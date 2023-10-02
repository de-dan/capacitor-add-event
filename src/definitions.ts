export interface CalendarPlugin {
  hasPermission(): Promise<boolean>;
  requestPermission(): Promise<void>;
  createEvent(options: CalendarEventOptions): Promise<any>;
}

export interface CalendarEventOptions {
  calendarId?: string;
  title?: string;
  location?: string;
  notes?: string;
  startDate?: Date;
  endDate?: Date;
  isAllDay?: boolean;
  url?: string;
}

import { WebPlugin } from '@capacitor/core';

import type { CalendarPlugin, CalendarEventOptions } from './definitions';

export class CalendarWeb extends WebPlugin implements CalendarPlugin {
  async createEvent(options: CalendarEventOptions): Promise<void> {
    console.log('create Event', options);
    throw new Error('Method not implemented.');
  }
}

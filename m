Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20631954D4
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0KHE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 27 Mar 2020 06:07:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59871 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgC0KHE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 06:07:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-12-E9zwsAk-MRCXmIL2Dbv0Jg-1; Fri, 27 Mar 2020 10:07:01 +0000
X-MC-Unique: E9zwsAk-MRCXmIL2Dbv0Jg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 27 Mar 2020 10:07:00 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 27 Mar 2020 10:07:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        "Shuah Khan" <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: RE: [PATCH 00/12 v2] ring-buffer/tracing: Remove disabling of ring
 buffer while reading trace file
Thread-Topic: [PATCH 00/12 v2] ring-buffer/tracing: Remove disabling of ring
 buffer while reading trace file
Thread-Index: AQHV/kYCQIwPxRMFlk+UdEERk+KYoKhTa8kQgAhKroCAAIuIsA==
Date:   Fri, 27 Mar 2020 10:07:00 +0000
Message-ID: <60977a309b5d46979a9a9bbd46c10932@AcuMS.aculab.com>
References: <20200319232219.446480829@goodmis.org>
        <2a7f96545945457cade216aa3c736bcc@AcuMS.aculab.com>
 <20200326214617.697634f3@oasis.local.home>
In-Reply-To: <20200326214617.697634f3@oasis.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Steven Rostedt
> Sent: 27 March 2020 01:46
> On Sat, 21 Mar 2020 19:13:51 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > From: Steven Rostedt
> > > Sent: 19 March 2020 23:22
> > ...
> > >
> > > This patch series attempts to satisfy that request, by creating a
> > > temporary buffer in each of the per cpu iterators to place the
> > > read event into, such that it can be passed to users without worrying
> > > about a writer to corrupt the event while it was being written out.
> > > It also uses the fact that the ring buffer is broken up into pages,
> > > where each page has its own timestamp that gets updated when a
> > > writer crosses over to it. By copying it to the temp buffer, and
> > > doing a "before and after" test of the time stamp with memory barriers,
> > > can allow the events to be saved.
> >
> > Does this mean the you will no longer be able to look at a snapshot
> > of the trace by running 'less trace' (and typically going to the end
> > to get info for all cpus).
> 
> I changed patch 9 to be this:
> 
> It adds an option "pause-on-trace" that when set, will bring back the
> old behavior of pausing recording to the ring buffer when the trace
> file is open.
> 
> If needed, I can add a kernel command line option and a Kconfig that
> makes this set to true by default.

Maybe a different file 'trace_no_pause' ?
Along with the one that lets you read the raw trace and get EOF.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


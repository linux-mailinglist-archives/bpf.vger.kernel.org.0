Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56F18E3DB
	for <lists+bpf@lfdr.de>; Sat, 21 Mar 2020 20:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCUTOE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 21 Mar 2020 15:14:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:51284 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgCUTOE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 21 Mar 2020 15:14:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-258-5dLg6k9dMdWiOUfVgdYHTg-1; Sat, 21 Mar 2020 19:13:59 +0000
X-MC-Unique: 5dLg6k9dMdWiOUfVgdYHTg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 21 Mar 2020 19:13:51 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 21 Mar 2020 19:13:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: RE: [PATCH 00/12 v2] ring-buffer/tracing: Remove disabling of ring
 buffer while reading trace file
Thread-Topic: [PATCH 00/12 v2] ring-buffer/tracing: Remove disabling of ring
 buffer while reading trace file
Thread-Index: AQHV/kYCQIwPxRMFlk+UdEERk+KYoKhTa8kQ
Date:   Sat, 21 Mar 2020 19:13:51 +0000
Message-ID: <2a7f96545945457cade216aa3c736bcc@AcuMS.aculab.com>
References: <20200319232219.446480829@goodmis.org>
In-Reply-To: <20200319232219.446480829@goodmis.org>
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
> Sent: 19 March 2020 23:22
...
> 
> This patch series attempts to satisfy that request, by creating a
> temporary buffer in each of the per cpu iterators to place the
> read event into, such that it can be passed to users without worrying
> about a writer to corrupt the event while it was being written out.
> It also uses the fact that the ring buffer is broken up into pages,
> where each page has its own timestamp that gets updated when a
> writer crosses over to it. By copying it to the temp buffer, and
> doing a "before and after" test of the time stamp with memory barriers,
> can allow the events to be saved.

Does this mean the you will no longer be able to look at a snapshot
of the trace by running 'less trace' (and typically going to the end
to get info for all cpus).

A lot of the time trace is being written far too fast for it to make
any sense to try to read it continuously.

Also, if BPF start using ftrace, no one will be able to use it for
'normal debugging' on such systems.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


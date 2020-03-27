Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB3519595F
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgC0O4O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 27 Mar 2020 10:56:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:38265 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727185AbgC0O4O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 10:56:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-170-SGnCHWRUOGKntCL40nF8vw-1; Fri, 27 Mar 2020 14:56:09 +0000
X-MC-Unique: SGnCHWRUOGKntCL40nF8vw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 27 Mar 2020 14:56:08 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 27 Mar 2020 14:56:08 +0000
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
Thread-Index: AQHV/kYCQIwPxRMFlk+UdEERk+KYoKhTa8kQgAhKroCAAIuIsIAAShAAgAAFRhA=
Date:   Fri, 27 Mar 2020 14:56:08 +0000
Message-ID: <c87eadc38d614b73a2c73f521fecb877@AcuMS.aculab.com>
References: <20200319232219.446480829@goodmis.org>
        <2a7f96545945457cade216aa3c736bcc@AcuMS.aculab.com>
        <20200326214617.697634f3@oasis.local.home>
        <60977a309b5d46979a9a9bbd46c10932@AcuMS.aculab.com>
 <20200327103046.08f06131@gandalf.local.home>
In-Reply-To: <20200327103046.08f06131@gandalf.local.home>
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
> Sent: 27 March 2020 14:31
..
> > Along with the one that lets you read the raw trace and get EOF.
> 
> Can you explain this more? I think we talked about this before, but I don't
> remember the details.

I was trying to use schedviz (on github from google).
It reads out the raw trace (for some scheduler events)
and then postprocesses it to generate to nice pictures.
However the shell script it uses for the captures has to run the
copies in the background, sleep a random time, and then kill all
the copies having hoped it has waited long enough - truly horrid.

There is also some confusion (IIRC between a header and your library
code) about the 'time-delta' on 'pad' entries.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


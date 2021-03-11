Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6F336EDD
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhCKJ3V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Mar 2021 04:29:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:38781 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232003AbhCKJ2u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Mar 2021 04:28:50 -0500
X-Greylist: delayed 84786 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Mar 2021 04:28:50 EST
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-232-BZvBvr3pMjOf4Z7qPKK-tw-1; Thu, 11 Mar 2021 09:28:47 +0000
X-MC-Unique: BZvBvr3pMjOf4Z7qPKK-tw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 11 Mar 2021 09:28:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 11 Mar 2021 09:28:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: The killing of ideal_nops[]
Thread-Topic: The killing of ideal_nops[]
Thread-Index: AQHXFcc39lSrY3Kgm0WONtWbUmlAY6p+hE6A
Date:   Thu, 11 Mar 2021 09:28:46 +0000
Message-ID: <3913a992a9384fe083a5f24e4ef86fdc@AcuMS.aculab.com>
References: <20210309120519.7c6bbb97@gandalf.local.home>
 <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
 <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
 <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
 <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net>
 <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net>
 <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net>
 <20210310091324.0c346d5f@oasis.local.home>
 <YEjWryS/9uB2y62O@hirez.programming.kicks-ass.net>
 <CAADnVQKMRWMuAJEJBPADactdKaGx4opg3y82m7fy59rRmA9Cog@mail.gmail.com>
 <YEjuArPJsSYDaYeI@hirez.programming.kicks-ass.net>
In-Reply-To: <YEjuArPJsSYDaYeI@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
...
> Below is the latest version which I just pushed out to my git tree so
> that the robots can have a go at it.

Why not delete the indirection table?
So you end up with:

> +#ifndef CONFIG_64BIT
> +
> +/*
> + * Generic 32bit nops from GAS:
> + *
> + * 1: nop
> + * 2: movl %esi,%esi
> + * 3: leal 0x00(%esi),%esi
> + * 4: leal 0x00(,%esi,1),%esi
> + * 5: leal %ds:0x00(,%esi,1),%esi
> + * 6: leal 0x00000000(%esi),%esi
> + * 7: leal 0x00000000(,%esi,1),%esi
> + * 8: leal %ds:0x00000000(,%esi,1),%esi
>   *
> - * *_NOP5_ATOMIC must be a single instruction.
> + * Except 5 and 8, which are DS prefixed 4 and 7 resp, where GAS would emit 2
> + * nop instructions.
>   */
> +#define BYTES_NOP1	0x90
> +#define BYTES_NOP2	0x89,0xf6
> +#define BYTES_NOP3	0x8d,0x76,0x00
> +#define BYTES_NOP4	0x8d,0x74,0x26,0x00
> +#define BYTES_NOP5	0x3e,BYTES_NOP4
> +#define BYTES_NOP6	0x8d,0xb6,0x00,0x00,0x00,0x00
> +#define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
> +#define BYTES_NOP8	0x3e,BYTES_NOP7

const unsigned char const x86_nops[8][8] = {
	{ BYTES_NOP1 },
	{ BYTES_NOP2 },
	{ BYTES_NOP3 },
	{ BYTES_NOP4 },
	{ BYTES_NOP5 },
	{ BYTES_NOP6 },
	{ BYTES_NOP7 },
	{ BYTES_NOP8 }
};

The rest of the patch may not need changing.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


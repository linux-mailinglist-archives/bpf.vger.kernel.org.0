Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21350277311
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgIXNtC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 24 Sep 2020 09:49:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54917 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728104AbgIXNtC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 09:49:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-275-AmPfbs06OlSmLB8NwMzbeQ-1; Thu, 24 Sep 2020 14:47:55 +0100
X-MC-Unique: AmPfbs06OlSmLB8NwMzbeQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Sep 2020 14:47:54 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Sep 2020 14:47:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'YiFei Zhu' <zhuyifei1999@gmail.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
CC:     YiFei Zhu <yifeifz2@illinois.edu>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: RE: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
Thread-Topic: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
Thread-Index: AQHWknD17ZW/yCPmvkCTJZb3HlQhMal3ymow
Date:   Thu, 24 Sep 2020 13:47:54 +0000
Message-ID: <7042ba3307b34ce3b95e5fede823514e@AcuMS.aculab.com>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <20bbc8ed4b9f2c83d0f67f37955eb2d789268525.1600951211.git.yifeifz2@illinois.edu>
In-Reply-To: <20bbc8ed4b9f2c83d0f67f37955eb2d789268525.1600951211.git.yifeifz2@illinois.edu>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu 
> Sent: 24 September 2020 13:44
> 
> Seccomp cache emulator needs to know all the architecture numbers
> that syscall_get_arch() could return for the kernel build in order
> to generate a cache for all of them.
> 
> The array is declared in header as static __maybe_unused const
> to maximize compiler optimiation opportunities such as loop
> unrolling.

I doubt the compiler will do what you want.
Looking at it, in most cases there are one or two entries.
I think only MIPS has three.

So a static inline function that contains a list of
conditionals will generate better code that any kind of
array lookup.
For x86-64 you end up with something like:

#ifdef CONFIG_IA32_EMULATION
	if (sd->arch == AUDIT_ARCH_I386) return xxx;
#endif
	return yyy;

Probably saves you having multiple arrays that need to be
kept carefully in step.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


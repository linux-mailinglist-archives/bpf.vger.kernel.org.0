Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175B5373630
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 10:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhEEIY7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 5 May 2021 04:24:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:39098 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229566AbhEEIY6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 5 May 2021 04:24:58 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-246-t31SIAGZMKGhnCVP98Zw3A-1; Wed, 05 May 2021 09:23:55 +0100
X-MC-Unique: t31SIAGZMKGhnCVP98Zw3A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 09:23:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 09:23:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Florian Weimer' <fweimer@redhat.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
CC:     Zack Weinberg <zackw@panix.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, Joseph Myers <joseph@codesourcery.com>
Subject: RE: [RFC v2] bpf.2: Use standard types and attributes
Thread-Topic: [RFC v2] bpf.2: Use standard types and attributes
Thread-Index: AQHXQR4JneAG95ru70e6btooWxCDq6rUiRug
Date:   Wed, 5 May 2021 08:23:55 +0000
Message-ID: <a17b3a3c7eff46829666d2b07adda0be@AcuMS.aculab.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
        <20210504110519.16097-1-alx.manpages@gmail.com>
        <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
        <YJFZHW2afbAMVOmE@kroah.com>    <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
        <YJFxArfp8wN3ILJb@kroah.com>
        <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
        <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
 <87r1imgu5g.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87r1imgu5g.fsf@oldenburg.str.redhat.com>
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

From: Florian Weimer
> Sent: 04 May 2021 20:46
> 
> * Alejandro Colomar:
> 
> > The thing is, in all of those threads, the only reasons to avoid
> > <stdint.h> types in the kernel (at least, the only explicitly
> > mentioned ones) are (a bit simplified, but this is the general idea of
> > those threads):
> >
> > * Possibly breaking something in such a big automated change.
> > * Namespace collision with userspace (the C standard allows defining
> >   uint32_t for nefarious purposes as long as you don't include
> >  <stdint.h>.   POSIX prohibits that, though)
> > * Uglier
> 
> __u64 can't be formatted with %llu on all architectures.  That's not
> true for uint64_t, where you have to use %lu on some architectures to
> avoid compiler warnings (and technically undefined behavior).  There are
> preprocessor macros to get the expected format specifiers, but they are
> clunky.  I don't know if the problem applies to uint32_t.  It does
> happen with size_t and ptrdiff_t on 32-bit targets (both vary between
> int and long).

uint32_t can be 'randomly' either int or long on typical 32bit architectures.
The correct way to print it is with eg "xxx %5.4" PRI_u32 " yyy".

Typed like ptrdiff_t and size_t exist because of things like the x86
segmented model. Pointers are 32bit (segment and offset), size_t is
(probably) 16 bit (nothing can be any bigger), but ptrdiff_t has to
be 32bit to contain [-65535 .. 65535].

Kernel code has used u8, u16 and u32 since well before the standards
body even thought about fixed width types (and well before Linux).
ISTR they were considered as the standard names, but rejected and the
current definitions approved.
They were probably too worried about code already using u32 for a
variable.
(Shame they never fixed math.h)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


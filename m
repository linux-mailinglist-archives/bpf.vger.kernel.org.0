Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7260B372D97
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhEDQJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 12:09:53 -0400
Received: from www62.your-server.de ([213.133.104.62]:60960 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhEDQJw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 12:09:52 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ldxbT-0002Ox-16; Tue, 04 May 2021 18:08:55 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ldxbS-0007mn-Pg; Tue, 04 May 2021 18:08:54 +0200
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Zack Weinberg <zackw@panix.com>,
        Joseph Myers <joseph@codesourcery.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com>
 <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b1583790-14ff-0999-77fb-d379c6b0170f@iogearbox.net>
Date:   Tue, 4 May 2021 18:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26160/Tue May  4 13:06:49 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/4/21 5:53 PM, Alejandro Colomar (man-pages) wrote:
> Hi Greg and Alexei,
> 
>> On Tue, May 04, 2021 at 07:12:01AM -0700, Alexei Starovoitov wrote:
>>> For the same reasons as explained earlier:
>>> Nacked-by: Alexei Starovoitov <ast@kernel.org>
> 
> Okay, I'll add that.
> 
> On 5/4/21 4:24 PM, Greg KH wrote:> I agree, the two are not the same type at all, this change should not be
>> accepted.
> 
> I get that in the kernel you don't use the standard fixed-width types (with some exceptions), probably not to mess with code that relies on <stdint.h> not being included (I hope there's not much code that relies on this in 2021, but who knows).
> 
> But, there is zero difference between these types, from the point of view of the compiler.  There's 100% compatibility between those types, and you're able to mix'n'match them.  See some example below.
> 
> Could you please explain why the documentation, which supposedly only documents the API and not the internal implementation, should not use standard naming conventions?  The standard is much easier to read for userspace programmers, which might ignore why the kernel does some things in some specific ways.
> 
> BTW, just to clarify, bpf.2 is just a small sample to get reviews; the original intention was to replace __uNN by uintNN_t in all of the manual pages.

But what /problem/ is this really solving? Why bother to change this /now/
after so many years?! I think this is causing more confusion than solving
anything, really. Moreover, what are you doing with all the __{le,be}{16,32,64}
types in uapi? Anyway, NAK for bpf.2 specifically, and the idea generally..

Best,
Daniel

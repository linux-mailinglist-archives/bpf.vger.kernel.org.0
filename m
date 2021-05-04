Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A9373006
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 20:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhEDSzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhEDSzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 14:55:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199AC061574;
        Tue,  4 May 2021 11:54:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l2so10524469wrm.9;
        Tue, 04 May 2021 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HxMXsLzGFWPlqcnxGJAcfYyhmw/u7Ltv81Kt77fU+Nk=;
        b=fA7KY7gp+sCW16alMT7Z3vAgBtQw9YAMnxSt6feaQyLIIN5rIIH3DWMxFvucXK39vV
         h6FjCUBQcFXo2vJ8OAQ9XMxNfcaaEkXNBRCymbRrgs58N/WzWU39g3YPkHRX/+t0BJaV
         S8Ysj4QFrnik0fzEhW2MmH9IdAuBkpiTq49rNfdcj/vAW5CjF4TwsvxFqX8NKPTrUspA
         /9SA6oKAwk9lKDaw9HBPXLz+C7VwO4lnuX5Q0QSyW4xR1H85szd8piJT7KsxW68LyRuT
         VYjbXAz36TcGPZsaY8yPybJCM/JQtlFR+M5nX9jHahu4lmCQM0cmIlmhzdk5dWrC6z5T
         XwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HxMXsLzGFWPlqcnxGJAcfYyhmw/u7Ltv81Kt77fU+Nk=;
        b=Mb/9HISt8yEeDFGMQenoPu7pU33SM0b2QBqV7+p/An8ceDxBHvpacYeKY/U1h4/pGT
         LNJ3Ss3GS0yoUzaex1zXsGU5+hCTpenkZzuefJ8/X6Bzy2c3rzOyxKaLBj+2/rfVquJR
         n/sCCEybYEPx1uP2hcW59ueFQ30lSWl+mtQ9vdyezonWMVx7/ZLpvpe6Q2Jym6a1V/l/
         5h54IG0lqgj9GgHGP+yxbfNZON1uKSGrniPTEJMRC/HO4CqfdiUfdK54LJV+VZJcO70C
         d+GGuAnRhYxO82w/xZNdmWZBODERy9IevNyPp83BHGPqgmji5bm/tqLg2kvHI9lEhMON
         khAQ==
X-Gm-Message-State: AOAM5305UtrO1WlDxR1p6VmhMRc/WClqUdusbbH8B0nokDsQ/3Co0Ca0
        5SXl4k4oKziB6KwsRKvGlzk=
X-Google-Smtp-Source: ABdhPJyr9Zc+yVazfOU4v9PmQblwpqV8RqeIwvsbaDL/Z8TPZjN1iEfmuearj6IrLpvwWWmlxTsZcg==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr35220529wrq.198.1620154453241;
        Tue, 04 May 2021 11:54:13 -0700 (PDT)
Received: from [192.168.0.237] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id j7sm3422098wmi.21.2021.05.04.11.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 11:54:12 -0700 (PDT)
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     Zack Weinberg <zackw@panix.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        David Laight <David.Laight@aculab.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com>
 <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
 <YJFxArfp8wN3ILJb@kroah.com>
 <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
Date:   Tue, 4 May 2021 20:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Greg, Daniel,

On 5/4/21 6:06 PM, Greg KH wrote:
 > There's a very old post from Linus where he describes the difference
 > between things like __u32 and uint32_t.  They are not the same, they
 > live in different namespaces, and worlds, and can not always be swapped
 > out for each other on all arches.>
 > Dig it up if you are curious, but for user/kernel apis you HAVE to use
 > the __uNN and can not use uintNN_t variants, so don't try to mix/match
 > them, it's good to just follow the kernel standard please.
I found these:

* [RFC] Splitting kernel headers and deprecating __KERNEL__ 
<https://lore.kernel.org/lkml/Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org/T/>

* coding style 
<https://lore.kernel.org/lkml/alpine.LFD.0.98.0706160840290.14121@woody.linux-foundation.org/>

* [patch] Small input fixes for 2.5.29 
<https://lore.kernel.org/lkml/Pine.LNX.4.33.0207301417190.2051-100000@penguin.transmeta.com/T/>

I already knew the first one, and now found the other two.  If there's 
any other thread that is relevant, I couldn't find it.

The thing is, in all of those threads, the only reasons to avoid 
<stdint.h> types in the kernel (at least, the only explicitly mentioned 
ones) are (a bit simplified, but this is the general idea of those threads):

* Possibly breaking something in such a big automated change.
* Namespace collision with userspace (the C standard allows defining 
uint32_t for nefarious purposes as long as you don't include <stdint.h>. 
  POSIX prohibits that, though)
* Uglier

But

* The manual pages only document the variable size and signedness by 
using either '__u32' or 'uint32_t'.  We state that the variable is an 
unsigned integer of exactly 32 bits; nothing more and nothing less.  It 
doesn't specify that those types are defined in <linux/bpf.h> (or 
whatever header a specific manual page uses).  In fact, in uint32_t(3) 
we clearly state the headers that shall provide the type.  In the end, 
the kernel will receive a 32 bit number.  I'm not exactly sure about 
what is wrong with this.  Is there any magic in the kernel/user 
interface beyond what the standard and the compiler define that I ignore?

* At that time (~2004), the C99 and POSIX.1-2001 standards were quite 
young, and it was likely to find code that defined uint32_t.  Currently, 
it is hard to find something that compiles without C99, and even if C99 
allows you to define uint32_t as long as you don't include <stdint.h>, 
it would be really stupid to do so.  And POSIX, which completely 
prohibits defining uint32_t, is also very present in Linux and other 
UNIX systems.  So we can probably guarantee that using <stdint.h> in the 
kernel wouldn't break anything.  But yet this isn't trying to do so. 
This is only about the manual pages.

I haven't read it in any of those threads, but suspect that the static 
analyzer used for the kernel might use extra information from the 
different 'u32'/'__u32' type names to do some extra checks.  Does it?

 > and can not always be swapped out for each other on all arches.

Really?  'uint32_t' is defined as "an unsigned integer type of a fixed 
width of exactly 32 bits".  How is that different from '[__]u32'? 
Aren't the kernel types guaranteed to be unsigned integers of exactly 32 
bits?  AFAICT, they are 100% binary compatible; and if not, it's 
probably a kernel bug.

Yes there are archs that don't provide 64 bit integers (I ignore if any 
of the archs supported by Linux does though), but if an arch doesn't 
provide 'uint64_t', it will neither be possible to have '__u64'.

[
        uintN_t
               Include: <stdint.h>.  Alternatively, <inttypes.h>.

               uint8_t, uint16_t, uint32_t, uint64_t

               An unsigned integer type of a fixed width  of  ex‐
               actly  N  bits, N being the value specified in its
               type name.  According to the C language  standard,
               they  shall  be  capable  of storing values in the
               range [0, UINTN_MAX], substituting N by the appro‐
               priate number.

               According   to   POSIX,   uint8_t,  uint16_t,  and
               uint32_t are required; uint64_t is  only  required
               in implementations that provide integer types with
               width 64; and all other types of this form are op‐
               tional.

] -- uint32_t(3)


 >
 > So consider this my:
 >
 > Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 >
 > as well.
Okay.

On 5/4/21 6:08 PM, Daniel Borkmann wrote:
 >
 > But what /problem/ is this really solving? Why bother to change this 
/now/
 > after so many years?! I think this is causing more confusion than solving
 > anything, really. Moreover, what are you doing with all the
 > __{le,be}{16,32,64}
 > types in uapi? Anyway, NAK for bpf.2 specifically, and the idea 
generally..
 >

I'm trying to clarify the manual pages as much as possible, by using 
standard conventions and similar structure all around the pages.  Not 
everyone understands kernel conventions.  Basically, Zack said very much 
what I had in mind with this patch.


Thanks for your reviews!

Regards,

Alex

--
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/

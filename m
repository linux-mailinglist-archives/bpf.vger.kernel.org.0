Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E71373133
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhEDUHx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 16:07:53 -0400
Received: from www62.your-server.de ([213.133.104.62]:49384 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhEDUHw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 16:07:52 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1le1Jk-0004mY-JI; Tue, 04 May 2021 22:06:52 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1le1Jk-000VNO-Aa; Tue, 04 May 2021 22:06:52 +0200
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Zack Weinberg <zackw@panix.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        David Laight <David.Laight@aculab.com>, davem@davemloft.net
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com>
 <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
 <YJFxArfp8wN3ILJb@kroah.com>
 <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
 <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8a184afe-14b7-ed15-eb6a-960ea05251d1@iogearbox.net>
Date:   Tue, 4 May 2021 22:06:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26160/Tue May  4 13:06:49 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/4/21 8:54 PM, Alejandro Colomar (man-pages) wrote:
> On 5/4/21 6:06 PM, Greg KH wrote:
>  > There's a very old post from Linus where he describes the difference
>  > between things like __u32 and uint32_t.  They are not the same, they
>  > live in different namespaces, and worlds, and can not always be swapped
>  > out for each other on all arches.>
>  > Dig it up if you are curious, but for user/kernel apis you HAVE to use
>  > the __uNN and can not use uintNN_t variants, so don't try to mix/match
>  > them, it's good to just follow the kernel standard please.
> I found these:
> 
> * [RFC] Splitting kernel headers and deprecating __KERNEL__ <https://lore.kernel.org/lkml/Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org/T/>
> 
> * coding style <https://lore.kernel.org/lkml/alpine.LFD.0.98.0706160840290.14121@woody.linux-foundation.org/>
> 
> * [patch] Small input fixes for 2.5.29 <https://lore.kernel.org/lkml/Pine.LNX.4.33.0207301417190.2051-100000@penguin.transmeta.com/T/>
> 
> I already knew the first one, and now found the other two.  If there's any other thread that is relevant, I couldn't find it.
> 
> The thing is, in all of those threads, the only reasons to avoid <stdint.h> types in the kernel (at least, the only explicitly mentioned ones) are (a bit simplified, but this is the general idea of those threads):
> 
> * Possibly breaking something in such a big automated change.
> * Namespace collision with userspace (the C standard allows defining uint32_t for nefarious purposes as long as you don't include <stdint.h>.  POSIX prohibits that, though)
> * Uglier
> 
> But
> 
> * The manual pages only document the variable size and signedness by using either '__u32' or 'uint32_t'.  We state that the variable is an unsigned integer of exactly 32 bits; nothing more and nothing less.  It doesn't specify that those types are defined in <linux/bpf.h> (or whatever header a specific manual page uses).  In fact, in uint32_t(3) we clearly state the headers that shall provide the type.  In the end, the kernel will receive a 32 bit number.  I'm not exactly sure about what is wrong with this.  Is there any magic in the kernel/user interface beyond what the standard and the compiler define that I ignore?
> 
> * At that time (~2004), the C99 and POSIX.1-2001 standards were quite young, and it was likely to find code that defined uint32_t.  Currently, it is hard to find something that compiles without C99, and even if C99 allows you to define uint32_t as long as you don't include <stdint.h>, it would be really stupid to do so.  And POSIX, which completely prohibits defining uint32_t, is also very present in Linux and other UNIX systems.  So we can probably guarantee that using <stdint.h> in the kernel wouldn't break anything.  But yet this isn't trying to do so. This is only about the manual pages.
> 
> I haven't read it in any of those threads, but suspect that the static analyzer used for the kernel might use extra information from the different 'u32'/'__u32' type names to do some extra checks.  Does it?
> 
>  > and can not always be swapped out for each other on all arches.
> 
> Really?  'uint32_t' is defined as "an unsigned integer type of a fixed width of exactly 32 bits".  How is that different from '[__]u32'? Aren't the kernel types guaranteed to be unsigned integers of exactly 32 bits?  AFAICT, they are 100% binary compatible; and if not, it's probably a kernel bug.
> 
> Yes there are archs that don't provide 64 bit integers (I ignore if any of the archs supported by Linux does though), but if an arch doesn't provide 'uint64_t', it will neither be possible to have '__u64'.
> 
> [
>         uintN_t
>                Include: <stdint.h>.  Alternatively, <inttypes.h>.
> 
>                uint8_t, uint16_t, uint32_t, uint64_t
> 
>                An unsigned integer type of a fixed width  of  ex‐
>                actly  N  bits, N being the value specified in its
>                type name.  According to the C language  standard,
>                they  shall  be  capable  of storing values in the
>                range [0, UINTN_MAX], substituting N by the appro‐
>                priate number.
> 
>                According   to   POSIX,   uint8_t,  uint16_t,  and
>                uint32_t are required; uint64_t is  only  required
>                in implementations that provide integer types with
>                width 64; and all other types of this form are op‐
>                tional.
> 
> ] -- uint32_t(3)
> 
> 
>  >
>  > So consider this my:
>  >
>  > Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  >
>  > as well.
> Okay.
> 
> On 5/4/21 6:08 PM, Daniel Borkmann wrote:
>  >
>  > But what /problem/ is this really solving? Why bother to change this /now/
>  > after so many years?! I think this is causing more confusion than solving
>  > anything, really. Moreover, what are you doing with all the
>  > __{le,be}{16,32,64}
>  > types in uapi? Anyway, NAK for bpf.2 specifically, and the idea generally..
> 
> I'm trying to clarify the manual pages as much as possible, by using standard conventions and similar structure all around the pages.  Not everyone understands kernel conventions.  Basically, Zack said very much what I had in mind with this patch.

But then are you also converting, for example, __{le,be}{16,32,64} to plain
uint{16,32,64}_t in the man pages and thus removing contextual information
(or inventing new equivalent types)?

What about other types exposed to user space like __sum16, __wsum, or __poll_t
when they are part of a man page, etc?

Thanks,
Daniel

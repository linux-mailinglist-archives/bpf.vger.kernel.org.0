Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD9241925
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgHKJy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgHKJy2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 05:54:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFEDC06174A
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 02:54:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so12427941ejb.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VqCnW+F9+9tJsYe5g6wAFuo+N9f5pgyFC+LnHJbK6JA=;
        b=KpVb+TiTRQRZ9NqSvgemtajbZBh0Lg3bA+PXANtMrhsr033FP224M6KLxJvnx2zFvu
         0YdDmAjDUr3AjDH4lEDgvieSkJczLu5mVJPNBJbvgBk8UHE0r3VzbD72W0bLpPi1ZawB
         AR8DkrFcBlnubrEBdm0HKr3ceLNHrHASQilgY5uMm9I16V2N/Fl6TasIccC6LcovQRzM
         q5iDf4Q1FB3ZD2u9UgGwg6z4bELpIkuUeOiulc5lCS/RDIfHbrHE6lBekxcapBSCx7vS
         PQd4mK4FZdEUILpON2YhywA1wYN24HmSru3TcDcotNKCjRVKdYD9x++HFRMVWxtOUIgZ
         UwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VqCnW+F9+9tJsYe5g6wAFuo+N9f5pgyFC+LnHJbK6JA=;
        b=HKrMECz9mKnlc9gBs5huY4FwQ2YZ2eEakVv0LruHKtxUS3QOjcQhrD4JpbdIcao2i8
         CSqvHoVUs0pMj3dgJ3cMFDNvmdz0JO4OHlLHvoUN0oq4YxZjMIBzEqj+rjVJC7j5lz5/
         OSt3Ayyg3g6Dd7opyzSuqJtYJ7DHM+pGXHDz1Zi8M4S17bGbVsljGqEJ6WNz4k9cK+Z9
         Z4qkP4ka5WJmhFYGhYAsTG94hmjOe2ggG/EtXpym3Z33A0puM+qGSAob3SInLu/XrW7t
         sA0iHaGMWK1KzELQ0e4ywIfn+83WBX+yMuZkFKevU0w/XVPRYyL2ZhJIEhXXhSn4bmWt
         KmZQ==
X-Gm-Message-State: AOAM530tXOScxiMx0bSVE4usm/lMKWqV1oULM1w20q1fNyoNuGoAOYtY
        mGngzHD1PnPhFaHvJztDvjmjQw==
X-Google-Smtp-Source: ABdhPJwu98KH0FtMQ1TqlP3Pk0dHM+v5fY4JyprMrtrqpSELdVfSXmYInsSOTDecwNtmcLiJcxg4cA==
X-Received: by 2002:a17:906:4696:: with SMTP id a22mr25356279ejr.154.1597139666817;
        Tue, 11 Aug 2020 02:54:26 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m6sm14564948ejq.85.2020.08.11.02.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 02:54:25 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:54:10 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakov Petrina <jakov.petrina@sartura.hr>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
Message-ID: <20200811095410.GA2786584@myrica>
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica>
 <CAEf4BzbC-abnqD4802=uT+u3+gwMK3q+yXjWAriuDTj2hMJ9Yw@mail.gmail.com>
 <CAADnVQ+fQG38XKR+V33qTR-G-7wm398CMCafbuQrTQ9CHfE2mA@mail.gmail.com>
 <20200810125753.GA1643799@myrica>
 <CAEf4BzaQcxAArJyLqxxw8sV507DyWzU44HJ3oaUAjX4UEu_KaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaQcxAArJyLqxxw8sV507DyWzU44HJ3oaUAjX4UEu_KaA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 11:54:54PM -0700, Andrii Nakryiko wrote:
> On Mon, Aug 10, 2020 at 5:58 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > On Fri, Aug 07, 2020 at 01:54:02PM -0700, Alexei Starovoitov wrote:
> > [...]
> > > > > > ```
> > > > > > typedef __Poly8_t poly8x16_t[16];
> > > > > > ```
> > > > > >
> > > > > > AFAICT these are ARM NEON intrinsic definitions which are GCC-specific. We
> > > > > > have opted to comment out this line as there was no additional `poly8x16_t`
> > > > > > usage in the header file.
> > > > >
> > > > > It looks like this "__Poly8_t" type is internal to GCC (provided in
> > > > > arm_neon.h) and clang has its own internals. I managed to reproduce this
> > > > > with an arm64 allyesconfig kernel (+BTF), but don't know how to fix it at
> > > > > the moment. Maybe libbpf should generate defines to translate these
> > > > > intrinsics between clang and gcc? Not very elegant. I'll take another
> > > > > look next week.
> > > >
> > > > libbpf is already blacklisting __builtin_va_list for GCC, so we can
> > > > just add __Poly8_t to the list. See [0].
> > > > Are there any other types like that? If you guys can provide me this,
> > > > I'll gladly update libbpf to take those compiler-provided
> > > > types/built-ins into account.
> > >
> > > Shouldn't __Int8x16_t and friends cause the same trouble?
> >
> > I think these do get properly defined, for example in my vmlinux.h:
> >
> >         typedef signed char int8x16_t[16];
> >
> > From a cursory reading of the "ARM C Language Extension" doc (IHI0053D) it
> > looks like only the poly8/16/64/128_t types are unspecified. It's safe to
> > drop them as long as they're not used in structs or function parameters,
> > but I sent a more generic fix [1] that copies the clang defintions. When
> > building the kernel with clang, the polyX_t types do get typedefs.
> >
> > Thanks,
> > Jean
> >
> 
> Hi Jean,
> 
> Would you be so kind to build some simple C repro code that uses those
> polyX_t types? Ideally built by both GCC and Clang. And then run
> `pahole -J` on them to get .BTF into them as well. If you can share
> those two with me, I'd love to look at how DWARF and BTF look like.
> 
> I'm, unfortunately, having trouble making something like that to
> cross-compile on my x86-64 machine, I've spent a bunch of time already
> on this unsuccessfully and it's really frustrating at this point. If
> you have an ARM system (or cross-compilation set up properly), it
> shouldn't take much time for you, hopefully. Just make sure that those
> polyX_t types do make it into DWARF, so, e.g., use them with static
> variable or something, e.g.,:
> 
> int main() {
>     static poly8_t a = 12;
>     return a + 10;
> }
> 
> Or something along those lines. Thanks!

No problem, I put the source and clang+gcc binaries in a tarball here:
https://jpbrucker.net/tmp/test-poly-neon.tar.bz2

These contain all the base types defined by arm_neon.h (minus the new
bfloat16, which I don't think matters at the moment)

Thanks,
Jean

> 
> > [1] https://lore.kernel.org/bpf/20200810122835.2309026-1-jean-philippe@linaro.org/
> >
> > > There is a bunch more in gcc/config/arm/arm-simd-builtin-types.def.
> > > May be there is a way to detect compiler builtin types by pattern matching
> > > their dwarf/btf shape and skip them automatically?
> > > The simplest, of course, is to only add a few that caused this known
> > > trouble to blocklist.

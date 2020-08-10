Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8C240644
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgHJM6L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgHJM6L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 08:58:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0030DC061756
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 05:58:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d6so9260025ejr.5
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ktYDUhHF31x1lc93JUbH3XBmZYcyUsbaMWCvBNCVtoE=;
        b=K6WSJN4GZJba5rv0vSTbH3ebXDdy2pHIC+xpROeTa8+eFMTDe5GCOHDAjLvtpIb8FG
         RmKC3vbZ3P3jwxdMRViC45Y3IQgiFq/ZFBA7y13cQLOn0azZLc5AE3iL7ZxmUGmsNWJK
         yhjcxub4ALC0pkkiUNsnZBem90q9RkZOjdGiXu3UzpvQotWYGzHSQEjG5On4THY/F6cQ
         uMyJ2c7bZNdPPa3mygJSFkr/fqlGnef1LFtH2q0JFxRRh6WF4P4G4v92tgoTbAwT3QEt
         6o4EKzxopm/0ulnvRGuHBXP8cMWukpOy5nFy6WDR8jOYXZ1oQWrGeGkoqY9pH5uIRc0D
         BW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktYDUhHF31x1lc93JUbH3XBmZYcyUsbaMWCvBNCVtoE=;
        b=XsFGq1N3YJukM4k1YzX6G2vuO2KeYdFIUGCq1O2w/AyAG7+4dzWWmTCxfJvzvXQzx7
         SHcel7j4DWP4ULQBWp7AIMQS1x8V1um2dnnnJG9T1qnce9qiXNwMxbivMrBDeD0PwhDU
         d7PHXI3oWXKvH4QndpGfPIfUJ7Y31E8aLvMuiEHY2ET2Lr0JbVwqzKAWvvjFjDCyexMn
         Es4iaiRbjyO22Uu+3Cv6Hm3UKqHNn/1zaSEA1SKwKlTuB6TBzXuo4A0QvJEV2QDFGXm8
         JoGsPU8RS5HaLobDWyU9X8KvYV3GzBWi0RKIzqp8JZTW9Y9XHLJ8VTyfSkfryOoyrOpu
         ijjg==
X-Gm-Message-State: AOAM533lBstjF+LwJP6QBcxZpJcb4nsmyK5DshrFyDGsP0WLfN6gtNHU
        T8mJMnpz0pPQR8YMjMjfrwWa/w==
X-Google-Smtp-Source: ABdhPJyucekWrU9iMusbTuqJaAo9iP/moBF4vkF4gUspwUfvVMHD6cDTj8PT/Ozigga7hG01g04FOA==
X-Received: by 2002:a17:906:15c7:: with SMTP id l7mr21244447ejd.208.1597064289674;
        Mon, 10 Aug 2020 05:58:09 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t3sm12356370edq.26.2020.08.10.05.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:58:08 -0700 (PDT)
Date:   Mon, 10 Aug 2020 14:57:53 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jakov Petrina <jakov.petrina@sartura.hr>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
Message-ID: <20200810125753.GA1643799@myrica>
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica>
 <CAEf4BzbC-abnqD4802=uT+u3+gwMK3q+yXjWAriuDTj2hMJ9Yw@mail.gmail.com>
 <CAADnVQ+fQG38XKR+V33qTR-G-7wm398CMCafbuQrTQ9CHfE2mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+fQG38XKR+V33qTR-G-7wm398CMCafbuQrTQ9CHfE2mA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 07, 2020 at 01:54:02PM -0700, Alexei Starovoitov wrote:
[...]
> > > > ```
> > > > typedef __Poly8_t poly8x16_t[16];
> > > > ```
> > > >
> > > > AFAICT these are ARM NEON intrinsic definitions which are GCC-specific. We
> > > > have opted to comment out this line as there was no additional `poly8x16_t`
> > > > usage in the header file.
> > >
> > > It looks like this "__Poly8_t" type is internal to GCC (provided in
> > > arm_neon.h) and clang has its own internals. I managed to reproduce this
> > > with an arm64 allyesconfig kernel (+BTF), but don't know how to fix it at
> > > the moment. Maybe libbpf should generate defines to translate these
> > > intrinsics between clang and gcc? Not very elegant. I'll take another
> > > look next week.
> >
> > libbpf is already blacklisting __builtin_va_list for GCC, so we can
> > just add __Poly8_t to the list. See [0].
> > Are there any other types like that? If you guys can provide me this,
> > I'll gladly update libbpf to take those compiler-provided
> > types/built-ins into account.
> 
> Shouldn't __Int8x16_t and friends cause the same trouble?

I think these do get properly defined, for example in my vmlinux.h:

	typedef signed char int8x16_t[16];

From a cursory reading of the "ARM C Language Extension" doc (IHI0053D) it
looks like only the poly8/16/64/128_t types are unspecified. It's safe to
drop them as long as they're not used in structs or function parameters,
but I sent a more generic fix [1] that copies the clang defintions. When
building the kernel with clang, the polyX_t types do get typedefs.

Thanks,
Jean

[1] https://lore.kernel.org/bpf/20200810122835.2309026-1-jean-philippe@linaro.org/

> There is a bunch more in gcc/config/arm/arm-simd-builtin-types.def.
> May be there is a way to detect compiler builtin types by pattern matching
> their dwarf/btf shape and skip them automatically?
> The simplest, of course, is to only add a few that caused this known
> trouble to blocklist.

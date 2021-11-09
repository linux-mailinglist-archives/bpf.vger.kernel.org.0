Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4644B214
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 18:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhKIRnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 12:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbhKIRnh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 12:43:37 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E95C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 09:40:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t21so22237747plr.6
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ls2c2SdVgxBHoHh8i6MJER7qk62nRwWJBvEeEOoLFtg=;
        b=Zh3ngkMaulORxbhzjGKRbXKaNu6CSNjgrZWUqi8JjjZlvOn2eyUXScD2Ixi2Etzcys
         7m8YBa9lVP2rXYWPX9E9hpEm5QnbHQmNJZKLUFvTFTPVUX6uyaQ83nkqNtA1616cPj+y
         ELYJfSZc7wB6ktc5L58+58M4xsYQqJxinmkz7u15yrgCLWd1X4+qAyrY4j58Qh4JY6mV
         G2DoUS1FCQV0qTWPvBeqCIb9nPE1zIqwMXdDBw13mVUXh3gwm+imxdvgSaEBNYkkJ6wr
         65jv/gqTMDLNmZ8Fuq4SyGi9Dkf+UWIjrTQpNWaSTYhIjvnO3c5RO79Pb5Cx8sLeZFju
         2VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ls2c2SdVgxBHoHh8i6MJER7qk62nRwWJBvEeEOoLFtg=;
        b=Y/NhtSwAR1JEM5jaR6pz1pY1yPNZ/jvbKw5zfHccRSnX4m/MyIFl6qMaOfP+uwuGxb
         qsIiBndWvaYPuaCqLXnoU2TB6mI0gXgmo7GFzYl6Uvc0u2OACMPbU1rNDJdrKxC1hbft
         FV+U2BDrzMSXV71uKD0BjBsltrzcEP6ztyaW/5j0nigoE+E5jy5UvkJoEeRsOzm88NcE
         SSjjqN1VWIS8AtYgByoySmRYYVYLLoaTVg8IzFwQVkis/SybNh4Q3SjvdLhpbw1JIpZI
         Ea5LrNzB/HXt2+ykC3TP1AZao6iYP3fFlyR0qB40st1ISULXNghN3NmSnNFrMF4QYH35
         h3Tw==
X-Gm-Message-State: AOAM532uznhmSdmYKTAi/OVW/z9IU9TTt2UlouT70t3OYF02epKNtP/T
        ajwi7pUlHnCeDVeT6PSgkj968pb6hrc=
X-Google-Smtp-Source: ABdhPJy3fdjr5cTxMTQq+azDn2swEG0J1D+9UAagG/qyfv0UcDTmfdOPpFOyiiwiQOXFoKAIu2+3Gw==
X-Received: by 2002:a17:90b:390f:: with SMTP id ob15mr9321625pjb.32.1636479650367;
        Tue, 09 Nov 2021 09:40:50 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:f8f1])
        by smtp.gmail.com with ESMTPSA id f11sm15587004pga.11.2021.11.09.09.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 09:40:49 -0800 (PST)
Date:   Tue, 9 Nov 2021 09:40:48 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 06/11] libbpf: ensure btf_dump__new() and
 btf_dump_opts are future-proof
Message-ID: <20211109174048.dzovealltpr3rwcq@ast-mbp.dhcp.thefacebook.com>
References: <20211108061316.203217-1-andrii@kernel.org>
 <20211108061316.203217-7-andrii@kernel.org>
 <20211109033839.yf3v7xcbqco6fddp@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzYoF3233To8EQb3qHA_NASN+1c5Xw3WJAyMq9CBZ9N2Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYoF3233To8EQb3qHA_NASN+1c5Xw3WJAyMq9CBZ9N2Lg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 09, 2021 at 07:37:48AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 8, 2021 at 7:38 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Nov 07, 2021 at 10:13:11PM -0800, Andrii Nakryiko wrote:
> > > +#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(               \
> > > +     __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) +      \
> > > +     __builtin_types_compatible_p(typeof(a4),                              \
> > > +                                  void(void *, const char *, va_list)),    \
> > > +     btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),\
> > > +     btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
> >
> > why '+' in the above? The return type of __builtin_types_compatible_p() is bool.
> > What is bool + bool ?
> > It suppose to be logical 'OR', right?
> 
> __builtin_types_compatible_p() is defined as returning 0 or 1 (not
> true/false). And __builtin_choose_expr() is also defined as comparing
> first argument against 0, not as true/false. But in practice it
> doesn't matter because bool is converted to 0 or 1 in arithmetic
> operations. So I can switch to || with no effect. Let me know if you
> still prefer logical || and I'll change.
> 
> But yes to your last question, it's logical OR.

Interesting. Looking at LLVM code it does indeed returns 'int'.
At least typeof(_builtin_types_compatible_p(..)) seems to be 'int'.

At the same type LLVM tests are using this macro:
#define check_same_type(type1, type2) __builtin_types_compatible_p(type1, type2) && __builtin_types_compatible_p(type1 *, type2 *)

While kernel has this macro:
#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))

Guessing that extra typeof() may resolve the difference between fn and &fn ?
Not sure why LLVM took that approach.

Anyway it will be removed once we hit 1.0, so no need to dig too deep.
I think changing + to || is still worth doing.

> >
> > Maybe checking for ops type would be more robust ?
> 
> opts can be NULL. At which point it's actually only compatible with
> void *. 

Assuming that fn pointer in btf_dump__new_deprecated() will never be NULL?

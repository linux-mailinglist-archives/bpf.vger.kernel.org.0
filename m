Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E1144B086
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbhKIPks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 10:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbhKIPkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 10:40:47 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB79C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 07:38:01 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y3so54013031ybf.2
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 07:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFZkzfYeosP/fZ8N92cEkDO3wEAvFRLCxzDBJopOfIg=;
        b=l8F9g9+gcmUTpyxMGe3D6Mab/93RHRKwPdLj06i+BRr1UmqJ5S4hS2Th9zRW6a4N9f
         LS6i5tyqZjdl17pctbFrqxH/28nH64cVV6iwsM3YM6u9a/fJKP5zAXAdMUjtnuwyYx7/
         g/DTu4kv95knU1/H2rxqu7ELXwEZAM4rYaLNjg4YDQgNqxHtcTwzPv8JVlhG/XVJUFEg
         ztGbTj4ZKq7DrZ2u5D8nqh1qWig9bxv9bRbHHZAPovdjtoFjfAO53tB0biIgbzW1yPq4
         YrgcWmmdDYXvSKfBJ/h+/HBqsKiLc5ECigpnVeuZL6Qcjb/X6MpNnib3Z3I6T7gQV58Q
         xkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFZkzfYeosP/fZ8N92cEkDO3wEAvFRLCxzDBJopOfIg=;
        b=oQOrSMcsxcKkNpVNbPIonLC/zauDTH6lUV4aSeq5A4Q1kRbMnSfQLHpgwwp8Q/IJnp
         3dT8x4P59h3qH10WPejqGRy/k71Cc7w+kQUoN8rKbYshft6HGIykzLBIdQX4OUIJ+xnW
         6+zNR/bB3ShjppEEkKaLNEZDjM3SqDCipM/Tn3O6XCzaiTvuCpNHMRM1/eSQSbOFFSk6
         tu0IPamNAVLWORfztCKkewZpNXn5VtzrbnWHdANDopDptL3MNh5q5p/V2GZIOVZ0ri00
         DqpbHTzphFWA3DxgGERv9nP5DPIxHOTKt0t3NUk3iuoTmfKrCS3/ol89XBOy6wcVKhRf
         5QYg==
X-Gm-Message-State: AOAM532LOthAx3407fMIO90t45Z2obCJtfISYXSBnHQ5fTllBYLMWktQ
        HnYchtIMOIrkHe286naXyRNJ8Uw6O5p5ZlJEjeo=
X-Google-Smtp-Source: ABdhPJw+x40Tj3TWTvCpgYQlmqYFQjU+1aPCagxxkRL2kiww7AcpePWS8KY4X2lOAQG6lmUDIjVUtPRiPY6BCZWmL7Y=
X-Received: by 2002:a25:d187:: with SMTP id i129mr9111406ybg.2.1636472280881;
 Tue, 09 Nov 2021 07:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20211108061316.203217-1-andrii@kernel.org> <20211108061316.203217-7-andrii@kernel.org>
 <20211109033839.yf3v7xcbqco6fddp@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211109033839.yf3v7xcbqco6fddp@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 07:37:48 -0800
Message-ID: <CAEf4BzYoF3233To8EQb3qHA_NASN+1c5Xw3WJAyMq9CBZ9N2Lg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/11] libbpf: ensure btf_dump__new() and
 btf_dump_opts are future-proof
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 8, 2021 at 7:38 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 07, 2021 at 10:13:11PM -0800, Andrii Nakryiko wrote:
> > +#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(               \
> > +     __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) +      \
> > +     __builtin_types_compatible_p(typeof(a4),                              \
> > +                                  void(void *, const char *, va_list)),    \
> > +     btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),\
> > +     btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
>
> why '+' in the above? The return type of __builtin_types_compatible_p() is bool.
> What is bool + bool ?
> It suppose to be logical 'OR', right?

__builtin_types_compatible_p() is defined as returning 0 or 1 (not
true/false). And __builtin_choose_expr() is also defined as comparing
first argument against 0, not as true/false. But in practice it
doesn't matter because bool is converted to 0 or 1 in arithmetic
operations. So I can switch to || with no effect. Let me know if you
still prefer logical || and I'll change.

But yes to your last question, it's logical OR.

>
> Maybe checking for ops type would be more robust ?

opts can be NULL. At which point it's actually only compatible with
void *. The only non-null args are btf (same for both variants, so no
go) or callback. So I have to check the callback. From my
experimentations with various possible invocations (locally, not in
any test), this check is quite robust. I need to check two types:
pointer to func and func itself (C allows that, turns out; I learned
it from [0]).

  [0] https://github.com/cilium/ebpf/issues/214

> Like:
> #define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(                  \
>         __builtin_types_compatible_p(typeof(a4), const struct btf_dump_opts*), \
>         btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4),        \
>         btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4))

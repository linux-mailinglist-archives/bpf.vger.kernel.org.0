Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859AE28903F
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 19:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbgJIRtn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 13:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbgJIRtn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 13:49:43 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E64C0613D2;
        Fri,  9 Oct 2020 10:49:43 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h6so7838009ybi.11;
        Fri, 09 Oct 2020 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4lWGWnNw2wi1xQY4e9Ca3eY9UD1wATiPi7XvwhFFcc=;
        b=MtQitgo5iP4KYmKAFw2N40KFLffGI1WGtFJu12UHkiJRgKzoEZLYqpZArFzP9c8YQp
         RgEYX+isKkgnautdUcXaByH+ADiF97MryzJCQg4HdgKebLlF0WImaWPkwxZo2zSs+NH8
         cdYYFmQUGxy7uEB+KEMWkLeQj24VM790F1DR+RnHtPEwyZTpfPqNrjaBJcx2Uvi24BFY
         pND5V6Ii+B8yOnEkephHMTQzo2UAe5Z1KeUQjFpOOYnQ9pehlB/9ZeiVVDygpZ5f4iZV
         t0u3zQOQF2biMhx5o8FaQw+PHgmatJdSxj4DFgJApQmBxmZfy/SewWIux2Tu08v2cpf2
         zavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4lWGWnNw2wi1xQY4e9Ca3eY9UD1wATiPi7XvwhFFcc=;
        b=e1IyABIdS5tO3TgKgZhyzkbQhuzcpq6Z7Qj50v+iWiFKfaMkkqAWz793hdh4GZxyxK
         EI4CYkYAG8Cx2CoKZamiVE1RKCO0d4IjWlZ4YiJyfew0EXbCpu+fUnV84D1r/RG7xONt
         Kyw8fnddKtP3PJbOnusAG+iV7zPBjpaGJGXn/3oW4blGvNndQHmcisCysGJJcsZWXbwt
         hzw3jUZX9UvbtCcD4R2T2upyk8ukvyzWf8dAFsshZkkr6Do94BGqlTwbXUxYrkKD4hRC
         5kpdLyPxFkqyARnRIuwGuO4UEPLJ2b5ZFOWLJ1L89Q3C+KEhMDZ5m9DUR8cGSad7Xt72
         dctg==
X-Gm-Message-State: AOAM531g59GyZ89w4escEzLkW3EdaGwpG6vo4UVsFv8QbcrdR5niT3Wo
        oMV0muC8NkmBCRBG8aR1pDo4dFdnU++BgdN4jLeOq0AHLe4=
X-Google-Smtp-Source: ABdhPJw0GmySY6VreT2ss5teV6ZvdGP8Cpa8QmqTweRm5BG0ahHmbAqnMcnmTLzhGjyvRLdy80NjF8a8NcRd2jEkqPY=
X-Received: by 2002:a25:cbc4:: with SMTP id b187mr19832909ybg.260.1602265782344;
 Fri, 09 Oct 2020 10:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201008234000.740660-1-andrii@kernel.org> <20201008234000.740660-2-andrii@kernel.org>
 <20201009145343.GA322246@kernel.org>
In-Reply-To: <20201009145343.GA322246@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Oct 2020 10:49:31 -0700
Message-ID: <CAEf4BzZCH7UTqqRqatBwOD9aCyR3r-JUb8v9_BwtddhSnZh37w@mail.gmail.com>
Subject: Re: [PATCH v2 dwarves 1/8] btf_loader: use libbpf to load BTF
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 7:53 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Thu, Oct 08, 2020 at 04:39:53PM -0700, Andrii Nakryiko escreveu:
> > From: Andrii Nakryiko <andriin@fb.com>
> >
> > Switch BTF loading to completely use libbpf's own struct btf and related APIs.
> > BTF encoding is still happening with pahole's own code, so these two code
> > paths are not sharing anything now. String fetching is happening based on
> > whether btfe->strings were set to non-NULL pointer by btf_encoder.
>
> While testing this one I noticed a problem, but it isn't caused by this
> particular patch:
>
> [acme@five pahole]$ cp ~/git/build/v5.9-rc6+/net/ipv4/tcp_ipv4.o .
> [acme@five pahole]$ readelf -SW tcp_ipv4.o | grep BTF
> [acme@five pahole]$ pahole -J tcp_ipv4.o
> [acme@five pahole]$ readelf -SW tcp_ipv4.o | grep BTF
>   [105] .BTF              PROGBITS        0000000000000000 0fbb3c 03f697 00      0   0  1
> [acme@five pahole]$ ./btfdiff tcp_ipv4.o
> --- /tmp/btfdiff.dwarf.BDAvGi   2020-10-09 11:41:45.161509391 -0300
> +++ /tmp/btfdiff.btf.p81icw     2020-10-09 11:41:45.177509720 -0300
> @@ -4056,7 +4056,7 @@ struct tcp_congestion_ops {
>         u32                        (*min_tso_segs)(struct sock *); /*    96     8 */
>         u32                        (*sndbuf_expand)(struct sock *); /*   104     8 */
>         void                       (*cong_control)(struct sock *, const struct rate_sample  *); /*   112     8 */
> -       size_t                     (*get_info)(struct sock *, u32, int *, union tcp_cc_info *); /*   120     8 */
> +       size_t                     (*get_info)(struct sock *, u32, int *, struct tcp_cc_info *); /*   120     8 */

It's a bug in btf_loader.c. When loading BTF_KIND_FWD, we always
assume it's struct forward reference. But I checked, generated BTF
does have the valid info (kind_flag), so it should be easy to fix,
I'll send a fix.

The reason we don't see it in vmlinux is because after dedup that
forward reference is resolved to a full type, which is clearly union.


[...]

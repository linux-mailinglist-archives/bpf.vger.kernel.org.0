Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F85204EE
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiEITKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 15:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbiEITJ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 15:09:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB11F63B7
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 12:06:01 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id s14so9937487ild.6
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NVamDgzsMQ8P8AffLdYNfPeR/7JugVTHxCVmTl+1F0=;
        b=GDR7Y9KFHomqbD2X+iHl9ZcJlw1niCHT32DwCIUKFE95vuVKcYh5moN06V5kmlpcAE
         NUpyjzDVHgoFhMNr3fZZYvWcA5L2hMinJEaT58L6vo0jZiUzZU1j3XAT9AETzEi59HB+
         Xi0s49I96/CftJGUivIMtcJNvEaHBc9uzJtTdOsz6McLDh+mjGTdi0j/5y9Sx6C9zaB/
         MicNgdWmNuILH92UHav8a96+MYA0bljVOkdH5CiggrLi6TSYiCS0CyEdp37gbisUzRGE
         9e/g0AfexaOK6mVg7aiyKQMtCBoHNLwVuvEv9UzeU6+2V1HFxDjABOnkeo/rJ5Gpw1o1
         SkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NVamDgzsMQ8P8AffLdYNfPeR/7JugVTHxCVmTl+1F0=;
        b=LaTYGdZ41NYg63vi1kZuI1q15//Qvi6hBv4/gErZSQ0+llLh/cA+kLEelNNUs6rJjK
         ENpUCWPjos5cp+9VbZoaK+M3H7WAQoe4N2qSlogZUI+2nmBbwARDwt/c2OPsyXsq+lcU
         BzXsSEyauaiiETjFtkRdcyojwoQjE74JsV/6RuIBIt3piVlNsUDj/2VaexY6G6l2MVdM
         cBqx+iiq35XvYHDKw4bRKa5GTYEyUI2kyuR9pwqh45RFLwvVsyRyRLt+xKvHc0qo9LH5
         89AlqbRFTW81EBHslk4GL6HCWuJ+33Z7N6RNyN12Y2DHXwvXXPnnmXqrDb4DtUK6pCsP
         G4eg==
X-Gm-Message-State: AOAM5307TzBOYBgfOJFXCvxoPAX/o1vkjWhyMoDiadeGnuHePDIjIsjd
        JepdCN00lFOebh1yUeiq7OK3LiPpGI/mUF96jc0uUsSzZiQ=
X-Google-Smtp-Source: ABdhPJyEn1RXKm9kTJQKtxKvwlpYDhcsE3yRk9qp+vdTmfeUlxcDBcDV2fyOWx2tEhSVD65HydLFBm1KTvjHVZ5iRc8=
X-Received: by 2002:a05:6e02:11a3:b0:2cf:90f9:30e0 with SMTP id
 3-20020a056e0211a300b002cf90f930e0mr4072403ilj.252.1652123161078; Mon, 09 May
 2022 12:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220508032117.2783209-1-kuifeng@fb.com> <20220508032117.2783209-5-kuifeng@fb.com>
In-Reply-To: <20220508032117.2783209-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 12:05:50 -0700
Message-ID: <CAEf4BzZ06F3vwhHHixpCyXHpnhCx2mwhT6GS5S5FfvBp_bsV9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/5] libbpf: Assign cookies to links in libbpf.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 7, 2022 at 8:21 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Add a cookie field to the attributes of bpf_link_create().
> Add bpf_program__attach_trace_opts() to attach a cookie to a link.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  tools/lib/bpf/bpf.c      |  8 ++++++++
>  tools/lib/bpf/bpf.h      |  3 +++
>  tools/lib/bpf/libbpf.c   | 32 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 12 ++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 56 insertions(+)
>

I have a gripe with better code reuse, but that's internal change so
we can do it in a follow up.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 73a5192defb3..df9be47d67bc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11440,6 +11440,38 @@ struct bpf_link *bpf_program__attach_trace(const struct bpf_program *prog)
>         return bpf_program__attach_btf_id(prog);
>  }
>
> +struct bpf_link *bpf_program__attach_trace_opts(const struct bpf_program *prog,
> +                                               const struct bpf_trace_opts *opts)

there is bpf_program__attach_btf_id() that does all of this except for
the cookie. It would be nicer to extend bpf_program__attach_btf_id(),
which won't break any API because it's an internal helper, add
optional bpf_trace_opts to it and then just redirect
bpf_program__attach_trace_opts() to bpf_program__attach_btf_id and
update all the existing callers with just passing NULL for opts.

We can do that as a follow up, given your patch set seems to be pretty
much ready to be landed.

> +{
> +       char errmsg[STRERR_BUFSIZE];
> +       struct bpf_link *link;
> +       int prog_fd, pfd;
> +       LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> +

[...]

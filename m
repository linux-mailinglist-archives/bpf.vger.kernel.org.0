Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1813E495662
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 23:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiATWgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 17:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiATWgb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 17:36:31 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572F0C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 14:36:31 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id r3so5787361iln.3
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7adu7dN88Vusyzi1sNGDDRvR0QIajbQCubqEGHDyfWA=;
        b=g5o4ExWD/p6GMjiwXOlFvSOkm8G9Jms2eRAbXgSuaVHbboqP24b3Gv2D/nwyrypvCx
         pDSQp1qNnRRdOts2jdTEX+wvIRKk4hGpsSj6ca28PVc90KlD/VmTRUnwYgWaQFaq0iN+
         SD4U3EjoYBM2sdY7iAp0mIFD7LEu7tGWXpXZeOenpog1fO2DmySKWit4BM7Ur5a2w/qd
         FOdUZxNHP2Pm+zq6QiVZ8QICnhLZxr6JqQ0httEUdaKEAs3sxcL5uWSJcKa1TNc5t2eq
         9y9MwcO92VkNKc3bkGLwAV0XRJ/LniUBxLzhijJn3EiGdQ7E8+MmSuhgGFUui6yE9PdC
         aUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7adu7dN88Vusyzi1sNGDDRvR0QIajbQCubqEGHDyfWA=;
        b=2CG9jqIlOnz7UIqU7R5XbVHZFr09E4CL6ksHgdenQD1/p5bstarZUc4OW39xkeB1VF
         w3uGZptBqVWGoKLx+mOt55gmSEuHnY4j8Bkvjsw2B3Mc1Pi3skY00+XTTgaCItdVG0lR
         XnoWl8e5H6HPB0Oi7gShhAfBSIZ7xfF8udyLoTYe84gc6E4a7Ps6gioQZ2eHuVmBijMH
         tBAaGx4KJ1i0gfCvfqpocbbfazBSSECJxQMwBV64je7p9Y0biF4I5mhWGZimCgdd48Zh
         SC0Uet/49IFeDgV6ePqe29VPraIdqls68Ii2TFYrmwsH2cF+v660upRkdc6PI9NFVgA9
         vPpQ==
X-Gm-Message-State: AOAM531VQYmFH7nsY52x9dM1yFb4p0ftUfzG0PG98vSjJC9npna/7n71
        8pCRMBVMODKDW/tov/1xtI9juKhwt/FTEVqsFOU=
X-Google-Smtp-Source: ABdhPJxGhJD2ylYg8VlSZGCuQNN/fbVLsKs1ofDmQnzVTBkUndIaqa9IasRcbx6qmx8+duFqm9B4pl2Sf6DriuS2szs=
X-Received: by 2002:a05:6e02:1748:: with SMTP id y8mr593182ill.305.1642718190618;
 Thu, 20 Jan 2022 14:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20220120164932.2798544-1-memxor@gmail.com>
In-Reply-To: <20220120164932.2798544-1-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 14:36:19 -0800
Message-ID: <CAEf4Bza64qGLc7D0pes2X53xRRTdEeHQ4=+wFK4sSwWHZxFA2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Do not fail build if CONFIG_NF_CONNTRACK=m/n
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 8:50 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Some users have complained that selftests fail to build when
> CONFIG_NF_CONNTRACK=m. It would be useful to allow building as long as
> it is set to module or built-in, even though in case of building as
> module, user would need to load it before running the selftest. Note
> that this also allows building selftest when CONFIG_NF_CONNTRACK is
> disabled.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 6f131c993c0b..d048d355a69f 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -17,18 +17,27 @@ int test_enonet_netns_id = 0;
>  int test_enoent_lookup = 0;
>  int test_eafnosupport = 0;
>
> +struct nf_conn;
> +
> +struct bpf_ct_opts___local {
> +       s32 netns_id;
> +       s32 error;
> +       u8 l4proto;
> +       u8 reserved[3];
> +};

I've added __attribute__((preserve_access_index)) to make it
CO-RE-relocatable, just in case. Applied to bpf-next.

> +
>  struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tuple *, u32,
> -                                 struct bpf_ct_opts *, u32) __ksym;
> +                                 struct bpf_ct_opts___local *, u32) __ksym;
>  struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *, struct bpf_sock_tuple *, u32,
> -                                 struct bpf_ct_opts *, u32) __ksym;
> +                                 struct bpf_ct_opts___local *, u32) __ksym;
>  void bpf_ct_release(struct nf_conn *) __ksym;
>
>  static __always_inline void
>  nf_ct_test(struct nf_conn *(*func)(void *, struct bpf_sock_tuple *, u32,
> -                                  struct bpf_ct_opts *, u32),
> +                                  struct bpf_ct_opts___local *, u32),
>            void *ctx)
>  {
> -       struct bpf_ct_opts opts_def = { .l4proto = IPPROTO_TCP, .netns_id = -1 };
> +       struct bpf_ct_opts___local opts_def = { .l4proto = IPPROTO_TCP, .netns_id = -1 };
>         struct bpf_sock_tuple bpf_tuple;
>         struct nf_conn *ct;
>
> --
> 2.34.1
>

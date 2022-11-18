Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA29F62FEA1
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 21:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKRURk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 15:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKRURk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 15:17:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452B31348
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 12:17:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kt23so15684369ejc.7
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 12:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq6V+87kbCrJAtcTBQfAoqSo7/NL0LRgPerUxO+ubmc=;
        b=Ae0z0UyswiJXCncvDp+o0kCHUwj7cVGE3y6NUit0hnkcTUIzY3Ea4qZccsAQDf9BH8
         Xps/VyI1O6Es07oRYHSQzut5NYHLfN/CZR+j9eXwnGU7MK74PKX0912YKIRBy9hW1QKO
         cmL0+YS+fMQeignNW0i+6QmvNeK0JiI19pNW5PtJEv1gkuWG1qT1i/BsoGhsr84wTB/q
         UG/ESLmP/pV76UiYspJXHGz3oiSfwHP0NAUoPdtH6doE0+kNOuN0yBtu08Lj5PYa4f73
         glc/zlpU4uET0lmK0NHXYZGOZtx35tgyasRo78z1zOjc2LjTTG6mkxqrSoY/94F2hZGq
         kaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iq6V+87kbCrJAtcTBQfAoqSo7/NL0LRgPerUxO+ubmc=;
        b=EN+B4K9XB+wAtFey6I+j/a7oqvDN0GMMuYXRKvNcmcgs66CaZEuK1KJ4Xobdag9AIE
         MReQf3s5XNZ/QATVQvJISJ33dOCVTQV01GxGvSTUokcVuo+G+IEnPJGvsWo8p7Nsq/sc
         Ugo1vUmtD+HD4JsOtmGBZIMb6bWzM7Wc/OrA3Tp/7jrll/14dwINa/SQqtFvyRSxDvhq
         i7rFnij5sxPY3IiJbQfkp4uV1kJuZMkV0Gs7IFm40BRRVN6YSYZtwdAwnEcQ08fKM+Oa
         sE+hAjmJ6CN+Mz85+006rElBnhh38ZUoKTfSbm78iYqFmywBJne6HmUZhNxVZBZZ15cP
         gZ2Q==
X-Gm-Message-State: ANoB5plI/pmzAVtfwCWEO0edM7U8ykI2oNNdzy/nna7JMnx33kw0O33V
        UbKbyxqAGw/wFvSjio7hQD/xhj2BjjfmRD40Ai2vOEOpkO0=
X-Google-Smtp-Source: AA0mqf7+u8PijULBgnzXYP7RwzewsRV9awHNsmHBH9NoeDtoGx00EvsNbAW//LMT8BzqpMDj3AUTwA/VCNzQqo3zbU0=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr6899996eje.94.1668802656810; Fri, 18 Nov
 2022 12:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20221118185938.2139616-1-memxor@gmail.com> <20221118185938.2139616-2-memxor@gmail.com>
In-Reply-To: <20221118185938.2139616-2-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Nov 2022 12:17:25 -0800
Message-ID: <CAADnVQLKwfr_UiLEc-5exQGd3saeuYUX2j8BHzAtBgZovUpCGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Disallow calling bpf_obj_new_impl on
 bpf_mem_alloc_init failure
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 11:00 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Instead of checking bpf_global_ma_set at runtime on each allocation
> inside bpf_obj_new_impl, simply disallow calling the kfunc in case
> bpf_global_ma initialization failed during program verification.
>
> The error generated when bpf_global_ma initialization fails:
> ...
> 21: (18) r1 = 0x7                     ; R1_w=7
> 23: (b7) r2 = 0                       ; R2_w=0
> 24: (85) call bpf_obj_new_impl#36585
> bpf_global_ma initialization failed, can't call bpf_obj_new_impl
> calling kernel function bpf_obj_new_impl is not allowed
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/helpers.c  |  2 --
>  kernel/bpf/verifier.c | 13 ++++++++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 212e791d7452..bc02f55adc1f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1760,8 +1760,6 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>         u64 size = local_type_id__k;
>         void *p;
>
> -       if (unlikely(!bpf_global_ma_set))
> -               return NULL;
>         p = bpf_mem_alloc(&bpf_global_ma, size);
>         if (!p)
>                 return NULL;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 195d24316750..f04bee7934a8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8746,6 +8746,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>         return 0;
>  }
>
> +static bool is_kfunc_disabled(struct bpf_verifier_env *env, const struct btf *btf, u32 func_id)
> +{
> +       if (btf != btf_vmlinux)
> +               return false;
> +       if (!bpf_global_ma_set && func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
> +               verbose(env, "bpf_global_ma initialization failed, can't call bpf_obj_new_impl\n");
> +               return true;
> +       }
> +       return false;
> +}
> +

This is all just unnecessary code bloat for the case
that cannot happen.

When you do:
meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl]
just add
if (!bpf_global_ma_set)
 return -ENOMEM;

No need for verbose(). The users will never hit it.

Also please get rid of special_kfunc_set and
and btf_id_set_contains(&special_kfunc_set, meta.func_id)
That additional check is unnecessary as well.
special_kfunc_list is enough.
I'm going to apply patch 2 to make CI green.

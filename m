Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A04631767
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 00:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKTXnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 18:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKTXnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 18:43:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A601A383
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 15:43:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z20so12548603edc.13
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 15:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/FWLrgcT6R84kYmvprv422DCsf3M/pLi2LZjDeMIu3c=;
        b=pyhYBWl/z49zwTy8+0RkkmH+egLnvE5zopJWCifBHivasmOZYbBKdCaoNOSpAM/qN6
         VAt2T4RkuhFUY226pDbHV5aAcc+CUvA0aOL+0RBVUPMKXROaUUDBj5k/eE7ixgTBItry
         19It5mF6aw6nmfX0Sycx5k4zvJas7JBjMqWmZ2WetukmiWIsmbGsGxFmvAv6aSJO3B2a
         zUzXxK7vVJWr1qV2iL2d/SBlC6nIKgglY2wZu2WWoMjJ9mBgEErjTyWPv/U0H37PAoI3
         KPLbg4zrDI1xjJZTVlkAznjcAe7u4ebmnBfxja50XWDSzQUwGAGKJa2QonzhObtZCk53
         eYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FWLrgcT6R84kYmvprv422DCsf3M/pLi2LZjDeMIu3c=;
        b=KN/MAu6LjBqVwvZq/Epdy4PgyLUDOoPfuxlqGqPuWNsC0YrFpTKYzYJQB7yQsgvAke
         AT9HI//6K1ZervOKGkgwsR03vuF11Cpk2QI0l0fgUKK2wkuzRvuka7l4iRbN5+xhRvay
         BSwpKgFo2lhwvV3iZ0/XA/ye1q48hsjMXqv2LZfwDspwaY1+g9/RqAzKMkuyuBQSX2to
         i58u6Abtbwu6HXpn4ZRLGbPly5Ylsn4gSg2d4bQnnS6rqyBWcCSE3d6KwfLng5RWkSTV
         7GoMqwCsYHG1HeHihj1n4EZ1P7h3wGlqGCf7gu8LhzKhzRAOo9W6WQXj02vVngRa+8mm
         dLtg==
X-Gm-Message-State: ANoB5pkZhzzbdTVDRi6I6ZBO3FMnZ3l6sa7I5adZzto7fB8Y8jdgIzXE
        oEmo2hzSvzAJ+Xi4C+29MNZ9lA3yiytIumYlyIk=
X-Google-Smtp-Source: AA0mqf6N5mUiwImewlt/h//P6NKZbQMZVxuVRXnTL3ghZXVJQpYdRyCh4t4qgd9/JhHGlR5sD5A44cPiv3YqxQlhFmk=
X-Received: by 2002:aa7:da0f:0:b0:469:a437:ddf with SMTP id
 r15-20020aa7da0f000000b00469a4370ddfmr1196445eds.421.1668987809495; Sun, 20
 Nov 2022 15:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20221120212610.2361700-1-memxor@gmail.com>
In-Reply-To: <20221120212610.2361700-1-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 20 Nov 2022 15:43:18 -0800
Message-ID: <CAADnVQ+wv6TgftYJs7tiVW+ekwbUv4u2+tdKMk24vFnoF8m6aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Disallow bpf_obj_new_impl call when
 bpf_mem_alloc_init fails
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

On Sun, Nov 20, 2022 at 1:26 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> In the unlikely event that bpf_global_ma is not correctly initialized,
> instead of checking the boolean everytime bpf_obj_new_impl is called,
> simply check it while loading the program and return an error if
> bpf_global_ma_set is false.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/helpers.c  | 2 --
>  kernel/bpf/verifier.c | 6 ++++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 89a95f3d854c..3d4edd314450 100644
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
> index 5bc9d84d7924..ea36107deee0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8878,6 +8878,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                                 struct btf *ret_btf;
>                                 u32 ret_btf_id;
>
> +                               /* Unlikely, but fail the kfunc call if bpf_global_ma
> +                                * is not initialized.
> +                                */
> +                               if (!bpf_global_ma_set)
> +                                       return -ENOMEM;

I removed the comment and added unlikely().
Comments should describe things that are not obvious from C code.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80763B449
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 22:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiK1VgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 16:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiK1VgR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 16:36:17 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214A2FFE3
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:36:16 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vp12so27945388ejc.8
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B6Yh5uB2E3jk/xJKf0RnuPHFjQdSNj1oPpHY0ixDIQk=;
        b=NED2cc77LR1RGheDIX+iPuj6yifkHGtKkJJyC99VwfKa3pagG2uLA6S1KwKjyFi6DU
         xMc+t4zmsMdyF22NDCxMeJyrsNv/9NW/EV32P4Z70Br5qQB/cf9VJAhDOfxGRomkGDAs
         GBfGK17YZVmqLUCC6+HZlqnsOax7oj8EnvZCYtM05ntxTr7LWma2a7wJ78HXDfz2KYY6
         nYWE3spgxWfZNrBdE5/ne6plInE4rlfb7JpNAgh9P0pgCxVLK/g/aJEAYcdhrJJ73upI
         O9qKtlQwac1A3jBFAMLfRJ29hiJUC6tOEQrAL+twrfoLwdzuy8EDt0hMXPw2ySa5gNek
         pwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6Yh5uB2E3jk/xJKf0RnuPHFjQdSNj1oPpHY0ixDIQk=;
        b=p69Ed+5SGkHEz9BIzSTds9p3kGfdw5FBR6VgDxAX+w4cEkukIY35oli4gFf7a1Gxkm
         1yFogcFoXRT7Qz91H8nYLliPhMNALG8FRwMHUYP+oAu/7ULZU+oXCDuyYXf17uF6mOnI
         la9L5WKiJcHVBr9HU+nRA331PyKT0MAIdlfIQVWh/RBPwfbTNQZjq0dvhUY8FkKvekIk
         Mj4NJSPYQ6EovPyFYghmm8fEvFYgwV6LaFgGWcmeDa7bwQOVY0dYcyyuKTgPzbRfhx8c
         He0cNzGpj6dgRURZDxOumSomPtPOSshJkkIt0nByauhknC1IGMQFpo/w+oFdaydONDVS
         cvBg==
X-Gm-Message-State: ANoB5pmd5Iiu114Sd/PDYcC8sn9+KaQukvzDx2jPgQqO4ODUXxBkKx4z
        t5pwJNUGa/Aw1CCkZOV2K1IprKwOqIhSTYZ6fqk=
X-Google-Smtp-Source: AA0mqf7kzyvu9n0g6miAILm3FUWmihmimKUGUubbZx+AaktbRWpMhEQAMaeaWywM1IM7di37WK0z21MFwLVqvBRAcSU=
X-Received: by 2002:a17:906:cd10:b0:7bc:571f:88be with SMTP id
 oz16-20020a170906cd1000b007bc571f88bemr4715438ejb.502.1669671374901; Mon, 28
 Nov 2022 13:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-3-jolsa@kernel.org>
In-Reply-To: <20221128132915.141211-3-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 28 Nov 2022 13:36:03 -0800
Message-ID: <CAADnVQLD0s07y=K1cEisnwFDgFEVw0egbLhx-PzVHTDQ9SOmdg@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Mon, Nov 28, 2022 at 5:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpf_vma_build_id_parse function to retrieve build id from
> passed vma object and making it available as bpf kfunc.
>
> We can't use build_id_parse directly as kfunc, because we would
> not have control over the build id buffer size provided by user.
>
> Instead we are adding new bpf_vma_build_id_parse function with
> 'build_id__sz' argument that instructs verifier to check for the
> available space in build_id buffer.
>
> This way we check that there's always available memory space
> behind build_id pointer. We also check that the build_id__sz is
> at least BUILD_ID_SIZE_MAX so we can place any buildid in.
>
> The bpf_vma_build_id_parse kfunc is marked as KF_TRUSTED_ARGS,
> so it can be only called with trusted vma objects. These are
> currently provided only by find_vma callback function and
> task_vma iterator program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h      |  4 ++++
>  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c6aa6912ea16..359c8fe11779 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2839,4 +2839,8 @@ static inline bool type_is_alloc(u32 type)
>         return type & MEM_ALLOC;
>  }
>
> +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> +                          unsigned char *build_id,
> +                          size_t build_id__sz);
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..7340de74531a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -23,6 +23,7 @@
>  #include <linux/sort.h>
>  #include <linux/key.h>
>  #include <linux/verification.h>
> +#include <linux/buildid.h>
>
>  #include <net/bpf_sk_storage.h>
>
> @@ -1383,6 +1384,36 @@ static int __init bpf_key_sig_kfuncs_init(void)
>  late_initcall(bpf_key_sig_kfuncs_init);
>  #endif /* CONFIG_KEYS */
>
> +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> +                          unsigned char *build_id,
> +                          size_t build_id__sz)
> +{
> +       __u32 size;
> +       int err;
> +
> +       if (build_id__sz < BUILD_ID_SIZE_MAX)
> +               return -EINVAL;
> +
> +       err = build_id_parse(vma, build_id, &size);
> +       return err ?: (int) size;

if err is positive the caller won't be able
to distinguish it vs size.

> +}
> +
> +BTF_SET8_START(tracing_btf_ids)
> +BTF_ID_FLAGS(func, bpf_vma_build_id_parse, KF_TRUSTED_ARGS)
> +BTF_SET8_END(tracing_btf_ids)
> +
> +static const struct btf_kfunc_id_set tracing_kfunc_set = {
> +       .owner = THIS_MODULE,
> +       .set   = &tracing_btf_ids,
> +};
> +
> +static int __init kfunc_tracing_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
> +}
> +
> +late_initcall(kfunc_tracing_init);

Its own btf_id set and its own late_initcall just for one kfunc?
Please reduce this boilerplate code.
Move it to kernel/bpf/helpers.c ?

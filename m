Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C0F56C51F
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 02:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiGHXRY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbiGHXRX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 19:17:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59E6193D4
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 16:17:22 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x22so73736qkf.13
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 16:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEpqZ3mGcZFuGVY/60/YxsPdqVYz+C2jqWw/2774RQI=;
        b=Ixk4vk0BF/h3tA1u84YeWwn1BK/PukzP5AJ63goagamizvEgvX3cL01n9W0BElB1+y
         HaJLmIDDCV40Cf/m52APuQbKDLS9n/5xwy8Msru0FwNLmQ6imK8dhqxLJTSARGkiX3mv
         SbDgV2chJm8yzQTBFuqyyrNEeigjfcgduAOAE9l+zUQruizU1A9IbOhzVw3lLBh3ml35
         v6mKnw+LblTOU/sPwal5CZ97vME50rcXYSo3+p+IVR3aYGs174qzYy5jt/WsbmwSB8pA
         LE3TvIllf5hbbFhIuYf7wmhzY9oZMhFCRZ8eDc+q746PIrdMKYNkNKBkb029hXp8VH94
         VcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEpqZ3mGcZFuGVY/60/YxsPdqVYz+C2jqWw/2774RQI=;
        b=HhsxFdN3u3QA56p1yOhLtmpJpq2Qc+e4Zg2mlrpsnoXL7avqKaej//Zw9tr3n8vBSQ
         zUEgsKXADSqHABR2ooDhlBk6tALe6Hi0KK99vXgSKt1s3W79ntzN+Jm8rC+KcspLKAkp
         tUSGN9WNKAyIlCSokdhKjmX+hDfVKCL1+ShjnD7iH5WybW46u5sG/ABYr4glcysCF9YR
         qYZCfaBp4bPKXpHviOFfRNjPiHoyQo86APnditJc2LkWh1rqD3T7giCTj9Led5/qNVlZ
         N4uYVib43MJn7gzcAOa2YfIFUWTUp8cwwdLz+sS9MdgDfe06IEF5//VL5XO9d7IYiRmG
         D04A==
X-Gm-Message-State: AJIora8FlK/6TNL9XDIYdSKTlq2FhxRDwXSM72zGT7v9DBK+WiZNlF7W
        jPa/xyllwdWtS8RQj2xKXW37GjGd9YDNxXqe5dzPkA==
X-Google-Smtp-Source: AGRyM1tIPWcFlePAGHQYyXwBHQcoLJlC18/o7LXhR7c818g4fm/vLhfnI+CRDiqq2xs2srtXUKMmTFlKWv1M7V8cZ+w=
X-Received: by 2002:a05:620a:f0e:b0:6b5:48f6:91da with SMTP id
 v14-20020a05620a0f0e00b006b548f691damr3951482qkl.446.1657322241720; Fri, 08
 Jul 2022 16:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com> <1657113391-5624-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1657113391-5624-2-git-send-email-alan.maguire@oracle.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 8 Jul 2022 16:17:10 -0700
Message-ID: <CA+khW7h80NeCvUneKw1Sscpqt6xHhfV-pA8R_ygEBNharXnRSA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: add a ksym BPF iterator
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alan,

On Wed, Jul 6, 2022 at 6:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> add a "ksym" iterator which provides access to a "struct kallsym_iter"
> for each symbol.  Intent is to support more flexible symbol parsing
> as discussed in [1].
>
> [1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/kallsyms.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
[...]
> +
> +static struct bpf_iter_reg ksym_iter_reg_info = {
> +       .target                 = "ksym",
> +       .ctx_arg_info_size      = 1,
> +       .ctx_arg_info           = {
> +               { offsetof(struct bpf_iter__ksym, ksym),
> +                 PTR_TO_BTF_ID_OR_NULL },
> +       },
> +       .seq_info               = &ksym_iter_seq_info,
> +};
> +

Can we add allow resched here?

 .feature = BPF_ITER_RESCHED,

I think this will improve the responsiveness of the kernel when iterating ksyms.

Thanks,
Hao

> +BTF_ID_LIST(btf_ksym_iter_id)
> +BTF_ID(struct, kallsym_iter)
> +
> +static int __init bpf_ksym_iter_register(void)
> +{
> +       int ret;
> +
> +       ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
> +       ret = bpf_iter_reg_target(&ksym_iter_reg_info);
> +       if (ret)
> +               pr_warn("Warning: could not register bpf ksym iterator: %d\n", ret);
> +       return ret;
> +}
> +
> +late_initcall(bpf_ksym_iter_register);
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
>  static inline int kallsyms_for_perf(void)
>  {
>  #ifdef CONFIG_PERF_EVENTS
> --
> 1.8.3.1
>

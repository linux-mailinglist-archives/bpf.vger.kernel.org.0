Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8662874E
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 18:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiKNRlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 12:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiKNRk7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 12:40:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7C727FDC
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:40:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l11so18421142edb.4
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAivLqhxJZ24k7WV5dto1B/2djZpcDpI6oOhB6ak8n4=;
        b=dBj0lZdPaKQMJMLHwCLbQbzqZ6MNl1WnlTpNAD1iisH+h3YHAcEveRQDgCWi3Sd53X
         UiePSdRzsphlld36z1SbvWdL8Aoz6PbUsCBICxlBae3BAv16C3hYmilsn0pFXyXoK2I4
         yGqmjLo94fpKjzjyogQS77yaD3H1CGT61bP1xjjYP3w58LVXsckLd1kAy1BUyG/rieyE
         pWI6MEe2ss23FwdYj4Yd2/Qo1bXO/jWPZvyiKgARthHKaGB+hpxvZNdjLUmrEgW7G1fa
         BzwOFBkMRxn69kNPan2gqdvqZB7+LcuNqVT9cFfdvQPu0XyJVyVVwxTqqNYbzyL8i95A
         fokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAivLqhxJZ24k7WV5dto1B/2djZpcDpI6oOhB6ak8n4=;
        b=P4IpYRO/T6Spompr9nSGihKclx0FRpeeaPEJfVnMJ34oUthQJobEJ+TM9xQUk8g9yI
         VdRCkhNU0p3SjIx4rSvT86qppZC9VK0nEZr0MpumeuIHqdFqYKiz4bVMFv3Qe7j0iqo9
         jePD9/LTf83f5ZWVqAkjwheVujigH1fmzlZL5tZQn2bHvB9Bm8anql9ZkMff+Wcc+vzq
         Y6MQEYap5L6EaekXq0xd8YcZK9FsQ8mnilOYV7Ni8qpONX6P5VqgS4tuzVIEZV86SKkQ
         WwU2tRt7LulJct7XywoV1vHkHWMWp50g24Xz53wZnKneEuLz9es3h0BTOWfR0KtHwSU+
         rgVg==
X-Gm-Message-State: ANoB5pm2WL2E0bBpHDSTbKvYmeYMn2cbRCW33hD3L4ZSg6bG4FxqallD
        n6HdDj6/O2k+7EURSyRU3I9JN6LbFZoDfKFxOrfd/30/kiY=
X-Google-Smtp-Source: AA0mqf6mXa4YsbzVYhQI+ynO4TAA3DmvE3azzAEuUIogptzv7PO16NVsN9CXUadAvlSZ+sqaH+3Qsd7p6DvNufB/i90=
X-Received: by 2002:a05:6402:1598:b0:458:fbd9:e3b1 with SMTP id
 c24-20020a056402159800b00458fbd9e3b1mr11929060edv.6.1668447656598; Mon, 14
 Nov 2022 09:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20221111143341.508022-1-jolsa@kernel.org> <20221111143341.508022-2-jolsa@kernel.org>
In-Reply-To: <20221111143341.508022-2-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Nov 2022 09:40:44 -0800
Message-ID: <CAADnVQ+TFa=LSpJoCkosu-a4g89Ve90zgcAJ=ij2YV3x1Zq_ig@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
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

On Fri, Nov 11, 2022 at 6:33 AM Jiri Olsa <jolsa@kernel.org> wrote:
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
> This way  we check that there's  always available memory space
> behind build_id pointer. We also check that the build_id__sz is
> at least BUILD_ID_SIZE_MAX so we can place any buildid in.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h  |  5 +++++
>  kernel/bpf/helpers.c | 16 ++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 798aec816970..5e7c4c50da8e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2779,4 +2779,9 @@ struct bpf_key {
>         bool has_ref;
>  };
>  #endif /* CONFIG_KEYS */
> +
> +extern int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> +                                 unsigned char *build_id,
> +                                 size_t build_id__sz);
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 283f55bbeb70..af7a30dafff3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -19,6 +19,7 @@
>  #include <linux/proc_ns.h>
>  #include <linux/security.h>
>  #include <linux/btf_ids.h>
> +#include <linux/buildid.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -1706,10 +1707,25 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>         }
>  }
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
> +}

And you'll allow any tracing prog to call it like this?
Feels obviously unsafe unless I'm missing something big here.
See the amount of safety checks that
stack_map_get_build_id_offset() does.
Why can we get away without them here?

The use case is not clear to me as well.
Do you alwasy expect to call this kfunc from bpf_find_vma callback ?


> +
>  BTF_SET8_START(tracing_btf_ids)
>  #ifdef CONFIG_KEXEC_CORE
>  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
> +BTF_ID_FLAGS(func, bpf_vma_build_id_parse)
>  BTF_SET8_END(tracing_btf_ids)
>
>  static const struct btf_kfunc_id_set tracing_kfunc_set = {
> --
> 2.38.1
>

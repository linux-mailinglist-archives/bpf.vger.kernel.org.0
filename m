Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D05BE9B5
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiITPJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiITPJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 11:09:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D620EE36
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 08:09:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 29so4327913edv.2
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rf8fWZMvIxnpYeMtamKheZb+00lmFUaOudJyDdWv6+Y=;
        b=eHBKUhhiTE8brUiuG5nIwNPaviuy6fYSpYajJoCLpJ80QAqf1GzZJEVDvQj6O/q1Fy
         Oc5/Vzh9IE8YZSus+ntF0yMZC7ql0TT32r2+3p3IW61czEgdF1F7rHKLGd+itfyoVoo3
         IiGhPQhUwj6G+t3x0c+5ir+p6bTUl0imogHO/KS3dNTZbfMIJX5jnV5O5dWuZ4ciDySK
         +9D1aVQBesRq6cv8WlO/RLXOh0abPDOLp0C2ikD9RpdSkIEnU+6zSgAaX0g9rnGGRxnt
         9Vi44qosjeZ2IsohYO4eihAW67OoMRO7gK+Sb+/p8z/ONLGzioqy6J2dQJUSWKyP3KHT
         kv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rf8fWZMvIxnpYeMtamKheZb+00lmFUaOudJyDdWv6+Y=;
        b=eEKGEiPCgaDjN3TODU5Dfv2bwDYanzlB14vnmHDjXjuHZ4WRAlYIpSs2DsQQhW27pH
         H5EsZu0JKbJnVAMQIVgWHUGO9bQDlSqM8OSANnC1zetd0Un/nD+e28NhlvhiWhW+yZqG
         lEVeSk9wDYl0Gce6ygxDClIXsDIDR453FUSS4hC7YaFPmCS/yH95VJaTs+ozotOCzRBW
         8IE+J1WmQzDv/yy14pgf/c8K1Fsvj2lBFpqhZulRszphRbiWCNhucp2/27Ad6Rjwyx6z
         7mFRs7duh+KREOunY4EVsuKAjq/2xVcjdFJi5Cfi6j0eWbUNAZ3mhrJ/REYgQaKjlZ0q
         Colw==
X-Gm-Message-State: ACrzQf2LgSCCArzwMcxldCYIRgBIyanjGVhRwaPVEfY+vp+k257eswCV
        NUzMVju89uFqAKbiUNQ79AJE5uPSEtutzB2JxIc=
X-Google-Smtp-Source: AMsMyM7GiZcNXQogA46VA81HHMzEWfQ6yluBBw8Scdrap92kQOQVqLd4qzfX+MoF+IxZmLddhUVJ54LZW2jgCW+Dds4=
X-Received: by 2002:aa7:d6c7:0:b0:452:2604:ae8b with SMTP id
 x7-20020aa7d6c7000000b004522604ae8bmr20285565edr.94.1663686579626; Tue, 20
 Sep 2022 08:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220919144811.3570825-1-houtao@huaweicloud.com>
In-Reply-To: <20220919144811.3570825-1-houtao@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 20 Sep 2022 08:09:28 -0700
Message-ID: <CAADnVQJTQG3=2vMyJ6roXqOoD5dZPs7ddTwxXEcMsym1K-FeUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Check whether or not node is NULL before
 free it in free_bulk
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Hou Tao <houtao1@huawei.com>
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

On Mon, Sep 19, 2022 at 7:30 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> llnode could be NULL if there are new allocations after the checking of
> c-free_cnt > c->high_watermark in bpf_mem_refill() and before the
> calling of __llist_del_first() in free_bulk (e.g. a PREEMPT_RT kernel
> or allocation in NMI context). And it will incur oops as shown below:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 0 P4D 0
>  Oops: 0002 [#1] PREEMPT_RT SMP
>  CPU: 39 PID: 373 Comm: irq_work/39 Tainted: G        W          6.0.0-rc6-rt9+ #1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  RIP: 0010:bpf_mem_refill+0x66/0x130
>  ......
>  Call Trace:
>   <TASK>
>   irq_work_single+0x24/0x60
>   irq_work_run_list+0x24/0x30
>   run_irq_workd+0x18/0x20
>   smpboot_thread_fn+0x13f/0x2c0
>   kthread+0x121/0x140
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x1f/0x30
>   </TASK>
>
> Simply fixing it by checking whether or not llnode is NULL in free_bulk().
>
> Fixes: 1376b7c57624 ("bpf: Introduce any context BPF specific memory allocator.")

There is no such sha.
Also that commit isn't buggy as-is.
The proper fixes tag:
Fixes: 8d5a8011b35d ("bpf: Batch call_rcu callbacks instead of
SLAB_TYPESAFE_BY_RCU.")

Used that while applying.
Thanks for the fix !

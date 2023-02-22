Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAB69FD2F
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 21:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjBVUs0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 15:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjBVUsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 15:48:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A709CDC1
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 12:48:24 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o12so36041510edb.9
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x9vGqY04NE5YfY1Sw9ynv48O9DSd0JhmLYBt2mXX16w=;
        b=G//UFa21+wHn//8ubd4EuVQ/8UDF+IhES4XVCeot6u4YsIjAwMhnFMAJKLGHWzDDWH
         W3Sx9Fg10fPXoaDp/rTNMuol0bNUMES5la4oTdkcckM27uniHcJZQG01UvFur6P5srPD
         evairGHstsMW01JfrDhVGsBJlMsBmA0VwluEK+6vpGnoQPDv8isT4gNTqkq/3veI+QAg
         dBtKOo2aP8TZwIRGRmqe/8VdARjP+XHs6h5lAvj9+RMfvtI+O34oTepuoBgtamMq1svC
         lqyTsu2YmqiAaYIIn1FNP4J54ToeLlEe6Up4/wdsiNerkVnJx61GD9YHWTbNSJaSBDkc
         TBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9vGqY04NE5YfY1Sw9ynv48O9DSd0JhmLYBt2mXX16w=;
        b=7xvV/7BvafzPi5eFXBSAqFCABOgpRbEx15+YGIIwJ6eePie4SObXKTIQMsyc1o5HEI
         d8mEgELd1Ppm4XvdSqN7vEbs/AQSQUw7nn6FPrtmOMOhBwvN8oun2GHtbWu+/n3QI5ZA
         xnXmPwrwvlXcIw1PzYPJzoXLGBSGnweUU/4W8Av/s/8guaAZZ1LEGEhjqVApWAuLIi8K
         RP0NuRV0D0q14xdNv1M2fVZYXz4/3NXLU6zXFZwXRDnznU5XdYI3mDISUwtlcA1IT1Vp
         chBENSBLd24TTdnJazQmjPqSrGvXv9U4iD/U1nlacoLX1382UybMdeI/HJDRexEmVUiW
         qi/g==
X-Gm-Message-State: AO0yUKXM+1h6gLX36FFPRcW6gRsTPmKQGOJ6MVu+nSasc2BiOGO0i/oM
        etOUOsnl+JBsSO50S7n1BRYLsyqh5aVPl04zeJg=
X-Google-Smtp-Source: AK7set9Xy0vcwrrNTKgPw52g9Hr1Fi0wdoXmGTB8WxIjA69a2TKn1NDiG4Lx+lmYSv4WEHEhfgR3PVZxgqSETYMuVrY=
X-Received: by 2002:a17:906:5158:b0:883:ba3b:eb94 with SMTP id
 jr24-20020a170906515800b00883ba3beb94mr7847521ejc.3.1677098902440; Wed, 22
 Feb 2023 12:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20230221200646.2500777-1-memxor@gmail.com> <20230221200646.2500777-3-memxor@gmail.com>
In-Reply-To: <20230221200646.2500777-3-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 12:48:11 -0800
Message-ID: <CAADnVQ+HqZv+NXYMx2oa-eqnEM33SnYH8-1S2gEUkTX1Jx=ipg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Support kptrs in local storage maps
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
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

On Tue, Feb 21, 2023 at 12:06 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Enable support for kptrs in local storage maps by wiring up the freeing
> of these kptrs from map value.
>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/bpf_local_storage.c | 35 ++++++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c           |  6 +++++-
>  kernel/bpf/verifier.c          | 12 ++++++++----
>  3 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 35f4138a54dc..2803b85b30b2 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -75,6 +75,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>         if (selem) {
>                 if (value)
>                         copy_map_value(&smap->map, SDATA(selem)->data, value);
> +               /* No need to call check_and_init_map_value as memory is zero init */
>                 return selem;
>         }
>
> @@ -103,10 +104,17 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
>         struct bpf_local_storage_elem *selem;
>
>         selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> +       bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
> +       kfree(selem);

CI is saying that clang compiled kernel crashes here:
https://github.com/kernel-patches/bpf/actions/runs/4239645973/jobs/7368557262

[ 18.596262] BUG: unable to handle page fault for address: 00000000ffffffff
[ 18.599128] RIP: 0010:bpf_obj_free_fields+0x29/0x110 [ 18.605706] <TASK>
[ 18.605844] bpf_selem_free_tasks_trace_rcu+0x22/0x30
[ 18.606171] rcu_tasks_invoke_cbs+0x150/0x210
[ 18.606449] rcu_tasks_one_gp+0x401/0x430
[ 18.606701] rcu_tasks_kthread+0x35/0x50

map.record somehow became (u32)-1 ?

aarch64 failures look related too:
libbpf: prog 'test_ls_map_kptr_ref1': failed to attach: ERROR:
strerror_r(-524)=22
test_map_kptr_success:FAIL:bpf_program__attach ref1 unexpected error: -524
#124/26 map_kptr/success-map:FAIL

Please pay attention to CI in the future.
It's the developer's job to monitor it for their patches.

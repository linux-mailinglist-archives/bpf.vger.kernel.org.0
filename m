Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110DB5A4014
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 00:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiH1WkD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 18:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1WkC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 18:40:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2646AF5BC
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 15:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C44C1B80A75
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 22:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724E4C43147
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661726398;
        bh=h9Yghxtm63LdVwl0jxH6ayWmmoeOeCxm7Z8UuEnJ2tg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U0Gpqmm4UnVr711sM7qaSbbDfFnwmMDCd94qJwFwn62hjCjshdY/Xpc5tzFt98H/G
         0t2DdJ3KbRgt+l6M6/Y6cRhq2vS/avF+HYwXb8ln3ysdCV55lcHz4sUeqYO34eXJOW
         WLABmSl8mrVCCmnUK6k8A7FcfDOr+FwlISfUBN/5+wHLHiKMo61dkSUEvJwiM8kStD
         bwBl6GIIYqzhTsOtZLWcgBb22ovjUFsjQ4SK4XVjI2FfrfhFsCBNURc+c97KmS85Ud
         hv3MlDfoG7mE3A5BaSITYhLY1bi0xuChkMbcNwlPSbW0zKgJ7AAe4WQxnRbcM9Bz5P
         z8gf3XGlGlkbw==
Received: by mail-qt1-f181.google.com with SMTP id c20so5014511qtw.8
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 15:39:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo0LLNfhI1f4eP7uW+o217z4k/KdaRusG6a9DfDvm3xFcaztLZaO
        NqxxcmDshHZbFzxTWHrPiDN6fguCz3Ivnioya4mz9A==
X-Google-Smtp-Source: AA6agR6PQHEuh4QhUjCIVB/roaiDmF8Rxl8yHb0b7aN27AyZ0Uzm/vf3CjPvTF5w1v54xsQ2EaNHjQ4AbERgKVyf8wU=
X-Received: by 2002:a05:622a:5a07:b0:343:4e03:d5a with SMTP id
 fy7-20020a05622a5a0700b003434e030d5amr7996194qtb.357.1661726397369; Sun, 28
 Aug 2022 15:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220827100134.1621137-1-houtao@huaweicloud.com>
In-Reply-To: <20220827100134.1621137-1-houtao@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 29 Aug 2022 00:39:46 +0200
X-Gmail-Original-Message-ID: <CACYkzJ779M1q4ffgJ01zMrTKJVqd9qGhc-CBT_aB=Pj9HONVXw@mail.gmail.com>
Message-ID: <CACYkzJ779M1q4ffgJ01zMrTKJVqd9qGhc-CBT_aB=Pj9HONVXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Disable preemption when increasing
 per-cpu map_locked
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 27, 2022 at 11:43 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
> from both NMI and non-NMI contexts. But since commit 74d862b682f5
> ("sched: Make migrate_disable/enable() independent of RT"),
> migrations_disable() is also preemptible under CONFIG_PREEMPT case,

nit: migrate_disable

> so now map_locked also disallows concurrent updates from normal contexts
> (e.g. userspace processes) unexpectedly as shown below:
>
> process A                      process B
>
> htab_map_update_elem()
>   htab_lock_bucket()
>     migrate_disable()
>     /* return 1 */
>     __this_cpu_inc_return()
>     /* preempted by B */
>
>                                htab_map_update_elem()
>                                  /* the same bucket as A */
>                                  htab_lock_bucket()
>                                    migrate_disable()
>                                    /* return 2, so lock fails */
>                                    __this_cpu_inc_return()
>                                    return -EBUSY
>
> A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
> only checking the value of map_locked for nmi context. But it will
> re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
> through non-tracing program (e.g. fentry program).
>
> So fixing it by using disable_preempt() instead of migrate_disable() when
> increasing htab->map_locked. However when htab_use_raw_lock() is false,
> bucket lock will be a sleepable spin-lock and it breaks disable_preempt(),
> so still use migrate_disable() for spin-lock case and leave the
> concurrent map updates problem to BPF memory allocator patchset in which
> !htab_use_raw_lock() case will be removed.

I think the description needs a bit more clarity and I think you mean
preempt_disable() instead of  disable_preempt

Suggestion:

One cannot use preempt_disable() to fix this issue as htab_use_raw_lock
being false causes the bucket lock to be a spin lock which can sleep and
does not work with preempt_disable().

Therefore, use migrate_disable() when using the spinlock instead of
preempt_disable() and defer fixing concurrent updates to when the kernel
has its own BPF memory allocator.

>
> Reviewed-by: Hao Luo <haoluo@google.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Fixes tag here please?


> ---
>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b301a63afa2f..6fb3b7fd1622 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -162,17 +162,25 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>                                    unsigned long *pflags)
>  {
>         unsigned long flags;
> +       bool use_raw_lock;
>
>         hash = hash & HASHTAB_MAP_LOCK_MASK;
>
> -       migrate_disable();
> +       use_raw_lock = htab_use_raw_lock(htab);
> +       if (use_raw_lock)
> +               preempt_disable();
> +       else
> +               migrate_disable();
>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
>                 __this_cpu_dec(*(htab->map_locked[hash]));
> -               migrate_enable();
> +               if (use_raw_lock)
> +                       preempt_enable();
> +               else
> +                       migrate_enable();
>                 return -EBUSY;
>         }
>
> -       if (htab_use_raw_lock(htab))
> +       if (use_raw_lock)
>                 raw_spin_lock_irqsave(&b->raw_lock, flags);
>         else
>                 spin_lock_irqsave(&b->lock, flags);
> @@ -185,13 +193,18 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>                                       struct bucket *b, u32 hash,
>                                       unsigned long flags)
>  {
> +       bool use_raw_lock = htab_use_raw_lock(htab);
> +
>         hash = hash & HASHTAB_MAP_LOCK_MASK;
> -       if (htab_use_raw_lock(htab))
> +       if (use_raw_lock)
>                 raw_spin_unlock_irqrestore(&b->raw_lock, flags);
>         else
>                 spin_unlock_irqrestore(&b->lock, flags);
>         __this_cpu_dec(*(htab->map_locked[hash]));
> -       migrate_enable();
> +       if (use_raw_lock)
> +               preempt_enable();
> +       else
> +               migrate_enable();
>  }
>
>  static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
> --
> 2.29.2
>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DDB59B57C
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiHUQmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 12:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiHUQmN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 12:42:13 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FE186C3
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 09:42:12 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id p5so5076697qvz.6
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nRT7zGUSeLsHMzro6U7ZcdeaedKmNHV35hVXVOge8EA=;
        b=UBfzcBCpfNPicsdy/WtDtjcR3SViqTny1VNjT2+KeaJ/HKiEvii58Lj6sw4+cOuYcO
         cFGjRho7m7pqxaY4xqLJ1ZGOtmW/BHE+7RhRT7zOY3EjGfTZx2QLEOO2rfZLlH2Dje1y
         CMwgOfFxm67Hs99YXnL/srz8YWd6V5FPB4Kk54LDXDxVWkzQWfWIfAnOgS7nlHvARXbN
         mkTViYdaacEyxPxJLOg31M69nqpp+yVMK0rdMef+i2G+SLeDlP5mBMNTK4YHwWThN5YH
         p24B/YSLfwntlVmwDS+ggdOG00wKE6oHHo1f8BnvznV2QWnF6eUV4gS86DDtuk+89hfj
         Gh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nRT7zGUSeLsHMzro6U7ZcdeaedKmNHV35hVXVOge8EA=;
        b=NQk0FZqOxVYGt4747e5X1dp9Se0SyarQjERvhJ0rMClLpk9GqReDg1hLyTIBWlg9CW
         nY64Auau2UEVbmSWyMOw8JlycjWs/5htF5WkiKKyfQR7k56235AFeBGWU5VkSkUKLYQE
         eK4H0lVBrfaA5efeqwObt+/BLxGGnCcFnmyuUgUzO8W2hlob0txAXmrAF4CNYLMp74iO
         Xr5owa8VkpOOB2J/bLJlsO0HnoTzh4arcz4kuC+ozyAXJ6wBsLPnXmaE92ufhtRBzYyb
         Fh4dWEp5Wp8/9bGMCvrEQrPkf49ltiYAOBIrHPyaE2Ct4BT3nJaGtlV0AAQLcVjFC5Ql
         D+bw==
X-Gm-Message-State: ACgBeo3x7Rr76J3i4rSDiVzyb+oiiM0Vpx1merH7xx8HIZULgSDpZdBg
        MfA5OXp8vgj+RBk3dWWXyZXzGfskoSrDj8IcRsDuTQ==
X-Google-Smtp-Source: AA6agR79TH2SqiDXe1cFJQjwq2USkca+3rUm7yejBwnYDwPv3po1jidkNrpwiS1E2ExwC4NgAO6C2HcBLxhZtqpCNkY=
X-Received: by 2002:a0c:b31a:0:b0:473:8062:b1b4 with SMTP id
 s26-20020a0cb31a000000b004738062b1b4mr13068982qve.85.1661100131316; Sun, 21
 Aug 2022 09:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220821033223.2598791-1-houtao@huaweicloud.com> <20220821033223.2598791-2-houtao@huaweicloud.com>
In-Reply-To: <20220821033223.2598791-2-houtao@huaweicloud.com>
From:   Hao Luo <haoluo@google.com>
Date:   Sun, 21 Aug 2022 09:42:00 -0700
Message-ID: <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu map_locked
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
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

Hi Hou Tao,

On Sat, Aug 20, 2022 at 8:14 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
> from both NMI and non-NMI contexts. But since 74d862b682f51 ("sched:
> Make migrate_disable/enable() independent of RT"), migrations_disable()
> is also preemptible under !PREEMPT_RT case, so now map_locked also
> disallows concurrent updates from normal contexts (e.g. userspace
> processes) unexpectedly as shown below:
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
> so still use migrate_disable() for spin-lock case.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

IIUC, this patch enlarges the scope of preemption disable to cover inc
map_locked. But I don't think the change is meaningful.

This patch only affects the case when raw lock is used. In the case of
raw lock, irq is disabled for b->raw_lock protected critical section.
A raw spin lock itself doesn't block in both RT and non-RT. So, my
understanding about this patch is, it just makes sure preemption
doesn't happen on the exact __this_cpu_inc_return. But the window is
so small that it should be really unlikely to happen.

>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6c530a5e560a..ad09da139589 100644
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

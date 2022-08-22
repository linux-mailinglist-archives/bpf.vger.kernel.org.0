Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC3559B7E3
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 05:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiHVDWC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 23:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHVDWB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 23:22:01 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23F19C0F
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 20:22:00 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id b2so7279420qvp.1
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 20:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EVwrQe7LmVhezv50F9rHjsSLhRomEYROGlEsv323rGU=;
        b=nQkMdHivw4XIA1aKsQUjU2I4XPu0xXeyFxy+5KMLUSNPcf1Z3hjYM/QHbmWIGIkiid
         6iNsAcgWjm8ZaIUovJa6lsRmxnBs7Qubk+C2dKOUKlPR/AbpQSK3ReVQAOq5B7AM9ZrG
         kB13Bi+W7JgzVkGTuoYNA9PDK0u3Y9TUQnQBK9Wou0HF1Ik8nq+cbNhnse7FaA+OYVan
         8U6+7TMazTjvDDZcOHj//ZQ5zddo/xUCxEPcv0gF6dticaP1XeBLF//5g2pp0D625iCy
         wbnYT2Wf8WkgPCTy/9LneGnV9zN0ER+Jn1hvDpv7IJf0rHks7zbXSQScVeRA4Nsor4G2
         Q+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EVwrQe7LmVhezv50F9rHjsSLhRomEYROGlEsv323rGU=;
        b=X1WqB/acfcEZ6owfgm/Y5geSqWxdQpewrh+1spzLsw9JujNyz8//bvUETrj4lAjd+D
         ukvYLalbplQA5FDeXKO0O1sHFuUVN6vxGJZMehID8u5pPP8yPMkfNwYMtsgk4QJ0HYM3
         xX+v9UjVRD8O//CFjyV4SLZBAb7wkD1YwesaXZHeL1pAttSKl2Jlwncc5PmRFvuqgtBY
         y2WxYw67CQMmAKDnfue4wg5lxJjqzsRMKwGhETgidASriRDKTea7Al2TqHekol0KrlAb
         0wAXbuIsxTqZn8EvBn+Kd1qvNOBv9z9FPQGfOk3zJNdgyk6bFIGadfLt5h++B4H1JAFn
         kOiQ==
X-Gm-Message-State: ACgBeo28eaw0y4zCOH3ti4B9ICBz9NaN7eamEUiXhVA1JQrHpX0OLpoo
        76hkIYll8XZQ8iSXCxRQLyGeGYF1wFt4dFZeKBOBCm/KD3UUcg==
X-Google-Smtp-Source: AA6agR4DscUSxmNfOZUXFG7PqKgjxKn0cFKcHyag19dlz4xJBCsPI/5LCNrcmqmvCFJ3k+t4afBbmfAyLJ9d6tq6oUI=
X-Received: by 2002:ad4:5e8d:0:b0:496:d8cb:3f2c with SMTP id
 jl13-20020ad45e8d000000b00496d8cb3f2cmr5154953qvb.35.1661138519047; Sun, 21
 Aug 2022 20:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com> <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
 <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com>
In-Reply-To: <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com>
From:   Hao Luo <haoluo@google.com>
Date:   Sun, 21 Aug 2022 20:21:48 -0700
Message-ID: <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
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

Hi, Hou Tao

On Sun, Aug 21, 2022 at 6:28 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 8/22/2022 12:42 AM, Hao Luo wrote:
> > Hi Hou Tao,
> >
> > On Sat, Aug 20, 2022 at 8:14 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
> >> from both NMI and non-NMI contexts. But since 74d862b682f51 ("sched:
> >> Make migrate_disable/enable() independent of RT"), migrations_disable()
> >> is also preemptible under !PREEMPT_RT case, so now map_locked also
> >> disallows concurrent updates from normal contexts (e.g. userspace
> >> processes) unexpectedly as shown below:
> >>
> >> process A                      process B
> >>
> >> htab_map_update_elem()
> >>   htab_lock_bucket()
> >>     migrate_disable()
> >>     /* return 1 */
> >>     __this_cpu_inc_return()
> >>     /* preempted by B */
> >>
> >>                                htab_map_update_elem()
> >>                                  /* the same bucket as A */
> >>                                  htab_lock_bucket()
> >>                                    migrate_disable()
> >>                                    /* return 2, so lock fails */
> >>                                    __this_cpu_inc_return()
> >>                                    return -EBUSY
> >>
> >> A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
> >> only checking the value of map_locked for nmi context. But it will
> >> re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
> >> through non-tracing program (e.g. fentry program).
> >>
> >> So fixing it by using disable_preempt() instead of migrate_disable() when
> >> increasing htab->map_locked. However when htab_use_raw_lock() is false,
> >> bucket lock will be a sleepable spin-lock and it breaks disable_preempt(),
> >> so still use migrate_disable() for spin-lock case.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> > IIUC, this patch enlarges the scope of preemption disable to cover inc
> > map_locked. But I don't think the change is meaningful.
> Before 74d862b682f51 ("sched: Make migrate_disable/enable() independent of
> RT"),  the preemption is disabled before increasing map_locked for !PREEMPT_RT
> case, so I don't think that the change is meaningless.
> >
> > This patch only affects the case when raw lock is used. In the case of
> > raw lock, irq is disabled for b->raw_lock protected critical section.
> > A raw spin lock itself doesn't block in both RT and non-RT. So, my
> > understanding about this patch is, it just makes sure preemption
> > doesn't happen on the exact __this_cpu_inc_return. But the window is
> > so small that it should be really unlikely to happen.
> No, it can be easily reproduced by running multiple htab update processes in the
> same CPU. Will add selftest to demonstrate that.

Can you clarify what you demonstrate?

Here is my theory, but please correct me if I'm wrong, I haven't
tested yet. In non-RT, I doubt preemptions are likely to happen after
migrate_disable. That is because very soon after migrate_disable, we
enter the critical section of b->raw_lock with irq disabled. In RT,
preemptions can happen on acquiring b->lock, that is certainly
possible, but this is the !use_raw_lock path, which isn't side-stepped
by this patch.

> >
> >>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
> >>  1 file changed, 18 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> index 6c530a5e560a..ad09da139589 100644
> >> --- a/kernel/bpf/hashtab.c
> >> +++ b/kernel/bpf/hashtab.c
> >> @@ -162,17 +162,25 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
> >>                                    unsigned long *pflags)
> >>  {
> >>         unsigned long flags;
> >> +       bool use_raw_lock;
> >>
> >>         hash = hash & HASHTAB_MAP_LOCK_MASK;
> >>
> >> -       migrate_disable();
> >> +       use_raw_lock = htab_use_raw_lock(htab);
> >> +       if (use_raw_lock)
> >> +               preempt_disable();
> >> +       else
> >> +               migrate_disable();
> >>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
> >>                 __this_cpu_dec(*(htab->map_locked[hash]));
> >> -               migrate_enable();
> >> +               if (use_raw_lock)
> >> +                       preempt_enable();
> >> +               else
> >> +                       migrate_enable();
> >>                 return -EBUSY;
> >>         }
> >>
> >> -       if (htab_use_raw_lock(htab))
> >> +       if (use_raw_lock)
> >>                 raw_spin_lock_irqsave(&b->raw_lock, flags);
> >>         else
> >>                 spin_lock_irqsave(&b->lock, flags);
> >> @@ -185,13 +193,18 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
> >>                                       struct bucket *b, u32 hash,
> >>                                       unsigned long flags)
> >>  {
> >> +       bool use_raw_lock = htab_use_raw_lock(htab);
> >> +
> >>         hash = hash & HASHTAB_MAP_LOCK_MASK;
> >> -       if (htab_use_raw_lock(htab))
> >> +       if (use_raw_lock)
> >>                 raw_spin_unlock_irqrestore(&b->raw_lock, flags);
> >>         else
> >>                 spin_unlock_irqrestore(&b->lock, flags);
> >>         __this_cpu_dec(*(htab->map_locked[hash]));
> >> -       migrate_enable();
> >> +       if (use_raw_lock)
> >> +               preempt_enable();
> >> +       else
> >> +               migrate_enable();
> >>  }
> >>
> >>  static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
> >> --
> >> 2.29.2
> >>
> > .
>

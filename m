Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E659CD6C
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 02:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiHWA4o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 20:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiHWA4n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 20:56:43 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A330513EB5
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 17:56:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g16so9232919qkl.11
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 17:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VnPWi9bL0ys5FfyEfVlJ0kmEcXa3Fd2HJ6zANJo6EtA=;
        b=r3Yzqd6ZpcV9Cfcr3Ujbv4NvU3hMvUiev1bEqm2snb7S1jrYfsQsmHPkhFue9GH8md
         1FLNLVN6a7bqsd1rl8S3bLe0uuAc3C8VCEVUUTrbsx/x4sk2lsPCqo+PeJtwujq6o2k+
         Tfazq7zWModnvtOcP3Dafa9Xs6JLTNlJijlQSNV8Jp9nGcImHM/r3iA42e6vwAp5ypax
         TsEk3419sE+SpdF03C+RCS3bn4k8dsU1VzoA5LiNZQedVhZN+GMLDBXak+44OyRS1XZi
         kflFOxQ13cRvveeSk1iI4wC4cwg965c6NX0dt7e3BMmt+DqM6IV8L1xIToE6dr3MdPOu
         yhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VnPWi9bL0ys5FfyEfVlJ0kmEcXa3Fd2HJ6zANJo6EtA=;
        b=KPb6gI+CWeBzjlmAt/mzfOU/LDp/qND2g0V08+uTCISEdv/mV57cS+HlLl5scN8N+v
         N/DH7hmdcPpkk0AtfxCOWZHXl5+Q+z9bybPw1lgw762g8Z+Bwk1K9o/OpUkAyFDtkZXJ
         CrMOe20o/xISfKIaIGXYlCftvQJ6pP7zo4TQn5vLTnoYzjayaru1scnCHBZoL47/qFQP
         otWNg3ERXSvgMR9LRlZPHUu3TIUZ9Hf4wNDLjPJPQX5eGo/wCi/SslD2AvleZdbHW+4f
         BebEAdnFsNrc6FDL8uHN9vH9KZ2tEbo9BjqsGbwON8tDi+Pjz6FcdnpPFKWDiJxs/PNv
         oEsQ==
X-Gm-Message-State: ACgBeo2ClS0ylR0OxLZZJFj+vnrh9lFidBJJ+pxpUNNBGYkbldLUrxKS
        HK/zNo1LxNhpjSdK2bk1PIQXYIlPuIapnzJ407e8X9hATWA=
X-Google-Smtp-Source: AA6agR4mM16E5uZQ5yGfbZdI3TGa1RQPv/SUmUZmiWebpgV0nDcqKs/fenNToykU7WOCBMN03RaRPTt1au+c+lBpyb8=
X-Received: by 2002:a05:620a:458c:b0:6bb:848a:b86b with SMTP id
 bp12-20020a05620a458c00b006bb848ab86bmr14438866qkb.267.1661216200576; Mon, 22
 Aug 2022 17:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com> <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
 <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com> <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
 <387c851f-03ae-9b34-4ec0-9667fb26ec18@huaweicloud.com> <CA+khW7jgvZR8azSE3gEJvhT_psgEeHCdU3uWAQUkkKFLgh0a4Q@mail.gmail.com>
In-Reply-To: <CA+khW7jgvZR8azSE3gEJvhT_psgEeHCdU3uWAQUkkKFLgh0a4Q@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 22 Aug 2022 17:56:29 -0700
Message-ID: <CA+khW7iv+zX0XzC++i-F7QZju9QGufh6+SVN3JWp9WyJe2qhMg@mail.gmail.com>
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

On Mon, Aug 22, 2022 at 11:01 AM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Aug 22, 2022 at 5:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> > Hi,
> >
> > On 8/22/2022 11:21 AM, Hao Luo wrote:
> > > Hi, Hou Tao
> > >
> > > On Sun, Aug 21, 2022 at 6:28 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > >> Hi,
> > >>
> > >> On 8/22/2022 12:42 AM, Hao Luo wrote:
> > >>> Hi Hou Tao,
> > >>>
> > >>> On Sat, Aug 20, 2022 at 8:14 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > >>>> From: Hou Tao <houtao1@huawei.com>
> > >>>>
> > >>>> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
> > >>>> from both NMI and non-NMI contexts. But since 74d862b682f51 ("sched:
> > >>>> Make migrate_disable/enable() independent of RT"), migrations_disable()
> > >>>> is also preemptible under !PREEMPT_RT case, so now map_locked also
> > >>>> disallows concurrent updates from normal contexts (e.g. userspace
> > >>>> processes) unexpectedly as shown below:
> > >>>>
> > >>>> process A                      process B
> > >>>>
> > >>>> htab_map_update_elem()
> > >>>>   htab_lock_bucket()
> > >>>>     migrate_disable()
> > >>>>     /* return 1 */
> > >>>>     __this_cpu_inc_return()
> > >>>>     /* preempted by B */
> > >>>>
> > >>>>                                htab_map_update_elem()
> > >>>>                                  /* the same bucket as A */
> > >>>>                                  htab_lock_bucket()
> > >>>>                                    migrate_disable()
> > >>>>                                    /* return 2, so lock fails */
> > >>>>                                    __this_cpu_inc_return()
> > >>>>                                    return -EBUSY
> > >>>>
> > >>>> A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
> > >>>> only checking the value of map_locked for nmi context. But it will
> > >>>> re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
> > >>>> through non-tracing program (e.g. fentry program).
> > >>>>
> > >>>> So fixing it by using disable_preempt() instead of migrate_disable() when
> > >>>> increasing htab->map_locked. However when htab_use_raw_lock() is false,
> > >>>> bucket lock will be a sleepable spin-lock and it breaks disable_preempt(),
> > >>>> so still use migrate_disable() for spin-lock case.
> > >>>>
> > >>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > >>>> ---
> > >>> IIUC, this patch enlarges the scope of preemption disable to cover inc
> > >>> map_locked. But I don't think the change is meaningful.
> > >> Before 74d862b682f51 ("sched: Make migrate_disable/enable() independent of
> > >> RT"),  the preemption is disabled before increasing map_locked for !PREEMPT_RT
> > >> case, so I don't think that the change is meaningless.
> > >>> This patch only affects the case when raw lock is used. In the case of
> > >>> raw lock, irq is disabled for b->raw_lock protected critical section.
> > >>> A raw spin lock itself doesn't block in both RT and non-RT. So, my
> > >>> understanding about this patch is, it just makes sure preemption
> > >>> doesn't happen on the exact __this_cpu_inc_return. But the window is
> > >>> so small that it should be really unlikely to happen.
> > >> No, it can be easily reproduced by running multiple htab update processes in the
> > >> same CPU. Will add selftest to demonstrate that.
> > > Can you clarify what you demonstrate?
> > First please enable CONFIG_PREEMPT for the running kernel and then run the
> > following test program as shown below.
> >
>
> Ah, fully preemptive kernel. It's worth mentioning that in the commit
> message. Then it seems promoting migrate_disable to preempt_disable
> may be the best way to solve the problem you described.
>
> > # sudo taskset -c 2 ./update.bin
> > thread nr 2
> > wait for error
> > update error -16
> > all threads exit
> >
> > If there is no "update error -16", you can try to create more map update
> > threads. For example running 16 update threads:
> >
> > # sudo taskset -c 2 ./update.bin 16
> > thread nr 16
> > wait for error
> > update error -16
> > update error -16
> > update error -16
> > update error -16
> > update error -16
> > update error -16
> > update error -16
> > update error -16
> > all threads exit
> >
> > The following is the source code for update.bin:
> >
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <stdbool.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <string.h>
> > #include <errno.h>
> > #include <pthread.h>
> >
> > #include "bpf.h"
> > #include "libbpf.h"
> >
> > static bool stop;
> > static int fd;
> >
> > static void *update_fn(void *arg)
> > {
> >         while (!stop) {
> >                 unsigned int key = 0, value = 1;
> >                 int err;
> >
> >                 err = bpf_map_update_elem(fd, &key, &value, 0);
> >                 if (err) {
> >                         printf("update error %d\n", err);
> >                         stop = true;
> >                         break;
> >                 }
> >         }
> >
> >         return NULL;
> > }
> >
> > int main(int argc, char **argv)
> > {
> >         LIBBPF_OPTS(bpf_map_create_opts, opts);
> >         unsigned int i, nr;
> >         pthread_t *tids;
> >
> >         nr = 2;
> >         if (argc > 1)
> >                 nr = atoi(argv[1]);
> >         printf("thread nr %u\n", nr);
> >
> >         libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
> >         fd = bpf_map_create(BPF_MAP_TYPE_HASH, "batch", 4, 4, 1, &opts);
> >         if (fd < 0) {
> >                 printf("create map error %d\n", fd);
> >                 return 1;
> >         }
> >
> >         tids = malloc(nr * sizeof(*tids));
> >         for (i = 0; i < nr; i++)
> >                 pthread_create(&tids[i], NULL, update_fn, NULL);
> >
> >         printf("wait for error\n");
> >         for (i = 0; i < nr; i++)
> >                 pthread_join(tids[i], NULL);
> >
> >         printf("all threads exit\n");
> >
> >         free(tids);
> >         close(fd);
> >
> >         return 0;
> > }
> >

Tao, thanks very much for the test. I played it a bit and I can
confirm that map_update failures are seen under CONFIG_PREEMPT. The
failures are not present under CONFIG_PREEMPT_NONE or
CONFIG_PREEMPT_VOLUNTARY. I experimented with a few alternatives I was
thinking of and they didn't work. It looks like Hou Tao's idea,
promoting migrate_disable to preempt_disable, is probably the best we
can do for the non-RT case. So

Reviewed-by: Hao Luo <haoluo@google.com>

But, I am not sure if we want to get rid of preemption-caused batch
map updates on preemptive kernels, or if there are better solutions to
address [0].

Tao, could you mention CONFIG_PREEMPT in your commit message? Thanks.

> > >
> > > Here is my theory, but please correct me if I'm wrong, I haven't
> > > tested yet. In non-RT, I doubt preemptions are likely to happen after
> > > migrate_disable. That is because very soon after migrate_disable, we
> > > enter the critical section of b->raw_lock with irq disabled. In RT,
> > > preemptions can happen on acquiring b->lock, that is certainly
> > > possible, but this is the !use_raw_lock path, which isn't side-stepped
> > > by this patch.
> > >
> > >>>>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
> > >>>>  1 file changed, 18 insertions(+), 5 deletions(-)
> > >>>>
> > >>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > >>>> index 6c530a5e560a..ad09da139589 100644
> > >>>> --- a/kernel/bpf/hashtab.c
> > >>>> +++ b/kernel/bpf/hashtab.c
> > >>>> @@ -162,17 +162,25 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
> > >>>>                                    unsigned long *pflags)
> > >>>>  {
> > >>>>         unsigned long flags;
> > >>>> +       bool use_raw_lock;
> > >>>>
> > >>>>         hash = hash & HASHTAB_MAP_LOCK_MASK;
> > >>>>
> > >>>> -       migrate_disable();
> > >>>> +       use_raw_lock = htab_use_raw_lock(htab);
> > >>>> +       if (use_raw_lock)
> > >>>> +               preempt_disable();
> > >>>> +       else
> > >>>> +               migrate_disable();
> > >>>>         if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
> > >>>>                 __this_cpu_dec(*(htab->map_locked[hash]));
> > >>>> -               migrate_enable();
> > >>>> +               if (use_raw_lock)
> > >>>> +                       preempt_enable();
> > >>>> +               else
> > >>>> +                       migrate_enable();
> > >>>>                 return -EBUSY;
> > >>>>         }
> > >>>>
> > >>>> -       if (htab_use_raw_lock(htab))
> > >>>> +       if (use_raw_lock)
> > >>>>                 raw_spin_lock_irqsave(&b->raw_lock, flags);
> > >>>>         else
> > >>>>                 spin_lock_irqsave(&b->lock, flags);
> > >>>> @@ -185,13 +193,18 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
> > >>>>                                       struct bucket *b, u32 hash,
> > >>>>                                       unsigned long flags)
> > >>>>  {
> > >>>> +       bool use_raw_lock = htab_use_raw_lock(htab);
> > >>>> +
> > >>>>         hash = hash & HASHTAB_MAP_LOCK_MASK;
> > >>>> -       if (htab_use_raw_lock(htab))
> > >>>> +       if (use_raw_lock)
> > >>>>                 raw_spin_unlock_irqrestore(&b->raw_lock, flags);
> > >>>>         else
> > >>>>                 spin_unlock_irqrestore(&b->lock, flags);
> > >>>>         __this_cpu_dec(*(htab->map_locked[hash]));
> > >>>> -       migrate_enable();
> > >>>> +       if (use_raw_lock)
> > >>>> +               preempt_enable();
> > >>>> +       else
> > >>>> +               migrate_enable();
> > >>>>  }
> > >>>>
> > >>>>  static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
> > >>>> --
> > >>>> 2.29.2
> > >>>>
> > >>> .
> > > .
> >

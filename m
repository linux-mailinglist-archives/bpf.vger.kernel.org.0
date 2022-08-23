Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5359CDE3
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiHWB31 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 21:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHWB31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 21:29:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0E26549
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:29:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q2so14028529edb.6
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=c4PPMlZey0bX5ltlkq8kHrp/HM2ePVfnvVadv1YMxl4=;
        b=prfQbsk3UiUpvf+nuolwL8LfJA3RMP7wG8OwQK3fjoRX1w9EWpsHYCSAyscx6m1i5J
         260U6Dc84gXHjiNHy5upTEqfxOvkmLDZSrhnqSywlX1Fruo7chpAgSm2wzfGbOtkMJmC
         Su2JmeI4iVZuo/aQpdYr1A0ozA74pri7dIAymwZxFXPpcsXKSqLjWmp45RqwNJEUDMio
         sqYy/LTiZBgB5nI9pqyvg0x92p6eyJ0f3qRHL7dyGUWCRLhhWNrZLVV+KSWVMji5bTD+
         KTlzBdCQXPZXOGT4xoro3nT+ZHjvldbmic5K/jN7s8cAxNENq2+SEEvZ9JkbKJ1BU6PK
         ynKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=c4PPMlZey0bX5ltlkq8kHrp/HM2ePVfnvVadv1YMxl4=;
        b=J1MMwJBTyjw+uoOBrhGuY8NKNZu1JQLmvqTfGQOxx6SP8tTt1CTBX81BveE5BOS+wa
         7nlo+xHsJ/q+obPCH9eZ0MHZBm6RnPu1uGS3dgyWiiM7JvGvxxaRxszQWI7lTw+SVvTb
         OaxbFjJygZqUtaaopEjHzvo0B9RXj52Fl5MAOSx87Y5Xw+HP2jx+sUekGoNIefmCscP/
         11zWgGyRkhA+r57YbvfVd9naEllhZPAaueJGjiLpjaLdDkqYS9pb6dZiWtkRcGfLVrFz
         gG4jB9NM8s2gA+98Nz6SiNWOydJ2UrjodOnTFB6df3XBnqmG/LsQ5Zei1yxwLs0B1z1L
         KOkg==
X-Gm-Message-State: ACgBeo1Iuze6ctspMYCacrnQ0R9PC73NJnI5mPucTiT3qW/gutIdZnI4
        iNDtPIGSnZE69zGVuEMlelNZHCaj16xK3qLtjio=
X-Google-Smtp-Source: AA6agR4h9na5am0pLz9/BQhU6gP3W1iIOkS3OdGiGB2JM1O+dO1mF3ajLdSTehQPu9F3kCF7Xox1KRPyfTgfX+O80nE=
X-Received: by 2002:a05:6402:270d:b0:43a:67b9:6eea with SMTP id
 y13-20020a056402270d00b0043a67b96eeamr1515109edd.94.1661218161162; Mon, 22
 Aug 2022 18:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com> <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
 <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com> <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
 <387c851f-03ae-9b34-4ec0-9667fb26ec18@huaweicloud.com> <CA+khW7jgvZR8azSE3gEJvhT_psgEeHCdU3uWAQUkkKFLgh0a4Q@mail.gmail.com>
 <CA+khW7iv+zX0XzC++i-F7QZju9QGufh6+SVN3JWp9WyJe2qhMg@mail.gmail.com>
In-Reply-To: <CA+khW7iv+zX0XzC++i-F7QZju9QGufh6+SVN3JWp9WyJe2qhMg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 22 Aug 2022 18:29:09 -0700
Message-ID: <CAADnVQ+udaAy5OZ-BXpfeQZdPRHD6F+FUD7KxJfxcjiyvh2Dsg@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu map_locked
To:     Hao Luo <haoluo@google.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
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
        Lorenz Bauer <oss@lmb.io>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 22, 2022 at 5:56 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Aug 22, 2022 at 11:01 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Aug 22, 2022 at 5:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
> > >
> > > Hi,
> > >
> > > On 8/22/2022 11:21 AM, Hao Luo wrote:
> > > > Hi, Hou Tao
> > > >
> > > > On Sun, Aug 21, 2022 at 6:28 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > > >> Hi,
> > > >>
> > > >> On 8/22/2022 12:42 AM, Hao Luo wrote:
> > > >>> Hi Hou Tao,
> > > >>>
> > > >>> On Sat, Aug 20, 2022 at 8:14 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > > >>>> From: Hou Tao <houtao1@huawei.com>
> > > >>>>
> > > >>>> Per-cpu htab->map_locked is used to prohibit the concurrent accesses
> > > >>>> from both NMI and non-NMI contexts. But since 74d862b682f51 ("sched:
> > > >>>> Make migrate_disable/enable() independent of RT"), migrations_disable()
> > > >>>> is also preemptible under !PREEMPT_RT case, so now map_locked also
> > > >>>> disallows concurrent updates from normal contexts (e.g. userspace
> > > >>>> processes) unexpectedly as shown below:
> > > >>>>
> > > >>>> process A                      process B
> > > >>>>
> > > >>>> htab_map_update_elem()
> > > >>>>   htab_lock_bucket()
> > > >>>>     migrate_disable()
> > > >>>>     /* return 1 */
> > > >>>>     __this_cpu_inc_return()
> > > >>>>     /* preempted by B */
> > > >>>>
> > > >>>>                                htab_map_update_elem()
> > > >>>>                                  /* the same bucket as A */
> > > >>>>                                  htab_lock_bucket()
> > > >>>>                                    migrate_disable()
> > > >>>>                                    /* return 2, so lock fails */
> > > >>>>                                    __this_cpu_inc_return()
> > > >>>>                                    return -EBUSY
> > > >>>>
> > > >>>> A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
> > > >>>> only checking the value of map_locked for nmi context. But it will
> > > >>>> re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
> > > >>>> through non-tracing program (e.g. fentry program).
> > > >>>>
> > > >>>> So fixing it by using disable_preempt() instead of migrate_disable() when
> > > >>>> increasing htab->map_locked. However when htab_use_raw_lock() is false,
> > > >>>> bucket lock will be a sleepable spin-lock and it breaks disable_preempt(),
> > > >>>> so still use migrate_disable() for spin-lock case.
> > > >>>>
> > > >>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> Tao, thanks very much for the test. I played it a bit and I can
> confirm that map_update failures are seen under CONFIG_PREEMPT. The
> failures are not present under CONFIG_PREEMPT_NONE or
> CONFIG_PREEMPT_VOLUNTARY. I experimented with a few alternatives I was
> thinking of and they didn't work. It looks like Hou Tao's idea,
> promoting migrate_disable to preempt_disable, is probably the best we
> can do for the non-RT case. So

preempt_disable is also faster than migrate_disable,
so patch 1 will not only fix this issue, but will improve performance.

Patch 2 is too hacky though.
I think it's better to wait until my bpf_mem_alloc patches land.
RT case won't be special anymore. We will be able to remove
htab_use_raw_lock() helper and unconditionally use raw_spin_lock.
With bpf_mem_alloc there is no inline memory allocation anymore.

So please address Hao's comments, add a test and
resubmit patches 1 and 3.
Also please use [PATCH bpf-next] in the subject to help BPF CI
and patchwork scripts.

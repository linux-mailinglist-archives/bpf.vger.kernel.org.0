Return-Path: <bpf+bounces-1975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5B725198
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 03:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D41C20B98
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 01:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8563F;
	Wed,  7 Jun 2023 01:39:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D557C
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 01:39:39 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51D9199D;
	Tue,  6 Jun 2023 18:39:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so78525261fa.1;
        Tue, 06 Jun 2023 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686101975; x=1688693975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RREVzSgazm5gHGWWBCv6bqwAttkRk0fKIUglpJkCHk0=;
        b=AsLFktq/4t7QYvK5BXPKgO3mQFiJUqhI9Z0l0VcnB2ZrJQbbLz0uf+VgUjScz9uJRl
         VEwRuyBpV5Gh2/J8vara9CMSbbCG2u8d6ji2WAK53aHXlQEcKjHD0N8JjWgsvCz9eDVd
         vGTsgeLIrFXTFHAUD8mclekY2MQwFFcaw3AY5lnuVz4F/OnUWuOcLVdZwWJFUvq9UoMt
         eFgeX78VUDQviiwojSg1FPAoGOSLfPgk9QtTveQ4zkmj7K92/8UIrdicX9APLmm0Gx33
         QQanlzpcWq5gYP0edEZToaw/owawBBfoNgpUuRHWf1ZVD05B4bTNS/vXHHS2E8iXtD8G
         9XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686101975; x=1688693975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RREVzSgazm5gHGWWBCv6bqwAttkRk0fKIUglpJkCHk0=;
        b=BZKpVyd1vqham7+9xavrUK6h7dl7oD6iG0/0zJtMVMyGbXiLZaA3yDkudLL/jL9Z30
         uaIC6sirkVDG1XjaBAY27jxpVekBt/rZF2nb8E1D8zunPDvEvCIjECIgAqhFtJEhJqMZ
         DlxgSEmmbam0th1SG/LhRkslDG0UrQANTlZxzWdIto6k4leVsRerzg4Vd5i0l+zo4r4a
         JDudW0AnOiAYLbfR4CrLu1U91smulN+OBSpyHCvwj0Q1mn413alnTRZYnizc8BW0WWLv
         8SkTvIWnC5NnfxOaLOVfidomwSECGU0jBRK3AdOAW1Zx0yHROU7d1Xaop6BST/FbC4FV
         QEYA==
X-Gm-Message-State: AC+VfDwt9EC1cXuYneEvxjM0HNtYD4qjirjPxUqaBC04lkb7UobN7dGb
	7y9AetiXf7HJLfvTFpn5nGNqVa9tzfiUgcc2eHjUaROb
X-Google-Smtp-Source: ACHHUZ6RWL8EomOneQSoKd5xRmm97SuvtTHqI/r/Z3gnK0wNtk6eCANz57zd7GxGHtHv++DX7E07FPx/9YiLCfdeScw=
X-Received: by 2002:a2e:6e10:0:b0:2af:29d2:2ffe with SMTP id
 j16-20020a2e6e10000000b002af29d22ffemr1782875ljc.15.1686101974745; Tue, 06
 Jun 2023 18:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com> <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <0bbf258f-668b-a691-e425-a4c1c6bfcc91@huaweicloud.com>
In-Reply-To: <0bbf258f-668b-a691-e425-a4c1c6bfcc91@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jun 2023 18:39:23 -0700
Message-ID: <CAADnVQL9OmzUEajiVN7DMHcpOUya6O-JvwU1zkPwxZ0D2XsPWg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory allocator
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	"houtao1@huawei.com" <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 6:19=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 6/7/2023 5:04 AM, Alexei Starovoitov wrote:
> > On Tue, Jun 06, 2023 at 08:30:58PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 6/6/2023 11:53 AM, Hou Tao wrote:
> >>> From: Hou Tao <houtao1@huawei.com>
> >>>
> >>> Hi,
> >>>
> >>> The implementation of v4 is mainly based on suggestions from Alexi [0=
].
> >>> There are still pending problems for the current implementation as sh=
own
> >>> in the benchmark result in patch #3, but there was a long time from t=
he
> >>> posting of v3, so posting v4 here for further disscussions and more
> >>> suggestions.
> >>>
> >>> The first problem is the huge memory usage compared with bpf memory
> >>> allocator which does immediate reuse:
> >>>
> >>> htab-mem-benchmark (reuse-after-RCU-GP):
> >>> | name               | loop (k/s)| average memory (MiB)| peak memory =
(MiB)|
> >>> | --                 | --        | --                  | --          =
     |
> >>> | no_op              | 1159.18   | 0.99                | 0.99        =
     |
> >>> | overwrite          | 11.00     | 2288                | 4109        =
     |
> >>> | batch_add_batch_del| 8.86      | 1558                | 2763        =
     |
> >>> | add_del_on_diff_cpu| 4.74      | 11.39               | 14.77       =
     |
> >>>
> >>> htab-mem-benchmark (immediate-reuse):
> >>> | name               | loop (k/s)| average memory (MiB)| peak memory =
(MiB)|
> >>> | --                 | --        | --                  | --          =
     |
> >>> | no_op              | 1160.66   | 0.99                | 1.00        =
     |
> >>> | overwrite          | 28.52     | 2.46                | 2.73        =
     |
> >>> | batch_add_batch_del| 11.50     | 2.69                | 2.95        =
     |
> >>> | add_del_on_diff_cpu| 3.75      | 15.85               | 24.24       =
     |
> >>>
> >>> It seems the direct reason is the slow RCU grace period. During
> >>> benchmark, the elapsed time when reuse_rcu() callback is called is ab=
out
> >>> 100ms or even more (e.g., 2 seconds). I suspect the global per-bpf-ma
> >>> spin-lock and the irq-work running in the contex of freeing process w=
ill
> >>> increase the running overhead of bpf program, the running time of
> >>> getpgid() is increased, the contex switch is slowed down and the RCU
> >>> grace period increases [1], but I am still diggin into it.
> >> For reuse-after-RCU-GP flavor, by removing per-bpf-ma reusable list
> >> (namely bpf_mem_shared_cache) and using per-cpu reusable list (like v3
> >> did) instead, the memory usage of htab-mem-benchmark will decrease a l=
ot:
> >>
> >> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list):
> >> | name               | loop (k/s)| average memory (MiB)| peak memory (=
MiB)|
> >> | --                 | --        | --                  | --           =
    |
> >> | no_op              | 1165.38   | 0.97                | 1.00         =
    |
> >> | overwrite          | 17.25     | 626.41              | 781.82       =
    |
> >> | batch_add_batch_del| 11.51     | 398.56              | 500.29       =
    |
> >> | add_del_on_diff_cpu| 4.21      | 31.06               | 48.84        =
    |
> >>
> >> But the memory usage is still large compared with v3 and the elapsed
> >> time of reuse_rcu() callback is about 90~200ms. Compared with v3, ther=
e
> >> are still two differences:
> >> 1) v3 uses kmalloc() to allocate multiple inflight RCU callbacks to
> >> accelerate the reuse of freed objects.
> >> 2) v3 uses kworker instead of irq_work for free procedure.
> >>
> >> For 1), after using kmalloc() in irq_work to allocate multiple infligh=
t
> >> RCU callbacks (namely reuse_rcu()), the memory usage decreases a bit,
> >> but is not enough:
> >>
> >> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list + multi=
ple reuse_rcu() callbacks):
> >> | name               | loop (k/s)| average memory (MiB)| peak memory (=
MiB)|
> >> | --                 | --        | --                  | --           =
    |
> >> | no_op              | 1247.00   | 0.97                | 1.00         =
    |
> >> | overwrite          | 16.56     | 490.18              | 557.17       =
    |
> >> | batch_add_batch_del| 11.31     | 276.32              | 360.89       =
    |
> >> | add_del_on_diff_cpu| 4.00      | 24.76               | 42.58        =
    |
> >>
> >> So it seems the large memory usage is due to irq_work (reuse_bulk) use=
d
> >> for free procedure. However after increasing the threshold for invokin=
g
> >> irq_work reuse_bulk (e.g., use 10 * c->high_watermark), but there is n=
o
> >> big difference in the memory usage and the delayed time for RCU
> >> callbacks. Perhaps the reason is that although the number of  reuse_bu=
lk
> >> irq_work calls is reduced but the time of alloc_bulk() irq_work calls =
is
> >> increased because there are no reusable objects.
> > The large memory usage is because the benchmark in patch 2 is abusing i=
t.
> > It's doing one bpf_loop() over 16k elements (in case of 1 producer)
> > and 16k/8 loops for --producers=3D8.
> > That's 2k memory allocations that have to wait for RCU GP.
> > Of course that's a ton of memory.
> I don't agree that. Because in v3, the benchmark is the same, but both
> the performance and the memory usage are better than v4. Even compared
> with  "htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list +
> multiple reuse_rcu() callbacks)" above, the memory usage in v3 is still
> much smaller as shown below. If the large memory usage is due to the
> abuse in benchmark, how do you explain the memory usage in v3 ?

There could have been implementation bugs or whatever else.
The main point is the bench test is not realistic and should not be
used to make design decisions.

> The reason I added tail for each list is that there could be thousands
> even ten thousands elements in these lists and there is no need to spend
> CPU time to traversal these list one by one. It maybe a premature
> optimization. So let me remove tails from these list first and I will
> try to add these tails back later and check whether or not there is any
> performance improvement.

There will be thousands of elements only because the bench test is wrong.
It's doing something no real prog would do.

> I have a different view for the benchmark. Firstly htab is not the only
> user of bpf memory allocator, secondly we can't predict the exact
> behavior of bpf programs, so I think to stress bpf memory allocator for
> various kinds of use case is good for its broad usage.

It is not a stress test. It's an abuse.
A stress test would be something that can happen in practice.
Doing thousands map_updates in a forever loop is not something
useful code would do.
For example call_rcu_tasks_trace is not design to be called millions
times a second. It's an anti-pattern and rcu core won't be optimized to do =
so.
rcu, srcu, rcu_task_trace have different usage patterns.
The programmer has to correctly pick one depending on the use case.
Same with bpf htab. If somebody has a real need to do thousands
updates under rcu lock they should be using preallocated map and deal
with immediate reuse.


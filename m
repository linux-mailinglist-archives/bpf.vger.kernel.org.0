Return-Path: <bpf+bounces-1956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A838724E70
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 23:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AFE2810A5
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3210B2721E;
	Tue,  6 Jun 2023 21:04:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2A3D7F
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 21:04:34 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8198E171D;
	Tue,  6 Jun 2023 14:04:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d44b198baso4814278b3a.0;
        Tue, 06 Jun 2023 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686085473; x=1688677473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z67gbpgUg4L5eXxeG6rpryziRgHhf2fUrevjsaebNpk=;
        b=nu3hngaf5OWC71KVa1Fb3a2ZNhx+wlNgVFeY6F/vzTqSpVE958yajv4ze8c9jYbxgd
         10hKw/wPykPCSgAKdLZ8IVAuj/CiJxWPIwxTvKgF4u7d8N2IbtXcaiAmyL1aEEWd3Ve3
         FRKMwm62vF4JHDFCMm4Oay4zhx735g7MFvzMDQ5vrfDnduZaS1nClweCLqrXB6P5xhir
         MYaHlffenkurVX3Yl8i5k/4r4wRH+9e/K0clEdqYMXDYxO2XZMVdxCsPAwIzkPtEewKq
         HTbbpkcNo/fYHXcC6uTO8V0456QXVvVzKPZu+hZeCgwM+TeJrzg0e8aP4ofHhb7Aqhkv
         21PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686085473; x=1688677473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z67gbpgUg4L5eXxeG6rpryziRgHhf2fUrevjsaebNpk=;
        b=jEo5veR70JU7K5Z/HcDuXW6r4o75qbujVTNsr6AZBakmV+9vcB1Y5fxnrep11YRJcC
         KogJhWODKSEHUQtMrC10VEg2QaqnhHWtk+A0ZEqOXbAdlIJBJ3ivvhIFLV21TqwRxPSx
         DsfPIUF8mPe01U8UJUF+51VAe5X1ZL5w648+YQtjBCNtESAsC+wAoiXjBoZFlS9FlJMV
         Bf73hKrumgz2dVaLOgDfootoN01Pdfbc/YCJ9mbxQDyyMiBDo4Hl+ZJwMsDpw1Ze0tiB
         L3CWE8yU5E+41zOoh9+SemcXboJzEvrqAYqYowLJzGgIAYWzmJ8FYNd9C/+9nnFZgQI5
         F6Cg==
X-Gm-Message-State: AC+VfDygElrSl3JB1Wa35aniPKTXhPKVNoDmyREXTRjCMsGtcLeR5isd
	+epHr1a40KhdiEf7EfhHOwg=
X-Google-Smtp-Source: ACHHUZ5iWaI7P0672a4cDvgmnE9ViccEwKzibjkIgDuXiSDmgvmthV+Nl71mcYSv5U3RYO6nRwj+qQ==
X-Received: by 2002:a05:6a00:4403:b0:659:14c8:1f0b with SMTP id br3-20020a056a00440300b0065914c81f0bmr4213299pfb.4.1686085472653;
        Tue, 06 Jun 2023 14:04:32 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:500::4:11fc])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b0064f95bb8255sm7257236pff.53.2023.06.06.14.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 14:04:32 -0700 (PDT)
Date: Tue, 6 Jun 2023 14:04:29 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	"houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
Message-ID: <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 06, 2023 at 08:30:58PM +0800, Hou Tao wrote:
> Hi,
> 
> On 6/6/2023 11:53 AM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > Hi,
> >
> > The implementation of v4 is mainly based on suggestions from Alexi [0].
> > There are still pending problems for the current implementation as shown
> > in the benchmark result in patch #3, but there was a long time from the
> > posting of v3, so posting v4 here for further disscussions and more
> > suggestions.
> >
> > The first problem is the huge memory usage compared with bpf memory
> > allocator which does immediate reuse:
> >
> > htab-mem-benchmark (reuse-after-RCU-GP):
> > | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
> > | --                 | --        | --                  | --               |
> > | no_op              | 1159.18   | 0.99                | 0.99             |
> > | overwrite          | 11.00     | 2288                | 4109             |
> > | batch_add_batch_del| 8.86      | 1558                | 2763             |
> > | add_del_on_diff_cpu| 4.74      | 11.39               | 14.77            |
> >
> > htab-mem-benchmark (immediate-reuse):
> > | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
> > | --                 | --        | --                  | --               |
> > | no_op              | 1160.66   | 0.99                | 1.00             |
> > | overwrite          | 28.52     | 2.46                | 2.73             |
> > | batch_add_batch_del| 11.50     | 2.69                | 2.95             |
> > | add_del_on_diff_cpu| 3.75      | 15.85               | 24.24            |
> >
> > It seems the direct reason is the slow RCU grace period. During
> > benchmark, the elapsed time when reuse_rcu() callback is called is about
> > 100ms or even more (e.g., 2 seconds). I suspect the global per-bpf-ma
> > spin-lock and the irq-work running in the contex of freeing process will
> > increase the running overhead of bpf program, the running time of
> > getpgid() is increased, the contex switch is slowed down and the RCU
> > grace period increases [1], but I am still diggin into it.
> For reuse-after-RCU-GP flavor, by removing per-bpf-ma reusable list
> (namely bpf_mem_shared_cache) and using per-cpu reusable list (like v3
> did) instead, the memory usage of htab-mem-benchmark will decrease a lot:
> 
> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list):
> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
> | --                 | --        | --                  | --               |
> | no_op              | 1165.38   | 0.97                | 1.00             |
> | overwrite          | 17.25     | 626.41              | 781.82           |
> | batch_add_batch_del| 11.51     | 398.56              | 500.29           |
> | add_del_on_diff_cpu| 4.21      | 31.06               | 48.84            |
> 
> But the memory usage is still large compared with v3 and the elapsed
> time of reuse_rcu() callback is about 90~200ms. Compared with v3, there
> are still two differences:
> 1) v3 uses kmalloc() to allocate multiple inflight RCU callbacks to
> accelerate the reuse of freed objects.
> 2) v3 uses kworker instead of irq_work for free procedure.
> 
> For 1), after using kmalloc() in irq_work to allocate multiple inflight
> RCU callbacks (namely reuse_rcu()), the memory usage decreases a bit,
> but is not enough:
> 
> htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list + multiple reuse_rcu() callbacks):
> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
> | --                 | --        | --                  | --               |
> | no_op              | 1247.00   | 0.97                | 1.00             |
> | overwrite          | 16.56     | 490.18              | 557.17           |
> | batch_add_batch_del| 11.31     | 276.32              | 360.89           |
> | add_del_on_diff_cpu| 4.00      | 24.76               | 42.58            |
> 
> So it seems the large memory usage is due to irq_work (reuse_bulk) used
> for free procedure. However after increasing the threshold for invoking
> irq_work reuse_bulk (e.g., use 10 * c->high_watermark), but there is no
> big difference in the memory usage and the delayed time for RCU
> callbacks. Perhaps the reason is that although the number of  reuse_bulk
> irq_work calls is reduced but the time of alloc_bulk() irq_work calls is
> increased because there are no reusable objects.

The large memory usage is because the benchmark in patch 2 is abusing it.
It's doing one bpf_loop() over 16k elements (in case of 1 producer)
and 16k/8 loops for --producers=8.
That's 2k memory allocations that have to wait for RCU GP.
Of course that's a ton of memory.

As far as implementation in patch 3 please respin it asap and remove *_tail optimization.
It makes the code hard to read and doesn't buy us anything.
Other than that the algorithm looks fine.

> > Another problem is the performance degradation compared with immediate
> > reuse and the output from perf report shown the per-bpf-ma spin-lock is a
> > top-one hotspot:

That's not what I see.
Hot spin_lock is in generic htab code. Not it ma.
I still believe per-bpf-ma spin-lock is fine.
The bench in patch 2 is measuring something that no real bpf prog cares about.

See how map_perf_test is doing:
        for (i = 0; i < 10; i++) {
                bpf_map_update_elem(&hash_map_alloc, &key, &init_val, BPF_ANY);

Even 10 map updates for the same map in a single bpf prog invocation is not realistic.
16k/8 is beyond any normal scenario.
There is no reason to optimize bpf_ma for the case of htab abuse.

> > map_perf_test (reuse-after-RCU-GP)
> > 0:hash_map_perf kmalloc 194677 events per sec
> >
> > map_perf_test (immediate reuse)
> > 2:hash_map_perf kmalloc 384527 events per sec

For some reason I cannot reproduce the slow down with map_perf_test 4 8.
I see the same perf with/without patch 3.

I've applied patch 1.
Please respin with patch 2 doing no more than 10 map_updates under rcu lock
and remove *_tail optimization from patch 3.
Just do llist_for_each_safe() when you move elements from one list to another.
And let's brainstorm further.
Please do not delay.


Return-Path: <bpf+bounces-2966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96146737927
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 04:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD39C1C20DB3
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D617EF;
	Wed, 21 Jun 2023 02:32:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE310EA;
	Wed, 21 Jun 2023 02:32:44 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EAFB4;
	Tue, 20 Jun 2023 19:32:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25ecc11961dso3439402a91.1;
        Tue, 20 Jun 2023 19:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314763; x=1689906763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDf15NEBcg7TFrAJzAUvACQjB4kuKUVLnfuynmQOT2k=;
        b=LWh3pTQ9p+Oojtn6b4+jNWww2wZygDe3nqEY9SPHGAm0VMOmZTokBJX2PEEv9GdT9o
         xspXvkxnIodRz9EG3TGJ15Wf5MoH86LcDMTJiaD4ax/Z+QwOecd79uX7y7/SqZvSEWIQ
         SJEvIk3jAamfhDE2Wx20ZFNjQuI7PjiHK3LOLgYB/tMOnoFzpL04wlaIWDAKRE1mcOBf
         SgPtBRT5r/2VELrL+gRNytXwo8NgdvKIa9N+ovTAtrRvSmnnX8cVipGZGE8e2N+b+VZR
         7Tp90GC328ivHLvWP+VS/0mln0J0AtkRIBUWXlstcSoRMGVKfEg/AxZ6egXYzIusaO3c
         SFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314763; x=1689906763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDf15NEBcg7TFrAJzAUvACQjB4kuKUVLnfuynmQOT2k=;
        b=bGfrDbfHTOeJ8VZHUQhKv8EGTRhVuojHj5qm56iUV4+/FGsx8S0ns2ihrahLrh9kOG
         UQypJxWD6qxiCf7kgkO+n2NxX/IDccJhR+0En5XRVGMSjlwQCXh7v6pIWU8a3HYGwa2y
         4EWZovygPNwWojZlkcsd8Kbi7IU9vqg9axvzGqYTQDzpQA6pK9MKz/WH1PTOJFaqy9Fe
         5RpfZedo6LBgGdXp42XRz4se0BvaWLqE4QtEkTsbiSIuwZWZNstajY6AiYl6PPtIFZTE
         cbRIXQIvHQZphgbT5oIUSvA7E+fyFV+MowbHkixtZixshsi6+dtU6uzLiwa5Em8FtYpS
         lQKw==
X-Gm-Message-State: AC+VfDwthxahGfPq2L2GAXYlFL7bN8H33hblQKKBPndHgn6/wmH9x0x1
	B3cKvpTlKWnDQoaiMgpT3Uj37n96QzM=
X-Google-Smtp-Source: ACHHUZ7m6U3ZjaEE5INKSVXfymJp+24nPWdrRQv29gJSM9TV6blb9OSe8Wcma+pA98YLvdJ2SiBGeQ==
X-Received: by 2002:a17:90a:710:b0:25c:1138:d97c with SMTP id l16-20020a17090a071000b0025c1138d97cmr12514969pjl.24.1687314762520;
        Tue, 20 Jun 2023 19:32:42 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090a0c4800b0025bc49aa716sm2228667pje.27.2023.06.20.19.32.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:32:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 00/12] bpf: Introduce bpf_mem_cache_free_rcu().
Date: Tue, 20 Jun 2023 19:32:26 -0700
Message-Id: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexei Starovoitov <ast@kernel.org>

Introduce bpf_mem_cache_free_rcu() that is similar to kfree_rcu except
the objects will go through an additional RCU tasks trace grace period
before being freed into slab.

Patches 1-8 - a bunch of prep work
Patch 9 - a patch from Paul that exports rcu_request_urgent_qs_task().
Patch 11 - the main bpf_mem_cache_free_rcu patch.
Patch 12 - use it in bpf_cpumask.

bpf_local_storage, bpf_obj_drop, qp-trie will be other users eventually.

With additional hack patch to htab that replaces bpf_mem_cache_free with bpf_mem_cache_free_rcu
the following are benchmark results:
- map_perf_test 4 8 16348 1000000
drops from 800k to 600k. Waiting for RCU GP makes objects cache cold.

- bench htab-mem -a -p 8
20% drop in performance and big increase in memory. From 3 Mbyte to 50 Mbyte. As expected.

- bench htab-mem -a -p 16 --use-case add_del_on_diff_cpu
Same performance and better memory consumption.
Before these patches this bench would OOM (with or without 'reuse after GP')
Patch 7 addresses the issue.

At the end the performance drop and additional memory consumption due to _rcu()
were expected and came out to be within reasonable margin.
Without Paul's patch 9 the memory consumption in 'bench htab-mem' is in Gbytes
which wouldn't be acceptable.

Patch 7 is a heuristic to address 'alloc on one cpu, free on another' issue.
It works well in practice. One can probably construct an artificial benchmark
to make heuristic ineffective, but we have to trade off performance, code complexity,
and memory consumption.

The life cycle of objects:
alloc: dequeue free_llist
free: enqeueu free_llist
free_llist above high watermark -> free_by_rcu_ttrace
free_rcu: enqueue free_by_rcu -> waiting_for_gp
after RCU GP waiting_for_gp -> free_by_rcu_ttrace
free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab

Alexei Starovoitov (11):
  bpf: Rename few bpf_mem_alloc fields.
  bpf: Simplify code of destroy_mem_alloc() with kmemdup().
  bpf: Let free_all() return the number of freed elements.
  bpf: Refactor alloc_bulk().
  bpf: Further refactor alloc_bulk().
  bpf: Optimize moving objects from free_by_rcu_ttrace to
    waiting_for_gp_ttrace.
  bpf: Add a hint to allocated objects.
  bpf: Allow reuse from waiting_for_gp_ttrace list.
  selftests/bpf: Improve test coverage of bpf_mem_alloc.
  bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
  bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.

Paul E. McKenney (1):
  rcu: Export rcu_request_urgent_qs_task()

 include/linux/bpf_mem_alloc.h                 |   2 +
 include/linux/rcutiny.h                       |   2 +
 include/linux/rcutree.h                       |   1 +
 kernel/bpf/cpumask.c                          |  20 +-
 kernel/bpf/memalloc.c                         | 299 +++++++++++++-----
 kernel/rcu/rcu.h                              |   2 -
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 7 files changed, 235 insertions(+), 93 deletions(-)

-- 
2.34.1



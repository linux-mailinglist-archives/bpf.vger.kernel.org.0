Return-Path: <bpf+bounces-3618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CDA7407DE
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD39C1C20B89
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 01:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912731847;
	Wed, 28 Jun 2023 01:56:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DF1376;
	Wed, 28 Jun 2023 01:56:40 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23ED297B;
	Tue, 27 Jun 2023 18:56:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-392116b8f31so3770108b6e.2;
        Tue, 27 Jun 2023 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917398; x=1690509398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOSuN8ZbTp+As1Q3NsXDGxXIwT+UbmTbeQ8ywUwVUzI=;
        b=NArEOmikC+/7HD3/g8jY2ckEp0gIRhEs4VG+tebC7uEZu17pDi6CwSF/3/5WNN0jmS
         629CPGp2mMkewxODYIuRiXRArj204iNgbRcqwv+JJ4v9J4Oz5A2lIy1Eb6Qz60cNjWvQ
         TJdOIUwIPyzkQxw65M1cAbGiPMDjueIC+/ZtbJAZQU+rcTXmLo/KIHbY8Si+u42wJ9xi
         aA8fWDPU00tSVbcFK8GwsStcHTdga67+cOoM6Qs6/UFeLEO4LPWP4FKWyZQFq/7FGJ0S
         1NIhwprvUUKBtPuC7gj6+3EClINfGarHtp+AHsxvYm/EB2H0wgxZusd24SIt0hRy2xZd
         YEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917398; x=1690509398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOSuN8ZbTp+As1Q3NsXDGxXIwT+UbmTbeQ8ywUwVUzI=;
        b=B0RSHMoDuz9mMfJpnpcVxhK88+jpCgAALqq/t4yfKN2NRIyEsAQYH5HS9KG//uQZfV
         EedaOxF6lnz/CeaWajt48LRAhNfL9GPz3gX5V3OJ/Ey3Db8TNKL8xxWukdn2JRVyKwWU
         ohWFwToFX9U9NauEye50Rpgf5CxBE5QyfBe8mLMUzNp/qO7hBwghybSPMXf1uXDANinC
         fnItsAzLymtEa9McUWWmvGy5AlIz3N+4toCBZrkIQDpE78mytFmvMMepf7mUPBItW9uU
         o4LFnU94027q4d7j9+/avvQyrlOa8vzjjKFxlftELD77P7xmKYQtB2soMiEFNphJ1ZoN
         5Zqw==
X-Gm-Message-State: AC+VfDwVC0XmKzMoyXqB4KOLmnjsaaWCboRPyGVu+z33/0HxbgIH7Ogk
	VW4cfNcb6Wcbo7yLTwwT1u6XNPCQB0g=
X-Google-Smtp-Source: ACHHUZ7k3WH15+uxGbnTtte5nnxLF77cGtA1Bssu4/LPjE/8AVVwGpfp3evzjEvVDIT7k4NKPQ2UTw==
X-Received: by 2002:a05:6808:16a6:b0:39e:c615:949f with SMTP id bb38-20020a05680816a600b0039ec615949fmr35407766oib.24.1687917397911;
        Tue, 27 Jun 2023 18:56:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id a8-20020aa780c8000000b00662610cf7a8sm6170737pfn.172.2023.06.27.18.56.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:56:37 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 00/13] bpf: Introduce bpf_mem_cache_free_rcu().
Date: Tue, 27 Jun 2023 18:56:21 -0700
Message-Id: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
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

v2->v3:
- dropped _tail optimization for free_by_rcu_ttrace
- new patch 5 to refactor inc/dec of c->active
- change 'draining' logic in patch 7
- add rcu_barrier in patch 12
- __llist_add-> llist_add(waiting_for_gp_ttrace) in patch 9 to fix race
- David's Ack in patch 13 and explanation that migrate_disable cannot be removed just yet.

v1->v2:
- Fixed race condition spotted by Hou. Patch 7.

v1:

Introduce bpf_mem_cache_free_rcu() that is similar to kfree_rcu except
the objects will go through an additional RCU tasks trace grace period
before being freed into slab.

Patches 1-9 - a bunch of prep work
Patch 10 - a patch from Paul that exports rcu_request_urgent_qs_task().
Patch 12 - the main bpf_mem_cache_free_rcu patch.
Patch 13 - use it in bpf_cpumask.

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
Patch 8 addresses the issue.

At the end the performance drop and additional memory consumption due to _rcu()
were expected and came out to be within reasonable margin.
Without Paul's patch 10 the memory consumption in 'bench htab-mem' is in Gbytes
which wouldn't be acceptable.

Patch 8 is a heuristic to address 'alloc on one cpu, free on another' issue.
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

Alexei Starovoitov (12):
  bpf: Rename few bpf_mem_alloc fields.
  bpf: Simplify code of destroy_mem_alloc() with kmemdup().
  bpf: Let free_all() return the number of freed elements.
  bpf: Refactor alloc_bulk().
  bpf: Factor out inc/dec of active flag into helpers.
  bpf: Further refactor alloc_bulk().
  bpf: Change bpf_mem_cache draining process.
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
 kernel/bpf/memalloc.c                         | 341 +++++++++++++-----
 kernel/rcu/rcu.h                              |   2 -
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 7 files changed, 261 insertions(+), 109 deletions(-)

-- 
2.34.1



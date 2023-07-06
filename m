Return-Path: <bpf+bounces-4150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B4749447
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6387C280FED
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173BEC2;
	Thu,  6 Jul 2023 03:34:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F2EA2;
	Thu,  6 Jul 2023 03:34:53 +0000 (UTC)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF121BD0;
	Wed,  5 Jul 2023 20:34:52 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3460b67fdd8so681615ab.0;
        Wed, 05 Jul 2023 20:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614491; x=1691206491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NwB6Ug6WAwdefYGLtF527p355Ymz3XEhfKG3HW84T9U=;
        b=qaDoI9A9gSnb6qmNun8xs+V4nHaT6soINMS+lwSSyeLkqMHtmjbCtHtKAY+wxRnKPM
         8PGYLDqVmleKuQbvfQ9ZfwDbi5Gq+F7Z5iaD1hn7OyPFjCtY6BKTUIBl308Lg8rfRY1t
         feI6OOfI4VgxG39Pjnp84aYmKAtO3fZhQyAd6YODJOLGaOzdMtXwCWr0VmKGLKThucWB
         kOeExixfKYrl9OdBuOotHWKtz2y+T5vWdZYC1f/Uft2lFAptApDMMVD2vRZ3JazbUbao
         VHu9fpNPNxPxONBuvt9gZMKnTwESAuDjpOLvh4uHaTl3hgF3w3qxyGqebts8wRuvV35I
         9jWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614491; x=1691206491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwB6Ug6WAwdefYGLtF527p355Ymz3XEhfKG3HW84T9U=;
        b=bjmNUOV4LMogEaauTxtVoEDp+tTivMOMel8ILQ+bAJA/Xl8RnGsdsydxrTkRufZjFk
         4c/UTiRHEEiEwRxPFtWEA2b6YhTWq0jL/OrJqNLZqS8GMI547+OhzcX2uh8QFzSJ8zra
         fVoJsq/H0y/s+vqeXV9LyQ4/6e/FZzzxzDHKxQ417PD+ZQHThiYlLJd2u68OZbDGMIMg
         ZwzIltGjUf5rAsWHtiHO/vWTarSDYHJfH/+2npTpcLEjCKcs0lJiB4W/B9uR5HfMp7/p
         6YQb7fQWUPJXQiUF6U+blayD1y3S8b3o77yiayDO+LxoIFLD4TIHGXIGGiW0F3EVBHWa
         fX8w==
X-Gm-Message-State: ABy/qLYFVekMvckRD/agzgE+JDpLBjHRbdVhxiWYNcdCZHCJw7DrbFis
	hdEa1W2tLd+564dtWBrVkjE=
X-Google-Smtp-Source: APBJJlGpMBy9xTDrmw8GVEAi27mRW376LELpUsrjD0rG7wyQxA7P6JqfNpvN7eTdWPqG/3iUuh9Heg==
X-Received: by 2002:a92:c84f:0:b0:345:8373:4ca8 with SMTP id b15-20020a92c84f000000b0034583734ca8mr301476ilq.27.1688614491031;
        Wed, 05 Jul 2023 20:34:51 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001b7f40a8959sm225542plb.76.2023.07.05.20.34.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:34:50 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 00/14] bpf: Introduce bpf_mem_cache_free_rcu().
Date: Wed,  5 Jul 2023 20:34:33 -0700
Message-Id: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
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

v3->v4:
- extra patch 14 from Hou to check for object leaks.
- fixed the race/leak in free_by_rcu_ttrace. Extra hunk in patch 8.
- added Acks and fixed typos.

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

Hou Tao (1):
  bpf: Add object leak check.

Paul E. McKenney (1):
  rcu: Export rcu_request_urgent_qs_task()

 include/linux/bpf_mem_alloc.h                 |   2 +
 include/linux/rcutiny.h                       |   2 +
 include/linux/rcutree.h                       |   1 +
 kernel/bpf/cpumask.c                          |  20 +-
 kernel/bpf/memalloc.c                         | 378 +++++++++++++-----
 kernel/rcu/rcu.h                              |   2 -
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 7 files changed, 298 insertions(+), 109 deletions(-)

-- 
2.34.1



Return-Path: <bpf+bounces-6155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1AB76632E
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DE3282642
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 04:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D38723AE;
	Fri, 28 Jul 2023 04:34:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B227148
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 04:34:18 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991392127
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 21:34:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58456435437so18107027b3.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 21:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690518856; x=1691123656;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=evhO+AjEg1SMd5ss0StJ/aj54KSk9FsWz8WvuuVoIFs=;
        b=Iw8pivXpTqxVUUKb/0ar8CUcLJqi7RiANKlRCzJYZZAZ/TVZkyInBwM7t0EKOHg2WF
         x/+A9kS7bPYlK/XfcMBj9Og41aA0UG+WPrWnoFpzBObZ/mJ7dJH+fXTzv/bnOI9QqkZf
         YhuXiFlqnKwUNDgrXFP8ohiP1lCdqcg+cK5pn1dK+usgwexzJFy7KU9+fSzZxWERsfZF
         fRI57hO4gtUi8aa7LxrV/CCcdmZXjChaj7zEjgDUhOk46xzyn0ZkVrQzbqrl03d92MOc
         C2HXxhe6BE8NkETQJ9th+wrSu2NTqlVZfaASqlU8OtWrFBQV9XG4YbzQV2hyguOJU7I+
         SecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690518856; x=1691123656;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evhO+AjEg1SMd5ss0StJ/aj54KSk9FsWz8WvuuVoIFs=;
        b=SmPHfHrUSOvWeiHV4tmrHyYzjKRfky4cokAlevBpBxKbgnMTvoqFIqzqtQVd+CID1s
         8+iN0i1YUVj9yPGf9hOZqHJSK7i7poBZ/IQ2U6pJvNF6/miVxTo36NQQKFHoDanvq1Xu
         5vo+1OyAdr14/aH8Xli5EonDgoF5Dvc6A8My2OfI1aaIm9wpTzLO7PPkUDRCAiWnPBR8
         izoeDP2WBsrdOU9+5KhPIJU1kJrE33KNaxhmZGC0CWR7gOMONuOTSNwrXvliAdl+u7B0
         7YDq5dqZ9OMCDapYgS1vQaW+yyl7a65Rrzr99eThKKI1sKENpGXRjobOm9861Ys08mLk
         27Ew==
X-Gm-Message-State: ABy/qLbgryaXeoXgSnDt8oeTCJ2+VUbgMsEZnx3c7Cg1X7FVeRfyrY1A
	aLzOPJYEGAnzB/YWsq/+MOVJEQX33Pt0N/6PzRc4JmQs0nuZncCczG52YyYVFK5fU998c65JbHY
	AF2varcsVC52nzMqfQ8R/AN5s8NVaFKfKLQSVuH+OwmCnixpHR1jWTLYP0L8IvQI=
X-Google-Smtp-Source: APBJJlFRSy+odkMnVRWfyTIDMNgE2QeG4/bctpRjf1Dk1cb3r+PjpRne0ISdRFjCKH36C5K/2Dg7rZE1AHxf9Q==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a25:2057:0:b0:c41:4696:e879 with SMTP id
 g84-20020a252057000000b00c414696e879mr3628ybg.7.1690518855354; Thu, 27 Jul
 2023 21:34:15 -0700 (PDT)
Date: Fri, 28 Jul 2023 04:33:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728043359.3324347-1-zhuyifei@google.com>
Subject: [PATCH v3 bpf-next] bpf/memalloc: Non-atomically allocate freelist
 during prefill
From: YiFei Zhu <zhuyifei@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao@huaweicloud.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In internal testing of test_maps, we sometimes observed failures like:
  test_maps: test_maps.c:173: void test_hashmap_percpu(unsigned int, void *):
    Assertion `bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0' failed.
where the errno is ENOMEM. After some troubleshooting and enabling
the warnings, we saw:
  [   91.304708] percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left
  [   91.304716] CPU: 51 PID: 24145 Comm: test_maps Kdump: loaded Tainted: G                 N 6.1.38-smp-DEV #7
  [   91.304719] Hardware name: Google Astoria/astoria, BIOS 0.20230627.0-0 06/27/2023
  [   91.304721] Call Trace:
  [   91.304724]  <TASK>
  [   91.304730]  [<ffffffffa7ef83b9>] dump_stack_lvl+0x59/0x88
  [   91.304737]  [<ffffffffa7ef83f8>] dump_stack+0x10/0x18
  [   91.304738]  [<ffffffffa75caa0c>] pcpu_alloc+0x6fc/0x870
  [   91.304741]  [<ffffffffa75ca302>] __alloc_percpu_gfp+0x12/0x20
  [   91.304743]  [<ffffffffa756785e>] alloc_bulk+0xde/0x1e0
  [   91.304746]  [<ffffffffa7566c02>] bpf_mem_alloc_init+0xd2/0x2f0
  [   91.304747]  [<ffffffffa7547c69>] htab_map_alloc+0x479/0x650
  [   91.304750]  [<ffffffffa751d6e0>] map_create+0x140/0x2e0
  [   91.304752]  [<ffffffffa751d413>] __sys_bpf+0x5a3/0x6c0
  [   91.304753]  [<ffffffffa751c3ec>] __x64_sys_bpf+0x1c/0x30
  [   91.304754]  [<ffffffffa7ef847a>] do_syscall_64+0x5a/0x80
  [   91.304756]  [<ffffffffa800009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

This makes sense, because in atomic context, percpu allocation would
not create new chunks; it would only create in non-atomic contexts.
And if during prefill all precpu chunks are full, -ENOMEM would
happen immediately upon next unit_alloc.

Prefill phase does not actually run in atomic context, so we can
use this fact to allocate non-atomically with GFP_KERNEL instead
of GFP_NOWAIT. This avoids the immediate -ENOMEM.

GFP_NOWAIT has to be used in unit_alloc when bpf program runs
in atomic context. Even if bpf program runs in non-atomic context,
in most cases, rcu read lock is enabled for the program so
GFP_NOWAIT is still needed. This is often also the case for
BPF_MAP_UPDATE_ELEM syscalls.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
v1->v2:
- Rebase from bpf to bpf-next
- Dropped second patch and edited commit message to include parts
  of original cover letter, and dropped Fixes tag

v2->v3:
- Clarified commit message
---
 kernel/bpf/memalloc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 14d9b1a9a4ca..9c49ae53deaf 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -201,12 +201,16 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
 }
 
 /* Mostly runs from irq_work except __init phase. */
-static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
+static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 {
 	struct mem_cgroup *memcg = NULL, *old_memcg;
+	gfp_t gfp;
 	void *obj;
 	int i;
 
+	gfp = __GFP_NOWARN | __GFP_ACCOUNT;
+	gfp |= atomic ? GFP_NOWAIT : GFP_KERNEL;
+
 	for (i = 0; i < cnt; i++) {
 		/*
 		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
@@ -238,7 +242,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 		 * will allocate from the current numa node which is what we
 		 * want here.
 		 */
-		obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
+		obj = __alloc(c, node, gfp);
 		if (!obj)
 			break;
 		add_obj_to_free_list(c, obj);
@@ -429,7 +433,7 @@ static void bpf_mem_refill(struct irq_work *work)
 		/* irq_work runs on this cpu and kmalloc will allocate
 		 * from the current numa node which is what we want here.
 		 */
-		alloc_bulk(c, c->batch, NUMA_NO_NODE);
+		alloc_bulk(c, c->batch, NUMA_NO_NODE, true);
 	else if (cnt > c->high_watermark)
 		free_bulk(c);
 
@@ -477,7 +481,7 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 	 * prog won't be doing more than 4 map_update_elem from
 	 * irq disabled region
 	 */
-	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
+	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
 }
 
 /* When size != 0 bpf_mem_cache for each cpu.
-- 
2.41.0.585.gd2178a4bd4-goog



Return-Path: <bpf+bounces-6103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C9765D14
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315401C21703
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84A1C9FF;
	Thu, 27 Jul 2023 20:18:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EA8F41
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 20:18:37 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC2213A
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 13:18:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704970148dso13808107b3.3
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690489115; x=1691093915;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y7e58S/AtdBWjwb7bMcUXohlkqNwdTadjMwtEKduWjs=;
        b=nT7ZOZHdZBR/0zR0p5yqXt14K+Cx9t+he2gr7I/FnU7Fuqt6lL5/+9lwo6BaAhhRbE
         FUrSJ81meOQx/OrtE49p/R30Lu50PKebfp0EUZ/zw3KNNHagkFE2BOyopUcK4EUwcFv2
         6WYAMdwVUqzW6tR2m2+mGLv6uSpDRVdwNQHO9WbsbkvKjwGhEdc5FfdZORTPaWk9SLh2
         7E6znRZbO+nVFFV0p9LND49xHD3YbVRYLW2aWJtppqf7jwooGdVnkmCaaudicpbNRfQl
         9hcWtOEZNXkM3eAS//D4s3RJNvLJ2Me4+pRXoUUpEBmz3iZ6SZPr1GDX1SlHZzFa215B
         0VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690489115; x=1691093915;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7e58S/AtdBWjwb7bMcUXohlkqNwdTadjMwtEKduWjs=;
        b=BcXMqiCRqazjM6GlC2HiKJGhbqf0+DXF/Lk9Btlg1GfWV6M+i04Um13y+KqYLPPO0X
         NPGQ7ctaRanTg0oGSsaVUQJJp3A4IPrs/VJWv9URm5pEt3UVrIPJqgAh5aqoyL4tzSpu
         JUpsd+RJiBAVlCdlN/zGICQDzLKl8L0/op83o5ki6UIRrw/vH9OqR/ZSSjbdJrvi7U1x
         GhZAdthFQWIuwmCplOhlpvDE5u5rrGgKjdxNBEBLfEWgXmiYXBWNX2pyGhysR8rTP8p8
         6Zrz8QJWig1JlmuU1BQAPjT1SNfbJAZxbAcF8Mw0wIVvlpT3lx0VaY0Y3yrtcUU8pOVk
         bDGA==
X-Gm-Message-State: ABy/qLbsJNH2nXaZn8ypC8x18JEquxLxqhRpUKh7IdeUOBe0Flmjpnmf
	zulUPgczwBNxVm2reUOmoRoHlHcL2vmOLNLJTgAZuHBCY8UyH2et34ZMrLrJhCE7a6ifZUpDe5Z
	mV0Dj0Hrghb5OXA8nQevSeSL1agEBNJPt+6KLO8lIVgcb8DGARSltxUzWshdyRo8=
X-Google-Smtp-Source: APBJJlEDk+CrgaBZVJ13HzGhMsw+LfRyKBSEhL49i9qNyJ5QmZWTuVAI65x6uyijmPLcQ0S1i6NnrLziw6A5zw==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a25:6903:0:b0:d0c:77a8:1f6b with SMTP id
 e3-20020a256903000000b00d0c77a81f6bmr2722ybc.10.1690489115079; Thu, 27 Jul
 2023 13:18:35 -0700 (PDT)
Date: Thu, 27 Jul 2023 20:18:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727201809.3232201-1-zhuyifei@google.com>
Subject: [PATCH v2 bpf-next] bpf/memalloc: Non-atomically allocate freelist
 during prefill
From: YiFei Zhu <zhuyifei@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao@huaweicloud.com>
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

Unfortunately unit_alloc runs in atomic context, even from map
item allocation in syscalls, due to rcu_read_lock, so we can't do
non-atomic workarounds in unit_alloc.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
v1->v2:
- Rebase from bpf to bpf-next
- Dropped second patch and edited commit message to include parts
  of original cover letter, and dropped Fixes tag
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



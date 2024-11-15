Return-Path: <bpf+bounces-44925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9069CD600
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 04:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F05B20E30
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 03:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACF81732;
	Fri, 15 Nov 2024 03:53:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC41C68F
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642797; cv=none; b=jpMqqUU46sByAFK7aSPQWWh6G2tXQy1vep9nlvGpE3J6CNEHpogSE/EztmcT5TAEMUsVO8TQCBzDk7YIUfruBmoH/BUFgh+eqgWJjtvC9bdWYOG3dueT5rD8pROuC3NXvht6dhN1uok/QkwxiqK1rIQvkTcewCuxYeNXlSWQZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642797; c=relaxed/simple;
	bh=c7idHWvzix1KdF8+P7iLuCmtdYY9aSmHp4MBexmrRO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWZlJsByD+YzyXmWRtaXuQC/MZprNP4UJR89tPFNhDrG75d976PxUqEl82bjAMLDZOd+YF3NIthYr3BIZQe+aXJrkljOyLQ93Ms1ExVADLR5gM2kSVwAKh60VRYy7qY3FuTqR9+RxxiXlDdT5OqWNpQDkd/0AORxJTShzgrYeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7A857B0E472C; Thu, 14 Nov 2024 19:52:57 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Add necessary migrate_{disable,enable} in bpf arena
Date: Thu, 14 Nov 2024 19:52:57 -0800
Message-ID: <20241115035257.2181074-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When running bpf selftest (./test_progs -j), the following warnings
showed up:

  $ ./test_progs -t arena_atomics
  ...
  BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u=
19:0/12501
  caller is bpf_mem_free+0x128/0x330
  ...
  Call Trace:
   <TASK>
   dump_stack_lvl
   check_preemption_disabled
   bpf_mem_free
   range_tree_destroy
   arena_map_free
   bpf_map_free_deferred
   process_scheduled_works
   ...

For selftests arena_htab and arena_list, similar smp_process_id() BUGs ar=
e
dumped, and the following are two stack trace:

   <TASK>
   dump_stack_lvl
   check_preemption_disabled
   bpf_mem_alloc
   range_tree_set
   arena_map_alloc
   map_create
   ...

   <TASK>
   dump_stack_lvl
   check_preemption_disabled
   bpf_mem_alloc
   range_tree_clear
   arena_vm_fault
   do_pte_missing
   handle_mm_fault
   do_user_addr_fault
   ...

Adding migrate_{disable,enable}() around related arena_*() calls can fix =
the issue.

Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it=
 in bpf arena")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/arena.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 3e1dfe349ced..9a55d18032a4 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -134,7 +134,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr=
 *attr)
 	INIT_LIST_HEAD(&arena->vma_list);
 	bpf_map_init_from_attr(&arena->map, attr);
 	range_tree_init(&arena->rt);
+	migrate_disable();
 	range_tree_set(&arena->rt, 0, attr->max_entries);
+	migrate_enable();
 	mutex_init(&arena->lock);
=20
 	return &arena->map;
@@ -185,7 +187,9 @@ static void arena_map_free(struct bpf_map *map)
 	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(aren=
a),
 				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, NULL);
 	free_vm_area(arena->kern_vm);
+	migrate_disable();
 	range_tree_destroy(&arena->rt);
+	migrate_enable();
 	bpf_map_area_free(arena);
 }
=20
@@ -276,7 +280,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf=
)
 		/* User space requested to segfault when page is not allocated by bpf =
prog */
 		return VM_FAULT_SIGSEGV;
=20
+	migrate_disable();
 	ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
+	migrate_enable();
 	if (ret)
 		return VM_FAULT_SIGSEGV;
=20
--=20
2.43.5



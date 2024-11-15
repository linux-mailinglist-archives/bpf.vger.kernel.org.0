Return-Path: <bpf+bounces-44930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ED19CD6CD
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 07:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A002E2832FD
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D81632E4;
	Fri, 15 Nov 2024 06:04:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334517C7C4
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650653; cv=none; b=QVKd79CD1p9vPRiLMYLtrzo2/qiozCgiRpwJLMl4lVepMeDmrcNqymjseNc6Y0z6u85kotBh4SknXYWZqMVeDsfzZGUwO2khwddePZjP1i1PXFJCstMIpgEgAiolR8hHvBJM3esgiswZuPDhLE+kjMRgOldJ/9zi879tFfvmMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650653; c=relaxed/simple;
	bh=m7rLgD+lNIBtAwSf90MrXmhkjD1aLDEhj8itsD4v8p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hm3aDGFXAjRTa3AhA8yJ3xfuhfaHP9nlNTKiQc3lcDxRl2zJKnw5l2ANRPF+8zbrzVaoAbI2dFUtjvhPKWfbLBpIbHpk4IiqZT5vDK6Cy0ccDjLdL2Wh/LqoplqE3lwQibxNSnCUR8yeCn52gerw2v9ug+XlNlqa8ej5d/lAmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D2848B0EF554; Thu, 14 Nov 2024 22:03:54 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2] bpf: Add necessary migrate_{disable,enable} in range_tree
Date: Thu, 14 Nov 2024 22:03:54 -0800
Message-ID: <20241115060354.2832495-1-yonghong.song@linux.dev>
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

Adding migrate_{disable,enable}() around related bpf_mem_{alloc,free}()
calls can fix the issue.

Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it=
 in bpf arena")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/range_tree.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index f7915ab0a6d3..5bdf9aadca3a 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -150,7 +150,9 @@ int range_tree_clear(struct range_tree *rt, u32 start=
, u32 len)
 			range_it_insert(rn, rt);
=20
 			/* Add a range */
+			migrate_disable();
 			new_rn =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
+			migrate_enable();
 			if (!new_rn)
 				return -ENOMEM;
 			new_rn->rn_start =3D last + 1;
@@ -170,7 +172,9 @@ int range_tree_clear(struct range_tree *rt, u32 start=
, u32 len)
 		} else {
 			/* in the middle of the clearing range */
 			range_it_remove(rn, rt);
+			migrate_disable();
 			bpf_mem_free(&bpf_global_ma, rn);
+			migrate_enable();
 		}
 	}
 	return 0;
@@ -223,7 +227,9 @@ int range_tree_set(struct range_tree *rt, u32 start, =
u32 len)
 		range_it_remove(right, rt);
 		left->rn_last =3D right->rn_last;
 		range_it_insert(left, rt);
+		migrate_disable();
 		bpf_mem_free(&bpf_global_ma, right);
+		migrate_enable();
 	} else if (left) {
 		/* Combine with the left range */
 		range_it_remove(left, rt);
@@ -235,7 +241,9 @@ int range_tree_set(struct range_tree *rt, u32 start, =
u32 len)
 		right->rn_start =3D start;
 		range_it_insert(right, rt);
 	} else {
+		migrate_disable();
 		left =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
+		migrate_enable();
 		if (!left)
 			return -ENOMEM;
 		left->rn_start =3D start;
@@ -251,7 +259,9 @@ void range_tree_destroy(struct range_tree *rt)
=20
 	while ((rn =3D range_it_iter_first(rt, 0, -1U))) {
 		range_it_remove(rn, rt);
+		migrate_disable();
 		bpf_mem_free(&bpf_global_ma, rn);
+		migrate_enable();
 	}
 }
=20
--=20
2.43.5



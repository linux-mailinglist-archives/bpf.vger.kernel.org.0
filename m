Return-Path: <bpf+bounces-28316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB128B84CB
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 06:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB201F228DC
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 04:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD26937165;
	Wed,  1 May 2024 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwuYsBUh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467B101CA
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537030; cv=none; b=a2n0KVcTRWhw1QfC84q81Po3Q8v/fwoB12Rg3zbIUdqQar1DvQ/inj+gF3prSM6DQAHpwFZwe7XtdfzVYdPUMWmlrCVMLpxH8Y49awq6zLsxDQ/34UPaVSLAFSvF5iUvNiUx7zPDj9E7NhZPGOa3lpKxrtMVjTF5tOc2N1ZfrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537030; c=relaxed/simple;
	bh=zW/R8msSZIIYaPl3izGD/ZyqnfyfTIx3G3LQBxDWVjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWAHyEhRZdylp38sJg61Vcq6K7hxsIi7Z4cziDoIoSNj2ryD9wjN5jV9tZWVYZYawLWgj1bnouWvflsi0QKiu5U0RXKcm1B0jeWrzZs+KTrY2rcEzi7STskVCMppaxEnHnvD+C2fdid290mS5gb0rXwC/9cyyMVOqHzzr3kXYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwuYsBUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FA2C113CC;
	Wed,  1 May 2024 04:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714537029;
	bh=zW/R8msSZIIYaPl3izGD/ZyqnfyfTIx3G3LQBxDWVjg=;
	h=From:To:Cc:Subject:Date:From;
	b=rwuYsBUhrSU6BHCgsTtCY8vhMyd7PrmUx/+aFRG31/tPgxGUidop1mc8mTWennyzH
	 /6jQf2qqGAzPQWVM4u2rCClveAbcDFrgcKHQvTCB0T6W5neuQ7B3D3BauFVuj6pxKM
	 mzOj69B3/Vrmelt9NS66Pd93k/32+hP5k1cnLUmb0HsWnKpdYE5H2CqaOH/h1OG3cH
	 qQekQsyo9PR2CG84Q+oYemqf1wLyj/j06v+V42YV6rtWDbiSbWX/aIGWVEYxBh6DvD
	 XHv/4kiDTHYbuZ8BOaa18CybsmITeXTAVOJf6XNnxfaRHjwuEGezOilN04VUAra95m
	 4qG+iKd4CTtnQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] libbpf: better fix for handling nulled-out struct_ops program
Date: Tue, 30 Apr 2024 21:17:06 -0700
Message-ID: <20240501041706.3712608-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous attempt to fix the handling of nulled-out (from skeleton)
struct_ops program is working well only if struct_ops program is defined
as non-autoloaded by default (i.e., has SEC("?struct_ops") annotation,
with question mark).

Unfortunately, that fix is incomplete due to how
bpf_object_adjust_struct_ops_autoload() is marking referenced or
non-referenced struct_ops program as autoloaded (or not). Because
bpf_object_adjust_struct_ops_autoload() is run after
bpf_map__init_kern_struct_ops() step, which sets program slot to NULL,
such programs won't be considered "referenced", and so its autoload
property won't be changed.

This all sounds convoluted and it is, but the desire is to have as
natural behavior (as far as struct_ops usage is concerned) as possible.

This fix is redoing the original fix but makes it work for
autoloaded-by-default struct_ops programs as well. We achieve this by
forcing prog->autoload to false if prog was declaratively set for some
struct_ops map, but then nulled-out from skeleton (programmatically).
This achieves desired effect of not autoloading it. If such program is
still referenced somewhere else (different struct_ops map or different
callback field), it will get its autoload property adjusted by
bpf_object_adjust_struct_ops_autoload() later.

We also fix selftest, which accidentally used SEC("?struct_ops")
annotation. It was meant to use autoload-by-default program from the
very beginning.

Fixes: f973fccd43d3 ("libbpf: handle nulled-out program in struct_ops correctly")
Cc: Kui-Feng Lee <thinker.li@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c                        | 37 +++++++++++++------
 .../selftests/bpf/progs/struct_ops_module.c   |  2 +-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7667671187e9..57a514eec49b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1128,6 +1128,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		const struct btf_type *mtype, *kern_mtype;
 		__u32 mtype_id, kern_mtype_id;
 		void *mdata, *kern_mdata;
+		struct bpf_program *prog;
 		__s64 msize, kern_msize;
 		__u32 moff, kern_moff;
 		__u32 kern_member_idx;
@@ -1145,19 +1146,35 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 
 		kern_member = find_member_by_name(kern_btf, kern_type, mname);
 		if (!kern_member) {
-			/* Skip all zeros or null fields if they are not
-			 * presented in the kernel BTF.
-			 */
-			if (libbpf_is_mem_zeroed(mdata, msize)) {
-				st_ops->progs[i] = NULL;
-				pr_info("struct_ops %s: member %s not found in kernel, skipping it as it's set to zero\n",
+			if (!libbpf_is_mem_zeroed(mdata, msize)) {
+				pr_warn("struct_ops init_kern %s: Cannot find member %s in kernel BTF\n",
 					map->name, mname);
-				continue;
+				return -ENOTSUP;
 			}
 
-			pr_warn("struct_ops init_kern %s: Cannot find member %s in kernel BTF\n",
+			prog = st_ops->progs[i];
+			if (prog) {
+				/* If we had declaratively set struct_ops callback, we need to
+				 * first validate that it's actually a struct_ops program.
+				 * And then force its autoload to false, because it doesn't have
+				 * a chance of succeeding from POV of the current struct_ops map.
+				 * If this program is still referenced somewhere else, though,
+				 * then bpf_object_adjust_struct_ops_autoload() will update its
+				 * autoload accordingly.
+				 */
+				if (!is_valid_st_ops_program(obj, prog)) {
+					pr_warn("struct_ops init_kern %s: member %s is declaratively assigned a non-struct_ops program\n",
+						map->name, mname);
+					return -EINVAL;
+				}
+				prog->autoload = false;
+				st_ops->progs[i] = NULL;
+			}
+
+			/* Skip all-zero/NULL fields if they are not present in the kernel BTF */
+			pr_info("struct_ops %s: member %s not found in kernel, skipping it as it's set to zero\n",
 				map->name, mname);
-			return -ENOTSUP;
+			continue;
 		}
 
 		kern_member_idx = kern_member - btf_members(kern_type);
@@ -1183,8 +1200,6 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		}
 
 		if (btf_is_ptr(mtype)) {
-			struct bpf_program *prog;
-
 			/* Update the value from the shadow type */
 			prog = *(void **)mdata;
 			st_ops->progs[i] = prog;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 40109be2b3ae..4c56d4a9d9f4 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -63,7 +63,7 @@ struct bpf_testmod_ops___zeroed {
 	int zeroed;
 };
 
-SEC("?struct_ops/test_3")
+SEC("struct_ops/test_3")
 int BPF_PROG(zeroed_op)
 {
 	return 1;
-- 
2.43.0



Return-Path: <bpf+bounces-19748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC812830D7D
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 20:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C651F26129
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59124A13;
	Wed, 17 Jan 2024 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFY47RIJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697824A0A
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521150; cv=none; b=NukcxJ+LMZXWP3W6Ix3Ejoy6r6MqChz+pUKehkz4MwwCKPUUZ3lyXd8iKBUny7IoDWCBzF089c3zMTjD+Ee57CrSWIjrZ03N3fmG+mcYs3Jq1+WsiONMAvv9b0fDAsB+tzRab6xFSLbAi7v2bmzJVquz62DrnY0yJnCVSNn4uA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521150; c=relaxed/simple;
	bh=CKj4WS3OBYxwgLDlZKDILeksf82FxX/temVWVwZinLM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=eFZ99OSqBq2lEwbN/AQXvsmTvtOq1Zwiwp1yX2nGq4WrhraXmAL487whzZpqyRuDqR/tL1lsM0hv5GOnTeOt5M0KVVGxush2K/ByBBwnAfS1HDpDS2+gPGUypSZr326fqmmps294VhhopCmGDv6hlIalGF+ZiSdMehmxPkhI+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFY47RIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C5BC433F1;
	Wed, 17 Jan 2024 19:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521149;
	bh=CKj4WS3OBYxwgLDlZKDILeksf82FxX/temVWVwZinLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFY47RIJbHIMysgNFke7RA1xZnN0/9JL9SMShiR/WgSN/pX4mcjR2ItpXgnPx0v5L
	 LKPNuGXdIzcD4R+G5BFJPbPirE5q2ynbzMd0yOVNBBdtJKYuhbHY9sSgo8q/n+JC1e
	 IM2IQkYQjo6ktetobfKVKXlTDZFV7gw0FZ20UrD75vIKj+uHTXN/7xyHf3UMgRlvG0
	 zYvJpwi1FCqwR+fy/8LG1oA8JRPK5KiONyd+FhFHClnRwU8BChj4cthXe0+v7kanti
	 3wH07kma2TxmfLIkNcNzGFo3DlooI7SJB40kaJiYeb66vVKTNoKf1bUTjRYEdW4iFM
	 UTPDoaGAFYdGA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 5/5] libbpf: warn on unexpected __arg_ctx type when rewriting BTF
Date: Wed, 17 Jan 2024 11:52:10 -0800
Message-Id: <20240117195210.739597-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117195210.739597-1-andrii@kernel.org>
References: <20240117195210.739597-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On kernel that don't support arg:ctx tag, before adjusting global
subprog BTF information to match kernel's expected canonical type names,
make sure that types used by user are meaningful, and if not, warn and
don't do BTF adjustments.

This is similar to checks that kernel performs, but narrower in scope,
as only a small subset of BPF program types can be accommodated by
libbpf using canonical type names.

Libbpf unconditionally allows `struct pt_regs *` for perf_event program
types, unlike kernel, which supports that conditionally on architecture.
This is done to keep things simple and not cause unnecessary false
positives. This seems like a minor and harmless deviation, which in
real-world programs will be caught by kernels with arg:ctx tag support
anyways. So KISS principle.

This logic is hard to test (especially on latest kernels), so manual
testing was performed instead. Libbpf emitted the following warning for
perf_event program with wrong context argument type:

  libbpf: prog 'arg_tag_ctx_perf': subprog 'subprog_ctx_tag' arg#0 is expected to be of `struct bpf_perf_event_data *` type

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 74 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4a266c475cb9..1be649070fe6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6695,6 +6695,66 @@ static struct {
 	/* all other program types don't have "named" context structs */
 };
 
+static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_program *prog,
+				     const char *subprog_name, int arg_idx,
+				     int arg_type_id, const char *ctx_name)
+{
+	const struct btf_type *t;
+	const char *tname;
+
+	/* check if existing parameter already matches verifier expectations */
+	t = skip_mods_and_typedefs(btf, arg_type_id, NULL);
+	if (!btf_is_ptr(t))
+		goto out_warn;
+
+	/* typedef bpf_user_pt_regs_t is a special PITA case, valid for kprobe
+	 * and perf_event programs, so check this case early on and forget
+	 * about it for subsequent checks
+	 */
+	while (btf_is_mod(t))
+		t = btf__type_by_id(btf, t->type);
+	if (btf_is_typedef(t) &&
+	    (prog->type == BPF_PROG_TYPE_KPROBE || prog->type == BPF_PROG_TYPE_PERF_EVENT)) {
+		tname = btf__str_by_offset(btf, t->name_off) ?: "<anon>";
+		if (strcmp(tname, "bpf_user_pt_regs_t") == 0)
+			return false; /* canonical type for kprobe/perf_event */
+	}
+
+	/* now we can ignore typedefs moving forward */
+	t = skip_mods_and_typedefs(btf, t->type, NULL);
+
+	/* if it's `void *`, definitely fix up BTF info */
+	if (btf_is_void(t))
+		return true;
+
+	/* if it's already proper canonical type, no need to fix up */
+	tname = btf__str_by_offset(btf, t->name_off) ?: "<anon>";
+	if (btf_is_struct(t) && strcmp(tname, ctx_name) == 0)
+		return false;
+
+	/* special cases */
+	switch (prog->type) {
+	case BPF_PROG_TYPE_KPROBE:
+	case BPF_PROG_TYPE_PERF_EVENT:
+		/* `struct pt_regs *` is expected, but we need to fix up */
+		if (btf_is_struct(t) && strcmp(tname, "pt_regs") == 0)
+			return true;
+		break;
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
+		/* allow u64* as ctx */
+		if (btf_is_int(t) && t->size == 8)
+			return true;
+		break;
+	default:
+	}
+
+out_warn:
+	pr_warn("prog '%s': subprog '%s' arg#%d is expected to be of `struct %s *` type\n",
+		prog->name, subprog_name, arg_idx, ctx_name);
+	return false;
+}
+
 static int clone_func_btf_info(struct btf *btf, int orig_fn_id, struct bpf_program *prog)
 {
 	int fn_id, fn_proto_id, ret_type_id, orig_proto_id;
@@ -6829,7 +6889,7 @@ static int probe_kern_arg_ctx_tag(void)
  */
 static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bpf_program *prog)
 {
-	const char *ctx_name = NULL, *ctx_tag = "arg:ctx";
+	const char *ctx_name = NULL, *ctx_tag = "arg:ctx", *fn_name;
 	struct bpf_func_info_min *func_rec;
 	struct btf_type *fn_t, *fn_proto_t;
 	struct btf *btf = obj->btf;
@@ -6909,15 +6969,11 @@ static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bpf_progra
 		if (arg_idx < 0 || arg_idx >= arg_cnt)
 			continue;
 
-		/* check if existing parameter already matches verifier expectations */
+		/* check if we should fix up argument type */
 		p = &btf_params(fn_proto_t)[arg_idx];
-		t = skip_mods_and_typedefs(btf, p->type, NULL);
-		if (btf_is_ptr(t) &&
-		    (t = skip_mods_and_typedefs(btf, t->type, NULL)) &&
-		    btf_is_struct(t) &&
-		    strcmp(btf__str_by_offset(btf, t->name_off), ctx_name) == 0) {
-			continue; /* no need for fix up */
-		}
+		fn_name = btf__str_by_offset(btf, fn_t->name_off) ?: "<anon>";
+		if (!need_func_arg_type_fixup(btf, prog, fn_name, arg_idx, p->type, ctx_name))
+			continue;
 
 		/* clone fn/fn_proto, unless we already did it for another arg */
 		if (func_rec->type_id == orig_fn_id) {
-- 
2.34.1



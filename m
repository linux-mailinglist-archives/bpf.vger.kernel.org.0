Return-Path: <bpf+bounces-77680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90075CEED1B
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB06F305223F
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012E24501B;
	Fri,  2 Jan 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dTd7xJ82"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C823D291
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366140; cv=none; b=owY6yzKNfaTTOmPvOp5uTLAKRRn+P8AS8Nkq3beCS/SP+X+5DjbnlMoBqE/rHxFkw9K7J9MNrH7BNmQZXWX565M3q0Au9ronSL0N5LceGFgudTN86n34EqxPb1iW14F1cmO901hv5LqElO691jhe6Wd34AfioL2wDlwBGUsZNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366140; c=relaxed/simple;
	bh=oBa469maWudsSL5hciWDODbQnyvM7WMptEAnoC2Jg2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj/hbxynjLAqBiJ3QpvFDw6cTBjsPVxeBCPfyOntseaSvb5HqPnsrO9DzJ7rZYNfbz23fNBxWT9zT509aUqrwhvV1CffrC7NfypZMUGEMgbQaI7BXxX4bhGiIdfRuyoqQGPHPOkmWXFQo9fc4YIYKE9Fpla6A6JEnxczHFN5W8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dTd7xJ82; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767366134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWoEF/+O4yZ7+ZS1SC3d02+me9C0QQC50vg1G2pDlFk=;
	b=dTd7xJ82NQ50raWJ1auBfjVAEwvFe1zNPFyY3dHzp/bG923whF4XKdS/DUgHQEvXkI3H+D
	2cu4C7PnzuE4zP0oxCJ+qzCDPlfxsgn1+i8mteiHNpH+MSZjsfbzjqr+Fwb8306pMkT6qV
	7dilcsPQzEAPjUodluMNHjnbf0UKuoQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 4/4] bpf, lib/test_bpf: Fix broken tailcall tests
Date: Fri,  2 Jan 2026 23:00:32 +0800
Message-ID: <20260102150032.53106-5-leon.hwang@linux.dev>
In-Reply-To: <20260102150032.53106-1-leon.hwang@linux.dev>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Update the tail call tests in test_bpf to work with the new tail call
optimization that requires:
  1. A valid used_maps array pointing to the prog array
  2. Precomputed tail call targets in array->ptrs[max_entries + index]

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 lib/test_bpf.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index af0041df2b72..680d34d46f19 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -15448,26 +15448,45 @@ static void __init destroy_tail_call_tests(struct bpf_array *progs)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(tail_call_tests); i++)
-		if (progs->ptrs[i])
-			bpf_prog_free(progs->ptrs[i]);
+	for (i = 0; i < ARRAY_SIZE(tail_call_tests); i++) {
+		struct bpf_prog *fp = progs->ptrs[i];
+
+		if (!fp)
+			continue;
+
+		/*
+		 * The used_maps points to fake maps that don't have
+		 * proper ops, so clear it before bpf_prog_free to avoid
+		 * bpf_free_used_maps trying to process it.
+		 */
+		kfree(fp->aux->used_maps);
+		fp->aux->used_maps = NULL;
+		fp->aux->used_map_cnt = 0;
+		bpf_prog_free(fp);
+	}
 	kfree(progs);
 }
 
 static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 {
+	int prologue_offset = bpf_arch_tail_call_prologue_offset();
 	int ntests = ARRAY_SIZE(tail_call_tests);
+	u32 max_entries = ntests + 1;
 	struct bpf_array *progs;
 	int which, err;
 
 	/* Allocate the table of programs to be used for tail calls */
-	progs = kzalloc(struct_size(progs, ptrs, ntests + 1), GFP_KERNEL);
+	progs = kzalloc(struct_size(progs, ptrs, max_entries * 2), GFP_KERNEL);
 	if (!progs)
 		goto out_nomem;
 
+	/* Set max_entries before JIT, as it's used in JIT */
+	progs->map.max_entries = max_entries;
+
 	/* Create all eBPF programs and populate the table */
 	for (which = 0; which < ntests; which++) {
 		struct tail_call_test *test = &tail_call_tests[which];
+		struct bpf_map *map = &progs->map;
 		struct bpf_prog *fp;
 		int len, i;
 
@@ -15487,10 +15506,16 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 		if (!fp)
 			goto out_nomem;
 
+		fp->aux->used_maps = kmalloc_array(1, sizeof(map), GFP_KERNEL);
+		if (!fp->aux->used_maps)
+			goto out_nomem;
+
 		fp->len = len;
 		fp->type = BPF_PROG_TYPE_SOCKET_FILTER;
 		fp->aux->stack_depth = test->stack_depth;
 		fp->aux->tail_call_reachable = test->has_tail_call;
+		fp->aux->used_maps[0] = map;
+		fp->aux->used_map_cnt = 1;
 		memcpy(fp->insnsi, test->insns, len * sizeof(struct bpf_insn));
 
 		/* Relocate runtime tail call offsets and addresses */
@@ -15548,6 +15573,10 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 				if ((long)__bpf_call_base + insn->imm != addr)
 					*insn = BPF_JMP_A(0); /* Skip: NOP */
 				break;
+
+			case BPF_JMP | BPF_TAIL_CALL:
+				insn->imm = 0;
+				break;
 			}
 		}
 
@@ -15555,11 +15584,11 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 		if (err)
 			goto out_err;
 
+		progs->ptrs[max_entries + which] = (void *) fp->bpf_func + prologue_offset;
 		progs->ptrs[which] = fp;
 	}
 
 	/* The last entry contains a NULL program pointer */
-	progs->map.max_entries = ntests + 1;
 	*pprogs = progs;
 	return 0;
 
-- 
2.52.0



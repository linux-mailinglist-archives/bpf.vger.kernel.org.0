Return-Path: <bpf+bounces-57396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8FAAA4B4
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A343A63D9
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFDA302A4E;
	Mon,  5 May 2025 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb+3iXLZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D7301A6D;
	Mon,  5 May 2025 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484014; cv=none; b=KZeAJqm3710XKyols08wsDysjb27nWbZDbUJAysJgvlq0baqVFipWy+tOa4SanSjUHK59ycbiaNNqsPAdXd31E+vtNFv8+b2zHtiJUBPdgB34zxUQcHHBOIXxV1fi77a+upy5zQd5zYOTjaLfo9dB/S0KCfach9aeEfL+tNPOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484014; c=relaxed/simple;
	bh=Sg740NCinBODe5OAdZjiDdMoUJxeX9MNjbl7CHpBcqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iw6imlyc0/EoIP76w96SmBbcweQyjHuYJr0xLRlVHusMq1vkEZv3YgTTEHy9HfbgSrgAponEuIcfRDDXQPSXVtB4WY19AX5UwvAMUkwf3IOYNtIaYr5/1pvVd1uh4145yiTcAHhjEpZGmlOjnK5JwUNQfeTVRDOkrlixiEY9MMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb+3iXLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FC3C4CEEF;
	Mon,  5 May 2025 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484014;
	bh=Sg740NCinBODe5OAdZjiDdMoUJxeX9MNjbl7CHpBcqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bb+3iXLZnfjGfue9oExBZuMHuZzwrmgRNST8h0eVDaCL4wrODLMDRWjUjr60+iuGV
	 HVtNL+nsBsSGzu4EwYm6G1C5L4agXPJkfl8a4IcxyUSljbcbKeKZgHOGFgqVscuHFR
	 Y7wr11Vew5w4GwlSldq687cga6+1XiTve+MKin8dxRiigdJGnRxjEK3xMGD/Xy/TQh
	 yZCoUtn4D3KsHXRzl9kAhTxqCFMpgEseoamD1mYsHIb7EpBuf0FTzOf32QCxE22V5y
	 AZetWpz8Q6KabLbh5ta57oyySV+tyb3B1H8DDi4K4YdaILmD+psJzwYdYWqrc2ijd/
	 0ghbnQTwYGlog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amery Hung <amery.hung@bytedance.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 318/642] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Mon,  5 May 2025 18:08:54 -0400
Message-Id: <20250505221419.2672473-318-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

[ Upstream commit d519594ee2445d7cd1ad51f4db4cee58f8213400 ]

Currently, add_kfunc_call() is only invoked once before the main
verification loop. Therefore, the verifier could not find the
bpf_kfunc_btf_tab of a new kfunc call which is not seen in user defined
struct_ops operators but introduced in gen_prologue or gen_epilogue
during do_misc_fixup(). Fix this by searching kfuncs in the patching
instruction buffer and add them to prog->aux->kfunc_tab.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20250225233545.285481-1-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db95b76f5c139..e2801472c0ae4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3206,6 +3206,21 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 	return res ? &res->func_model : NULL;
 }
 
+static int add_kfunc_in_insns(struct bpf_verifier_env *env,
+			      struct bpf_insn *insn, int cnt)
+{
+	int i, ret;
+
+	for (i = 0; i < cnt; i++, insn++) {
+		if (bpf_pseudo_kfunc_call(insn)) {
+			ret = add_kfunc_call(env, insn->imm, insn->off);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
@@ -20334,7 +20349,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
+	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
@@ -20363,6 +20378,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				return -ENOMEM;
 			env->prog = new_prog;
 			delta += cnt - 1;
+
+			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -20383,6 +20402,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 			env->prog = new_prog;
 			delta += cnt - 1;
+
+			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-- 
2.39.5



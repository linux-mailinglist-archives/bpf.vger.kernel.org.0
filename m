Return-Path: <bpf+bounces-78113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDBBCFE4D2
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEC8B300162F
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823EA34DCE4;
	Wed,  7 Jan 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="a43gj3jN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574EA34DB64
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796112; cv=none; b=WuOoX7RHTGYoBUSpxealkRXSwvm6sWtr2SZ+Fw4xv+F7eETasJVNNLiOF9qdBiz0rODJzp7g6FbEVpoDxTiCBD2YWOki3BwzXl6v+dNx7rgyh4Nq8kj+jdptJbgTbGvsfk97NehuS+nC0DH/A6aH/szenp7YC3XYIHXQUgi508U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796112; c=relaxed/simple;
	bh=9Nkg5+9yHPlpPwp9nF6PKpTxzXwCWPm/mZB+YcWF76s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3VpwDDmiLmTC+AGHaQ5Jj90G2gGpqJ9NVHuyzS4VbKwAzGlJ/q+N0t8dY3x/hASUXEM9VWc6++GwgWtfIymvtrIM2gWAFJneGDGe9bMZQc963r7aNR5I+R7lWPqbGaTxpo31ngdHMhL/35biBoxs3Fk6mmqLhh52D1b/Wo4nTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=a43gj3jN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso431144066b.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796107; x=1768400907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/14zXsBs003XOvy4U1i82NqonKMu3HQa+ln0OAs3us=;
        b=a43gj3jNdfdYSv4gSSQS1oeN9NV32Ra8DtqbY0X7Vsy4hETHQOptKzlRPAzSfW5C5J
         rqYsS0BxJUHewgw26mvVzXNfgt3thkrIKFG31h+4UcHp0Ls1o87201G4kq+71TWrRSCj
         Wza6WJePRH9B+7gbHGbP4RBHBxPJygffji6TbH3E+aCLGdSvmDw3pEjvPqstcFSVqY6h
         D74V3Nl52qyvee6ZS6NLG+eCYDQcevBW/Hexfq9k/4eAaSZ9Zb0ghbqGctCwyDpimU5t
         CdowmE8eB2zONDsAMfJNV0jtR/VcUcYa/eSBLfFdmGqd0GO3WPfm/MrxPXXnt/17q8M1
         Bt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796107; x=1768400907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/14zXsBs003XOvy4U1i82NqonKMu3HQa+ln0OAs3us=;
        b=sG+J6VyfolZ8O5AiUBCExy5n//sYPnXiMPWpI80DWkLR8Nqg4GkA9BZzszT5phNLt5
         bsW2MsqSfq/+1iHSeWozAIqT7WvMGbm1DrZPlgTXW2XED3z4a4FoGWXCD08NjHJzMXfl
         NEwH5E0XXfi5lQ2ie0JhQj+kXQY1wPWB/MkSLWzb9UM0bm3m+eF6pyycLw09Kih4mVd6
         7rVZpF8iouYuHe1sonSUa5csYkJNxfXH7P5vOzPoHTCkNPmJTVMY4G73QD17iw4fzFr8
         QSMuP6pirzSXyTmaYatYbmhe0f7V1zuJAXYGw4bSGjcDYJjFKttskjDJm83+mqQRO+um
         nECA==
X-Gm-Message-State: AOJu0YzQQ5EImWUUWqC6bWu0wY+F0v/pIFwXHHEAzp6zlXWbaEjv9o8V
	Vi7e6dnrwBXDsTKUzjMfVa+cuBK+BjTaUxRAv9SsZr2WbL6DcoEawoW7cr6JonRM2QA=
X-Gm-Gg: AY/fxX7HTV8NNkSJvotJTw+crW55DAuue/cDInO8j2uO+sZ9VClTckQiKlBPjppZrXn
	hCe02Z+EZx7tMav+oURV0DP2m/qASub6KPo2T0R7UelzRheM8uA4dlzT6ZNYrJXi6FT9a7d9wvp
	7BB+8K1ncQsbXHJqKRWN4E7GlvaOIou88OyRnGovYHBGyFluiTlsu3RyWfiKFCNorgaUqmSx7nm
	OEBBsCYMdIBPw2ww5llE/+CFv5I77qrFoDuojUgCE8Gmx625cIqzsRIv8/uJoYJKN9HJgaYo5QR
	vlFUjHZMZQX+MzwZk7v1IVBz4rP6DxD2EcaxwoTB3TGFooxb0iBHaOcCs/yiywaxwoRgckMeqOb
	pXtvZR4KBa772ojxI+vlH0nZWXPTsDg7fmXSN433ZnHKYiqJdWtL9iqfnspQ2Bj5TKp0FqFZHlS
	Xq+LVFKvDm+PiZAi4dckzjFALoQf0GqWbN4X+zMoRZwi3Yb3g9QM4R7zPnuOg=
X-Google-Smtp-Source: AGHT+IFuKBW87SwWKv45NowNyF6gDSC4dEqUaQmH0tDRwaae0GNWQln5Te3nVrJsyyGSAJHCYyWCOw==
X-Received: by 2002:a17:906:fe05:b0:b75:7b39:847a with SMTP id a640c23a62f3a-b8445216dccmr283429566b.60.1767796107483;
        Wed, 07 Jan 2026 06:28:27 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm527881766b.9.2026.01.07.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:27 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:15 +0100
Subject: [PATCH bpf-next v3 15/17] bpf, verifier: Support direct kernel
 calls in gen_prologue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-15-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare ground for the next patch to emit a call to a regular kernel
function, not a kfunc or a BPF helper, from the prologue generator using
BPF_EMIT_CALL.

These calls use offsets relative to __bpf_call_base and must bypass the
verifier's patch_call_imm fixup, which expects BPF helper IDs rather than
pre-resolved offsets.

Add a finalized_call flag to bpf_insn_aux_data to mark call instructions
with finalized offsets so the verifier can skip patch_call_imm fixup for
these calls.

As a follow-up, existing gen_prologue and gen_epilogue callbacks using
kfuncs can be converted to BPF_EMIT_CALL, removing the need for kfunc
resolution during prologue/epilogue generation.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 12 ++++++++++++
 net/core/filter.c            |  5 +++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b32ddf0f0ab3..9ccd56c04a45 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	bool finalized_call; /* call holds function offset relative to __bpf_base_call */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76f2befc8159..219e233cc4c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21816,6 +21816,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			env->prog = new_prog;
 			delta += cnt - 1;
 
+			/* gen_prologue emits function calls with target address
+			 * relative to __bpf_call_base. Skip patch_call_imm fixup.
+			 */
+			for (i = 0; i < cnt - 1; i++) {
+				if (bpf_helper_call(&env->prog->insnsi[i]))
+					env->insn_aux_data[i].finalized_call = true;
+			}
+
 			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
 			if (ret < 0)
 				return ret;
@@ -23422,6 +23430,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 patch_call_imm:
+		if (env->insn_aux_data[i + delta].finalized_call)
+			goto next_insn;
+
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
 		 * programs to call them, must be real in-kernel functions
@@ -23433,6 +23444,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 		insn->imm = fn->func - __bpf_call_base;
+		env->insn_aux_data[i + delta].finalized_call = true;
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
diff --git a/net/core/filter.c b/net/core/filter.c
index 07af2a94cc9a..e91d5a39e0a7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9080,10 +9080,11 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 7);
 
 	/* ret = bpf_skb_pull_data(skb, 0); */
+	BUILD_BUG_ON(!__same_type(btf_bpf_skb_pull_data,
+				  (u64 (*)(struct sk_buff *, u32))NULL));
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
-	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			       BPF_FUNC_skb_pull_data);
+	*insn++ = BPF_EMIT_CALL(bpf_skb_pull_data);
 	/* if (!ret)
 	 *      goto restore;
 	 * return TC_ACT_SHOT;

-- 
2.43.0



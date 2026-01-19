Return-Path: <bpf+bounces-79511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB8D3B7B7
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50F743039870
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C592E88BB;
	Mon, 19 Jan 2026 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dENHjkpD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F884283C89
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852443; cv=none; b=hOXNa7ze7H4gNTn5BiBRujGDDWOrYoqpYHepKRiUs44z5u+nTMVHarP76EaRHWm/Q6q++gfom/sPMgoCZKXiUD546lj372Lcqh/J6WLaD0nmWqPAHGsNTsoY+aVXb0SVzJEXQ7vPso3je+QDmOKeRPrV2vhI3+RPBQhoGO7CUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852443; c=relaxed/simple;
	bh=aR/cMzvmiH2dGYO5AY+gFo1ZHK2cA90zSq7Q8qDCPhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUp4vRy+/YPEHs4AirYnBk8RsnQge6su59W3LdBSbCHwJAE4P1PlikCUpWXainFsZe66puzmEI9PFPTTwwwylhefO7kGUY8m0gbhGNY+kyHFpuyaoHQ6GCpJgmzZqAZb/5DwKLavRntG2o5wdEAehbDfyP3kSzFFVoLwH8PgRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dENHjkpD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso7298917a12.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768852440; x=1769457240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUlfmKvuRwZKg/mPJdtvG12qGirJSsx4E2asdI/2pro=;
        b=dENHjkpDZ5TlsED1fyfmp8BVapdOkYSqAbDvamS5viJ14PQ1UPr99XaMb2ZkiyEKXC
         0VoMSQ1JOpoRMifL5vZKFKF+COZQmg52FXc0xswW6S6WSZ0eNxwgqXu4z2AmL1mIJbyu
         /+HrMiyEZEornpxGgyB1LGmar9ioH6C/jKMhrEvOBbf+Fc7IUL7LzK58cwlgax71Tf7R
         t7eneCCQDIFprvCjloHo39HBPIiAtUj+hxv3K74l1U8Rv5RmrCu15AbRsd292dt2efW9
         j2oRwMtOdAKDLrrGUq8ZAH3VJWuwbqwsdqFviLNO8IxBznjyMTqSJmyM/5p/os/r+EBh
         E9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852440; x=1769457240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cUlfmKvuRwZKg/mPJdtvG12qGirJSsx4E2asdI/2pro=;
        b=ESFwpCazb3V2s8CeeJ8roHHotyuQdeJ0nrfiWnHpCyh/OLlazudEE5AdSeQdTpSnNC
         TrSWgYgb0czRPMWeTHYs+fpWPuxw+wGFHdR2HiufpIrOAmOE2Ulzy3s7fFF0wU5QxRq2
         ToYe5Xd9zf6tKaWiGkGXP59s/+zban2Mv2sQ3W654m/YJSQbR3cyJW4msFLDrsG4OlTf
         zE/a5mYu6ehbTQcTGQ+8N8I9O3mC37P4iFIqIRKlUw8flsiscf1MZUMmPITys8wVBmqy
         ZL5IvRx4beaYymcvvfPgvESQNH6Qd0EpLQktIxlMWvSLJgiCUUlZybQSPsB1a4s0B01N
         Z3Jg==
X-Gm-Message-State: AOJu0Yy9X3z0RBi4AY130jdEhOZjF3Ix2gbP2PCOYWQgkHq0M/4mxrQo
	p8qqF9Sjo0uFxbi0YJvfElFwQ0y6NLCqZKF9Vqko95k9jRsyLJz1CfMWNqbdmxr1q1A=
X-Gm-Gg: AY/fxX7jRsa3iQHi+szbuEUMcGkGWtsRJY92j4OT+LtoudC+N9qZPIISb2HN/l7ms85
	RzxieGA8JQiFXUtON9nigqFC2F5256VFr6VdCGPlYvEzrM17Hh3n8r4YKp6WyR4tYtRJeBdy7/W
	8fI4KjtNZ8OZeGWrdYMohjAUvKoKHUBc/RmGLWwGIl65qIxVg3DU3D6HkpAXrFvHR8y/n/dZuhq
	sAyTTZswbjegNN8Ls9L0jaujQuUR3JYaco72b4Qjv+SBHfUvfJ8gdf8it03KhGzCuOhzYPvTRk+
	zktXwRqzu16cB+UDDLBEWiKVOmkisTaG60W89onpqCmdJF618rhqpM6JyPaJkOQHekaTi5FsdoS
	kpdH0ciuYeXKq/lSMGzLKZBaLJP1OGlhLFImJb1YNptU2jyssLz9TuiuY9IHF9+lbJDamFD/1tB
	2JOL3afDzBCn04sv3d8Omec8OGjtZar7wXyFf+LX+JIZM447FE5tVuE4IHfYM=
X-Received: by 2002:a17:907:e118:b0:b87:9e78:401a with SMTP id a640c23a62f3a-b879e7843a9mr653222966b.65.1768852439587;
        Mon, 19 Jan 2026 11:53:59 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9fbbsm1216427966b.38.2026.01.19.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:53:59 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 19 Jan 2026 20:53:53 +0100
Subject: [PATCH bpf-next 3/4] bpf: Remove kfunc support in prologue and
 epilogue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Remove add_kfunc_in_insns() and its call sites in convert_ctx_accesses().
This function was used to register kfuncs found in prologue and epilogue
instructions, but is no longer needed now that we use direct helper calls
via BPF_EMIT_CALL instead.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15694a40ca02..b04b63c9b777 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3453,21 +3453,6 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 	return res ? &res->func_model : NULL;
 }
 
-static int add_kfunc_in_insns(struct bpf_verifier_env *env,
-			      struct bpf_insn *insn, int cnt)
-{
-	int i, ret;
-
-	for (i = 0; i < cnt; i++, insn++) {
-		if (bpf_pseudo_kfunc_call(insn)) {
-			ret = add_kfunc_call(env, insn->imm, insn->off);
-			if (ret < 0)
-				return ret;
-		}
-	}
-	return 0;
-}
-
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
@@ -21823,7 +21808,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
+	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
@@ -21852,10 +21837,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				return -ENOMEM;
 			env->prog = new_prog;
 			delta += cnt - 1;
-
-			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
-			if (ret < 0)
-				return ret;
 		}
 	}
 
@@ -21877,10 +21858,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			env->prog = new_prog;
 			delta += cnt - 1;
 
-			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
-			if (ret < 0)
-				return ret;
-
 			mark_helper_calls_finalized(env, 0, cnt - 1);
 		}
 	}

-- 
2.43.0



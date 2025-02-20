Return-Path: <bpf+bounces-52094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2897A3E359
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 19:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D3142182D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E42163AA;
	Thu, 20 Feb 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmRnDhRg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7F215F52
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074707; cv=none; b=rG7x3/MUrGMVt/MgZbm1w7/7aGCp5U6OG2HLuJR3sJ7G2sgIpvIHA12Zzp2vJgHPUqJUg4i6tO5iTZCHYdCp/MhZuYsIfIhZuR3mVxGdSqz86/4cKCA9/zqJ/CyVMNBYr4gJ0EoFz552aT7JELMDW4D8BCAwsmMcEIgPucJvyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074707; c=relaxed/simple;
	bh=dFVl0mltdSI9xY7xCGyam++vCFk31r7Ci1vODvAyuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQkn6CQtgV7RkqD53muzbo7o3tgZE3KPs/yRDZG0SHUFHF06m3rTZL4/DmV0+y0n5U4QFjsoR/kDcTClLJcGALCzSLYTVJuhhpVdlOxAw2VzOLqOQGrIgtboCjrnkoQM0juGWqO+MndU3mRC4UuTT7sWY7TXslmF9ajKB6tIVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmRnDhRg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fcc940bb14so1908739a91.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 10:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740074705; x=1740679505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcNCf6nis9hu8Rc01mpWy+jatPgNBlLoDXeHiyrSKOQ=;
        b=jmRnDhRgm+E3rud2aGhFu7HdRKPbJpJftPqz6JlYohdALJIpi20UWuIMeGbCGhNg7n
         hgi6yel4rN2Nw1Js/gWZB2puMTu16uzZiWH6Z0vLe/q9DSzCuKu0DKYr6LDSlGSfgm3d
         mWDho2rGCF39DPb+Fp58UNUUml1vOh6M+617R8InRjjps3zfyRii+hFLFkcTIGYQuFWM
         pWgCRlz1fDTOduCORPqRMIYAEkXinQwfVF6H8t9h4EbwZFvCdHAq6QmKY3k6NwzXLOBt
         v0GSKY7Pd9XbDxfLv4JTOyjpDPu8K4FAruFTYYkZRERRkJBVo3ITaSvHeeduJHI9uJSJ
         jd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074705; x=1740679505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcNCf6nis9hu8Rc01mpWy+jatPgNBlLoDXeHiyrSKOQ=;
        b=cAcJ1YuVlEtfTGVe2oB+hNOLTLgAzJkgzcD5pL8swKGY3x3E9y4KgiAd/CP/bqSKeD
         J28jrzf3oIspkel0GF5w7En7SIEmK+HxQhYAYP7ac4tdYq8ZFAsc5JjUTc50li9FgOl9
         MNAF8luWQpLA2Lj+9qkFSG5eKsNCzIk7eoq3QDFstb4zFdcISqMFVJczh5n02UE+NlSe
         /+GJXVHGi1lPCVHtXSYZjrkSqSYu/K6YiA7x1ZUv6Nhxo7Xg4iioa2fvsdI9QsTM2+B2
         EpejbKVJ1pVjb+SbeatzjFF6GcBBs2H7DeSA78n4vUg0a/Rkrqmv/oCht5m2KyxFa7I9
         +YTA==
X-Gm-Message-State: AOJu0YzsTd6ATrcXw3JQ5Z3ZfQp7SL88K4PGv+I0JY8ENsha/QzopGV/
	gOSi7wPvNYPimdW29C/lqFfRkuU745sUfm26QbAbpWjE/sP/McqVPmbYwA==
X-Gm-Gg: ASbGnctY5cMoW+T22OmTdAi5UU738WoheAci5xWxLAR1aqUB0JkECpv1e5uwAVYieKT
	430OQdZouSlgeTfvj0HnW8HXCFnv6bp9jwgBTr91N0oh2EJqdSegue5sgFADh7fU4erHHxHiAXT
	wdeaMB+iiJPze7GqcPSxN9weGA1K3AhflNEVXneld2rnGsOTEKgoitwN4LecqLZt4Xuoy3ZwUJg
	4530WA9/kZ8FtU6Ynsq78RJVVCc6ZlxnYpgaYF58qaulK5v2/tkf/5deY9BjnD8XsmkAW++mbfG
	aE5gRwvMGDjOLfOQKhgatMiHwP15w5OVzKc5ly4F94zfqXH7Ep8BJbG+R2KuY3URdA==
X-Google-Smtp-Source: AGHT+IFqB35QulP8TjyEEBfdp7st8+hvG/ErrRflXwEbQHTWMIc9Srw8TUD9uGNVUzCSQuumLvmC1Q==
X-Received: by 2002:a17:90b:37c7:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-2fce76a26cfmr168392a91.7.1740074704635;
        Thu, 20 Feb 2025 10:05:04 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ba60c1sm14399682a91.44.2025.02.20.10.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:05:04 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Thu, 20 Feb 2025 10:04:54 -0800
Message-ID: <20250220180455.436748-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Currently, add_kfunc_call() is only invoked once before the main
verification loop. Therefore, the verifier could not find the
bpf_kfunc_btf_tab of a new kfunc call which is not seen in user defined
struct_ops operators but introduced in gen_prologue or gen_epilogue
during do_misc_fixup(). Fix this by searching kfuncs in the patching
instruction buffer and add them to prog->aux->kfunc_tab.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 85b2d4e65834..6cda6e16f853 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3215,6 +3215,21 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
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
@@ -20368,7 +20383,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
+	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
@@ -20397,6 +20412,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				return -ENOMEM;
 			env->prog = new_prog;
 			delta += cnt - 1;
+
+			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -20417,6 +20436,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 			env->prog = new_prog;
 			delta += cnt - 1;
+
+			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-- 
2.47.1



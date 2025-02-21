Return-Path: <bpf+bounces-52201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D877A3FC26
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8627E3BE675
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB65D1F541E;
	Fri, 21 Feb 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2+e1Mhf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3F1F236B
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156453; cv=none; b=rHRKx14FPBPd1CtyfvcqZfcOJCEmtdbZ+2RwSaezgPXKu4/LrY4pH9tPvyu6j4ZVeiD3ef2GQo2DD9neQtczfjkwtPkrn6IZojBk35Kfw0RMxibPrn622UTZyrmXv+kjZPPiN25tIdyMdLZyaKLmoWqHmI0GJS1zjaHMjZJpIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156453; c=relaxed/simple;
	bh=ZvHiGs57O+ZNc4XNRWrUmxzgbX/+zlzXCHH5PrO+Pfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3y2uPDhzKmXAkX9c+cfZr4FkfkYlJkvSwkkpOp41I35OH0w3igMeDqCIDwQPrnCI94F8sTD16541HA5I990dVAz/Cwkd0t3xYBNsEs3Dzw81xea8+Q6AcTv9pZarGN4NeVxiv8NubRXUFrNQgyjLcjjjun1SOS2+4l+hfBzfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2+e1Mhf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c2a87378so41426235ad.1
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 08:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740156451; x=1740761251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4io0qf3sA2xS38ydPazBKeEFiCv0/bEMBmTD9p8Tbg=;
        b=F2+e1Mhfhlg0f8pVQennZuxMcOx0e/JLw9xkaa8jqADpn4ofoh0pP0SEDpaYkLHIcf
         5Db/Ett9aM9qROgYzZNSri5OvhGr59/yo6Bks2yxmCuzKmPO9BAv7Mt5cH0mXORfpnKE
         rSI0FIoBohKjmNmh6AGQ7dz1s0gk7RgjC718Q34epXIiJWaatr+GB0aZnsrF16UxVIky
         F+Zus0Rc7hPGhjlUmt8TXiLgCQLpFGTUp8hjUW+Y9yreVVYMdHHajcvSLHMJ78AfQJce
         uYeqbzstWMaaNhByIEJzjknlZ1TTVtkkprTEx1hOmN59KzLqH/43QRAHuKn5IlsV5kve
         eJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156451; x=1740761251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4io0qf3sA2xS38ydPazBKeEFiCv0/bEMBmTD9p8Tbg=;
        b=bb7DBZy13UWPyJdWf5kDcdbX39ras+tcl+D5AkbcTUDK+q/KVIeeIwKAfcFKk4b5jl
         H17kof5wiv6Y2QzjjsdW02WNk4bfrLr22qeipoKEJ2m1UnCBs/tzCSxNPmB1KZuWLodW
         qRRmNtNntOZv9WEdaxXk7QCRGNtwsIoRxNDOAWhAuN5gcYzQ1bxk/WyTW2QkqnyqxkoW
         ADT0i64pAz60LHrJJ4qajPOn0j7wiRVc4gc1Nwkv6D/GhPMeHbzJRg+F65mSdrGkwyXB
         NNcp+AX9vAejego1zbsJr5BtImjrn7Adm5OXgguH5AgqQVFx55ardRmFUO0kYc1AvF3n
         cbDA==
X-Gm-Message-State: AOJu0YxEDhO4mb6KEwo9XSSt3YJ3fDnZ7zNKA0mrAAfccXdSgOKJU6m+
	ttaDXYjSB7p/TGhZXUQjLbB1PXASKEuqfyUQQ1BwFRsRY5o1dteRPbE8IA==
X-Gm-Gg: ASbGncsT5zHiLOhCwVfHeUP/K07vFqGG6UbY481lLvmbvYhXnBhNLonPyfuRFi3SxXm
	UAU2VqbXx4DRpMO8kv3z4G4LEAx8k/ywBkTxHoc8pMnVMWI+pPYErIRACcLbFkzQKh0o73cKgau
	XOr+IUwSfQQogaI0FPPycoWm0S8YmP4OzHnybL8NsEbs+rEP1UDHdTvker26ugilllKUoDMZ90a
	9utpLnf31cxtYnF1aWH1T4177jWT+bDqFSJoQ67ce8ED1gAFXHpJMJG79jX0SB0iBbImkrcEfCk
	9tTA5ImW/gKlUNnVm/u2iFiQF2D2iXiSsvYgbiNSM5+UWJdDM619sVsvGQedCWCf5s4uEB/yCmM
	f
X-Google-Smtp-Source: AGHT+IH02UeqVXWWMmvcyBjX4iXDzdFifKXN2Q0WwrDHMbAkbLhsBhng11wnGb4Bz8obifY2eYLnPw==
X-Received: by 2002:a17:902:d4d2:b0:21f:4b63:d5c3 with SMTP id d9443c01a7336-221a0edbfa5mr55390645ad.12.1740156451129;
        Fri, 21 Feb 2025 08:47:31 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2210001ea01sm110875785ad.176.2025.02.21.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:47:30 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/2] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Fri, 21 Feb 2025 08:47:20 -0800
Message-ID: <20250221164721.1794729-1-ameryhung@gmail.com>
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
index 8f1df279e432..212b487fd39d 100644
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



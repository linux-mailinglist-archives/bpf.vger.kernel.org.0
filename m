Return-Path: <bpf+bounces-70480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1358BBFFA1
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 03:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 668CD34BD2A
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 01:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBBD1E0DE3;
	Tue,  7 Oct 2025 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAXQcOOU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCCA1CCEE0
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801399; cv=none; b=ds5DJjzYc+FXPhFKlQqh+nUUrIdI5pQgmyrl4Ie+kRadQPHaIV3FEcs6UJ82b5AyoOrfwBmq2lwmIbZXEt/vRjiH+ekY2glPvdd5tS9pNWaK3f7JbsEzUIE/o8i8A0tUieURQW07CCUkZRTWCre5u0eoSkoCbxA6LbjviFKzbPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801399; c=relaxed/simple;
	bh=E7KT1OX7LhXM5/taJfQXeIKjbFsQoG3WVbquYA/wU0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU6dC5Uok4oTcLJFF2rPdh0APq35odL22ebasmBxHi0SqWlvfyprt+tmF78TTFBxl5Tuh/Cp3JZpPsN37tWEOtlRNHQweCk6eFS3DHEqwkcccVmd3bgZwX7Zs9yyC80ejVGxsUevP+X2YhqVMsFF8Mr+w/hf43XoJak1DP4qKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAXQcOOU; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b3b27b50090so1049043966b.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 18:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759801395; x=1760406195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pR8kwpfqese5uhHS7IuRyPe1Fm36kzk/g7qgF6+2vZk=;
        b=LAXQcOOUhTBG/I6kl0DhH3NG/PJPPnMqiPgEbRTvc8zb09udpFQ4s5sjYB6g40Gmj5
         zVryCltAjm7nfELsgKyRc+wc7oge8P0Z9V6gTSKy3joS+EazxVZSFoVABQdiakTDZa1N
         bPMG2Y0APZ8X5fpeiGkv739PrcD43t0SWr4A/21z66jaFGY1rf+leUecAIGX2Ud0UXSN
         N2LbeaNPiaEVzRUHuoR7ODxtxWfg3tSlQYJjo8Lal3mhcKkFbx1yZ+mVC2hyDLW+tGLd
         UFCL+VILg93XTfL+g75w8H9vNDqv06+plVllCTx0eRuZtcgiAgT5RzLbpArEEW0zCGtW
         oo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759801395; x=1760406195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pR8kwpfqese5uhHS7IuRyPe1Fm36kzk/g7qgF6+2vZk=;
        b=hpbFVWu5BxdXCcl68qbteASqURQDHDjNUBo068q85+L6HBl0ikI23gMzTYkSJ78wSi
         FE6aUAfxO7Vx4rXbR8HXa029PP0NQ9WimVYTtxvaPqBf2d3vjPNbQQ1ZNasj/WyOUtx0
         yWHJhdaHlljWI8Sprkbw8qGRvaomgg7itkRkmQaDT1TVaWV50il7bnv7cSBBkGKeycab
         UEEbURJ9RCyF/1STCEvJ76uBUXKBZBCrKOsR9cciuUoCRteXNUtoboYb868rRhuAFnGU
         WU1xHc0zzChogr2aDn5maGhtv1yL7vb6gF5kVvSatM36wdR2sEekTqNvDbctb5q1Q5zP
         SmJA==
X-Gm-Message-State: AOJu0YyInjkN8fGplhpL4A334NOaSd26xp4rIXmn4b2R1D7ceUPFHGHe
	lou7QDcR2PA7GOTXrho3DY9P6mo4esus2qYZMlOhrxGyVxfnSFx4oLDGLv14TSgK
X-Gm-Gg: ASbGncs8Ej2pjgU/SqMxzpRCguqaxAuVgbOm/5ApF9Q68hDJS23nY4k76c3amlJvOih
	2J2g+kxYvegxbOJAug1J6epQcLry8n6VxbKDKPCWwZ+epsnTzMDTcCS95HH16x05sj1gzZ3Rl13
	0XoZtGzjMuDX8yvfnTvYI67suSqd+yCKUDlJE2Y4sKCJVBLUSnj+Mnz/L89IFNy65KKrKqm2FXV
	z0u4pZrRPGgmfVgdjfyeDP4lkGJ/bUB0xo5mxswQPs4LdtAFOU8wuuMYYQy2+Uf2A2Fli6Cnjov
	wVk8WuQgmPWNXJmBF7xsZGaZRzW25CNOjL343xY5hAjSOLZIB0KIBy1Sp1+fqvIvIrw9NjiBa5q
	8rAwq553l+pjpluqsJuf87+AU7ECJQVnkV6vj1/82M6lfIjGaFSZw3LgDbfi5hMMIEx+Zwniuai
	0nCgTHj5f5Bsepv2BFVq+RnHWx
X-Google-Smtp-Source: AGHT+IFwY4hsgLDyVMl+ZiIWtGYr5Gpg0Qn7p2pde86IeKASAnZKRESy49eGBxj1y0muPhwNH0/zTA==
X-Received: by 2002:a17:906:d542:b0:b48:44bc:44d5 with SMTP id a640c23a62f3a-b49c407909cmr1790271666b.43.1759801394481;
        Mon, 06 Oct 2025 18:43:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b4869c4f314sm1254896766b.69.2025.10.06.18.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 18:43:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] bpf: Fix GFP flags for non-sleepable async callbacks
Date: Tue,  7 Oct 2025 01:43:09 +0000
Message-ID: <20251007014310.2889183-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007014310.2889183-1-memxor@gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3289; i=memxor@gmail.com; h=from:subject; bh=E7KT1OX7LhXM5/taJfQXeIKjbFsQoG3WVbquYA/wU0w=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBo5HAZkkSIS9b4rjBtJJ62isr98uC7j0FeGc374 E2tMLgSxaWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaORwGQAKCRBM4MiGSL8R yiuJEACvRcIPW5LVWzHDZXvmxF6JYvawwox8mDDg6qiLs5Xqgq54Ykl3LBHENEaNav+xBNZ4p1d TPZj3pdl1s365aNKhqBxylG/hiW+Qv5OSOKS09QedRTDWBZMUZAmh0S4Gp+yOUu4ZLYl6kmPCjT wbiiQuFPh6bvQZnUlQ4OQ2egkPgChgdjLlO/mIkq14FDSM0agdsL3a9999ikWM5fEfQzsmLzrQZ c8BYzmkm29cdCrtvLZQrPRqj0VVqad99GeKVmYGFY5vbfhE1yrI+ulFjHyfB22j/mBjILClIBe8 DXiqpGupfazJhttmW/kbuKeH8HfzZRaKr0n/UrOPXpzNxV5XigB6r83fcgO4dh+xAAta7T3GUEH b+4Mqp4KG71haUAx33sBzvqZK7xBV+5TPuqlZ7sX1w9gJt9S6AR2z5fcN/3ReXjzflrEwI17zpd 3te+kMg2hte1TG/GSVHGz98jhh5u+NY3srYbRCMAyjWe7mp2tgPueHB8eS9+aIFcETEaaozPhfC J/0gboStLB/InZJSY9I8cBTfrp7vDi3l8VwK1BRm2ZXl4Q/grreQP4ChCM29TdzwU/J7qKEqJB6 7Fu/lbahGF/EuSrKn5cjPbBgwp84YgZHNzt5sYOWWHY8vFibAVUGVPpULtFMEiOMuNG7cqJokwl cD3cUwl53Hzmlyw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Fix storage_get helpers to use GFP_ATOMIC when called from non-sleepable
contexts within sleepable programs, such as bpf_timer callbacks.
Currently, the check in do_misc_fixups assumes that env->prog->sleepable,
previously in_sleepable(env) which only resolved to this check before
last commit, holds across the program's execution, but that is not true.
Instead, the func_atomic bit must be set whenever we see the function
being called in an atomic context. Previously, this is being done when
the helper is invoked in atomic contexts in sleepable programs, we can
simply just set the value to true without doing an in_sleepable() check.

We must also do a standalone in_sleepable() check to handle cases where
the async callback itself is armed from a sleepable program, but is
itself non-sleepable (e.g., timer callback) and invokes such a helper,
thus needing the func_atomic bit to be true for the said call.

Adjust do_misc_fixups() to drop any checks regarding sleepable nature of
the program, and just depend on the func_atomic bit to decide which GFP
flag to pass.

Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eff81ad182c8..32123c4b041a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11438,7 +11438,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (in_sleepable(env) && is_storage_get_function(func_id))
+		if (is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
@@ -11449,7 +11449,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (in_sleepable(env) && is_storage_get_function(func_id))
+		if (is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
@@ -11460,10 +11460,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 
-		if (in_sleepable(env) && is_storage_get_function(func_id))
+		if (is_storage_get_function(func_id))
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
+	/*
+	 * Non-sleepable contexts in sleepable programs (e.g., timer callbacks)
+	 * are atomic and must use GFP_ATOMIC for storage_get helpers.
+	 */
+	if (!in_sleepable(env) && is_storage_get_function(func_id))
+		env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
+
 	meta.func_id = func_id;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -22495,8 +22502,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (is_storage_get_function(insn->imm)) {
-			if (!env->prog->sleepable ||
-			    env->insn_aux_data[i + delta].storage_get_func_atomic)
+			if (env->insn_aux_data[i + delta].storage_get_func_atomic)
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 			else
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
-- 
2.51.0



Return-Path: <bpf+bounces-52571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150B1A44EE8
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6D9167605
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C02135AA;
	Tue, 25 Feb 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPkWTXCz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53849213235
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518964; cv=none; b=dH4ZCH/9/xggmAKBW0ug7tvALwY+9AsBvGyXGZoGFridagr2vmv+LS+wWkJv3MlHqW08e4KwssAzMJqrYLnkYPdF06vFeXUL8X+XwY7+7eOxVruXFPFs0AyjUAa6rsy1sl/giGb5fxw1N+DEE7qVbbhgi4J5samO2Vl8PcXYbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518964; c=relaxed/simple;
	bh=ZvHiGs57O+ZNc4XNRWrUmxzgbX/+zlzXCHH5PrO+Pfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKRViRMpHMAjKPwAcdB/ISO3/h0xJllXk3PZ1Q6ZwwiLMW3+kH/2riMxt3nlWjbuuiZS9hUCWM+mrIZ6g/8nw3eQVdU2SMKV0LcO+2PCdGq3xjKo6i7DZSicZflUt2BL3FGuWHbbesmXDRK2VCYXGhe80ttzTDKL4tKvZmpROos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPkWTXCz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d398bea9so98518495ad.3
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 13:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740518962; x=1741123762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4io0qf3sA2xS38ydPazBKeEFiCv0/bEMBmTD9p8Tbg=;
        b=WPkWTXCzTWpf1S6rbibkU9nyAdIqZFV1jpoOG7g4dVEMjf73pjlhrJm607lqYpCj4/
         Tv+4O4q6DEHzufIxWExjkvfgdR+X/wHOHhBuMzbtUtBZHIT9DloPqooMU8NxjpVutmLS
         /GtC+SSY6bsOG1DmDdm/nRfNfB2+1A96Fu5hVtXkBFne+Mych7yDXF0QSqtbr/nZPx1M
         C5t7YYSFs2hQ3+JTMGSKsy7ssmRwp2A6em+NHhgUHgDGmKFmaakLf+lJ3pOCd65DP8TV
         Q5NDepLFdOPRbPzZx/yic+MJHMrYS0X5h62Vi326Z+K9YBQBQZgbRXxeHd+zsiSvqE2L
         jStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518962; x=1741123762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4io0qf3sA2xS38ydPazBKeEFiCv0/bEMBmTD9p8Tbg=;
        b=r9vfdTZTFlw46yUj2pCDclFIDWxYf7QjVwX+fNyLYunZCJWPApdtAjwcbX94CcAw4G
         v/V+HVt5EZVtKFGTEJfvIOCRAv0gGenYRBQAflewPy0U/FeS6nJAASklR7F+pVBeGNwR
         ghYmsMa+Tx0t7pCA65V44Oac8jCXkvD+xH887GSczfD+soIOA24zLnOikibR8BPUiUbr
         qai/hLoQdEDayJ10qBJNTaLmZp0CE+Tp8crrakLa9Q7NG4h+MTJrAHHqmCOIiFWWA7Lj
         pUqVb7XEJgX6bHh7Mf+gzEZwIYdxvKpaCo2uErJoJqv7S2Vaz6E1gjO0QJ8QWRzFcAjz
         1Tug==
X-Gm-Message-State: AOJu0Yzajooikgzg9A8B5/jTi9ZML6kM2QIEH+FqNmPpvV5KBGyUm9BS
	JKzVVxo0WLep6EC+GyeEldLf8PkxjZE0BwCkuKK/TqnilhV+53huv2yqVA==
X-Gm-Gg: ASbGnct54HcKav6CxL0Ea1W7ZAzN9i6sKxQglnN7CFgANz5eL+RWP7/mYRIAVWLgWA1
	+EPJRGY7CYyGvFPcn2/UNmBMjnPWGLP7g+EoJbTNhaNrYGQqqMkzeH+WWN3gYqdvmD5m4gUEMWY
	/+q+dXoJLq6284T8/iFKVEOoiK7Pa9hkt0jWYvMg8tJmuy0vZDLvX2GmIRcC786uic5wRK/Gq3w
	7wYJ+VWZucBEVcJejtC0E4BH5sl66c/tMIJmBnOsdu6MuoXqns7LjwUXRbzWFySxzr6qRIHGiyL
	8ywRMzYj/FwLsZu0Fi7XTKioEeVIE+zorSjr267NHDjyuac3Jb4/T7OpfAKAsoTvsGsL0AQAolM
	b
X-Google-Smtp-Source: AGHT+IE5jdJmjLMRD+ULlsjIsP+B0dZ3u8e8pirmaeYlhmwY9qSxSs3AF7dm3m1uuDfg5kdQF8SuUQ==
X-Received: by 2002:a17:902:ea10:b0:21f:9c7:2d2e with SMTP id d9443c01a7336-221a1191916mr332271745ad.40.1740518962144;
        Tue, 25 Feb 2025 13:29:22 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0004a2sm18989355ad.26.2025.02.25.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:29:21 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/2] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Tue, 25 Feb 2025 13:29:14 -0800
Message-ID: <20250225212915.145949-1-ameryhung@gmail.com>
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



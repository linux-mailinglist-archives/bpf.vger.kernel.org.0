Return-Path: <bpf+bounces-50231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCEFA24353
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694B5188AB8C
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77D71369BB;
	Fri, 31 Jan 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEiU9z1c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E31F4280;
	Fri, 31 Jan 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351775; cv=none; b=aDyIcNBVXL/20+tb0oda4ty6l+eC0mDJNbJcOtgoI9tjxWN/acf7HpLA14teZTSBBMxxoXs/YzOl+EqHQS+MLTFpRG798bMX5b7ZNZj19sjQlTvH3USii39vkDeUnnvVonCULdqxUzmcJUjBwiTN0LgPtX0U8xrCm2eyhqjdJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351775; c=relaxed/simple;
	bh=yxQYFsT9AePiAzQhyVc7xoKjhDpHjJ27Ru0+BglOpZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXsVSdQykV/WiB4PtX3OiCFO0EGnJmGhK083gQHdZcC8e49RxG2s6vzv4E3V5Rh/rMGOmwMu6q/bpsWuVJSHNCIZnhEIEZywYXd5FMKyeN8CyqE4GAz0r+hieoFpu/m5tjnDz8uM+NNxIJ4FTQ5oqWuf6GXvbt4pn/xQWTcFsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEiU9z1c; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso3234331a91.1;
        Fri, 31 Jan 2025 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351773; x=1738956573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDXRG+l+8UkDA8rcyi4Z/G13+60E1Jk+sSAlFlqGB+E=;
        b=lEiU9z1cPbgr/WexfYh2rsIwyBSYpAFun+lmozKvwqhJSPciC94lFlAGdyhSaq5lgv
         Um4mIXwqLq0MtIjykdar/bFAwLHQLAJSGrexlNA7J5xbq9gEPz1ZFvi3iJQNRdtsxYUN
         PhcTKDRm0/9JzHF/MvChbDFER/L104mrwuebCQtjiIAT6qhMfRDyBs/xfyqIGhbkuoG2
         VjkcKtckauUAcc1rBEf0o8hDYUAX9TBegpKWFWG+Ys/vW3nKBfTqfHvjgzMXQizI+4c2
         kDdfH3ZvYIs2LUXLCU3E5NnaBtuczjPzSaKCsVovcj8gFe6t9lk++yUUtKg3Z5Q7XN6b
         9vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351773; x=1738956573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDXRG+l+8UkDA8rcyi4Z/G13+60E1Jk+sSAlFlqGB+E=;
        b=Amw+5eoLam9JrFlOq+G/WOUUuDd/Uf5vZOylJYgU1onQE+3izLPlgEzGkrOe2BJnoC
         +28a/ooRiJskKrXhrgYl/30W+QWOetp7uScHBEqM9YdT02ChaStA4q7zdwZbFdShQBgv
         y9mBjTfGE1cDmo/7jIQCzfp7h69pBZNP/agun5D0DtrQnoDUu7bjT7UBH/4TCIv0TCJx
         XPlanRYImmf1qbc+sW8RBaJGULGwH/OjFHo1V+4YnJzlOoKMMn07QxPI7/uFbSaYJmPx
         ew2aEUeIrv480o8AyRg+pE++6hl5UsWbWH+htgj/foFvVqs8giG8xPVZ411r2JNWbxUZ
         Q3NA==
X-Gm-Message-State: AOJu0YxB5BBfMengEi2hq/MAV4+ai+HXMvvvrjZz5+tlcJHAUmc/nEEZ
	UTVmBy2xCSKb9LnRPhtba4/aRO9DKRhTueWuwjgri3jHr+W80WGZ5X2flUQ3Be0=
X-Gm-Gg: ASbGncsQJsueUre6XN9WRswx9PHmUi20d24alMyIuxmCVqxrhKkTEWkpFGjt7hg+mmY
	F5YgXSJiqAY9jTcXWIMyVfvmErQnwulOEHxoFbYGY4Wel3hAo4pAkjfl1RFRkJqOjkJt4+Jk57G
	25E+zcLXFJfa1U3gPUGRdM1oF1GG7Xf2ZEAOMORlX1OzD2iqXQBhfFow4T0mO/80zwcU4tnz/Ws
	26/IAl7uDiD4l5gZYzwG5GXdsUs2ELkkbKuwMyct605l55iCyIUpYLd7UzEI3JQ79TkRm8qFhcb
	ieW+RhZaiKR3nAMnWM3N+RHMMRyriEffnWlbuBwedSP/kRGbgNsTMFj1qk08EnNMZw==
X-Google-Smtp-Source: AGHT+IFoPrLEFTMuwKHCxW+85CuBvGB0pph0vStHjM2TDFKri4C5KnJ44CRE359EBL/DSbFPwVxleg==
X-Received: by 2002:a17:90b:1f86:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-2f83ac8c3famr17781165a91.28.1738351772957;
        Fri, 31 Jan 2025 11:29:32 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:32 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/18] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Fri, 31 Jan 2025 11:28:49 -0800
Message-ID: <20250131192912.133796-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
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
---
 kernel/bpf/verifier.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bcf095e8d0c..c11d105b3c6f 100644
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



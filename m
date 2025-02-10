Return-Path: <bpf+bounces-51017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA881A2F593
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B13A7B29
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB4B2586EC;
	Mon, 10 Feb 2025 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfkogBj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D0204863;
	Mon, 10 Feb 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209440; cv=none; b=sDMb9QxPXt6LfHz22bRCjwuWTvArdI+rQj+vZqZpDMy++MS8RT3vx9KmHk9ZIR4Mx5h/HbKx8O1fD5cpz42tWvrk/fXblRhBcU6nF2SYzMgI6xQsTc6LnHXK9RmZlYHxfB11OO9eO4rSlnQeGk5OfpMNPpHqj6DePJfwMIJHBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209440; c=relaxed/simple;
	bh=aldpEaDnt4oDAJv5zeFxR3usl+NBly81q17OHUipcvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxVn3q68qPkF2VVG3r3Cu75u5SYu60EHfrO7o8dtfr1JmT/x/O4dLqVimFuDe4klrpzt+k6LGW3EJJMj757y3FEVZCy/IMBpuPN72iwUbhK/1096RtD1ZtHjRBYPM5jJE6hGdb2SU2kuIAlKT5bRgC7/v33sANjm6+itRZBbBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfkogBj7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa1c093d6eso5353747a91.0;
        Mon, 10 Feb 2025 09:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209439; x=1739814239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tb9zgB4Ux2lEBx5nRCfRcA5Fu7KXgIIpYuPhggdRh8=;
        b=jfkogBj7umAWtLRFGs7T+2ewHbECdwpyGTdJdybn96fOYWQdu0e4bAhF+NYsq1jAS9
         2aGTQYt1L9kiQ6lQ116C2cr5gVWvr3zakWpzpDDBgXYOPsWs1uRMTcPGofrf2NTseuH5
         BN6ABjB+CYfGCDR5IPgTtb7XzocD254OgASWwIHxU3dZtHWf9xY38B17a6Ov703rKWS7
         SMJbFjW3RHs08gmypl8R/HExm0Bryu9j9x5NBINT/5xwmblj/ETVm3zCYI2S1/HOJFCP
         o9HTALCaNDoqFxYmuO1IQ3Le3GyfY4YlHdl2mcvXQGmWJRZUBJ9DEflikGT6sofU7dUB
         L6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209439; x=1739814239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Tb9zgB4Ux2lEBx5nRCfRcA5Fu7KXgIIpYuPhggdRh8=;
        b=j9nsHsrJyf1Nz0fepefHuy11s6JqIDPUqjXsFWWNwf+RZAwX6doD0pEnfy8TE1L6cC
         HliJEM91p+FQIH6f2FScWrUqR4vhQ9FT58J2O0XjCPpnzxGdy3kLUYFSNCgz86LhhxxI
         OUTfXSEVoco8qPVKkJkYq6HZVbA1TkuvK0CkTLExxeG4GqcmN/87jsAPnw/pqWtArpKh
         yUiS3sG+MjzFqMyhjp1kdE2Eqyo9HdknhPXJpMlHWbAqGk/uIDVAYhofkpjhaFTMY/5w
         1Rq4FUIVAI/suYnkNWG+RWPu8DAeBbGz399Fjnd/+obueykBJLsc8d3VLoKSz7kQibnH
         tUkw==
X-Gm-Message-State: AOJu0YxRPjdb+CJWVAc4R/x9gHgPTQCO7TI80JE0/3prE+5Lj5aONf2n
	47AwulumchsXy4zjVbr2fVYFZsS1oaAzpKB7TnZla8MAES5I4bqUJKIIm699
X-Gm-Gg: ASbGncsxpEeFf8J24O6M9P9fzKEH48VxkSIOLqvYouv/BZWu0eoHyMgZkJzsukWdSVN
	YZR/KlG/878ja7dim3PO3K3WF5TVub2SFrtDhmSKkxRrggPNH0+zuyEBKzCzXmwLWzRgp0MbQr7
	QA0eZSIdr8ZR8GL/gcnjlX3DlnZSTOV+vZNrI1FGnpLPGMMmtg9CTrvrYuzLQL8AddabuZjK4ty
	Rw7wDpKAe02CoZBngAU44LtwX/oCXpW9axUujc+0esBVFuy3PKIeEffwSDTSF+Q/P8qRYgw7sdl
	hp2UlelXJ34t6mJhAbaGhZKTKTzHbJ+TSuAjET8A5S82z73vXdt/pLlFqhwewb3uLQ==
X-Google-Smtp-Source: AGHT+IH3KUOlK5GB0ml4pOfR5WCxpQyWQoJ0PaamE/DnQp5aZFwF84EEuN7v3xLPIEmWWIQy5v7WMA==
X-Received: by 2002:a17:90b:3dc3:b0:2fa:1451:2d56 with SMTP id 98e67ed59e1d1-2fa243e10b6mr22378988a91.25.1739209438669;
        Mon, 10 Feb 2025 09:43:58 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:58 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 10/19] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Mon, 10 Feb 2025 09:43:24 -0800
Message-ID: <20250210174336.2024258-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
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



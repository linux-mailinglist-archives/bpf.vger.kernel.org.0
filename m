Return-Path: <bpf+bounces-47475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 801699F9AD0
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4DB166349
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD4227BB8;
	Fri, 20 Dec 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD3JGs+B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015C227567;
	Fri, 20 Dec 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724597; cv=none; b=lqI5nAumTO3haHPyn6fj7mauwMRs/kvv1WzvtSUOpLVW7nX04wvCgdn8JRL3tZDzsMSY+8uMY6eiIlTWQeF1HT+wvMt2ro2Ol9JiQdF4z5UI913ZtdSpcf9BO4BU448ruCs0UoU0YAq3nRAc6gaKf3+IDG9fCy+4zkfD82zbnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724597; c=relaxed/simple;
	bh=7VTKmqevgwD2T3vHTnzqDkUUJE0B8xtaL03/gd0M7oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtFArYOejjSkMfaTcpk88NJjMjDnvJMgeH81rE12j1fBDM3CfjmCFwEoeeQrEEk4MCbtkXh0CqNYENm5sx6F2J//9SYdf+qWjGRsDeBE8vnCf+Wx4WiB4kCADohXDpuFkVTHgOtHigSKBscyTDDmyXdz+GdT/p/yUJtJ2GqllNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD3JGs+B; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd526d4d9eso1766103a12.2;
        Fri, 20 Dec 2024 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724595; x=1735329395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pVqW4kyTwbSxeSE3OUqtXEyeML27KshGWKHBkIuQrc=;
        b=hD3JGs+BWqaz93RgHNJSejc6x5ECShPcd4iQWW0n+Li+iB7xJUJWnEmspbsSrPhp38
         WIk2TfHbT0ZQa8eZrY4SNY9vAFHVR+Bam6S7x5foPXC5Qnh6BNAStDysfhvFniwogwAw
         3Oxce2QmBU5L4XicoN9PCBQSsA1xaPyVd+m5sdQY2hlQJcg9PCa1xz9GKw1hITobq52i
         icelhXC1B5w/gzUb4WQjVAaQMjYyMNmEBReXg/UJP/haOSwBCxnaNSAf4B2sFDKobyUN
         zLnnDCg+5iKCXZEZjgM3AuXnzJ0hRwY+PiY1U5Yb2R+rUFdzAY7qPQJSyYPqejZA3wHp
         HC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724595; x=1735329395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pVqW4kyTwbSxeSE3OUqtXEyeML27KshGWKHBkIuQrc=;
        b=rQuDjTAwcbrDitzVzw7RtZcSeDxY/XKnTiStz37ZPpB7d4xM4hJwdfNeDZ1/3MAzkE
         FckKrh2X8YFJSYaoYCtXWgxwK2NIF5lfW9devfHt7y1uHTbGYCVZa7Y/FxfNhlUgYagD
         48lyhDrkJSInju3KkWynp2RZldmws2W4yVXEjQ6OoH5LMjDTnDLSZfhTOIEQzGhn6bpw
         KtumZ+sA2+JXSniD29IQ3MYXc+fvsgoiral0hbClpiRUSP6zun5sNR3j16izlMqIa+LR
         KRdevWC94KO3qBPOo45T4Czc20gkzouWdkquM1b7nPKs0XMxITUZqofttVqSDs953kPt
         3ANg==
X-Gm-Message-State: AOJu0Ywa1/bsa55Xyx8RM3H+yZvI6zIVfahoiWWrEWhv2hImFTa2BMSn
	VyR9wTpRkFl0ENRiVpfk18dpJICddo7e/+sHfWt1HLSpL7p2d2wRFjlABA==
X-Gm-Gg: ASbGncteUX1CJY1dWmPwLMM8WSu45ZLYqjlA6p+z4VO3FHxmcXcWl1ShMfmqELJHT6N
	Jc97k6f6+ZYxSkjL1a8yfdQakYif0lCvZs+zo4LrQHx35tLZVRS18pJuUVR6Zq8ZLNMO76BvuZ/
	xS95hzEiPjbPghD2WuzhK4gpEe6FbROHUx1eBwBN6Mf3s0rhnbFuv5e7v//n72+bdOqrx2KI55b
	p5P/S1gKToNfHbaweemK4Df8fOP/0eN/i7cqJvk45/BfaaNyxb4u2H5dfB11amdbfpBFltk6Kfj
	lLuXPRu9fP+LbQZUdSQPbey6mGohc0Ea
X-Google-Smtp-Source: AGHT+IEEz5M/z8tYwRcmPtDwIciVMVaTLXI5ltjtZLcP2vze1Rmfe8O6DYxFr/gp/wwBuC44qziTZw==
X-Received: by 2002:a05:6a21:339e:b0:1e1:aba4:209c with SMTP id adf61e73a8af0-1e5e07ffc0amr7662403637.29.1734724595385;
        Fri, 20 Dec 2024 11:56:35 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:35 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 07/14] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Fri, 20 Dec 2024 11:55:33 -0800
Message-ID: <20241220195619.2022866-8-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
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
index 0e6a3c4daa7d..949812d955ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3214,6 +3214,21 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
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
@@ -20278,7 +20293,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
+	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
@@ -20307,6 +20322,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				return -ENOMEM;
 			env->prog = new_prog;
 			delta += cnt - 1;
+
+			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -20327,6 +20346,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 			env->prog = new_prog;
 			delta += cnt - 1;
+
+			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-- 
2.47.0



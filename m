Return-Path: <bpf+bounces-52103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D0A3E685
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 22:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6397719C488F
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7759264F8B;
	Thu, 20 Feb 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLgxEzQ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF203264628
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086744; cv=none; b=pQMW4qFhtq9QkZo11daoX/g4kv9R6Jhg16Jezdb6JhAr0o2cbe0qnvO5E6J3K1Q+6XItcLTiAJjXhdAjUVha6yz2zA6q7LTcumvlUNxofi8LOg3i/If6ysWBA9ok/CeKHFxgQHf4Hx6VxlrOPIJVzHGgdM+qRPBKE5NQd1hCvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086744; c=relaxed/simple;
	bh=dFVl0mltdSI9xY7xCGyam++vCFk31r7Ci1vODvAyuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieRiA9t9FFimSw2XSZKMFTp8ZozKmIzbGZcNX+0Jm+YVr050urabV384i6MjeterxkX249f2Oe9XdmJa8LXyVa1T68Ch89nRnSqjHHAp7KaFDFtoUAEv0DZ16js40H6m2HC0Nl4fjzsh/y6fCLjt7/4/MCMjt3G1178jFPxybxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLgxEzQ1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f42992f608so2355551a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 13:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740086742; x=1740691542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcNCf6nis9hu8Rc01mpWy+jatPgNBlLoDXeHiyrSKOQ=;
        b=SLgxEzQ1W1H13luuf7sdzsBCGY9jMSHK1nRZhryrx+J2yTsmQG70HZhhq+4RhzXpMt
         YLFU1fKeKafE4gvxzjPmUdSZ0Mk9CdWdWYdvgSklaxxyPrj989dfhGePL3YtTNGiwhAb
         TSlnS0Un/N1CBTKvcgYoV0tsvw7MVJpfK9VaPhlbTkkRRrX8ROYSUzdhigsHIn+LY+c0
         KVmUOjwkx22yc5jJZNE9G+yeOvoE8seX+bhTEvKuUFAOQTDJOcP2mw3tnDdDrYukvwwC
         6IfC42M3zq0HPhFAM0I/k2Cny1zRgK6dTBFCXd8cPf2pvc5ezLs0h4gr2roSHK5YK61a
         zaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086742; x=1740691542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcNCf6nis9hu8Rc01mpWy+jatPgNBlLoDXeHiyrSKOQ=;
        b=E1W5eLHcCovWkVJWgKuz5Euo7wn0GUlsTmA6KdIhzWMN/NsmVa+I6X/lLF++96pzmY
         zYL2pKSjJ+nB2ugiNJwPVO2ztWHVhOKdYb5+ryiYZdfrNcr8UADFRqkxvbve+hh5BgcB
         RG4mlhb9MXVBc4Ac5AOl2UCydHT/ilNjsfNnAVyNa+OhcNCUXUTZuHAvwGJwp0UJ3RYb
         TrnNJi2L+/qdk9rXwjZs8bEHzrc7HXJbuTy9n64g/W84HpY2us+HvGFePw8BhW8X40pL
         sfFP49wC5FuC63twZdnTAssMoX0rLCdvOM6hUIICCNQEY0QUiZ4RyrUo4IJ412DZ/x34
         DByA==
X-Gm-Message-State: AOJu0YxLeBfC2IsnHAlpzzUu1JLo8cdZ2UmWP7hGGNKsGITCB6FwHGHy
	9JfxWGMroUQauoJVgXcnP4WljtkTJavovDJ6BDzx4vVw9JhgSivg0/7maQ==
X-Gm-Gg: ASbGnctoroSSRkaIZR6Wj2MqvgpdDaFIqI7GItD/DOc0JZl4xrwPi4W3wuoF6/+EiY5
	/rMLM1n2QlalZdPhkYpMhgONBa1Cq0tKTIbCjTnOqm6tXjQv8KHQEOIMND5jxf/7rTkuiUHRb9k
	SbyAB6prK1/e1RLhdHR8DoK4RFKXopP95MRqYVmPqIlEkSvOy6mSuHIz5tVVXW/Il62R961klZe
	hI1i2+vkfW+LFkOJLkUrBsobGuVoXUhNfL81Kx52v6A3irugPFTPfr5aKtoU0d2AvqIviDEsGjn
	tlBpA08zyJq62tQ1cGBGNzJTe7xzZ1wVspNHO/VkNlKO7rcxsRMy2wFiYWQgaDUuXg==
X-Google-Smtp-Source: AGHT+IFb45MuxwLDUUUgBiELfzl3SLbWtbcWQ9Qy2SOypxz2VCgA+p8r1ctonWTaZbBF9TVH7qsu6g==
X-Received: by 2002:a17:90b:53ce:b0:2f6:d266:f45e with SMTP id 98e67ed59e1d1-2fce789de66mr1196824a91.2.1740086741831;
        Thu, 20 Feb 2025 13:25:41 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d046sm126107795ad.114.2025.02.20.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:25:41 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Thu, 20 Feb 2025 13:25:31 -0800
Message-ID: <20250220212532.783859-1-ameryhung@gmail.com>
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



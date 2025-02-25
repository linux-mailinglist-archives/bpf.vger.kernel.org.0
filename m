Return-Path: <bpf+bounces-52593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408DA450F7
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 00:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B824C3B0658
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C032B233724;
	Tue, 25 Feb 2025 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaeFvvUv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01572327AE
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526557; cv=none; b=NHUagXdGvVkjKrqvqfepwcbaxgaX+F3F6sXF/XeW/yGnqJkjCpTreIH2k56iK63hOdous6osL49pndBuZyBsdRNsXugGfHPQChMCjfEI9ZvujvjOWBGZMDLLGXW3TudH1VPuiVK57sXCMdVgXGe6u3bFci0MQklwYkH0xLMUGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526557; c=relaxed/simple;
	bh=Bm+LBylfGsJgvyk+qTys+PsBYkW9Hx/AoPwHzVV4khE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSkuCl2EFY3VbR825dfo9CSio42JxEkMhdAdP7QGOIKlcOHy4JydCcB6BzoA73ftOr+XsgWztGQ7JMS/D7CqKJUBSUmlkMGiXtVxbZLv88faQLwfWuuCuplRw2Sir6qPaQ4BAzD0CSLz8h2eXy9l6q2FRu5tatgIIDEW9ObRqvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaeFvvUv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d39a5627so95511515ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 15:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740526555; x=1741131355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtsF8ys3horHKPl9ZBt+YIvSB84YRPfrUVxVHC4uRDk=;
        b=WaeFvvUvU0+BpmncvvyFa7TKw9UN7XkWQuIabDRxcSY4anpZuyYOhitBz2JKr1GnBj
         tEYKYKvo0+CNwjI3vLgWBma9Non2Ud5Fmb4cr3BQAzTye3hR6yC5BOpXCYR1qhHndiXl
         TKl77Roz/jFSyxMhd0ae80yOk7tGbhRRCqfx7h4pEsuWC6kx0k6GYGBdS27H3BuLHqSY
         rOej+rvRc3FMKDutnM80FtAuybjyPcuqBthZjoyU7rLmnpUrFl2hKTcr3da89FL4dX4K
         9HVsrHAQIPMys0CF+LYWJ0hAk/mTypuPp2DwXrmVOfY5uqECvc5WbmYjIE8g/LqPU/XK
         gpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740526555; x=1741131355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtsF8ys3horHKPl9ZBt+YIvSB84YRPfrUVxVHC4uRDk=;
        b=RC6W50a1nfyZqF+m8+SXzKlFEaL6PdlXSXDzsZgoRoGcxDO1n4pokcayTl/puVP1sk
         e/RPpTtwiRpb6e+SR2HKQC2Ey2wABStlu1+jrBD70NZMNZBELZb6TdAAwlXdRXbHqhDj
         ToL4nXzIgkIrLeJ5gDJEXIQNvogYjNoxdo+QHQRULKq6jwGudooafpXZEnhyETRvEnEU
         xhu9TJlB6dQmwzmQFg2msyJEptI30of2h/WfiHWESuBElb8x7X+7kGVS8mj9qllO0Pka
         3aPj7sxGcz4aoA6ZwRmeNPnAxejJY5eVz6t+V9VaFNO6No5k2wxF1owKeWrOJiXxQgCN
         3CMg==
X-Gm-Message-State: AOJu0Yw3q2MkOUr+kMkwOBoS26SVvA2VEO+yogukKSDE67tW57lcKumz
	APfk5jmHlx2wUIrkrMRztMr7a5eI7h6fmdOabvZyHzp8Q3kbOVJL8YbfBg==
X-Gm-Gg: ASbGncsWEzkP56F//VTsKTTTtC4Ja0n9Z7ohsGS2bKbWTe2FZh7IfjGK1EJHaXPZynn
	031VcJCt0rGEf3TrgKxNFchBPfIIxIY3BMzwQq2P2L+D0wwY0+3ub2u4PpiOVUDCqlqV35XdejL
	6bjHk0BmleRJLh0Rc3lUBkt7LsyCMXOki7d+SYeeVPOsSnu2vTVwxIb9/7gdcbAsIHHu9CK6OsH
	0dw3bHxDmvSpHJFjh5uD5ddqxIiPNsSVOv9Wd65dTSEdF4ZxzceVnQ8x4vuPaqztf7V2OGiI0Jp
	TP74dqX+JCCdDwCuC6eQWHnRY8wPOS+6a7Ffybsy1VAqgwppmSKg6eQxz0A+1VuyfwVh3cexpta
	K
X-Google-Smtp-Source: AGHT+IFJSDSBd1VRLHzhzqy1TmPANYxQXAp+de/B3HwIZwcWkIFzi9dYpvl4Jr4DkI8LkzmCjrzlXw==
X-Received: by 2002:a05:6a20:431a:b0:1ee:d515:c6e7 with SMTP id adf61e73a8af0-1eef3c56744mr33048788637.1.1740526554882;
        Tue, 25 Feb 2025 15:35:54 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81c589sm2167527b3a.135.2025.02.25.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:35:54 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 1/2] bpf: Search and add kfuncs in struct_ops prologue and epilogue
Date: Tue, 25 Feb 2025 15:35:44 -0800
Message-ID: <20250225233545.285481-1-ameryhung@gmail.com>
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
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
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



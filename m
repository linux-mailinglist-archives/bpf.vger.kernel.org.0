Return-Path: <bpf+bounces-59039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885BAC5E31
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE947AA6D4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F199278F2F;
	Wed, 28 May 2025 00:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKPEgnvh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515072634
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392029; cv=none; b=jiq9SvuH9VkU6NXXk/TYvAZt1F7TbR74xVYQyr7LIzfe0jXKXkf1x9WtRna7ZGC8yO9TG6fXJDRAAHxhWKtyAk/BOKEb3LPSbBpil1cYnzz/csdFyt3EhKowUwrIWqZiShLJ6mvZPaQq1DTL5getnPZM76ohm+zLb7s8b9Lm0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392029; c=relaxed/simple;
	bh=duRct5JXMYbnM2dpIoZz6+ectfUqwXEPNGnUF4rIbbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MttuUWUMyds0PCB7ZnpOD+ggr1/+RG8PbI1M5OAHlRrYMQlJy3OrkVLvVCXZPlleQbyyqHzPR804HxFuZpda9IgOQESrknip+nd3j0tlZ1Hakzg3hFer3k171i7+y2TLJKVXve3//lHDZxjcPczMSqgoEbIgwXjlwxA6+elpYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKPEgnvh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e09f57ed4so3472465ad.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748392027; x=1748996827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KpuxmvuESfWRBjwTrM+x2+GrkEXPMjx3rwSt4GzxrBU=;
        b=bKPEgnvh3izEvEc+ecIwe/W5JDTSfNnHGRZyLWAXPYkSSK2s/bbp6hJtdrLDHeRt3n
         OJYx5oFV2cCXDWCUGY7uuUmja2d8e3PyxpwH5LmpipLVL5/GJepRnUxAH9u8Le2lmhci
         uG5Q6xvS1Ezft+UcVI29c/B76Elgq+NQ7W+iQHl+qjEcwb1ndRe7KLK8hGvk9ijO+Zs8
         28nxKsmM27XlXxEAZV9/0lci1WaI0ylA1hkWyR4xfXOTHwU1I+hmfWA5+0gbKZFqGxbv
         WvJOyGTFZ6Q4AOLOrMnOJqrVEArLvAjbhNH6MMWvHJjVKlKAqaCaMHdIfBC9I48EK9ee
         k8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748392027; x=1748996827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpuxmvuESfWRBjwTrM+x2+GrkEXPMjx3rwSt4GzxrBU=;
        b=lvjq7ulRVgHXFE3ePzG4YM9bVSap5VwlTHpbB9r0YEfvfJ+IYvgVG71jndDSnINQh3
         L/F9XjuyPs9Q4/Nd94FgPf9XLOdk2LWjfKxSbZTcyAyT1vi1hjr2lxYPfmtw3/a+YlDx
         xj8vVRMEDOfVjJli05JvhfGYAo0XLjyxSf+J3INfDjQL+uOCrTZt+PvfA/EdAgxQNEEC
         UFQSZJChEA/xO+SS0InTsrh6BVwkNxYWqTXewUDFilurqEDq3pHPaWCmqJrRJPVsAr6y
         1aogI5bUpgwck9dreAu/A+Q5ik9242xgZgeddVPwDja3B5Zm9iHIwQtylmsFFKBSl0S3
         WbGQ==
X-Gm-Message-State: AOJu0YyXCFG3g67kii5/UFdD/kZRli83g5DCzktvUZJsFQdNNQRT+vc0
	XYVa8q3bibg9UwpFRlFI2K0a2B5AD/vseyC/PZedRCBeo340KgWWWxDqnQ+k9w==
X-Gm-Gg: ASbGncs6X8wxHGfrpgCXuoGd2adM4mAjhCncfZ1oYowWs1ratR65AKTvjscBMtFcX9C
	k+/aG14WtmI/cCKlZN+ACbgQw8tUOlJcCxBZwgvqhu6rzyX6Fx6kzMgXnq7O9kLWUlN8UZx6+iz
	0iPAXdwCW0A/ev0ATlg4X/bWLk2/3+UTy8aZNdqmJCmMm4Uj70XLsYZvuETCVZW7q3Pk4Gb6FTF
	zpiMsuFqfrRbC64ONkb3JFsnWX4zG4c2xgGrXNc6LMlMjBp+J0HjHljk/1C44K/7YRThghBigJ7
	giECOBsWQ9By4klvKOG76kpNBETOU4iiROdebygwuEnur4+20dh3YOBdVCR22F4N0RkI4DUShuy
	tsdq5C5dot6P+fWc1
X-Google-Smtp-Source: AGHT+IGFNhf3Ap/qbGwImHU4tyeoaF+QEiMD2Mz08FpnYq8QiWmNy2Np7LRi4n3r+H20jBVMVkO2vA==
X-Received: by 2002:a17:903:2f82:b0:215:a303:24e9 with SMTP id d9443c01a7336-234b74448bbmr35116325ad.3.1748392026727;
        Tue, 27 May 2025 17:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ccf5dsm44395ad.257.2025.05.27.17.27.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 May 2025 17:27:06 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	xukuohai@huawei.com,
	alexis.lothore@bootlin.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf, arm64: Remove unused-but-set function and variable.
Date: Tue, 27 May 2025 17:27:04 -0700
Message-Id: <20250528002704.21197-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Remove unused-but-set function and variable to fix the build warning:
   arch/arm64/net/bpf_jit_comp.c: In function 'arch_bpf_trampoline_size':
>> arch/arm64/net/bpf_jit_comp.c:2547:6: warning: variable 'nregs' set but not used [-Wunused-but-set-variable]
    2547 |  int nregs, ret;
         |      ^~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505280643.h0qYcSCM-lkp@intel.com/
Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b5c3ab623536..14d4c6ac4ca0 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2520,21 +2520,6 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	return ctx->idx;
 }
 
-static int btf_func_model_nregs(const struct btf_func_model *m)
-{
-	int nregs = m->nr_args;
-	int i;
-
-	/* extra registers needed for struct argument */
-	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
-		/* The arg_size is at most 16 bytes, enforced by the verifier. */
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nregs += (m->arg_size[i] + 7) / 8 - 1;
-	}
-
-	return nregs;
-}
-
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr)
 {
@@ -2543,10 +2528,8 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 		.idx = 0,
 	};
 	struct bpf_tramp_image im;
-	struct arg_aux  aaux;
-	int nregs, ret;
-
-	nregs = btf_func_model_nregs(m);
+	struct arg_aux aaux;
+	int ret;
 
 	ret = calc_arg_aux(m, &aaux);
 	if (ret < 0)
-- 
2.47.1



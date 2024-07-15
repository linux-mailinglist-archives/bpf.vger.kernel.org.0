Return-Path: <bpf+bounces-34857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F915931D6F
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F13B2188B
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCEA144316;
	Mon, 15 Jul 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOm+gGxb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B981442E8
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084554; cv=none; b=rf+Eru7sRkYMu7umX/p2nctQrHUVWK3BdEEhYCHTORgEf3MjEA2YgFHkWmqaoOpaEaJyAUu5L6zJ9wjLmU6+2wOBB/LQCSwptjG6Q/dXSSZegWd1H0VEZ3FG0J/VMxy2hrd7+tAf6HrrG7RLU04jFxENmAJJJNFt0UOi3qd6V1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084554; c=relaxed/simple;
	bh=ldMPcgcQGMpOFdiM8FOHsMKJSftJhX+5BRjhpcImCPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAjmY2cqogeYBO80fMyrQdr4y7bHaDiyxfa+i7jRsmAkjuKDnxsGJn3E8n/vQcBc92dErYNoaoienXp2/jwk9hzsjbREBtMUNaIaE73s5TmsDbT0DF5Ag0FfAqyHOeKaK+6xVCsrIpW61/UDl7Mu9O0nLqCGC7qpwwZZCufqR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOm+gGxb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f6e9662880so220675739f.2
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084552; x=1721689352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+36kxACO33x+PbYNxrBVc9gb54uCltMFFp3q5I6q3Q=;
        b=YOm+gGxbWXTxzLm8uRWKqEzRnxfFFfyVGOGfbE0WXZx8p7nUn0YD7u6hnb/gFrA8Ya
         gEeX7WDJ80H8BO3DCrSWyvWy73CpXVeIhI1oWqZLxfxegqShDtTvtFChKmOYwdlvVues
         sKHBzWvYsk9P8iFqAvfsbMmyDBPhURINTrYcSyJ0vEfvWkOolCWutXWrH0PxmSgX+jbd
         osGG2T5zRB4uQfXBOYXUi5RDnNA8mKve2DTOem5H3OJ86PvbMIsE/9BsRbIzWLvonNjF
         mbMfpan4OIcuKpgRNqTtUlqCQb8SQDvX76ibUfzFdpPiRJ+xtNpmNsGjWBe9jCpLGc+A
         jlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084552; x=1721689352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+36kxACO33x+PbYNxrBVc9gb54uCltMFFp3q5I6q3Q=;
        b=DD1yx8lxCwMLl6wHx0EM8z20ucy0Y4snFX88wYopj2Z51KJfHYVngoF1aZ3wQ8RGmn
         yaCT5t/bLMt9WmKY27z81ejThxJ9tkBF2sQmCwJr6gz5lHTJc8Uuk5Js0xgb31nW2CVY
         FWTURCgsSAzvwDcKqf2MT31DDRFhq2noxG7aEFJI1/Vc4vjr+RrTl4G9HVhp283zCviK
         5TUWIV5QGeIipmMV0urvb+xtVibOEfp0J9p1Vny6lhEVCVz9PFoMWOEMrcA0Z4NusuQT
         gQaIZEfs/MG/GJsbXOgBF4346WajXJ1ou9nj8/iqhbxY+XE21q9VTBgV68TqxxZJvz96
         +FKA==
X-Gm-Message-State: AOJu0Yx471+9ehUvBWpTn/DcI+Fu6/m9r7zgyJ/DQkSjKkUkhD2OTGPc
	u4MwikOmTJRsu2mRfEZbA2B6l+EvEwKFeW7WoDrFpUZ0RWyUrFW8LbIZag==
X-Google-Smtp-Source: AGHT+IHJCKCUF3y3mcnuK1ASfaSwaKroyMAG9O+zth3nJJnn3h61YwxJCSAkm+KNnNu7NphLDogiNg==
X-Received: by 2002:a05:6602:1693:b0:80f:81f5:b46c with SMTP id ca18e2360f4ac-8157670971amr67652239f.15.1721084552111;
        Mon, 15 Jul 2024 16:02:32 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next v3 05/12] selftests/bpf: print correct offset for pseudo calls in disasm_insn()
Date: Mon, 15 Jul 2024 16:01:54 -0700
Message-ID: <20240715230201.3901423-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715230201.3901423-1-eddyz87@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust disasm_helpers.c:disasm_insn() to account for the following
part of the verifier.c:jit_subprogs:

  for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
        /* ... */
        if (!bpf_pseudo_call(insn))
                continue;
        insn->off = env->insn_aux_data[i].call_imm;
        subprog = find_subprog(env, i + insn->off + 1);
        insn->imm = subprog;
  }

Where verifier moves offset of the subprogram to the insn->off field.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/disasm_helpers.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
index 96b1f2ffe438..f529f1c8c171 100644
--- a/tools/testing/selftests/bpf/disasm_helpers.c
+++ b/tools/testing/selftests/bpf/disasm_helpers.c
@@ -4,6 +4,7 @@
 #include "disasm.h"
 
 struct print_insn_context {
+	char scratch[16];
 	char *buf;
 	size_t sz;
 };
@@ -18,6 +19,22 @@ static void print_insn_cb(void *private_data, const char *fmt, ...)
 	va_end(args);
 }
 
+static const char *print_call_cb(void *private_data, const struct bpf_insn *insn)
+{
+	struct print_insn_context *ctx = private_data;
+
+	/* For pseudo calls verifier.c:jit_subprogs() hides original
+	 * imm to insn->off and changes insn->imm to be an index of
+	 * the subprog instead.
+	 */
+	if (insn->src_reg == BPF_PSEUDO_CALL) {
+		snprintf(ctx->scratch, sizeof(ctx->scratch), "%+d", insn->off);
+		return ctx->scratch;
+	}
+
+	return NULL;
+}
+
 struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
 {
 	struct print_insn_context ctx = {
@@ -26,6 +43,7 @@ struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
 	};
 	struct bpf_insn_cbs cbs = {
 		.cb_print	= print_insn_cb,
+		.cb_call	= print_call_cb,
 		.private_data	= &ctx,
 	};
 	char *tmp, *pfx_end, *sfx_start;
-- 
2.45.2



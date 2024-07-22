Return-Path: <bpf+bounces-35283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8393970C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE17B219C2
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69396D1A9;
	Mon, 22 Jul 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdsa2PL2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C061FD7
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691553; cv=none; b=FcLGTAMyr6tnnqzLU0q3fKTOqp8wZ7FBAgVWzdS7W4R+FS+xw9JahPYFhxe+1KTvW/XMJFofJl3n7fIwW+Z5YE4Yq8P+mhvZ9pmC8DdruaiWpQ4NqufYAk975IY17w8xMopxRKMK17fLYSSsL4cp3YOLo/EIyz66COIKbMauET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691553; c=relaxed/simple;
	bh=ldMPcgcQGMpOFdiM8FOHsMKJSftJhX+5BRjhpcImCPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg0wOlxJW6o9mGPJlDu0tjhHx+ONNElipX7qd3JVnnysEmT7s8wDLs6n3f4mS5AJTrdGdEiM6IVfRfqms6RSsU3u8cvubGkEJpkSEYvVp87T7uXGp2bT2hCmqoQiVJ7f0MuI4JiqX7hCPMLDYKVexkI/9uVNxXs0c9g+ukWnvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdsa2PL2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so1121197b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691551; x=1722296351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+36kxACO33x+PbYNxrBVc9gb54uCltMFFp3q5I6q3Q=;
        b=mdsa2PL2JqTMGJF3+/P2x0maulNQta2iLTiBeVjW8DvHkzm8pqKFBmJcN5NC7iggwM
         qN8m3MpVxNNE2gsoSZQu4YZIMcsORpi5xxkL+cPQgcVyvU57APkCIHG+8o5K0W3ZpYyU
         K6IAVvgJxeyoFsu2MvylHDg/BYJpmYdmL5SqjHBLnkifGkyPDtnGs3mWAmSvVjJMAOt/
         ElmE+GpxDF5L8mARDK7MStuUfdkwqQeuy6G/sji5qYmMGlM3wTwYo5+qRc1Ryk1VcBVk
         2JXyLkVpgvBlZFBrPGjWamiZmIFXKVZHzgg0XSg5E6Im3X1L6TpdXHGHOavKqc/iS/nj
         szKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691551; x=1722296351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+36kxACO33x+PbYNxrBVc9gb54uCltMFFp3q5I6q3Q=;
        b=NU7QPlm/IXMvQMoCULNvVw+tKgJs7QbJYqOoGmhoO/ztZ0iIpkeIBViuCe6VD6NZaB
         BYVCGb96UWyktBgGwgOJr8HJLWlEyX1REgFvr5eWDVXOMBjf54C+R1X3pONIpmbBCIGc
         mjrCeiFwLS+YuK5xR93CtI/34SkdYi39dhHgbPbfiglEAjRH/csqSEJG0Ky3yalGXXfa
         Qz40iylKZ0UjwFAISKVPiP/t2JFsQ8ICmSLci+LV4PiUpb1I8srnbKOiCe2mcD+jCNZt
         QZ6Dlo/2+5rOrUfd++uP3O7q3dPu/8V1DUwQf6Ji/IqHYEA8YgSud56egLR05bCgex+q
         E5Yg==
X-Gm-Message-State: AOJu0Ywmvq1I/Yj3+fAGAfUZhByN0BXy05hXPn33in3cliLjovtG5n6g
	hmikNC3fJuR5GSKn4Unqy3vUg704IaSvnpaLzdK41HH/kOoGvIIva9dKZdkWziM=
X-Google-Smtp-Source: AGHT+IGpgbm98X1I4bGkazNwEEoXvcMaG499Hw9xrrHNADjy5mdRhy+T+3His/5SqBgsZ75ivDXA3g==
X-Received: by 2002:a05:6a00:1950:b0:70d:2837:6089 with SMTP id d2e1a72fcca58-70d2837cb61mr6872526b3a.11.1721691551012;
        Mon, 22 Jul 2024 16:39:11 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 05/10] selftests/bpf: print correct offset for pseudo calls in disasm_insn()
Date: Mon, 22 Jul 2024 16:38:39 -0700
Message-ID: <20240722233844.1406874-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
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



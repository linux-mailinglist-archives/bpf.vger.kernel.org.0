Return-Path: <bpf+bounces-36960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5480894FA62
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE121C21C78
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E0F19AA63;
	Mon, 12 Aug 2024 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoSUDhJ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF719A2A8
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506254; cv=none; b=ov0dXbQ1bqxw1sfQ3PIdL+r0Cry7jmTBd5QS8FCWEiXSas/0WPaNFVwYtl28LRkOGJRy7h6/XPvRDAS5fSmAzTZQk3qdAPihBayjz3ebM07lmPqGIT4TuscXI8aX7u3B/m8xx2EAMdrmAjNmAzt0S6KE84K0e3UqW5ygIHhYznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506254; c=relaxed/simple;
	bh=DYUHILfBeq79NNB8r+D6oFraPo9L4stbrDAWMzVjUkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iioqjI9Zx2cOJgRhiHi73F+UqHJzqobK501icXfqzBgfestzJeoNRfFSPeB+77xpsdceAWQrMIPFfdBIGRX2Pb82LQyugWdpzI575xRSeNR7Lx9eFLEWUvEq1VkyAWKtbvWOJbm3j4L+fk6ZQM0K2Pj7ji5ztBkoQlgDA2pW7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoSUDhJ1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso3233911a91.3
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723506252; x=1724111052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5XPSNegzCYKn7BJ+tG74644VJNHjxQdFUZ0YZ/UMFw=;
        b=QoSUDhJ1UCMA6x1nMqq3t0gUvX85TryhziZHg7F4jlqI1TDKGQEKT4ukhTmFXTQgs9
         8WiZnHellP8mS8fnE2DkuwxTffQb4bEizOWooGQ4X3tsFKntmPW0yzs7xBXJGXLxLrs5
         rBPhTCkuyPYt+oCi+nSfqrX+hZLACZoVD62RU+zZpo2S1mQgCuz84veb5tzf5OgpAo6v
         rzlLwBU2jSy0hHIwDH8LxmiSJieoHoz5M7ZUh6eIKcg1f7s0O0kVgpL4Qs5+6qXNTOp2
         lCMc4Yb4Le01d5LMZvuQiNJqRID8tzX48zenJRDKCF0H46GKFaruGyffhQBwYc7kNoR7
         RT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723506252; x=1724111052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5XPSNegzCYKn7BJ+tG74644VJNHjxQdFUZ0YZ/UMFw=;
        b=HJ0oyJskDtjmKIVi9fPJ3FDzzTO5gcpw2oWx0MJtC565wTJdXNyZETvS5P4J+zzMiV
         8rzJdJdniOnDR8GMNh+XdVwqZkvLHCHiW6o/OCA3YYN8GYaaClRNVD21RV5IwFJ5v6kD
         /nw5g55e4mzkbrUImZMxCXQPuDAxaigIaqcwjVExxFangW4gVKSaz3vLSFwX5S+oaOPf
         c1P2aTmzgT5UI69yandf52jqmjG7C2OzwP52GS2Cq6G6uzToA7/VA12uEj188RoJS1qR
         yBw8NHF4jjq6ZxGDmEU7im+Czsm86mdMtRVjjtdVOITUiZ3xNVeOkZ/HsvUhyti8aqmf
         Q5eQ==
X-Gm-Message-State: AOJu0YyO7WKBhCpPl6VbNMBJ6FWWO7q5IYuYWD6EXvSdPyVogXYiI3tI
	Y2bTDzEvfiDbwG5TH+x7iu+RJzW6LnwGaRn2bOgyKgxrrPimxwmGcFbC+webDQo=
X-Google-Smtp-Source: AGHT+IGCFw3D5rs5g4dBC/bo+uj3Wgv6qCRLAc7vfPJ4+5lyFL/3joMitUlBb0r4L7A9nPhb+zNQKA==
X-Received: by 2002:a17:90a:2dc8:b0:2c2:5f25:5490 with SMTP id 98e67ed59e1d1-2d392631742mr2108577a91.34.1723506252100;
        Mon, 12 Aug 2024 16:44:12 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcfe3c1asm5688538a91.39.2024.08.12.16.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 16:44:11 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: check if nocsr pattern is recognized for kfuncs
Date: Mon, 12 Aug 2024 16:43:56 -0700
Message-ID: <20240812234356.2089263-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812234356.2089263-1-eddyz87@gmail.com>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kfunc_bpf_cast_to_kern_ctx() and kfunc_bpf_rdonly_cast()
to verify that nocsr pattern is recognized for kfunc calls.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_nocsr.c      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_nocsr.c b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
index a7fe277e5167..8ce8d90ea3ad 100644
--- a/tools/testing/selftests/bpf/progs/verifier_nocsr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
@@ -2,8 +2,11 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
 
 SEC("raw_tp")
 __arch_x86_64
@@ -793,4 +796,51 @@ __naked int nocsr_max_stack_fail(void)
 	);
 }
 
+SEC("cgroup/getsockname_unix")
+__xlated("0: r2 = 1")
+/* bpf_cast_to_kern_ctx is replaced by a single assignment */
+__xlated("1: r0 = r1")
+__xlated("2: r0 = r2")
+__xlated("3: exit")
+__success
+__naked void kfunc_bpf_cast_to_kern_ctx(void)
+{
+	asm volatile (
+	"r2 = 1;"
+	"*(u64 *)(r10 - 32) = r2;"
+	"call %[bpf_cast_to_kern_ctx];"
+	"r2 = *(u64 *)(r10 - 32);"
+	"r0 = r2;"
+	"exit;"
+	:
+	: __imm(bpf_cast_to_kern_ctx)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("3: r3 = 1")
+/* bpf_rdonly_cast is replaced by a single assignment */
+__xlated("4: r0 = r1")
+__xlated("5: r0 = r3")
+void kfunc_bpf_rdonly_cast(void)
+{
+	asm volatile (
+	"r2 = %[btf_id];"
+	"r3 = 1;"
+	"*(u64 *)(r10 - 32) = r3;"
+	"call %[bpf_rdonly_cast];"
+	"r3 = *(u64 *)(r10 - 32);"
+	"r0 = r3;"
+	:
+	: __imm(bpf_rdonly_cast),
+	 [btf_id]"r"(bpf_core_type_id_kernel(union bpf_attr))
+	: __clobber_common);
+}
+
+void kfunc_root(void)
+{
+	bpf_cast_to_kern_ctx(0);
+	bpf_rdonly_cast(0, 0);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.45.2



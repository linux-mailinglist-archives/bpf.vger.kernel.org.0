Return-Path: <bpf+bounces-37839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11D95B0BF
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8361F2143B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737F17CA04;
	Thu, 22 Aug 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZT/3qIX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3517C7C3
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316096; cv=none; b=TvP9r+UVnJB2OhKQ1WcTqZvVBoL+pusACSb5bMOvUcjQ2zlJN9MwVez9AQ1fq4KYy1DQiIS9Nt9gyc7dBc76XoTeSuVaPXMetP4lDf+8NYhm3Kpjr9fa6HQeDkgIBHOCXKcfTGga+IP6y6WmDMzq6sx/5EJYBqcYJq2oYirz4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316096; c=relaxed/simple;
	bh=SPv7SzAnZuFx6VBDu1Us/wEVReLGH20Z+96IAklt0QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noo/rTmXqhsOOytf8Lnt6dg4hcKePWc6OX/vZM3byPYTtjMesxr98EDBJvHmoK0/yyqw8VRTCNLu2KYQTKc65brTaO+fsrIN+Qqn38hGN/48Shgty1uuB+wjJtfAvXOblHt2wZfMTXwtyGhQl6wtScem3tG6mz4zAGefgO3Gr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZT/3qIX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71423704ef3so466097b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316094; x=1724920894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imjPoZCl/bEQJlJqnmv17tA/yvenbStSD5R5DrglOiI=;
        b=GZT/3qIX5BA4bKoLVIpRFJYi652Lc6SfJTTRgeMeFWui3605+sNhjEAcJEKOMnP09x
         2Z7RgqXpMI9y4M7URQ81sEnrn2knodD1glWwB3FpElPmKxVVJ8p69shF9tHn45JQ0CSk
         HbVPDJc7BAzp6xG3OfvnUYs5WTVMQHkvmnzQ70Z115mrGFgeUlKczlCv1yF7b80rC6Uo
         YVcMAUBYaBLAOCPAqI0eeUC13380xElqfPPJ2go5dbN+K/42/aQb6Nke9AjbHVZvptC0
         D2rlCeX8wB0tNaKKFgNZEmGPyma5uwtvK1qoOsZSYVgK2Qi6RBpPCchxFXZyYsZomtht
         bwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316094; x=1724920894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imjPoZCl/bEQJlJqnmv17tA/yvenbStSD5R5DrglOiI=;
        b=BcjoF8fFt5Vyo6WtCfZluEEv8nmS8F+s+B/BUqo+f1tabmh4urVcByi4D/gAK4oRjb
         feDkkp527b1VFGSqQNNuVSEvvnwuuG95QcF5cyiw7L5khYoWAzUqzSiI0dA74EHgC1dk
         49LTDdQouEJ9HkqRdQqBuQ2jFg9n6FMo9QQMInpF0dXJluYF8oBGQdh+YMT2lKKMYr2W
         GdpP1VupeagajEQLU7asw7ovynPCh7IH4ALCNamt2LAZCeyzQNhmGauF9xrQQ2Acuuk0
         rIDYvBfeMUYg/j60l1/qChuRx1rT8XOY5Nx7rMSfoQWUdTj5+NMiyMR9grIruK6r52WG
         g1XQ==
X-Gm-Message-State: AOJu0YzKKSQnbyiwrbDh4Dpx7W2uaeYwpPDfeJzqUBtX4W//CTq+GOeC
	ruoioTYHOuwdL+MIS/ycUANky7LplEW2q/lUaBiuSFmGNEsjWOBYf9j0CO8o
X-Google-Smtp-Source: AGHT+IESyjjlw1PQUIY87nmi5Y7reGJjKBkLZvTJp92165UObjIKNY8tKB+xzQyUoqxUjGg5cwS8gg==
X-Received: by 2002:a05:6a20:9f9b:b0:1c3:b61c:57cb with SMTP id adf61e73a8af0-1caeb360b32mr1181311637.53.1724316094033;
        Thu, 22 Aug 2024 01:41:34 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340449sm881692b3a.218.2024.08.22.01.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:41:33 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: check if bpf_fastcall is recognized for kfuncs
Date: Thu, 22 Aug 2024 01:41:12 -0700
Message-ID: <20240822084112.3257995-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822084112.3257995-1-eddyz87@gmail.com>
References: <20240822084112.3257995-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kfunc_bpf_cast_to_kern_ctx() and kfunc_bpf_rdonly_cast() to verify
that bpf_fastcall pattern is recognized for kfunc calls.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_bpf_fastcall.c         | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index e30ab9fe5096..9da97d2efcd9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
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
@@ -842,4 +845,56 @@ __naked int bpf_fastcall_max_stack_fail(void)
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
+/* BTF FUNC records are not generated for kfuncs referenced
+ * from inline assembly. These records are necessary for
+ * libbpf to link the program. The function below is a hack
+ * to ensure that BTF FUNC records are generated.
+ */
+void kfunc_root(void)
+{
+	bpf_cast_to_kern_ctx(0);
+	bpf_rdonly_cast(0, 0);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.45.2



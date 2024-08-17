Return-Path: <bpf+bounces-37407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D59554B5
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 03:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710A2B213F6
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 01:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39CC8F6A;
	Sat, 17 Aug 2024 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFqwNxzZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871E79CF
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723859521; cv=none; b=SFBkcF9H8VguqYE5eNKWVX1SdIhdnoNzbe1bXWJ6hFk7S4aad+qZxqh3d5ppV5PC8k9wt3ZuhqGQ7BXTai0xrNg5Ek9G1oqiujnU/JWUjnq5bh3s+SPrRFNa2YMWrD5f5UHy1MDNf6S8FpHx/T6tMjKVqXnEHcr+sVrJ5sGJQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723859521; c=relaxed/simple;
	bh=Thpy9YX+DVaExsU9bjF/wBKqXZ9LSeLGadjAHvaTFzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIw4DWucRkOaa3PMkz9SWnTHhmWWhiGrZkMJJtcA6Xjxz4CaXNlDxiOo/r5lFDOxXZdk1lzcZ8m4eC6EzCYMvOnAvccTK405k1+6wYWYskMRjHel4MMbWRPgpK6cefuoadJKxpsnmDE6t1/voPeD4inyPiw4FQSD5NNytTgvt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFqwNxzZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so2217693b3a.0
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723859519; x=1724464319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXSfRoeh2zyaYVXkRxqAaXsnt4vk8OaDv0L2mfVTOgk=;
        b=IFqwNxzZMTsdH37mE0nT3agFB3GUqh9tCOeeK4m+7wXw5oEx8tk76tQq2PyfKKZwtD
         p8LTcoKpf6DEdrDTuxJXKydz95IB32RYz6TKaNHWtCpgIEzCQZ57mjrXeJgNB76PpE8S
         nWhpCPeEnpY0cVgNnODlhFt/6+zr70rieamvyU8oVQW2nXp56HxMrqRlUzCiYRpj2t5T
         KrmWSDt1OsaAocMjJBHjsN0bPgmoilg3VSQiiE7PwFGq15pW7W5cGMatQAxjt09LMYcO
         Wzk87Fz5107NX+JxqreRw+2KOBJQyArqOFYxFDwTzTtSPLxsNBkplVUgwqhxjmqvtf4J
         bKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723859519; x=1724464319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXSfRoeh2zyaYVXkRxqAaXsnt4vk8OaDv0L2mfVTOgk=;
        b=U0EIbcLY/uwWfIp+hiMyQusoUXUHJoMk8IzVPiWI1etaR0sxHYRCkb/8Q8iVyA8q7r
         mmLRo7adfVp04X+ondSw9TDPO3lSgcXfM7f9qi13VhZzEpXoAES4K2K5T9+SA+Kukj4s
         d4534uFpXWvy9ibqS+1plHJJDvTeqWVbZLlxXTvbEkXVeWAreNK84n+lJ5vAwARQAhXn
         mXEpXa1QsX3aTrnVoZqOwqsDrfMR0qaKeRrNbZhkwlmhbomopgDUjAf6yLBl3RurIPeC
         thAI3FB+0lr6fuvZoiFYV2OTQpbqLg8dAwy8ISIkIedW780unAswm8A6JA6n1xKhiCaS
         TzUg==
X-Gm-Message-State: AOJu0YyUw/JeQsrTmyCpAhqZS3AXHODoOGU15I5UNk4PlFqpbdVz3mJe
	3NxZHRPkeKPKerVgzVuDt2Lv04fZdewHzVCvTL9uyy9q5r7TtboO6YhxbsNIPvM=
X-Google-Smtp-Source: AGHT+IFSgt0+PWYAcuQNQdhcNDViQ36TFJqy5yp/Sghz/Fv8ZInvo5BD5Wj8LHtbFeJh7JnUqZ2CVQ==
X-Received: by 2002:a05:6a20:c90d:b0:1c8:92ed:7c5a with SMTP id adf61e73a8af0-1c904fabe2cmr6366941637.22.1723859519251;
        Fri, 16 Aug 2024 18:51:59 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356ad2sm3598887a12.69.2024.08.16.18.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 18:51:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: check if bpf_fastcall is recognized for kfuncs
Date: Fri, 16 Aug 2024 18:51:40 -0700
Message-ID: <20240817015140.1039351-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240817015140.1039351-1-eddyz87@gmail.com>
References: <20240817015140.1039351-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kfunc_bpf_cast_to_kern_ctx() and kfunc_bpf_rdonly_cast() to verify
that bpf_fastcall pattern is recognized for kfunc calls.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_bpf_fastcall.c         | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index f75cd5e3fffe..97c2420ccb38 100644
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
@@ -793,4 +796,51 @@ __naked int bpf_fastcall_max_stack_fail(void)
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



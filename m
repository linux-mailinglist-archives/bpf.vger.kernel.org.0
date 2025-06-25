Return-Path: <bpf+bounces-61565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B1CAE8C52
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF913AA942
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9982DAFB3;
	Wed, 25 Jun 2025 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKg4E0jk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF02D662C
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875873; cv=none; b=E3CfPs8MsTTpXXiYbbBb+YBIr5Zp5aO9AFPPikLE2FACLiNsc5zkazlAIWh+FIQMTEAXKwDCsFQqm/oO1gSggXLaa+TcV93y7ZytcBjJOo6luO+3eso3FVkU2TefBGeC/e+ORx/mLBdwxFIjhtzVz0rITwfc/SwqVFooS+TVLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875873; c=relaxed/simple;
	bh=nEwOUyO5jx+o9ipj2+IQ4vFzVZHxahzb7hzryFgIimg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhGR3WiujnWWTerltyoFlBJg+nyzUIziaX4sG2UdhNxUqY5zGO1nSEBWU2s0aWMcnElDxxkigkB9aMhwAmS9gTM05ZY+wUnFQVfTt5btB2tgkVaDQwrMo1SKwAJM0k8jgSXK76QzGzW/Ps7F2MFGPwoU55Eo/aB8olmX3dkZWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKg4E0jk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31c6c9959cso181009a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750875870; x=1751480670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI8lSZd9S0E0PCDhmy8OtPFHByW/OsHmXaGWem3jUk8=;
        b=jKg4E0jkzj6PmJuQAIvFThVtp+Fl84fBy9f5SpULVYbuaTvVcYK/4/Iby+XONXHysU
         PaltsS7UN3s/+p+qbyq8G5FxE87DKCP7r+OK+oR4NOB+UmjSMJwHGhB+HnnN090IHZcN
         EqyQiUNPnHmc+dUW+n30mlaH71XzQg5+FeWqRHVx9bSIUU/BZsoG9tWNVNMzO6mOcT9u
         HAet65xtXBhbc/V/gBc85EleYPv8KjrEhlGB45j8BnhznbiqZbU2PdzCI/FxLn2+D1ms
         Z1OccLLlIHjHYkQexvA3TWEh/gyT7abVxQ5i8KexQ1dQDPhWsVFpIsSh9N2O0y79A3/4
         ZgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875870; x=1751480670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AI8lSZd9S0E0PCDhmy8OtPFHByW/OsHmXaGWem3jUk8=;
        b=n3hiLzlL9uxzHvkEtVFcfenq/PE5jwhnaV+92tjGrDouODlTe2rPWIXxmiwVOW4/qp
         vAVzhxJqaJlSuRJgFMxIgIsyDIuT7Fkr0AmHs+nIy0TkUgkAYoWNTDhjs2rM0G8YV2qV
         og4NQmilOlpngliviXp+/gzUeG2UfR4z66wVfBuYS44naNOlZBf2nlCCV6qETa2WXuH9
         QwcLF0vfrpttciRL6hxpNeZgXrm/PXWFgEkI0eUAQE6v4aE6xXPvvr1ZhbDu25FkQj1q
         1VPCEzw9qSxTddcnAOLOrjfyogyiupLzBu0OJ7WxwtzcLVlFnsrJZlgU79C8osqlRwxo
         gabw==
X-Gm-Message-State: AOJu0Yx0HQLdNBs/Sa0U3UZ6qpZtyUhxDmyVQpeoUpuxnQk8Hg04S3z0
	77690EWyI1w5V0MKYeS6dopyiA9TC8WaQUm9m5Ccil+FsfVp7mtsAZdByPTOrs9/grk=
X-Gm-Gg: ASbGncvCXxZYg1i4xtFjBRs4ythXI7RrU1riPKYvnQyX1W+qPZK/QOCwhEW6ffXgowN
	9j2Ioy35lVZIyIzBWNI3+ROUjC1gAjUEJKhUVcLeFqYqd8kwI9ePr6m1Vn9Kl+Iu+mKqe3vK/GZ
	50Q2LBC8Adx7lL49jy0VtiO/zCpgV9OiL1hnNf8vZbb5Zp/w+jJQJIpfD8xZ0QAioSs150v7dZc
	KmyVR0SSMibTKCjlS8Nw/KOBRlEtJRU7/8f6EWKDfICLgS+LH5lGqqiUAKl/kuF1ohuI8/K1Ro3
	3VfFGpOqzIi33uXLuPi22pE2LI42wItNnBJsFS9wGJv/YQxVzDlaW8yY+VuejLVT7NPaZy4/6/6
	HBcALDqEjtg==
X-Google-Smtp-Source: AGHT+IED8Q67PVJQ7i/hPddid2jeq/EjT7s9Silsgjl6897DEmMkKO/PfgW64zwdzRuBpwml7wa9Zw==
X-Received: by 2002:a05:6a21:6e4a:b0:220:1af3:d98f with SMTP id adf61e73a8af0-2207f28ba73mr6468224637.26.1750875870306;
        Wed, 25 Jun 2025 11:24:30 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258b4asm13322939a12.60.2025.06.25.11.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:24:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: check operations on untrusted ro pointers to mem
Date: Wed, 25 Jun 2025 11:24:14 -0700
Message-ID: <20250625182414.30659-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625182414.30659-1-eddyz87@gmail.com>
References: <20250625182414.30659-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following cases are tested:
- it is ok to load memory at any offset from rdonly_untrusted_mem;
- rdonly_untrusted_mem offset/bounds are not tracked;
- writes into rdonly_untrusted_mem are forbidden;
- atomic operations on rdonly_untrusted_mem are forbidden;
- rdonly_untrusted_mem can't be passed as a memory argument of a
  helper of kfunc;
- it is ok to use PTR_TO_MEM and PTR_TO_BTF_ID in a same load
  instruction.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/mem_rdonly_untrusted.c     |   9 ++
 .../bpf/progs/mem_rdonly_untrusted.c          | 136 ++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mem_rdonly_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/prog_tests/mem_rdonly_untrusted.c
new file mode 100644
index 000000000000..40d4f687bd9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/mem_rdonly_untrusted.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+#include "mem_rdonly_untrusted.skel.h"
+
+void test_mem_rdonly_untrusted(void)
+{
+	RUN_TESTS(mem_rdonly_untrusted);
+}
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
new file mode 100644
index 000000000000..00604755e698
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+SEC("socket")
+__success
+__retval(0)
+int ldx_is_ok_bad_addr(void *ctx)
+{
+	char *p;
+
+	if (!bpf_core_enum_value_exists(enum bpf_features, BPF_FEAT_RDONLY_CAST_TO_VOID))
+		return 42;
+
+	p = bpf_rdonly_cast(0, 0);
+	return p[0x7fff];
+}
+
+SEC("socket")
+__success
+__retval(1)
+int ldx_is_ok_good_addr(void *ctx)
+{
+	int v, *p;
+
+	v = 1;
+	p = bpf_rdonly_cast(&v, 0);
+	return *p;
+}
+
+SEC("socket")
+__success
+int offset_not_tracked(void *ctx)
+{
+	int *p, i, s;
+
+	p = bpf_rdonly_cast(0, 0);
+	s = 0;
+	bpf_for(i, 0, 1000 * 1000 * 1000) {
+		p++;
+		s += *p;
+	}
+	return s;
+}
+
+SEC("socket")
+__failure
+__msg("cannot write into rdonly_untrusted_mem")
+int stx_not_ok(void *ctx)
+{
+	int v, *p;
+
+	v = 1;
+	p = bpf_rdonly_cast(&v, 0);
+	*p = 1;
+	return 0;
+}
+
+SEC("socket")
+__failure
+__msg("cannot write into rdonly_untrusted_mem")
+int atomic_not_ok(void *ctx)
+{
+	int v, *p;
+
+	v = 1;
+	p = bpf_rdonly_cast(&v, 0);
+	__sync_fetch_and_add(p, 1);
+	return 0;
+}
+
+SEC("socket")
+__failure
+__msg("cannot write into rdonly_untrusted_mem")
+int atomic_rmw_not_ok(void *ctx)
+{
+	long v, *p;
+
+	v = 1;
+	p = bpf_rdonly_cast(&v, 0);
+	return __sync_val_compare_and_swap(p, 0, 42);
+}
+
+SEC("socket")
+__failure
+__msg("invalid access to memory, mem_size=0 off=0 size=4")
+__msg("R1 min value is outside of the allowed memory range")
+int kfunc_param_not_ok(void *ctx)
+{
+	int *p;
+
+	p = bpf_rdonly_cast(0, 0);
+	bpf_kfunc_trusted_num_test(p);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure
+__msg("R1 type=rdonly_untrusted_mem expected=")
+int helper_param_not_ok(void *ctx)
+{
+	char *p;
+
+	p = bpf_rdonly_cast(0, 0);
+	/*
+	 * Any helper with ARG_CONST_SIZE_OR_ZERO constraint will do,
+	 * the most permissive constraint
+	 */
+	bpf_copy_from_user(p, 0, (void *)42);
+	return 0;
+}
+
+static __noinline u64 *get_some_addr(void)
+{
+	if (bpf_get_prandom_u32())
+		return bpf_rdonly_cast(0, bpf_core_type_id_kernel(struct sock));
+	else
+		return bpf_rdonly_cast(0, 0);
+}
+
+SEC("socket")
+__success
+__retval(0)
+int mixed_mem_type(void *ctx)
+{
+	u64 *p;
+
+	/* Try to avoid compiler hoisting load to if branches by using __noinline func. */
+	p = get_some_addr();
+	return *p;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1



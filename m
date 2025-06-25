Return-Path: <bpf+bounces-61471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB5AAE739D
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473FB1662A4
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82E10785;
	Wed, 25 Jun 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzqQseZc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F67F9
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809927; cv=none; b=k1ZKlV46JRSo9oDwOb8hlnzzujSBfvwevcOROwjYGNG7qTOQ1h2JBA1WRHdz04mV/0mvKyE3NMS2NgCwzms1F0rScMvMKjqIYva5/LfOvSIz+peHlww7EEwMwpSEZNlCwqe7WtkkfZJ6vpI+PaKRWqXnsDfZBrNKBIFaR9S/+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809927; c=relaxed/simple;
	bh=nEwOUyO5jx+o9ipj2+IQ4vFzVZHxahzb7hzryFgIimg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr8v8VRs9UpSBe8vK4wfKzEhI2HwaLhT3VRvXA0geYNolvS/Zjpr62BH3AP6yolf8o795hHs75U5N0mVrfaN1wVAah4MDTNPRSBLV0xwOm0NUHCee3/rxDvCrgFxwFeW72yrfGYmzbk6t0xO8EaYZGzVBC7TupVlHdmwzKomkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzqQseZc; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e731a56e111so5134131276.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750809924; x=1751414724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI8lSZd9S0E0PCDhmy8OtPFHByW/OsHmXaGWem3jUk8=;
        b=FzqQseZc/gKLkuCe2HnLeK58qrEfcHQrmZJXVWmasePYBUmXJRuHbCOXrCP2KxJbq8
         nm80rQ75PcSPL2k6islg67ItfzMrRqIocAReDvK9r6uMEAhw/P593VLBTMUgcpKrGRqb
         6a5yidOhp53P2SkjZT1LYEm7oNv/eQhbFysgKsDVTwo7cCDJpg/I2Q2NwfCV7bGv6rkq
         WXsb6HSW+J/9TPimEFQdmFIe/xL1aEN6e1bH2cZuYZ4xY2aBLZBcBY+CvprpDmdYnbKM
         CWlF5wruzTLdri8B2cF2i3LJOjwb0r46pIYklD+2psPy+gN1oUvyXQ0rx7pEqJY9UsBq
         lcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750809924; x=1751414724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AI8lSZd9S0E0PCDhmy8OtPFHByW/OsHmXaGWem3jUk8=;
        b=S7pHYl75gYm4ueYGcbBOvl500K3cpQx1LgJLRqOs9kB5eMI2TarGmnp6bwcyxdEutW
         tqv5Xad8VFmDH5zM+7pNzKZDwAP33y4wUjH16pkwihBDBZ2EbBpYSnZhA+9DCFg4z73Z
         gIu3KqvUXtuxPb4buptilsHdSS8fvF8d7e9gKIRmWrcBSbFLRhS4IcZNBtG6F/igiN6w
         FxlfZXhjAna2mkeuxIbqVw41XAU3ztqN3AeKr4D9q+rvcjsxGdYZqHB3qkIB737Vu6Sc
         WC4vHNq+eY2JbSvWYSz0tyU4Z4J1ddti7P3vR36XfV76mw0FDVRgRdnYaKGldCkw32y7
         X2Xg==
X-Gm-Message-State: AOJu0YxbEjQ+UmHH916pkNeIIrlKFHW2r1Zaq4Bb+xSP7xlfDzfmesEE
	N+sDb+HUnNb5wVORXmV5gkLc06j2wkql0pci5qyRxLuRXH8KYiPtxTp1g8ce7V/q
X-Gm-Gg: ASbGnctSxM4tALEcqb+0ZdlBJXdMgDGSh/IxuBeONmZA4qdvDWgsENWVrQCigoAcMq+
	j1sduAMmAiCCDw6JcXcgK5Yg5ArRvOtlczAHxFr3VIWsXTsKiEiJmSKKclMZ8vsL3kZO2huEaiU
	IO10ATXI4t58wgJfMcFNDGn58liBuVz/9PQ2OF+99O7TPTll/+7Npxwdv+Qj9MqTuG5qkg4ltp5
	yBGb79bSG06ZosBmfjVeECiPiYqENkjLBNzW8bmZ0YeRLhVZSZSPGrtzQ/YW2sy/T2eB7YmfZs9
	0v1dsZXyv3O9UNNzpfbw/94eKuwgkd7RegwhYDiRJpec5DAZ+PZyOQ==
X-Google-Smtp-Source: AGHT+IGJE9xzkWR3NN7bpHvgtw+s/GOVCWVMf7VSPkhcAbMlgchI4l1+71wwOa8wDKS7UucXOkvasQ==
X-Received: by 2002:a05:690c:892:b0:710:f401:2fd8 with SMTP id 00721157ae682-71406dd4b54mr14958447b3.30.1750809924445;
        Tue, 24 Jun 2025 17:05:24 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4a238f6sm22208207b3.48.2025.06.24.17.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:05:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: check operations on untrusted ro pointers to mem
Date: Tue, 24 Jun 2025 17:05:20 -0700
Message-ID: <20250625000520.2700423-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625000520.2700423-1-eddyz87@gmail.com>
References: <20250625000520.2700423-1-eddyz87@gmail.com>
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



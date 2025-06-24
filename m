Return-Path: <bpf+bounces-61425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D2DAE6F3E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE417F89D
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699EA2E7F39;
	Tue, 24 Jun 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fda/ezbA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C62E3399
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792222; cv=none; b=WrUpzHsS6sQR1XtfteaRovir5vsxjLYahDo8i9BT5/F65uUkykj5+lW7ZGBkqblH4Vr8jkDzveGxPIcjI8ccvvqjrzzxe2+4BUrIWbq/2g3qiXTzYiwIRWXlNi/bSOvZYFpTHF/oh80UGkOice/KqaVYz939j+8Hr6EX1yrPfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792222; c=relaxed/simple;
	bh=CT81V18/d4WfZTSCxM4nC9x+/7crdQrYy3sIci1Al5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxnOETwQA7Qx8YCZtdyZCrqEoi0CBPdCw+mKhrYZiYl9EUWuwmfWTVubHlpDw4AKm757TgzvYJy8rN28j7crn6NsA+oH3y2/6ft1E1L31ROEGwqgqOBNSyhbh3FkaddT83BU6A6qHkW4066N5spLF9tUR652aV5Zk3tvIiejA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fda/ezbA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70b4e497d96so56358247b3.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750792219; x=1751397019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDTAzxfllkMvrIv6zC//kO6UoQPAUsc5i2utsUSDJBE=;
        b=Fda/ezbAZSMT087fXjk0lkc91bVdulif2X0gD616whBxdogjXAOfg8INGmndfBO3Pr
         fI3ZqQhpUbTHn5Kn+Dav6JkEy/vMNGW7cgTpin5SPRNqk/GDodsWfoUdmf3XtDcZYQ1o
         L+1z7vCZ+/5SUGFH6QrpSWbnTbcyY9YW3BGtlQzbXTcxxse2ls2+H2HdxFmGW/boVI6v
         FifTJj9/st0aar9JY4XI8As9v0IqHXUPakoMVaV8diiPXMEYEaVqLD6oJpVuXGS88YZw
         CSu9G9lLXLmnJd40lDHOtLEsihts25Wsl3zvo2bifJ5vT6iOdlmA3QJrIQ8IiDECzuKf
         ZsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792219; x=1751397019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDTAzxfllkMvrIv6zC//kO6UoQPAUsc5i2utsUSDJBE=;
        b=PuyEbM1NdxOni/pu78jyuWANb35QEWZzSVa/wuaE1h2U44SFfCkD3VvUPyAgMQaTZI
         ukf8OEfYwwRnGPEvmxEDW8ZY9Bf3KRscRMNHiCzQRLUd5/4+cMQLnPVip98VgRBAXuXr
         nPQ3MyjuJlRgSnyESWrq0dQAENG5U5lNSsVWSXgWOTN1ll7Kp/TQCjeQUJZpGJjr/B4L
         Xrto6B+9x3nKZHSUKkMtrvb/Zsqhl9PwFxFbop+fCrMUUF2NHd+/laqyx3JyZ/eOXOX0
         tn7Wzt+8kFDT00MEZNmYxSOggr1pnlQO98zYVQ71vkqyIwzbGmE1eLUdBI9HCkdjHLEq
         QtpQ==
X-Gm-Message-State: AOJu0YxC56UBeVhgBLNu1Bk45kgHCI5z0o1CkCNH53hgnsrrMQ47KqMz
	RobS2pXsjcZ8MxPuAnsCJjulm9EFn0YuO01D0Wv/ZoCQ/ObJSU9fQIDe/hTfiBJe
X-Gm-Gg: ASbGncsspXy+Chs7NSbn3Ee+pMJA4ArtvCvLnwJupbb3Stjpd+tbiteYODB9sArE7Hg
	IFuEZ2BtNipg0fxd1mKlIbhEsVGhfpQz3VUD9C2/kOfFUHOE6j6FYe8/jx+eVGUKCNbXvb65NEr
	xj70LNM4VDZ4yXEXC+e/8uDlxt/4T3HIktnhCDE57Y/46fb+lsZKnSWfCbPSVqPkDiNm3Nl2civ
	wWvSMrpx6kbXb9fxIq9Ug/V+v5c5GQUN6FZBecGv/ut+LOOg6mrpKIIrVblxg9TeVypgsj8ZVdy
	34TuNib7xA7zIU80FmKPCNHQ+FRnExvZki09Ox3XQC4bhWbb+EUFnw==
X-Google-Smtp-Source: AGHT+IGU3gy3pP1zDQSgDN/45FYMY6QOHZvTCK3Cx+idHTWPUlXXoBUQs/djSKLVbPFe18kjrFFkiw==
X-Received: by 2002:a05:690c:6004:b0:712:c295:d013 with SMTP id 00721157ae682-71406dff22amr1243427b3.34.1750792218902;
        Tue, 24 Jun 2025 12:10:18 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c49c0c30sm21227287b3.7.2025.06.24.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:10:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: check operations on untrusted ro pointers to mem
Date: Tue, 24 Jun 2025 12:10:09 -0700
Message-ID: <20250624191009.902874-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624191009.902874-1-eddyz87@gmail.com>
References: <20250624191009.902874-1-eddyz87@gmail.com>
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
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_mem_rdonly_untrusted.c | 136 ++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_rdonly_untrusted.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index cedb86d8f717..5cb49ba089d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -57,6 +57,7 @@
 #include "verifier_may_goto_1.skel.h"
 #include "verifier_may_goto_2.skel.h"
 #include "verifier_meta_access.skel.h"
+#include "verifier_mem_rdonly_untrusted.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
@@ -205,6 +206,7 @@ void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup)
 void test_verifier_private_stack(void)        { RUN(verifier_private_stack); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
+void test_verifier_mem_rdonly_untrusted(void) { RUN_FULL_CAPS(verifier_mem_rdonly_untrusted); }
 void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
 void test_verifier_ref_tracking(void)         { RUN(verifier_ref_tracking); }
 void test_verifier_regalloc(void)             { RUN(verifier_regalloc); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/verifier_mem_rdonly_untrusted.c
new file mode 100644
index 000000000000..00604755e698
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mem_rdonly_untrusted.c
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



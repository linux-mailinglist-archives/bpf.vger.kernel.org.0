Return-Path: <bpf+bounces-62488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7655CAFB1B5
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 12:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B126D3A4F79
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C586028BA88;
	Mon,  7 Jul 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZH68xKe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E735949
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885734; cv=none; b=GTes6K45xLcuSr6u2JGs6zyAjPrdUJ2ofT8h+jwJ4t0qsdxWIq7wkXQly3toJ4rt9DO1YkJng/UejzfD3W2x+ZY1uCSAsOJrQNU0IL9QWfMJonQiVX7ueNqvHZKuM7qbzQRyzDr5t5QeVx0Gf7EcH4kfBAepFTUR1QYlfTpr6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885734; c=relaxed/simple;
	bh=Lzf1bAFFzi04wYNI0HwLIRDu4rC3q+ASN/cbv/55tXE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DVleY1NxzXveJ4AY8+0zAmzCq4DcRObWRCLaDfDwtWf+fslfhryqbyIoSNPTkuy+gmZMeMV/hzOAo8oxgaftY/Uw0Y/8Z6J8rMX0w3dvpgMah+LAYInzUQRv+oC9odXj6IRKXHTpStJO/TnPdu2o4tJDiNsDaLWybTvHkUxwtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZH68xKe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d6ade159so25004175e9.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 03:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751885731; x=1752490531; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YHPr7WocoPt3HkBuwmqJSBn/YrOT6YrO4avv4Aiqr0=;
        b=AZH68xKec6lr8RTxcmC75eguPaPXT1HJNoBiPUAlRY4i6ztLmRd4mJj1ibOQWIX+gB
         Np1KHZNMWWKd6ldfjve/JKCIpuc8FMKeC8RXi3EE30ZIkOLSwSpCbYviuOKlaTif23p0
         904fqw425Fnxv6eDTqMT4XhXKiPZEN08pkUxnTXAdYU1kylMUJD1ZLmU7L3sjSe0YWeP
         KalMjnA1rndHlHgFePI26sn47VhTCjorJWA2uuJxBtNZipdm5zokLAGQ+0sqWnwOc6ij
         aILOk4m+5B0p73FYizt/YQtLk2FSdBMKB9gqn4HJYlK48iP7Qy3SdJgT4avMI2+ULTot
         pwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751885731; x=1752490531;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YHPr7WocoPt3HkBuwmqJSBn/YrOT6YrO4avv4Aiqr0=;
        b=R0AEgW6exY3+tizHwX+kGPNVZttrVnZk7IxGZqB6gl9Hh1El+PaNxXqUj7GUCdSeqf
         DOpaUDRf0Iz974dV+NM5tx6QYQr+Az2zx5Q+xy1opugJOkCkCplRLsalh0xXJgsTrStH
         7CQiGGrpxhKcSZ2KKhtwoWt4/cHaobMcbg1i/AFakxVGsfDmxj7CPL+yI4emsHQBgP+B
         gCY5EeElcwvEL4jYIL//pWhZQ2gUxbU6b9LZGc2vYhjt3L9zlUSVVPTGFZ6uYxxtX/sv
         72n3QkuhDNvx9nmGdJVFyJ0MDMEH9xUEzkIcILIaI2YbUjMXwpkTlDE8udQkdQyzlEVJ
         UvIQ==
X-Gm-Message-State: AOJu0YzW8fdBh/sj/50wVX5wlUnNVrPzvZG93WwNBjNl+FEB1dB13YN2
	hAJM3J7ts9VOReHHNLQiEW7qWbHSZ0ipLuktl56mM8jLEqQoEijOn6i9RV8i8oW5
X-Gm-Gg: ASbGncsKve8JNqwL/KigyBYdNbROpk6mI9xGfbsffF6Ku0K+MkrMQh9rJVDpmVTvmLV
	cJvm8O4xWwqM1V9rCFp+4wCstkx4P8cjN5SpSc7HMqOTGoCItehIApf/Wcr2NjsrT6gqjGfN+ct
	wuQnYxHr184osTkJzOAGDR/0d2Coyyh+tbbwkVPMc8LmOpRmgTF9py6JS9gMjr8/DJWi7YUgGSi
	2pXtcwtXFg/VCQq4pFci6el7kMEq1BR3nLqCFO9X41w0OhDFjz/wGWe3djSDX6dR990CTtgmUDa
	JR2DKCB7lEf4dvZvVi/4CkOn66QamEn4K0Q8aG/e8olcQ28xybKnJS2Jl7za5d18xRuHgFzoPko
	uSjeUWZj6LvIfaud1G1Cxeb14hHawvW3efP0RKt48X8vAbs54zBLB5QSMrHJR
X-Google-Smtp-Source: AGHT+IHAblbaHMFExA9PUjebju0vtGMr5+4xkMAVh6sX9NOai2846kIFIA5/IbtaGg7XU0ZPe1s79w==
X-Received: by 2002:a05:600c:3e11:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-454b4eb5c76mr82807905e9.28.1751885730610;
        Mon, 07 Jul 2025 03:55:30 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f536999e2663c8dd.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f536:999e:2663:c8dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472446fddsm9926038f8f.66.2025.07.07.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 03:55:29 -0700 (PDT)
Date: Mon, 7 Jul 2025 12:55:27 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3] selftests/bpf: Negative test case for tail call
 map
Message-ID: <aGunnz9AtNe32wC4@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds a negative test case for the following verifier error.

    expected prog array map for tail call

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v3:
  - Removed BPF_F_ANY_ALIGNMENT flag as suggested by Yonghong.
Changes in v2:
  - Moved the test to prog_tests format as suggested by Eduard.
  - Rebased.
  - v1: https://lore.kernel.org/bpf/7cec754c8d4cc2d93a50e9091d7ccc7f33d454d4.1751578055.git.paul.chaignon@gmail.com/

 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_tailcall.c   | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c9da06741104..77ec95d4ffaa 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -85,6 +85,7 @@
 #include "verifier_store_release.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subreg.skel.h"
+#include "verifier_tailcall.skel.h"
 #include "verifier_tailcall_jit.skel.h"
 #include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
@@ -219,6 +220,7 @@ void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_store_release(void)        { RUN(verifier_store_release); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
+void test_verifier_tailcall(void)             { RUN(verifier_tailcall); }
 void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
 void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
new file mode 100644
index 000000000000..e58ca0cdbeb2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+SEC("socket")
+__description("invalid map type for tail call")
+__failure __msg("expected prog array map for tail call")
+__failure_unpriv
+__naked void invalid_map_for_tail_call(void)
+{
+	asm volatile ("			\
+	r2 = %[map_hash_48b] ll;	\
+	r3 = 0;				\
+	call %[bpf_tail_call];		\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_hash_48b),
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0



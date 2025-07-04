Return-Path: <bpf+bounces-62401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923BCAF938C
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1EE6E1170
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6242D63E8;
	Fri,  4 Jul 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yah2mRDq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75E38DDB
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634284; cv=none; b=VR9M777/ynYkpJGPH9Ue/lIjyQtW6JsNxEZaln7JgZHNugxPAgNWgtBzzttZDHfd78yjDnjV36OSLkf7bDfJT99UEb3GOFf192f1+vYy4UD1WBGirvFSThMn5sZh8KWgjgXROSrTzUHB6Czeg9YgrlWuQzQ7+dum2PnYp393ze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634284; c=relaxed/simple;
	bh=FJQBLUgxoUBMr4kXmpqi9gDzka0VSdZ+I1U7BfTjl4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m1h3WDbsvtrRdLpAUw3IlP8cNUpJtIC660Km6gjvbmgtK0zBr0GHDGyWP9zApxF6o1PosIJ/P7Lap+VPyBIHZhdJ4t3i7M+lqI/vk/ySOuKsxoCKz4OkZcUVX6RJWhcO4oGNio0kDHWeKLGv+vJ3Grnz+CvwAocuxpm945BM5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yah2mRDq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453749af004so4410635e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634279; x=1752239079; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAuNiJ62X27x2g4fuV8ektirIyRZ+wo4eysGjhbIpuc=;
        b=Yah2mRDqq8uEj6LJnKybzeun2N9hFUpCwzbmwuE4zDcyF2wQ10CIM2neHyGH8VUPQ2
         /xiGZFm2/Y+iyU/fHF9yEidKMglTmBzCil9WGBjWwPbHk2OyQ7GDAzuW3gDaTNPKCBmA
         mmvX2sjCi1+3jkaucwxWlv0NP5an6IFiEaY5q8DvjoRHYyZvw+Y8vph9ckI2Ofqg12B3
         Lnt1r0cP4s4klIf/FReh8xyyawUuW9w+uPSbArmKNE4pPYtpA5N5hKGVjRhOS4KBU4u+
         0vtSwQo5TIG1Ax1KiuEH/+eBPC2jJDthF8vgGeBsvk6Mwg0R0OtoluaHMbzUWIUxmt9B
         RQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634279; x=1752239079;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAuNiJ62X27x2g4fuV8ektirIyRZ+wo4eysGjhbIpuc=;
        b=vexwsr/V9C1/bPZfRBMDaynqHZjLcLlqLFKCm8nAJgP38V07xZZ58M01U5MQRm93fY
         Hdl4oAzE4TvRL6bFjFvfZczLXzckfius2BGiBJiKR0imIZAP9nDa+67bRVyN/aVtaPst
         eg96H9OkzoA7bwZcTW/WyAI/9cEKoWv+CT7jfAA7/3/n5hWVtUMsMW8K6Eb7NxJBryQJ
         Gph6N2QmqGLKTj4Xn49zLJryEmOr8AdH1JM4xvzXwLUtASIb4nYvHKcX3CYJ+Iu0Bbd+
         s6ucjFdvVEA0Dybf1SLRWEwG9Q5OyK05/Kb+GZe330QBIqEt7JF1Q/1gP4EYQI7ltmnR
         SiyQ==
X-Gm-Message-State: AOJu0YwgKGQUbI0EzpU5T1SaVUp/gswYco5TsE063eL1Qm6IlEG8v8e2
	izBBgYwxv2LmJDMO8RCeKeHwHiQOecAHlwuSPKUL3aZ1zH8xN9oU3l5ubE99f5kF
X-Gm-Gg: ASbGnct4KLe7Q0QfgV2QtYa1tWNJO/XfG8b3Sl+rpL3f8ljSjvEX2CpaOQfrXdveXrn
	y/mGLBMkh9BD21Joao8eZyaQR/zg5vIAncQ1hbitWwNaU84+80zP1oTUx0xZpuXfaRfSyroAlMn
	/i+JajBEesnYVMPnCgK5BhzXKH2WEi/ptSrN/90MGdmepMsa+JLHLJO/0SOKqGV+ftYxMPlaIBE
	cmvFaOPRNC7EOrYF1EEj5PeGgji5r7TQwFkT3zAqunCEApWbu/XpleyBxilzfhYDKwBZwb+hUGX
	gEXfRgamsG6S9p7SFlbD/Ex8vqB8qLnSn4QmFoKRHm0Ik03GGkUkN1Cgd3u5xDDzO/F9kkBXl1Q
	zB6kfV0mjutio7S05BO2CFEF5ECO1Ph6u4AwBeeiEFRSGiLSuPQ==
X-Google-Smtp-Source: AGHT+IE5bcjli8AvNtZeJoTmx/tESWkszK/zbM1QfYBfd/F1bvk1ySRyEYZmjmxxB5m/LKMX9ikZuw==
X-Received: by 2002:a05:600c:a41:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-454b30df102mr31746265e9.18.1751634278681;
        Fri, 04 Jul 2025 06:04:38 -0700 (PDT)
Received: from Tunnel (2a01cb09e0612408276c52a81ead4591.ipv6.abo.wanadoo.fr. [2a01:cb09:e061:2408:276c:52a8:1ead:4591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1890626sm26626005e9.40.2025.07.04.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:04:37 -0700 (PDT)
Date: Fri, 4 Jul 2025 15:04:28 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Negative test case for tail call
 map
Message-ID: <aGfRXNF7Ns5xV044@Tunnel>
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

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Moved the test to prog_tests format as suggested by Eduard.
  - Rebased.
  - v1: https://lore.kernel.org/bpf/7cec754c8d4cc2d93a50e9091d7ccc7f33d454d4.1751578055.git.paul.chaignon@gmail.com/

 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_tailcall.c   | 32 +++++++++++++++++++
 2 files changed, 34 insertions(+)
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
index 000000000000..662a6528ce4f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_array SEC(".maps");
+
+SEC("socket")
+__description("invalid map type for tail call")
+__failure __msg("expected prog array map for tail call")
+__failure_unpriv
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void invalid_map_for_tail_call(void)
+{
+	asm volatile ("		\
+	r2 = %[map_array] ll;	\
+	r3 = 0;			\
+	call %[bpf_tail_call];	\
+	exit;			\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_array)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0



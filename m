Return-Path: <bpf+bounces-54540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6041EA6B96E
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 12:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AD417E3A4
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B2D215F49;
	Fri, 21 Mar 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aXbsNT7R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3C21D3F9;
	Fri, 21 Mar 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554899; cv=none; b=O9SUSn8ppOJuVYP+XEWZQmmJGCH283yGT7j+MxLAjq2vSyYt1KyvZiof7f+kp7LXPN+nki0pRvf/t4j0o+p5trQEWQsWcjoWct0msHkAQ/oyDd8XHY32L76YYbgaFmZbMkLtjhrT6iNly8v1iPYljZIbf/y289zPeyDjOo+DAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554899; c=relaxed/simple;
	bh=MLZGkAu21+LrNfYE8W9N0lqdqbSpjCAY2PAxJhbl/TA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Agel6ydUGHpSap22fclddquzxp5aDjLDbTXe/bDDjLv7yAgmrbgTVxfy0aBgQ5PYCr6ROPYuLxITM5A7tIRIupeXJBcBy3r6/tqOb9uwFP6Lw3Lib6d8v3+F8tgY+qZO+w3oTieBGGqCIUzYLNLMI+aCsGsKIf6+DGMz1FORItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aXbsNT7R; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742554897; x=1774090897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JgQNipmoxhOuZI3ANfSPfGYnk4m3ske6t9CpDLDmP8A=;
  b=aXbsNT7R9ZWfwUA/3WKJvS48bGtxMi4pHAhDa0AxDgHnz138AReXOh0C
   9KB5wI+IUENmOplOLlFnd7+piZVgC/2NjbxGSKntpwasShTG277Isc5m3
   fWBrHwCJJMfvEnkjEUAjpk2kAnn7dTHmTio6O2uVOi7zIHMDecCri2tsg
   c=;
X-IronPort-AV: E=Sophos;i="6.14,264,1736812800"; 
   d="scan'208";a="183940194"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:01:35 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:40086]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.119:2525] with esmtp (Farcaster)
 id 495d2d0e-8411-4dd0-8ab9-1e9f2da7a24a; Fri, 21 Mar 2025 11:01:35 +0000 (UTC)
X-Farcaster-Flow-ID: 495d2d0e-8411-4dd0-8ab9-1e9f2da7a24a
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 11:01:35 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 11:01:29 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Peilin Ye <yepeilin@google.com>, Ilya Leoshkevich
	<iii@linux.ibm.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for load-acquire/store-release when register number is invalid
Date: Fri, 21 Mar 2025 19:59:02 +0900
Message-ID: <20250321110010.95217-6-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321110010.95217-4-enjuk@amazon.com>
References: <20250321110010.95217-4-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

syzbot reported out-of-bounds read in check_atomic_load/store() when
the register number is MAX_BPF_REG or greater in this context:
    https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c

To avoid the issue from now on, let's add tests where the register
number is invalid for load-acquire/store-release.

By the way, I chose R11 as an invalid register but there's no particular
insistence on this choice as long as the register number is invalid.

Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 .../selftests/bpf/progs/verifier_load_acquire.c    | 14 ++++++++++++++
 .../selftests/bpf/progs/verifier_store_release.c   | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
index 1babe9ad9b43..e3912d2c6f95 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -189,6 +189,20 @@ __naked void load_acquire_from_sock_pointer(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("load-acquire with invalid register R11")
+__failure __failure_unpriv __msg("R11 is invalid")
+__naked void load_acquire_with_invalid_reg(void)
+{
+	asm volatile (
+	".8byte %[load_acquire_insn];" // r0 = load_acquire((u64 *)(r11 + 0));
+	"exit;"
+	:
+	: __imm_insn(load_acquire_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, 11 /* invalid reg */, 0))
+	: __clobber_all);
+}
+
 #else /* CAN_USE_LOAD_ACQ_STORE_REL */
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
index cd6f1e5f378b..2dc1d713b4a6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -257,6 +257,20 @@ __naked void store_release_leak_pointer_to_map(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("store-release with invalid register R11")
+__failure __failure_unpriv __msg("R11 is invalid")
+__naked void store_release_with_invalid_reg(void)
+{
+	asm volatile (
+	".8byte %[store_release_insn];" // store_release((u64 *)(r11 + 0), r1);
+	"exit;"
+	:
+	: __imm_insn(store_release_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, 11 /* invalid reg */, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
 #else
 
 SEC("socket")
-- 
2.48.1



Return-Path: <bpf+bounces-54567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD483A6C79F
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 05:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979A81B61C3E
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 04:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D801519A0;
	Sat, 22 Mar 2025 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BW/JDLy3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93782E339B;
	Sat, 22 Mar 2025 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742619303; cv=none; b=ZbTmaicqOY2sAObXLIyzjfXL5vwxdvRGwlALQdC/HJ4tbLZL9+vuoFcNwFyb5BUPqjyu5Eto8iTwJtYaysJg6a/ktQzJDiSpgimbuWo67CvJmACFPntYUmeGFMdwahLHNba0hffcBVabJIuTBRnxAdNge7fGlzj2XFCwqcUzOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742619303; c=relaxed/simple;
	bh=/BANrqohcaH8gkslBYw6uDTdmQqSYjo1r5cLL91blqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiZQ+cjzf4m0ZqZeAbzsl/C1WvZr0oDwD1cUh5wEz8fJ24SiHp9TAw2P97KTZdx4x8TsDdWsA20eePE4tspx1JuMVEgeIL1r5+Co2A3LXoQYkzFe38/7sEToVVMkJAuoFcjcAuKpN0fkUGXTrMSDCx4x4DanwYWlcUyDXnUx64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BW/JDLy3; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742619302; x=1774155302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=alxkgRk2YP28x0I/t2md9n8GWPrTMSHqZ0tB261Lni8=;
  b=BW/JDLy3OYSQrs9dclWKArGFP5LhJH735mgNkpgKunlWHyAN0YgA5rxf
   UmeyMJi8mchsB0JM5uNd+0lcf2TEiGb7EYuGP+xDvagoqMbHUFImIk91n
   jOKzJDrM6nkipI8BmyEA6k9vFTKKJIiYee36CNNfe6eMW/509hpE0+oUr
   w=;
X-IronPort-AV: E=Sophos;i="6.14,266,1736812800"; 
   d="scan'208";a="809617375"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 04:54:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:46446]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.119:2525] with esmtp (Farcaster)
 id 9103bcaa-3a54-4c78-b770-cb9e249cbf13; Sat, 22 Mar 2025 04:54:56 +0000 (UTC)
X-Farcaster-Flow-ID: 9103bcaa-3a54-4c78-b770-cb9e249cbf13
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 22 Mar 2025 04:54:55 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 22 Mar 2025 04:54:49 +0000
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
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Add selftests for load-acquire/store-release when register number is invalid
Date: Sat, 22 Mar 2025 13:52:56 +0900
Message-ID: <20250322045340.18010-6-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250322045340.18010-4-enjuk@amazon.com>
References: <20250322045340.18010-4-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

syzbot reported out-of-bounds read in check_atomic_load/store() when the
register number is invalid in this context:
    https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c

To avoid the issue from now on, let's add tests where the register number
is invalid for load-acquire/store-release.

After discussion with Eduard, I decided to use R15 as invalid register
because the actual slab-out-of-bounds read issue occurs when the register
number is R12 or larger.

Signed-off-by: Kohei Enju <enjuk@amazon.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_load_acquire.c    | 14 ++++++++++++++
 .../selftests/bpf/progs/verifier_store_release.c   | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
index 1babe9ad9b43..77698d5a19e4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -189,6 +189,20 @@ __naked void load_acquire_from_sock_pointer(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("load-acquire with invalid register R15")
+__failure __failure_unpriv __msg("R15 is invalid")
+__naked void load_acquire_with_invalid_reg(void)
+{
+	asm volatile (
+	".8byte %[load_acquire_insn];" // r0 = load_acquire((u64 *)(r15 + 0));
+	"exit;"
+	:
+	: __imm_insn(load_acquire_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, 15 /* invalid reg */, 0))
+	: __clobber_all);
+}
+
 #else /* CAN_USE_LOAD_ACQ_STORE_REL */
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
index cd6f1e5f378b..c0442d5bb049 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -257,6 +257,20 @@ __naked void store_release_leak_pointer_to_map(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("store-release with invalid register R15")
+__failure __failure_unpriv __msg("R15 is invalid")
+__naked void store_release_with_invalid_reg(void)
+{
+	asm volatile (
+	".8byte %[store_release_insn];" // store_release((u64 *)(r15 + 0), r1);
+	"exit;"
+	:
+	: __imm_insn(store_release_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, 15 /* invalid reg */, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
 #else
 
 SEC("socket")
-- 
2.48.1



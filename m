Return-Path: <bpf+bounces-74685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F17C61F6C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 01:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1FCF4E360F
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 00:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890DF1D63E4;
	Mon, 17 Nov 2025 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz3+a0qX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094121B4257
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340445; cv=none; b=TqPkf1MjrCQ1J9O+RMAYS7XvmeFsTasVe4YcHLeSVyBobeY6601xgbsWTvvlOvEdvah9ssVzZE/RW7lDp/mPEYL4XwuISCIA/o29Ly94B9nQR4uCFMOEzQueNJMRPJdst0iFArcT4q+wJ47ywRYCggkqoH0P6qrlb+x4RNSOhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340445; c=relaxed/simple;
	bh=qPVFSFVTqrn5UGtT9yP6ABevgmsRMkEfsC6TLxGS9lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A13z5GsbM7SV1pDxL4UDgU/8CTXWbMPHuDKYerWIC/1UewaULSgWmZuO2Fu6QAs8NbwjND4XTmVngZ1Nsrfb2sRAv7LK5OutbFGmYcBzbBgKGnh3trRmo38PlvnRPSIUKxItb80AQTP4pkBJZLfJ5zaLpuACyyKUt9H8IX3xRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz3+a0qX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A4C4CEF5;
	Mon, 17 Nov 2025 00:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763340444;
	bh=qPVFSFVTqrn5UGtT9yP6ABevgmsRMkEfsC6TLxGS9lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bz3+a0qXDHBOenSnK7Vap9ekcpEJwWbz5P2WuDb2J26NhAfyPbbr6wzpw0zuX2wEE
	 kIy6FZdnGuitnstAK9Bhg1fSFq39omhBSOESxhjZ2G5nvgJa4M7K4jHdOzilrD2wlb
	 r4dt53UmeX0W4zPbCZcjSSvtywFS21aUqcd/299N8YhyPjfkWVJBPtBy5h2jojHV/X
	 X7vl20Ry5kMHEHA/4OhOOWPbERY0Q8sbF9IBSzXNUXnUHd+W7NjHRnJ39VytnhM4Y4
	 pOXfGBwKSmTav23g8e+YgFrc31nN3MFfvQ2lNQh4vvfWBfVeKW3UR/FZNVTHLDA4FW
	 xrfMLvmRE7FvA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 4/4] selftests: bpf: Enable gotox tests from arm64
Date: Mon, 17 Nov 2025 00:46:39 +0000
Message-ID: <20251117004656.33292-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117004656.33292-1-puranjay@kernel.org>
References: <20251117004656.33292-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 JIT now supports gotox instruction and jumptables, so run tests in
verifier_gotox.c for arm64.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_gotox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index b6710f134a1d..536c9f3e2170 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -6,7 +6,7 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-#ifdef __TARGET_ARCH_x86
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 
 #define DEFINE_SIMPLE_JUMP_TABLE_PROG(NAME, SRC_REG, OFF, IMM, OUTCOME)	\
 									\
@@ -384,6 +384,6 @@ jt0_%=:								\
 	: __clobber_all);
 }
 
-#endif /* __TARGET_ARCH_x86 */
+#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 */
 
 char _license[] SEC("license") = "GPL";
-- 
2.47.3



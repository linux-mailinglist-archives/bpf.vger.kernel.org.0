Return-Path: <bpf+bounces-78163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A8D000A1
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 21:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A6E3054996
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F730C35F;
	Wed,  7 Jan 2026 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOnhpRM2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D7AD24
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818452; cv=none; b=M/hqExeRy/Lf2cF3To6hhJkupravXbpQg4CBhIa1TxqO275iNVqrDXw2npBnz2lmoJgqNLboxfPUbLjoIKEJ+oMS9Fp6kXR40i2FlEaZB4zDJhxbZiisTaHKptiEed1aZPsBlxFMpJ5wKb5QMeo/Q7O8k1MIrO2nsfnDwcqnGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818452; c=relaxed/simple;
	bh=DCAYTbxXeg2jc1kZTGiR9Z/ZhDsoEsDDNmqQGvjCjQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Far27C9BUfMVcwcaQom5OOA1WyMBqSd/33FqX3I4Nq2cZUSMCOMyCYIq/uIU4NNeTDVdQ39bWEpoHxxsCHMzkKXQ5QEqJv0Ui6xP1tQZOnhKzXJDyqPOymjFqITBKsGMsR3SiH/y9Q53zq9VdGTjZr6PIHpgNX6Ry48Srkzc/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOnhpRM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39618C4CEF1;
	Wed,  7 Jan 2026 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818452;
	bh=DCAYTbxXeg2jc1kZTGiR9Z/ZhDsoEsDDNmqQGvjCjQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOnhpRM28czin0ghlUM97cLZFMilgqbmaTCbed9/UgXk3xLJdwhEGhKgq0vS2yan9
	 VvYGDdnLE6IuzIBwJyXw5JKNxJDvu4cGFGEbpsEjTy97x4wUiKyTJlTL+o/xSNu05D
	 Ao9ohhipeS+pl50hA5gaXSCc9hnosF2WWzbHVLiiiWT3W/1hQ/NHjiwehdXNb+ix6n
	 0RIMPQ1pA00BYhTca1QQxmnGpt+atqD2xyHV0vQ61Y0HXaecU4S7NwKXbtx8MX3C0b
	 TwLQrVs1ybzYoG4MUFSoFrEpRinTlnE4KM3fzl1MS6Ijsbuf/n1Aj8ihh3JchbzEK3
	 nUnZyMozPttnA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Update expected output for sub64_partial_overflow test
Date: Wed,  7 Jan 2026 12:39:36 -0800
Message-ID: <20260107203941.1063754-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107203941.1063754-1-puranjay@kernel.org>
References: <20260107203941.1063754-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the expected regex pattern for the sub64_partial_overflow test.
With BPF_SUB now supporting linked register tracking, the verifier
output shows R3=scalar(id=1-1) instead of R3=scalar() because r3 is
now tracked as linked to r0 with an offset of -1.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 411a18437d7e..560531404bce 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1477,7 +1477,7 @@ __naked void sub64_full_overflow(void)
 SEC("socket")
 __description("64-bit subtraction, partial overflow, result in unbounded reg")
 __success __log_level(2)
-__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar()")
+__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar(id=1-1)")
 __retval(0)
 __naked void sub64_partial_overflow(void)
 {
-- 
2.47.3



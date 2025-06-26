Return-Path: <bpf+bounces-61664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C939AE9E05
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62434E00C3
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359EB1B4F0A;
	Thu, 26 Jun 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="gzGT3CwZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F12E424C
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942756; cv=none; b=oCH6bIZZnn16SvlCV45Va0rbdyqO3K+QL6pDNVyBGvOaX6cE74dmSvI3veON+QZ9ewkQuqsqZx6Thi15KGVACgRqcKtJkNiRG2xTrUKsdIxB6eOLA1O9IzIOYxqnKf0MNt80tLyATTy2XvPO4hBPTQP0XALGXVi+4F0v1lsiqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942756; c=relaxed/simple;
	bh=ji4KDDXiy6eFwWVj1BZCgIBPNfg/9Au+cZ2s/2LqJkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgS/68hBQlgpP9ouzmRL9bboozVJUyG2VqQ398MFxFYmrBkH7SnKD75sXI1VBkUUwTKIcfNPpzXsMe6gcNs/zhi4UPI7BBn0i7Sx1W9YLkSc67GjtVIab5SX0hSOcmqOV0u9JZLuyGcZwcFpAUM9I8UVbL1/1zXksjC3IaIZhTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=gzGT3CwZ; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1750942209; bh=/1gz89lG2AvlpyJUyX2W+vb/RZKm+W1ehr9ermOMf10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=gzGT3CwZ2tHO/CERY6I5CKtOwXGfJ0yzv5my4LdjZj3FpA5rcHmwYaamMo0wThnvG
	 vk0FJV5SwPVMb3Gjwf0Eu9W588dmVmng7N0kwZmzohqdhdZXXZ/EQjio6mJrA0befv
	 FHDc9cCfeoyIMxBIxaP37bKO5HzVmeBEwGnlbwy+L+vPXaXBOZH/kncqpG2Qd1n9Sa
	 paPS2i6piuMA93rydvVJ0fy2doJ7ExHohntOJhVn1jRMgTv3oX2SLUNPegGMtAwDCd
	 RoUhQqCLSw9zS9iRqEcRBo33dr+vwuLnPay4GNP8wvu2MbHa5yFaJcknQ77dvAijAY
	 UaNl9pOO8nTPw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bSdnY2W21zPjgN;
	Thu, 26 Jun 2025 14:50:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from luis-tp.pool.uni-erlangen.de (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19pic4bOmw3ZndzQ/JGlfYRYYBSitIKtuw=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bSdnV6GBpzPlqC;
	Thu, 26 Jun 2025 14:50:06 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Subject: [RFC PATCH 1/3] bpf: Fix aux usage after do_check_insn()
Date: Thu, 26 Jun 2025 14:49:33 +0200
Message-ID: <20250626124933.13250-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <8734bmoemx.fsf@fau.de>
References: <8734bmoemx.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must terminate the speculative analysis if the just-analyzed insn had
nospec_result set. Using cur_aux() here is wrong because insn_idx might
have been incremented by do_check_insn().

Reported-by: Paul Chaignon <paul.chaignon@gmail.com>
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 kernel/bpf/verifier.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f403524bd215..88613fb71b16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19955,11 +19955,11 @@ static int do_check(struct bpf_verifier_env *env)
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
 			 */
-			cur_aux(env)->nospec = true;
+			env->insn_aux_data[prev_insn_idx].nospec = true;
 			/* If it was an ADD/SUB insn, potentially remove any
 			 * markings for alu sanitization.
 			 */
-			cur_aux(env)->alu_state = 0;
+			env->insn_aux_data[prev_insn_idx].alu_state = 0;
 			goto process_bpf_exit;
 		} else if (err < 0) {
 			return err;
@@ -19968,7 +19968,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 		WARN_ON_ONCE(err);
 
-		if (state->speculative && cur_aux(env)->nospec_result) {
+		if (state->speculative && env->insn_aux_data[prev_insn_idx].nospec_result) {
 			/* If we are on a path that performed a jump-op, this
 			 * may skip a nospec patched-in after the jump. This can
 			 * currently never happen because nospec_result is only
@@ -19977,6 +19977,8 @@ static int do_check(struct bpf_verifier_env *env)
 			 * never skip the following insn. Still, add a warning
 			 * to document this in case nospec_result is used
 			 * elsewhere in the future.
+			 *
+			 * Therefore, no special case for ldimm64/call required.
 			 */
 			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + 1);
 process_bpf_exit:
-- 
2.49.0



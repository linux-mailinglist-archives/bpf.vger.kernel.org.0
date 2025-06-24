Return-Path: <bpf+bounces-61451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623AEAE7201
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBCD7B2072
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D224A06B;
	Tue, 24 Jun 2025 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq19DiND"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188F3D994
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802455; cv=none; b=laDbOQxV5JxSCpmMeMWq3VaczpCViqE5tJrSgHBavED9yN5ES6g6CJhbuoU4TbVDFm44wcBR0Nesk4NT8GfIxHDSOcLgl0/ey16A17TSW8iIRLgKqInhfCCbjSU8BctXNiNTB1moVKUvb+d+0bV3ejxysRt9tY7RznEQELRAfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802455; c=relaxed/simple;
	bh=BrLq68FnNH1+/zuF5HQPqzlmVCgRWSet0Qr5O3T8bH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deh1fvzsQo11unh/3wDNNvanR/Eqc9rxp1voofW+ts0d5yLlD5F9QSnHXJrmiON/QGYdVhl200XmyIEUJKDkUAfOY4yldTO19C9yObrh59Gk1eOAnTkMzPSyCPSEPHcEXnNYqy3DwEZIua01AmsbTRsqu0v29ppJvk1sZWT93hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq19DiND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2BDC4CEE3;
	Tue, 24 Jun 2025 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802455;
	bh=BrLq68FnNH1+/zuF5HQPqzlmVCgRWSet0Qr5O3T8bH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dq19DiNDxRPO3XZS6gHXvlYN/wBlAkokmuB1RerXp1TyBXJdkczAhlnoVuYaX49R6
	 VTVgDhzyj7vsHdxOz7oSwQblDlQ1ssG8jp1nJioOnwSKHl2bgNw9B2u8MMFA+gdksC
	 /FMMzg0R9R8y30foY6k81YPP9OmSdvf2iRG1HjJuvn/4jKXAxacGanHd22n2IzN3q2
	 tk9i8fnqtkJeG9ydHjcva1W8Q/zY6jmi5rVe7Y0mv5YcdPRZiIyrlSC0Nmp7u1sk9H
	 lxdZqHEWj4mD6IlbRkJqy5nU/HsIGtyENQ7U0c3dhD0ywY+Fgb4l7oiG7Gah0BJOTF
	 uqczlrV67ASyw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for BPF_NEG range tracking logic
Date: Tue, 24 Jun 2025 15:00:38 -0700
Message-ID: <20250624220038.656646-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624220038.656646-1-song@kernel.org>
References: <20250624220038.656646-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_REG now has range tracking logic. Add selftests for BPF_NEG.
Specifically, return value of LSM hook lsm.s/socket_connect is used to
show that the verifer tracks BPF_NEG(1) falls in the [-4095, 0] range;
while BPF_NEG(100000) does not fall in that range.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/progs/verifier_precision.c  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 9fe5d255ee37..b6aca92e592f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -231,4 +231,74 @@ __naked void bpf_cond_op_not_r10(void)
 	::: __clobber_all);
 }
 
+SEC("lsm.s/socket_connect")
+__success __log_level(2)
+__msg("0: (b7) r0 = 1")
+__msg("1: (84) w0 = -w0")
+__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 1: (84) w0 = -w0")
+__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
+__naked int bpf_neg_2(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -1 is allowed
+	 */
+	asm volatile (
+	"r0 = 1;"
+	"w0 = -w0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm.s/socket_connect")
+__failure __msg("At program exit the register R0 has")
+__naked int bpf_neg_3(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -10000 is not allowed.
+	 */
+	asm volatile (
+	"r0 = 10000;"
+	"w0 = -w0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm.s/socket_connect")
+__success __log_level(2)
+__msg("0: (b7) r0 = 1")
+__msg("1: (87) r0 = -r0")
+__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 1: (87) r0 = -r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
+__naked int bpf_neg_4(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -1 is allowed
+	 */
+	asm volatile (
+	"r0 = 1;"
+	"r0 = -r0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm.s/socket_connect")
+__failure __msg("At program exit the register R0 has")
+__naked int bpf_neg_5(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -10000 is not allowed.
+	 */
+	asm volatile (
+	"r0 = 10000;"
+	"r0 = -r0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1



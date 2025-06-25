Return-Path: <bpf+bounces-61548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CBAAE8A14
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6643A6D90
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A472D4B7C;
	Wed, 25 Jun 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GffsQlb7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25792D4B41
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869641; cv=none; b=oK2skr5I/C2AukIxALWqgyZ/gPbjICGkOrBX5IT7yLbcGrOCZIj5xZeK0oorKnSnZja9hp4A1ZZbM7TOTDB0cYjM2w5QgD/KNeC2pD27yuZnFkWdfDc0W0IqGGXhMLiiAsBD+QbZz8yGPkE0OpO19oxWXb0oOc/jsXjenP8rRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869641; c=relaxed/simple;
	bh=wiyXjFCr0vzH3k0goxeMxAlFdoQ0auzW5PJZxNpJEIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWshwc80ZlTZvzyNxAWbnmoxwNbDA03mxm64Y4KniCPH7oqFrjBOZP3au2zwIm5O6acNZ1NUauF/of9IndwaEGGxc6eLA5vaBy+l7mKSJFJL+kynwHzw2vM+LEzGNvALW/2Atd+4iZaS9wdhpKbp15HU4MaP/tvBNhGZxlaouro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GffsQlb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258A6C4CEEA;
	Wed, 25 Jun 2025 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750869641;
	bh=wiyXjFCr0vzH3k0goxeMxAlFdoQ0auzW5PJZxNpJEIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GffsQlb7DzLFP1nUIxwWcMyq/vd/t1Nrt9EcWWnzbVanW8Q0fZaFlp7pjp3z2DEE9
	 aHAflV2oMwbhzRCgc3leZUm0bIELCintKXKjJHC46LfE8yvKdAR9UIpA9HZEzX8NlD
	 p77F4WXC9FzUhuSXiENfp37kcU0GbK4YdV0ED33CQcndxaBVRft1R0A+JD8GuQx8Xn
	 GsEEz8Z5CtSF27wjfSkpGQQD4iM1AaMglO6MZh3HyeZZ5OewxZon0gDfNO0c7zSVLQ
	 sR3omqO2/1WZZN8PBBQHH23dLhTX6M+tt+X06f+OSYSoFbKszJ+dGpRMn94ril+Ak1
	 3W88PY7/YNE8Q==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: Add tests for BPF_NEG range tracking logic
Date: Wed, 25 Jun 2025 09:40:25 -0700
Message-ID: <20250625164025.3310203-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625164025.3310203-1-song@kernel.org>
References: <20250625164025.3310203-1-song@kernel.org>
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
index 9fe5d255ee37..73fee2aec698 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -231,4 +231,74 @@ __naked void bpf_cond_op_not_r10(void)
 	::: __clobber_all);
 }
 
+SEC("lsm.s/socket_connect")
+__success __log_level(2)
+__msg("0: (b7) r0 = 1                        ; R0_w=1")
+__msg("1: (84) w0 = -w0                      ; R0_w=0xffffffff")
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
+__msg("0: (b7) r0 = 1                        ; R0_w=1")
+__msg("1: (87) r0 = -r0                      ; R0_w=-1")
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



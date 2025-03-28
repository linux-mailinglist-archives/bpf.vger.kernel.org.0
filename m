Return-Path: <bpf+bounces-54874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D1A750CD
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 20:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3669E189043C
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715C41E1DF9;
	Fri, 28 Mar 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0VMFWQb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7301531C5;
	Fri, 28 Mar 2025 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190301; cv=none; b=ql5cBs5+qrdAaOZ2lOxaXHK5SIyhT4Pi3sEpUybksdq8YsUiUEdOKFVFvTA1zm2X37epUBWO+7YiihPxGojumjvxjm7w2TVsUapTvG38pbroDHkj5aF71+FH9TkVMcmEXJ4Gj09SEMSNgITn/sbnqWn0y+YDwuk7xRBNCcDVFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190301; c=relaxed/simple;
	bh=vUUOmaBsW00jSF2gRrb1rpo7FsoIYv4PkVoMJjSPa2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeSQR4NuwpSwV0vB+MoT0aK+VxQIG/zjXrADNv8tgUiTpeCGSxf+RE7yv3xq0RM5yRROEwm54K1bwNFzSH16mtWtfCwoOt8m/PbdBMQ3FOlrbkI6nMCVv1c083/fNfazsDGTfrNzvprBo/thABqFRzwQK03aaO83ur+vrWYuW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0VMFWQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ABDC4CEE4;
	Fri, 28 Mar 2025 19:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743190299;
	bh=vUUOmaBsW00jSF2gRrb1rpo7FsoIYv4PkVoMJjSPa2M=;
	h=From:To:Cc:Subject:Date:From;
	b=C0VMFWQb8cYGUvMuEndJm2THrABw3Y92jxwzHOxIFThfBQYab+AUk90h/LYeib/MW
	 ya/XzXkgdDIqMCSDgPG4WXqXg+EWaNlT4aiqZegxpCHsQATBIHTNnO+ylP0KSmL3a7
	 Lcfw7E5+D5nzddG3HVhHH0yv3bIG4CPMbt0ZjTK4YVgzIIWmKVQnGZAoJ9F9ptX7oY
	 jhmhuaHMMHXzHx4hcUBngmKr27ZMiwVCGKBgTqeq2OybP0s3zy6umuSGYoGRNN5zQj
	 nvjlTRpOVyiRW574lRNb7u9XhnRpDhVVkrrAM5O6dARu2TvTaY3Mb5EOcLTEBbKHtS
	 +JP/Vp1kffFIg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel-team@meta.com,
	song@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix verifier_bpf_fastcall
Date: Fri, 28 Mar 2025 12:31:24 -0700
Message-ID: <20250328193124.808784-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit [1] moves percpu data on x86 from address 0x000... to address
0xfff...

Before [1]:

159020: 0000000000030700     0 OBJECT  GLOBAL DEFAULT   23 pcpu_hot

After [1]:

152602: ffffffff83a3e034     4 OBJECT  GLOBAL DEFAULT   35 pcpu_hot

As a result, verifier_bpf_fastcall tests should now expect a negative
value for pcpu_hot, IOW, the disassemble should show "r=" instead of
"w=".

Fix this in the test.

Note that, a later change created a new variable "cpu_number" for
bpf_get_smp_processor_id() [2]. The inlining logic is updated properly
as part of this change, so there is no need to fix anything on the
kernel side.

[1] commit 9d7de2aa8b41 ("x86/percpu/64: Use relative percpu offsets")
[2] commit 01c7bc5198e9 ("x86/smp: Move cpu number to percpu hot section")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index a9be6ae49454..c258b0722e04 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -12,7 +12,7 @@ SEC("raw_tp")
 __arch_x86_64
 __log_level(4) __msg("stack depth 8")
 __xlated("4: r5 = 5")
-__xlated("5: w0 = ")
+__xlated("5: r0 = ")
 __xlated("6: r0 = &(void __percpu *)(r0)")
 __xlated("7: r0 = *(u32 *)(r0 +0)")
 __xlated("8: exit")
@@ -704,7 +704,7 @@ SEC("raw_tp")
 __arch_x86_64
 __log_level(4) __msg("stack depth 32+0")
 __xlated("2: r1 = 1")
-__xlated("3: w0 =")
+__xlated("3: r0 =")
 __xlated("4: r0 = &(void __percpu *)(r0)")
 __xlated("5: r0 = *(u32 *)(r0 +0)")
 /* bpf_loop params setup */
@@ -753,7 +753,7 @@ __arch_x86_64
 __log_level(4) __msg("stack depth 40+0")
 /* call bpf_get_smp_processor_id */
 __xlated("2: r1 = 42")
-__xlated("3: w0 =")
+__xlated("3: r0 =")
 __xlated("4: r0 = &(void __percpu *)(r0)")
 __xlated("5: r0 = *(u32 *)(r0 +0)")
 /* call bpf_get_prandom_u32 */
-- 
2.47.1



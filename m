Return-Path: <bpf+bounces-29654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4967E8C46B6
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C55B2281B
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A462D058;
	Mon, 13 May 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owoEHy+C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB993838F
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623688; cv=none; b=eTKDGNxheXNRi9w1i6uYyTesP/B4nAinkRVI32gFff+udR053lLiryRw/JXAH/5J39CjQ8L2kzydh6xqa2nSnHbb4pYOhtyg2V4PV9yg6+TSRIO3lYQKGUCXVPVKXevnXAzc7sKyeNUiKfvIfDmtc71XmSidlOrhxeuSTO2Njkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623688; c=relaxed/simple;
	bh=V4656gibYuhndMUYyqzVEaZZWASYfIp5xRRV/49wdQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEeZRHW/43S+kU12nnCGiR56+xupB+V0XgzxqQvalx+jhYrYFHfBWEfL+9e5qyVCOYlLOtjrwJzA1UZifOqBzdn5ozQAc7r3nZG/AYAX49OGrpL9CUw7n4vIeg5LaxnmWNkZHhS69zv70c56X9u1Xq9jrLrBl+Moh+UueESz2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owoEHy+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6656C113CC;
	Mon, 13 May 2024 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715623687;
	bh=V4656gibYuhndMUYyqzVEaZZWASYfIp5xRRV/49wdQU=;
	h=From:To:Cc:Subject:Date:From;
	b=owoEHy+CTvpwYjTpcuNionrJ2V2/QunbgN+1cGzvahRpuXYlKH7HpfyoBF1dw/xme
	 PzBwp0vtqqoOJzxm6aaTjco+wCpanGXC8GLBNlhw2DKwQcy6FrfLeCatMcD4oI2UWS
	 J/lqecp9twjYlGUb26/zei+NyFWHo8k5lSG4y/7W+FYW7xhCf8u+7MWPCwd1v9kDBz
	 R1nWTWJ46y9rJ7uPUkcS7aCdDYg98ikndP17wB/r04PI0W4d5Hv5TxzSOJd1zdnv6l
	 ABYSfCXCrlwj7GbEZVftzzoCZLGGDxGO11X1EF0ks0QNcF7U3bQHG0j/Ao8S9fKMu3
	 Vy1L9ZuQ4JaEQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH] libbpf: fix feature detectors when using token_fd
Date: Mon, 13 May 2024 11:08:03 -0700
Message-ID: <20240513180804.403775-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust `union bpf_attr` size passed to kernel in two feature-detecting
functions to take into account prog_token_fd field.

Libbpf is avoiding memset()'ing entire `union bpf_attr` by only using
minimal set of bpf_attr's fields. Two places have been missed when
wiring BPF token support in libbpf's feature detection logic.

Fix them trivially.

Fixes: f3dcee938f48 ("libbpf: Wire up token_fd into feature probing logic")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 2 +-
 tools/lib/bpf/features.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 466a29d80124..2a4c71501a17 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -105,7 +105,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
  */
 int probe_memcg_account(int token_fd)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, attach_btf_obj_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
 	struct bpf_insn insns[] = {
 		BPF_EMIT_CALL(BPF_FUNC_ktime_get_coarse_ns),
 		BPF_EXIT_INSN(),
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 4e783cc7fc4b..a336786a22a3 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -22,7 +22,7 @@ int probe_fd(int fd)
 
 static int probe_kern_prog_name(int token_fd)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, prog_name);
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
-- 
2.43.0



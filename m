Return-Path: <bpf+bounces-41648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BE999448
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1971F23DCD
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8851E1C15;
	Thu, 10 Oct 2024 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS0cicmx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606B79D2
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595058; cv=none; b=OCgFwmBI0gRp6ig863zk5XQdyMq9lYq46A+mOUqHfKP/q6O9hsyjTWkXvMFuL6xJwFMCubdd+zIkASJjTGVgZK4icRjxqqFEQFYik5WuCwSQb49tb7DbC7VM4QV+r9SscGclz8tgUnPSlsQBXi6tsYf+OZqjBKKpsgT6rUHhNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595058; c=relaxed/simple;
	bh=taZcxtP09exfathlFfWFsZR1sXmFNmYV1d+3LzOrHkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5/CzzjhmTU8KBGOZETokgT7IH7JvVjYWX8PO/IL4nJN748ZWBFot0+UIWYY6meb6PEaKN771TWQkE9gzsDErwRwqLBVWATFX8G1qNa0GacZbQNM1Ukwrltt5PpwF+7xVcTLG7Z0znLiBUr19Gs3J2YGtqsox78Rkwmpe1kGM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS0cicmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82765C4CEC5;
	Thu, 10 Oct 2024 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728595057;
	bh=taZcxtP09exfathlFfWFsZR1sXmFNmYV1d+3LzOrHkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PS0cicmxruBZzr3L9b9s2SG5qtGnz0Y7UJYOq2yqlxdbGOWIpn9Bj+GqsrI/im/6n
	 J28uVD3cFRCHbSkg+T7JX1l2aWKPOnDDQKGaVuanC+LjzvAQJl5T5ZmB+uLFy/kAga
	 FrHGB5lVYEwThFIRDH4AyHE03B4xrwAVz6ngbh+uW7M1Cv/Owu12ODwPsEwfaQu79e
	 qeRwkFEF5q1kbXgmAg2Umrd31Bmp+S0+WRIujugluYCRCgzdkPSnSNTa56YsBaXgzW
	 ygpJcMcsyqOv2f/fxhXwZ2ZEf+TbkC/BGwLyamUStLfkPFMfG5uyuTIABIFo0cK2Lt
	 bziUIW4peAQbQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: add subprog to BPF object file with no entry programs
Date: Thu, 10 Oct 2024 14:17:31 -0700
Message-ID: <20241010211731.4121837-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010211731.4121837-1-andrii@kernel.org>
References: <20241010211731.4121837-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a subprogram to BPF object file that otherwise has no entry BPF
programs to validate that libbpf can still load this correctly.

Until this was fixed, user could expect this very confusing error message:

  libbpf: prog 'dangling_subprog': missing BPF prog type, check ELF section name '.text'
  libbpf: prog 'dangling_subprog': failed to load: -22
  libbpf: failed to load object 'struct_ops_detach'
  libbpf: failed to load BPF skeleton 'struct_ops_detach': -22

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/struct_ops_detach.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
index 56b787a89876..5222d58592a7 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_detach.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
@@ -6,5 +6,11 @@
 
 char _license[] SEC("license") = "GPL";
 
+int dangling_subprog(void)
+{
+	/* do nothing, just be here */
+	return 0;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops testmod_do_detach;
-- 
2.43.5



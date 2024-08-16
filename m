Return-Path: <bpf+bounces-37376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F94954E00
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA751F26CFA
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6A1BE22C;
	Fri, 16 Aug 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJzMAwk9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7F1DDF5;
	Fri, 16 Aug 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822996; cv=none; b=GXJ1R2qiqorkTQJdRrIMJqZCJo7MW1cND7s6XGg2/k2dp0+GmJj8b3P/wQ0QHNgi1YlmduAKXHbgGNBE47ywhezi8klrtQFCtC/R4644X+v4Ti+5gv1xfjuCk0cYvxd6lIFALuffPtad79giCSw8mMCePPQ3HO2MC0NEuuOHyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822996; c=relaxed/simple;
	bh=B1ncGCuFLhTXUNWrhL4utEno0VidrBkAJsGjCTu9Ohc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eI+yyLFQcVQeyc7WJPsLcbnImQgn79nH7qmJDJl6F9AaJXlq1Cp+M4myHiqXj/Bv3lhBPjVAuVB3Ya2vPWUsUCIo+qf9oL02ATCcBRVcP8qs7UHj4kT7h0X2OXwGIkJglb9gSh+BIxCvZqI+qVVdlENR6tyGkO9k9pqSjls1A/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJzMAwk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01D3C4AF0B;
	Fri, 16 Aug 2024 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723822996;
	bh=B1ncGCuFLhTXUNWrhL4utEno0VidrBkAJsGjCTu9Ohc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJzMAwk9zgWRd6Yvx9Am8HpDAj3Hm3f20Vs4zFDxGvWYsqboybcnhfbtY3vGMjQKW
	 QfLd27q8Di3GXnHZhJ69NWxRp9Tz88BieB46PBuLchKubNIrx5DFs+DYBQMvUIJO5P
	 QADS1RggjKsieTIH6PnchK21qst1dyJzq3WOf/1co2veB6R+1jfVOliQnpNho+KY3V
	 axrhaiQrKxsQCE1KeMvGJSp938AZVUd5jzkTE4WOYIHNjtnpJn1OetQoOqgL3FiX0d
	 a0eP044aJng2g1yNThxQPkHi1qm3dgiMjCWDkQhXTmbH6d6+knrmem2XTE83iXmJ+t
	 xJObXQNJ2GDJQ==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	andrii@kernel.org,
	keescook@chromium.org,
	daniel@iogearbox.net,
	renauld@google.com,
	revest@chromium.org,
	song@kernel.org,
	linux@roeck-us.net,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v15 1/4] init/main.c: Initialize early LSMs after arch code, static keys and calls.
Date: Fri, 16 Aug 2024 17:43:04 +0200
Message-ID: <20240816154307.3031838-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240816154307.3031838-1-kpsingh@kernel.org>
References: <20240816154307.3031838-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With LSMs using static calls and static keys, early_lsm_init needs to
wait for setup_arch for architecture specific functionality which
includes jump tables and static calls to be initialized.

Since not all architectures call jump_table_init in setup_arch,
explicitly call both jump_table_init and static_call_init before
early_security_init.

This only affects "early LSMs" i.e. only lockdown when
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 init/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 206acdde51f5..c4778edae797 100644
--- a/init/main.c
+++ b/init/main.c
@@ -922,8 +922,11 @@ void start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
-	early_security_init();
 	setup_arch(&command_line);
+	/* Static keys and static calls are needed by LSMs */
+	jump_label_init();
+	static_call_init();
+	early_security_init();
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
@@ -934,7 +937,6 @@ void start_kernel(void)
 
 	pr_notice("Kernel command line: %s\n", saved_command_line);
 	/* parameters may set static keys */
-	jump_label_init();
 	parse_early_param();
 	after_dashes = parse_args("Booting kernel",
 				  static_command_line, __start___param,
-- 
2.46.0.184.g6999bdac58-goog



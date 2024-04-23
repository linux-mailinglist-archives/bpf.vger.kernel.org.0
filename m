Return-Path: <bpf+bounces-27500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6E8ADCFA
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 06:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42376283166
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 04:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53F1208A8;
	Tue, 23 Apr 2024 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le/Pv/qX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EB1CAB3;
	Tue, 23 Apr 2024 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848154; cv=none; b=YAI7VeOIskTlQoJr0dkE4SIkHRzT/gq/nosGvkjBBR0V8etm3he1i1R2LVs9QQOUbiDsZ+mgCNWqJD50NkP42lOvPKwTv9vFeyKKTT4Bu83qhpmtzysxEGqTI8xx9jMZ6vuZiYMI4yVJ1CeEb0VlUT1UnlFrRjKIaCCb6MZVINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848154; c=relaxed/simple;
	bh=puryQ1J6mzWbCrUfIOEYUOuYeQHliVuNmWN99eIePwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b109HJHGIDbifzIPlkC5K8UgwXKspwDf2Rw0SNNNALaGHu8JVcP6dtsHuw9n03HOMYxAtBkFP1oMbxdMpVq2FoU0ukZaGsdmZSBCoz8dKhh2mcRM7/2DlOgnNgwgqdkU5KHnLKrpP54tUV6UqWE5tCMElC0tieIpzifTGQMK3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le/Pv/qX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F34BC116B1;
	Tue, 23 Apr 2024 04:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713848153;
	bh=puryQ1J6mzWbCrUfIOEYUOuYeQHliVuNmWN99eIePwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=le/Pv/qXNH6cmU/bEapqQld8Xy6qptw1W4yy3w76kNBPQoyRaCQ0eDU8aW4OhYWvQ
	 5Mw11o+v7XwagPHZlhU0O3PzlDxaSNWLya2r6tfJ2eLh6f061eRrKx2Aax9CCNIi40
	 9btXUZVsTznHsEP/H1yEccKQOxUkoFa5bdqrxukAQowOZhhLU7AzfKPatKfViNJz8F
	 YlPKOkmW98paCxbsin3DxJ2//NPjoEEvFPmVbXH0uiYwYiMJb0X4DKvMA+EqLHRt7z
	 uXd8GQaU2PNSFL2wkl7+gq+reYJfXzAQ0Hi/4hMHQK4jllydhVPYg3fUcJ0p+39rmQ
	 BWvJQ5CtWZjFA==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] arch/Kconfig: Move SPECULATION_MITIGATIONS to arch/Kconfig
Date: Mon, 22 Apr 2024 21:55:48 -0700
Message-ID: <20240423045548.1324969-1-song@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPECULATION_MITIGATIONS is currently defined only for x86. As a result,
IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) is always false for other
archs. f337a6a21e2f effectively set "mitigations=off" by default on
non-x86 archs, which is not desired behavior. Jakub observed this
change when running bpf selftests on s390 and arm64.

Fix this by moving SPECULATION_MITIGATIONS to arch/Kconfig so that it is
available in all archs and thus can be used safely in kernel/cpu.c

Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
Cc: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/Kconfig     | 10 ++++++++++
 arch/x86/Kconfig | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f066785bb71..8f4af75005f8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1609,4 +1609,14 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
 	# strict alignment always, even with -falign-functions.
 	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
 
+menuconfig SPECULATION_MITIGATIONS
+	bool "Mitigations for speculative execution vulnerabilities"
+	default y
+	help
+	  Say Y here to enable options which enable mitigations for
+	  speculative execution hardware vulnerabilities.
+
+	  If you say N, all mitigations will be disabled. You really
+	  should know what you are doing to say so.
+
 endmenu
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a..50c890fce5e0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2486,16 +2486,6 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
-menuconfig SPECULATION_MITIGATIONS
-	bool "Mitigations for speculative execution vulnerabilities"
-	default y
-	help
-	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
-
-	  If you say N, all mitigations will be disabled. You really
-	  should know what you are doing to say so.
-
 if SPECULATION_MITIGATIONS
 
 config MITIGATION_PAGE_TABLE_ISOLATION
-- 
2.43.0



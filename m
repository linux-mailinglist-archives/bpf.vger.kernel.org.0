Return-Path: <bpf+bounces-28525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D38BB197
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 19:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B941F228A7
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C797157E88;
	Fri,  3 May 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIRN+DUF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBB157A74;
	Fri,  3 May 2024 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756742; cv=none; b=T7q9C7XwNN6Fj5wNpXFoR8w97ik4nyi20BSiMlRMrBFQ3L7gQ2t7Shke/C4CpEupQVuj5aU9jw6mDBauXb4Kvbr4FQkG1aly6knn2eTm6zlFfEijAcR1b2R9+XMo/JQ5sAnzlGD4Nkp9xsscMWpup/i78j9Hx9DRnALFdbb/eoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756742; c=relaxed/simple;
	bh=sxFjeHo/U9d6yJ4gu/S8oCYHW6M/QMHpy5fuSlTg3o8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X2cQDiF8nNDVm1XYfrFSSX8RB3GKfSFxrqN/0FX0+x0wuILJCCTzdxTq+Js7ZRAQvByaHPqMBs8FStYeGixtooMvnjnNDF2buk15kifJ9TTYqzzzR5caRLWGLtSpQLvy9gnex1b3q/vGKYZZ/yeZl9Cn3LDsBWAEtyb9S1Nrm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIRN+DUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257BCC116B1;
	Fri,  3 May 2024 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714756741;
	bh=sxFjeHo/U9d6yJ4gu/S8oCYHW6M/QMHpy5fuSlTg3o8=;
	h=From:To:Cc:Subject:Date:From;
	b=hIRN+DUFCywNEszWU9lwdZU2kY1GdPQ/vI695iOCohOzJou/FEySpToU/05dvz1P0
	 ZGNOaxMi/LHxI8UwG6/irrNE79FoDmsE6N81uZG/60U+ISuXKU4vUNVodtvYFA+4i0
	 dT1+Y3XUIr/2WwBj57H5tUUL9bgXm3QkzWI17B7W6w9mrZjvSPoXA4BnaXNZOMJiIQ
	 NDrAUyHfKGMaCnvapDfx5CuyznN2IiuyDyL2YFAwhaVzhlCKXXh3prw7StOm4ApR6A
	 n9LAHQYNU74Hb1IfUBy6AZlV7JSGaMh8FctgeyyunHhpfzdXJU7/TNdWUR/5yceNDd
	 DyXx3tDu99nJQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH v3 1/2] arm64/arch_timer: include <linux/percpu.h>
Date: Fri,  3 May 2024 17:18:46 +0000
Message-Id: <20240503171847.68267-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_timer.h includes linux/smp.h since the commit:

  6acc71ccac7187fc ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")

It was included to use DEFINE_PER_CPU(), etc. But It should have
included <linux/percpu.h> rather than <linux/smp.h>. It worked because
smp.h includes percpu.h.

The next commit will remove percpu.h from smp.h and it will break this
usage.

Explicitly include percpu.h and remove smp.h

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/arch_timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 934c658ee947..f5794d50f51d 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -15,7 +15,7 @@
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/jump_label.h>
-#include <linux/smp.h>
+#include <linux/percpu.h>
 #include <linux/types.h>
 
 #include <clocksource/arm_arch_timer.h>
-- 
2.40.1



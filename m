Return-Path: <bpf+bounces-28440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A68B9AF5
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 14:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB708B22D9B
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB5253E27;
	Thu,  2 May 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYLLKxV8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69261CAB8;
	Thu,  2 May 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653317; cv=none; b=ec4938tE6fs85gMcDfank1mTsHkomDsEzTjshhN08W2GDXvRVtSXqaPDL5ms6WmSJ+g1uhLTlYAfFr1SLCpi7IcYinZonFXME7T4vLoLAJgXxnpWAQdNmOI9K62foZXeCWYWACG0xEqDUatUNJ+bJykFpzU68hBwtvx77SxxlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653317; c=relaxed/simple;
	bh=WlKxebhw7412R6YXQz6YwsAh+Molh2hfBvugAc0mpbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UYyK4Z1kkNc92jgPOBxJt0bvpAuWeZ0LwyJAZq9ThKAK2wC17eivlQ/JCabJhUnahUSj1eRafw6AZdfDlsqrcCBpUfq+tVisDVp9aF/8+SmTGcuvJI8REXb5LFmID1EyIgc+xr/4nsS8/bHB+4NufLrapi48anuXEGYNV790tP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYLLKxV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A66C113CC;
	Thu,  2 May 2024 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714653317;
	bh=WlKxebhw7412R6YXQz6YwsAh+Molh2hfBvugAc0mpbg=;
	h=From:To:Cc:Subject:Date:From;
	b=nYLLKxV8o3+Z20fq820fXOAXBId0L4cMWCCXPXtwX4pgrz0JEFnD8r599mmvqAcng
	 uyLkIPCkxbHaWwXBqmTgwKEib8Oz5yprgfgVN2EAigO4hKJcH6cHqHNEBuEvKScWP3
	 501dLo6/yviawJ2JybDqnSqZqYrZsfTW7ati3oXXEKgW9RXa2u5H0KCszv/QvrQWuC
	 g1pDQgp83Ers75yoaLkn9Wf8vrw/A5EO83fxhTzTV0yCrQf5mppOxU2wOOPIxDdPK3
	 7vur5WnX3/agBnMF29r1iNM0K3Zw5cQKyEwIevVUUaH0U2yzLRJ8CknhEG83B2xNIO
	 XPlTuqD+eb92Q==
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
Subject: [PATCH v2 1/2] arm64/arch_timer: include <linux/percpu.h>
Date: Thu,  2 May 2024 12:34:48 +0000
Message-Id: <20240502123449.2690-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_timer.h includes linux/smp.h to use DEFINE_PER_CPU() and it works
because smp.h includes percpu.h. The next commit will remove percpu.h
from smp.h and it will break this usage.

Explicitly include percpu.h and remove smp.h

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
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



Return-Path: <bpf+bounces-63527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 107DBB08250
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE731A624E2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C72036F3;
	Thu, 17 Jul 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzRd9+O6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3B1EFFA6;
	Thu, 17 Jul 2025 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715756; cv=none; b=cRwWmd2CWejjmy+trMw97Cm7Unbyd6BNS3e4Cd6E3MWnkdr1pFUh13gz8FVuY8xubM4TvPY0Ljo98/O1FGLrD36AiTlhlE2epBSQkbfKesUWa/RgWAY3Ny7CSwyouq8Mt+vXjsGZWhdvG8xbxCQ4jvgw/ch/wBH78Tm/GQZk8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715756; c=relaxed/simple;
	bh=aRxII1P7bLClpEluNYWEE+ZDymSuTvTaQoIzZ8HvPzQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LkgovkVfsli58UEQvKuysFBLF8Q/Vhyd4tlryhBGlWyUOaCDrC9lvgU5UBvyAAYgqAwsv9NRdrFBdDc7oWId1QDZEw9fxt8cofy8jQ1Lfj5LB9MdiCcwX+gdnV0vK/oEtwTbriEFauPCqZxzignsBmLNVHCdE0G9nX05/FgQ3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzRd9+O6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC44C4CEF7;
	Thu, 17 Jul 2025 01:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715756;
	bh=aRxII1P7bLClpEluNYWEE+ZDymSuTvTaQoIzZ8HvPzQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=FzRd9+O69WEm2lf4j9y1wjOAUL1yD44FCrObncYv2o+psODx0J6UMRPu2hk+O27H5
	 SsJo7vH0nK/k+ZBK1CehyNOx2EVi95EWssZfWnlrgRnAXfB4iFOWafC10lR1SF+qyy
	 zo+5WJlWKDzhJwUYl3K0NtoDzDQHpp1e1wX2fgPAwfEjsuMBgSQ3s36HwY5+wKROlM
	 dKYDGA6ed2yMkewJZPHJ0M2YfMoagdmfukORqHogvZrPUt05dZOyQLckp9zVufDqKC
	 W6yRUj3Fj7SDQZYpkMb/eJ3Tw1El0EPOleJDmKuQMjrAEMb1HTRe9BDF+hDXf2JyWO
	 2TWM4YYmi9Hbw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucDRI-000000068xh-3vxh;
	Wed, 16 Jul 2025 21:29:36 -0400
Message-ID: <20250717012936.785935784@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 21:28:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v9 07/11] unwind_user/sframe/x86: Enable sframe unwinding on x86
References: <20250717012848.927473176@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

The x86 sframe 2.0 implementation works fairly well, starting with
binutils 2.41 (though some bugs are getting fixed in later versions).
Enable it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5862433c81e1..05dbfa3eb8ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -303,6 +303,7 @@ config X86
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
+	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
-- 
2.47.2




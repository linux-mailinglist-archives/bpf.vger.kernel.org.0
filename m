Return-Path: <bpf+bounces-62627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D953DAFC0A0
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F6A4A8325
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4824322F74A;
	Tue,  8 Jul 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCkhzSiQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2B224AF2;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940719; cv=none; b=epyRj8DQN+V461jRqN3wKVvj/HzK3Z2PcOmGZi1Hgt+NYULGgcg1E843jTXLbpVdww/beZGL1SpL5Eb/Jkc1+JQLqMxxzS5ts+afnfNePVOSQkj4UwHmcV1X2+7ewXQNI7h5Od2pzeqc/Ek0vPwDwF9mnz34NXHtZuo/avh79pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940719; c=relaxed/simple;
	bh=IEeF1XmOFvet0cAU5DreYcr/1OJVi6UMuV3x6isQ67c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sb0YB2rH1VVUefshvrLvpJb1hw+kOJyPRTZNk9/xvrOTnVfVdHip2ajvFTglsUrXxQchA241MnfvnyG5CUOYx0OMwT1OijaZlfE8IAw/TQv+xjelLq+1XTMxWFktVscZQaVQArg8NLkCNqGgqp7GRK5zAbGhAi421afd6Od4Ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCkhzSiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E86C116C6;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940719;
	bh=IEeF1XmOFvet0cAU5DreYcr/1OJVi6UMuV3x6isQ67c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=uCkhzSiQKmFrmco8yP7xlCWCh9jEpI4C2UECYcSuKnH4tIW7KgKDNCycqD5XjwWXn
	 tCiKS5z3EvoZCkl776kV/wTee+ITriIkm4IidxoycIu6Pd424/gWOdJKoUjGzuyFbx
	 vLkmRHWWChVGjLUjEeHzawKSdiXcwKHyVHDbshBvR62pEoUArab2EnJV4YXEBycUnF
	 zLWdXFZHxth4jzruG/LT+EVf3YAuStMxq+fiSj7pquD+bCsUSLXxq6PgbPN6w6sPZR
	 tGgbU2RHtj7LBLhR5YSBemdHLSYV2LwVchaj/cZnTFSY+enM3kJlPRes8ZVgHshofB
	 kOuIWdPT0cMjg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxoN-00000000De0-2wJ7;
	Mon, 07 Jul 2025 22:11:59 -0400
Message-ID: <20250708021159.552828535@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:11:22 -0400
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
Subject: [PATCH v8 07/12] unwind_user/sframe/x86: Enable sframe unwinding on x86
References: <20250708021115.894007410@kernel.org>
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
index 17d4094c821b..8a382a6b9be3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -304,6 +304,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_COMPAT_FP	if IA32_EMULATION
 	select HAVE_UNWIND_USER_FP		if X86_64
+	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
-- 
2.47.2




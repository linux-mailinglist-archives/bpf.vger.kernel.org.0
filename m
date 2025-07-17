Return-Path: <bpf+bounces-63529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87DB0824E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DC3567B68
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72074205E25;
	Thu, 17 Jul 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJBeqAyz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E51F4169;
	Thu, 17 Jul 2025 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715757; cv=none; b=RSQ3qnfaRS6A43dfvCdrqlHz37R56+PEAjnl5rb/U44fGQxrYct8Be9YMIHXH8z8rX5KsvDvdgZZVs9LLV1dLGiZc7dW1RaXwlT6F4+gt7P3IQbp3J7SyNJrqt2mZfLmGq4FS2VFRKWCJJYjNGxb7A7jRWsNIQD9Fm54zcU/0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715757; c=relaxed/simple;
	bh=tQh371Xu4aNv634IWnbNpzI8g0gGO4AVuobSDHJ5Ps4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rp6bvutDINRdo2y2oSJ0v+Kb8Z9v9wRgZrEcyd62dnoJGn62tiHghHEA8Lfje5dze4KXgqttkx6i+r9IwDnoFi8yfI4JrEVc972LkKTd4B8pnt/ujIMQaee6Wa/A8iBmery6Q4qUQ4UvZwJVkb2uNFNV/xoV5IScY/d34NcoLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJBeqAyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA32FC4CEF4;
	Thu, 17 Jul 2025 01:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715756;
	bh=tQh371Xu4aNv634IWnbNpzI8g0gGO4AVuobSDHJ5Ps4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kJBeqAyz4tUxhCCJvJ88LMpi7Kd9mtT8GIrBQDiJSkqAx1uKNvIelnNHSoPtwR7ee
	 uEuFDpVTzU/zswUKFJdxGy9lucs3uk+0WirTaau0MJDzi83I68ljRIQiylCxMu6hqh
	 MeU8gjjg0Nai1TFVQQ081YXIh4TML3NABi/MFqtTawFIF/YBHG1SVcAsLc1e/chF9j
	 8imwhCPaSZybBhAQ+gMEtJXPJptZUImi7p75vUsKY/RErgeAhePlKuqAzMB5rACpyc
	 krBJb2Qn5V5FHl0Q009Y9E89mrDCGRshQNjbqAcMCmIREaruN9oYpJ2iEu7TyBf2Lk
	 KMLhYK6spcxrg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucDRJ-000000068yD-0S7b;
	Wed, 16 Jul 2025 21:29:37 -0400
Message-ID: <20250717012936.957316732@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 21:28:56 -0400
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
Subject: [PATCH v9 08/11] unwind_user/sframe: Remove .sframe section on detected corruption
References: <20250717012848.927473176@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

To avoid continued attempted use of a bad .sframe section, remove it
on demand when the first sign of corruption is detected.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/sframe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index b10420d19840..f246ead6c2a0 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -310,6 +310,10 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	ret = __find_fre(sec, &fde, ip, frame);
 end:
 	user_read_access_end();
+
+	if (ret == -EFAULT)
+		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
+
 	return ret;
 }
 
-- 
2.47.2




Return-Path: <bpf+bounces-62626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105DFAFC09B
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DB21BC07CC
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4516922F386;
	Tue,  8 Jul 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPncEIZN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B32248BF;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940719; cv=none; b=nszM96rxXygK4oKdfO02w5+muVvVadHBB8nRiso5x/4EUW+BpyUtN0QkdM1K9t2vkoKxAH5ysRZdAwQJaLGjGg/juuKDMwJbjbab6lhm2xQDIOFvjgiRcToOT2AW1W18y5obGUrqs7dxjhQp3+yWVZYr4ruLXkJBn+0oMc0VSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940719; c=relaxed/simple;
	bh=tQh371Xu4aNv634IWnbNpzI8g0gGO4AVuobSDHJ5Ps4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qe2MWOLdmDCd9g3g+xVRI0eBb2HIgPLu8fYfSpwLwRLEbUWPrTy+R9xj5QQRapnFWp//8zXeBWkflcl3huxwaCtmkd7EGy5Pc2fqZYaSa1Z5kF/Usscrd4k8tpk69k4vOfXbocH/cQ6jswbfNWvdtPJxh59kTCuyFmBlq5fUces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPncEIZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FFAC4CEF5;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940719;
	bh=tQh371Xu4aNv634IWnbNpzI8g0gGO4AVuobSDHJ5Ps4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=YPncEIZNeWYyU+Bt9rm/KZTt696DmMS0QKxERpoPjndVNQK3Oa6m4/ckgpS+5ylj6
	 EscF0muNd5qA10L6Fs34V5HulXr3LzTuz0gu1Uv3Mx4Agq9kZNQFd+PzPiYV9jotzB
	 1tAqgkqb8RaFVi9HfnEFEbXLBAGKirrOuRNKENm7kgW/i+q8nEwyf/9KTyxv8tqnU2
	 C7nMQeo1DGU8qH4TBUy5Z35HGdobSU41BzzM507ZzfoX9DJZMyi/eld1OLy4pyRlkY
	 xLYAuNwgYp3ENA+nm+zeaic4Z+ex3OFU5mY7vflH1150Pg6n6eRRNyZU4eNpOWDNdO
	 p2MgRd8aTVj0Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxoN-00000000DeW-3dri;
	Mon, 07 Jul 2025 22:11:59 -0400
Message-ID: <20250708021159.719618907@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:11:23 -0400
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
Subject: [PATCH v8 08/12] unwind_user/sframe: Remove .sframe section on detected corruption
References: <20250708021115.894007410@kernel.org>
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




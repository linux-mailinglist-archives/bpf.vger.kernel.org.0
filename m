Return-Path: <bpf+bounces-66718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2DB38AE4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8295A2084BE
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F63081A7;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APHVpDv6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F2301028;
	Wed, 27 Aug 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326262; cv=none; b=lNM30zzYZDfC2vqphWaraRVjiJWLGukz9XvcFsxNHVi62M8Wb/scGXdPoqgQ/ExhYM9XvkkudeQe06A4mFhEI8QRD02EeOXVrV/Y2ovq6Euyaiqi3k5UU9fPBWAMu/pkhaLK5xc8+1WJbRa7JXTBrOlY4yW0ZQZdRg3PcdPlEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326262; c=relaxed/simple;
	bh=EgHoeoxXCjxslVJujBtFAK4/oaW+ZtT15/3T3C1cFpY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BJYbPQuy71AdQTVsO60B5fXxkw/IEXT8m60sQLymKbNE0TJX3pJ1YPkTxlxkgnRvYY4lrBl8xBmCHHgJoOcMGREYM+WgTFgIhebIbvA7z1sTyS+6r8BdF9uZGdkjCDHtWDgD0dSfYTufZyQJOnbeOIH5ccRA94osQtIKFZwCSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APHVpDv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA31C4CEFA;
	Wed, 27 Aug 2025 20:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756326262;
	bh=EgHoeoxXCjxslVJujBtFAK4/oaW+ZtT15/3T3C1cFpY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=APHVpDv6+sGOzsT07FlPoOJMlel/ovN020dbdkghGgEQBAOAaCqSix3fFPp1/NI/Y
	 nBovlfX2dNP7yv4p6DMvSRceP0s4TpUi9poQA2YduXYwGrTGTbqCeRaDyCd9ax89tz
	 S/4wjyxoeI1aXmiV7d9mEIXxxZ8sOIaHfO8RV4Wr2z+8PerpXU2DbjM+SGeecsFNIM
	 ag4eQBqAm+RGCtjWyg5Z8q+SoH3vcP4NnVWKAgijHnW/j+n8gAzm9Z0c7mey6TvVRT
	 5UIRdimAi1TZND47cppFNcFAGcyAvcxbmnDxotDn4yg48VXlJMQ9ktVkYwwAq0WOTt
	 Wva4yZzCMlfuw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urMhF-00000003kzp-2Tcm;
	Wed, 27 Aug 2025 16:24:41 -0400
Message-ID: <20250827202441.441080427@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 16:15:56 -0400
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
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v10 08/11] unwind_user/sframe: Remove .sframe section on detected corruption
References: <20250827201548.448472904@kernel.org>
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
2.50.1




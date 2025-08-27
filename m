Return-Path: <bpf+bounces-66716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC05B38AE5
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B36683C3D
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47556305E2E;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUnynYLK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23042FFDE6;
	Wed, 27 Aug 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326262; cv=none; b=lwfyMSPUAc25+6pN7hoawDVz4fIatqxK5U0cSIkz9ogev3C9SIai0gJstxNSzxsPeLz6bNfGGLZbFVsl95G0mlmzvdMsl4g3Af0hcLXna1NsTs6vE/8voDhEH3rjXPZM6f++fxK7jJwJsCE5ywEQlKZgN+wd0eUOmfacRBD1Xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326262; c=relaxed/simple;
	bh=GYS2jS3IBb5LImBXp+CSuVflYR2klNpfl1fOuznBhsg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RpN7/tPBPRdK0yX3S6ljmmoeVdRmJJs9Ci8TALo8DjF4xKd9wb8PV7zUSWksycXRORVJ6f6e7iNAN4nUBR788QKw/TnULyHRCdgaRpzyeWLI4pZWI556J8J8kNO09wfMRddN78aON9yxdxgZzve/SmuRoMxQwYoZWSfIgY1sW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUnynYLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80217C4AF11;
	Wed, 27 Aug 2025 20:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756326262;
	bh=GYS2jS3IBb5LImBXp+CSuVflYR2klNpfl1fOuznBhsg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=AUnynYLKZF9uvt/IlSpeh0nx9uXnCQT2RtJg768NNQwKvOey+8g+JRoo8GWxUGp9Z
	 /WJZctxLCDpo+nQ3OMKMS/ephUxLM/bfNKz+BG6sePOmNdBQnCK7XTewS6g3jXgre1
	 /rZ17lAyXA9O6OEh5C7uhPqDO6bxImpRYC/XkCSmUWAp1CSN+QUPjtjnHy2xvexGfa
	 PkGEJJsgrAxUylLKm34T7IQhbpCpRDLM+PUQbp4sc3aKwp3wjVPYoz3ZrJsF7SIMl+
	 IW2RpHe4H3esKRKTtT6un6pJnETyF9ALAXtdeJnYn1OWmibHbVjBOnR2/r/8MYfm24
	 BtLkf0W8ikooQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urMhF-00000003kzK-1lhq;
	Wed, 27 Aug 2025 16:24:41 -0400
Message-ID: <20250827202441.276817748@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 16:15:55 -0400
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
Subject: [PATCH v10 07/11] unwind_user/sframe/x86: Enable sframe unwinding on x86
References: <20250827201548.448472904@kernel.org>
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
index 8f94c58d4de8..c3518f145f0d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -300,6 +300,7 @@ config X86
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
+	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
-- 
2.50.1




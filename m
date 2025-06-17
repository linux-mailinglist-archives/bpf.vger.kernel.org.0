Return-Path: <bpf+bounces-60859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48062ADDF24
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E3A189C9F4
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371D6295DB2;
	Tue, 17 Jun 2025 22:51:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6372F5310;
	Tue, 17 Jun 2025 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200678; cv=none; b=a/AY6WqwJ7BavUz3NEyMOxRf7iiwqNs2fIhOirZXAYAHbVxpRq/6dQEy4WERhYlqtEtTQHt4Poccqt5z/xWxfSRt+qQwRq87pbu9NfjA/O0lHvUrlNVhCea/TdpcilDwlmuIQ92DWipQILd7hjO3kdcr8L0O0UZtK7cxNF0fmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200678; c=relaxed/simple;
	bh=iXGszjtXOZHDy7gWbPWg+lr0E7dCDoezrDFH319UBvg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TgNLYWg7DDrY6a6XO/pGL2V84mwmP/uP8M2QV+aHPBEMnLrPKubBX6Ufc+TVRW10jq/GanRCcZErJNy3C50XazULRTwiHjH7lFWQRg2hTPnaSwsp3+Ng1qf1PnHNARLSrY6cRwK47tCRy7PyIN312ttl+jSDlIH4tr7WGnXi61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B67CD1017B3;
	Tue, 17 Jun 2025 22:51:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id B0B0530;
	Tue, 17 Jun 2025 22:51:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uRf9C-00000002L6s-29si;
	Tue, 17 Jun 2025 18:51:18 -0400
Message-ID: <20250617225118.364667867@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Jun 2025 18:50:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 08/12] unwind_user/sframe/x86: Enable sframe unwinding on x86
References: <20250617225009.233007152@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: q7ycq9d9dkc7owgwa5cynr53tds45bj8
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B0B0530
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Uzply6cl3gsXjJr1KesH0wywOxldb14w=
X-HE-Tag: 1750200671-394734
X-HE-Meta: U2FsdGVkX19AJUtTTAelvx03X7L/01djQSa83Uwsp3IhNfD2PRZCjVo0MqQWFJfaGNNof5VwHcEYxMnzNbSJWrh8w/oiY9wOtCwKDtiNXIB1pekrwVTMxdwmQykBPnET6Fc+5MRvFv1+i3GGNotahAsOxsh11izQoycQjERlY2zkxVkfrmC7XgvRjVGBEhNYKrWmOSEYT+h8fATbnln8bU8PVukvSQwR92XlwNMXVW0bgw6KVInYGxTg6v2qrmPJaSoJ2kSGKzUVK8CjNKlF3UPTLc8fOOUwa35jIHkUzRwq+Kd05rIJS90PhmdJa/IzYJwR0pN/rWQOy9Bhk/eLau7tlIRFC3vxeZFLGMO08rFlS6uo8oBQX902PMbymuAn80vrv6ghWqMugBD5MguW3yJF6Ad1+Lz2xrA9CzsizHE=

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
index 3f7bdc9e3cec..e282c5123385 100644
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




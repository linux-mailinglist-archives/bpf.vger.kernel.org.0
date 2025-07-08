Return-Path: <bpf+bounces-62630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDC3AFC0A5
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300E73A6EC5
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB3235BE1;
	Tue,  8 Jul 2025 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDI5dXgc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3E9230BFF;
	Tue,  8 Jul 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940720; cv=none; b=NSP8L3pFkQE60ybALlAaP/9Q0MLKFza8LFhCdom9Mr0+wTmJHRhZbe7WNxgR7MdBrBaA83Fxscgf9876gurLADLAhJSYwsyTEZjtv883mhEvKZvvb0xtqtKUEalEUR2WWHTmfV6XC/qhfXw2sO9qN8b89KkJEc1vGpieIuip2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940720; c=relaxed/simple;
	bh=Kp6RYb5t+RCZ7jokiwYGJB2GAw8QmJKJAuA8NhLPUp4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Aa88Tw42C2GaJ/wlMiA0iLMTu0CE3pVvMh6cdAszzNEGpxuuy3DNZxKmHq6/OMd6Z6f6msTojme7xLHeAOTccZi2LZuHVh/6hsfnq5XwCEYnOpXioGfxB6xCpDr+n/a8s1ViqmzBLbSXukYVpwkxxMJCe2NnhP6NISLkMtoZZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDI5dXgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF36C4CEF7;
	Tue,  8 Jul 2025 02:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940720;
	bh=Kp6RYb5t+RCZ7jokiwYGJB2GAw8QmJKJAuA8NhLPUp4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=VDI5dXgchyXngwF9gjq44ApKHJNunSERqJc01O+SEFBvL4wgcfHl5aAQvpGno46Z4
	 HyEGRq/ORld4q4ah2FTfk8pFeoqCXI+RH2YsIvg0S16AC44tgAuydlK9qCqdX5NFda
	 lEr1uYaH9uLgSym5yp2jQaoJJST5xzEy63C08g2B7iiQ2Wzh8GFcthxAntlYsz9/HF
	 PK5HeKkkH/WL2lw6nswDW7SM76bGe5sMuOMrWX1Bk/aCyQZSQdTD/finxbv/ScNmgu
	 i2JOj2HCVVpH9cH9ELGLSq6qeJLXa1D/BXwxYhP4LGw4H6WEV5ycI2+qUTcjcZa52D
	 d7ivtv1UiFa2A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxoO-00000000Dg2-1ZjL;
	Mon, 07 Jul 2025 22:12:00 -0400
Message-ID: <20250708021200.223446028@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:11:26 -0400
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
Subject: [PATCH v8 11/12] unwind_user/sframe: Add .sframe validation option
References: <20250708021115.894007410@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add a debug feature to validate all .sframe sections when first loading
the file rather than on demand.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig           | 19 ++++++++++
 kernel/unwind/sframe.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 0c6056ef13de..86eec85cb898 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -450,6 +450,25 @@ config HAVE_UNWIND_USER_SFRAME
 	bool
 	select UNWIND_USER
 
+config SFRAME_VALIDATION
+	bool "Enable .sframe section debugging"
+	depends on HAVE_UNWIND_USER_SFRAME
+	depends on DYNAMIC_DEBUG
+	help
+	  When adding an .sframe section for a task, validate the entire
+	  section immediately rather than on demand.
+
+	  This is a debug feature which is helpful for rooting out .sframe
+	  section issues.  If the .sframe section is corrupt, it will fail to
+	  load immediately, with more information provided in dynamic printks.
+
+	  This has a significant page cache footprint due to its reading of the
+	  entire .sframe section for every loaded executable and shared
+	  library.  Also, it's done for all processes, even those which don't
+	  get stack traced by the kernel.  Not recommended for general use.
+
+	  If unsure, say N.
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 3972bce40fc7..6159f072bdb6 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -353,6 +353,83 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	return ret;
 }
 
+#ifdef CONFIG_SFRAME_VALIDATION
+
+static __always_inline int __sframe_validate_section(struct sframe_section *sec)
+{
+	unsigned long prev_ip = 0;
+	unsigned int i;
+
+	for (i = 0; i < sec->num_fdes; i++) {
+		struct sframe_fre *fre, *prev_fre = NULL;
+		unsigned long ip, fre_addr;
+		struct sframe_fde fde;
+		struct sframe_fre fres[2];
+		bool which = false;
+		unsigned int j;
+		int ret;
+
+		ret = __read_fde(sec, i, &fde);
+		if (ret)
+			return ret;
+
+		ip = sec->sframe_start + fde.start_addr;
+		if (ip <= prev_ip) {
+			dbg_sec_uaccess("fde %u not sorted\n", i);
+			return -EFAULT;
+		}
+		prev_ip = ip;
+
+		fre_addr = sec->fres_start + fde.fres_off;
+		for (j = 0; j < fde.fres_num; j++) {
+			int ret;
+
+			fre = which ? fres : fres + 1;
+			which = !which;
+
+			ret = __read_fre(sec, &fde, fre_addr, fre);
+			if (ret) {
+				dbg_sec_uaccess("fde %u: __read_fre(%u) failed\n", i, j);
+				dbg_print_fde_uaccess(sec, &fde);
+				return ret;
+			}
+
+			fre_addr += fre->size;
+
+			if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
+				dbg_sec_uaccess("fde %u: fre %u not sorted\n", i, j);
+				return -EFAULT;
+			}
+
+			prev_fre = fre;
+		}
+	}
+
+	return 0;
+}
+
+static int sframe_validate_section(struct sframe_section *sec)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start)) {
+		dbg_sec("section usercopy failed\n");
+		return -EFAULT;
+	}
+
+	ret = __sframe_validate_section(sec);
+	user_read_access_end();
+	return ret;
+}
+
+#else /*  !CONFIG_SFRAME_VALIDATION */
+
+static int sframe_validate_section(struct sframe_section *sec) { return 0; }
+
+#endif /* !CONFIG_SFRAME_VALIDATION */
+
+
 static void free_section(struct sframe_section *sec)
 {
 	dbg_free(sec);
@@ -461,6 +538,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 		goto err_free;
 	}
 
+	ret = sframe_validate_section(sec);
+	if (ret)
+		goto err_free;
+
 	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
 	if (ret) {
 		dbg_sec("mtree_insert_range failed: text=%lx-%lx\n",
-- 
2.47.2




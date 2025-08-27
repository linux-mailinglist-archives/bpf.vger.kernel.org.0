Return-Path: <bpf+bounces-66720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A5B38AE7
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E99F1C21E33
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB603081C1;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN3lC9as"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DD304BCA;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326263; cv=none; b=nG7RLxE01iWFoKd05O5sDb6D476wKIJDVwfnRxoQ1skon3o8GZsFhJMayH0OlC8eiRUBnxURNEaWgGqr6Qs6vpwfH5feiP6lK5NKJ0mQ8J1eDtnRqdepmkSfScLk3ITxop7Pumq3sXqAbRbzeZk8CEm+SR26DGkP7YjfDg+CTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326263; c=relaxed/simple;
	bh=B0Z0hge9MApW75b17usDdRxmkX5DdtylXDH/jRh6dj4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XP6RvX0mZOd/PRqlDUB1qxJ90VgOyBc/th99xOpVOi6JtdAv87GMwdpSDSLwH4BamNGQSkavMhgQ+qSXfWSWSb15IUbgpqce+ZCFi9bZHBpwitwlcPafGGj+4hsj7Usg9Dgo9RbuIxZrIqQmJV3Upu6HKus+PY5aajhBp5CUCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN3lC9as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056A3C4CEEB;
	Wed, 27 Aug 2025 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756326263;
	bh=B0Z0hge9MApW75b17usDdRxmkX5DdtylXDH/jRh6dj4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ZN3lC9as6z85Vu96b7dlCuCAB68Zp7ESIARXwCw6Qk6Egz6iQngzm/NVUtj9oiw+3
	 gcJumShNdJqQe11PveT1f2+ySFHwh7Y5+ma/HYdCIa/ii6zvN3+JaY/t1utHDCQKe3
	 SZU+ndOIQHieK6fIV7riyaEduBWJn4wpmx4ghCyX+GhqkuNJJbKA1tL4OFLTLVLqSv
	 uQq2CFUgaVlgYKZfk3/6lEtKw8lO6hrVWIRIILBWjgiMtfFuLwYEaGDFzsthBBh7zy
	 qHke4zqDC1XCgt+Nne0U1MnQc40HHb9ZykLKVDZxt8c2XRil2dW/Tvq9JiG/ykPVAo
	 w4YN0JySoTXHA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urMhF-00000003l0o-3tCK;
	Wed, 27 Aug 2025 16:24:41 -0400
Message-ID: <20250827202441.776912299@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 16:15:58 -0400
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
Subject: [PATCH v10 10/11] unwind_user/sframe: Add .sframe validation option
References: <20250827201548.448472904@kernel.org>
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
 arch/Kconfig           | 19 +++++++++
 kernel/unwind/sframe.c | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 277b87af949f..918ebe3c5a85 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -455,6 +455,25 @@ config HAVE_UNWIND_USER_SFRAME
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
index 66d3ba3c8389..79ff3c0fc11f 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -319,6 +319,98 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	return ret;
 }
 
+#ifdef CONFIG_SFRAME_VALIDATION
+
+static int safe_read_fde(struct sframe_section *sec,
+			 unsigned int fde_num, struct sframe_fde *fde)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
+	ret = __read_fde(sec, fde_num, fde);
+	user_read_access_end();
+	return ret;
+}
+
+static int safe_read_fre(struct sframe_section *sec,
+			 struct sframe_fde *fde, unsigned long fre_addr,
+			 struct sframe_fre *fre)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
+	ret = __read_fre(sec, fde, fre_addr, fre);
+	user_read_access_end();
+	return ret;
+}
+
+static int sframe_validate_section(struct sframe_section *sec)
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
+		ret = safe_read_fde(sec, i, &fde);
+		if (ret)
+			return ret;
+
+		ip = sec->sframe_start + fde.start_addr;
+		if (ip <= prev_ip) {
+			dbg_sec("fde %u not sorted\n", i);
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
+			ret = safe_read_fre(sec, &fde, fre_addr, fre);
+			if (ret) {
+				dbg_sec("fde %u: __read_fre(%u) failed\n", i, j);
+				dbg_sec("FDE: start_addr:0x%x func_size:0x%x fres_off:0x%x fres_num:%d info:%u rep_size:%u\n",
+					fde.start_addr, fde.func_size,
+					fde.fres_off, fde.fres_num,
+					fde.info, fde.rep_size);
+				return ret;
+			}
+
+			fre_addr += fre->size;
+
+			if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
+				dbg_sec("fde %u: fre %u not sorted\n", i, j);
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
@@ -427,6 +519,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
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
2.50.1




Return-Path: <bpf+bounces-62628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F0EAFC0A4
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D654275E1
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AB231837;
	Tue,  8 Jul 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFOLG9VA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359F2264B2;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940719; cv=none; b=iDh3HU2TBwV27NWQvpEWi/843pXk4bhD2nS8I8WpGJVvJO0YWzXrGmMS8tEB0+Jdm655MSs3OKuJbFJdfSZx59j+nBLn3eEyFAWB47qt1Xo8AO8DxqPAYHCNOP6PCm7AGsmabyyoa1mvbE4s7MoWFDvSvtVCk+A7/P1SJNalmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940719; c=relaxed/simple;
	bh=+1dKUkXeGNCMo2SsOx0RVb/skigBKBZOQ6KCmMD4/Gk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WUHWEBfWTB+pmr3Bz2CU852Nq703bMRhc+w2ewvcJYe0pXqh7+jOka3mNeuTGGwY8YZznlI/aStJVZfMTzet0C6VEgVusrJk2SKUY+ouYDe9rwyFdpLjs3bRLPx7moCvLNMYKCkKDWp9MBbJFnUcy2qEU6y/xoHDjBGb0wnOu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFOLG9VA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3633C4CEF4;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940719;
	bh=+1dKUkXeGNCMo2SsOx0RVb/skigBKBZOQ6KCmMD4/Gk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=mFOLG9VA4dPKzffvcdJ96kiN3gm1LjnqC+daOwiuMsecExk5/wmhJIWtdX4VZyv1d
	 jdFebOzEY3jgoJE0rRN941AZHTaQDtUmrLDc5KbdysBrV4FvwkElhT33RZ4wIt4/Ae
	 saq3uo1aujuzJehUQoKGNH9VBycoQN4TDBSwNCm9+N3wnSoxHF1lRV0S3bsPnrQfXj
	 SUlCe46VUNmyzrFcRZZAG5j7JX1i0p3xugwWgtM+XMO+9EzCiREvZfE+I+hdWEWOjB
	 6RfElJDzBgCNQZirfO54x/Nt79pqOAJPHDs/MUETZullt58088Ho771YBmRrxNRPQT
	 2vE3Q2uXzy3ng==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxoO-00000000Df2-09ow;
	Mon, 07 Jul 2025 22:12:00 -0400
Message-ID: <20250708021159.889174831@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:11:24 -0400
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
Subject: [PATCH v8 09/12] unwind_user/sframe: Show file name in debug output
References: <20250708021115.894007410@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

When debugging sframe issues, the error messages aren't all that helpful
without knowing what file a corresponding .sframe section belongs to.
Prefix debug output strings with the file name.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sframe.h       |  4 +++-
 kernel/unwind/sframe.c       | 23 ++++++++++--------
 kernel/unwind/sframe_debug.h | 45 +++++++++++++++++++++++++++++++-----
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index 9a72209696f9..b79c5ec09229 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -10,7 +10,9 @@
 
 struct sframe_section {
 	struct rcu_head	rcu;
-
+#ifdef CONFIG_DYNAMIC_DEBUG
+	const char	*filename;
+#endif
 	unsigned long	sframe_start;
 	unsigned long	sframe_end;
 	unsigned long	text_start;
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index f246ead6c2a0..66d3ba3c8389 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -311,14 +311,17 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 end:
 	user_read_access_end();
 
-	if (ret == -EFAULT)
+	if (ret == -EFAULT) {
+		dbg_sec("removing bad .sframe section\n");
 		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
+	}
 
 	return ret;
 }
 
 static void free_section(struct sframe_section *sec)
 {
+	dbg_free(sec);
 	kfree(sec);
 }
 
@@ -329,7 +332,7 @@ static int sframe_read_header(struct sframe_section *sec)
 	unsigned int num_fdes;
 
 	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
-		dbg("header usercopy failed\n");
+		dbg_sec("header usercopy failed\n");
 		return -EFAULT;
 	}
 
@@ -337,18 +340,18 @@ static int sframe_read_header(struct sframe_section *sec)
 	    shdr.preamble.version != SFRAME_VERSION_2 ||
 	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
 	    shdr.auxhdr_len) {
-		dbg("bad/unsupported sframe header\n");
+		dbg_sec("bad/unsupported sframe header\n");
 		return -EINVAL;
 	}
 
 	if (!shdr.num_fdes || !shdr.num_fres) {
-		dbg("no fde/fre entries\n");
+		dbg_sec("no fde/fre entries\n");
 		return -EINVAL;
 	}
 
 	header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
 	if (header_end >= sec->sframe_end) {
-		dbg("header doesn't fit in section\n");
+		dbg_sec("header doesn't fit in section\n");
 		return -EINVAL;
 	}
 
@@ -360,7 +363,7 @@ static int sframe_read_header(struct sframe_section *sec)
 	fres_end   = fres_start + shdr.fre_len;
 
 	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
-		dbg("inconsistent fde/fre offsets\n");
+		dbg_sec("inconsistent fde/fre offsets\n");
 		return -EINVAL;
 	}
 
@@ -416,6 +419,8 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 	sec->text_start		= text_start;
 	sec->text_end		= text_end;
 
+	dbg_init(sec);
+
 	ret = sframe_read_header(sec);
 	if (ret) {
 		dbg_print_header(sec);
@@ -424,8 +429,8 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 
 	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
 	if (ret) {
-		dbg("mtree_insert_range failed: text=%lx-%lx\n",
-		    sec->text_start, sec->text_end);
+		dbg_sec("mtree_insert_range failed: text=%lx-%lx\n",
+			sec->text_start, sec->text_end);
 		goto err_free;
 	}
 
@@ -447,7 +452,7 @@ static int __sframe_remove_section(struct mm_struct *mm,
 				   struct sframe_section *sec)
 {
 	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
-		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
+		dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
 		return -EINVAL;
 	}
 
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
index 055c8c8fae24..7794bf0bd78c 100644
--- a/kernel/unwind/sframe_debug.h
+++ b/kernel/unwind/sframe_debug.h
@@ -10,26 +10,59 @@
 #define dbg(fmt, ...)							\
 	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
 
+#define dbg_sec(fmt, ...)						\
+	dbg("%s: " fmt, sec->filename, ##__VA_ARGS__)
+
 static __always_inline void dbg_print_header(struct sframe_section *sec)
 {
 	unsigned long fdes_end;
 
 	fdes_end = sec->fdes_start + (sec->num_fdes * sizeof(struct sframe_fde));
 
-	dbg("SEC: sframe:0x%lx-0x%lx text:0x%lx-0x%lx "
-	    "fdes:0x%lx-0x%lx fres:0x%lx-0x%lx "
-	    "ra_off:%d fp_off:%d\n",
-	    sec->sframe_start, sec->sframe_end, sec->text_start, sec->text_end,
-	    sec->fdes_start, fdes_end, sec->fres_start, sec->fres_end,
-	    sec->ra_off, sec->fp_off);
+	dbg_sec("SEC: sframe:0x%lx-0x%lx text:0x%lx-0x%lx "
+		"fdes:0x%lx-0x%lx fres:0x%lx-0x%lx "
+		"ra_off:%d fp_off:%d\n",
+		sec->sframe_start, sec->sframe_end, sec->text_start, sec->text_end,
+		sec->fdes_start, fdes_end, sec->fres_start, sec->fres_end,
+		sec->ra_off, sec->fp_off);
+}
+
+static inline void dbg_init(struct sframe_section *sec)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	guard(mmap_read_lock)(mm);
+	vma = vma_lookup(mm, sec->sframe_start);
+	if (!vma)
+		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);
+	else if (vma->vm_file)
+		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);
+	else if (vma->vm_ops && vma->vm_ops->name)
+		sec->filename = kstrdup(vma->vm_ops->name(vma), GFP_KERNEL);
+	else if (arch_vma_name(vma))
+		sec->filename = kstrdup(arch_vma_name(vma), GFP_KERNEL);
+	else if (!vma->vm_mm)
+		sec->filename = kstrdup("(vdso)", GFP_KERNEL);
+	else
+		sec->filename = kstrdup("(anonymous)", GFP_KERNEL);
+}
+
+static inline void dbg_free(struct sframe_section *sec)
+{
+	kfree(sec->filename);
 }
 
 #else /* !CONFIG_DYNAMIC_DEBUG */
 
 #define dbg(args...)			no_printk(args)
+#define dbg_sec(args...	)		no_printk(args)
 
 static inline void dbg_print_header(struct sframe_section *sec) {}
 
+static inline void dbg_init(struct sframe_section *sec) {}
+static inline void dbg_free(struct sframe_section *sec) {}
+
 #endif /* !CONFIG_DYNAMIC_DEBUG */
 
 #endif /* _SFRAME_DEBUG_H */
-- 
2.47.2




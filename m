Return-Path: <bpf+bounces-60869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D9ADDF38
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5359189E83E
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5FF2F2732;
	Tue, 17 Jun 2025 22:51:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340E2F0C40;
	Tue, 17 Jun 2025 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200684; cv=none; b=Ro2iGnFhl/FKWSbDhtMb9U+ItZoCRRSd2Rn0ygR0tn3Mzi4MeKkPhCVQn0bFW2TsOSl+uOIz8F+8FOWO/TyxSDimgcSaHCGcX85gNycikQCYAaKPH7QXLmavh03LyPB94oHyZzv6fI2wzawHlgAAA53u+wQ698BeYUuh6tsaeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200684; c=relaxed/simple;
	bh=ShUHp/wqwcY55c8QXwJf8hpQWS+ZW3po2DP2qOe02+A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=V3zN/xDiNwzPdfM1aXlQSq0GZJN7tPWWGaxJ20OIsNWemJ/cOqx6YwirM7PR0TeJmZ4Z6am3Bb3KKt21IwNAl+Is9kKiha9mM4MWQVuKaiECCsF846tAn3B2KipWLo3lk5ezLK5DNNfZDNoHF/HdJCzru0OKhfUBvQnKCCqVa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C6AD7161208;
	Tue, 17 Jun 2025 22:51:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id B22A52000D;
	Tue, 17 Jun 2025 22:51:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uRf9B-00000002L3x-26IK;
	Tue, 17 Jun 2025 18:51:17 -0400
Message-ID: <20250617225117.349098754@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Jun 2025 18:50:11 -0400
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
Subject: [PATCH v6 02/12] unwind_user/sframe: Store sframe section data in per-mm maple tree
References: <20250617225009.233007152@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: B22A52000D
X-Stat-Signature: ajzgg1xtm7q3jk6gayf448kbpdsyxm7f
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ByZZco0tmx3xbfqiL1iYjHdAWST2LaG8=
X-HE-Tag: 1750200670-644817
X-HE-Meta: U2FsdGVkX1+tfTKb/4tXNbkvF/yipibTe6D1HWtowO/5FCkAcu1jDfem9dZI+dF1xF31NGzWXtli3TqGpMzBN6TaSyq78CaZ/wJVuJF7nkK9qH/BXT1V7q/sxtZFcA3sEK++0fo4rta2755Uolv1BWNaDtYY5ipbYWUFtZ4WjT+twIoy60ZuPGbYNxkfc3sgMvD/Ui4XS5GBT+eDTMV6FA9W1JpVH6bpxoEqXko73j/AL5atz0WUgYvW34KtLHd49epvxpoVmR254sB+aGKrs/e3o/+kC1AbPK0F9Ky+WGvcEqaOWXQCtli3iEb5cx0G1+xMl4HRIxbUtYYnnaXnc5aTph9Jkl8ybC5x2Q0ggnxBUZfS/sUO+anRT6pAU1/6A7y69sgsF9cpRCf45fCvyI/uOwl9kdMYAwG8wpgFVLk=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Associate an sframe section with its mm by adding it to a per-mm maple
tree which is indexed by the corresponding text address range.  A single
sframe section can be associated with multiple text ranges.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/include/asm/mmu.h |  2 +-
 include/linux/mm_types.h   |  3 +++
 include/linux/sframe.h     | 13 +++++++++
 kernel/fork.c              | 10 +++++++
 kernel/unwind/sframe.c     | 55 +++++++++++++++++++++++++++++++++++---
 mm/init-mm.c               |  2 ++
 6 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 0fe9c569d171..227a32899a59 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -87,7 +87,7 @@ typedef struct {
 	.context = {							\
 		.ctx_id = 1,						\
 		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
-	}
+	},
 
 void leave_mm(void);
 #define leave_mm leave_mm
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6b91e8a66d6..4296cabf4afa 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1206,6 +1206,9 @@ struct mm_struct {
 #ifdef CONFIG_MM_ID
 		mm_id_t mm_id;
 #endif /* CONFIG_MM_ID */
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+		struct maple_tree sframe_mt;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index 0584f661f698..73bf6f0b30c2 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -22,18 +22,31 @@ struct sframe_section {
 	signed char	fp_off;
 };
 
+#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),
+extern void sframe_free_mm(struct mm_struct *mm);
+
 extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 			      unsigned long text_start, unsigned long text_end);
 extern int sframe_remove_section(unsigned long sframe_addr);
 
+static inline bool current_has_sframe(void)
+{
+	struct mm_struct *mm = current->mm;
+
+	return mm && !mtree_empty(&mm->sframe_mt);
+}
+
 #else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
 
+#define INIT_MM_SFRAME
+static inline void sframe_free_mm(struct mm_struct *mm) {}
 static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 				     unsigned long text_start, unsigned long text_end)
 {
 	return -ENOSYS;
 }
 static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
+static inline bool current_has_sframe(void) { return false; }
 
 #endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3341d50c61f2..e56daf4e546f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -106,6 +106,7 @@
 #include <linux/pidfs.h>
 #include <linux/tick.h>
 #include <linux/unwind_deferred.h>
+#include <linux/sframe.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -687,6 +688,7 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+	sframe_free_mm(mm);
 
 	free_mm(mm);
 }
@@ -1024,6 +1026,13 @@ static void mmap_init_lock(struct mm_struct *mm)
 #endif
 }
 
+static void mm_init_sframe(struct mm_struct *mm)
+{
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+	mt_init(&mm->sframe_mt);
+#endif
+}
+
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
@@ -1053,6 +1062,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->pmd_huge_pte = NULL;
 #endif
 	mm_init_uprobes_state(mm);
+	mm_init_sframe(mm);
 	hugetlb_count_init(mm);
 
 	if (current->mm) {
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 20287f795b36..fa7d87ffd00a 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -122,15 +122,64 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 	if (ret)
 		goto err_free;
 
-	/* TODO nowhere to store it yet - just free it and return an error */
-	ret = -ENOSYS;
+	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
+	if (ret) {
+		dbg("mtree_insert_range failed: text=%lx-%lx\n",
+		    sec->text_start, sec->text_end);
+		goto err_free;
+	}
+
+	return 0;
 
 err_free:
 	free_section(sec);
 	return ret;
 }
 
+static int __sframe_remove_section(struct mm_struct *mm,
+				   struct sframe_section *sec)
+{
+	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
+		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
+		return -EINVAL;
+	}
+
+	free_section(sec);
+
+	return 0;
+}
+
 int sframe_remove_section(unsigned long sframe_start)
 {
-	return -ENOSYS;
+	struct mm_struct *mm = current->mm;
+	struct sframe_section *sec;
+	unsigned long index = 0;
+	bool found = false;
+	int ret = 0;
+
+	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
+		if (sec->sframe_start == sframe_start) {
+			found = true;
+			ret |= __sframe_remove_section(mm, sec);
+		}
+	}
+
+	if (!found || ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+void sframe_free_mm(struct mm_struct *mm)
+{
+	struct sframe_section *sec;
+	unsigned long index = 0;
+
+	if (!mm)
+		return;
+
+	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX)
+		free_section(sec);
+
+	mtree_destroy(&mm->sframe_mt);
 }
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 4600e7605cab..b32fcf167cc2 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -11,6 +11,7 @@
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
 #include <linux/iommu.h>
+#include <linux/sframe.h>
 #include <asm/mmu.h>
 
 #ifndef INIT_MM_CONTEXT
@@ -46,6 +47,7 @@ struct mm_struct init_mm = {
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 	INIT_MM_CONTEXT(init_mm)
+	INIT_MM_SFRAME
 };
 
 void setup_initial_init_mm(void *start_code, void *end_code,
-- 
2.47.2




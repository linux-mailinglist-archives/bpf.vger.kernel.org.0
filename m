Return-Path: <bpf+bounces-60865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C2ADDF2F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FB33BD73E
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5522EAB85;
	Tue, 17 Jun 2025 22:51:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF528983C;
	Tue, 17 Jun 2025 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200681; cv=none; b=KtVY7WcM+CRsAfbXkIk39MSUK6eWh9hH534+Vn9rI29X4uYxvza5hqlGvN01QFZIBE+wdzh4dBlGD+A7u2UNsLLcWfaaHT9IW4HJkBtuRCF7XcA8EUazonLinoKMnYZKOyBvublLva7hqDGU39gT3iAmENk2Y/9KzMEpw1HfKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200681; c=relaxed/simple;
	bh=N11IKOSTRsuhgUUB4jrq9+qZ/9RCPUE2KJ8G23H5Uoc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HBODM7/qLkFAWtiUGkI2rm3K2Z+oPd8fXSH59bA5bKrx6y7tsyuE/TUGvU0SmnSWJ0qP0WL46oEP8Bup3yeWj/+c/KEww3K95eILUsb67lfpG+YGKKhY1NBy3Xe+hkn5B7NFNUI1CHkyZ17OLCRHod/3ebrVhraTUcrxA4KXYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 35FCE81184;
	Tue, 17 Jun 2025 22:51:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 0464460009;
	Tue, 17 Jun 2025 22:51:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uRf9B-00000002L4v-3VTQ;
	Tue, 17 Jun 2025 18:51:17 -0400
Message-ID: <20250617225117.684288771@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Jun 2025 18:50:13 -0400
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
Subject: [PATCH v6 04/12] unwind_user/sframe: Add support for reading .sframe contents
References: <20250617225009.233007152@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 0464460009
X-Stat-Signature: etafwdbr47omdhx537kr77tdxrb44o6u
X-Rspamd-Server: rspamout05
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18xX3CKhrsM6tM0l3GOTHWPf8Zhh33AN58=
X-HE-Tag: 1750200670-927214
X-HE-Meta: U2FsdGVkX19KYzcpdX5Ig0g2ErEN9TaMmR+UEtY8FSzJo33tMaAK++PDiFoVu0FjkQ0QXPZABS42hxoFabyVdF77/loRfiKWLClfjIie2iOPrS4SW2N7cIj5I0zaxhSod0mtwxLeXMv4eIBIzimhkq0bpJHW1DVATdAETzOOtGumBKtdyPx8h7cfckbnWq1qWlRfrpS2sYsW3JIF0/RUoAdtzVlL8Fy+v51qxsa6MQgj/KAHKHH6RFrGwrffSdHXPCA0ICSurXKbQ4izvVD3E3OgBYrtx7PV9+Kt4uqS76jtxwy2KOcSa1qTAOCvPjf1i4D8s9r+0JikoW8YwQwWG1lRQ2cfR5t+SVCVrSt/4ihHRc0ut6+5KOg3PzyX+3cC6D1kvJTRQcVnn2Y0ThQ03lo2EEvoCt0VPetVxGmbw1kzj3Z7pLTMh78T1fN754/oILcMGYYACPw=

From: Josh Poimboeuf <jpoimboe@kernel.org>

In preparation for using sframe to unwind user space stacks, add an
sframe_find() interface for finding the sframe information associated
with a given text address.

For performance, use user_read_access_begin() and the corresponding
unsafe_*() accessors.  Note that use of pr_debug() in uaccess-enabled
regions would break noinstr validation, so there aren't any debug
messages yet.  That will be added in a subsequent commit.

Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org/
Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com/

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lore.kernel.org/20250424201824.113896892@goodmis.org

- Added updates from Jens Remus <jremus@linux.ibm.com>
  https://lore.kernel.org/all/20250528102655.1455423-1-jremus@linux.ibm.com/

 include/linux/sframe.h       |   5 +
 kernel/unwind/sframe.c       | 311 ++++++++++++++++++++++++++++++++++-
 kernel/unwind/sframe_debug.h |  35 ++++
 3 files changed, 347 insertions(+), 4 deletions(-)
 create mode 100644 kernel/unwind/sframe_debug.h

diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index 73bf6f0b30c2..9a72209696f9 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -3,11 +3,14 @@
 #define _LINUX_SFRAME_H
 
 #include <linux/mm_types.h>
+#include <linux/srcu.h>
 #include <linux/unwind_user_types.h>
 
 #ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
 
 struct sframe_section {
+	struct rcu_head	rcu;
+
 	unsigned long	sframe_start;
 	unsigned long	sframe_end;
 	unsigned long	text_start;
@@ -28,6 +31,7 @@ extern void sframe_free_mm(struct mm_struct *mm);
 extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 			      unsigned long text_start, unsigned long text_end);
 extern int sframe_remove_section(unsigned long sframe_addr);
+extern int sframe_find(unsigned long ip, struct unwind_user_frame *frame);
 
 static inline bool current_has_sframe(void)
 {
@@ -46,6 +50,7 @@ static inline int sframe_add_section(unsigned long sframe_start, unsigned long s
 	return -ENOSYS;
 }
 static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
+static inline int sframe_find(unsigned long ip, struct unwind_user_frame *frame) { return -ENOSYS; }
 static inline bool current_has_sframe(void) { return false; }
 
 #endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index fa7d87ffd00a..b10420d19840 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -15,9 +15,303 @@
 #include <linux/unwind_user_types.h>
 
 #include "sframe.h"
+#include "sframe_debug.h"
 
-#define dbg(fmt, ...)							\
-	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+struct sframe_fre {
+	unsigned int	size;
+	u32		ip_off;
+	s32		cfa_off;
+	s32		ra_off;
+	s32		fp_off;
+	u8		info;
+};
+
+DEFINE_STATIC_SRCU(sframe_srcu);
+
+static __always_inline unsigned char fre_type_to_size(unsigned char fre_type)
+{
+	if (fre_type > 2)
+		return 0;
+	return 1 << fre_type;
+}
+
+static __always_inline unsigned char offset_size_enum_to_size(unsigned char off_size)
+{
+	if (off_size > 2)
+		return 0;
+	return 1 << off_size;
+}
+
+static __always_inline int __read_fde(struct sframe_section *sec,
+				      unsigned int fde_num,
+				      struct sframe_fde *fde)
+{
+	unsigned long fde_addr, ip;
+
+	fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde));
+	unsafe_copy_from_user(fde, (void __user *)fde_addr,
+			      sizeof(struct sframe_fde), Efault);
+
+	ip = sec->sframe_start + fde->start_addr;
+	if (ip < sec->text_start || ip > sec->text_end)
+		return -EINVAL;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int __find_fde(struct sframe_section *sec,
+				      unsigned long ip,
+				      struct sframe_fde *fde)
+{
+	s32 ip_off, func_off_low = S32_MIN, func_off_high = S32_MAX;
+	struct sframe_fde __user *first, *low, *high, *found = NULL;
+	int ret;
+
+	ip_off = ip - sec->sframe_start;
+
+	first = (void __user *)sec->fdes_start;
+	low = first;
+	high = first + sec->num_fdes - 1;
+
+	while (low <= high) {
+		struct sframe_fde __user *mid;
+		s32 func_off;
+
+		mid = low + ((high - low) / 2);
+
+		unsafe_get_user(func_off, (s32 __user *)mid, Efault);
+
+		if (ip_off >= func_off) {
+			if (func_off < func_off_low)
+				return -EFAULT;
+
+			func_off_low = func_off;
+
+			found = mid;
+			low = mid + 1;
+		} else {
+			if (func_off > func_off_high)
+				return -EFAULT;
+
+			func_off_high = func_off;
+
+			high = mid - 1;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	ret = __read_fde(sec, found - first, fde);
+	if (ret)
+		return ret;
+
+	/* make sure it's not in a gap */
+	if (ip_off < fde->start_addr || ip_off >= fde->start_addr + fde->func_size)
+		return -EINVAL;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+#define ____UNSAFE_GET_USER_INC(to, from, type, label)			\
+({									\
+	type __to;							\
+	unsafe_get_user(__to, (type __user *)from, label);		\
+	from += sizeof(__to);						\
+	to = __to;							\
+})
+
+#define __UNSAFE_GET_USER_INC(to, from, size, label, u_or_s)		\
+({									\
+	switch (size) {							\
+	case 1:								\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##8, label);	\
+		break;							\
+	case 2:								\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##16, label);	\
+		break;							\
+	case 4:								\
+		____UNSAFE_GET_USER_INC(to, from, u_or_s##32, label);	\
+		break;							\
+	default:							\
+		return -EFAULT;						\
+	}								\
+})
+
+#define UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label)		\
+	__UNSAFE_GET_USER_INC(to, from, size, label, u)
+
+#define UNSAFE_GET_USER_SIGNED_INC(to, from, size, label)		\
+	__UNSAFE_GET_USER_INC(to, from, size, label, s)
+
+#define UNSAFE_GET_USER_INC(to, from, size, label)				\
+	_Generic(to,								\
+		 u8:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 u16:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 u32:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
+		 s8:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
+		 s16:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
+		 s32:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label))
+
+static __always_inline int __read_fre(struct sframe_section *sec,
+				      struct sframe_fde *fde,
+				      unsigned long fre_addr,
+				      struct sframe_fre *fre)
+{
+	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
+	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
+	unsigned char offset_count, offset_size;
+	s32 cfa_off, ra_off, fp_off;
+	unsigned long cur = fre_addr;
+	unsigned char addr_size;
+	u32 ip_off;
+	u8 info;
+
+	addr_size = fre_type_to_size(fre_type);
+	if (!addr_size)
+		return -EFAULT;
+
+	if (fre_addr + addr_size + 1 > sec->fres_end)
+		return -EFAULT;
+
+	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
+	if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size)
+		return -EFAULT;
+
+	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
+	offset_count = SFRAME_FRE_OFFSET_COUNT(info);
+	offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
+	if (!offset_count || !offset_size)
+		return -EFAULT;
+
+	if (cur + (offset_count * offset_size) > sec->fres_end)
+		return -EFAULT;
+
+	fre->size = addr_size + 1 + (offset_count * offset_size);
+
+	UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);
+	offset_count--;
+
+	ra_off = sec->ra_off;
+	if (!ra_off) {
+		if (!offset_count--)
+			return -EFAULT;
+
+		UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
+	}
+
+	fp_off = sec->fp_off;
+	if (!fp_off && offset_count) {
+		offset_count--;
+		UNSAFE_GET_USER_INC(fp_off, cur, offset_size, Efault);
+	}
+
+	if (offset_count)
+		return -EFAULT;
+
+	fre->ip_off		= ip_off;
+	fre->cfa_off		= cfa_off;
+	fre->ra_off		= ra_off;
+	fre->fp_off		= fp_off;
+	fre->info		= info;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int __find_fre(struct sframe_section *sec,
+				      struct sframe_fde *fde, unsigned long ip,
+				      struct unwind_user_frame *frame)
+{
+	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
+	struct sframe_fre *fre, *prev_fre = NULL;
+	struct sframe_fre fres[2];
+	unsigned long fre_addr;
+	bool which = false;
+	unsigned int i;
+	u32 ip_off;
+
+	ip_off = ip - (sec->sframe_start + fde->start_addr);
+
+	if (fde_type == SFRAME_FDE_TYPE_PCMASK)
+		ip_off %= fde->rep_size;
+
+	fre_addr = sec->fres_start + fde->fres_off;
+
+	for (i = 0; i < fde->fres_num; i++) {
+		int ret;
+
+		/*
+		 * Alternate between the two fre_addr[] entries for 'fre' and
+		 * 'prev_fre'.
+		 */
+		fre = which ? fres : fres + 1;
+		which = !which;
+
+		ret = __read_fre(sec, fde, fre_addr, fre);
+		if (ret)
+			return ret;
+
+		fre_addr += fre->size;
+
+		if (prev_fre && fre->ip_off <= prev_fre->ip_off)
+			return -EFAULT;
+
+		if (fre->ip_off > ip_off)
+			break;
+
+		prev_fre = fre;
+	}
+
+	if (!prev_fre)
+		return -EINVAL;
+	fre = prev_fre;
+
+	frame->cfa_off = fre->cfa_off;
+	frame->ra_off  = fre->ra_off;
+	frame->fp_off  = fre->fp_off;
+	frame->use_fp  = SFRAME_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
+
+	return 0;
+}
+
+int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
+{
+	struct mm_struct *mm = current->mm;
+	struct sframe_section *sec;
+	struct sframe_fde fde;
+	int ret;
+
+	if (!mm)
+		return -EINVAL;
+
+	guard(srcu)(&sframe_srcu);
+
+	sec = mtree_load(&mm->sframe_mt, ip);
+	if (!sec)
+		return -EINVAL;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
+
+	ret = __find_fde(sec, ip, &fde);
+	if (ret)
+		goto end;
+
+	ret = __find_fre(sec, &fde, ip, frame);
+end:
+	user_read_access_end();
+	return ret;
+}
 
 static void free_section(struct sframe_section *sec)
 {
@@ -119,8 +413,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 	sec->text_end		= text_end;
 
 	ret = sframe_read_header(sec);
-	if (ret)
+	if (ret) {
+		dbg_print_header(sec);
 		goto err_free;
+	}
 
 	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
 	if (ret) {
@@ -136,6 +432,13 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 	return ret;
 }
 
+static void sframe_free_srcu(struct rcu_head *rcu)
+{
+	struct sframe_section *sec = container_of(rcu, struct sframe_section, rcu);
+
+	free_section(sec);
+}
+
 static int __sframe_remove_section(struct mm_struct *mm,
 				   struct sframe_section *sec)
 {
@@ -144,7 +447,7 @@ static int __sframe_remove_section(struct mm_struct *mm,
 		return -EINVAL;
 	}
 
-	free_section(sec);
+	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
 
 	return 0;
 }
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
new file mode 100644
index 000000000000..055c8c8fae24
--- /dev/null
+++ b/kernel/unwind/sframe_debug.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SFRAME_DEBUG_H
+#define _SFRAME_DEBUG_H
+
+#include <linux/sframe.h>
+#include "sframe.h"
+
+#ifdef CONFIG_DYNAMIC_DEBUG
+
+#define dbg(fmt, ...)							\
+	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+
+static __always_inline void dbg_print_header(struct sframe_section *sec)
+{
+	unsigned long fdes_end;
+
+	fdes_end = sec->fdes_start + (sec->num_fdes * sizeof(struct sframe_fde));
+
+	dbg("SEC: sframe:0x%lx-0x%lx text:0x%lx-0x%lx "
+	    "fdes:0x%lx-0x%lx fres:0x%lx-0x%lx "
+	    "ra_off:%d fp_off:%d\n",
+	    sec->sframe_start, sec->sframe_end, sec->text_start, sec->text_end,
+	    sec->fdes_start, fdes_end, sec->fres_start, sec->fres_end,
+	    sec->ra_off, sec->fp_off);
+}
+
+#else /* !CONFIG_DYNAMIC_DEBUG */
+
+#define dbg(args...)			no_printk(args)
+
+static inline void dbg_print_header(struct sframe_section *sec) {}
+
+#endif /* !CONFIG_DYNAMIC_DEBUG */
+
+#endif /* _SFRAME_DEBUG_H */
-- 
2.47.2




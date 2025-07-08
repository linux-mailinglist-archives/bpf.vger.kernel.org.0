Return-Path: <bpf+bounces-62629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8A9AFC0A1
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93601BC099B
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016AE23534D;
	Tue,  8 Jul 2025 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPA1tQIM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDD22FDE8;
	Tue,  8 Jul 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940720; cv=none; b=rxQvz7okaFDQ0mEZrHuoU3GpyQjbHYFUGtaj50XMdBQzGian7POBewt8CBzdLRkhkhWbegIUy2WVA1q0/MjLoUwDGVaiTD41JEo+HK/a0dXaafAGhkPfmebXduIIY4axyQhcuI7SZlPhZldTMOqhlZU7AW8L17v/z2u050laJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940720; c=relaxed/simple;
	bh=cQU/IOg2dV3IqPOdj6NyIdrtPpR/u8Ehsn+YFDVM0xo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fKKxfSrMr4Zc57P7qgbk3MJiWYnLf6pSZ9msYkPNovBnEgOPdryxB/PxpwPaXAjCCCaFhMQJyRL7dARQOWKdf1gdS1eEmZxOBBhkCvmlgqz2pSqGINYV38xCl/88QLddGSnJATaZ5fxbMXVHWzW5p9zXMNKok7gODai5QkXlTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPA1tQIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6B2C4CEE3;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940720;
	bh=cQU/IOg2dV3IqPOdj6NyIdrtPpR/u8Ehsn+YFDVM0xo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=fPA1tQIMqWWWMvKLXkD89IR5zIbHTYWDwq4rE/Utz13qlxjhuZJOVyDMxCNP2Ofh9
	 +kfd035HAz/KpEbC/gvlo7meJNdQzzHiwZWXoSa+fmvqtvV6joMrBQ2IZH467W94LZ
	 GGl8LjdbntSXY0QNidTBtRQhT8EWfAm+yW18KN17/MRuk/M68H6Q+/CStu7Fri3RH7
	 NfBKPIgH7zZcRIO3vq56hMU9wWzmgsQUVlIqGgN8dByrwNAp41oZFBPD7bQIMNDJL+
	 AG7vLjZO95vqu588voAnQXLEuYeGtx+6N6HkO6+OSSO9eHWPrOqcKRP716KuwUx+tE
	 6Sx+o0dIM61BQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxoO-00000000DfW-0qoe;
	Mon, 07 Jul 2025 22:12:00 -0400
Message-ID: <20250708021200.058879671@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:11:25 -0400
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
Subject: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
References: <20250708021115.894007410@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Objtool warns about calling pr_debug() from uaccess-enabled regions, and
rightfully so.  Add a dbg_sec_uaccess() macro which temporarily disables
uaccess before doing the dynamic printk, and use that to add debug
messages throughout the uaccess-enabled regions.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/sframe.c       | 60 ++++++++++++++++++++++++++++--------
 kernel/unwind/sframe_debug.h | 31 +++++++++++++++++++
 2 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 66d3ba3c8389..3972bce40fc7 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -53,12 +53,15 @@ static __always_inline int __read_fde(struct sframe_section *sec,
 			      sizeof(struct sframe_fde), Efault);
 
 	ip = sec->sframe_start + fde->start_addr;
-	if (ip < sec->text_start || ip > sec->text_end)
+	if (ip < sec->text_start || ip > sec->text_end) {
+		dbg_sec_uaccess("bad fde num %d\n", fde_num);
 		return -EINVAL;
+	}
 
 	return 0;
 
 Efault:
+	dbg_sec_uaccess("fde %d usercopy failed\n", fde_num);
 	return -EFAULT;
 }
 
@@ -85,16 +88,22 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 		unsafe_get_user(func_off, (s32 __user *)mid, Efault);
 
 		if (ip_off >= func_off) {
-			if (func_off < func_off_low)
+			if (func_off < func_off_low) {
+				dbg_sec_uaccess("fde %u not sorted\n",
+						(unsigned int)(mid - first));
 				return -EFAULT;
+			}
 
 			func_off_low = func_off;
 
 			found = mid;
 			low = mid + 1;
 		} else {
-			if (func_off > func_off_high)
+			if (func_off > func_off_high) {
+				dbg_sec_uaccess("fde %u not sorted\n",
+						(unsigned int)(mid - first));
 				return -EFAULT;
+			}
 
 			func_off_high = func_off;
 
@@ -116,6 +125,7 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 	return 0;
 
 Efault:
+	dbg_sec_uaccess("fde usercopy failed\n");
 	return -EFAULT;
 }
 
@@ -140,6 +150,8 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 		____UNSAFE_GET_USER_INC(to, from, u_or_s##32, label);	\
 		break;							\
 	default:							\
+		dbg_sec_uaccess("%d: bad UNSAFE_GET_USER_INC size %u\n",\
+				__LINE__, size);			\
 		return -EFAULT;						\
 	}								\
 })
@@ -174,24 +186,34 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	u8 info;
 
 	addr_size = fre_type_to_size(fre_type);
-	if (!addr_size)
+	if (!addr_size) {
+		dbg_sec_uaccess("bad addr_size in fde info %u\n", fde->info);
 		return -EFAULT;
+	}
 
-	if (fre_addr + addr_size + 1 > sec->fres_end)
+	if (fre_addr + addr_size + 1 > sec->fres_end) {
+		dbg_sec_uaccess("fre addr+info goes past end of subsection\n");
 		return -EFAULT;
+	}
 
 	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
-	if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size)
+	if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size) {
+		dbg_sec_uaccess("fre starts past end of function: ip_off=0x%x, func_size=0x%x\n",
+				ip_off, fde->func_size);
 		return -EFAULT;
+	}
 
 	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
 	offset_count = SFRAME_FRE_OFFSET_COUNT(info);
 	offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
-	if (!offset_count || !offset_size)
+	if (!offset_count || !offset_size) {
+		dbg_sec_uaccess("zero offset_count or size in fre info %u\n",info);
 		return -EFAULT;
-
-	if (cur + (offset_count * offset_size) > sec->fres_end)
+	}
+	if (cur + (offset_count * offset_size) > sec->fres_end) {
+		dbg_sec_uaccess("fre goes past end of subsection\n");
 		return -EFAULT;
+	}
 
 	fre->size = addr_size + 1 + (offset_count * offset_size);
 
@@ -200,8 +222,10 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 
 	ra_off = sec->ra_off;
 	if (!ra_off) {
-		if (!offset_count--)
+		if (!offset_count--) {
+			dbg_sec_uaccess("zero offset_count, can't find ra_off\n");
 			return -EFAULT;
+		}
 
 		UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
 	}
@@ -212,8 +236,10 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 		UNSAFE_GET_USER_INC(fp_off, cur, offset_size, Efault);
 	}
 
-	if (offset_count)
+	if (offset_count) {
+		dbg_sec_uaccess("non-zero offset_count after reading fre\n");
 		return -EFAULT;
+	}
 
 	fre->ip_off		= ip_off;
 	fre->cfa_off		= cfa_off;
@@ -224,6 +250,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	return 0;
 
 Efault:
+	dbg_sec_uaccess("fre usercopy failed\n");
 	return -EFAULT;
 }
 
@@ -257,13 +284,20 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		which = !which;
 
 		ret = __read_fre(sec, fde, fre_addr, fre);
-		if (ret)
+		if (ret) {
+			dbg_sec_uaccess("fde addr 0x%x: __read_fre(%u) failed\n",
+					fde->start_addr, i);
+			dbg_print_fde_uaccess(sec, fde);
 			return ret;
+		}
 
 		fre_addr += fre->size;
 
-		if (prev_fre && fre->ip_off <= prev_fre->ip_off)
+		if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
+			dbg_sec_uaccess("fde addr 0x%x: fre %u not sorted\n",
+					fde->start_addr, i);
 			return -EFAULT;
+		}
 
 		if (fre->ip_off > ip_off)
 			break;
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
index 7794bf0bd78c..045e9c0b16c9 100644
--- a/kernel/unwind/sframe_debug.h
+++ b/kernel/unwind/sframe_debug.h
@@ -13,6 +13,26 @@
 #define dbg_sec(fmt, ...)						\
 	dbg("%s: " fmt, sec->filename, ##__VA_ARGS__)
 
+#define __dbg_sec_descriptor(fmt, ...)					\
+	__dynamic_pr_debug(&descriptor, "sframe: %s: " fmt,		\
+			   sec->filename, ##__VA_ARGS__)
+
+/*
+ * To avoid breaking uaccess rules, temporarily disable uaccess
+ * before calling printk.
+ */
+#define dbg_sec_uaccess(fmt, ...)					\
+({									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {				\
+		user_read_access_end();					\
+		__dbg_sec_descriptor(fmt, ##__VA_ARGS__);		\
+		BUG_ON(!user_read_access_begin(				\
+				(void __user *)sec->sframe_start,	\
+				sec->sframe_end - sec->sframe_start));	\
+	}								\
+})
+
 static __always_inline void dbg_print_header(struct sframe_section *sec)
 {
 	unsigned long fdes_end;
@@ -27,6 +47,15 @@ static __always_inline void dbg_print_header(struct sframe_section *sec)
 		sec->ra_off, sec->fp_off);
 }
 
+static __always_inline void dbg_print_fde_uaccess(struct sframe_section *sec,
+						  struct sframe_fde *fde)
+{
+	dbg_sec_uaccess("FDE: start_addr:0x%x func_size:0x%x "
+			"fres_off:0x%x fres_num:%d info:%u rep_size:%u\n",
+			fde->start_addr, fde->func_size,
+			fde->fres_off, fde->fres_num, fde->info, fde->rep_size);
+}
+
 static inline void dbg_init(struct sframe_section *sec)
 {
 	struct mm_struct *mm = current->mm;
@@ -57,8 +86,10 @@ static inline void dbg_free(struct sframe_section *sec)
 
 #define dbg(args...)			no_printk(args)
 #define dbg_sec(args...	)		no_printk(args)
+#define dbg_sec_uaccess(args...)	no_printk(args)
 
 static inline void dbg_print_header(struct sframe_section *sec) {}
+static inline void dbg_print_fde_uaccess(struct sframe_section *sec, struct sframe_fde *fde) {}
 
 static inline void dbg_init(struct sframe_section *sec) {}
 static inline void dbg_free(struct sframe_section *sec) {}
-- 
2.47.2




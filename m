Return-Path: <bpf+bounces-53057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E1A4C1F8
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7FB3AD95D
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4D211A10;
	Mon,  3 Mar 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfMOQrl/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E01212B2B;
	Mon,  3 Mar 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008647; cv=none; b=T97vw6JuAocKkwWXmuWXIyxaTgMz1sLz140V7zIovaniFlU791JgSJuDkRs1tGkgSSx69OGVCjV5T6PpNANvmoqCv8lqRZXdQqWCh+eHQwJkjsctzlGDOXwigxVRLiArffyT+CV6RucO4FSRvSnoNz+br2cZ4vzOLt4KjuoXKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008647; c=relaxed/simple;
	bh=/mOskEeuSOoI6Ik4GZTrnIyvVE91D9OQfL2ePFfqnyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5zAkd5twkwqi+gpWK25a63kJbrbq1XDUp/qJV0rzcdFA1kmXX+wZmeyovdJoInYDyJX06JFrTvraqUclai4tIaczBaTPAKce1kRIzLH8mmd4j9o47ANiq95bACV1guHluiLU0o1Df19E+9MHzNVzQYDL7ssmX6J+MlsFhuLOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfMOQrl/; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2233622fdffso84011485ad.2;
        Mon, 03 Mar 2025 05:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741008645; x=1741613445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+TPvgOYa0/i6hWJUb51m5UVXTU1tbJahC/+FJNQh8Y=;
        b=dfMOQrl/JvemPuk2oWyYMQvAKpK6dxpNu5BRSFqcV7fdVglYdgD4GGZ4bxFc6O849v
         y8dWrzb+FbOj4RQS2VJnr4LGBESOQPkffmOnXwsGMtgL6c6VWVppPi/VXW/2wxn30vbC
         Y0zdQ63fRE1GeURAk627IP6C2euWM7qz5SM3A6pjRvNLpilnEztoVrUkkE8YWJfA4Pln
         whS5Qmn9OMv+aXJlfAIMXefKIXi7Qty4XYLjmI+RjCUjeInLWspTNGe/0Zj9Ik9hayLW
         /2vyrYiYoVnt6mGBJ9r44SGpidhwbO7jnuXCrMJCC1y0tQBJC6YmiZfaUlytQAjSY4nV
         Z9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008645; x=1741613445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+TPvgOYa0/i6hWJUb51m5UVXTU1tbJahC/+FJNQh8Y=;
        b=od82cK8P9gaHJjUl42iQ5rUPRXJ+Ms+o6d5FLrNIRD2DhJ1FLNmFIqLvMPYeXWZt8S
         vHcEg6FOkFA9xii9SzJrK+mxlLOEMkroPaKedJWvzsBFDryZIoOgtb7foaRzkDz5uUEk
         iEPvO5hKSKmllQxQoINXW6l5Xko1r2+kfp3AouxCD1A4DqM0dUP1/gzh7HHJ21KbMxqm
         lcGSpJ33qu9ASCrc6JBjx8RA2oLzIaCBXgxkjRK/vEdK6EKUOC8+wS01IhVQoMz7ee1y
         erZvtcqBE1TA5wppXhg0ywvBKAsjMYCLU5Iq5RfAH+6Z3DkCjr1f+IHhUu88kzvdrfFu
         WMYA==
X-Forwarded-Encrypted: i=1; AJvYcCU0xds5uT6/9WAuUCDgtGCGFB7JlEyr4b+ONVV9D5jcQGClbyXcERDnhWNz6Gc7Ef6+GVua2wFc@vger.kernel.org, AJvYcCVgZhcwvFs2GUtKBnZW9xeZkqnzdiISWPKg1R4vpr6GMCNGbKDQQ+6AfAvolY13GEAuV8g3sAfeNobWWRYX@vger.kernel.org, AJvYcCXdh1UQgHqeE9WtcR2E4BYnelLfH0xRBpuli8RVRZ78msuveSCW/i74A7UZOcfeSP9KfLg=@vger.kernel.org, AJvYcCXkcPeIGo/Gd+uMm6VvmvcCp9lG3IhjvuZGX58u4DfyuAEkguUv7vHSnvniPCeYsPpBUrEEg3zeT5mSMXWI4Nh8Ajgq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ffyq/1r3zJxzoJv5RQNIj3v17M3RVd7nPxenXpRp3q+3CO9u
	hPPikIK3bMur2msbpaDzKDE4gxHefL4lmOqdJTwWmyiL7i7m/OqK
X-Gm-Gg: ASbGncvK/0xw3urFQSjAp/o5K9+/dWh2/2vZe0NlI84T6dJBH1amI6uQt4H6DwlJI7I
	AUt3QiV7t4N9I63u/E+uLj6uyw1HBT0oq4wtfjJazm0+eBgBVQmexks+XdJYnolHQEr6erySTNk
	yDwxSVluGAmTFYsEgt2w4IrRao8prfDCt71OP/rtE4xUqODJcB7XrGOOKpMMQyZEIljgidLfvwV
	sbIcMYEha0wsIRTa9AyMbXCHf5OGOR7xpJN38VbiVLlYBZMc/PFNMJquglBqEHfC3HLvOrqnxV9
	mM57q7YkwZTo/fWiE2gsTKrxxb6Sx9GOfYKL3ABYAa2e+LdGp+exxBWrkR3Nbw==
X-Google-Smtp-Source: AGHT+IFlbT3UDNEQKtNvTWGWrAZWwF7WOjWCx8Sdq18QPhAIVe0wmrIF4oYZBBWwy52qUNo/JhCf0Q==
X-Received: by 2002:a17:903:1790:b0:21f:71b4:d2aa with SMTP id d9443c01a7336-22368fa54b4mr247215185ad.5.1741008644544;
        Mon, 03 Mar 2025 05:30:44 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505359b8sm77297035ad.253.2025.03.03.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:30:44 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	rostedt@goodmis.org,
	mark.rutland@arm.com,
	alexei.starovoitov@gmail.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mhiramat@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	mathieu.desnoyers@efficios.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	samitolvanen@google.com,
	kees@kernel.org,
	dongml2@chinatelecom.cn,
	akpm@linux-foundation.org,
	riel@surriel.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 2/4] add per-function metadata storage support
Date: Mon,  3 Mar 2025 21:28:35 +0800
Message-Id: <20250303132837.498938-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303132837.498938-1-dongml2@chinatelecom.cn>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, there isn't a way to set and get per-function metadata with
a low overhead, which is not convenient for some situations. Take
BPF trampoline for example, we need to create a trampoline for each
kernel function, as we have to store some information of the function
to the trampoline, such as BPF progs, function arg count, etc. The
performance overhead and memory consumption can be higher to create
these trampolines. With the supporting of per-function metadata storage,
we can store these information to the metadata, and create a global BPF
trampoline for all the kernel functions. In the global trampoline, we
get the information that we need from the function metadata through the
ip (function address) with almost no overhead.

Another beneficiary can be ftrace. For now, all the kernel functions that
are enabled by dynamic ftrace will be added to a filter hash if there are
more than one callbacks. And hash lookup will happen when the traced
functions are called, which has an impact on the performance, see
__ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function
metadata supporting, we can store the information that if the callback is
enabled on the kernel function to the metadata.

Support per-function metadata storage in the function padding, and
previous discussion can be found in [1]. Generally speaking, we have two
way to implement this feature:

1. Create a function metadata array, and prepend a insn which can hold
the index of the function metadata in the array. And store the insn to
the function padding.

2. Allocate the function metadata with kmalloc(), and prepend a insn which
hold the pointer of the metadata. And store the insn to the function
padding.

Compared with way 2, way 1 consume less space, but we need to do more work
on the global function metadata array. And we implement this function in
the way 1.

Link: https://lore.kernel.org/bpf/CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com/ [1]
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- add supporting for arm64
- split out arch relevant code
- refactor the commit log
---
 include/linux/kfunc_md.h |  25 ++++
 kernel/Makefile          |   1 +
 kernel/trace/Makefile    |   1 +
 kernel/trace/kfunc_md.c  | 239 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 include/linux/kfunc_md.h
 create mode 100644 kernel/trace/kfunc_md.c

diff --git a/include/linux/kfunc_md.h b/include/linux/kfunc_md.h
new file mode 100644
index 000000000000..df616f0fcb36
--- /dev/null
+++ b/include/linux/kfunc_md.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KFUNC_MD_H
+#define _LINUX_KFUNC_MD_H
+
+#include <linux/kernel.h>
+
+struct kfunc_md {
+	int users;
+	/* we can use this field later, make sure it is 8-bytes aligned
+	 * for now.
+	 */
+	int pad0;
+	void *func;
+};
+
+extern struct kfunc_md *kfunc_mds;
+
+struct kfunc_md *kfunc_md_find(void *ip);
+struct kfunc_md *kfunc_md_get(void *ip);
+void kfunc_md_put(struct kfunc_md *meta);
+void kfunc_md_put_by_ip(void *ip);
+void kfunc_md_lock(void);
+void kfunc_md_unlock(void);
+
+#endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..7435674d5da3 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_TRACE_CLOCK) += trace/
 obj-$(CONFIG_RING_BUFFER) += trace/
 obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_RETHOOK) += trace/
+obj-$(CONFIG_FUNCTION_METADATA) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..9780ee3f8d8d 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
 obj-$(CONFIG_FPROBE) += fprobe.o
 obj-$(CONFIG_RETHOOK) += rethook.o
 obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
+obj-$(CONFIG_FUNCTION_METADATA) += kfunc_md.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 obj-$(CONFIG_RV) += rv/
diff --git a/kernel/trace/kfunc_md.c b/kernel/trace/kfunc_md.c
new file mode 100644
index 000000000000..7ec25bcf778d
--- /dev/null
+++ b/kernel/trace/kfunc_md.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/slab.h>
+#include <linux/memory.h>
+#include <linux/rcupdate.h>
+#include <linux/ftrace.h>
+#include <linux/kfunc_md.h>
+
+#define ENTRIES_PER_PAGE (PAGE_SIZE / sizeof(struct kfunc_md))
+
+static u32 kfunc_md_count = ENTRIES_PER_PAGE, kfunc_md_used;
+struct kfunc_md __rcu *kfunc_mds;
+EXPORT_SYMBOL_GPL(kfunc_mds);
+
+static DEFINE_MUTEX(kfunc_md_mutex);
+
+
+void kfunc_md_unlock(void)
+{
+	mutex_unlock(&kfunc_md_mutex);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_unlock);
+
+void kfunc_md_lock(void)
+{
+	mutex_lock(&kfunc_md_mutex);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_lock);
+
+static u32 kfunc_md_get_index(void *ip)
+{
+	return *(u32 *)(ip - KFUNC_MD_DATA_OFFSET);
+}
+
+static void kfunc_md_init(struct kfunc_md *mds, u32 start, u32 end)
+{
+	u32 i;
+
+	for (i = start; i < end; i++)
+		mds[i].users = 0;
+}
+
+static int kfunc_md_page_order(void)
+{
+	return fls(DIV_ROUND_UP(kfunc_md_count, ENTRIES_PER_PAGE)) - 1;
+}
+
+/* Get next usable function metadata. On success, return the usable
+ * kfunc_md and store the index of it to *index. If no usable kfunc_md is
+ * found in kfunc_mds, a larger array will be allocated.
+ */
+static struct kfunc_md *kfunc_md_get_next(u32 *index)
+{
+	struct kfunc_md *new_mds, *mds;
+	u32 i, order;
+
+	mds = rcu_dereference(kfunc_mds);
+	if (mds == NULL) {
+		order = kfunc_md_page_order();
+		new_mds = (void *)__get_free_pages(GFP_KERNEL, order);
+		if (!new_mds)
+			return NULL;
+		kfunc_md_init(new_mds, 0, kfunc_md_count);
+		/* The first time to initialize kfunc_mds, so it is not
+		 * used anywhere yet, and we can update it directly.
+		 */
+		rcu_assign_pointer(kfunc_mds, new_mds);
+		mds = new_mds;
+	}
+
+	if (likely(kfunc_md_used < kfunc_md_count)) {
+		/* maybe we can manage the used function metadata entry
+		 * with a bit map ?
+		 */
+		for (i = 0; i < kfunc_md_count; i++) {
+			if (!mds[i].users) {
+				kfunc_md_used++;
+				*index = i;
+				mds[i].users++;
+				return mds + i;
+			}
+		}
+	}
+
+	order = kfunc_md_page_order();
+	/* no available function metadata, so allocate a bigger function
+	 * metadata array.
+	 */
+	new_mds = (void *)__get_free_pages(GFP_KERNEL, order + 1);
+	if (!new_mds)
+		return NULL;
+
+	memcpy(new_mds, mds, kfunc_md_count * sizeof(*new_mds));
+	kfunc_md_init(new_mds, kfunc_md_count, kfunc_md_count * 2);
+
+	rcu_assign_pointer(kfunc_mds, new_mds);
+	synchronize_rcu();
+	free_pages((u64)mds, order);
+
+	mds = new_mds + kfunc_md_count;
+	*index = kfunc_md_count;
+	kfunc_md_count <<= 1;
+	kfunc_md_used++;
+	mds->users++;
+
+	return mds;
+}
+
+static int kfunc_md_text_poke(void *ip, void *insn, void *nop)
+{
+	void *target;
+	int ret = 0;
+	u8 *prog;
+
+	target = ip - KFUNC_MD_INSN_OFFSET;
+	mutex_lock(&text_mutex);
+	if (insn) {
+		if (!memcmp(target, insn, KFUNC_MD_INSN_SIZE))
+			goto out;
+
+		if (memcmp(target, nop, KFUNC_MD_INSN_SIZE)) {
+			ret = -EBUSY;
+			goto out;
+		}
+		prog = insn;
+	} else {
+		if (!memcmp(target, nop, KFUNC_MD_INSN_SIZE))
+			goto out;
+		prog = nop;
+	}
+
+	ret = kfunc_md_arch_poke(target, prog);
+out:
+	mutex_unlock(&text_mutex);
+	return ret;
+}
+
+static bool __kfunc_md_put(struct kfunc_md *md)
+{
+	u8 nop_insn[KFUNC_MD_INSN_SIZE];
+
+	if (WARN_ON_ONCE(md->users <= 0))
+		return false;
+
+	md->users--;
+	if (md->users > 0)
+		return false;
+
+	if (!kfunc_md_arch_exist(md->func))
+		return false;
+
+	kfunc_md_arch_nops(nop_insn);
+	/* release the metadata by recovering the function padding to NOPS */
+	kfunc_md_text_poke(md->func, NULL, nop_insn);
+	/* TODO: we need a way to shrink the array "kfunc_mds" */
+	kfunc_md_used--;
+
+	return true;
+}
+
+/* Decrease the reference of the md, release it if "md->users <= 0" */
+void kfunc_md_put(struct kfunc_md *md)
+{
+	mutex_lock(&kfunc_md_mutex);
+	__kfunc_md_put(md);
+	mutex_unlock(&kfunc_md_mutex);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_put);
+
+/* Get a exist metadata by the function address, and NULL will be returned
+ * if not exist.
+ *
+ * NOTE: rcu lock should be held during reading the metadata, and
+ * kfunc_md_lock should be held if writing happens.
+ */
+struct kfunc_md *kfunc_md_find(void *ip)
+{
+	struct kfunc_md *md;
+	u32 index;
+
+	if (kfunc_md_arch_exist(ip)) {
+		index = kfunc_md_get_index(ip);
+		if (WARN_ON_ONCE(index >= kfunc_md_count))
+			return NULL;
+
+		md = rcu_dereference(kfunc_mds) + index;
+		return md;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kfunc_md_find);
+
+void kfunc_md_put_by_ip(void *ip)
+{
+	struct kfunc_md *md;
+
+	mutex_lock(&kfunc_md_mutex);
+	md = kfunc_md_find(ip);
+	if (md)
+		__kfunc_md_put(md);
+	mutex_unlock(&kfunc_md_mutex);
+}
+EXPORT_SYMBOL_GPL(kfunc_md_put_by_ip);
+
+/* Get a exist metadata by the function address, and create one if not
+ * exist. Reference of the metadata will increase 1.
+ *
+ * NOTE: always call this function with kfunc_md_lock held, and all
+ * updating to metadata should also hold the kfunc_md_lock.
+ */
+struct kfunc_md *kfunc_md_get(void *ip)
+{
+	u8 nop_insn[KFUNC_MD_INSN_SIZE], insn[KFUNC_MD_INSN_SIZE];
+	struct kfunc_md *md;
+	u32 index;
+
+	md = kfunc_md_find(ip);
+	if (md) {
+		md->users++;
+		return md;
+	}
+
+	md = kfunc_md_get_next(&index);
+	if (!md)
+		return NULL;
+
+	kfunc_md_arch_pretend(insn, index);
+	kfunc_md_arch_nops(nop_insn);
+
+	if (kfunc_md_text_poke(ip, insn, nop_insn)) {
+		kfunc_md_used--;
+		md->users = 0;
+		return NULL;
+	}
+	md->func = ip;
+
+	return md;
+}
+EXPORT_SYMBOL_GPL(kfunc_md_get);
-- 
2.39.5



Return-Path: <bpf+bounces-1496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A13717A9A
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 10:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8171F1C20E2C
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A2BE6E;
	Wed, 31 May 2023 08:48:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A4BE64
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 08:48:30 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A341B4
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 01:48:26 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230531084824epoutp02c37c0a1d3681b572d35bd5185e2297e2~kLibRjvMA2443424434epoutp02R
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 08:48:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230531084824epoutp02c37c0a1d3681b572d35bd5185e2297e2~kLibRjvMA2443424434epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685522904;
	bh=s0725QwcTW3BEZD38ZtJrSmnGOHUK1uQ30n4RkrditY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ObX9n//kiXZT985nYnGdIh0Xuw+OKOZH/Ft8FM6LPAFnWd71KuD7jN4Qq+kuVSnp0
	 ZACNtL1tacjZRlMagKFhPPx+HwQbkqUzIrBf1OX3vIXtIYelhcYlNFoOhRmKkmMf81
	 urv2bgh6o1Mh+rf24HaC8aD22kcxOVHWxs2XjnMc=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230531084824epcas5p4e332b734c30995d8cf0ce80497257a50~kLiam8fGy2502925029epcas5p4f;
	Wed, 31 May 2023 08:48:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.B4.16380.7D907746; Wed, 31 May 2023 17:48:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230531084808epcas5p4a782bf6bb5655f2d320c246057e7bb63~kLiLrvqHG2996829968epcas5p4Y;
	Wed, 31 May 2023 08:48:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230531084808epsmtrp2b0aabe5ad0888f954b4264a9bba6a819~kLiLqZRrJ1909719097epsmtrp2W;
	Wed, 31 May 2023 08:48:08 +0000 (GMT)
X-AuditID: b6c32a4b-56fff70000013ffc-9f-647709d7a89e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.47.28392.7C907746; Wed, 31 May 2023 17:48:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230531084802epsmtip1f97dd27b6b24d3ca7e1a9da5b235d9a1~kLiG9Q-0z2391523915epsmtip1V;
	Wed, 31 May 2023 08:48:02 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	thunder.leizhen@huawei.com, mcgrof@kernel.org, boqun.feng@gmail.com,
	vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
	brauner@kernel.org, michael.christie@oracle.com, samitolvanen@google.com,
	glider@google.com, peterz@infradead.org, keescook@chromium.org,
	stephen.s.brennan@oracle.com, alan.maguire@oracle.com, pmladek@suse.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Maninder Singh
	<maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH v2 2/2] kallsyms: add kallsyms_show_value defination in all
 cases
Date: Wed, 31 May 2023 14:17:45 +0530
Message-Id: <20230531084745.877337-2-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531084745.877337-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0ybVRjGd75L+7Wx8lkIOwNlBkcWLnZzzuWosC1G3ZeIMsE/jMucDf0G
	Q262IAMXLaPOjAmDARuUhnGbBYQxoExWuUhprCugGyop041b2RQC0pbZ0gFz5Stx/z3veX/v
	eZ735FC4uIUXQB1LzWDlqdLkYJ6QuDoQGvq8RZAl2+ncgyyGXAI5H1TiaGn5Dz5q1uViyGE0
	8dDcgB2gupp/cfSVrQdHBlMfH2nGdqGTXQ0YMpaqcTR0JgXd6y3A0K96DQ8NXDxFoObTjSSy
	FM0AtHrOQqLGi1qAGr5eJJGp4AcMPZy+T6JLDfMkGnHNEcikXeWhVWM/hqxuOw8VDseiv+rL
	wf4gplJ5k2CK8xb4zDX1bT5T3Z7JqIzzJNPREMbkW0Zwpr3pNI+pUZbhjG3mFsEU6poA06r7
	nWAc7UEHRR8II2Vs8rFPWfmOvR8JE6u67oF0bcTx2cFOXAmU2/KBgIL0bji52MPLB0JKTH8P
	YEX+JZwr7AB+c7bF23EAWDJyF2yM9JiHvZQewOW1K15qCcDpWSPpoXi0BDbpuwlPw4/uIuCN
	tgnMU+D0KQArq/oJD+VLx8HJhQuYRxN0COysU697iOgoWDe0hnF+W2HFiJPv0QJ6L2x1LuMc
	8xS8XmFdvwd/xOR1Vq5ngrRZAEcsbpIbfh2W/TxDcNoXzpp0fE4HQMeCZ2/qkc6CnUVfcLMq
	APs0pTyO2QetN2tID4PTobBVv4M7fgaWmS9jnO+TsOCB1ZtTBLuqNnQIVI1d8UYIhA6bzRuB
	gYNXtRj3XMUA/j1bSBSBZ9WP7aN+bB/1/9bVAG8CW9h0RUoCq3gp/cVUNkuikKYoMlMTJPFp
	Ke1g/UeHvdUFpiYWJQaAUcAAIIUH+4mipAqZWCSTZuew8rQj8sxkVmEAgRQRvFm0Pep6vJhO
	kGawH7NsOivf6GKUIECJRczMOd/9fPzPFlfbT/fPTIRjk36bT0Qo95e/EldaOLX98OHI7Azq
	pJwaJ3zePn9WvyJ5gsRai92frJQHmg/8M2g/sM/kU7g2xr4RM2qW5fTqRj8M9a+9fPTC1C8T
	3/WpWku6b5Tzu2PoNqlMsTAY92VH3JzqdvJ741X1uelH1xIEm6xD789TpP/umDlnTpzjhP8t
	v6LG0elESpx9t6S2f/hQ8bXhnoe9rrQA66vtkqTXyKFd3/KDwk2YmfQt/nEswiyruJPms6nZ
	HW1btddu0Rx57tCbSSu/1SdpQzpSXfGxiZ+dj3Lu4UcvhYTnHX+nWhPt3qkyGKvu+MRGIpdw
	69MvBxOKROkLYbhcIf0PtHXPFUAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSnO5xzvIUg+6PFhY3DjWyWHz/PZvZ
	4svP2+wWa7Y0Mll8PnKczeL14U+MFosXfmO2aP+4l9ni0PH97BZzbhpZNO1YwWRxZMosZosz
	3bkWz/f1Mllc3jWHzeLw/DYWizWdK1ktbkx4ymjxd9INVouV85czWqzo+cBqcbz3AJPF/8df
	WS2WrnjLanHpx2sWi+PL/7JZ/D1ykMniya9PbBZ9Z4MsXiyZwegg5zG74SKLx8Tmd+weO2fd
	ZfdYsKnUo+XIW1aPzSu0PLpuXGL22LSqk81jYcNUZo+PT2+xePRtWcXosX7LVRaPz5vkAnij
	uGxSUnMyy1KL9O0SuDLm7XjOWLBcp+LV6a3MDYwNKl2MnBwSAiYSe0+dZe5i5OIQEtjBKHFz
	aQMLREJa4ue/91C2sMTKf8/ZIYo+MUpse7WWCSTBJqAnsWrXHhaQhIjAHRaJfS83glUxC3Qx
	Sjx8toYdpEpYIFDiUN8VsFEsAqoSWxfPYgSxeQVsJRaf+ccEsUJeYual72D1nAJ2Euu//2QG
	sYWAaiasOcMOUS8ocXLmE7A5zED1zVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRy
	veLE3OLSvHS95PzcTYzgNKCltYNxz6oPeocYmTgYDzFKcDArifDaJhanCPGmJFZWpRblxxeV
	5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDEKFT0Y86W+wl/5fNkNkeFzzBz
	3ap5TOXXwSu5TXlLD+38zeL0yue0lINhoN6zlAMVMddfN9hvneC9jlP4F+eTm4uvP5mVkXwi
	cc3CyPaJT53799XF/mVjOfdjg2m/5NmPpuGOM5LDP4redL6/qT0pVeOa1D+fpy9bqwVzF3IL
	P0l6uvBi+sbZZ2PnzHz/R+jDZFGtFROXrVxas/PNemeJrj3ftgvx/Mh3bShTYpTKWhf1p0Iy
	oO3lIi+19LTcY0uFWR7oPN6x8d0ux+KJbG+0HhmpBWy5HOt3UblBaTnf0dzwvtUbc1Z9ZjfI
	kcxSyZRUyFf3kFwmftP06ZJWjS3rtp9l+tf6MuP7jiNlNtXsSizFGYmGWsxFxYkAVddDy3ID
	AAA=
X-CMS-MailID: 20230531084808epcas5p4a782bf6bb5655f2d320c246057e7bb63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230531084808epcas5p4a782bf6bb5655f2d320c246057e7bb63
References: <20230531084745.877337-1-maninder1.s@samsung.com>
	<CGME20230531084808epcas5p4a782bf6bb5655f2d320c246057e7bb63@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kallsyms_show_value return false if KALLSYMS is disabled,
but it is getting used in module.c also for fetching module address.

Thus when KALLSYMS is disabled, system will not print module
load address:

Earlier:
=======
/ # insmod  test.ko
/ # lsmod
test 12288 0 - Live 0x0000000000000000 (O)  // No Module Load address
/ #

With change:
==========
/ # insmod test.ko
/ # lsmod
test 12288 0 - Live 0xffff800000fc0000 (O)  // Module address
/ # cat /proc/modules
test 12288 0 - Live 0xffff800000fc0000 (O)

New file knosyms.c is added (name suggested by Kees Cook),
which includes common defination irrespective of CONFIG_KALLSYMS.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
earlier conversations:(then it has dependancy on other change, but that
was stashed from linux-next, now it can be pushed)
https://lkml.org/lkml/2022/5/11/212
https://lkml.org/lkml/2022/4/13/47

 include/linux/kallsyms.h | 10 +++-----
 kernel/Makefile          |  2 +-
 kernel/kallsyms.c        | 35 ---------------------------
 kernel/knosyms.c         | 52 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 43 deletions(-)
 create mode 100644 kernel/knosyms.c

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index fe3c9993b5bf..3f3559ba0c56 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -24,6 +24,9 @@
 struct cred;
 struct module;
 
+/* How and when do we show kallsyms values? */
+extern bool kallsyms_show_value(const struct cred *cred);
+
 static inline int is_kernel_text(unsigned long addr)
 {
 	if (__is_kernel_text(addr))
@@ -95,8 +98,6 @@ extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
 int lookup_symbol_name(unsigned long addr, char *symname);
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
-/* How and when do we show kallsyms values? */
-extern bool kallsyms_show_value(const struct cred *cred);
 
 #else /* !CONFIG_KALLSYMS */
 
@@ -160,11 +161,6 @@ static inline int lookup_symbol_attrs(unsigned long addr, unsigned long *size, u
 	return -ERANGE;
 }
 
-static inline bool kallsyms_show_value(const struct cred *cred)
-{
-	return false;
-}
-
 static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
 					  void *data)
 {
diff --git a/kernel/Makefile b/kernel/Makefile
index b69c95315480..76efc634b1a4 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o regset.o
+	    async.o range.o smpboot.o ucount.o regset.o knosyms.o
 
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MULTIUSER) += groups.o
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 77747391f49b..1dcb7051f852 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -961,41 +961,6 @@ late_initcall(bpf_ksym_iter_register);
 
 #endif /* CONFIG_BPF_SYSCALL */
 
-static inline int kallsyms_for_perf(void)
-{
-#ifdef CONFIG_PERF_EVENTS
-	extern int sysctl_perf_event_paranoid;
-	if (sysctl_perf_event_paranoid <= 1)
-		return 1;
-#endif
-	return 0;
-}
-
-/*
- * We show kallsyms information even to normal users if we've enabled
- * kernel profiling and are explicitly not paranoid (so kptr_restrict
- * is clear, and sysctl_perf_event_paranoid isn't set).
- *
- * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
- * block even that).
- */
-bool kallsyms_show_value(const struct cred *cred)
-{
-	switch (kptr_restrict) {
-	case 0:
-		if (kallsyms_for_perf())
-			return true;
-		fallthrough;
-	case 1:
-		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
-				     CAP_OPT_NOAUDIT) == 0)
-			return true;
-		fallthrough;
-	default:
-		return false;
-	}
-}
-
 static int kallsyms_open(struct inode *inode, struct file *file)
 {
 	/*
diff --git a/kernel/knosyms.c b/kernel/knosyms.c
new file mode 100644
index 000000000000..f2c8755e22e7
--- /dev/null
+++ b/kernel/knosyms.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Samsung Electronics Co., Ltd
+ *
+ * Author:
+ *	Maninder singh <maninder1.s@samsung.com>
+ *	Onkarnath <onkarnath.1@samsung.com>
+ *
+ * A split of kernel/kallsyms.c
+ * to contain few generic function definations independent of config KALLSYMS
+ * or defined under KALLSYMS disabled.
+ */
+
+#include <linux/kallsyms.h>
+#include <linux/security.h>
+
+static inline int kallsyms_for_perf(void)
+{
+#ifdef CONFIG_PERF_EVENTS
+	extern int sysctl_perf_event_paranoid;
+
+	if (sysctl_perf_event_paranoid <= 1)
+		return 1;
+#endif
+	return 0;
+}
+
+/*
+ * We show kallsyms information even to normal users if we've enabled
+ * kernel profiling and are explicitly not paranoid (so kptr_restrict
+ * is clear, and sysctl_perf_event_paranoid isn't set).
+ *
+ * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
+ * block even that).
+ */
+bool kallsyms_show_value(const struct cred *cred)
+{
+	switch (kptr_restrict) {
+	case 0:
+		if (kallsyms_for_perf())
+			return true;
+		fallthrough;
+	case 1:
+		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
+				     CAP_OPT_NOAUDIT) == 0)
+			return true;
+		fallthrough;
+	default:
+		return false;
+	}
+}
+
-- 
2.17.1



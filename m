Return-Path: <bpf+bounces-1485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB77E717575
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 06:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737B81C20C83
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 04:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39446AF;
	Wed, 31 May 2023 04:26:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041401878
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:26:32 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA2CE51
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 21:26:26 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230531042621epoutp01b1811a590c9f2f534cd2710210f3a678~kH9oFGDtG0790107901epoutp01j
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:26:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230531042621epoutp01b1811a590c9f2f534cd2710210f3a678~kH9oFGDtG0790107901epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685507181;
	bh=OZ8baXbiD2DQiCP83WG7ZVsAQdACJUJlH8qE/8dAJNI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZW4iQXLQ855HGV3ry99o3M3ouLx/cYGRUxk+y2aX+V4CqkwHjVOGigkjjg1tMs81w
	 t+ryr9zIYPdPBwgDYGbtBTQboNHf1xq6Kcxvz4ZvnLSltL/n8W3K4SSvMTuQCfF2ID
	 PFbalsm8U4zqUImVvjOTCeHVZAzugEZ8uwhQjmFs=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230531042620epcas5p1df446ac3b1303fe6bcce85f7954a7983~kH9nUx5uY0888008880epcas5p1I;
	Wed, 31 May 2023 04:26:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AA.F9.16380.C6CC6746; Wed, 31 May 2023 13:26:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230531042611epcas5p1f46c41ccec93ce04eef4fe861242ac19~kH9e9WSR30888008880epcas5p14;
	Wed, 31 May 2023 04:26:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230531042611epsmtrp2f01afbe4e2aeb8d029b6c2c21d40b3b1~kH9e7VPzD2656226562epsmtrp23;
	Wed, 31 May 2023 04:26:11 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-3e-6476cc6ca8ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.8C.27706.36CC6746; Wed, 31 May 2023 13:26:11 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230531042606epsmtip16392bc90e1383d1cf2927c40e309087d~kH9aTADQG2970229702epsmtip1N;
	Wed, 31 May 2023 04:26:06 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	thunder.leizhen@huawei.com, mcgrof@kernel.org, boqun.feng@gmail.com,
	vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
	brauner@kernel.org, michael.christie@oracle.com, samitolvanen@google.com,
	glider@google.com, peterz@infradead.org, keescook@chromium.org,
	stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Maninder Singh
	<maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH 1/1] kallsyms: add kallsyms_show_value defination in all
 cases
Date: Wed, 31 May 2023 09:56:00 +0530
Message-Id: <20230531042600.819453-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+69vbft0uVa2Tjg1IzND2pWdag5cYKOMLlm2ebG3BwOtbY3
	oKPQtBTGkgUYxEmhUBXZaJFCQAqNga0rikwESrNWImSgsjInY65E4gejraN2HcnW3pn53+88
	7/Oe531PDh8Xf0XG84/mFbDqPFluAikkLgwnrn8l91qhYpP7VhLyOMoIFAybcPQodItC5+1l
	GAo4XSS6P+wHqLVlEUdf+vpx5HANUKhx6lX0RW8Hhpx1Rhxdq1Kiu1f0GLre10iiYfNxAp2v
	7OQhj2EWoKVTHh7qNFsA6qhe4CGXfhBD5zoe8tDE4/sEclmWSLTkHMKQ9y8/iWpG30NzbV+D
	XSsZU+k4wZwsn6eYS8bbFNNs0zIVzoc85rsOCaPzTOCMzVpJMi2lZ3DGN/szwdTYrYDptt8k
	mIBt1V5RpnCHgs09WsiqN6YcFub0+Kt5qsktn4baG8hSEJTogIAP6S0wONRI6YCQL6a/B7Bx
	bhrnDn4A3d4ZEHGJ6UUAHzfn6wA/2lHftZnz9AN4bszH4zyPALS790WYpKXQ2neZiHAM3U7A
	mZ/2Rxpw+jiApqahaGE5vReax4bwCBP0Gjh+dzJ6kYhOhm6PDnDjrYYNE0GK05fBqw3eaC/+
	r17eY8I5j0UADZUHOU6D3aFqHsfL4T2XneI4Hgbm+0lugSLYYyiJzAPpCgAHGutIzrMTesdb
	eBEPTifC7r6NnLwSnhnpwrjYZ6E+7MU4XQR7m57wGlgx9c1/sStgwOcjOGag/uIozr1PFuya
	GaEMYLXxqW2MT21j/D+5GeBWEMeqNMpsVrNVlZTHFkk1MqVGm5ctlecrbSD6dyVv9oI7MwtS
	B8D4wAEgH0+IESXLNAqxSCEr/oxV5x9Sa3NZjQOs4BMJsaJ1yVflYjpbVsB+wrIqVv2kivEF
	8aVY88npwQ2flxQltYYWX5jHl8brj02nWN5/4G8/sk1ffuPKwlxt1UGtfNXsbpfc1XDHLBas
	Z5d5+tNFjnfTDqSkyD/edbsVUw5KRRlFPwxsyrtx7Mi+WOV8as2hjwRec+D6rxcyTu/4jdqq
	aErdPvXnL4YCX2Jhke2tdNXrH6LU+uys3RKtUNt6kyp5Y7/k957nZzUX0dkHpzrDWWhxNDS+
	YURXU7Xtte3hNs2JSVQW+8faA+9kVD5TAs6OrXXtkZ0Ipo96auvS2tZlvpQZgILTl60/ytKg
	YY+dcn7w8tjhaXfS23FV+kvOTtGLxd86wiZde86I++/and09MffyLcV9A3HPJRCaHNlmCa7W
	yP4BVu8IRioEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RWUwTYRSF/WemM2O1OFYTRghgqjxYFUFr+HGPEDMxanBBI7g1dAS0BdIB
	3GJSBFQGMdS40RIrEaEtDdQKCu4WIpqACm4FNIobIkKhVLAaXAqa+Pbd853kPFwSFd/F/Mik
	5DRWnSxXSnAhdqVOEjg7vjFDEXqzNhQ67JkYHPqhR6Hb005AS1UmAgfqG3DYXecC8ELxIAqP
	9N9Eob3hNgGLWufCQzVGBNaf1KGwMU8FO2/lI/DJtSIc1hkOY9CSaxJAR8EHAIdPOATQZCgD
	0HisTwAb8u8g8KKxRwBbvnVjsKFsGIfD9XcR+P67C4fHm9bBTyVnwbIARq9pxhhtVi/B1Ope
	Ecx5WzqTXd8jYC4bpQzvaEEZmzkXZ4o1p1Cm/0MbxhyvMgOmsuoZxgzYAqNFscJFClaZlMGq
	5yzZIUysdh0TpD6X7fWUFuIaMCTlAUnSlIw+XRHGAyEppq4Duqh4EOPB2D+5P+356fzLk2jT
	z05itOQCtK6Xx70Cp0Jo87UbmFdMpu5jdLmpDPEeKMUDuuOjhfC2JlFr6IquYoGXMSqYbu58
	PsIiajF938GD0YkgurBliBjNJ9IPCt+PTKN/8qxqPVoAfHT/Kd1/6jxAzGAKm8qpElRcWGpY
	MrsnhJOruPTkhJD4FJUNjHxZOqMGXDX3hdgBQgI7oElUMlm0WM4pxCKFfN9+Vp2yXZ2uZDk7
	8Ccxia/oMf9gu5hKkKexu1k2lVX/swg51k+DzOvLXT7u10HZ6rTLfo0FrTHzlXiEJMuZMqNg
	Dnop9JO4dMX4uI1TjZqmbV2bDGdytG2E1TfnYFD2xjN7pmX0WyP0a6d1+EYdfRjXwbcH3NMr
	Le8iI+/JIjt0UVp7khEJ5x7FSQ3BYJE4J3YXWOZqdQZnbhafsM4LGlxizE/qyssuWXDA7Xlq
	eH19fMSFz9qdq2JLhQFf5m8tUQmqLAu/ape3udfequzp9cntnfruRfeu8Oi8DdEvQaJpwPBF
	tmW9j8XaZHeNKZ+Qtc42Myqi/e3ZHqezzuNSfHWfu7TXn48pvz0mPM09/dGs5jubrOpATY1x
	n2hpDHHDlndxZXDOm3gJxiXKw6SompP/BisAiN1UAwAA
X-CMS-MailID: 20230531042611epcas5p1f46c41ccec93ce04eef4fe861242ac19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230531042611epcas5p1f46c41ccec93ce04eef4fe861242ac19
References: <CGME20230531042611epcas5p1f46c41ccec93ce04eef4fe861242ac19@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kallsyms_show_value return false if KALLSYMS is disabled,
but its usage is done by module.c also.
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

BPF code has high dependency on kallsyms,
so bpf_dump_raw_ok check is not changed.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
BPF logic is not changed and seems kprobe will work, rest kprobe
maintainer can comment if it can cause issue. Tested for modules data.

earlier conversations:(then it has dependancy on other change, but that
was stashed from linux-next, now it can be pushed)
https://lkml.org/lkml/2022/5/11/212
https://lkml.org/lkml/2022/4/13/47

 include/linux/filter.h   |  7 ++++++
 include/linux/kallsyms.h | 10 +++-----
 kernel/Makefile          |  2 +-
 kernel/kallsyms.c        | 35 ---------------------------
 kernel/knosyms.c         | 52 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 43 deletions(-)
 create mode 100644 kernel/knosyms.c

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bbce89937fde..f67010e7c6fe 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -923,6 +923,7 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_helper_changes_pkt_data(void *func);
 
+#ifdef CONFIG_KALLSYMS
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
 	/* Reconstruction of call-sites is dependent on kallsyms,
@@ -930,6 +931,12 @@ static inline bool bpf_dump_raw_ok(const struct cred *cred)
 	 */
 	return kallsyms_show_value(cred);
 }
+#else
+static inline bool bpf_dump_raw_ok(const struct cred *cred)
+{
+	return false;
+}
+#endif
 
 struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
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



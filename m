Return-Path: <bpf+bounces-1790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F034C721CF6
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 06:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB70628119F
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820FD20FA;
	Mon,  5 Jun 2023 04:10:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DD137D
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 04:10:07 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9008199A
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 21:09:41 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230605040937epoutp013b2044d7d35a559bdba87359f450b30b~lp9cMYXl91989919899epoutp01R
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 04:09:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230605040937epoutp013b2044d7d35a559bdba87359f450b30b~lp9cMYXl91989919899epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685938177;
	bh=4EdxGjMWJn2JfCI0JELUBSu8bBR8MwE5bGC3vqvog7Y=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PwMSMqen65TqhP64/eeBw8wRbUdfIeOORlJd3m71ZGSJ2t02ClvQ8Cabl9IFQJO35
	 02OBV/8+SqqgD7oST2jejUYzPRYfrEf2VzIR2pi3wF/zgoG/oICapLApJjSD9YrhkR
	 5M5YboPBG+tmt3CcrfUOdQkeLPNMFMqdubB17/u4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230605040936epcas5p1e9c91a397d374fe85d3e490793f48609~lp9a3iDJ12840328403epcas5p15;
	Mon,  5 Jun 2023 04:09:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.6B.04567.FFF5D746; Mon,  5 Jun 2023 13:09:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230605040744epcas5p21968bee09fba5c3505a729fe2f57c507~lp7yiGBU71115111151epcas5p2a;
	Mon,  5 Jun 2023 04:07:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230605040744epsmtrp2349389775d2c0e03e8140da802e0f5ab~lp7ygs5xF1080610806epsmtrp2W;
	Mon,  5 Jun 2023 04:07:44 +0000 (GMT)
X-AuditID: b6c32a49-db3fe700000011d7-d8-647d5fff6686
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.B8.28392.F8F5D746; Mon,  5 Jun 2023 13:07:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230605040738epsmtip23ac210ce26d7c724f2b2ab94d60d31fd~lp7tqqucA0036900369epsmtip2o;
	Mon,  5 Jun 2023 04:07:38 +0000 (GMT)
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
Subject: [PATCH v3 1/3] kallsyms: move kallsyms_show_value() out of
 kallsyms.c
Date: Mon,  5 Jun 2023 09:37:29 +0530
Message-Id: <20230605040731.13828-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRzved93737o4nV4+giFObRkxYDOrseOlAq7V++8qLw6tU4GvIK1
	AW388LcgHN0gdoOwE8YJXHDMxYUN5uFM1sZqZ0XGgBx4GKdQxBA3tjmQ0GAvXP73+X6+n8/3
	8/0+9/BwURMZwTuSnccos2VyMSkgLvfESGKfSj2VEd8zjCOXrZhAwXkdjvxzt7iorbMYQz67
	g0TunhmAvm56gKPPvddwZHNYuKh+6GV0tkuPIXtNHY5+rVCgv7srMdRvridRT0MZgdrUFznI
	pR0HaKHaxUEXG1oB0n/h4SBH5Q8Yenw3wEEt+nsc5Jx1E8jRukCiBbsVQ2MPZ0ik6X0PTTSf
	B0lRtK6oj6CrSqa59JW6ES7daMynS+33OHSHXkKXu5w4bTSoSbqp6BxOe8eHCVrTaQB0e+cg
	QfuMUSnCA4LEDEZ+pIBRxu1IFWRpKvx47k3xUf/jMm4RaHimHPB5kNoG/2n9l1MOBDwRdRXA
	YO0Mly1mACzvG8TYwgfgWd1vnBXLnKcXZxtmAL9qmwBs4QfQ5rpJLqlISgoN5u+JpcZaqouA
	v383GpqFU2UA6i5YiSVVOJUCTZcDobkEtQV2NPaGsJBKhKUVA1w2byOsdQa5LL8GXq8dC3nx
	Rb7EpAvtAalv+NBt1S8bkqG2uRhncTicdHQu8xHQN31tcT3eIi6EJu0Z1lsKoKW+hmQ1O+FY
	XxNnSYNTMbDdHMfSz8JzP3+LsblPw8r5MYzlhbDrwgreAkuHLi2/UST0eb0Ei2n444A/tI6I
	+hg+Ck4BLdhY98Q5dU+cU/d/ciPADWADk6tSZDKqV3ITsplCqUqmUOVnZ0rTcxRGEPrFkt1d
	YGTUI7UBjAdsAPJw8Vqhec+JDJEwQ3bsOKPMOaTMlzMqG4jkEeL1whdev54uojJlecynDJPL
	KFe6GI8fUYRRNr97fey6yKFjJ//4JbDueV3aicLat+hL80MGw2ByczyWXyC0psXXjO4qvt8R
	vbNRvGbT/je3GfZKTW8UaMZHcl4aKH6Y1dKv4bfFlAyH23RRprnJgp8s++vbj7d0Vof95XzN
	8ZnikOFg/oTl1cma6APPBeKML4blvdN/ozt8OHI+7eiXYbN3tmsDmzz026u7+cHTI3cSPTmW
	Kstc9Vb77uQp6T7vnkdFHuuUbtfmU/vkdAL/9AeHg5uT+jLHb/dUpY4J0mMXBLd92ite9w6b
	afr+1ZPVKebVknaROung6Ps3BuRq4t3pxI9WHd5AUg/UH0Y7z6g/WYX/eXfWcWv75ODWoJhQ
	ZckSJLhSJfsPsQGRSTQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSvO6E+NoUgwvaFjcONbJYfP89m9ni
	y8/b7BZrtjQyWXw+cpzN4vXhT4wWixd+Y7Zo/7iX2eLQ8f3sFnNuGlk07VjBZHFkyixmizPd
	uRbP9/UyWVzeNYfN4vD8NhaLNZ0rWS1uTHjKaPF30g1Wi5XzlzNarOj5wGpxvPcAk8X/x19Z
	LZaueMtqcenHaxaL48v/sln8PXKQyeLJr09sFn1ngyxeLJnB6CDnMbvhIovHxOZ37B47Z91l
	91iwqdSj5chbVo/NK7Q8um5cYvbYtKqTzWNhw1Rmj49Pb7F49G1ZxeixfstVFo/Pm+QCeKO4
	bFJSczLLUov07RK4Mvq6vzAXXFeq+PK/jb2Bcb5MFyMnh4SAicTPD2eZQWwhgR2MEn1TiyHi
	0hI//71ngbCFJVb+e84OUfOJUeL/Fy0Qm01AT2LVrj1ANVwcIgJ3WCT2vdzIDuIwC3QxSjx8
	tgasQ1jAT+LxuyuMIDaLgKrE5gVnWUFsXgEbiZbuK+wQG+QlZl76zg4RF5Q4OfMJ2GZmoHjz
	1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIziitbR2MO5Z
	9UHvECMTB+MhRgkOZiUR3l1e1SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnN
	Tk0tSC2CyTJxcEo1MG28cv7id7ewxfz975ad0w8/EdF9PcqI4Xiv1LRdM6d0rvEPmND4YX/k
	A33dNVtXRlsqJkw8OcOvYvn+x1mahxnFHh6f+85BpiRm3an32uUvGw5/Yzh3TqY3MND6A2/A
	BZPs99s3s7nNvvpB9KNR98W8dzsfMbf8dfv/nWer388XWX8+TNiz4cHTnq1iPp/cj2T/Pnny
	3HyLc9uMVm/4riWW7nM15Zla6f/C/JpqkSyO6KmXvKr0Jk3ov2G+cUFNMOdr85CNtgW/p/Q8
	K3/Praap2quloLay+AU/U07Uw7YTbUFvnBpNVJaZnlLXYuu8ISBdFpYd1uEyaWbgy/M+ijYu
	6QHxuWvFJqh8em/cPUGJpTgj0VCLuag4EQA4+1cdVwMAAA==
X-CMS-MailID: 20230605040744epcas5p21968bee09fba5c3505a729fe2f57c507
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230605040744epcas5p21968bee09fba5c3505a729fe2f57c507
References: <CGME20230605040744epcas5p21968bee09fba5c3505a729fe2f57c507@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

function kallsyms_show_value() is used by other parts
like modules_open(), kprobes_read() etc. which can work in case of
!KALLSYMS also.

e.g. as of now lsmod do not show module address if KALLSYMS is disabled.
since kallsyms_show_value() defination is not present, it returns false
in !KALLSYMS.

/ # lsmod
test 12288 0 - Live 0x0000000000000000 (O)

So kallsyms_show_value() can be made generic
without dependency on KALLSYMS.

Thus moving out function to a new file knosyms.c.

With this patch code is just moved to new file
and no functional change.

Next patch will enable defination of function for all cases.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
earlier conversations:(then it has dependancy on other change, but that
was stashed from linux-next, now it can be pushed)
https://lkml.org/lkml/2022/5/11/212
https://lkml.org/lkml/2022/4/13/47
v1 -> v2: separate out bpf and kallsyms change
v2 -> v3: make kallsym changes in2 patches, non functional and
functional change

 kernel/Makefile   |  2 +-
 kernel/kallsyms.c | 35 ----------------------------------
 kernel/knosyms.c  | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 36 deletions(-)
 create mode 100644 kernel/knosyms.c

diff --git a/kernel/Makefile b/kernel/Makefile
index f9e3fd9195d9..918d3e9b14bc 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o regset.o
+	    async.o range.o smpboot.o ucount.o regset.o knosyms.o \
 
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MULTIUSER) += groups.o
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8193e947aa10..0f82c3d5a57d 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -907,41 +907,6 @@ late_initcall(bpf_ksym_iter_register);
 
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
index 000000000000..9e2c72a89ea5
--- /dev/null
+++ b/kernel/knosyms.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Samsung Electronics Co., Ltd
+ *
+ * A split of kernel/kallsyms.c
+ * It will contain few generic function definations independent of config KALLSYMS.
+ */
+
+#include <linux/kallsyms.h>
+#include <linux/security.h>
+
+#ifdef CONFIG_KALLSYMS
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
+#endif
-- 
2.17.1



Return-Path: <bpf+bounces-2088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502647275D8
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 05:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CF281630
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 03:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BC111E;
	Thu,  8 Jun 2023 03:39:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0F10EF
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:39:13 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404226A1
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 20:39:10 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230608033908epoutp04a2d107a8e30d3455563941c53c480489~mkergJdbh0138501385epoutp04y
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:39:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230608033908epoutp04a2d107a8e30d3455563941c53c480489~mkergJdbh0138501385epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1686195548;
	bh=2Fz2DLJhxQC3RZTzyXiXAqOxcnw3R376ukqCFr/l8z0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OFrFG3BycUk0yJMGsdG1dEfcWOn1dCDx2EBgDEo4NCZKYvq3ezpDLTHaSNZBJwZeo
	 AX3dWMq12e+9kNMKykDjgKGh674IVWxoROy6ZtC9bCnH9D7zW/bbk4CthrgZlyQ2ix
	 Ars0O/pre0tAK/f5JDBrWF8INCTukXIa88ps38FM=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230608033907epcas5p27c6e3d9457ba227b42747c5bff110f02~mkeqsDaw93270632706epcas5p26;
	Thu,  8 Jun 2023 03:39:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.A9.44881.B5D41846; Thu,  8 Jun 2023 12:39:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230608033132epcas5p22208020abf46fc8667086c31b6d7c63d~mkYDAYZcV0732707327epcas5p2u;
	Thu,  8 Jun 2023 03:31:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230608033132epsmtrp13712376939b39ccc0b0100f2126a2a06~mkYC9UIIf0357103571epsmtrp1a;
	Thu,  8 Jun 2023 03:31:32 +0000 (GMT)
X-AuditID: b6c32a4a-ea9fa7000001af51-ca-64814d5ba94e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	02.F2.28392.49B41846; Thu,  8 Jun 2023 12:31:32 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230608033125epsmtip19c2d6d633b95d95b1875734d8cf2b767~mkX8i8neI0805408054epsmtip1F;
	Thu,  8 Jun 2023 03:31:25 +0000 (GMT)
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
Subject: [PATCH v5 1/2] kallsyms: move kallsyms_show_value() out of
 kallsyms.c
Date: Thu,  8 Jun 2023 09:01:18 +0530
Message-Id: <20230608033119.1543638-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVSTVRzHu8/bHuZZPQxP3sAgSSIxRlDmtRL4w+pJwyOd8lSgtOAJrQ13
	NibpqeN4CQ/DwZyaMN4jj7yIwBoeXgXGcqLlwSGJGLXlprwk8ZYmyDHHIyf/+/5+9/O93/v7
	nUvj4hLKl96dksopU6SyQEpInOlZ82JoXEx60svV2pVo0JJOoLvzRTiavXddgE6Z0zE0Y7VR
	aLxnGqDKijs4OjjVgSOLrVOAiq9FoIzmKgxZjxpx9HOuHN06q8NQf2sxhXrKsgl0KqeaRIN6
	N0ALhkESVZedBKjq0CSJbLouDD248Q+JTlTdJpH933EC2U4uUGjB2o0h19w0hfJ+eR+N/FAA
	ov3ZIs1lgj2cOSFgW4zDArbcpGazrLdJ9seqEFY7aMdZU00OxVZojuHslHuIYPPMNYCtNw8Q
	7IzJf5voE+GbSZxs915OGRb5qXCX80GvQHE86KuRPjuhATZ/LfCiIfMqtP1eS2qBkBYzbQCe
	ue8Q8MU0gN+ONZAeSszMAPjrX2uXHJVDkwQPtQKY2XT1kX0WwDZNL+GhKEYCa1rbF6nlTDMB
	+xodmKfAmWwAi0q7FykfZhvMuDlHeTTBBMErV8ofhtO0iImE+X8r+LgAWGi/K/BoEeMNewtd
	i1b8YT+zqQjnmVovaGijeL0JGseNgNc+cMxmFvDaF47mZy9eD5k02KQ/4HkOZLIA7Cw++sgb
	BV2XK0gPgzNrYH1rGN9+Fh67cBrjY5+EunkXxvdFsLl0SQfBrGv8tiDjB2empgg+ioUlHV/z
	S9wBO+byKT0IMD42jPGxYYz/B5cDvAY8wylU8mROtU4RkcKlSVRSuUqdkixJ3CM3gcUfHLK5
	GTgdkxILwGhgAZDGA5eLvog6kCQWJUn37eeUexKUahmnsgA/mghcIQre2JsoZpKlqdyXHKfg
	lEunGO3lq8HiNaONlojcFeZh75tPfFYXV7C/JTf2bAmZusxwsXlL/5G0xvDheP2dl3aMhpNl
	tvPTBTs/Py33jXr7J0PCsGH1B9sv5Vqd5udk6//IvDpbV34rZn1XW9eRjxL6JZuDZr4bCcjK
	mde3H1Scb4GVMmv3htqJnMN5m4SHdBtC9160hNv/lJ942i2bcLqu1y17w013Z4sHzhl93hG4
	I1/fGnzv3Y1bVoVlyJ4a6At65YWVoUMFlWrVrLq9Ydi7gxwvmaxY3cjoYm78FhtzKTE4tLB0
	PG5AL0yPLT3+VryjruK13u93ln3juB+96lz+e86t+8ymhpZ1z0fX09q1Yw7Mp1Pt9/GFgQ+3
	BxKqXdLwEFypkv4HHRqfMzAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzH932e557n6XJ5ujTfTsucX1s4VOw7zM/h2ZokNoTluEcXXW53
	FSI6cXRX17FCd21dxVy3LBKlRVzlFjJOthOGSvKjdBUJiS42/733fr0+e//xoXHhXUJExyUk
	cqoEabyY5BPX68RBs3LCNbI5GpsIuewaAg38MOOof/A5hUorNBjqq3eQ6GNdL0DFhV9xdMJ9
	E0d2Ry2F8p+FoKNVVgzV55hw9ECvQO9uZWHoSXU+ieoKtAQqzSjhIZfxLUBDp108VFJwESBr
	Zg8PObJuY2i47QsPXbB28ZDz20cCOS4OkWio/g6G2r/3ksjQFIU6z58DS4NYc9pjgj2V3k2x
	N0wvKdZSnsQeq+/isVetwazO5cTZclsGyRam5eKs+20LwRoqbIAtq3hKsH3lQZGCaP4iGRcf
	l8ypZi/ezpe/GW6klGen7u985CTSgCNIB7xoyITB4pYeQgf4tJCpAvD+YDYxCibAwV+f/2Y/
	WPLrHTUq9QJ4Jr8KjACSkUBbdY3nehzzgoC33l/xWDijA/BNRyk1YvkxEVB/3YiPZIKZCpub
	LX96mhYwi2H2Z+XowkSY5xzw6ALGFzbmtXuW8T99+jUzbgQ+pv+Q6T9kAZgNBHBKtSJWoZ6r
	DEng9knUUoU6KSFWsnOvohx4Xh0cXAVqbD0SO8BoYAeQxsXjBLuXHJEJBTLpgRROtTdGlRTP
	qe1gAk2Ixwse6RpjhEysNJHbw3FKTvWPYrSXKA07fGCKtKjSe90lbXq0SZT1U+KfvDlnpksg
	5vv00ZP8O+rWRn7oGhuQorfPK3uxw7iwKLJ1ybSV5lT3cLHVqmy1DBReWK2ffI8ypM76Vnio
	llB3xu0qeAUPXz6DlTU3dphDFSvkActqo/3OLshN9R5OfDzmZEOsUOt0a9n1InGb/PTy1vWv
	U/xvROVFxDN7Jud0x4BnVM3W3KKHZPaKg/KQjE1L2w2KlnDZDG6r18CnJsm2at/5ZYHT14zP
	+xreVPk9NFnvyJxXqQuMxq5kN0XETWo7vnHzBs202i0/19qP2ELhSXKMpdso297gk7nM7L8x
	sKVPW9IvM/xYlSFfHub2EhNquXRuMK5SS38DRlEhEVkDAAA=
X-CMS-MailID: 20230608033132epcas5p22208020abf46fc8667086c31b6d7c63d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230608033132epcas5p22208020abf46fc8667086c31b6d7c63d
References: <CGME20230608033132epcas5p22208020abf46fc8667086c31b6d7c63d@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Thus moving out function to a new file ksyms_common.c.

With this patch code is just moved to new file
and no functional change.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
earlier conversations:(then it has dependancy on other change, but that
was stashed from linux-next, now it can be pushed)
https://lore.kernel.org/lkml/202205111525.92B1C597@keescook/T/
https://lkml.org/lkml/2022/4/13/47
v1 -> v2: separate out bpf and kallsyms change
v2 -> v3: make kallsym changes in2 patches, non functional and
functional change
v3 -> v4: patch order changed, file name changed form knosyms -> ksyms_common
and copyright header modified.
v4 -> v5: license changed to kallsyms.c file, and bpf changes are
dropped as confirmed from BPF side:
https://lore.kernel.org/lkml/CAEf4Bzb4B9FxMnf3t81D22FWkciLOvwDPLY0BbEPGGe7R5QPrg@mail.gmail.com/T/

 kernel/Makefile       |  2 +-
 kernel/kallsyms.c     | 35 ---------------------------------
 kernel/ksyms_common.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 36 deletions(-)
 create mode 100644 kernel/ksyms_common.c

diff --git a/kernel/Makefile b/kernel/Makefile
index f9e3fd9195d9..3947122d618b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o regset.o
+	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
 
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
diff --git a/kernel/ksyms_common.c b/kernel/ksyms_common.c
new file mode 100644
index 000000000000..3840fa1c9c86
--- /dev/null
+++ b/kernel/ksyms_common.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ksyms_common.c: A split of kernel/kallsyms.c
+ * Contains a few generic function definations independent of config KALLSYMS.
+ */
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



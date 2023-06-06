Return-Path: <bpf+bounces-1914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A70723640
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 06:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6108D2814E7
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 04:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75BA34;
	Tue,  6 Jun 2023 04:28:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732A659
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 04:28:50 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25708F7
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 21:28:48 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230606042843epoutp017c0c900c76b80b2aaa8b0f5926b1bdec~l93ZhFCI53038530385epoutp01f
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 04:28:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230606042843epoutp017c0c900c76b80b2aaa8b0f5926b1bdec~l93ZhFCI53038530385epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1686025723;
	bh=UPFI0Fr7ya420xXG7/qmyA3ANnUzZPRg9R0PJ6qxvac=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MQTZa+WJslaNKMGhI0Kio7JA9mb0rvrV+H+Ck1PZTsvzZhRqAwXjJWrZTRfezlIik
	 3Lz2N2CxSyXI1UfnHbS+fzieeERAE9TGENLbhrbypQaipy2Kzv6bIBQQIrWk4yGcO0
	 RdAitLzxLQxOvSlgwwElcLTyj9waZMvmhRh0FG1k=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230606042842epcas5p3eb897c6d960d8f31f28f6dd854176e09~l93YawC7Z3179831798epcas5p3L;
	Tue,  6 Jun 2023 04:28:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.18.44881.9F5BE746; Tue,  6 Jun 2023 13:28:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230606042812epcas5p262df978931619b2d62e493d08147e120~l929LShmh2556625566epcas5p2C;
	Tue,  6 Jun 2023 04:28:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230606042812epsmtrp1cbf27e575176fc8450b477e77f929137~l929I3EUW0584405844epsmtrp1_;
	Tue,  6 Jun 2023 04:28:12 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-7b-647eb5f9c379
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.13.28392.CD5BE746; Tue,  6 Jun 2023 13:28:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230606042807epsmtip1ac638ff8d094c6ebba5cb5c8d82d3039~l924Ng6aB1859118591epsmtip1A;
	Tue,  6 Jun 2023 04:28:07 +0000 (GMT)
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
Subject: [PATCH v4 1/3] kallsyms: move kallsyms_show_value() out of
 kallsyms.c
Date: Tue,  6 Jun 2023 09:58:00 +0530
Message-Id: <20230606042802.508954-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yTVxjGc75bS2PNB7h4BMWMYYZk0o7JciAyFzTui7MJIyMx6DIa+qV0
	a7G2sO7mVmZTBxus3hIsHcKEcRkO6WAWtOPWUF1wmThJC8FghDHsOmkrl3LJRvuVzP9+7/O+
	z3nOe3L4eEwdFcdXFJewmmKpMpESED8P7k7eE+z6TCa+vpiJXANlBFpcqcHR0+A4D7V1lmEo
	4HBSyDPoB+hK/QKOzvjsOBpw9vKQxZ2GvrA1Y8hxwYyj4a9UaOaXSgzd67FQaPCykUBt5S0k
	cpmmAVo75yJRy+UmgJq/niORs7IPQ/8+midRY7OXRCNLHgI5m9YotObox9DUsp9CVXdy0V8N
	1eD1BKZGf5dgzp7+h8d0myd4TJ21lDE4vCTzU3MKU+EawRlraznF1Osv4oxveoxgqjpbAdPe
	eZ9gAtaEHGG+YJ+MVSo+YDWi1woERUP+YUJ97oUPPY0eSg8mtleAKD6k90K/eQyrAAJ+DH0D
	wOpVD8kVfgDdrnacKwIAPpgMEhuWG95vKa7RA+Bwd1OkeArgzNATLDRF0amwtecmEWpsoW0E
	/L1jMpyC00YAa2r7w2fF0jlweaSSF2KC3gU7DN4wC+ksONvso7i8nfDSyGJEj4a3L02Fvfi6
	frqrJnxBSDdFweHzbThnOAj1ZXaS41j42NnJ4zgOzn5jXGf+Outgl+lzzmsAsNdyIRK2H07d
	rSdDMzi9G7b3iDh5B7z4648Yl7sZVq5MYZwuhLbaDd4FDe5rkdh4GPD5Iu/FQJNzDQ8dGUO/
	A2ttWhPYaX5mG/Mz25j/D64DeCvYxqq1KjmrTVenFbO6VK1UpS0tlqcWnlBZQfgTpxy2gYeT
	c6kDAOODAQD5eOIWYc/hT2QxQpn0o49ZzYl3NaVKVjsA4vlE4lbhi1m3C2NoubSEfZ9l1axm
	o4vxo+L0mCzpN4Vks324wA3EjuTuK9XHVSK2qOXN0dk0h7/2+vhWcNI0ZDY8HM9D47q5kuxb
	R266XI0ZOXlvze8VLbUnZduf1wdHVbqOoif3Rp+bOSaiC/aRlZYvX3r0iiT9Tt2qM3/ZLPn0
	cd6ptB25SX/Hnp2x9x50ZKpG06lbJY2H1MbJJdfgIR08FbxaLH7Alh/I/bOvPyCublFeSzgv
	GLr/ttSdSUmIo8cEOaubDuRnFcgzrOKFNyZnN0WbJHne7KFo8mTcfIInuX9xrOr4H50LfW6b
	Iz7zyPy271/dbly5KqItijP7Fd9NBAp/mD9qjeuo26MQZ/QuTMsb1MR7ysaGREJbJH05Bddo
	pf8Be+7qNDMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUyMcQDH/Z7nueeebjseZfxUMuctLSnz8tvQzD8elCWbrE0c96yiq3ZP
	5bzUSkjHXcpbdVqF5joR16VX4TpOW4YzHF0tSy+c6+VSCeeli81/330/n+37x5fC3U2EJxUb
	n8TK4sVxIlJA3G0W+Sy1VqdJAk/U+SKLIYNAY9/VOPoy3sZHFfoMDA0bTSSyNTsAulo6iqOs
	oXs4Mpju89Hlt8vRsVoNhoznC3HUelqKepuUGHpZf5lEzcUnCVSRXc5DlrPdADnzLDxUXnwd
	IM2ZQR4yKR9g6FfXCA+Vaew8ZP5qI5DpupNETuNDDH345iCR6mk46ruWD9b7MOr0FwSTm9nP
	Z+oK2/lMiS6ZOW6085gqjR+jsJhxRqfNJpnS9As4M9T9jmBUei1gKvWvCGZY5xMmjBSslbBx
	sSmsbFnwHkHMY0crkZg3X24rs5HpoN1bAdwoSK+ADfYiUgEElDtdC+DAlQFsEnjB8Z8DxGT2
	gOU/e/mTkgNAVWWZSyLpAKitbyQmwAzaSsCmj3dcFk4rAHzfU8GfsDzorfBxxxlyIhP0Qnjn
	uN3VC+l18KNmiJycmAsLzGN/++mwpeCDaxr/02dWq/GzYGrhf6jwP1QCMC2YzSZy0mgpF5S4
	PJ49GMCJpVxyfHTAvgSpDri+9vOrBY3awQADwChgAJDCRTOE9ZuPSNyFEvGhw6wsYbcsOY7l
	DMCLIkSzhM8VLbvd6WhxEnuAZRNZ2T+KUW6e6djR5hQ6b44l7/OunVH8+f1dd9PCtne8wagq
	UFMu3TjadfvcE8uC1TvC3y4pClsZvn/btPxNyXq740Rw2w31t5Rnc60XjTl1/jN9I1StmxIy
	5O3iT52h5wf7BlR7G2p6M7dsoKxRMeZO/OCtRfIsmbkKS80NUYpEPOmlwJDaxj0Z2qh+yc0R
	GCHPZVNLx4Jaw+Q/BOz46n2ROWv8e9ry3+hGbUdKvUumctlDF7bZFxescnZUs1Z5zrrXoacC
	PR4V1xV5qmKZzpAG27vv0aNZ3KW+KZutlcF7pT8E+nOO13ENoc7hljRrjppdeiBipQrqbyiV
	hJvnrZh59iRNzctPQSKCixEH+eEyTvwbZdUy8VoDAAA=
X-CMS-MailID: 20230606042812epcas5p262df978931619b2d62e493d08147e120
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230606042812epcas5p262df978931619b2d62e493d08147e120
References: <CGME20230606042812epcas5p262df978931619b2d62e493d08147e120@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Thus moving out function to a new file ksyms_common.c.

With this patch code is just moved to new file
and no functional change.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
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
index 000000000000..e776f12f0f5a
--- /dev/null
+++ b/kernel/ksyms_common.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
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



Return-Path: <bpf+bounces-51489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F7A35324
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3381891382
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB05134D4;
	Fri, 14 Feb 2025 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lweEzeTt"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2069.outbound.protection.outlook.com [40.92.59.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B971863E;
	Fri, 14 Feb 2025 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493625; cv=fail; b=YoohuAwCCap/9ncYFW9M1OC4hgeyayWisybsWqskQRk7FCJyGkOb4+6LwfAd6rAs4gkI9brrmMOsbkFHoUjHFEQw1uLfxLBQRxk+9G+jtSfPX65aiKCh78g8YXiAVeUpjx9EJUeuyemxn6uf/qTDbvDmj5U8TI39Mog4e6OnNNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493625; c=relaxed/simple;
	bh=RHyu8iP9eN84DuDluqXLOKucNdaptC5YwmTdZnn7RWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hec5PcK+7EESQI2tpDGV3bT3GGg4Zn0DsBxl8T9JVBTWMTFVMu59O8X767IUpsPpgAPgnyOszKwSids1GGtxXSjvet3G5xNgbd1BbWMsgBaZc/pI6aHlma3RCJoAuAJyG2ZVw0oQz/rCG5cVGzz57Kqei/YxmdT3E93QWL2t9vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lweEzeTt; arc=fail smtp.client-ip=40.92.59.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol9wg5ddCn0YyuImE441AVA8yWyxUqcaZK4YpHT/44tLDMve6zU5dJAVzBTtGtZcfSDmRfdZZIrvTaRJgujVdP4UTcyCWg6pKuAw+g63DAp4xuEUwhDD0oHvuZDXheBD4Vpe0nU1JIbhpPS9PvfQrk6ICLLJszUzJkVtcnlirUyGzYrpZP/B3/ODo6q7Fo0cMVKXEP8Pb4P2xJhkXYY/qKNc3qKonsTQrXhUhca/heZS3x0BfbaUlxaVsz+pb2eQyuimjKbdkeXpWtSzNy2c2pvR2vypsz9vpEX4DaZCJlWU/tzkDt3jI3SWFsFc0nV8vh+635MEocT7nTkz8Wn0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSaGOC+54QbVHkXb7qIbugj3rZQ0zRzi4tXZEVfEh28=;
 b=hPjxLpJCeuiCCEx1aiEYUm9sSltipysyMnHFJUg8HcyYu/fkKFwgcvckbupgN3NWmwgpQ0oAWgKvBDP99aA+z7oivCRDnaL0XTZ8gkJ8p2N+hLsDWvFECjJjRU9UF5rHf1yGci/6Py3FkoFtzhukD6Ju0jvSsc07QL/vgjp9YXbk1qW+K9rnF+WAxW6IpjX6Ksa3tYP2kXjUIIbDAqNI/PQ7HxvY9E18KGXWmd+Xz7YXmS2tLu9ntzFnMZxpbkzYTyneHxscWqJiFzEJfLV1oKiuk4jW/oT1d+rfkzJRMrXBspSQsiNS/xA0/aHLmCHI+4+RTukPv9P4YQWfQnGd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSaGOC+54QbVHkXb7qIbugj3rZQ0zRzi4tXZEVfEh28=;
 b=lweEzeTtkVKNxub6QNh0oQPwLiBR8YU8YgPT8BG6gzejgOwXm1ldkFLTZlGQT9REWGHg8m8ubuDsJxdmhC5mf/QEddy8aq+4O8/PYJE1AQThMzSm6BYf3dkLGkQqP7vjMYTtxWD9cwEdX0rafV3OIUO1CyqL8vacATlA3kwFpHImIJpLkBUU9T22Pf1h9kTRbTwQdI2WcMof2xbfRAfU+1igloPokdGQB3HzNv4e8JvOKtULk3tTiVGkfWssj3afl/oULbUiD33CQOmdWdw6LhpnaTrNp/fq2WrwyeyNaMc5wq7ey3gxw2o3DtEsuOqnOlIEskZNa6zCRN1EXQS8Bg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB9817.eurprd03.prod.outlook.com (2603:10a6:20b:61b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 00:40:20 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:40:20 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 6/6] selftests/bpf: Add test cases for demonstrating runtime acquire/release reference tracking
Date: Fri, 14 Feb 2025 00:26:57 +0000
Message-ID:
 <AM6PR03MB508078EF9EDA7CAC87E8AC3299FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214002657.68279-6-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 641a2aac-a60e-416d-a884-08dd4c9028ff
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|15080799006|19110799003|5072599009|13041999003|3412199025|41001999003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ssfBHgdWatZ1TkWX9W1Ka6YVd02626Jnvw1eK+h0B2mZWpwoYoBEbZ+6ma7N?=
 =?us-ascii?Q?VCc43qpB8bcSpNWcMoNF/IYiDm1C85KT4g4HZmNHooUyoAa82SfRAz2hn+/7?=
 =?us-ascii?Q?ME0dHoQ7ckwdJws1Z0YLXdHGOENxJG9A0COCQwim2lNKQxqEFDkX9yG4U+mN?=
 =?us-ascii?Q?8EaFh1KC2SIJXJgzmIzCiccfqkKOiRPJKGS2HRmkovPurZ7Tfqt0ZT5MmSLJ?=
 =?us-ascii?Q?aRiWoJdvD7Jve1euTBQ3qDH++JfilaTAXfndIkS/43ZOSvQ3h1zsmH/uAfhK?=
 =?us-ascii?Q?+J12HXyhE5cqOme5aJPOhmIJpQmThKd0rDCji/UA7Z3vx7FkgFN+NxKfF3Mn?=
 =?us-ascii?Q?+62EnDw7fJvcsuuRuPUq9Ix0+E/ILXpBJ4cAbGCPRkkW/Wr0l0tipxsDl0Zt?=
 =?us-ascii?Q?4UIeaCXO3WVo92wDgSO5CzBlqbd+juV8D1BR/rqWIhJIRN13b5drjE3GoGll?=
 =?us-ascii?Q?dt1VJ9HnFECxymInv/IrQ56iUWNJ6lJnqdb97atqUZ3LTP8SdOepSsTB3On/?=
 =?us-ascii?Q?Qn9mtzzO3Kr3cES6cr7qG5+80+hyXi34jAtd62X3wYIVEImRb79d5O4Yq23I?=
 =?us-ascii?Q?NC8cILMQYd9XNW6WE9EQiLLzXvHTna1ArAoV437WpbnPKRBFUIONWejQYlZA?=
 =?us-ascii?Q?nuWGHi9fg2kDqVYSC6PIJ5gnpCSpjbnPSu1oWJOvBk8TTnoyxYJNNY/K3dgB?=
 =?us-ascii?Q?frFv6usdrYVorUPhN77YogZ82JHdeOJ5nG7KmEujNJ6R/0vBIFAmiuEHlYkV?=
 =?us-ascii?Q?S26hQqYpbyMD8foRapvXuErLZSvBRx4jnKhRtAs7RiGU0PLVq67bdsHVGMsJ?=
 =?us-ascii?Q?GXz5l3WgaZgKuZJxWojdRe3U4IJYFMmuBgk9iFRAGvYWDzwWXrrtKtUXePKB?=
 =?us-ascii?Q?6zV6SLrpQEpDtA6+rWPjthlAT9yXitUW1rpy/Ixy9VNFmzfWYFgImydV8Vq8?=
 =?us-ascii?Q?uoSu6FETNfbBnoWMybK2s3/MFn9t8JPPNEFiue8eOpK53IsAP7nUsdvxOPlG?=
 =?us-ascii?Q?pRx4dg34yqQPda5oXHmSSpXJzfolJPPUGgTiX3BIykqWRlCZz66a1uhgxgT4?=
 =?us-ascii?Q?kgEf8UtxeAsqzmEVp68Y7ymlwS28YTH7CCW6T29JqyHb8z2ET1E=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/0p4tQ9c7OBq/BSjUUsyqXW+Kqo7s0rvuQRur/FLn5/m7iuzHhlP/h+sz8o?=
 =?us-ascii?Q?zWcKK1BBMbgLwmiZCY/upESIQ2NW4/aLMQFzboVhAcypH7A+b9Ee9jMzmPZJ?=
 =?us-ascii?Q?7OU89fmyuBE9Ih/8ctaPq3gyOscZ9GiJkj6iFS33xv3Q5V5WpvR09NvqMTlZ?=
 =?us-ascii?Q?CvxqvL5zj5pvs3rtBp9BQuEfoJYIa4aLACdpJ/4bPBn+xT6EpLLbj8dFCGkz?=
 =?us-ascii?Q?VuDGFt4iWNDZwVHYlTFHWn3Ta+P6185w2T4UA8GO0h858A5P/8nXC3LJPUoI?=
 =?us-ascii?Q?aSTXS2bz5sZRhgncIj7edbEIIzTFFBpBoje2WjjHkrOre/W3aLB+N8l1/8w+?=
 =?us-ascii?Q?QfauO0oVzNUq/vli977YB3XAaMC9DObgv4gjSQpRgFsTk0JGqkNkIlITUbla?=
 =?us-ascii?Q?5uYSHg0r91mwiMZPxlSwTK+hpZ66sR8L6qnnlFE9fl/LszqV/c2qRBoxTyRT?=
 =?us-ascii?Q?yw852RjwUVpOfxqbhhieUSaA1/47vtAG5gVELXF0cRR05sOrf3NQpYD8DOEo?=
 =?us-ascii?Q?ma3bxCRaLzjTdBhYagpFbG73MAAsBeADNg2v7uxXB/3UuvS2WM73pPuKqXdH?=
 =?us-ascii?Q?1IBOHFpAI93D9dwRcriKy5X2nJLxlsPG76bGTrC/7aK/avYgObmdqgZgDzDz?=
 =?us-ascii?Q?wF+nN5cJorvrnYqIs4nNIB1Rk757SzsXVUIatCL5DfLMBd//pwmDN+V0yZXd?=
 =?us-ascii?Q?UKEPltDfTGv1K4UYBiJH3j2vLgb1LXNr+3nFLUPDF0wwPEF8vxWIFd3FjNRE?=
 =?us-ascii?Q?Ui9+Lmrlv+fPrsq+px1ABwoRVNXrXMGPpAgF9j2qFlgcAR/ylPcWGBr2RyMo?=
 =?us-ascii?Q?L/JQdu2YMXQ2sGYB4/t6uyOaL4suCzS5b349MeVUIUW7RaitTUTiOB9H+e4g?=
 =?us-ascii?Q?+kSPS6aYPFw2Uf0THup19UBxLl7beOLfeyFFPAE56ZzaQSUWMBNRBXGMnjHg?=
 =?us-ascii?Q?3ophIiu5ZuMJ19NMQ+WtizRU9rNTlxbS19Vv4z3Fb4U4pXFtn5e0YE8217CG?=
 =?us-ascii?Q?fjUSeRlaT5DP5kmFdfly4wPKj2ivDvG9tN7077wgiP92KzEOENvrumbR768g?=
 =?us-ascii?Q?QIeb/UNS3BUe029a22ikjausTQjPrl91bjDNltH474bYQn/5k38l9SpkPD0P?=
 =?us-ascii?Q?BaNC4tHjoPypYsS3HmPE7p2i/bChZE0+H5xXL8/5F2MvnwAq/dQJzwvke/Ym?=
 =?us-ascii?Q?eu4YM3Ov2afLAJvL34z+ERI+7XT9Y9+b7W1SgK7SEhkATopQMd1EPWm2puQk?=
 =?us-ascii?Q?aXMgTYVpBWkiy2/XAC8H?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641a2aac-a60e-416d-a884-08dd4c9028ff
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:40:20.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9817

This patch adds test cases for demonstrating runtime acquire/release
reference tracking.

Test cases include simple, branch, and loop.

Simple test case has no branches or loops.

Branch test case contains if statements.

Loop test case contains the bpf_iter_num iterator.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/runtime/Makefile     | 20 ++++++++++
 tools/testing/selftests/runtime/branch.bpf.c | 42 ++++++++++++++++++++
 tools/testing/selftests/runtime/branch.c     | 19 +++++++++
 tools/testing/selftests/runtime/loop.bpf.c   | 37 +++++++++++++++++
 tools/testing/selftests/runtime/loop.c       | 19 +++++++++
 tools/testing/selftests/runtime/simple.bpf.c | 35 ++++++++++++++++
 tools/testing/selftests/runtime/simple.c     | 19 +++++++++
 7 files changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/runtime/Makefile
 create mode 100644 tools/testing/selftests/runtime/branch.bpf.c
 create mode 100644 tools/testing/selftests/runtime/branch.c
 create mode 100644 tools/testing/selftests/runtime/loop.bpf.c
 create mode 100644 tools/testing/selftests/runtime/loop.c
 create mode 100644 tools/testing/selftests/runtime/simple.bpf.c
 create mode 100644 tools/testing/selftests/runtime/simple.c

diff --git a/tools/testing/selftests/runtime/Makefile b/tools/testing/selftests/runtime/Makefile
new file mode 100644
index 000000000000..d03133786a26
--- /dev/null
+++ b/tools/testing/selftests/runtime/Makefile
@@ -0,0 +1,20 @@
+targets = simple branch loop
+
+all: $(targets)
+
+vmlinux.h:
+	bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
+
+%.bpf.o: %.bpf.c vmlinux.h
+	clang -O2 -g -target bpf -c $*.bpf.c -o $*.bpf.o
+
+%.skel.h: %.bpf.o
+	bpftool gen skeleton $*.bpf.o > $*.skel.h
+
+$(targets): %: %.c %.skel.h
+	clang $< -lelf -lbpf -o $@
+
+clean:
+	rm -f *.o *.skel.h vmlinux.h $(targets)
+
+.SECONDARY:
diff --git a/tools/testing/selftests/runtime/branch.bpf.c b/tools/testing/selftests/runtime/branch.bpf.c
new file mode 100644
index 000000000000..87697151299c
--- /dev/null
+++ b/tools/testing/selftests/runtime/branch.bpf.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+
+int test = 5;
+
+SEC("syscall")
+int test_branch(void *arg)
+{
+	struct task_struct *task1;
+
+	task1 = bpf_task_from_pid(1);
+
+	if (test > 2) {
+		struct task_struct *task2;
+
+		task2 = bpf_task_from_pid(2);
+		if (task2)
+			bpf_task_release(task2);
+	}
+
+	if (test < 2) {
+		struct task_struct *task3;
+
+		task3 = bpf_task_from_pid(3);
+		if (task3)
+			bpf_task_release(task3);
+	}
+
+	if (task1)
+		bpf_task_release(task1);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/runtime/branch.c b/tools/testing/selftests/runtime/branch.c
new file mode 100644
index 000000000000..3592e14f1f75
--- /dev/null
+++ b/tools/testing/selftests/runtime/branch.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include "branch.skel.h"
+
+int main(int argc, char **argv)
+{
+	struct branch_bpf *skel;
+	int err, prog_fd;
+
+	skel = branch_bpf__open_and_load();
+	prog_fd = bpf_program__fd(skel->progs.test_branch);
+	err = bpf_prog_test_run_opts(prog_fd, NULL);
+
+	branch_bpf__destroy(skel);
+	return err;
+}
diff --git a/tools/testing/selftests/runtime/loop.bpf.c b/tools/testing/selftests/runtime/loop.bpf.c
new file mode 100644
index 000000000000..2b49ec9e1058
--- /dev/null
+++ b/tools/testing/selftests/runtime/loop.bpf.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+
+SEC("syscall")
+int test_loop(void *arg)
+{
+	struct task_struct *task_loop;
+	struct task_struct *task1;
+	int *v;
+
+	task1 = bpf_task_from_pid(1);
+
+	struct bpf_iter_num it;
+
+	bpf_iter_num_new(&it, 1, 3);
+	while ((v = bpf_iter_num_next(&it))) {
+		task_loop = bpf_task_from_pid(*v);
+		if (task_loop)
+			bpf_task_release(task_loop);
+	}
+
+	bpf_iter_num_destroy(&it);
+
+	if (task1)
+		bpf_task_release(task1);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/runtime/loop.c b/tools/testing/selftests/runtime/loop.c
new file mode 100644
index 000000000000..bde83e5595e4
--- /dev/null
+++ b/tools/testing/selftests/runtime/loop.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include "loop.skel.h"
+
+int main(int argc, char **argv)
+{
+	struct loop_bpf *skel;
+	int err, prog_fd;
+
+	skel = loop_bpf__open_and_load();
+	prog_fd = bpf_program__fd(skel->progs.test_loop);
+	err = bpf_prog_test_run_opts(prog_fd, NULL);
+
+	loop_bpf__destroy(skel);
+	return err;
+}
diff --git a/tools/testing/selftests/runtime/simple.bpf.c b/tools/testing/selftests/runtime/simple.bpf.c
new file mode 100644
index 000000000000..ad7989ebb7d4
--- /dev/null
+++ b/tools/testing/selftests/runtime/simple.bpf.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+
+struct bpf_cpumask *bpf_cpumask_create(void) __ksym;
+void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym;
+
+SEC("syscall")
+int test_simple(void *arg)
+{
+	struct task_struct *task;
+	struct bpf_cpumask *cpumask;
+
+	task = bpf_task_from_pid(1);
+	if (!task)
+		return 0;
+
+	cpumask = bpf_cpumask_create();
+	if (!cpumask)
+		goto error_cpumask;
+
+	bpf_cpumask_release(cpumask);
+error_cpumask:
+	bpf_task_release(task);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/runtime/simple.c b/tools/testing/selftests/runtime/simple.c
new file mode 100644
index 000000000000..e65959aac89b
--- /dev/null
+++ b/tools/testing/selftests/runtime/simple.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include "simple.skel.h"
+
+int main(int argc, char **argv)
+{
+	struct simple_bpf *skel;
+	int err, prog_fd;
+
+	skel = simple_bpf__open_and_load();
+	prog_fd = bpf_program__fd(skel->progs.test_simple);
+	err = bpf_prog_test_run_opts(prog_fd, NULL);
+
+	simple_bpf__destroy(skel);
+	return err;
+}
-- 
2.39.5



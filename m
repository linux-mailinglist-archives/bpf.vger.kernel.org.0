Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDE20EE81
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgF3GbL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 02:31:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729984AbgF3GbL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 02:31:11 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U6QPlo009586
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 23:31:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dENfKnXYbsHOcz7F13wDWYONmbIkZMqgoSy0hLH3dwo=;
 b=NQhkvzIHST932dCK24rTxe6sNaVgdIyOTQYbJdF5qS//0TTczMfcXAbqW5KYOuz8J01H
 ozB/z+Zcy3x0lnNBjkHepVpzTP7/fvaXiB9IdRj4ddCRC2uPF5mA9fW4JYyM60IvEOv2
 rWt7gOitxpfU6nQ4dPVuDolLCCFSWPQ1K4o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31xpcnrc99-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 23:31:10 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 23:31:09 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1559462E51C7; Mon, 29 Jun 2020 23:28:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@chromium.org>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 bpf-next 1/4] perf: expose get/put_callchain_entry()
Date:   Mon, 29 Jun 2020 23:28:43 -0700
Message-ID: <20200630062846.664389-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630062846.664389-1-songliubraving@fb.com>
References: <20200630062846.664389-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 cotscore=-2147483648 suspectscore=8
 priorityscore=1501 mlxlogscore=999 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sanitize and expose get/put_callchain_entry(). This would be used by bpf
stack map.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h |  2 ++
 kernel/events/callchain.c  | 13 ++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b4bb32082342c..00ab5efa38334 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1244,6 +1244,8 @@ get_perf_callchain(struct pt_regs *regs, u32 init_n=
r, bool kernel, bool user,
 extern struct perf_callchain_entry *perf_callchain(struct perf_event *ev=
ent, struct pt_regs *regs);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
+extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
+extern void put_callchain_entry(int rctx);
=20
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 334d48b16c36d..c6ce894e4ce94 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -149,7 +149,7 @@ void put_callchain_buffers(void)
 	}
 }
=20
-static struct perf_callchain_entry *get_callchain_entry(int *rctx)
+struct perf_callchain_entry *get_callchain_entry(int *rctx)
 {
 	int cpu;
 	struct callchain_cpus_entries *entries;
@@ -159,8 +159,10 @@ static struct perf_callchain_entry *get_callchain_en=
try(int *rctx)
 		return NULL;
=20
 	entries =3D rcu_dereference(callchain_cpus_entries);
-	if (!entries)
+	if (!entries) {
+		put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
 		return NULL;
+	}
=20
 	cpu =3D smp_processor_id();
=20
@@ -168,7 +170,7 @@ static struct perf_callchain_entry *get_callchain_ent=
ry(int *rctx)
 		(*rctx * perf_callchain_entry__sizeof()));
 }
=20
-static void
+void
 put_callchain_entry(int rctx)
 {
 	put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
@@ -183,11 +185,8 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr=
, bool kernel, bool user,
 	int rctx;
=20
 	entry =3D get_callchain_entry(&rctx);
-	if (rctx =3D=3D -1)
-		return NULL;
-
 	if (!entry)
-		goto exit_put;
+		return NULL;
=20
 	ctx.entry     =3D entry;
 	ctx.max_stack =3D max_stack;
--=20
2.24.1


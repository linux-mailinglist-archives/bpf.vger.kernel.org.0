Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA03FBE6E
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 23:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbhH3VmM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 17:42:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6858 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237296AbhH3VmL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 17:42:11 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ULe5oH016355
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:41:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LZUtTQgJNp9GbfflicU67M/kon4XzUwGfZ6kGY8+dkM=;
 b=Oq0Ai01KcV4hI+OZmWMQSzvF+lmZ0k+n4pcushF53aNQgfWe3GMyAsOa51Tu9e0rUR7k
 aTTp0byesHzU61rpsuF5dzJ3Qs8RsDTrFQgY72SI6VQJumRaAjOW6ehP3HUHl8ad7Qxc
 joH9OPuBgKETt5t/68qj9DfbFYnRyhHfvNw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aryp93ckv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:41:17 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 30 Aug 2021 14:41:16 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1FFECF14680F; Mon, 30 Aug 2021 14:41:12 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v3 bpf-next 1/3] perf: enable branch record for software events
Date:   Mon, 30 Aug 2021 14:41:04 -0700
Message-ID: <20210830214106.4142056-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210830214106.4142056-1-songliubraving@fb.com>
References: <20210830214106.4142056-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: dd04PJdq0RuA668cRU8rG3eEpsZe6C19
X-Proofpoint-ORIG-GUID: dd04PJdq0RuA668cRU8rG3eEpsZe6C19
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_06:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The typical way to access branch record (e.g. Intel LBR) is via hardware
perf_event. For CPUs with FREEZE_LBRS_ON_PMI support, PMI could capture
reliable LBR. On the other hand, LBR could also be useful in non-PMI
scenario. For example, in kretprobe or bpf fexit program, LBR could
provide a lot of information on what happened with the function. Add API
to use branch record for software use.

Note that, when the software event triggers, it is necessary to stop the
branch record hardware asap. Therefore, static_call is used to remove som=
e
branch instructions in this process.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++--
 include/linux/perf_event.h   | 24 ++++++++++++++++++++++++
 kernel/events/core.c         |  3 +++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ac6fd2dabf6a2..d28d0e12c112c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2155,9 +2155,9 @@ static void __intel_pmu_disable_all(void)
=20
 static void intel_pmu_disable_all(void)
 {
+	intel_pmu_lbr_disable_all();
 	__intel_pmu_disable_all();
 	intel_pmu_pebs_disable_all();
-	intel_pmu_lbr_disable_all();
 }
=20
 static void __intel_pmu_enable_all(int added, bool pmi)
@@ -2186,6 +2186,20 @@ static void intel_pmu_enable_all(int added)
 	__intel_pmu_enable_all(added, false);
 }
=20
+static int
+intel_pmu_snapshot_branch_stack(struct perf_branch_snapshot *br_snapshot=
)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+
+	intel_pmu_disable_all();
+	intel_pmu_lbr_read();
+	memcpy(br_snapshot->entries, cpuc->lbr_entries,
+	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
+	br_snapshot->nr =3D x86_pmu.lbr_nr;
+	intel_pmu_enable_all(0);
+	return 0;
+}
+
 /*
  * Workaround for:
  *   Intel Errata AAK100 (model 26)
@@ -6283,9 +6297,15 @@ __init int intel_pmu_init(void)
 			x86_pmu.lbr_nr =3D 0;
 	}
=20
-	if (x86_pmu.lbr_nr)
+	if (x86_pmu.lbr_nr) {
 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
=20
+		/* only support branch_stack snapshot for perfmon >=3D v2 */
+		if (x86_pmu.disable_all =3D=3D intel_pmu_disable_all)
+			static_call_update(perf_snapshot_branch_stack,
+					   intel_pmu_snapshot_branch_stack);
+	}
+
 	intel_pmu_check_extra_regs(x86_pmu.extra_regs);
=20
 	/* Support full width counters using alternative MSR range */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fe156a8170aa3..1f42e91668024 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -57,6 +57,7 @@ struct perf_guest_info_callbacks {
 #include <linux/cgroup.h>
 #include <linux/refcount.h>
 #include <linux/security.h>
+#include <linux/static_call.h>
 #include <asm/local.h>
=20
 struct perf_callchain_entry {
@@ -1612,4 +1613,27 @@ extern void __weak arch_perf_update_userpage(struc=
t perf_event *event,
 extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned=
 long addr);
 #endif
=20
+/*
+ * Snapshot branch stack on software events.
+ *
+ * Branch stack can be very useful in understanding software events. For
+ * example, when a long function, e.g. sys_perf_event_open, returns an
+ * errno, it is not obvious why the function failed. Branch stack could
+ * provide very helpful information in this type of scenarios.
+ *
+ * On software event, it is necessary to stop the hardware branch record=
er
+ * fast. Otherwise, the hardware register/buffer will be flushed with
+ * entries af the triggering event. Therefore, static call is used to
+ * stop the hardware recorder.
+ */
+#define MAX_BRANCH_SNAPSHOT 32
+
+struct perf_branch_snapshot {
+	unsigned int nr;
+	struct perf_branch_entry entries[MAX_BRANCH_SNAPSHOT];
+};
+
+typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_snapshot *=
);
+DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_sta=
ck_t);
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 011cc5069b7ba..22807864e913b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13437,3 +13437,6 @@ struct cgroup_subsys perf_event_cgrp_subsys =3D {
 	.threaded	=3D true,
 };
 #endif /* CONFIG_CGROUP_PERF */
+
+DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack,
+			perf_snapshot_branch_stack_t);
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6C402FC0
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 22:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346704AbhIGUaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 16:30:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60688 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346504AbhIGUaX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 16:30:23 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187KPdiK030069
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 13:29:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=B1tqW/iynwQ5qq9eZmv7rxLu0OH/S+KFbWjhwaAhsck=;
 b=kfP7CuC+zo2HKjj4AeYV1H071oywfEhLvrurDK/ivNufDHaOrUx50oFGMM2oBhau3jwf
 J1J1BMlN3aybqe3tX9Ks0McRlZv0H6h3/4rMU9rH2lBs2xBD0ftrkIxv4vtmxD6R1vEQ
 ScSnbTyQt6TyhF4+aj+PwptYwrV1eHSHakg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcmw10tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 13:29:16 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 13:28:38 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2EF9B1027A612; Tue,  7 Sep 2021 13:28:31 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v6 bpf-next 1/3] perf: enable branch record for software events
Date:   Tue, 7 Sep 2021 13:28:00 -0700
Message-ID: <20210907202802.3675104-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907202802.3675104-1-songliubraving@fb.com>
References: <20210907202802.3675104-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: nVxv-QBKGrNMsHGqzrZUcsh1eWyQCJ5F
X-Proofpoint-GUID: nVxv-QBKGrNMsHGqzrZUcsh1eWyQCJ5F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_07:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070130
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

Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/events/intel/core.c | 29 ++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c   |  8 --------
 arch/x86/events/perf_event.h | 10 ++++++++--
 include/linux/perf_event.h   | 23 +++++++++++++++++++++++
 kernel/events/core.c         |  2 ++
 5 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7011e87be6d03..2e318fb8d649b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2143,7 +2143,7 @@ static __initconst const u64 knl_hw_cache_extra_reg=
s
  * However, there are some cases which may change PEBS status, e.g. PMI
  * throttle. The PEBS_ENABLE should be updated where the status changes.
  */
-static void __intel_pmu_disable_all(void)
+static __always_inline void __intel_pmu_disable_all(void)
 {
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
=20
@@ -2153,7 +2153,7 @@ static void __intel_pmu_disable_all(void)
 		intel_pmu_disable_bts();
 }
=20
-static void intel_pmu_disable_all(void)
+static __always_inline void intel_pmu_disable_all(void)
 {
 	__intel_pmu_disable_all();
 	intel_pmu_pebs_disable_all();
@@ -2186,6 +2186,23 @@ static void intel_pmu_enable_all(int added)
 	__intel_pmu_enable_all(added, false);
 }
=20
+static int
+intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsig=
ned int cnt)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	intel_pmu_disable_all();
+	intel_pmu_lbr_read();
+	cnt =3D min_t(unsigned int, cnt, x86_pmu.lbr_nr);
+
+	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * c=
nt);
+	intel_pmu_enable_all(0);
+	local_irq_restore(flags);
+	return cnt;
+}
+
 /*
  * Workaround for:
  *   Intel Errata AAK100 (model 26)
@@ -6283,9 +6300,15 @@ __init int intel_pmu_init(void)
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
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8647713276a73..8a832986578a9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1296,14 +1296,6 @@ void intel_pmu_pebs_enable_all(void)
 		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 }
=20
-void intel_pmu_pebs_disable_all(void)
-{
-	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
-
-	if (cpuc->pebs_enabled)
-		wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
-}
-
 static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e5..171abbb359fe5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1240,6 +1240,14 @@ static inline bool intel_pmu_has_bts(struct perf_e=
vent *event)
 	return intel_pmu_has_bts_period(event, hwc->sample_period);
 }
=20
+static __always_inline void intel_pmu_pebs_disable_all(void)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+
+	if (cpuc->pebs_enabled)
+		wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
+}
+
 int intel_pmu_save_and_restart(struct perf_event *event);
=20
 struct event_constraint *
@@ -1314,8 +1322,6 @@ void intel_pmu_pebs_disable(struct perf_event *even=
t);
=20
 void intel_pmu_pebs_enable_all(void);
=20
-void intel_pmu_pebs_disable_all(void);
-
 void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sche=
d_in);
=20
 void intel_pmu_auto_reload_read(struct perf_event *event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fe156a8170aa3..0cbc5dfe11102 100644
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
@@ -1612,4 +1613,26 @@ extern void __weak arch_perf_update_userpage(struc=
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
+ * entries of the triggering event. Therefore, static call is used to
+ * stop the hardware recorder.
+ */
+
+/*
+ * cnt is the number of entries allocated for entries.
+ * Return number of entries copied to .
+ */
+typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *ent=
ries,
+					   unsigned int cnt);
+DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_sta=
ck_t);
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 744e8726c5b2f..349f80aa9e7d8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13435,3 +13435,5 @@ struct cgroup_subsys perf_event_cgrp_subsys =3D {
 	.threaded	=3D true,
 };
 #endif /* CONFIG_CGROUP_PERF */
+
+DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack, perf_snapshot_branch=
_stack_t);
--=20
2.30.2


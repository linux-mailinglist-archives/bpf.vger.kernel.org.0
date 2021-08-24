Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA43F57D2
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 08:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhHXGC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 02:02:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14276 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234375AbhHXGC5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Aug 2021 02:02:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17O5xsLo019191
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 23:02:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bwhi0VIoog24LMnJMGGhnnA/5LgkIcxAbDFf+Jh61oE=;
 b=WMuomTlKKABHVO45hBCbXITNzYIiK+bl43Z5fe3jEOC+ZRvijqmQyKPConI5EVzzOsvC
 wR/PZu50PC091+ffEgYSASAGJv8IVHvJ/HOSWtImvVfBjm00X8sr7OhptSh+1FU7Xw5C
 sEbjmnFPVfYjo6g38YdeNiz9UAVoIUcpEGA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3amdb74xqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 23:02:12 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 23:02:10 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A860FDDDF77A; Mon, 23 Aug 2021 23:02:09 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next 1/3] perf: enable branch record for software events
Date:   Mon, 23 Aug 2021 23:01:55 -0700
Message-ID: <20210824060157.3889139-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824060157.3889139-1-songliubraving@fb.com>
References: <20210824060157.3889139-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 70Vxnu2RiEGnqGAl08295dpnUwDb22-z
X-Proofpoint-ORIG-GUID: 70Vxnu2RiEGnqGAl08295dpnUwDb22-z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_01:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=922 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240039
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
 arch/x86/events/intel/core.c |  5 ++++-
 arch/x86/events/intel/lbr.c  | 12 ++++++++++++
 arch/x86/events/perf_event.h |  2 ++
 include/linux/perf_event.h   | 33 +++++++++++++++++++++++++++++++++
 kernel/events/core.c         | 28 ++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ac6fd2dabf6a2..a29649e7241cc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6283,8 +6283,11 @@ __init int intel_pmu_init(void)
 			x86_pmu.lbr_nr =3D 0;
 	}
=20
-	if (x86_pmu.lbr_nr)
+	if (x86_pmu.lbr_nr) {
 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
+		static_call_update(perf_snapshot_branch_stack,
+				   intel_pmu_snapshot_branch_stack);
+	}
=20
 	intel_pmu_check_extra_regs(x86_pmu.extra_regs);
=20
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 9e6d6eaeb4cb6..b73b444cf229d 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1862,3 +1862,15 @@ EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 struct event_constraint vlbr_constraint =3D
 	__EVENT_CONSTRAINT(INTEL_FIXED_VLBR_EVENT, (1ULL << INTEL_PMC_IDX_FIXED=
_VLBR),
 			  FIXED_EVENT_FLAGS, 1, 0, PERF_X86_EVENT_LBR_SELECT);
+
+void intel_pmu_snapshot_branch_stack(void)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+
+	intel_pmu_lbr_disable_all();
+	intel_pmu_lbr_read();
+	memcpy(this_cpu_ptr(&perf_branch_snapshot_entries), cpuc->lbr_entries,
+	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
+	*this_cpu_ptr(&perf_branch_snapshot_size) =3D x86_pmu.lbr_nr;
+	intel_pmu_lbr_enable_all(false);
+}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e5..5262083f4e13b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1379,6 +1379,8 @@ void intel_pmu_pebs_data_source_skl(bool pmem);
=20
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
=20
+void intel_pmu_snapshot_branch_stack(void);
+
 void intel_pt_interrupt(void);
=20
 int intel_bts_interrupt(void);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fe156a8170aa3..7cd2af7c5eda6 100644
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
@@ -1612,4 +1613,36 @@ extern void __weak arch_perf_update_userpage(struc=
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
+ *
+ * To use the snapshot:
+ * 1) After the event triggers, call perf_snapshot_branch_stack asap;
+ * 2) On the same cpu, access the snapshot with perf_read_branch_snapsho=
t;
+ */
+#define MAX_BRANCH_SNAPSHOT 32
+DECLARE_PER_CPU(struct perf_branch_entry,
+		perf_branch_snapshot_entries[MAX_BRANCH_SNAPSHOT]);
+DECLARE_PER_CPU(int, perf_branch_snapshot_size);
+
+void perf_default_snapshot_branch_stack(void);
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+DECLARE_STATIC_CALL(perf_snapshot_branch_stack,
+		    perf_default_snapshot_branch_stack);
+#else
+extern void (*perf_snapshot_branch_stack)(void);
+#endif
+
+int perf_read_branch_snapshot(void *buf, size_t len);
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 011cc5069b7ba..b42cc20451709 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13437,3 +13437,31 @@ struct cgroup_subsys perf_event_cgrp_subsys =3D =
{
 	.threaded	=3D true,
 };
 #endif /* CONFIG_CGROUP_PERF */
+
+DEFINE_PER_CPU(struct perf_branch_entry,
+	       perf_branch_snapshot_entries[MAX_BRANCH_SNAPSHOT]);
+DEFINE_PER_CPU(int, perf_branch_snapshot_size);
+
+void perf_default_snapshot_branch_stack(void)
+{
+	*this_cpu_ptr(&perf_branch_snapshot_size) =3D 0;
+}
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+DEFINE_STATIC_CALL(perf_snapshot_branch_stack,
+		   perf_default_snapshot_branch_stack);
+#else
+void (*perf_snapshot_branch_stack)(void) =3D perf_default_snapshot_branc=
h_stack;
+#endif
+
+int perf_read_branch_snapshot(void *buf, size_t len)
+{
+	int cnt;
+
+	memcpy(buf, *this_cpu_ptr(&perf_branch_snapshot_entries),
+	       min_t(u32, (u32)len,
+		     sizeof(struct perf_branch_entry) * MAX_BRANCH_SNAPSHOT));
+	cnt =3D  *this_cpu_ptr(&perf_branch_snapshot_size);
+
+	return (cnt > 0) ? cnt : -EOPNOTSUPP;
+}
--=20
2.30.2


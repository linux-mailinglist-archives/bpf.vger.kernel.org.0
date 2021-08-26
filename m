Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B8D3F908B
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbhHZWOL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 18:14:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27776 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230400AbhHZWOL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 18:14:11 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17QMAXlH003590
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 15:13:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=XJe7pWNFHhVBR8nzVFLX3GIlYlAQPrmirhupC5SObi8=;
 b=WlLGQ3oXHjyDGA4VSZBe+lpcpa8WofL4O7Mj6K1/7QYn/sWyNaGfPf/7GKKsx+iJ0djK
 CG/4UJ/mqRB20SiqkAWFVrtiUx4vbmYePF1+Wssor6RuwzHDr2djjgEbdSZDhCLrsBmS
 AORSqe/WesFghVB+GVUuOOh2NSuvOuvQyLQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3apc9s36xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 15:13:22 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 26 Aug 2021 15:13:21 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 77C2EE2EC444; Thu, 26 Aug 2021 15:13:15 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 1/3] perf: enable branch record for software events
Date:   Thu, 26 Aug 2021 15:13:04 -0700
Message-ID: <20210826221306.2280066-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826221306.2280066-1-songliubraving@fb.com>
References: <20210826221306.2280066-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GRdWz5eMCS2-EZavtII2ekfsDUBusepf
X-Proofpoint-GUID: GRdWz5eMCS2-EZavtII2ekfsDUBusepf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_05:2021-08-26,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=779 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260124
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
Some data on intel_pmu_lbr_disable_all() and perf_pmu_disable().

With this patch, when fexit program triggers, intel_pmu_lbr_disable_all i=
s
used to stop the LBR, and the LBR is stopped after 6 extra branch records
(see the full trace below). If we replace intel_pmu_lbr_disable_all in
intel_pmu_snapshot_branch_stack() with perf_pmu_disable, the LBR is stopp=
ed
after 19 extra branch records. This is still acceptable for systems with =
32
LBR entries. But for systems with fewer entries, all the entries before
fexit are flushed. Therefore, I suggest we take the short cut and stop LB=
R
asap.


LBR snapshot captured when we use intel_pmu_lbr_disable_all():

ID: 0 from intel_pmu_lbr_disable_all.part.10+37 to intel_pmu_lbr_disable_=
all.part.10+72
ID: 1 from intel_pmu_lbr_disable_all.part.10+33 to intel_pmu_lbr_disable_=
all.part.10+37
ID: 2 from intel_pmu_snapshot_branch_stack+51 to intel_pmu_lbr_disable_al=
l.part.10+0
ID: 3 from __bpf_prog_enter+53 to intel_pmu_snapshot_branch_stack+0
ID: 4 from __bpf_prog_enter+8 to __bpf_prog_enter+38
ID: 5 from __brk_limit+473903158 to __bpf_prog_enter+0
ID: 6 from bpf_fexit_loop_test1+22 to __brk_limit+473903139
ID: 7 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
ID: 8 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
ID: 9 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13


LBR snapshot captured when we use perf_pmu_disable():

ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
ID: 2 from intel_pmu_disable_all+15 to intel_pmu_lbr_disable_all+0
ID: 3 from intel_pmu_pebs_disable_all+30 to intel_pmu_disable_all+15
ID: 4 from intel_pmu_disable_all+10 to intel_pmu_pebs_disable_all+0
ID: 5 from __intel_pmu_disable_all+49 to intel_pmu_disable_all+10
ID: 6 from intel_pmu_disable_all+5 to __intel_pmu_disable_all+0
ID: 7 from x86_pmu_disable+61 to intel_pmu_disable_all+0
ID: 8 from x86_pmu_disable+38 to x86_pmu_disable+41
ID: 9 from __x86_indirect_thunk_rax+16 to x86_pmu_disable+0
ID: 10 from __x86_indirect_thunk_rax+0 to __x86_indirect_thunk_rax+12
ID: 11 from perf_pmu_disable.part.122+4 to __x86_indirect_thunk_rax+0
ID: 12 from perf_pmu_disable+23 to perf_pmu_disable.part.122+0
ID: 13 from intel_pmu_snapshot_branch_stack+45 to perf_pmu_disable+0
ID: 14 from x86_get_pmu+35 to intel_pmu_snapshot_branch_stack+39
ID: 15 from intel_pmu_snapshot_branch_stack+34 to x86_get_pmu+0
ID: 16 from __bpf_prog_enter+53 to intel_pmu_snapshot_branch_stack+0
ID: 17 from __bpf_prog_enter+8 to __bpf_prog_enter+38
ID: 18 from __brk_limit+478056502 to __bpf_prog_enter+0
ID: 19 from bpf_fexit_loop_test1+22 to __brk_limit+478056483
ID: 20 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
ID: 21 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13


---
 arch/x86/events/intel/core.c |  5 ++++-
 arch/x86/events/intel/lbr.c  | 13 +++++++++++++
 arch/x86/events/perf_event.h |  2 ++
 include/linux/perf_event.h   | 29 +++++++++++++++++++++++++++++
 kernel/events/core.c         |  3 +++
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ac6fd2dabf6a2..a29649e7241cc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6283,8 +6283,11 @@ __init int intel_pmu_init(void)
 			x86_pmu.lbr_nr =3D 0;
 	}

-	if (x86_pmu.lbr_nr)
+	if (x86_pmu.lbr_nr) {
 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
+		static_call_update(perf_snapshot_branch_stack,
+				   intel_pmu_snapshot_branch_stack);
+	}

 	intel_pmu_check_extra_regs(x86_pmu.extra_regs);

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 9e6d6eaeb4cb6..7d4fe1d6e79ff 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1862,3 +1862,16 @@ EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 struct event_constraint vlbr_constraint =3D
 	__EVENT_CONSTRAINT(INTEL_FIXED_VLBR_EVENT, (1ULL << INTEL_PMC_IDX_FIXED=
_VLBR),
 			  FIXED_EVENT_FLAGS, 1, 0, PERF_X86_EVENT_LBR_SELECT);
+
+int intel_pmu_snapshot_branch_stack(struct perf_branch_snapshot *br_snap=
shot)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+
+	intel_pmu_lbr_disable_all();
+	intel_pmu_lbr_read();
+	memcpy(br_snapshot->entries, cpuc->lbr_entries,
+	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
+	br_snapshot->nr =3D x86_pmu.lbr_nr;
+	intel_pmu_lbr_enable_all(false);
+	return 0;
+}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e5..0f4ca25d10bf1 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1379,6 +1379,8 @@ void intel_pmu_pebs_data_source_skl(bool pmem);

 int intel_pmu_setup_lbr_filter(struct perf_event *event);

+int intel_pmu_snapshot_branch_stack(struct perf_branch_snapshot *br_snap=
shot);
+
 void intel_pt_interrupt(void);

 int intel_bts_interrupt(void);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fe156a8170aa3..f029eb4b2ce40 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -57,6 +57,7 @@ struct perf_guest_info_callbacks {
 #include <linux/cgroup.h>
 #include <linux/refcount.h>
 #include <linux/security.h>
+#include <linux/static_call.h>
 #include <asm/local.h>

 struct perf_callchain_entry {
@@ -1612,4 +1613,32 @@ extern void __weak arch_perf_update_userpage(struc=
t perf_event *event,
 extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned=
 long addr);
 #endif

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
+
+struct perf_branch_snapshot {
+	unsigned int nr;
+	struct perf_branch_entry entries[MAX_BRANCH_SNAPSHOT];
+};
+
+int dummy_perf_snapshot_branch_stack(struct perf_branch_snapshot *br_sna=
pshot);
+
+DECLARE_STATIC_CALL(perf_snapshot_branch_stack, dummy_perf_snapshot_bran=
ch_stack);
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 011cc5069b7ba..c53fe90e630ac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13437,3 +13437,6 @@ struct cgroup_subsys perf_event_cgrp_subsys =3D {
 	.threaded	=3D true,
 };
 #endif /* CONFIG_CGROUP_PERF */
+
+DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack,
+			dummy_perf_snapshot_branch_stack);
--
2.30.2

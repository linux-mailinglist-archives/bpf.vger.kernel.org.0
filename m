Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95734513A72
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiD1Q5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiD1Q5U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:57:20 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C816EAAB6D
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:04 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SG7bkf026710
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ieT8Tf+QwreVVBIPB3fn8rGvo6gr38a6dDeW9euEhFw=;
 b=mZVwZ5ImfbFT8qU2hZFflt6ZYilb4wHMgLGK15j9sHgyjZ+6bXd8ygYvyRh8z/t9n3J1
 OHj3BM4UK0hiWGUjZfjpcAN2RaT4Np+DExaXmB04cNXY0FfuSjGp+6gPx82RPMqlMx87
 5PWdIzwfHAE3n7S6S4b2cxlpeuZmqut20Wk= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqm5r40r4-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L64wkK2lRqokQaXT0zE6vXJN7JXA++M8SEi+Z9GMywi2JCdacIZCtN5FCsh6rV9zP8YZdzBFqW8X8JWRrngIHpdVpUKpZoVWT/Jrj+9gAN3KyqJ0ZOjhB+DdBE6iOneSX3awFgqSs9/WKEWyTOixc7gKDRC8y4P4eZnaVQa/a7jV1Ba/Ta+m4O9dz4ogILQcQ5SkDYa07rE4SzFPWJQMS8zsZ5GCQ+BorLIuo4B8uNbV8P/SCtU7SgWVB1SIMpI3S4TXGPw6Ykskav8bEvI/ToENtb5PcT2zdHj9WDURKC79NpzLbtD/brYgDOT+cpyi7ccDEMw5mVKSS8CGgeMqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieT8Tf+QwreVVBIPB3fn8rGvo6gr38a6dDeW9euEhFw=;
 b=bgoxhbaqDPOsGeVUupEQ+9qIx7fXp7skPCoi3G3oPDtgE+SIBhQOLwTOsSfPoTIFhYzaFT1vaS67e22vTqfb7abaqDzi/lfsn2Gp2+/PVs8jJPlt9t4WqggYzMb2Eu6ghJCCz7xwG3YxQ2KfbHpY3cpZkBsye1sRM4uucGChps4Gwhl5FXQPO2TUo2QVBgtWjQy9tC0kG7ccB5l2fyfpfzPYjgChDOtGcuFCp/OS3kCgJNGBcXkWhRFthwUd0/EjMKYnijZ9x5S9Uyzv7rglKCtCbKuiInIZk1+yVnzmBqoy65l9ODLt8eF6ZLS6gyqUq2zK1B01krd5/3E7uA5vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 16:54:00 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 16:54:00 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>
Subject: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by chaining
 tasks and normal rcu
Thread-Topic: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by
 chaining tasks and normal rcu
Thread-Index: AQHYWyCObZ0QBOT6hkONP5DC6DKxDw==
Date:   Thu, 28 Apr 2022 16:54:00 +0000
Message-ID: <972caeb1e9338721bb719b118e0e40705f860f50.1651103126.git.delyank@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
In-Reply-To: <cover.1651103126.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe1f5f15-d701-4064-1984-08da2937b155
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4615F4A89023F32A4C82AC04C1FD9@SJ0PR15MB4615.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSE3J3b8D8DJjpsEuVPWJmE9rYdh3WCXCGau1REZtkLcWavax7hsShifsmJtzTxjK3hqseqvTWNCTNVjR9YXXbA/Ialn0bZs8ccDsYVW6cdHrk7x9M3dtfTRugxZ6dMD4WzyAnWIvWhfF7UoNPrkrMwigCTQI7SNaf92fSK64n9WIf7VSJWrI+O+CikbrbiEOLbf0UvY1dHm9QpagdAuCIQURSYKkVw9IFUkcpzmFx20OGbmzgtkWQGb5Akk9bpF7AChfrs5AKZTJqYbuXAWHPKaWzgoGd6ueLzkGKIzDUi9vZtR9Adtxt6Z/jgUAjcIxp4wfw7v0vAU+Gsj3+H8SZPhD+XrlcbBjfaQz4EMfkGgaF6sP33C0+L6odLjR+N1+x70/Mt2dtvxMZu3JceHc+jmDGnewWz4ONbtHIJaODMYOJKmrVs8X/yO9IdiCJdfsZVh7MO7by0fuFhkSXSySDHUfvA9zfEsgrkVMRkle7FeBcVl0yg8+2I1CIwS+45KsZkKGtifSKGO6CQTNcu5Pfqhu1/gDmq9eOmPMHWb5PzuGkBkE/3YpZV6khcqfXuV+1lCk4dRiDxn0x0hdJ/svfrdnFbtgaqKW59qfuhkBf7E5cldJ3JzfNsRMZj2HKBgP8x8jXAh7Ib/XuZW+wMdNGF0Tog75juSApWZwqkRNuw5wQMH8i7g0uiYNfnuDG25Qf9Y+gxnByOz8fyzURBEZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(36756003)(38070700005)(86362001)(316002)(122000001)(5660300002)(66946007)(4326008)(8936002)(6506007)(66556008)(76116006)(8676002)(64756008)(66446008)(83380400001)(66476007)(6486002)(71200400001)(186003)(26005)(6512007)(110136005)(2616005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FPgY/HdsxopKW8EHzeRI82ta5HgZQeBe3u5yLKQwcFLC0kYOLKA7akO3N1?=
 =?iso-8859-1?Q?cQwNmtaWWISIeaWldiXDqi2CFB4JDjIlvMyk4N42a9cxfWtlwuX3PnMTNW?=
 =?iso-8859-1?Q?J4wim+5H3WU0/oP4dYZwyYaMDe/BxG1KpCkcEoRupkfMOdAa/vSh8okhDy?=
 =?iso-8859-1?Q?kbdIMnTO78sGBMv7DNOGFM4US45bpdSuRnQ5xpgLta64UrgEl7WkWaE0gi?=
 =?iso-8859-1?Q?QVKXISkCnERBE/Drlzmq/KFD851LtVrKXkFuMEzWa9y72fXWvjq3aqEjiI?=
 =?iso-8859-1?Q?8uvypAjwBHRGwDnP3m4Gvou4BtAU4FFNh0TofMXt+rztmnPmP8rSu1V6KZ?=
 =?iso-8859-1?Q?rhoHvw1z6efY9s04eDu2JuRu/a7hQ9lWzFUJqT5VGNTni88WYoouA2jgBF?=
 =?iso-8859-1?Q?bHCx4EvcNy0CBvZ//lekTGuw9l1LBWTNjNsEVu3N6syQy9E0TMeKUefK6w?=
 =?iso-8859-1?Q?2QARqvOUOtEcifZ1oja5S1+5L9u+tYsPTudzfuZNNxotlGJe7Pm8FpfkBE?=
 =?iso-8859-1?Q?ub9+HKR+TJut5v6gWGTyD6vV0kpRiUrmW93d/zUZLNURjRr9kndrKtURGw?=
 =?iso-8859-1?Q?0SOj+Fe/DaYhyGgl3+M7goi9lu7hFcrsCXy8Sno8tfKH6Bu7rJtnRJD1A5?=
 =?iso-8859-1?Q?dabZ3pq66MPlQ/b0FZcwg8ey/DwfiFXNF5uV4+WnHW6qZARcGy5ZsOLVRz?=
 =?iso-8859-1?Q?CmqpEHIz7U/ARygwX1miAfH/YF2JgRiWWN9QEs9KC3Q3K1Vm2y0wXA2ung?=
 =?iso-8859-1?Q?/YJBGmmZMRD75Usaxo5LiLyK67FF4tavic0ry/dZD24mrsDPJhJgqpv8xp?=
 =?iso-8859-1?Q?d8zLG/6ObMABXdwsBQW4sn/ImqOfCgi6jvtvfC9GaPQtPWVwt8MAdhpPtM?=
 =?iso-8859-1?Q?MLtAmO94cl1lHi0N/w9vLg2kNH23F+dcAGu2ijfBixprYJUAh618nzaMrw?=
 =?iso-8859-1?Q?joMEMJaHFA4HUl4MtWsc10yJtDvLVi1JPJ3cjTbflaIBA39LL34BHtBRoI?=
 =?iso-8859-1?Q?v9mIwXNP+tsaGfzCjNzYOMsvDUehJpKvui+WejCFZZcw0WQEYsyshvqaKu?=
 =?iso-8859-1?Q?m9395+Zbf6QlaQnaTMHEiEwtJd3IMNUjrNGyH6BelukEmW+qQ9nmi4GmJ2?=
 =?iso-8859-1?Q?YeKD3i1PCzl2RPK+OvJdgwqecGZU4pPuNo/qaMTTuaLrqouH4Utz+Zvmop?=
 =?iso-8859-1?Q?GBm7I6PrYG3+8YzYN+VcKPiCgKX8Oa6v69GqbJelE4ldiet6HulS9/uwhJ?=
 =?iso-8859-1?Q?DPZMtOpDtYPiqODyEazaJ+pdvsGWFkko2M/leLz7KdlK/fm7apdwQFY3VP?=
 =?iso-8859-1?Q?goPQ84RXsA2XRnGGh6oO4vlQmu85Nk5ceKunGYjhYP+BqaH8L57Rb9qWpl?=
 =?iso-8859-1?Q?m2b7aJUHfDwLfpgfHN3Q85diQHs+dsaB1IZ+rYf3Kaoz0bKOg2G74chfDL?=
 =?iso-8859-1?Q?9Fh1tGgSMzT7CyUguzVb7Lhk1gIQlqJbvISCM7aA+3XKX5HRokcywPRpT2?=
 =?iso-8859-1?Q?iHSDO6pBdKUftdCbek+PfUipoixd0SB+IATe+kuUdoUCULHtXByE0HsOH2?=
 =?iso-8859-1?Q?WJflJU4f9q71bVCRLUzXG6IgVUeSYWRph8LpfEH+AOw1pi+ywXe/hGeYii?=
 =?iso-8859-1?Q?S7FV0m7XaUpCsKmA/BTwg5zBgYaoh6xRK9m4WHck+E+QNGT7W4hEIaVbCE?=
 =?iso-8859-1?Q?e6BXMQwyekBJyKdJB7x1xAiWCqRAyW1T5rCwkvoxSlqoTkCesmPZI1eXZk?=
 =?iso-8859-1?Q?00c6mG1uqsSkZs7h36tH8oZ1icW4tsUKxdk5LHJ932TXMc5WFGnDc4P2BZ?=
 =?iso-8859-1?Q?DJiaYBGFwA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1f5f15-d701-4064-1984-08da2937b155
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 16:54:00.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdAvHytQjlmWaLE6sWSfSseHK2Tjkqhj5dIOM3OAxDGDLq8tt/mLP1TBgXQBV8+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4615
X-Proofpoint-GUID: gjy3S3n84HzbkhcuUtl6VaJZ_t39Q5dk
X-Proofpoint-ORIG-GUID: gjy3S3n84HzbkhcuUtl6VaJZ_t39Q5dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

uprobes work by raising a trap, setting a task flag from within the
interrupt handler, and processing the actual work for the uprobe on the
way back to userspace. As a result, uprobe handlers already execute in a
user context. The primary obstacle to sleepable bpf uprobe programs is
therefore on the bpf side.

Namely, the bpf_prog_array attached to the uprobe is protected by normal
rcu and runs with disabled preemption. In order for uprobe bpf programs
to become actually sleepable, we need it to be protected by the tasks_trace
rcu flavor instead (and kfree() called after a corresponding grace period).

One way to achieve this is by tracking an array-has-contained-sleepable-pro=
g
flag in bpf_prog_array and switching rcu flavors based on it. However, this
is deemed somewhat unwieldly and the rcu flavor transition would be hard
to reason about.

Instead, based on Alexei's proposal, we change the free path for
bpf_prog_array to chain a tasks_trace and normal grace periods
one after the other. Users who iterate under tasks_trace read section would
be safe, as would users who iterate under normal read sections (from
non-sleepable locations). The downside is that we take the tasks_trace late=
ncy
unconditionally but that's deemed acceptable under expected workloads.

The other interesting implication is wrt non-sleepable uprobe
programs. Because they need access to dynamically sized rcu-protected
maps, we conditionally disable preemption and take an rcu read section
around them, in addition to the overarching tasks_trace section.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 include/linux/bpf.h          | 60 ++++++++++++++++++++++++++++++++++++
 include/linux/trace_events.h |  1 +
 kernel/bpf/core.c            | 10 +++++-
 kernel/trace/bpf_trace.c     | 23 ++++++++++++++
 kernel/trace/trace_uprobe.c  |  4 +--
 5 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7d7f4806f5fb..d8692d7176ce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -25,6 +25,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/stddef.h>
 #include <linux/bpfptr.h>
+#include <linux/rcupdate_trace.h>

 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1379,6 +1380,65 @@ bpf_prog_run_array(const struct bpf_prog_array *arra=
y,
 	return ret;
 }

+/**
+ * Notes on RCU design for bpf_prog_arrays containing sleepable programs:
+ *
+ * We use the trace RCU flavor read section to protect the bpf_prog_array =
overall.
+ * Because there are users of bpf_prog_array that only use the normal
+ * rcu flavor, to avoid tracking a used-for-sleepable-programs bit in the
+ * array, we chain call_rcu_tasks_trace and kfree_rcu on the free path.
+ * This is suboptimal if the array is never used for sleepable programs
+ * but not a cause of concern under expected workloads.
+ *
+ * In the case where a non-sleepable program is inside the array,
+ * we take the rcu read section and disable preemption for that program
+ * alone, so it can access rcu-protected dynamically sized maps.
+ */
+static __always_inline u32
+bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
+			     const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	const struct bpf_prog *prog;
+	const struct bpf_prog_array *array;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	u32 ret =3D 1;
+
+	might_fault();
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "shouldn't be holding rcu lock");
+
+	migrate_disable();
+	rcu_read_lock_trace();
+
+	array =3D rcu_dereference(array_rcu);
+	if (unlikely(!array))
+		goto out;
+	old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
+	item =3D &array->items[0];
+	while ((prog =3D READ_ONCE(item->prog))) {
+		if (!prog->aux->sleepable) {
+			preempt_disable();
+			rcu_read_lock();
+		}
+
+		run_ctx.bpf_cookie =3D item->bpf_cookie;
+		ret &=3D run_prog(prog, ctx);
+		item++;
+
+		if (!prog->aux->sleepable) {
+			rcu_read_unlock();
+			preempt_enable();
+		}
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+out:
+	rcu_read_unlock_trace();
+	migrate_enable();
+	return ret;
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6e95a9f07a5..d45889f1210d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -736,6 +736,7 @@ trace_trigger_soft_disabled(struct trace_event_file *fi=
le)

 #ifdef CONFIG_BPF_EVENTS
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
+unsigned int uprobe_call_bpf(struct trace_event_call *call, void *ctx);
 int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *=
prog, u64 bpf_cookie);
 void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *inf=
o);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 13e9dbeeedf3..a4c301ef2ba1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2261,11 +2261,19 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 pro=
g_cnt, gfp_t flags)
 	return &bpf_empty_prog_array.hdr;
 }

+static void __bpf_prog_array_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_prog_array *progs;
+
+	progs =3D container_of(rcu, struct bpf_prog_array, rcu);
+	kfree_rcu(progs, rcu);
+}
+
 void bpf_prog_array_free(struct bpf_prog_array *progs)
 {
 	if (!progs || progs =3D=3D &bpf_empty_prog_array.hdr)
 		return;
-	kfree_rcu(progs, rcu);
+	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_rcu);
 }

 int bpf_prog_array_length(struct bpf_prog_array *array)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f15b826f9899..6a2291d4b5a0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -140,6 +140,29 @@ unsigned int trace_call_bpf(struct trace_event_call *c=
all, void *ctx)
 	return ret;
 }

+unsigned int uprobe_call_bpf(struct trace_event_call *call, void *ctx)
+{
+	unsigned int ret;
+
+	/*
+	 * Instead of moving rcu_read_lock/rcu_dereference/rcu_read_unlock
+	 * to all call sites, we did a bpf_prog_array_valid() there to check
+	 * whether call->prog_array is empty or not, which is
+	 * a heuristic to speed up execution.
+	 *
+	 * If bpf_prog_array_valid() fetched prog_array was
+	 * non-NULL, we go into uprobe_call_bpf() and do the actual
+	 * proper rcu_dereference() under RCU trace lock.
+	 * If it turns out that prog_array is NULL then, we bail out.
+	 * For the opposite, if the bpf_prog_array_valid() fetched pointer
+	 * was NULL, you'll skip the prog_array with the risk of missing
+	 * out of events when it was updated in between this and the
+	 * rcu_dereference() which is accepted risk.
+	 */
+	ret =3D bpf_prog_run_array_sleepable(call->prog_array, ctx, bpf_prog_run)=
;
+	return ret;
+}
+
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
 {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9711589273cd..3eb48897d15b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1346,9 +1346,7 @@ static void __uprobe_perf_func(struct trace_uprobe *t=
u,
 	if (bpf_prog_array_valid(call)) {
 		u32 ret;

-		preempt_disable();
-		ret =3D trace_call_bpf(call, regs);
-		preempt_enable();
+		ret =3D uprobe_call_bpf(call, regs);
 		if (!ret)
 			return;
 	}
--
2.35.1=

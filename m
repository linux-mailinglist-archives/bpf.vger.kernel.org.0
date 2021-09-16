Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C51740E141
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbhIPQ2v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 12:28:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11886 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241243AbhIPQ0y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 12:26:54 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GFgwhA000568
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=iau4hHOFchq8z6EJX9Kwz613Q1mY9uyx7wtHal15ZB0=;
 b=iy5pGpvpSJlSThE8pIndCuEzZrunpurp2puh669JaVbQvyqSSP8rMSjm7W7B5dYEHI5Z
 tzX4uOj9S2EBUym+HBHQe9eIwoW2bzqFvyc1yigXDfvHeWTTVt+oGf3hZ0WWQwf80cGu
 8KybFGsOYAWnB0F/7k5mcPLrC+3wi04XaJs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b40fb3fes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:33 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:25:04 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 3CC76BE68AB2; Thu, 16 Sep 2021 09:25:02 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mel Gorman <mgorman@techsingularity.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 4/6] sched: cfs: add bpf hooks to control wakeup and tick preemption
Date:   Thu, 16 Sep 2021 09:24:49 -0700
Message-ID: <20210916162451.709260-5-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: -XznsGAKI8nZxTxgB_2aureNOrMCkajs
X-Proofpoint-ORIG-GUID: -XznsGAKI8nZxTxgB_2aureNOrMCkajs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds 3 hooks to control wakeup and tick preemption:
  cfs_check_preempt_tick
  cfs_check_preempt_wakeup
  cfs_wakeup_preempt_entity

The first one allows to force or suppress a preemption from a tick
context. An obvious usage example is to minimize the number of
non-voluntary context switches and decrease an associated latency
penalty by (conditionally) providing tasks or task groups an extended
execution slice. It can be used instead of tweaking
sysctl_sched_min_granularity.

The second one is called from the wakeup preemption code and allows
to redefine whether a newly woken task should preempt the execution
of the current task. This is useful to minimize a number of
preemptions of latency sensitive tasks. To some extent it's a more
flexible analog of a sysctl_sched_wakeup_granularity.

The third one is similar, but it tweaks the wakeup_preempt_entity()
function, which is called not only from a wakeup context, but also
from pick_next_task(), which allows to influence the decision on which
task will be running next.

It's a place for a discussion whether we need both these hooks or only
one of them: the second is more powerful, but depends more on the
current implementation. In any case, bpf hooks are not an ABI, so it's
not a deal breaker.

The idea of the wakeup_preempt_entity hook belongs to Rik van Riel. He
also contributed a lot to the whole patchset by proving his ideas,
recommendations and a feedback for earlier (non-public) versions.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/bpf_sched.h       |  1 +
 include/linux/sched_hook_defs.h |  4 +++-
 kernel/sched/fair.c             | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_sched.h b/include/linux/bpf_sched.h
index 6e773aecdff7..5c238aeb853c 100644
--- a/include/linux/bpf_sched.h
+++ b/include/linux/bpf_sched.h
@@ -40,6 +40,7 @@ static inline RET bpf_sched_##NAME(__VA_ARGS__)	\
 {						\
 	return DEFAULT;				\
 }
+#include <linux/sched_hook_defs.h>
 #undef BPF_SCHED_HOOK
=20
 static inline bool bpf_sched_enabled(void)
diff --git a/include/linux/sched_hook_defs.h b/include/linux/sched_hook_d=
efs.h
index 14344004e335..f075b32698cd 100644
--- a/include/linux/sched_hook_defs.h
+++ b/include/linux/sched_hook_defs.h
@@ -1,2 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-BPF_SCHED_HOOK(int, 0, dummy, void)
+BPF_SCHED_HOOK(int, 0, cfs_check_preempt_tick, struct sched_entity *curr=
, unsigned long delta_exec)
+BPF_SCHED_HOOK(int, 0, cfs_check_preempt_wakeup, struct task_struct *cur=
r, struct task_struct *p)
+BPF_SCHED_HOOK(int, 0, cfs_wakeup_preempt_entity, struct sched_entity *c=
urr, struct sched_entity *se)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..35ea8911b25c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,6 +21,7 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include "sched.h"
+#include <linux/bpf_sched.h>
=20
 /*
  * Targeted preemption latency for CPU-bound tasks:
@@ -4447,6 +4448,16 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct s=
ched_entity *curr)
=20
 	ideal_runtime =3D sched_slice(cfs_rq, curr);
 	delta_exec =3D curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
+
+	if (bpf_sched_enabled()) {
+		int ret =3D bpf_sched_cfs_check_preempt_tick(curr, delta_exec);
+
+		if (ret < 0)
+			return;
+		else if (ret > 0)
+			resched_curr(rq_of(cfs_rq));
+	}
+
 	if (delta_exec > ideal_runtime) {
 		resched_curr(rq_of(cfs_rq));
 		/*
@@ -7083,6 +7094,13 @@ wakeup_preempt_entity(struct sched_entity *curr, s=
truct sched_entity *se)
 {
 	s64 gran, vdiff =3D curr->vruntime - se->vruntime;
=20
+	if (bpf_sched_enabled()) {
+		int ret =3D bpf_sched_cfs_wakeup_preempt_entity(curr, se);
+
+		if (ret)
+			return ret;
+	}
+
 	if (vdiff <=3D 0)
 		return -1;
=20
@@ -7168,6 +7186,15 @@ static void check_preempt_wakeup(struct rq *rq, st=
ruct task_struct *p, int wake_
 	    likely(!task_has_idle_policy(p)))
 		goto preempt;
=20
+	if (bpf_sched_enabled()) {
+		int ret =3D bpf_sched_cfs_check_preempt_wakeup(current, p);
+
+		if (ret < 0)
+			return;
+		else if (ret > 0)
+			goto preempt;
+	}
+
 	/*
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
--=20
2.31.1


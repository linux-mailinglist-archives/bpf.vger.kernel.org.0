Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6630540E139
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbhIPQ2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 12:28:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232660AbhIPQ01 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 12:26:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18GFgtm3027960
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=FvkZsdRnuDFdsFs6RIuDJK0lxpqem6zpUwmYQiIpIG4=;
 b=A+pK/+rZLVyk3N245w0cDN5aG0VOxd+gBaLAQqwoiLk7nrCCQsqw9vd12Lc3/zjUlkfb
 OnpuSAqHGioIdNO65LTJY/iG2rj8AbBNj3NvrJfRdzRUqpRfQVq14RqyxPFhW1LOKPXw
 BHU+uKzXLBbs76Xsp1h3kv4NL0b2YxbrDfU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b42vxttgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:05 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:25:04 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 36BF6BE68AAE; Thu, 16 Sep 2021 09:25:02 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mel Gorman <mgorman@techsingularity.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 3/6] bpf: sched: introduce bpf_sched_enable()
Date:   Thu, 16 Sep 2021 09:24:48 -0700
Message-ID: <20210916162451.709260-4-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: N4OWnV7FrtyBrAEYYACzcI_dk7gikiGB
X-Proofpoint-ORIG-GUID: N4OWnV7FrtyBrAEYYACzcI_dk7gikiGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a dedicated static key and the bpf_sched_enabled() wrapper
to guard all invocations of bpf programs in the scheduler code.

It will help to avoid any potential performance regression in a case
when no scheduler bpf programs are attached.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/bpf_sched.h | 24 ++++++++++++++++++++++++
 kernel/bpf/syscall.c      |  7 +++++++
 kernel/sched/bpf_sched.c  |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/bpf_sched.h b/include/linux/bpf_sched.h
index 0f8d3dae53df..6e773aecdff7 100644
--- a/include/linux/bpf_sched.h
+++ b/include/linux/bpf_sched.h
@@ -6,6 +6,8 @@
=20
 #ifdef CONFIG_BPF_SYSCALL
=20
+#include <linux/jump_label.h>
+
 #define BPF_SCHED_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_sched_##NAME(__VA_ARGS__);
 #include <linux/sched_hook_defs.h>
@@ -14,6 +16,23 @@
 int bpf_sched_verify_prog(struct bpf_verifier_log *vlog,
 			  const struct bpf_prog *prog);
=20
+DECLARE_STATIC_KEY_FALSE(bpf_sched_enabled_key);
+
+static inline bool bpf_sched_enabled(void)
+{
+	return static_branch_unlikely(&bpf_sched_enabled_key);
+}
+
+static inline void bpf_sched_inc(void)
+{
+	static_branch_inc(&bpf_sched_enabled_key);
+}
+
+static inline void bpf_sched_dec(void)
+{
+	static_branch_dec(&bpf_sched_enabled_key);
+}
+
 #else /* CONFIG_BPF_SYSCALL */
=20
 #define BPF_SCHED_HOOK(RET, DEFAULT, NAME, ...)	\
@@ -23,6 +42,11 @@ static inline RET bpf_sched_##NAME(__VA_ARGS__)	\
 }
 #undef BPF_SCHED_HOOK
=20
+static inline bool bpf_sched_enabled(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_BPF_SYSCALL */
=20
 #endif /* _BPF_CGROUP_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 67e062376f22..aa5565110498 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -31,6 +31,7 @@
 #include <linux/bpf-netns.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
+#include <linux/bpf_sched.h>
=20
 #define IS_FD_ARRAY(map) ((map)->map_type =3D=3D BPF_MAP_TYPE_PERF_EVENT=
_ARRAY || \
 			  (map)->map_type =3D=3D BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -2602,6 +2603,9 @@ static void bpf_tracing_link_release(struct bpf_lin=
k *link)
 	struct bpf_tracing_link *tr_link =3D
 		container_of(link, struct bpf_tracing_link, link);
=20
+	if (link->prog->type =3D=3D BPF_PROG_TYPE_SCHED)
+		bpf_sched_dec();
+
 	WARN_ON_ONCE(bpf_trampoline_unlink_prog(link->prog,
 						tr_link->trampoline));
=20
@@ -2804,6 +2808,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
 		goto out_unlock;
 	}
=20
+	if (prog->type =3D=3D BPF_PROG_TYPE_SCHED)
+		bpf_sched_inc();
+
 	link->tgt_prog =3D tgt_prog;
 	link->trampoline =3D tr;
=20
diff --git a/kernel/sched/bpf_sched.c b/kernel/sched/bpf_sched.c
index ead691dc6e85..bf92cfb5ecf4 100644
--- a/kernel/sched/bpf_sched.c
+++ b/kernel/sched/bpf_sched.c
@@ -6,6 +6,8 @@
 #include <linux/btf_ids.h>
 #include "sched.h"
=20
+DEFINE_STATIC_KEY_FALSE(bpf_sched_enabled_key);
+
 /*
  * For every hook declare a nop function where a BPF program can be atta=
ched.
  */
--=20
2.31.1


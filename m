Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D6540E137
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbhIPQ21 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 12:28:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38508 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241918AbhIPQ01 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 12:26:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18GFgvmi028087
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=I5fkErTvZrkiVI6NbzLcumqoZjkORUv3EO++1kQRzZs=;
 b=D9SljK0EcOKqOWh0eoKaggHLnjdCdjhvLrE8T7n6JLEqNCRl2utlgWro2nOM5L3fY+54
 e3EodqLr5GFMoQCXD9mUICLLn05Wf1IYYaTkvCbPIxHi8y2BSmJb58QCKtOKuBL4Gw+G
 iUrmfkBjvRH3o0163SLxE1P+qJxIDxK03X8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b42vxttgx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:06 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:25:04 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 3080EBE68AAC; Thu, 16 Sep 2021 09:25:02 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mel Gorman <mgorman@techsingularity.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 2/6] bpf: sched: add convenient helpers to identify sched entities
Date:   Thu, 16 Sep 2021 09:24:47 -0700
Message-ID: <20210916162451.709260-3-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: -1obUGZkUac_MnMQ9poMh6taHHsHMkMx
X-Proofpoint-ORIG-GUID: -1obUGZkUac_MnMQ9poMh6taHHsHMkMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=865 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds 3 helpers useful for dealing with sched entities:
  u64 bpf_sched_entity_to_tgidpid(struct sched_entity *se);
  u64 bpf_sched_entity_to_cgrpid(struct sched_entity *se);
  long bpf_sched_entity_belongs_to_cgrp(struct sched_entity *se, u64 cgrp=
id);

Sched entity is a basic structure used by the scheduler to represent
schedulable objects: tasks and cgroups (if CONFIG_FAIR_GROUP_SCHED
is enabled). It will be passed as an argument to many bpf hooks, so
scheduler bpf programs need a convenient way to deal with it.

bpf_sched_entity_to_tgidpid() and bpf_sched_entity_to_cgrpid() are
useful to identify a sched entity in userspace terms (pid, tgid and
cgroup id). bpf_sched_entity_belongs_to_cgrp() allows to check whether
a sched entity belongs to sub-tree of a cgroup. It allows to write
cgroup-specific scheduler policies even without enabling the cgroup
cpu controller.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/uapi/linux/bpf.h       | 23 +++++++++++
 kernel/sched/bpf_sched.c       | 74 ++++++++++++++++++++++++++++++++++
 scripts/bpf_doc.py             |  2 +
 tools/include/uapi/linux/bpf.h | 23 +++++++++++
 4 files changed, 122 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6dfbebb8fc8f..199e4a92820d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4900,6 +4900,26 @@ union bpf_attr {
  *		**-EINVAL** if *flags* is not zero.
  *
  *		**-ENOENT** if architecture does not support branch records.
+ *
+ * u64 bpf_sched_entity_to_tgidpid(struct sched_entity *se)
+ *	Description
+ *		Return task's encoded tgid and pid if the sched entity is a task.
+ *	Return
+ *		Tgid and pid encoded as tgid << 32 \| pid, if *se* is a task. (u64)-=
1 otherwise.
+ *
+ * u64 bpf_sched_entity_to_cgrpid(struct sched_entity *se)
+ *	Description
+ *		Return cgroup id if the given sched entity is a cgroup.
+ *	Return
+ *		Cgroup id, if *se* is a cgroup. (u64)-1 otherwise.
+ *
+ * long bpf_sched_entity_belongs_to_cgrp(struct sched_entity *se, u64 cg=
rpid)
+ *	Description
+ *		Checks whether the sched entity belongs to a cgroup or
+ *		it's sub-tree. It doesn't require a cgroup CPU controller
+ *		to be enabled.
+ *	Return
+ *		1 if the sched entity belongs to a cgroup, 0 otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5079,6 +5099,9 @@ union bpf_attr {
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
+	FN(sched_entity_to_tgidpid),	\
+	FN(sched_entity_to_cgrpid),	\
+	FN(sched_entity_belongs_to_cgrp),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/sched/bpf_sched.c b/kernel/sched/bpf_sched.c
index 2f05c186cfd0..ead691dc6e85 100644
--- a/kernel/sched/bpf_sched.c
+++ b/kernel/sched/bpf_sched.c
@@ -42,12 +42,86 @@ int bpf_sched_verify_prog(struct bpf_verifier_log *vl=
og,
 	return 0;
 }
=20
+BPF_CALL_1(bpf_sched_entity_to_tgidpid, struct sched_entity *, se)
+{
+	if (entity_is_task(se)) {
+		struct task_struct *task =3D task_of(se);
+
+		return (u64) task->tgid << 32 | task->pid;
+	} else {
+		return (u64) -1;
+	}
+}
+
+BPF_CALL_1(bpf_sched_entity_to_cgrpid, struct sched_entity *, se)
+{
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (!entity_is_task(se))
+		return cgroup_id(se->cfs_rq->tg->css.cgroup);
+#endif
+	return (u64) -1;
+}
+
+BPF_CALL_2(bpf_sched_entity_belongs_to_cgrp, struct sched_entity *, se,
+	   u64, cgrpid)
+{
+#ifdef CONFIG_CGROUPS
+	struct cgroup *cgrp;
+	int level;
+
+	if (entity_is_task(se))
+		cgrp =3D task_dfl_cgroup(task_of(se));
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	else
+		cgrp =3D se->cfs_rq->tg->css.cgroup;
+#endif
+
+	for (level =3D cgrp->level; level; level--)
+		if (cgrp->ancestor_ids[level] =3D=3D cgrpid)
+			return 1;
+#endif
+	return 0;
+}
+
+BTF_ID_LIST_SINGLE(btf_sched_entity_ids, struct, sched_entity)
+
+static const struct bpf_func_proto bpf_sched_entity_to_tgidpid_proto =3D=
 {
+	.func		=3D bpf_sched_entity_to_tgidpid,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	=3D &btf_sched_entity_ids[0],
+};
+
+static const struct bpf_func_proto bpf_sched_entity_to_cgrpid_proto =3D =
{
+	.func		=3D bpf_sched_entity_to_cgrpid,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	=3D &btf_sched_entity_ids[0],
+};
+
+static const struct bpf_func_proto bpf_sched_entity_belongs_to_cgrp_prot=
o =3D {
+	.func		=3D bpf_sched_entity_belongs_to_cgrp,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	=3D &btf_sched_entity_ids[0],
+	.arg2_type	=3D ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 bpf_sched_func_proto(enum bpf_func_id func_id, const struct bpf_prog *pr=
og)
 {
 	switch (func_id) {
 	case BPF_FUNC_trace_printk:
 		return bpf_get_trace_printk_proto();
+	case BPF_FUNC_sched_entity_to_tgidpid:
+		return &bpf_sched_entity_to_tgidpid_proto;
+	case BPF_FUNC_sched_entity_to_cgrpid:
+		return &bpf_sched_entity_to_cgrpid_proto;
+	case BPF_FUNC_sched_entity_belongs_to_cgrp:
+		return &bpf_sched_entity_belongs_to_cgrp_proto;
 	default:
 		return NULL;
 	}
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 00ac7b79cddb..84019ba5b67b 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -548,6 +548,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct sched_entity',
     ]
     known_types =3D {
             '...',
@@ -596,6 +597,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct sched_entity',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 6dfbebb8fc8f..199e4a92820d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4900,6 +4900,26 @@ union bpf_attr {
  *		**-EINVAL** if *flags* is not zero.
  *
  *		**-ENOENT** if architecture does not support branch records.
+ *
+ * u64 bpf_sched_entity_to_tgidpid(struct sched_entity *se)
+ *	Description
+ *		Return task's encoded tgid and pid if the sched entity is a task.
+ *	Return
+ *		Tgid and pid encoded as tgid << 32 \| pid, if *se* is a task. (u64)-=
1 otherwise.
+ *
+ * u64 bpf_sched_entity_to_cgrpid(struct sched_entity *se)
+ *	Description
+ *		Return cgroup id if the given sched entity is a cgroup.
+ *	Return
+ *		Cgroup id, if *se* is a cgroup. (u64)-1 otherwise.
+ *
+ * long bpf_sched_entity_belongs_to_cgrp(struct sched_entity *se, u64 cg=
rpid)
+ *	Description
+ *		Checks whether the sched entity belongs to a cgroup or
+ *		it's sub-tree. It doesn't require a cgroup CPU controller
+ *		to be enabled.
+ *	Return
+ *		1 if the sched entity belongs to a cgroup, 0 otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5079,6 +5099,9 @@ union bpf_attr {
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
+	FN(sched_entity_to_tgidpid),	\
+	FN(sched_entity_to_cgrpid),	\
+	FN(sched_entity_belongs_to_cgrp),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.31.1


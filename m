Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293CD5EB07E
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 20:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiIZSuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIZSuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:50:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F023A4BE
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:14 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28QIBJph008018
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=EOLQsl1iM2n+hqWB6yKxw77IOaj0Fa7bLCF1z4Ee++Q=;
 b=SxrBam+BC8DP1yLO2k270laa4a0LRLSqnz5RGOFh+czGw9a8pY9CSPDiMxlrSt5LXBN1
 lWrYcJZEZb7Rg17XWzBb9NyD5Vk1myC4Ogq/WZHkIjquPod/e0yowIPbM7OwAuRySfYx
 V3IgvGpISQfO226GXPkwXVKqvJxcNEjEJWY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jswjunhqd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:13 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:50:12 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 6E368895101A; Mon, 26 Sep 2022 11:50:00 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v11 3/5] bpf: Handle show_fdinfo for the parameterized task BPF iterators
Date:   Mon, 26 Sep 2022 11:49:55 -0700
Message-ID: <20220926184957.208194-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220926184957.208194-1-kuifeng@fb.com>
References: <20220926184957.208194-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: v15a-GMSH7yOg7AsyXeQnK7luv_5mspK
X-Proofpoint-ORIG-GUID: v15a-GMSH7yOg7AsyXeQnK7luv_5mspK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Show information of iterators in the respective files under
/proc/<pid>/fdinfo/.

For example, for a task file iterator with 1723 as the value of tid
parameter, its fdinfo would look like the following lines.

    pos:    0
    flags:  02000000
    mnt_id: 14
    ino:    38
    link_type:      iter
    link_id:        51
    prog_tag:       a590ac96db22b825
    prog_id:        299
    target_name:    task_file
    task_type:      TID
    tid: 1723

This patch add the last three fields.  task_type is the type of the
task parameter.  TID means the iterator visit only the thread
specified by tid.  The value of tid in the above example is 1723.  For
the case of PID task_type, it means the iterator visits only threads
of a process and will show the pid value of the process instead of a
tid.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/task_iter.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 655a0040a4c8..5371d82a0d7f 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -10,6 +10,12 @@
 #include <linux/btf_ids.h>
 #include "mmap_unlock_work.h"
=20
+static const char * const iter_task_type_names[] =3D {
+	"ALL",
+	"TID",
+	"PID",
+};
+
 struct bpf_iter_seq_task_common {
 	struct pid_namespace *ns;
 	enum bpf_iter_task_type	type;
@@ -691,6 +697,15 @@ static int bpf_iter_fill_link_info(const struct bpf_=
iter_aux_info *aux, struct b
 	return 0;
 }
=20
+static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *au=
x, struct seq_file *seq)
+{
+	seq_printf(seq, "task_type:\t%s\n", iter_task_type_names[aux->task.type=
]);
+	if (aux->task.type =3D=3D BPF_TASK_ITER_TID)
+		seq_printf(seq, "tid:\t%u\n", aux->task.pid);
+	else if (aux->task.type =3D=3D BPF_TASK_ITER_TGID)
+		seq_printf(seq, "pid:\t%u\n", aux->task.pid);
+}
+
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
 	.attach_target		=3D bpf_iter_attach_task,
@@ -702,6 +717,7 @@ static struct bpf_iter_reg task_reg_info =3D {
 	},
 	.seq_info		=3D &task_seq_info,
 	.fill_link_info		=3D bpf_iter_fill_link_info,
+	.show_fdinfo		=3D bpf_iter_task_show_fdinfo,
 };
=20
 static const struct bpf_iter_seq_info task_file_seq_info =3D {
@@ -724,6 +740,7 @@ static struct bpf_iter_reg task_file_reg_info =3D {
 	},
 	.seq_info		=3D &task_file_seq_info,
 	.fill_link_info		=3D bpf_iter_fill_link_info,
+	.show_fdinfo		=3D bpf_iter_task_show_fdinfo,
 };
=20
 static const struct bpf_iter_seq_info task_vma_seq_info =3D {
@@ -746,6 +763,7 @@ static struct bpf_iter_reg task_vma_reg_info =3D {
 	},
 	.seq_info		=3D &task_vma_seq_info,
 	.fill_link_info		=3D bpf_iter_fill_link_info,
+	.show_fdinfo		=3D bpf_iter_task_show_fdinfo,
 };
=20
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
--=20
2.30.2


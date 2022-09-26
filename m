Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CAA5EB07F
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 20:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIZSuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIZSuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:50:17 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9898339104
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QI9cqP007877
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=RiecEoRJvDiZs8M3kJGwyFL3KmyYwQbR0Xn6ZPx2cLI=;
 b=PxIDO9Ss95aDksZvIYDPlocMVYbXQoH2F6m/EueH5iE1BXvVu84yew2zLRQjkeB16f/s
 bGUbdHlXEs+zvG3vHVG1xtKT+d9sh/hsHXzD85AZ7h7FGaDioW9OhnDjyR/5f46BHJVl
 gsn1Uhq5xUYwhB+pN1Tt2UoNkKC20FgKeW0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsydxw7dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:12 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:50:11 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id E63DD8951018; Mon, 26 Sep 2022 11:49:59 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v11 2/5] bpf: Handle bpf_link_info for the parameterized task BPF iterators.
Date:   Mon, 26 Sep 2022 11:49:54 -0700
Message-ID: <20220926184957.208194-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220926184957.208194-1-kuifeng@fb.com>
References: <20220926184957.208194-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cnMTOb61leDu6MeIET7a4TWQOyyMkRrO
X-Proofpoint-GUID: cnMTOb61leDu6MeIET7a4TWQOyyMkRrO
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

Add new fields to bpf_link_info that users can query it through
bpf_obj_get_info_by_fd().

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/task_iter.c         | 18 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a0bac82d5e01..d99d1eee17c6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6264,6 +6264,10 @@ struct bpf_link_info {
 					__u64 cgroup_id;
 					__u32 order;
 				} cgroup;
+				struct {
+					__u32 tid;
+					__u32 pid;
+				} task;
 			};
 		} iter;
 		struct  {
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index ec67efeb8fb0..655a0040a4c8 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -676,6 +676,21 @@ static const struct bpf_iter_seq_info task_seq_info =
=3D {
 	.seq_priv_size		=3D sizeof(struct bpf_iter_seq_task_info),
 };
=20
+static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, =
struct bpf_link_info *info)
+{
+	switch (aux->task.type) {
+	case BPF_TASK_ITER_TID:
+		info->iter.task.tid =3D aux->task.pid;
+		break;
+	case BPF_TASK_ITER_TGID:
+		info->iter.task.pid =3D aux->task.pid;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
 	.attach_target		=3D bpf_iter_attach_task,
@@ -686,6 +701,7 @@ static struct bpf_iter_reg task_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 static const struct bpf_iter_seq_info task_file_seq_info =3D {
@@ -707,6 +723,7 @@ static struct bpf_iter_reg task_file_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_file_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 static const struct bpf_iter_seq_info task_vma_seq_info =3D {
@@ -728,6 +745,7 @@ static struct bpf_iter_reg task_vma_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_vma_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index a0bac82d5e01..d99d1eee17c6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6264,6 +6264,10 @@ struct bpf_link_info {
 					__u64 cgroup_id;
 					__u32 order;
 				} cgroup;
+				struct {
+					__u32 tid;
+					__u32 pid;
+				} task;
 			};
 		} iter;
 		struct  {
--=20
2.30.2


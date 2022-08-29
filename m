Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D35A5475
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiH2TXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiH2TXm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 15:23:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7028708F
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 12:23:40 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TJ5mmk015195
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 12:23:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Ug5niAcs28nJ/3zhwKx/mbqbeJ1Eu/kgRwjDfxMHowo=;
 b=WOYb32pMAUaaQOM+n2DrsKwsF1sC4zR6DFz7HcwwL3HCm0PE+nw/0XKveIq1me/wLRcM
 OfGJnlwbAIcb1OM1KYEXQeskAhHY+o/pmdaQcQDTDSaFoh8oexDkd3JNQKCcnJYRq/ih
 ziwVA8XJgKEDQDR00SRIoWCdvA6gI+Pb8dE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7h3uuq0f-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 12:23:39 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 12:23:37 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 23C74749ED61; Mon, 29 Aug 2022 12:23:35 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v8 2/5] bpf: Handle bpf_link_info for the parameterized task BPF iterators.
Date:   Mon, 29 Aug 2022 12:23:14 -0700
Message-ID: <20220829192317.486946-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829192317.486946-1-kuifeng@fb.com>
References: <20220829192317.486946-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DxgSr-baYujXd1eLUKMA5pTBUuk98xAt
X-Proofpoint-GUID: DxgSr-baYujXd1eLUKMA5pTBUuk98xAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index f212a19eda06..088cbc8f6a0c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6216,6 +6216,10 @@ struct bpf_link_info {
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
index 0bc7277d1ee1..5140117447e5 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -668,6 +668,21 @@ static const struct bpf_iter_seq_info task_seq_info =
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
@@ -678,6 +693,7 @@ static struct bpf_iter_reg task_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 static const struct bpf_iter_seq_info task_file_seq_info =3D {
@@ -699,6 +715,7 @@ static struct bpf_iter_reg task_file_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_file_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 static const struct bpf_iter_seq_info task_vma_seq_info =3D {
@@ -720,6 +737,7 @@ static struct bpf_iter_reg task_vma_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_vma_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 40935278eede..864cf6a613d6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6216,6 +6216,10 @@ struct bpf_link_info {
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


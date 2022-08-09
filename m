Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1658D3EA
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 08:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiHIGhc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 02:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiHIGhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 02:37:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E75201A4
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 23:37:31 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278NSOtD026340
        for <bpf@vger.kernel.org>; Mon, 8 Aug 2022 23:37:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mvhQmTkgPYORgwT8deIYjwksxAJlwQ8X/Ziy5oxTCNE=;
 b=HzKsbRDbgFSq7HoJhBBDoqgR0U7tvXFUs7Fform7fypGSyEkqq6vUdsQ+xxprnj48HH8
 1dwSZNaJg+QGh3FtW7mOndWOOURcccW/gaG7kHgZTcq7/AQiNj7j8iipIo23fDYzPkfP
 TFl/9j9fJOXFQDD8VRqmwxXquXykOBZKBWY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hu774uutm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 23:37:30 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 23:37:29 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 1921C6716761; Mon,  8 Aug 2022 23:35:03 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v3 2/3] bpf: Handle bpf_link_info for the parameterized task BPF iterators.
Date:   Mon, 8 Aug 2022 23:35:00 -0700
Message-ID: <20220809063501.667610-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809063501.667610-1-kuifeng@fb.com>
References: <20220809063501.667610-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Y9Exx3vwcPVLGvSop4lOFaNOuU3U39xr
X-Proofpoint-ORIG-GUID: Y9Exx3vwcPVLGvSop4lOFaNOuU3U39xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/task_iter.c         | 19 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 3 files changed, 33 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3d0b9e34089f..17b945e87973 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6171,6 +6171,13 @@ struct bpf_link_info {
 				struct {
 					__u32 map_id;
 				} map;
+				struct {
+					enum bpf_iter_task_type type;
+					union {
+						__u32 tid;
+						__u32 tgid;
+					};
+				} task;
 			};
 		} iter;
 		struct  {
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 047d94493117..01213329398f 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -614,6 +614,22 @@ static const struct bpf_iter_seq_info task_seq_info =
=3D {
 	.seq_priv_size		=3D sizeof(struct bpf_iter_seq_task_info),
 };
=20
+static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, =
struct bpf_link_info *info)
+{
+	switch (aux->task.type) {
+	case BPF_TASK_ITER_TID:
+		info->iter.task.tid =3D aux->task.tid;
+		break;
+	case BPF_TASK_ITER_TGID:
+		info->iter.task.tgid =3D aux->task.tgid;
+		break;
+	default:
+		break;
+	}
+	info->iter.task.type =3D aux->task.type;
+	return 0;
+}
+
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
 	.attach_target		=3D bpf_iter_attach_task,
@@ -624,6 +640,7 @@ static struct bpf_iter_reg task_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 static const struct bpf_iter_seq_info task_file_seq_info =3D {
@@ -645,6 +662,7 @@ static struct bpf_iter_reg task_file_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_file_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 static const struct bpf_iter_seq_info task_vma_seq_info =3D {
@@ -666,6 +684,7 @@ static struct bpf_iter_reg task_vma_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_vma_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 3d0b9e34089f..204a8473ae1f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6171,6 +6171,13 @@ struct bpf_link_info {
 				struct {
 					__u32 map_id;
 				} map;
+				struct {
+					enum bpf_iter_task_type type;
+					union {
+					__u32 tid;
+					__u32 tgid;
+					};
+				} task;
 			};
 		} iter;
 		struct  {
--=20
2.30.2


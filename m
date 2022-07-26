Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D487580AB6
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 07:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiGZFR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 01:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiGZFR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 01:17:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3052250B
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:55 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26Q0p3Hn019579
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=k2nDpx09XX8pV7vrO9o2y51T5QvCmQOB8DMPwlD51zA=;
 b=WCjium/c6kXvXE5hW7ZfP18rSSkez+2OcPCYnXrdI0tVQsmOBM7R3/Z49eMmLWf/ZB+T
 MdONqL2oKqq5hhy17Rhre+ivuZu/xYfTusZfuUKtZS0d4tmQsYmrMOGgw983CJ1LzFWg
 pcQEvNOeEPbMQGThoZPI+DF/wM4N8CbvPvI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hgcajpk6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:55 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 22:17:54 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id D5FEB5E528AE; Mon, 25 Jul 2022 22:17:43 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 2/3] bpf: Handle bpf_link_info for the parameterized task BPF iterators.
Date:   Mon, 25 Jul 2022 22:17:12 -0700
Message-ID: <20220726051713.840431-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726051713.840431-1-kuifeng@fb.com>
References: <20220726051713.840431-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: v9bCm5Z43zX_V9Rolld2ti5grBQRNNaQ
X-Proofpoint-ORIG-GUID: v9bCm5Z43zX_V9Rolld2ti5grBQRNNaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/task_iter.c         | 10 ++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 991141cacb9e..3121e9c66b7e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6158,6 +6158,10 @@ struct bpf_link_info {
 				struct {
 					__u32 map_id;
 				} map;
+				struct {
+					__u32 tid;
+					__u8 type; /* one of enum bpf_task_iter_type */
+				} task;
 			};
 		} iter;
 		struct  {
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 7979aacb651e..26655d681776 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -565,6 +565,13 @@ static const struct bpf_iter_seq_info task_seq_info =
=3D {
 	.seq_priv_size		=3D sizeof(struct bpf_iter_seq_task_info),
 };
=20
+static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, =
struct bpf_link_info *info)
+{
+	info->iter.task.tid =3D aux->task.tid;
+	info->iter.task.type =3D aux->task.type;
+	return 0;
+}
+
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
 	.attach_target		=3D bpf_iter_attach_task,
@@ -575,6 +582,7 @@ static struct bpf_iter_reg task_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 static const struct bpf_iter_seq_info task_file_seq_info =3D {
@@ -596,6 +604,7 @@ static struct bpf_iter_reg task_file_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_file_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 static const struct bpf_iter_seq_info task_vma_seq_info =3D {
@@ -617,6 +626,7 @@ static struct bpf_iter_reg task_vma_reg_info =3D {
 		  PTR_TO_BTF_ID_OR_NULL },
 	},
 	.seq_info		=3D &task_vma_seq_info,
+	.fill_link_info		=3D bpf_iter_fill_link_info,
 };
=20
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 991141cacb9e..3121e9c66b7e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6158,6 +6158,10 @@ struct bpf_link_info {
 				struct {
 					__u32 map_id;
 				} map;
+				struct {
+					__u32 tid;
+					__u8 type; /* one of enum bpf_task_iter_type */
+				} task;
 			};
 		} iter;
 		struct  {
--=20
2.30.2


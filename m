Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D954659A824
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 00:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiHSWJp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiHSWJp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 18:09:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7EB441F
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:09:43 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JKHqsq017681
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:09:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=WMUUJ+dI46gWEiL8GDnVyxkP1iPNjmZj8z81e5zaTbM=;
 b=oDCZRoprGULZQha092TeuPIhhKQkw/NvWAQQ6ecZibP0yvBsiX52P+nBIfFMO9b2Y71E
 nbJIuC7DbeORP+TKSqqZrFCOtb0uE0pzRBnP4qw6XtblHLSBoXGhVswClvXReXHqGKsi
 y4V7DkS9Fnl3+/lvd6a0MhtpYqqPt3xV1MY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j1sdw2u94-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:09:42 -0700
Received: from twshared32421.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 15:09:40 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id D54406DDB81C; Fri, 19 Aug 2022 15:09:31 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v6 3/4] bpf: Handle show_fdinfo for the parameterized task BPF iterators
Date:   Fri, 19 Aug 2022 15:09:26 -0700
Message-ID: <20220819220927.3409575-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220819220927.3409575-1-kuifeng@fb.com>
References: <20220819220927.3409575-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: C8aQMKQ3n81bBDmsDdgWovltz7YzhLlu
X-Proofpoint-GUID: C8aQMKQ3n81bBDmsDdgWovltz7YzhLlu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_12,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Show information of iterators in the respective files under
/proc/<pid>/fdinfo/.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 kernel/bpf/task_iter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 927b3a1cf354..5303eddb264b 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -611,6 +611,11 @@ static int bpf_iter_fill_link_info(const struct bpf_=
iter_aux_info *aux, struct b
 	return 0;
 }
=20
+static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *au=
x, struct seq_file *seq)
+{
+	seq_printf(seq, "task_type:\t%d\npid:\t%d\n", aux->task.type, aux->task=
.pid);
+}
+
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
 	.attach_target		=3D bpf_iter_attach_task,
@@ -622,6 +627,7 @@ static struct bpf_iter_reg task_reg_info =3D {
 	},
 	.seq_info		=3D &task_seq_info,
 	.fill_link_info		=3D bpf_iter_fill_link_info,
+	.show_fdinfo		=3D bpf_iter_task_show_fdinfo,
 };
=20
 static const struct bpf_iter_seq_info task_file_seq_info =3D {
@@ -644,6 +650,7 @@ static struct bpf_iter_reg task_file_reg_info =3D {
 	},
 	.seq_info		=3D &task_file_seq_info,
 	.fill_link_info		=3D bpf_iter_fill_link_info,
+	.show_fdinfo		=3D bpf_iter_task_show_fdinfo,
 };
=20
 static const struct bpf_iter_seq_info task_vma_seq_info =3D {
@@ -666,6 +673,7 @@ static struct bpf_iter_reg task_vma_reg_info =3D {
 	},
 	.seq_info		=3D &task_vma_seq_info,
 	.fill_link_info		=3D bpf_iter_fill_link_info,
+	.show_fdinfo		=3D bpf_iter_task_show_fdinfo,
 };
=20
 BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
--=20
2.30.2


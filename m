Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE722A04E
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 21:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgGVTwJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 15:52:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19898 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgGVTwJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jul 2020 15:52:09 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MJXjI2014741
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 12:52:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=b5McB+fVPoqyi/xjIS6iBbcS6lVZaUOlTpnBsJVci5M=;
 b=a+vXOIhQ/K75GhQqpcsCvFLzEmSB3pve2VZkpq1b9kssS5DjtEHwkURawdZ+591wf+s3
 4ZKV1y865XlsYqPfDHtr2cdLxBDd/P+kmuxhMtCDoM3OmDGLt/bOr748Yzs/zNksmb1J
 GaN/y8Wfyltm1GhVp3o/x34hHkrF/vQ97Qc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32et5krpbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 12:52:08 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 12:52:07 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 599013704C81; Wed, 22 Jul 2020 12:51:56 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: fix pos computation for bpf_iter seq_ops->start()
Date:   Wed, 22 Jul 2020 12:51:56 -0700
Message-ID: <20200722195156.4029817-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_13:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=1 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007220124
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the pos pointer in bpf iterator map/task/task_file
seq_ops->start() is always incremented.
This is incorrect. It should be increased only if
*pos is 0 (for SEQ_START_TOKEN) since these start()
function actually returns the first real object.
If *pos is not 0, it merely found the object
based on the state in seq->private, and not really
advancing the *pos. This patch fixed this issue
by only incrementing *pos if it is 0.

Note that the old *pos calculation, although not
correct, does not affect correctness of bpf_iter
as bpf_iter seq_file->read() does not support llseek.

This patch also renamed "mid" in bpf_map iterator
seq_file private data to "map_id" for better clarity.

Fixes: 6086d29def80 ("bpf: Add bpf_map iterator")
Fixes: eaaacd23910f ("bpf: Add task and task/file iterator targets")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/map_iter.c  | 16 ++++++----------
 kernel/bpf/task_iter.c |  6 ++++--
 2 files changed, 10 insertions(+), 12 deletions(-)

I targeted this to bpf-next as I think this patch
does not need to backport to bpf tree as it does not
impact correctness.

Alexei, I also made the change of "mid"->"map_id"
and simplified the logic in map_iter seq_file->next()
the same as your patch in
  https://lore.kernel.org/bpf/20200717044031.56412-2-alexei.starovoitov@g=
mail.com/T
the goal is to reduce conflicts as we touch
the same file and close lines.

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 8a7af11b411f..5926c76d854e 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -7,7 +7,7 @@
 #include <linux/btf_ids.h>
=20
 struct bpf_iter_seq_map_info {
-	u32 mid;
+	u32 map_id;
 };
=20
 static void *bpf_map_seq_start(struct seq_file *seq, loff_t *pos)
@@ -15,27 +15,23 @@ static void *bpf_map_seq_start(struct seq_file *seq, =
loff_t *pos)
 	struct bpf_iter_seq_map_info *info =3D seq->private;
 	struct bpf_map *map;
=20
-	map =3D bpf_map_get_curr_or_next(&info->mid);
+	map =3D bpf_map_get_curr_or_next(&info->map_id);
 	if (!map)
 		return NULL;
=20
-	++*pos;
+	if (*pos =3D=3D 0)
+		++*pos;
 	return map;
 }
=20
 static void *bpf_map_seq_next(struct seq_file *seq, void *v, loff_t *pos=
)
 {
 	struct bpf_iter_seq_map_info *info =3D seq->private;
-	struct bpf_map *map;
=20
 	++*pos;
-	++info->mid;
+	++info->map_id;
 	bpf_map_put((struct bpf_map *)v);
-	map =3D bpf_map_get_curr_or_next(&info->mid);
-	if (!map)
-		return NULL;
-
-	return map;
+	return bpf_map_get_curr_or_next(&info->map_id);
 }
=20
 struct bpf_iter__bpf_map {
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2feecf095609..1039e52ebd8b 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -51,7 +51,8 @@ static void *task_seq_start(struct seq_file *seq, loff_=
t *pos)
 	if (!task)
 		return NULL;
=20
-	++*pos;
+	if (*pos =3D=3D 0)
+		++*pos;
 	return task;
 }
=20
@@ -210,7 +211,8 @@ static void *task_file_seq_start(struct seq_file *seq=
, loff_t *pos)
 		return NULL;
 	}
=20
-	++*pos;
+	if (*pos =3D=3D 0)
+		++*pos;
 	info->task =3D task;
 	info->files =3D files;
=20
--=20
2.24.1


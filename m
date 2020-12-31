Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F092E7E3D
	for <lists+bpf@lfdr.de>; Thu, 31 Dec 2020 06:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgLaFZD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Dec 2020 00:25:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbgLaFZD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 31 Dec 2020 00:25:03 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BV59F8A022277
        for <bpf@vger.kernel.org>; Wed, 30 Dec 2020 21:24:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=5sh45r1gIDl0BQlNr5iBX4CiY8cDqybActy1AHxgORI=;
 b=P3pNh4zTRdxP1B5EQjCGAoOwa9GmBrKXOdssXAga5t+rceVOdsbTx4wo+6y5YsXHWtTy
 nF+t5o8U7NSG3bgKKsNcw0fR6dTaFxjg3WNB1+t7QST1h6O6BtlCeALizQH40BFL7Ka7
 A2FWv4HHESoixPhD600IAyAJZvEX4QCZhEU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 35s5fp8ea7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 30 Dec 2020 21:24:22 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Dec 2020 21:24:20 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2ED4237059B2; Wed, 30 Dec 2020 21:24:18 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf] bpf: fix a task_iter bug caused by a merge conflict resolution
Date:   Wed, 30 Dec 2020 21:24:18 -0800
Message-ID: <20201231052418.577024-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-31_01:2020-12-30,2020-12-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxlogscore=581 mlxscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012310028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Latest bpf tree has a bug for bpf_iter selftest.
  $ ./test_progs -n 4/25
  test_bpf_sk_storage_get:PASS:bpf_iter_bpf_sk_storage_helpers__open_and_lo=
ad 0 nsec
  test_bpf_sk_storage_get:PASS:socket 0 nsec
  ...
  do_dummy_read:PASS:read 0 nsec
  test_bpf_sk_storage_get:FAIL:bpf_map_lookup_elem map value wasn't set cor=
rectly
                          (expected 1792, got -1, err=3D0)
  #4/25 bpf_sk_storage_get:FAIL
  #4 bpf_iter:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 2 FAILED

When doing merge conflict resolution, Commit 4bfc4714849d missed to
save curr_task to seq_file private data. The task pointer in seq_file
private data is passed to bpf program. This caused
NULL-pointer task passed to bpf program which will immediately return
upon checking whether task pointer is NULL.

This patch added back the assignment of curr_task to seq_file private data
and fixed the issue.

Fixes: 4bfc4714849d ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/b=
pf/bpf")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/task_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 3efe38191d1c..175b7b42bfc4 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -159,6 +159,7 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_in=
fo *info)
                 }
=20
                 /* set info->task and info->tid */
+		info->task =3D curr_task;
 		if (curr_tid =3D=3D info->tid) {
 			curr_fd =3D info->fd;
 		} else {
--=20
2.24.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BB2D4910
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 19:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgLIScU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 13:32:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30378 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733052AbgLIScP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 13:32:15 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B9IOm2T010624
        for <bpf@vger.kernel.org>; Wed, 9 Dec 2020 10:31:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wc0O2unk5ryFRxsza2jifcFMOPJyAyUPNkqeLvjRe7A=;
 b=AUA7qWKHrY/V76FsyLQ8CrRPLLoRor3gvJlI56Kj9us2lYvQkW8D+ZsPHM2CkVpdjTYj
 j7chusbYEIGqFSFFJUjCZTyN2wfRPzFhW2uo/mVMmG8du2jv3CBwNgzCimlIeVzvVrXt
 Ulj29MEYH+0vzabMr/T9PRFPia3ZUFTCZPc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ak7a6jye-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 10:31:30 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 10:31:28 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id C04E03705020; Wed,  9 Dec 2020 10:31:24 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add a test for ptr_to_map_value on stack for helper access
Date:   Wed, 9 Dec 2020 10:31:24 -0800
Message-ID: <20201209183124.3382023-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201209183124.3381965-1-yhs@fb.com>
References: <20201209183124.3381965-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_14:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=13 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=874
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012090131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change bpf_iter_task.c such that pointer to map_value may appear
on the stack for bpf_seq_printf() to access. Without previous
verifier patch, the bpf_iter test will fail.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/bpf_iter_task.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_task.c
index 4983087852a0..b7f32c160f4e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
@@ -11,9 +11,10 @@ int dump_task(struct bpf_iter__task *ctx)
 {
 	struct seq_file *seq =3D ctx->meta->seq;
 	struct task_struct *task =3D ctx->task;
+	static char info[] =3D "    =3D=3D=3D END =3D=3D=3D";
=20
 	if (task =3D=3D (void *)0) {
-		BPF_SEQ_PRINTF(seq, "    =3D=3D=3D END =3D=3D=3D\n");
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
 		return 0;
 	}
=20
--=20
2.24.1


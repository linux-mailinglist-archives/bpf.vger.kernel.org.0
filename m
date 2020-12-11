Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B677B2D6ED1
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 04:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405233AbgLKDmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 22:42:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405281AbgLKDmH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 22:42:07 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB3P9EE019252
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 19:41:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=60VBbKIIwJcZ4oLxq8srsUqv7aEvs/d+Xdi78HuEvOE=;
 b=IGY71WTaMFqN4QpcNsmOL+BGPsS8s6pcpiYtKw5Nt8ylD4SmyZlvhw/a83GjRtoFJIvV
 mxVcz3CNtqQGAF188ZRSBOato7csvhTStysy5fhEiNP2OosSp4vR9AHTeYbJ026c8Mdk
 pCEFizKUV5qqSpQzZYY8rHebN5la8gaN6pw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35avdhd61q-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 19:41:26 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 19:41:25 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B62783705741; Thu, 10 Dec 2020 19:41:22 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add a test for ptr_to_map_value on stack for helper access
Date:   Thu, 10 Dec 2020 19:41:22 -0800
Message-ID: <20201211034122.3452472-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201211034121.3452172-1-yhs@fb.com>
References: <20201211034121.3452172-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_01:2020-12-09,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=869 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=13 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012110019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change bpf_iter_task.c such that pointer to map_value may appear
on the stack for bpf_seq_printf() to access. Without previous
verifier patch, the bpf_iter test will fail.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/bpf_iter_task.c | 3 ++-
 tools/testing/selftests/bpf/verifier/unpriv.c     | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testin=
g/selftests/bpf/verifier/unpriv.c
index 91bb77c24a2e..a3fe0fbaed41 100644
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ b/tools/testing/selftests/bpf/verifier/unpriv.c
@@ -108,8 +108,9 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b =3D { 3 },
-	.errstr =3D "invalid indirect read from stack off -8+0 size 8",
-	.result =3D REJECT,
+	.errstr_unpriv =3D "invalid indirect read from stack off -8+0 size 8",
+	.result_unpriv =3D REJECT,
+	.result =3D ACCEPT,
 },
 {
 	"unpriv: mangle pointer on stack 1",
--=20
2.24.1


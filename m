Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510493629A0
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 22:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbhDPUsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 16:48:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239295AbhDPUsT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 16:48:19 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GKgkdJ029600
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 13:47:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=diBKIQZf7e/YrXBNNYKp1jPapJqEnZFZBOLFf/ivM70=;
 b=auUhl5gn+lNU+swIUeHiaAFkEcaHGncbDp3cyz+E3MshTf5U0zxJvcadKI3/SzkAGR63
 abcXnbu1yEfEYcVb2gnyZDvxl1uhO3T/qHzEiZ124DhG9Ic867eFqRo3PSeEhQ9NJe6E
 eHrWBVjp3TODUwXT2J9FI7IAmUeN5g5bqEo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37yb5j2jvs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 13:47:53 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 13:47:52 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 0B265A90304; Fri, 16 Apr 2021 13:47:45 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v2 3/3] bpf/selftests: add bpf_get_task_stack retval bounds test_prog
Date:   Fri, 16 Apr 2021 13:47:04 -0700
Message-ID: <20210416204704.2816874-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416204704.2816874-1-davemarchevsky@fb.com>
References: <20210416204704.2816874-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pv3WyxJjFISz-5hoykCfElw4AEc-W8nr
X-Proofpoint-ORIG-GUID: pv3WyxJjFISz-5hoykCfElw4AEc-W8nr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a libbpf test prog which feeds bpf_get_task_stack's return value
into seq_write after confirming it's positive. No attempt to bound the
value from above is made.

Load will fail if verifier does not refine retval range based on buf sz
input to bpf_get_task_stack.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       |  1 +
 .../selftests/bpf/progs/bpf_iter_task_stack.c | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 74c45d557a2b..2d3590cfb5e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -147,6 +147,7 @@ static void test_task_stack(void)
 		return;
=20
 	do_dummy_read(skel->progs.dump_task_stack);
+	do_dummy_read(skel->progs.get_task_user_stacks);
=20
 	bpf_iter_task_stack__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/to=
ols/testing/selftests/bpf/progs/bpf_iter_task_stack.c
index 50e59a2e142e..43c36f5f7649 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
@@ -35,3 +35,30 @@ int dump_task_stack(struct bpf_iter__task *ctx)
=20
 	return 0;
 }
+
+SEC("iter/task")
+int get_task_user_stacks(struct bpf_iter__task *ctx)
+{
+	struct seq_file *seq =3D ctx->meta->seq;
+	struct task_struct *task =3D ctx->task;
+	uint64_t buf_sz =3D 0;
+	int64_t res;
+
+	if (task =3D=3D (void *)0)
+		return 0;
+
+	res =3D bpf_get_task_stack(task, entries,
+			MAX_STACK_TRACE_DEPTH * SIZE_OF_ULONG, BPF_F_USER_STACK);
+	if (res <=3D 0)
+		return 0;
+
+	buf_sz +=3D res;
+
+	/* If the verifier doesn't refine bpf_get_task_stack res, and instead
+	 * assumes res is entirely unknown, this program will fail to load as
+	 * the verifier will believe that max buf_sz value allows reading
+	 * past the end of entries in bpf_seq_write call
+	 */
+	bpf_seq_write(seq, &entries, buf_sz);
+	return 0;
+}
--=20
2.30.2


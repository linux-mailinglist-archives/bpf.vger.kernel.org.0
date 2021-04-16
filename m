Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3679F3617E3
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 04:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhDPC4t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 22:56:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49886 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234548AbhDPC4s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 22:56:48 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13G2rer6008946
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 19:56:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VvTspJUH6Wl4gYYvQFQviOGptMsjn3QpbuBX/Pa7Qv0=;
 b=TDCWiqJqpt9U9G8hPyBDaKlpKC2c7O53umg9QCx1aJMADY5i4cpD2R1j3sdpagBoNwZl
 5m/QzCRxk1gJIvfdve8oSX0lqZiedKigiq0DM9AW1buEVlFvpCesQt6Boeap/uJUzhCW
 MT3DJ6eWchHb8bOMWX28etEqrn6hKPWwWoI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37wvd43f5e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 19:56:24 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 19:56:21 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id A7A93A2A6CA; Thu, 15 Apr 2021 19:56:16 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 3/3] bpf/selftests: add bpf_get_task_stack retval bounds test_prog
Date:   Thu, 15 Apr 2021 19:55:37 -0700
Message-ID: <20210416025537.2352753-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416025537.2352753-1-davemarchevsky@fb.com>
References: <20210416025537.2352753-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oh-BZYbqhR7Izg1GfeQn6nPcNcfH-epD
X-Proofpoint-GUID: oh-BZYbqhR7Izg1GfeQn6nPcNcfH-epD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160023
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
---
 .../selftests/bpf/prog_tests/bpf_iter.c       |  1 +
 .../selftests/bpf/progs/bpf_iter_task_stack.c | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

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
index 50e59a2e142e..c60048ed226f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
@@ -35,3 +35,25 @@ int dump_task_stack(struct bpf_iter__task *ctx)
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
+	bpf_seq_write(seq, &entries, buf_sz);
+	return 0;
+}
--=20
2.30.2


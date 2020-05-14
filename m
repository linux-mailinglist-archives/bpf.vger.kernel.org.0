Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CCE1D26AB
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 07:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgENFcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 01:32:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9748 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgENFcP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 01:32:15 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E5UtBv012375
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 22:32:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jHiBVRGlYsHFPO13+fZz7H9QrT08kIIXqqAFOGS0ZtM=;
 b=V8ydajJxKFU92LLzIg2QYSrsEsXSQTCTexiJ3OSZtl/uVrfCUbt2zzpjlzm3357zMW7U
 Ip3AC6Vwvh7q3OsZdaogs1+7zb8GZX962KwDV5n8tB/SQihpa4RjBVR8sJnQhgI3yOh4
 gbPWCZeutwIg449Ga+UNmKMPc2sGlbcCdHc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100y1scy1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 22:32:14 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 22:32:12 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 459323702424; Wed, 13 May 2020 22:32:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v2 2/2] selftests/bpf: enforce returning 0 for fentry/fexit programs
Date:   Wed, 13 May 2020 22:32:07 -0700
Message-ID: <20200514053207.1298479-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514053205.1298315-1-yhs@fb.com>
References: <20200514053205.1298315-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=13 phishscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=845 clxscore=1015
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140049
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are a few fentry/fexit programs returning non-0.
The tests with these programs will break with the previous
patch which enfoced return-0 rules. Fix them properly.

Fixes: ac065870d928 ("selftests/bpf: Add BPF_PROG, BPF_KPROBE, and BPF_KR=
ETPROBE macros")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/test_overhead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_overhead.c b/tools/te=
sting/selftests/bpf/progs/test_overhead.c
index 56a50b25cd33..abb7344b531f 100644
--- a/tools/testing/selftests/bpf/progs/test_overhead.c
+++ b/tools/testing/selftests/bpf/progs/test_overhead.c
@@ -30,13 +30,13 @@ int prog3(struct bpf_raw_tracepoint_args *ctx)
 SEC("fentry/__set_task_comm")
 int BPF_PROG(prog4, struct task_struct *tsk, const char *buf, bool exec)
 {
-	return !tsk;
+	return 0;
 }
=20
 SEC("fexit/__set_task_comm")
 int BPF_PROG(prog5, struct task_struct *tsk, const char *buf, bool exec)
 {
-	return !tsk;
+	return 0;
 }
=20
 char _license[] SEC("license") =3D "GPL";
--=20
2.24.1


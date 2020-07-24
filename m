Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD522CF0D
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgGXUIL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 16:08:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgGXUIK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jul 2020 16:08:10 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OJjnei017901
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 13:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Iuyw+uQSv2oOg1S+YzvxSbjoeQJp7NxGe48GJfiuYmI=;
 b=Bm1jrdFy85qpCEI6GkTCU1gQ5fmoj62yrN99LiHVthkiH4zEEWiBm3mNsJNPO7hlVQaw
 0whxlUFNW2Nliy2zb9qjB6lMKgxA28Jr08eVlVzRbd7lj3u70yNOq18nbyPehNBs4rL+
 HBsyMDMB8rvjLwyfILpnbvRYVL88OO/CvIA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32etbgbd5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 13:08:09 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 13:08:08 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6603662E4E74; Fri, 24 Jul 2020 13:05:47 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, Song Liu <songliubraving@fb.com>,
        kernel test robot <lkp@intel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: fix build on architectures with special bpf_user_pt_regs_t
Date:   Fri, 24 Jul 2020 13:05:02 -0700
Message-ID: <20200724200503.3629591-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_09:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Architectures like s390, powerpc, arm64, riscv have speical definition of
bpf_user_pt_regs_t. So we need to cast the pointer before passing it to
bpf_get_stack(). This is similar to bpf_get_stack_tp().

Fixes: 03d42fd2d83f ("bpf: Separate bpf_get_[stack|stackid] for perf even=
ts BPF")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/stackmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 5beb2f8c23da1..4fd830a62be2d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -678,6 +678,7 @@ const struct bpf_func_proto bpf_get_task_stack_proto =
=3D {
 BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
+	struct pt_regs *regs =3D (struct pt_regs *)(ctx->regs);
 	struct perf_event *event =3D ctx->event;
 	struct perf_callchain_entry *trace;
 	bool kernel, user;
@@ -685,7 +686,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_da=
ta_kern *, ctx,
 	__u64 nr_kernel;
=20
 	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
-		return __bpf_get_stack(ctx->regs, NULL, NULL, buf, size, flags);
+		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags);
=20
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -705,8 +706,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_da=
ta_kern *, ctx,
 		__u64 nr =3D trace->nr;
=20
 		trace->nr =3D nr_kernel;
-		err =3D __bpf_get_stack(ctx->regs, NULL, trace, buf,
-				      size, flags);
+		err =3D __bpf_get_stack(regs, NULL, trace, buf, size, flags);
=20
 		/* restore nr */
 		trace->nr =3D nr;
@@ -718,8 +718,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_da=
ta_kern *, ctx,
 			goto clear;
=20
 		flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		err =3D __bpf_get_stack(ctx->regs, NULL, trace, buf,
-				      size, flags);
+		err =3D __bpf_get_stack(regs, NULL, trace, buf, size, flags);
 	}
 	return err;
=20
--=20
2.24.1


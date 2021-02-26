Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF3325CE1
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 06:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhBZFN4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 00:13:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50582 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbhBZFN4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 00:13:56 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q55t3v014984
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rxytlf0nXyAifhAjbEL+BKJqGUZ7hoIQcPl9XrAFgQE=;
 b=GS8aCKzDpPSDXL54Gfba8E2j086rXAmfwEvQPcyb/Zkm304ZJj8rR8rko/Dr5KbX6QOZ
 Cj+p3d26inLj1T5c0M58xa+7IylUekpGmUZSL/0X+sVwCxJiMh7tJlCuCT6+fNJqNYv5
 YyeRPf+kBACXspKZzPoDwIvQdCdX9zS4Ku0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xd17mqu3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:15 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 21:13:13 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id AD8263705B54; Thu, 25 Feb 2021 21:13:09 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 04/12] bpf: change return value of verifier function add_subprog()
Date:   Thu, 25 Feb 2021 21:13:09 -0800
Message-ID: <20210226051309.3428543-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226051305.3428235-1-yhs@fb.com>
References: <20210226051305.3428235-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_01:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=623 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, verifier function add_subprog() returns 0 for success
and negative value for failure. Change the return value
to be the subprog number for success. This functionality will be
used in the next patch to save a call to find_subprog().

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3fc5d1b28b6c..dd860ce1f591 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1530,7 +1530,7 @@ static int add_subprog(struct bpf_verifier_env *env=
, int off)
 	}
 	ret =3D find_subprog(env, off);
 	if (ret >=3D 0)
-		return 0;
+		return ret;
 	if (env->subprog_cnt >=3D BPF_MAX_SUBPROGS) {
 		verbose(env, "too many subprograms\n");
 		return -E2BIG;
@@ -1538,7 +1538,7 @@ static int add_subprog(struct bpf_verifier_env *env=
, int off)
 	env->subprog_info[env->subprog_cnt++].start =3D off;
 	sort(env->subprog_info, env->subprog_cnt,
 	     sizeof(env->subprog_info[0]), cmp_subprogs, NULL);
-	return 0;
+	return env->subprog_cnt - 1;
 }
=20
 static int check_subprogs(struct bpf_verifier_env *env)
--=20
2.24.1


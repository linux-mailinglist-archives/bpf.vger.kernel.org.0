Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D313268E8
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZUuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:50:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65420 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhBZUuS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:50:18 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QKhnqd003999
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uYxon6aa6p1+1x/KExIiLnNj/+5XEr6DPPBnqrQ8reY=;
 b=T8JbXTKma1FonJYy1UDSL2RDQLdWbKtTxdxyhZnMN28+vDyrrZ4poUtqg4AsU2PYlNsP
 CmJbkU5mYkoFnHK8wxl5ACjNNYzhLSEnhh+aYG09KaIpqUujCTba5Ur2VtAc8Frng/ID
 kT564jCXCXJZ5Pd22U6GYp6K3ta1N91H6Z4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36x96c20w4-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:36 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 12:49:33 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 903803705324; Fri, 26 Feb 2021 12:49:24 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v5 04/12] bpf: change return value of verifier function add_subprog()
Date:   Fri, 26 Feb 2021 12:49:24 -0800
Message-ID: <20210226204924.3884848-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226204920.3884074-1-yhs@fb.com>
References: <20210226204920.3884074-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=617 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102260155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, verifier function add_subprog() returns 0 for success
and negative value for failure. Change the return value
to be the subprog number for success. This functionality will be
used in the next patch to save a call to find_subprog().

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 97e772f44cd7..dbdca49ac6cc 100644
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1502325CE4
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 06:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhBZFN5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 00:13:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42510 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBZFN4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 00:13:56 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q5A0IG009889
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Qom6yWPNhPDQFiLXkbqNSXzx0gAAqG4fSmWRAdOYu1w=;
 b=GbFGR158FkYi4ACpgZ99MFpqnWZvbyM9t923Ccb+x/wEwTrmYnO0tEEsv34rZ0hJlRzP
 tiZCmRCeRMSuo35HZaR0T0cZqo/H2qg73SjokTisBkmW9phmQkQYgySH2BQ1TEXD3/9/
 27I78dynroaGw8a3uWjvH0MuINBVFEWW3Kk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36x9cawr7h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:15 -0800
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 21:13:13 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 30B743705FFE; Thu, 25 Feb 2021 21:13:07 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v4 02/12] bpf: factor out verbose_invalid_scalar()
Date:   Thu, 25 Feb 2021 21:13:07 -0800
Message-ID: <20210226051307.3428406-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226051305.3428235-1-yhs@fb.com>
References: <20210226051305.3428235-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_01:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=804
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Factor out the function verbose_invalid_scalar() to verbose
print if a scalar is not in a tnum range. There is no
functionality change and the function will be used by
later patch which introduced bpf_for_each_map_elem().

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9cb182e91162..9b48c966fe15 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -390,6 +390,24 @@ __printf(3, 4) static void verbose_linfo(struct bpf_=
verifier_env *env,
 	env->prev_linfo =3D linfo;
 }
=20
+static void verbose_invalid_scalar(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *reg,
+				   struct tnum *range, const char *ctx,
+				   const char *reg_name)
+{
+	char tn_buf[48];
+
+	verbose(env, "At %s the register %s ", ctx, reg_name);
+	if (!tnum_is_unknown(reg->var_off)) {
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose(env, "has value %s", tn_buf);
+	} else {
+		verbose(env, "has unknown scalar value");
+	}
+	tnum_strn(tn_buf, sizeof(tn_buf), *range);
+	verbose(env, " should have been in %s\n", tn_buf);
+}
+
 static bool type_is_pkt_pointer(enum bpf_reg_type type)
 {
 	return type =3D=3D PTR_TO_PACKET ||
@@ -8455,17 +8473,7 @@ static int check_return_code(struct bpf_verifier_e=
nv *env)
 	}
=20
 	if (!tnum_in(range, reg->var_off)) {
-		char tn_buf[48];
-
-		verbose(env, "At program exit the register R0 ");
-		if (!tnum_is_unknown(reg->var_off)) {
-			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "has value %s", tn_buf);
-		} else {
-			verbose(env, "has unknown scalar value");
-		}
-		tnum_strn(tn_buf, sizeof(tn_buf), range);
-		verbose(env, " should have been in %s\n", tn_buf);
+		verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
 		return -EINVAL;
 	}
=20
--=20
2.24.1


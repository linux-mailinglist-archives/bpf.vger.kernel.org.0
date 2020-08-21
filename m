Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8039424E3A7
	for <lists+bpf@lfdr.de>; Sat, 22 Aug 2020 00:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHUW5C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 18:57:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726719AbgHUW5C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 18:57:02 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07LMipkq021582
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 15:57:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=qDxnkgHmT5FQe7I3faR7d8Kd/9DvmKx/sIeSq4WAaNk=;
 b=KTST7XWTeyesnxSo2iYL9xoeApchP+yTotiVKKYB4/Rx5lF8rvuF0P17RMmhtzIgLdFt
 KhW1/D8NVVXuQXPyOHX8+CIQwB1DQvM93kiXLDirdCpbr7AMzt+dHW5WByPtJRIfWdF9
 KuUYmObh0cDklnnnqMpSjUDa6o/Nh/pQOJU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 331hcc3fpv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 15:57:01 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 15:56:59 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id A7A742EC6002; Fri, 21 Aug 2020 15:56:54 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] libbpf: fix type compatibility check copy-paste error
Date:   Fri, 21 Aug 2020 15:56:53 -0700
Message-ID: <20200821225653.2180782-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_10:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 suspectscore=8 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008210213
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix copy-paste error in types compatibility check. Local type is accident=
ally
used instead of target type for the very first type check strictness chec=
k.
This can result in potentially less strict candidate comparison. Fix the
error.

Fixes: 3fc32f40c402 ("libbpf: Implement type-based CO-RE relocations supp=
ort")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 210429c5b772..ea80a1582af6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4603,7 +4603,7 @@ static int bpf_core_types_are_compat(const struct b=
tf *local_btf, __u32 local_id
=20
 	/* caller made sure that names match (ignoring flavor suffix) */
 	local_type =3D btf__type_by_id(local_btf, local_id);
-	targ_type =3D btf__type_by_id(local_btf, local_id);
+	targ_type =3D btf__type_by_id(targ_btf, targ_id);
 	if (btf_kind(local_type) !=3D btf_kind(targ_type))
 		return 0;
=20
--=20
2.24.1


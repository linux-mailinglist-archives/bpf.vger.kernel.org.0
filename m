Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809B34097E7
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbhIMPxa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:53:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40586 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343750AbhIMPxX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 11:53:23 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF4SQL005528
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:52:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MPd8CE2Vo023qXKlVuAYJuGnL6LJHYAqw0OghIKP5bM=;
 b=T54dtvC7NXTLZCSZB0QvbF6Ao2yysOReRsUJWTIw13skUtza8f12QlLFMwUGhCzc265M
 OCblKktnOg0qKiEtoL7OqBGo9pKWElwoJviAOjBvYaWuc0aZgK7O9+zrQsnqlaRGVE3F
 peXR7ENrUx+fYLN0xRYqiq3xuphcx9zJatY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1wgtbs8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:52:06 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 08:52:05 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id F02077279099; Mon, 13 Sep 2021 08:52:00 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 07/11] selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
Date:   Mon, 13 Sep 2021 08:52:00 -0700
Message-ID: <20210913155200.3728013-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913155122.3722704-1-yhs@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: HPht9csQTX8YXyblaLZA1BYjqT562GA4
X-Proofpoint-ORIG-GUID: HPht9csQTX8YXyblaLZA1BYjqT562GA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=805 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF_KIND_TAG ELF format has a component_idx which might have value -1.
test_btf may confuse it with common_type.name as NAME_NTH checkes
high 16bit to be 0xffff. Change NAME_NTH high 16bit check to be
0xfffe so it won't confuse with component_idx.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 649f87382c8d..ad39f4d588d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -39,8 +39,8 @@ static bool always_log;
 #define BTF_END_RAW 0xdeadbeef
 #define NAME_TBD 0xdeadb33f
=20
-#define NAME_NTH(N) (0xffff0000 | N)
-#define IS_NAME_NTH(X) ((X & 0xffff0000) =3D=3D 0xffff0000)
+#define NAME_NTH(N) (0xfffe0000 | N)
+#define IS_NAME_NTH(X) ((X & 0xffff0000) =3D=3D 0xfffe0000)
 #define GET_NAME_NTH_IDX(X) (X & 0x0000ffff)
=20
 #define MAX_NR_RAW_U32 1024
--=20
2.30.2


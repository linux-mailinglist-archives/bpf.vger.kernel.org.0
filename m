Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7E40BB70
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhINWcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:32:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40568 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235137AbhINWcG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 18:32:06 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EKSIv0002244
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gO9zZXYIw5zxS4DfbDW3POGeEqDbAUpKPRs1UNlgwUI=;
 b=U0rn3gHhM6ulQyMXJGWF5SkNIq5FcsznMFIEUr2AvM2+z+wLBUjnXobeATBRtL2lN+Ew
 aXZCG//pDs8a96DZkgC31fbCkj9WkYzeduaQEobns8PPpB8pTJEtveFB88mPvjvtxN4y
 iGfiOXBA8vwAON4VEPVnynK5LrXm4P6EybU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b32t40nwt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:47 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 15:30:46 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id F2542738224C; Tue, 14 Sep 2021 15:30:41 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 07/11] selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
Date:   Tue, 14 Sep 2021 15:30:41 -0700
Message-ID: <20210914223041.248009-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
References: <20210914223004.244411-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: JuUPhKodyPShyvfEVTzyM8ylTk0ojTcv
X-Proofpoint-ORIG-GUID: JuUPhKodyPShyvfEVTzyM8ylTk0ojTcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=799 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF_KIND_TAG ELF format has a component_idx which might have value -1.
test_btf may confuse it with common_type.name as NAME_NTH checkes
high 16bit to be 0xffff. Change NAME_NTH high 16bit check to be
0xfffe so it won't confuse with component_idx.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F172446E1BC
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 06:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhLIFHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 00:07:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30344 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229676AbhLIFHr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 00:07:47 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MnIFx027063
        for <bpf@vger.kernel.org>; Wed, 8 Dec 2021 21:04:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=LUG92XgGe0HpWFmbNnQLobG1GFcmHDFVRNeZKBuka34=;
 b=TpkY1jniF6B8G6GEF0Rw6lQWtkzDS2G1qSEl+4XBwQ0p5aM2hxl7tsD7jLXpr0l4VNGm
 b1RPUTY7fp/vZmGcLR8StylN46ZNiZ72Wl5nynNLwM3Tk3tLNXxS5j8pZ7tcv/h0E72J
 IIe6DkyvHI1ev76EgD3lsmWBnGf5VTeurA0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cu5u5sn36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 21:04:14 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 21:04:13 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id BEE22385AB8B; Wed,  8 Dec 2021 21:04:03 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix a compilation warning
Date:   Wed, 8 Dec 2021 21:04:03 -0800
Message-ID: <20211209050403.1770836-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: zcBd98QKriGHh8EOl6PApfsN3DAzgpfy
X-Proofpoint-ORIG-GUID: zcBd98QKriGHh8EOl6PApfsN3DAzgpfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_02,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=767 bulkscore=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following warning is triggered when I used clang compiler
to build the selftest.

  /.../prog_tests/btf_dedup_split.c:368:6: warning: variable 'btf2' is us=
ed uninitialized whenever 'if' condition is true [-Wsometimes-uninitializ=
ed]
        if (!ASSERT_OK(err, "btf_dedup"))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /.../prog_tests/btf_dedup_split.c:424:12: note: uninitialized use occur=
s here
        btf__free(btf2);
                  ^~~~
  /.../prog_tests/btf_dedup_split.c:368:2: note: remove the 'if' if its c=
ondition is always false
        if (!ASSERT_OK(err, "btf_dedup"))
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /.../prog_tests/btf_dedup_split.c:343:25: note: initialize the variable=
 'btf2' to silence this warning
        struct btf *btf1, *btf2;
                               ^
                                =3D NULL

Initialize local variable btf2 =3D NULL and the warning is gone.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/t=
ools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 878a864dae3b..90aac437576d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -340,7 +340,7 @@ static void btf_add_dup_struct_in_cu(struct btf *btf,=
 int start_id)
=20
 static void test_split_dup_struct_in_cu()
 {
-	struct btf *btf1, *btf2;
+	struct btf *btf1, *btf2 =3D NULL;
 	int err;
=20
 	/* generate the base data.. */
--=20
2.30.2


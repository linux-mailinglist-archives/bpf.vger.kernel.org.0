Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA96A49D18F
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 19:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiAZSTv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 13:19:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48222 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235901AbiAZSTv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 13:19:51 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QGHq9N002566
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 10:19:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=N7FD39xl1wIazm0gF6D6J08Ezu22M+1y8m3Jm3Ni0rM=;
 b=ZHrjsKdw75lD1rsS7cVKPxrL4Bw+s/i7w+foBv+CH12NMPrlUwgpbZI0vjQaZn+17zJX
 qxCVTq1iI1/NHXbvg1ffbfDhg1cwVxTqyDxj9U1jV9fKFhS1/OJAYVTMLjv2V+rP9b0f
 jACGnP0EQjNMgcBpGOlnvSZMzaSxvfPCCuU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtvbevq0e-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 10:19:50 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 10:19:49 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 4F9D55989F08; Wed, 26 Jan 2022 10:19:40 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix a clang compilation error
Date:   Wed, 26 Jan 2022 10:19:40 -0800
Message-ID: <20220126181940.4105997-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RXq7KDfRlWpZOuYYxsOiFnh661PnzATT
X-Proofpoint-ORIG-GUID: RXq7KDfRlWpZOuYYxsOiFnh661PnzATT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_06,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=794 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Compiling kernel and selftests/bpf with latest llvm like blow:
  make -j LLVM=3D1
  make -C tools/testing/selftests/bpf -j LLVM=3D1
I hit the following compilation error:
  /.../prog_tests/log_buf.c:215:6: error: variable 'log_buf' is used unin=
itialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitiali=
zed]
          if (!ASSERT_OK_PTR(raw_btf_data, "raw_btf_data_good"))
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /.../prog_tests/log_buf.c:264:7: note: uninitialized use occurs here
          free(log_buf);
               ^~~~~~~
  /.../prog_tests/log_buf.c:215:2: note: remove the 'if' if its condition=
 is always false
          if (!ASSERT_OK_PTR(raw_btf_data, "raw_btf_data_good"))
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /.../prog_tests/log_buf.c:205:15: note: initialize the variable 'log_bu=
f' to silence this warning
          char *log_buf;
                       ^
                        =3D NULL
  1 error generated.

Compiler rightfully detected that log_buf is uninitialized in one of fail=
ure path as indicated
in the above.

Proper initialization of 'log_buf' variable fixed the issue.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/log_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/tes=
ting/selftests/bpf/prog_tests/log_buf.c
index e469b023962b..1ef377a7e731 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -202,7 +202,7 @@ static void bpf_btf_load_log_buf(void)
 	const void *raw_btf_data;
 	__u32 raw_btf_size;
 	struct btf *btf;
-	char *log_buf;
+	char *log_buf =3D NULL;
 	int fd =3D -1;
=20
 	btf =3D btf__new_empty();
--=20
2.30.2


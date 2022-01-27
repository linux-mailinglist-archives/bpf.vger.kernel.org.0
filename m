Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27249E7AD
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiA0Qhf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 11:37:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbiA0Qhe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 11:37:34 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RGaedi031157
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 08:37:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=KnhRcazG6lt7WiZn8QYXkyxhQiHkh4SDlGWlADX/QzI=;
 b=le7FFIcFbyD4SIhLMGNe6mS6dkmx3zNLUb6RMMgqtT/f/zXiQNC84F0mkavvcAhghtR3
 JtRiTSKQC1z2fcPECip3b2RYkMGpTgfAFHTkMov6Xh+xFiUjEcZ0Ufp9y7Ofi3qnlVPN
 r/pjRfXUN4ctXq1w0DJA0X+khz28mafb37U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dukpkkgne-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 08:37:34 -0800
Received: from twshared3205.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 08:37:31 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 327925A29032; Thu, 27 Jan 2022 08:37:26 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix a clang compilation error
Date:   Thu, 27 Jan 2022 08:37:26 -0800
Message-ID: <20220127163726.1442032-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4F76xjxTZ9XlbwR2mZcQb8z3ByBLPcV5
X-Proofpoint-GUID: 4F76xjxTZ9XlbwR2mZcQb8z3ByBLPcV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=762
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When building selftests/bpf with clang
  make -j LLVM=3D1
  make -C tools/testing/selftests/bpf -j LLVM=3D1
I hit the following compilation error:

  trace_helpers.c:152:9: error: variable 'found' is used uninitialized wh=
enever 'while' loop exits because its condition is false [-Werror,-Wsomet=
imes-uninitialized]
          while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf,=
 &base) =3D=3D 4) {
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
  trace_helpers.c:161:7: note: uninitialized use occurs here
          if (!found)
               ^~~~~
  trace_helpers.c:152:9: note: remove the condition if it is always true
          while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf,=
 &base) =3D=3D 4) {
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
                 1
  trace_helpers.c:145:12: note: initialize the variable 'found' to silenc=
e this warning
          bool found;
                    ^
                     =3D false

It is possible that for sane /proc/self/maps we may never hit the above i=
ssue
in practice. But let us initialize variable 'found' properly to silence t=
he
compilation error.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/trace_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
index 65ab533c2516..ca6abae9b09c 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -142,7 +142,7 @@ ssize_t get_uprobe_offset(const void *addr)
 {
 	size_t start, end, base;
 	char buf[256];
-	bool found;
+	bool found =3D false;
 	FILE *f;
=20
 	f =3D fopen("/proc/self/maps", "r");
--=20
2.30.2


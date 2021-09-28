Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4841E41B5B6
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 20:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhI1SNT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 14:13:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46234 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242108AbhI1SNS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 14:13:18 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SBK17N026572
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 11:11:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=4qr4MU6aogZhDAGO6WItYzhZ+eg37fJQuNhUq4Xv0hU=;
 b=OjtOzSIuRBYdbXsgjsy6qlFhAJnnE0b0sMg3zKNlgm2MBqnGzFvejmWiPCrJPDhIrByZ
 UhAETLilgMTA5VO2wBN9dYhWCcYWE3r0AF5uFIrTyYotXA3ofKbJPBXYHOauxv2upOU2
 IZ22FOkjoa73AS3P2vQvWBgIDuY4us8UFpA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bc22wu7t0-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 11:11:38 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 11:11:37 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id F33BA461F1EF; Tue, 28 Sep 2021 11:11:30 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf] tools/bpftool: Avoid using "?:" in generated code
Date:   Tue, 28 Sep 2021 11:11:27 -0700
Message-ID: <20210928181127.1392891-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 6dBPs5DotYsK9Amr88xLJ5ujycwSJRQ8
X-Proofpoint-ORIG-GUID: 6dBPs5DotYsK9Amr88xLJ5ujycwSJRQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=439 impostorscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109280108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"?:" is a GNU C extension, some environment has warning flags for its
use, or even prohibit it directly.  This patch avoid triggering these
problems by simply expand it to its full form, no functionality change.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/bpf/bpftool/gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index d40d92bbf0e4..85071b6fa4ad 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -803,7 +803,7 @@ static int do_skeleton(int argc, char **argv)
 			}						    \n\
 									    \n\
 			err =3D %1$s__create_skeleton(obj);		    \n\
-			err =3D err ?: bpf_object__open_skeleton(obj->skeleton, opts);\n\
+			err =3D err ? err : bpf_object__open_skeleton(obj->skeleton, opts);\n=
\
 			if (err)					    \n\
 				goto err_out;				    \n\
 									    \n\
--=20
2.30.2


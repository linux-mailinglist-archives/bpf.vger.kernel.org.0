Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6050F41B675
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 20:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhI1SoU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 14:44:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230109AbhI1SoT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 14:44:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18SINPlh009423
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 11:42:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=2u4sqjlqbUhJLhW8TshINN2xCe0nl6v1kE1HB51EZGM=;
 b=HOXlOtCoBN5NgJMKdbStUCH1iS+Ja/o4s6BEyyQq00K/zU+O/lTQm1SleBXuwQzqscmc
 J44JHx7BXiBD0bpqlb34Zy6+whjqZwUhTfs2+/NsZwvs76SpzFHAmYnkOzh6oi1w6D6t
 TlM8h7rUkjKDv479iA5gLQ2yvKBT1XOr2Bo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3bby1j4hya-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 11:42:39 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 11:42:38 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 1BA3E4623C99; Tue, 28 Sep 2021 11:42:26 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next] tools/bpftool: Avoid using "?:" in generated code
Date:   Tue, 28 Sep 2021 11:42:21 -0700
Message-ID: <20210928184221.1545079-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: tKQhmt0ewlnI_or1IgQrrgato7JFjiJv
X-Proofpoint-ORIG-GUID: tKQhmt0ewlnI_or1IgQrrgato7JFjiJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=397 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"?:" is a GNU C extension, some environment has warning flags for its
use, or even prohibit it directly.  This patch avoid triggering these
problems by simply expand it to its full form, no functionality change.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/bpf/bpftool/gen.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index e3ec47a6a612..cc835859465b 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -803,7 +803,10 @@ static int do_skeleton(int argc, char **argv)
 			}						    \n\
 									    \n\
 			err =3D %1$s__create_skeleton(obj);		    \n\
-			err =3D err ?: bpf_object__open_skeleton(obj->skeleton, opts);\n\
+			if (err)					    \n\
+				goto err_out;				    \n\
+									    \n\
+			err =3D bpf_object__open_skeleton(obj->skeleton, opts);\n\
 			if (err)					    \n\
 				goto err_out;				    \n\
 									    \n\
--=20
2.30.2


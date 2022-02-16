Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030824B7C0E
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 01:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiBPAsM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 19:48:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiBPAsM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 19:48:12 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC529A4FD
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:48:00 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21G0QJsb001704
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:48:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Hsn20EyE55YrvL674mWeN+GHV/yGyWNlFYcGvDTPsO0=;
 b=YDSVVPRWTdNP/FL1kJ1denPQpU9XEFoytznx9E8Rv5CvwxNj754kD77GgTd8BvBlhjXh
 QEmzI4djMM+y+BfvL6jyQjLxzwJlk7ZvDXREyXG/Lixp4kRIV5ITiA90d+5ZjoRJJl/b
 waDA6PhR+5IuvLUz7gkVaR38YSYs628F3ig= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n3d0qbq-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:48:00 -0800
Received: from twshared14630.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 16:47:59 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id EC61138E9B69; Tue, 15 Feb 2022 16:47:47 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     <kernel-team@fb.com>, Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next] scripts/pahole-flags.sh: Enable parallelization of pahole.
Date:   Tue, 15 Feb 2022 16:46:16 -0800
Message-ID: <20220216004616.2079689-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zu9DovDv-RRYrr_pqhhFtOKLPnqDUTnS
X-Proofpoint-GUID: zu9DovDv-RRYrr_pqhhFtOKLPnqDUTnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_07,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=590 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160003
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pass a -j argument to pahole to parse DWARF and generate BTF with
multithreading.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 scripts/pahole-flags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index c293941612e7..73f237ce44e8 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
=20
-extra_paholeopt=3D
+extra_paholeopt=3D-j
=20
 if ! [ -x "$(command -v ${PAHOLE})" ]; then
 	exit 0
--=20
2.30.2


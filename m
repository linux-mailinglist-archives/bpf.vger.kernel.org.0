Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8052C4C05BD
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 01:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiBWAG3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 19:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiBWAG0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 19:06:26 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB0344D6
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 16:06:00 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MNjoOa031048
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 16:05:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=gfKuTWqioVQSwwAZVVlY7GYCbQm3Wqhu+xi+8qUOzNc=;
 b=jUvD9j5WK6V8xWog2FsfKF2x1R9aZnefG25wjsq/CSpTU3bRIDvcJGsxMS0pJmI2KIHd
 SAfmTRMOYvSZpLREf+FpzK0MscJJkO844cOVunUTNe15kBPMOu57OJi4dccrozqJvdtI
 QiQsOYzOcld8qzMFtmlIYOGalMaDDrPqtzU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ed4kcjd6f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 16:05:59 -0800
Received: from twshared33837.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 16:05:58 -0800
Received: by devvm4573.vll0.facebook.com (Postfix, from userid 200310)
        id CFF0C3DF86C1; Tue, 22 Feb 2022 16:05:48 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: workaround stdout issue in VM launched by vmtest.sh
Date:   Tue, 22 Feb 2022 16:05:44 -0800
Message-ID: <20220223000544.3524440-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: P4gmHjEmLecb6KP5Co-R8kY-tfRQMRDp
X-Proofpoint-GUID: P4gmHjEmLecb6KP5Co-R8kY-tfRQMRDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_08,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202220148
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This apply a workaround to fix stdout issue in `./vmtest.sh` invocations,
but doesn't work on `./vmtest.sh -s`

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selfte=
sts/bpf/vmtest.sh
index e0bb04a97e10..a9f943a84ed5 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -184,6 +184,10 @@ EOF
 	fi
=20
 	sudo bash -c "echo '#!/bin/bash' > ${init_script}"
+	sudo bash -c "cat >>${init_script}" <<EOF
+# Force rebinding stdout/stderr to /dev/ttyS0, to workaround a mysteriou=
s issue
+exec 1>/dev/ttyS0 2>/dev/ttyS0
+EOF
=20
 	if [[ "${command}" !=3D "" ]]; then
 		sudo bash -c "cat >>${init_script}" <<EOF
--=20
2.30.2


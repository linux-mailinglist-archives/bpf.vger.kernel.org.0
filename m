Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382A34BA523
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiBQPwr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 10:52:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBQPwq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 10:52:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32212DAB
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 07:52:30 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21H2Ij4i015041
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 07:52:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5W3PjkcFd+drHiib0ddkFs6cPITF0Vxvom4SBXidkNo=;
 b=TPbIfJnpv8ikXcSfiGYlXcG8oaBfWhmSsPs9hNdeWpcNJ6YBTRGPgiq6z3ZwafTkEiOM
 VvXVWILAsvm1ifXVVeLrS/nnJGUt5ukvG7TokPxqZYW54FU5YzZJAwW7ffgEyLJGwX34
 3lbpPFmeno/jinUHmYSr228sz8gW0s8mLKU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e9dfbc2fg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 07:52:29 -0800
Received: from twshared33837.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 07:52:28 -0800
Received: by devvm4573.vll0.facebook.com (Postfix, from userid 200310)
        id 964B03A33A9C; Thu, 17 Feb 2022 07:52:19 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: fix vmtest.sh to launch smp vm.
Date:   Thu, 17 Feb 2022 07:52:12 -0800
Message-ID: <20220217155212.2309672-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GfFDBZWbDZk8xRLQBwk0cT1kedctdtPU
X-Proofpoint-GUID: GfFDBZWbDZk8xRLQBwk0cT1kedctdtPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_06,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=594
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170072
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

Fix typo in vmtest.sh to make sure it launch proper vm with 8 cpus.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selfte=
sts/bpf/vmtest.sh
index b3afd43549fa..e0bb04a97e10 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -241,7 +241,7 @@ EOF
 		-nodefaults \
 		-display none \
 		-serial mon:stdio \
-		"${qemu_flags[@]}" \
+		"${QEMU_FLAGS[@]}" \
 		-enable-kvm \
 		-m 4G \
 		-drive file=3D"${rootfs_img}",format=3Draw,index=3D1,media=3Ddisk,if=3D=
virtio,cache=3Dnone \
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC834B9141
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 20:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiBPTfJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 14:35:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiBPTfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 14:35:08 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19A1F3F36
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 11:34:55 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GFj1NG016413
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 11:34:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=e4iolRkqqJWqaZZf0PphO2YeQAJY3KJhw8a+r5Bp/Gg=;
 b=omUI7q/sWs7vtumKqqnPdQ16e22hvvAoylxKc5tvEvAhAeEm6g670FZdJ0452A5E453P
 d0watHAi0wCKyYrZ8Le8Td8AHuVzQck5q8lLm4ZXmZY0uHfiLO0PunaY9Xkqsn2JbhYr
 YzN/pXgTKZm6dEsROBcBqJoPnWjqTKFJMGY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n3gxyr0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 11:34:54 -0800
Received: from twshared6457.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 11:34:51 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 21D76396657C; Wed, 16 Feb 2022 11:34:48 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     <kernel-team@fb.com>, Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH v2 bpf-next] scripts/pahole-flags.sh: Enable parallelization of pahole.
Date:   Wed, 16 Feb 2022 11:34:31 -0800
Message-ID: <20220216193431.2691015-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eKHRi-ImYs4CGIz0aWEiAlVYPDvYIYaJ
X-Proofpoint-GUID: eKHRi-ImYs4CGIz0aWEiAlVYPDvYIYaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_09,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=575 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160110
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

v2 checks the version of pahole to apply -j only if >=3D v1.22.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index c293941612e7..264c05020263 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -16,5 +16,8 @@ fi
 if [ "${pahole_ver}" -ge "121" ]; then
 	extra_paholeopt=3D"${extra_paholeopt} --btf_gen_floats"
 fi
+if [ "${pahole_ver}" -ge "122" ]; then
+    extra_paholeopt=3D"${extra_paholeopt} -j"
+fi
=20
 echo ${extra_paholeopt}
--=20
2.30.2


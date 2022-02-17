Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA604BA790
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiBQR4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 12:56:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiBQR4B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 12:56:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957C2B1039
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 09:55:46 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HFqla1014623
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 09:55:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=SWAMB/nP9yx3IyKflikmIOYUgwFYVsQzhsXmL4P1BGA=;
 b=kkRYvUV97ekuLvAYReNRC6okBO2m4sL02IE4r17zjoyIYpgqIEKQsexIGglpO/hnEUSh
 NGA+QQ6pYtUhs0YT1NX+QFafBSdUvk3DUIE37EFA0g9xOIcg3x7Do5hgPo0xLklcukWu
 bGvshmuGsPwJIlSIbiju4+RexqI9K29RSGM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e9dfbd03k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 09:55:45 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 09:55:45 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 20DE43DC1A4D; Thu, 17 Feb 2022 09:55:40 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     <kernel-team@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v3 bpf-next] scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.
Date:   Thu, 17 Feb 2022 09:54:27 -0800
Message-ID: <20220217175427.649713-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gbIC9U8qpRICWdjhpJvuOPuhlTys4usk
X-Proofpoint-GUID: gbIC9U8qpRICWdjhpJvuOPuhlTys4usk
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_06,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=817
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170082
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

Pass a "-j" argument to pahole if possible to reduce the time of
generating BTF info.

Since v1.22, pahole can parse DWARF and generate BTF with
multithreading to speed up the conversion.  It will reduce the overall
build time of the kernel for seconds.

v3 fixes whitespaces and improves the commit description.
v2 checks the version of pahole to enable multithreading only if possible.

[v2] https://lore.kernel.org/bpf/20220216193431.2691015-1-kuifeng@fb.com/
[v1] https://lore.kernel.org/bpf/20220216004616.2079689-1-kuifeng@fb.com/

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index c293941612e7..0d99ef17e4a5 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -16,5 +16,8 @@ fi
 if [ "${pahole_ver}" -ge "121" ]; then
 	extra_paholeopt=3D"${extra_paholeopt} --btf_gen_floats"
 fi
+if [ "${pahole_ver}" -ge "122" ]; then
+	extra_paholeopt=3D"${extra_paholeopt} -j"
+fi
=20
 echo ${extra_paholeopt}
--=20
2.30.2


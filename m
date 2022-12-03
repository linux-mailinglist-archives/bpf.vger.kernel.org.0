Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C842664187C
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 19:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLCSqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 13:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiLCSqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 13:46:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E752017E1E
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 10:46:23 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B3GIkeq016998
        for <bpf@vger.kernel.org>; Sat, 3 Dec 2022 10:46:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/foy6PqlTpOiEcU5FFzaizzuHD4PNOXkAahnvgbR6Cw=;
 b=exS2JdeGpC8X7u88Ds/OptqUZn1GECRlkm99xEJpfTEQo2CY7cttBWwsJzGUHUxnqQpZ
 G5ThW3JRkJAL+wjZEVW+vaAyVIKCmrinpLqEawathcwJvhyTuJmfyC4TCF2N6S0k3b+k
 y/bVhzxZYnZKzlPVKIWhO6fWHUpjeZCMyPI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m82ntaxqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 03 Dec 2022 10:46:23 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 10:46:23 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 10:46:22 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 14B6C1320E743; Sat,  3 Dec 2022 10:46:13 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 3/3] docs/bpf: Add KF_RCU documentation
Date:   Sat, 3 Dec 2022 10:46:13 -0800
Message-ID: <20221203184613.478967-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221203184557.476871-1-yhs@fb.com>
References: <20221203184557.476871-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s8IFNyaoqy53bSFBEZ-dwrnbYiyizUby
X-Proofpoint-GUID: s8IFNyaoqy53bSFBEZ-dwrnbYiyizUby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-03_10,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add proper KF_RCU documentation in kfuncs.rst.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/kfuncs.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 90774479ab7a..b027fe16ee66 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -191,6 +191,15 @@ rebooting or panicking. Due to this additional restr=
ictions apply to these
 calls. At the moment they only require CAP_SYS_BOOT capability, but more=
 can be
 added later.
=20
+2.4.8 KF_RCU flag
+-----------------
+
+The KF_RCU flag is used for kfuncs which have a rcu ptr as its argument.
+When used together with KF_ACQUIRE, it indicates the kfunc should have a
+single argument which must be a trusted argument or a MEM_RCU pointer.
+The argument may have reference count of 0 and the kfunc must take this
+into consideration.
+
 2.5 Registering the kfuncs
 --------------------------
=20
--=20
2.30.2


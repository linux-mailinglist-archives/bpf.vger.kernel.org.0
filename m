Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C032263FC6B
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 01:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLBADj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 19:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLBADi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 19:03:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BD3BE4C0
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 16:03:36 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1N4QU2010501
        for <bpf@vger.kernel.org>; Thu, 1 Dec 2022 16:03:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=SDHTha50dDXmyqJ6f4tyWn6/RqDV0QGNCA8qMZkV8DQ=;
 b=htq76D1MGUQ0xZiYzmXCst+pUxuet73FJB1ryuXDQ0Sml8YvYuDv2fkmS3VS7S0WHTTc
 Br8mL6v9ivFD8etqm7+6gsNbsjyjBmLWkl91hJ6vyf4rm2fG+ire5xji+S7bhyBTg0eV
 0f2E7MIWaZLFFCJD2CApQG68Cy6sTLgVYVk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6qebyt92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 16:03:35 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 16:03:35 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 4181DBF45655; Thu,  1 Dec 2022 16:03:26 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Change the name kprobe_multi_test/bench_attach to kprobe_multi_bench_attach in DENYLIST.
Date:   Thu, 1 Dec 2022 16:02:48 -0800
Message-ID: <20221202000249.3865528-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DvgFYnxCPvj20-vKrUb_EAGPYPt5_SWi
X-Proofpoint-ORIG-GUID: DvgFYnxCPvj20-vKrUb_EAGPYPt5_SWi
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the test case was renamed, the DENYLIST should be updated as well.

The test log of selftests before udpate.

 - https://github.com/kernel-patches/bpf/actions/runs/3578436190/jobs/60188=
48635 (aarch64-gcc)
 - https://github.com/kernel-patches/bpf/actions/runs/3578436190/jobs/60188=
49210 (aarch64-llvm-16)

The test log of selftests after update.

 - https://github.com/kernel-patches/bpf/actions/runs/3595023593/jobs/60553=
27754 (aarch64-gcc)
 - https://github.com/kernel-patches/bpf/actions/runs/3595023593/jobs/60553=
28464 (aarch64-llvm-16)

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 ci/vmtest/configs/DENYLIST | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/vmtest/configs/DENYLIST b/ci/vmtest/configs/DENYLIST
index d12cf9fae5ee..1ce9cefd457f 100644
--- a/ci/vmtest/configs/DENYLIST
+++ b/ci/vmtest/configs/DENYLIST
@@ -1,6 +1,6 @@
 # TEMPORARY
 btf_dump/btf_dump: syntax
-kprobe_multi_test/bench_attach
+kprobe_multi_bench_attach
 core_reloc/enum64val
 core_reloc/size___diff_sz
 core_reloc/type_based___diff_sz
--=20
2.30.2


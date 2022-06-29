Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE85E55F88F
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 09:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiF2HMb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 03:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2HMY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 03:12:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB7D13C
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 00:12:22 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25SKq1dX006968
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 00:12:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ryM3F2juoCXGltReAjJEPFW8MZMilEFT1PQOZTMcXQ8=;
 b=SH1IzueNfPDNW2loFHu8LVTtl0wTCo0L2Cwlj7UOHW2faX2t4KKmPv6J4I9t42qYtXUy
 y6s/jAMWtRd1GLOTAwAloQgUX2/v8cLVfvV0dAgCZVuVdEQfdKD4gDKCmnNGnlMHsyaB
 S0WDTnI+8HuHBA5nXgi8AOzR0Vr6LUiqGyM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h03ru589a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 00:12:22 -0700
Received: from twshared25478.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 29 Jun 2022 00:12:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1C550C24D703; Wed, 29 Jun 2022 00:12:19 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v3 1/2] libbpf: Sync with latest libbpf repo
Date:   Wed, 29 Jun 2022 00:12:19 -0700
Message-ID: <20220629071219.3179028-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220629071213.3178592-1-yhs@fb.com>
References: <20220629071213.3178592-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4PCxtZs98_fsVWmHV1TSx2y-lQzHyyT_
X-Proofpoint-GUID: 4PCxtZs98_fsVWmHV1TSx2y-lQzHyyT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_11,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync up to commit
  645500dd7d2d ci: blacklist mptcp test on s390x

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 87dff0a..645500d 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 87dff0a2c775c5943ca9233e69c81a25f2ed1a77
+Subproject commit 645500dd7d2d6b5bb76e4c0375d597d4f0c4814e
--=20
2.30.2


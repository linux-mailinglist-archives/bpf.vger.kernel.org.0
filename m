Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F067523FDB
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiEKWC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 18:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiEKWC4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 18:02:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768F313F5B
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 15:02:55 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BJfw3F007788
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 15:02:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=BpSYOXyg6wnT7RS6o6SrXwZrXLpUQf9GZTa0R/0RJu4=;
 b=FpVDJBxjffDE1AKMe7I0CIntf6qDOAVSVC2PEWPQh3vJ6TGEA1Ty7Wrt4WTe07EAqlop
 7+si63cvXFCNU+h4fYrsTfrWc+clN8Blzo6yteK3OPRTzqwRqUsNlccs1yURUzSAbbKr
 YJbDN0/1mEUeaq8MAl1CEdlJz0425EhhCr0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g0gat2qnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 15:02:54 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 15:02:53 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id C9078A2C7776; Wed, 11 May 2022 15:02:43 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 1/2] libbpf: Sync with latest libbpf repo
Date:   Wed, 11 May 2022 15:02:43 -0700
Message-ID: <20220511220243.525215-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BJfCiPD00-1_VZaFPeFP9volUXs0g_7T
X-Proofpoint-GUID: BJfCiPD00-1_VZaFPeFP9volUXs0g_7T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync up to commit 87dff0a2c775 (vmtest: allow building foreign debian roo=
tfs).

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 393a058..87dff0a 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 393a058d061d49d5c3055fa9eefafb4c0c31ccc3
+Subproject commit 87dff0a2c775c5943ca9233e69c81a25f2ed1a77
--=20
2.30.2


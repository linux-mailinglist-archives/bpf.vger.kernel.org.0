Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31235A8136
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiHaP1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiHaP1i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 11:27:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F13D7D3D
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:34 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27VEgxmX002355
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qDok8Iq5w17SAnHEfnuZ66U119jMnfMCQ5dCfMHVvxU=;
 b=cqYd4Ns0rDq3MvI6ymxknsCU4Q6kEPm1oVIhQkEUxe8VPbyxUbNbPDHWOYUimZPAVO1k
 aJv7c+3fX4Djcbs6VkKEYsp9uzT8v+nZ6JyoxPmFZ+UhI04QhEsy5gg0aKycjP6IRl8p
 EEcZU8rk9BCDCaCpByYpsWUf0BpP+M6s70E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j9nkryfad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:34 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 08:27:33 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A66D5ECDED70; Wed, 31 Aug 2022 08:27:23 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Add tracing_struct test in DENYLIST.s390x
Date:   Wed, 31 Aug 2022 08:27:23 -0700
Message-ID: <20220831152723.2081551-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831152641.2077476-1-yhs@fb.com>
References: <20220831152641.2077476-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yiHvCCHu_6r92-Xzk4S9at_JLnGXWPQW
X-Proofpoint-ORIG-GUID: yiHvCCHu_6r92-Xzk4S9at_JLnGXWPQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tracing_struct test in DENYLIST.s390x since s390x does not
support trampoline now.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
index 736b65f61022..aa18b6d24510 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -68,3 +68,4 @@ unpriv_bpf_disabled                      # fentry
 setget_sockopt                           # attach unexpected error: -524=
                                               (trampoline)
 cb_refs                                  # expected error message unexpe=
cted error: -524                               (trampoline)
 cgroup_hierarchical_stats                # JIT does not support calling =
kernel function                                (kfunc)
+tracing_struct                           # failed to auto-attach: -524  =
                                               (trampoline)
--=20
2.30.2


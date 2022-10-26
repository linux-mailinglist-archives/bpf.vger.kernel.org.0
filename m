Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB12860DA4B
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 06:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiJZE3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 00:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiJZE33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 00:29:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6209DC0A
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:28 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PMGw93013391
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qGChYlxKI2BtcewqWCZ50PZm6LrXi5cZt2/dwE4n31I=;
 b=ozrQ9LBTogC3/C29aGtjpp+Oe6XCfuR5XbnJocI9McWteRhn2yAXoZfQ8u276rXAeNyT
 nWkS/fYBNbiF2cmybPUXi7Z1XQ6lysDnI1KocYfaDMjjUqSphIpeLTGKhQH+WO++nW+Z
 Pgagb3L9nzMsa6WPZQuo1Ut1Z/5fc9CqlwM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3keb4jumaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:27 -0700
Received: from twshared0933.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:29:26 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 354901131B8B5; Tue, 25 Oct 2022 21:29:17 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v6 8/9] selftests/bpf: Add test cgrp_local_storage to DENYLIST.s390x
Date:   Tue, 25 Oct 2022 21:29:17 -0700
Message-ID: <20221026042917.675685-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221026042835.672317-1-yhs@fb.com>
References: <20221026042835.672317-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hUDcPQalEMUxjytznhbaiO0O2ZtCNeCO
X-Proofpoint-ORIG-GUID: hUDcPQalEMUxjytznhbaiO0O2ZtCNeCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_02,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test cgrp_local_storage have some programs utilizing trampoline.
Arch s390x does not support trampoline so add the test to
the corresponding DENYLIST file.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
index 520f12229b98..be4e3d47ea3e 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -10,6 +10,7 @@ bpf_nf                                   # JIT does not=
 support calling kernel f
 bpf_tcp_ca                               # JIT does not support calling =
kernel function                                (kfunc)
 cb_refs                                  # expected error message unexpe=
cted error: -524                               (trampoline)
 cgroup_hierarchical_stats                # JIT does not support calling =
kernel function                                (kfunc)
+cgrp_local_storage                       # prog_attach unexpected error:=
 -524                                          (trampoline)
 core_read_macros                         # unknown func bpf_probe_read#4=
                                               (overlapping)
 d_path                                   # failed to auto-attach program=
 'prog_stat': -524                             (trampoline)
 deny_namespace                           # failed to attach: ERROR: stre=
rror_r(-524)=3D22                                (trampoline)
--=20
2.30.2


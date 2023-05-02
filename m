Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6C6F4D70
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjEBXJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjEBXJ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:09:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A1D30CD
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:09:24 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JXxaq015448
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:09:24 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qak8d9vc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:09:24 -0700
Received: from twshared7331.15.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:09:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CF89A2FD4BD02; Tue,  2 May 2023 16:06:31 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 05/10] bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
Date:   Tue, 2 May 2023 16:06:14 -0700
Message-ID: <20230502230619.2592406-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502230619.2592406-1-andrii@kernel.org>
References: <20230502230619.2592406-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: T6KiCLmc6zKBOdHeZuLo3RPZdk_WcZC_
X-Proofpoint-ORIG-GUID: T6KiCLmc6zKBOdHeZuLo3RPZdk_WcZC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Seems like that extra bpf_capable() check in BPF_MAP_FREEZE handler was
unintentionally left when we switched to a model that all BPF map
operations should be allowed regardless of CAP_BPF (or any other
capabilities), as long as process got BPF map FD somehow.

This patch replaces bpf_capable() check in BPF_MAP_FREEZE handler with
writeable access check, given conceptually freezing the map is modifying
it: map becomes unmodifiable for subsequent updates.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ffc61a764fe5..2e5ca52c45c4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2001,6 +2001,11 @@ static int map_freeze(const union bpf_attr *attr)
 		return -ENOTSUPP;
 	}
 
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
 	mutex_lock(&map->freeze_mutex);
 	if (bpf_map_write_active(map)) {
 		err = -EBUSY;
@@ -2010,10 +2015,6 @@ static int map_freeze(const union bpf_attr *attr)
 		err = -EBUSY;
 		goto err_put;
 	}
-	if (!bpf_capable()) {
-		err = -EPERM;
-		goto err_put;
-	}
 
 	WRITE_ONCE(map->frozen, true);
 err_put:
-- 
2.34.1


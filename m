Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4966BD832
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 19:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCPSd2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Mar 2023 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCPSd1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 14:33:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C82332B
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:21 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32GI7H16006551
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:21 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3pbs3cdjxe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:20 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 11:33:19 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1D8AE2AC19636; Thu, 16 Mar 2023 11:30:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 4/6] libbpf: don't enfore verifier log levels on libbpf side
Date:   Thu, 16 Mar 2023 11:30:11 -0700
Message-ID: <20230316183013.2882810-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316183013.2882810-1-andrii@kernel.org>
References: <20230316183013.2882810-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vcCCwvURNUC9iO95TtfC4GV7dIyO2iqI
X-Proofpoint-ORIG-GUID: vcCCwvURNUC9iO95TtfC4GV7dIyO2iqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_02,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This basically prevents any forward compatibility. And we either way
just return -EINVAL, which would otherwise be returned from bpf()
syscall anyways.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index e750b6f5fcc3..eb08a998b526 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -290,8 +290,6 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 
 	if (!!log_buf != !!log_size)
 		return libbpf_err(-EINVAL);
-	if (log_level > (4 | 2 | 1))
-		return libbpf_err(-EINVAL);
 	if (log_level && !log_buf)
 		return libbpf_err(-EINVAL);
 
-- 
2.34.1


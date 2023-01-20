Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033C675EAA
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjATUKR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjATUKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:10:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59ABC767
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:14 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KI7PHl011377
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:13 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7gdededb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:13 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:10:11 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0016725B4B246; Fri, 20 Jan 2023 12:10:06 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 25/25] libbpf: clean up now not needed __PT_PARM{1-6}_SYSCALL_REG defaults
Date:   Fri, 20 Jan 2023 12:09:14 -0800
Message-ID: <20230120200914.3008030-26-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tacj9fzyAcZCCoNsWk2p8NV8gBrCVQgN
X-Proofpoint-ORIG-GUID: tacj9fzyAcZCCoNsWk2p8NV8gBrCVQgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Each architecture supports at least 6 syscall argument registers, so now
that specs for each architecture is defined in bpf_tracing.h, remove
unnecessary macro overrides, which previously were required to keep
existing BPF_KSYSCALL() uses compiling and working.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index b37d3c78b19a..6db88f41fa0d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -476,24 +476,6 @@ struct pt_regs;
  *
  * See syscall(2) manpage for succinct table with information on each arch.
  */
-#ifndef __PT_PARM1_SYSCALL_REG
-#define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
-#endif
-#ifndef __PT_PARM2_SYSCALL_REG
-#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
-#endif
-#ifndef __PT_PARM3_SYSCALL_REG
-#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
-#endif
-#ifndef __PT_PARM4_SYSCALL_REG
-#define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
-#endif
-#ifndef __PT_PARM5_SYSCALL_REG
-#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
-#endif
-#ifndef __PT_PARM6_SYSCALL_REG
-#define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
-#endif
 #ifndef __PT_PARM7_SYSCALL_REG
 #define __PT_PARM7_SYSCALL_REG __unsupported__
 #endif
-- 
2.30.2


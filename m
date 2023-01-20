Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB5675E94
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjATUJa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjATUJa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BBB743B3
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:29 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30KI7Hbs027768
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:28 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3n6vyjvdnj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:28 -0800
Received: from twshared16837.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:27 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E4E0A25B4B0A3; Fri, 20 Jan 2023 12:09:23 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 04/25] libbpf: complete mips spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:08:53 -0800
Message-ID: <20230120200914.3008030-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XBsFkjRm7HFA5susnBH4EvQNF-t-LujB
X-Proofpoint-GUID: XBsFkjRm7HFA5susnBH4EvQNF-t-LujB
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
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

Add registers for PARM6 through PARM8. Add a link to an ABI. We don't
distinguish between O32, N32, and N64, so document that we assume N64
right now.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index a263f600e309..f356955b059a 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -201,11 +201,19 @@ struct pt_regs___arm64 {
 
 #elif defined(bpf_target_mips)
 
+/*
+ * N64 ABI is assumed right now.
+ * https://en.wikipedia.org/wiki/MIPS_architecture#Calling_conventions
+ */
+
 #define __PT_PARM1_REG regs[4]
 #define __PT_PARM2_REG regs[5]
 #define __PT_PARM3_REG regs[6]
 #define __PT_PARM4_REG regs[7]
 #define __PT_PARM5_REG regs[8]
+#define __PT_PARM6_REG regs[9]
+#define __PT_PARM7_REG regs[10]
+#define __PT_PARM8_REG regs[11]
 #define __PT_RET_REG regs[31]
 #define __PT_FP_REG regs[30]	/* Works only with CONFIG_FRAME_POINTER */
 #define __PT_RC_REG regs[2]
-- 
2.30.2


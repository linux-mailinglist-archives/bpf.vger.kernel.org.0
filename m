Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B865C675E90
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjATUJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATUJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:25 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A7812875
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:24 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KIN3Ca013834
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:24 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7ycmgwa2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:24 -0800
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:22 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CC30E25B4B00E; Fri, 20 Jan 2023 12:09:19 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 02/25] libbpf: add 6th argument support for x86-64 in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:08:51 -0800
Message-ID: <20230120200914.3008030-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SYYqKQrUxIoSuMJ1fP8hub6RxxoDwsY9
X-Proofpoint-ORIG-GUID: SYYqKQrUxIoSuMJ1fP8hub6RxxoDwsY9
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

Add r9 as register containing 6th argument on x86-64 architecture, as
per its ABI. Add also a link to a page describing ABI for easier future
reference.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index ef17d8fdd9d6..a47504c2f3cb 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -78,6 +78,10 @@
 
 #if defined(bpf_target_x86)
 
+/*
+ * https://en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI
+ */
+
 #if defined(__KERNEL__) || defined(__VMLINUX_H__)
 
 #define __PT_PARM1_REG di
@@ -85,6 +89,7 @@
 #define __PT_PARM3_REG dx
 #define __PT_PARM4_REG cx
 #define __PT_PARM5_REG r8
+#define __PT_PARM6_REG r9
 #define __PT_RET_REG sp
 #define __PT_FP_REG bp
 #define __PT_RC_REG ax
@@ -115,6 +120,7 @@
 #define __PT_PARM3_REG rdx
 #define __PT_PARM4_REG rcx
 #define __PT_PARM5_REG r8
+#define __PT_PARM6_REG r9
 #define __PT_RET_REG rsp
 #define __PT_FP_REG rbp
 #define __PT_RC_REG rax
-- 
2.30.2


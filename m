Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6607D53BEFB
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 21:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiFBTku convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Jun 2022 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiFBTkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 15:40:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7F24BD7
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 12:39:50 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 252C0SGc024871
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 12:39:50 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gevu4u016-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 12:39:50 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 12:39:48 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id AE1C286C00B8; Thu,  2 Jun 2022 12:37:13 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <rostedt@goodmis.org>, <jolsa@kernel.org>,
        <mhiramat@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/5] ftrace: allow customized flags for ftrace_direct_multi ftrace_ops
Date:   Thu, 2 Jun 2022 12:37:02 -0700
Message-ID: <20220602193706.2607681-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602193706.2607681-1-song@kernel.org>
References: <20220602193706.2607681-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: waEllGuq6kmiaybnaJQvdZ4D2Z737o_s
X-Proofpoint-GUID: waEllGuq6kmiaybnaJQvdZ4D2Z737o_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This enables users of ftrace_direct_multi to specify the flags based on
the actual use case. For example, some users may not set flag IPMODIFY.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/trace/ftrace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2fcd17857ff6..afe782ae28d3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5456,8 +5456,7 @@ int modify_ftrace_direct(unsigned long ip,
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 
-#define MULTI_FLAGS (FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_DIRECT | \
-		     FTRACE_OPS_FL_SAVE_REGS)
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {
@@ -5547,7 +5546,7 @@ int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	}
 
 	ops->func = call_direct_funcs;
-	ops->flags = MULTI_FLAGS;
+	ops->flags |= MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
 
 	err = register_ftrace_function(ops);
-- 
2.30.2


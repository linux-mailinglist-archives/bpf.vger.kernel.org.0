Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF034675E97
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjATUJk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjATUJj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816712875
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:38 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KK5C8f001039
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:38 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n702vk0h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:38 -0800
Received: from twshared16837.02.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 36D2225B4B0D8; Fri, 20 Jan 2023 12:09:36 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 10/25] libbpf: add BPF_UPROBE and BPF_URETPROBE macro aliases
Date:   Fri, 20 Jan 2023 12:08:59 -0800
Message-ID: <20230120200914.3008030-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 78eW1yeycIMgtZ_c-usrCpp9zjmWd6AK
X-Proofpoint-ORIG-GUID: 78eW1yeycIMgtZ_c-usrCpp9zjmWd6AK
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

Add BPF_UPROBE and BPF_URETPROBE macros, aliased to BPF_KPROBE and
BPF_KRETPROBE, respectively. This makes uprobe-based BPF program code
much less confusing, especially to people new to tracing, at no cost in
terms of maintainability. We'll use this macro in selftests in
subsequent patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 510df96ff19d..9c4246fe8799 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -781,4 +781,11 @@ ____##name(struct pt_regs *ctx, ##args)
 
 #define BPF_KPROBE_SYSCALL BPF_KSYSCALL
 
+/* BPF_UPROBE and BPF_URETPROBE are identical to BPF_KPROBE and BPF_KRETPROBE,
+ * but are named way less confusingly for SEC("uprobe") and SEC("uretprobe")
+ * use cases.
+ */
+#define BPF_UPROBE(name, args...)  BPF_KPROBE(name, ##args)
+#define BPF_URETPROBE(name, args...)  BPF_KRETPROBE(name, ##args)
+
 #endif
-- 
2.30.2


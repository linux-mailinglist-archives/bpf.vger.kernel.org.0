Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E804DDC57
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 16:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiCRPCp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 18 Mar 2022 11:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbiCRPCo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 11:02:44 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971D1C8ABD
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 08:01:25 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I15JrP032052
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 08:01:25 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3evg3skb1p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 08:01:24 -0700
Received: from twshared12717.14.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 08:01:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 745D21473B30D; Fri, 18 Mar 2022 08:01:08 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpftool: add BPF_TRACE_KPROBE_MULTI to attach type names table
Date:   Fri, 18 Mar 2022 08:01:06 -0700
Message-ID: <20220318150106.2933343-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sLYb77UqiqXbqkojHLFSViJyvF0P6gs6
X-Proofpoint-GUID: sLYb77UqiqXbqkojHLFSViJyvF0P6gs6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_10,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_TRACE_KPROBE_MULTI is a new attach type name, add it to bpftool's
table. This fixes a currently failing CI bpftool check.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 606743c6db41..b091923c71cb 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -56,7 +56,6 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_CGROUP_UDP6_RECVMSG]	= "recvmsg6",
 	[BPF_CGROUP_GETSOCKOPT]		= "getsockopt",
 	[BPF_CGROUP_SETSOCKOPT]		= "setsockopt",
-
 	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
 	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
 	[BPF_SK_SKB_VERDICT]		= "sk_skb_verdict",
@@ -76,6 +75,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_SK_REUSEPORT_SELECT]	= "sk_skb_reuseport_select",
 	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_skb_reuseport_select_or_migrate",
 	[BPF_PERF_EVENT]		= "perf_event",
+	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_bulti",
 };
 
 void p_err(const char *fmt, ...)
-- 
2.30.2


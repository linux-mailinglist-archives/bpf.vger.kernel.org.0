Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C26A87E6
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 18:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCBR2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 12:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjCBR2U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 12:28:20 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D496C22030;
        Thu,  2 Mar 2023 09:28:19 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pXmj4-0002by-1k; Thu, 02 Mar 2023 18:28:18 +0100
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     <netfilter-devel@vger.kernel.org>, Florian Westphal <fw@strlen.de>
Subject: [PATCH RFC v2 bpf-next 2/3] libbpf: sync header file, add nf prog section name
Date:   Thu,  2 Mar 2023 18:27:56 +0100
Message-Id: <20230302172757.9548-3-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302172757.9548-1-fw@strlen.de>
References: <20230302172757.9548-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/include/uapi/linux/bpf.h | 12 ++++++++++++
 tools/lib/bpf/libbpf.c         |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c9699304aed2..b063c6985769 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
+	BPF_PROG_TYPE_NETFILTER,
 };
 
 enum bpf_attach_type {
@@ -1049,6 +1050,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_PERF_EVENT = 7,
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
+	BPF_LINK_TYPE_NETFILTER = 10,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1543,6 +1545,11 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__u32		pf;
+				__u32		hooknum;
+				__s32		prio;
+			} netfilter;
 		};
 	} link_create;
 
@@ -6373,6 +6380,11 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 pf;
+			__u32 hooknum;
+			__s32 priority;
+		} netfilter;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05c4db355f28..a2cbd6fe6a51 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8570,6 +8570,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
+	SEC_DEF("netfilter",		NETFILTER, 0, SEC_NONE),
 };
 
 static size_t custom_sec_def_cnt;
-- 
2.39.2


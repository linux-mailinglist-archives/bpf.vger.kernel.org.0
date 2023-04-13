Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA406E0EDB
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjDMNff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 09:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjDMNey (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 09:34:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E7B765;
        Thu, 13 Apr 2023 06:33:03 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pmx4L-00017m-Ft; Thu, 13 Apr 2023 15:32:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     netfilter-devel@vger.kernel.org, bpf@vger.kernel.org,
        dxu@dxuuu.xyz, qde@naccy.de, Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf-next v2 5/6] tools: bpftool: print netfilter link info
Date:   Thu, 13 Apr 2023 15:32:27 +0200
Message-Id: <20230413133228.20790-6-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413133228.20790-1-fw@strlen.de>
References: <20230413133228.20790-1-fw@strlen.de>
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

Dump protocol family, hook and priority value:
$ bpftool link
2: type 10  prog 20
        pf: 2, hook 1, prio -128

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/bpf/bpftool/link.c       | 24 ++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
 tools/lib/bpf/libbpf.c         |  1 +
 3 files changed, 40 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index f985b79cca27..a2ea85d1ebbf 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -135,6 +135,18 @@ static void show_iter_json(struct bpf_link_info *info, json_writer_t *wtr)
 	}
 }
 
+static void show_netfilter_json(const struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_uint_field(json_wtr, "pf",
+			 info->netfilter.pf);
+	jsonw_uint_field(json_wtr, "hook",
+			 info->netfilter.hooknum);
+	jsonw_int_field(json_wtr, "prio",
+			 info->netfilter.priority);
+	jsonw_uint_field(json_wtr, "flags",
+			 info->netfilter.flags);
+}
+
 static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 {
 	__u32 len = sizeof(*info);
@@ -195,6 +207,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 				 info->netns.netns_ino);
 		show_link_attach_type_json(info->netns.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_NETFILTER:
+		show_netfilter_json(info, json_wtr);
+		break;
+
 	default:
 		break;
 	}
@@ -301,6 +317,14 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		printf("\n\tnetns_ino %u  ", info->netns.netns_ino);
 		show_link_attach_type_plain(info->netns.attach_type);
 		break;
+	case BPF_LINK_TYPE_NETFILTER:
+		printf("\n\tpf: %d, hook %u, prio %d",
+		       info->netfilter.pf,
+		       info->netfilter.hooknum,
+		       info->netfilter.priority);
+		if (info->netfilter.flags)
+			printf(" flags 0x%x", info->netfilter.flags);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3823100b7934..c93febc4c75f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
+	BPF_PROG_TYPE_NETFILTER,
 };
 
 enum bpf_attach_type {
@@ -1050,6 +1051,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_PERF_EVENT = 7,
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
+	BPF_LINK_TYPE_NETFILTER = 10,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1560,6 +1562,13 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__u32		pf;
+				__u32		hooknum;
+				__s32		prio;
+				__u32		flags;
+				__u64		reserved[2];
+			} netfilter;
 		};
 	} link_create;
 
@@ -6410,6 +6419,12 @@ struct bpf_link_info {
 		struct {
 			__u32 map_id;
 		} struct_ops;
+		struct {
+			__u32 pf;
+			__u32 hooknum;
+			__s32 priority;
+			__u32 flags;
+		} netfilter;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49cd304ae3bc..ae27451002ae 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8641,6 +8641,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
+	SEC_DEF("netfilter",		NETFILTER, 0, SEC_NONE),
 };
 
 static size_t custom_sec_def_cnt;
-- 
2.39.2


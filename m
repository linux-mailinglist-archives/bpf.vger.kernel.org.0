Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A176ED1FC
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDXQFh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjDXQFg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB196EA1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A45861B3C
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CC7C433D2;
        Mon, 24 Apr 2023 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352332;
        bh=LO+VFQYdH3MN8xOtSlZeI39Xncak2pqlFCQR+qwnkJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNKcp4edyJGBGLN7tYxBvemjEccZ2QWo0rag/MSR+l1niBUMRMeH6nlolufAPzrj0
         UnyHgzcDFzlPKCk071NhzxNJ7vUT4nB4BwGM4LcnN8kAaQnrJtU+wj1sU0jqtco+ze
         7dKWo0dZvMGYvEVFewDoMo9ff35o8Lcg7OP88W/6M4A+t+aYkC168XoPsnUcU4pWu8
         F8wVBQxrXFxqk8xaUumlcaguaI9uCQ2IeNOslQ1JDn4rQEpI869365g5haAlM2KfbT
         afs5T79aBTEPMqR3wjb4TTLNRbsjBoXTS2oNdlzSkDgzzeHAo+aFgoHL8omqAy//1n
         f8y8Au88NjHyw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 04/20] libbpf: Update uapi bpf.h tools header
Date:   Mon, 24 Apr 2023 18:04:31 +0200
Message-Id: <20230424160447.2005755-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Updating uapi bpf.h tools header with new uprobe_multi
link interface.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1bb11a6ee667..77ce2159478d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1035,6 +1035,7 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
+	BPF_TRACE_UPROBE_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1052,6 +1053,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
 	BPF_LINK_TYPE_NETFILTER = 10,
+	BPF_LINK_TYPE_UPROBE_MULTI = 11,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1169,6 +1171,11 @@ enum bpf_link_type {
  */
 #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
 
+/* link_create.uprobe_multi.flags used in LINK_CREATE command for
+ * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
+ */
+#define BPF_F_UPROBE_MULTI_RETURN	(1U << 0)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
@@ -1568,6 +1575,14 @@ union bpf_attr {
 				__s32		priority;
 				__u32		flags;
 			} netfilter;
+			struct {
+				__u32		flags;
+				__u32		cnt;
+				__aligned_u64	paths;
+				__aligned_u64	offsets;
+				__aligned_u64	ref_ctr_offsets;
+				__aligned_u64	cookies;
+			} uprobe_multi;
 		};
 	} link_create;
 
-- 
2.40.0


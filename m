Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064866ED203
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjDXQGZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDXQGY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCB5FE4
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0BB619FC
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DD6C433EF;
        Mon, 24 Apr 2023 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352382;
        bh=AqRLMtmRhgwygSKYtfSyTQDKQgYEwziG5bQpBxvD168=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqhOrlPEwKPOk/kpXh+NpXSTlT/bD3IZEnERg8AWGKH6dPcRNOmGg4IZFclZVNTnu
         BVSPq21aWZCwTamvEOLuGU8SPN5o+IsoFYFXcq00lySjiwOwEWy+n2QvtiGgzBhC7h
         PkMGcXuHspLvI7/Xpctq+h3dA/QfFA5G4otysBBn3xBiyYe8xoXC/5jW/yhUOwY5bN
         RlcMP6yBmZ8gsTMrpMnUFpuH1u2USHZstf2NRrUQKmRrvJnsWi60rvtLO5ISxhZVtb
         VsSvbDBC4pa0HAC0RaS1i1zjkD2edi7TzCyV5nEBYUH1tEILDEA49xFNbSr9WoJPI6
         JvuiLlNYlbnhQ==
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
Subject: [RFC/PATCH bpf-next 09/20] libbpf: Add bpf_link_create support for multi uprobes
Date:   Mon, 24 Apr 2023 18:04:36 +0200
Message-Id: <20230424160447.2005755-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding new uprobe_multi struct to bpf_link_create_opts object
to pass multiple uprobe data to link_create attr uapi.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 10 ++++++++++
 tools/lib/bpf/bpf.h | 10 +++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 128ac723c4ea..de227846fa3b 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -722,6 +722,16 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, kprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_UPROBE_MULTI:
+		attr.link_create.uprobe_multi.flags = OPTS_GET(opts, uprobe_multi.flags, 0);
+		attr.link_create.uprobe_multi.cnt = OPTS_GET(opts, uprobe_multi.cnt, 0);
+		attr.link_create.uprobe_multi.paths = ptr_to_u64(OPTS_GET(opts, uprobe_multi.paths, 0));
+		attr.link_create.uprobe_multi.offsets = ptr_to_u64(OPTS_GET(opts, uprobe_multi.offsets, 0));
+		attr.link_create.uprobe_multi.ref_ctr_offsets = ptr_to_u64(OPTS_GET(opts, uprobe_multi.ref_ctr_offsets, 0));
+		attr.link_create.uprobe_multi.cookies = ptr_to_u64(OPTS_GET(opts, uprobe_multi.cookies, 0));
+		if (!OPTS_ZEROED(opts, uprobe_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a2c091389b18..9404096b2cf0 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -332,13 +332,21 @@ struct bpf_link_create_opts {
 			const unsigned long *addrs;
 			const __u64 *cookies;
 		} kprobe_multi;
+		struct {
+			__u32 flags;
+			__u32 cnt;
+			const char **paths;
+			const unsigned long *offsets;
+			const unsigned long *ref_ctr_offsets;
+			const __u64 *cookies;
+		} uprobe_multi;
 		struct {
 			__u64 cookie;
 		} tracing;
 	};
 	size_t :0;
 };
-#define bpf_link_create_opts__last_field kprobe_multi.cookies
+#define bpf_link_create_opts__last_field uprobe_multi.cookies
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
-- 
2.40.0


Return-Path: <bpf+bounces-5454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D775AD25
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD83D28191D
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4874217AD9;
	Thu, 20 Jul 2023 11:38:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA7174E9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34C5C433C8;
	Thu, 20 Jul 2023 11:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689853089;
	bh=iP3gI3pTLno2B8mn+SXQ8iYnLezJaUekPmXI27B8z18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzWVagCC65va7K7CVGVjvEc/ayo+ZGLUX9xLO5F861YZRlDoJ+ZTDETj2Fk5yfIi8
	 ceU+J8zI6WGA35lBlkIVnphimJff8ZOuNQDO+5QRaFHNWjGFthbsUcf4xs6W1nCA62
	 43jPuQjTYNYJGnRGhBTab208imeJjF1KeqRh3D+GfV6ALp2auAEyXRJuYu2ab8qWU9
	 K70I3+s/0sF/HSHCT/JrHjvMCrBcX6Xok1+GQ4g3WLoyBfqY50jUNhe7OYxVmpZwHt
	 BNLvBeTMwshEIk9G4Zg2V8q6nk/WV4OSklrDsJuVNRoLXQXM/i4NyElEAei93BFgof
	 r+rjFEf6rgFvQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 13/28] libbpf: Add bpf_link_create support for multi uprobes
Date: Thu, 20 Jul 2023 13:35:35 +0200
Message-ID: <20230720113550.369257-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720113550.369257-1-jolsa@kernel.org>
References: <20230720113550.369257-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding new uprobe_multi struct to bpf_link_create_opts object
to pass multiple uprobe data to link_create attr uapi.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 11 +++++++++++
 tools/lib/bpf/bpf.h | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 3b0da19715e1..3a2da530bf5f 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -733,6 +733,17 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, kprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_UPROBE_MULTI:
+		attr.link_create.uprobe_multi.flags = OPTS_GET(opts, uprobe_multi.flags, 0);
+		attr.link_create.uprobe_multi.cnt = OPTS_GET(opts, uprobe_multi.cnt, 0);
+		attr.link_create.uprobe_multi.path = ptr_to_u64(OPTS_GET(opts, uprobe_multi.path, 0));
+		attr.link_create.uprobe_multi.offsets = ptr_to_u64(OPTS_GET(opts, uprobe_multi.offsets, 0));
+		attr.link_create.uprobe_multi.ref_ctr_offsets = ptr_to_u64(OPTS_GET(opts, uprobe_multi.ref_ctr_offsets, 0));
+		attr.link_create.uprobe_multi.cookies = ptr_to_u64(OPTS_GET(opts, uprobe_multi.cookies, 0));
+		attr.link_create.uprobe_multi.pid = OPTS_GET(opts, uprobe_multi.pid, 0);
+		if (!OPTS_ZEROED(opts, uprobe_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index c676295ab9bf..4d5c439c0765 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -346,6 +346,15 @@ struct bpf_link_create_opts {
 			const unsigned long *addrs;
 			const __u64 *cookies;
 		} kprobe_multi;
+		struct {
+			__u32 flags;
+			__u32 cnt;
+			const char *path;
+			const unsigned long *offsets;
+			const unsigned long *ref_ctr_offsets;
+			const __u64 *cookies;
+			__u32 pid;
+		} uprobe_multi;
 		struct {
 			__u64 cookie;
 		} tracing;
@@ -358,7 +367,7 @@ struct bpf_link_create_opts {
 	};
 	size_t :0;
 };
-#define bpf_link_create_opts__last_field kprobe_multi.cookies
+#define bpf_link_create_opts__last_field uprobe_multi.pid
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
-- 
2.41.0



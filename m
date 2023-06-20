Return-Path: <bpf+bounces-2890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD0736665
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE42810C7
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AFBBE62;
	Tue, 20 Jun 2023 08:37:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D5A92D
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E92C433C8;
	Tue, 20 Jun 2023 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250253;
	bh=A2Jx8O/za5xOv/x7nAQNjLOaUfH7Kx/T6Bd6yMcIq90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7FR0jcXiYN1nB3xlzCLkZmqtLMzsDjvnpsv++ZqR1kVgtFssshuKIb98ReGwuNpL
	 /ejfAoIOSXIh/odA6TrsioOm4W3ePm9o2oLsUREul9/ob4Un+rfbWHORiQZ3feRYa0
	 lMRnT6Q5jmC48bShkxBlYtGq/EAgOc4gXcC36xhSkadTFJ8j1oeNKms4ql+7ylaZ2T
	 Oyy4YQTalJilcBRL3GMenxCXcmky2uOR+Hq8LGK5li50RcA32abmpQw/IZSUQs9DbJ
	 F2N/mCVjl8w/0hHyaHhGR4vA/RKuzKKqIdCpdljy/sxx+nJNb+93Qq91YbaeL1xBVd
	 ihdCQSKyVbQhw==
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
Subject: [PATCHv2 bpf-next 10/24] libbpf: Add bpf_link_create support for multi uprobes
Date: Tue, 20 Jun 2023 10:35:36 +0200
Message-ID: <20230620083550.690426-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding new uprobe_multi struct to bpf_link_create_opts object
to pass multiple uprobe data to link_create attr uapi.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 11 +++++++++++
 tools/lib/bpf/bpf.h | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ed86b37d8024..0fd35c91f50c 100644
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
index 9aa0ee473754..82979b4f2769 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -346,13 +346,22 @@ struct bpf_link_create_opts {
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
 	};
 	size_t :0;
 };
-#define bpf_link_create_opts__last_field kprobe_multi.cookies
+#define bpf_link_create_opts__last_field uprobe_multi.pid
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
-- 
2.41.0



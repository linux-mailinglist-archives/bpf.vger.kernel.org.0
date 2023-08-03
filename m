Return-Path: <bpf+bounces-6808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812C76E1B5
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C14F1C214D1
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED959134DA;
	Thu,  3 Aug 2023 07:36:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8CB125A5
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFCAC433C7;
	Thu,  3 Aug 2023 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048195;
	bh=kS46N1o+M01ZmsvoKyuB9PlBcUzMc5VPHvHAomf7JsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmeIB0QbmX3+jP8/Jo34HpsOTkFN0SBcRCWXOCSnJae0W8zEpRCztHS//8PHVvDGW
	 jObGK11pP4BcodYE7kb4mPmLYKpB8zO7jFm5ROw/LA7b4x8+rFJSG6OSAzrD/GeahO
	 KipadDEPj5+RISoo7ekG6yB8qkkF9rPJlxmr/uR9nFcrf7HPRKAWOSEUqEmQoznvHo
	 +TM98plWQEKsSOxWF4B0CuEzhM/9GmQTcWd8E6A/nmOSCrUm8ClRlFteAnGqSvI6KR
	 VPgCvh1ma69bWi8Oe0QhGApzzzXkRmrtOmDgzBDEGsvakpIN9Gv05TLS1KRKFOUoin
	 8bFE6oqmONe0A==
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
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv6 bpf-next 13/28] libbpf: Add bpf_link_create support for multi uprobes
Date: Thu,  3 Aug 2023 09:34:05 +0200
Message-ID: <20230803073420.1558613-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803073420.1558613-1-jolsa@kernel.org>
References: <20230803073420.1558613-1-jolsa@kernel.org>
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
index c9b6b311a441..b0f1913763a3 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -767,6 +767,17 @@ int bpf_link_create(int prog_fd, int target_fd,
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
index 044a74ffc38a..74c2887cfd24 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -392,6 +392,15 @@ struct bpf_link_create_opts {
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
@@ -409,7 +418,7 @@ struct bpf_link_create_opts {
 	};
 	size_t :0;
 };
-#define bpf_link_create_opts__last_field kprobe_multi.cookies
+#define bpf_link_create_opts__last_field uprobe_multi.pid
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
-- 
2.41.0



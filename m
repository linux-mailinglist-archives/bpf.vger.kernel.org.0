Return-Path: <bpf+bounces-7305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB67755B3
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787C3281B6A
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457E182A3;
	Wed,  9 Aug 2023 08:36:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA026AAB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1F0C433C7;
	Wed,  9 Aug 2023 08:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570218;
	bh=kS46N1o+M01ZmsvoKyuB9PlBcUzMc5VPHvHAomf7JsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqR/sNFKWebaHJK2shjrn0iyxznaT/9HIAValo0qHuQ8rN19LI1uZoPcMQdrAoVi3
	 dybmkRLqrXKjVIfysTKlsd/346DAK08lfbmVV14qeq6Zj7lDKR1ZypbxKO0sp4JqC2
	 RLt6kYI/NnhdDKjVIHkHaeE4YJGfjJ8KizZSvb2jE++wIhwYbHwQWPSHq72s9ifjec
	 azo5DDwjmh/OvTxA3VW+mFFsEYl0Ce4gxZIetQGunUG7OeqGkX0D1teSPGjvBR2OC5
	 g4CdJgCDDDBKDcGgb/LJNBzYE0G3FrIbtJtsi8pKNkU6ukAL6psPD0Hsb/qcrr/tmq
	 AkR8QgciHWACw==
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
Subject: [PATCHv7 bpf-next 13/28] libbpf: Add bpf_link_create support for multi uprobes
Date: Wed,  9 Aug 2023 10:34:25 +0200
Message-ID: <20230809083440.3209381-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
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



Return-Path: <bpf+bounces-6368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DB7685C2
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DC61C209E4
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126E2119;
	Sun, 30 Jul 2023 13:45:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CC363
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3236C433C9;
	Sun, 30 Jul 2023 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724709;
	bh=vmugc6jxgx13ipJJtpDTvjTS10L7/3Asxl8XSeTBeuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7gEejaytVig7ck6Xu8oIGZ45lfL9jmKKlnPhSspG6wwha2DSIPKPfW2VwM9f7am9
	 6VSaVWpH4NcQdgTTEL+HDLXxbqF9HJ6U6DqF1Ki0lONpY2bJSJLL81zT5tTytzRlq2
	 D/gKN1WvKY2E/27HopKH5aHc7kmN3pgvbcOvCGdx+9zVZPmNLI5tar5yOW+4H/lkYc
	 o5+poH5P95YtQiUE1rzZ0XzRDCBfNJFiPuRD8N5RdgjiwGzy+uYhK1AQRttzvUChl+
	 +6ImA3yPyOD6rcV9GKLityZO/IyLePBkUuihRZfIsbc8v2w48jxJA31eDzfjUSR/QY
	 CVZRGBh/aLC/A==
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
Subject: [PATCHv5 bpf-next 16/28] libbpf: Add uprobe multi link detection
Date: Sun, 30 Jul 2023 15:42:11 +0200
Message-ID: <20230730134223.94496-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730134223.94496-1-jolsa@kernel.org>
References: <20230730134223.94496-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe-multi link detection. It will be used later in
bpf_program__attach_usdt function to check and use uprobe_multi
link over standard uprobe links.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 36 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d7b1a159d001..d1bb6eb7cde2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4819,6 +4819,39 @@ static int probe_perf_link(void)
 	return link_fd < 0 && err == -EBADF;
 }
 
+static int probe_uprobe_multi_link(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
+		.expected_attach_type = BPF_TRACE_UPROBE_MULTI,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, link_fd, err;
+	unsigned long offset = 0;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), &load_opts);
+	if (prog_fd < 0)
+		return -errno;
+
+	/* Creating uprobe in '/' binary should fail with -EBADF. */
+	link_opts.uprobe_multi.path = "/";
+	link_opts.uprobe_multi.offsets = &offset;
+	link_opts.uprobe_multi.cnt = 1;
+
+	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
+	err = -errno; /* close() can clobber errno */
+
+	if (link_fd >= 0)
+		close(link_fd);
+	close(prog_fd);
+
+	return link_fd < 0 && err == -EBADF;
+}
+
 static int probe_kern_bpf_cookie(void)
 {
 	struct bpf_insn insns[] = {
@@ -4915,6 +4948,9 @@ static struct kern_feature_desc {
 	[FEAT_SYSCALL_WRAPPER] = {
 		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
 	},
+	[FEAT_UPROBE_MULTI_LINK] = {
+		"BPF multi-uprobe link support", probe_uprobe_multi_link,
+	},
 };
 
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ead551318fec..f0f08635adb0 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -355,6 +355,8 @@ enum kern_feature_id {
 	FEAT_BTF_ENUM64,
 	/* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) */
 	FEAT_SYSCALL_WRAPPER,
+	/* BPF multi-uprobe link support */
+	FEAT_UPROBE_MULTI_LINK,
 	__FEAT_CNT,
 };
 
-- 
2.41.0



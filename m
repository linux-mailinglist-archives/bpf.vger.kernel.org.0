Return-Path: <bpf+bounces-6811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D876E1D1
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C744A1C214CB
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20660134CD;
	Thu,  3 Aug 2023 07:37:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA39454
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72F7C433C8;
	Thu,  3 Aug 2023 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048228;
	bh=vmugc6jxgx13ipJJtpDTvjTS10L7/3Asxl8XSeTBeuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfucvavJ8JqeOGr7mYg4qbf3BUkYGM+TgZq/84lZ4Zi03EcHYmVH2JlL8e+QOrZwj
	 h+19LCsV2SgplVY7s2acUXDYn4jirQLBtNvNm/kFzZ0Rif5ug6rFloUwTClA87qLp3
	 IaXZoSTdbmJb/OyAGH3gprW5XMxWTthAIaqA9loknuB9VtDzf5SZv5JpRFxrjFr++c
	 xoTPuJjBnsiWxOO5E4eraQXEg6q0QDMnW0/VV2cIZatJb20ruAYTGlVrBcd07ZEfq3
	 Mf4Ovc4jhF2WXYHp3zMx0pzMOG16pJcUdaYjTDrffFpL1FSUjKiE00RkS0xrfOc5Aa
	 A/wSPdYsHwI/A==
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
Subject: [PATCHv6 bpf-next 16/28] libbpf: Add uprobe multi link detection
Date: Thu,  3 Aug 2023 09:34:08 +0200
Message-ID: <20230803073420.1558613-17-jolsa@kernel.org>
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



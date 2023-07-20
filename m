Return-Path: <bpf+bounces-5457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1C75AD28
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D677F1C213D3
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8817FE2;
	Thu, 20 Jul 2023 11:38:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2179174E9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F326FC433C7;
	Thu, 20 Jul 2023 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689853120;
	bh=+ldYR/Y4dDoNaaaY9XQJQUNDn8aG26HT/0k2SRXNkuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLNTxLVSN0NIygMSh857Jcj3178foHqMUOj8qHSIZEaZj9gXDdSC9lCI5OOEAEQPa
	 HlMKD6+DkoIWF3JDSNqMHJ5e6rOtuU8STXKKqCduKVcHnvIc22fSpmuYG+DGddZPWl
	 xr6t/3eRWN/P2PeklwI44m3JVUUPVRbpO3KFXlb/5KtzZJYAeCCWl7x/PqjzgzX4Q9
	 +B12m7V5C8eexB8cOfjX7pszFBQ3VFzLvIdHQ11djLXWbvsmi0THpzUn0l2U3e330m
	 c6wEqtYkMuvvFHp6tnZfXkRDbJxfqX56glh2xOzpie+thL4oquCgdYbhIMCBimPhCa
	 uuBSWM0MVHAZQ==
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
Subject: [PATCHv4 bpf-next 16/28] libbpf: Add uprobe multi link detection
Date: Thu, 20 Jul 2023 13:35:38 +0200
Message-ID: <20230720113550.369257-17-jolsa@kernel.org>
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

Adding uprobe-multi link detection. It will be used later in
bpf_program__attach_usdt function to check and use uprobe_multi
link over standard uprobe links.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 36 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 527f02960156..8be253a19e9e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4816,6 +4816,39 @@ static int probe_perf_link(void)
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
@@ -4912,6 +4945,9 @@ static struct kern_feature_desc {
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



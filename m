Return-Path: <bpf+bounces-2893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46D73666A
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E41C20B57
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE9BE62;
	Tue, 20 Jun 2023 08:38:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7C4400
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934AFC433C8;
	Tue, 20 Jun 2023 08:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250282;
	bh=uO+8Th2NqoNTdu0300lnGgBvDFBT0ANoSG5DGFrGOcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1HQzxPmS9cbji+aj9d/KLmEhOTFpBwssEb8nBl19RirOsioX7To2cQPNX39QWkb+
	 FrT3WMrgzqtqHtgWjWQmoFNoL4EHRRTf6otiRw88WT18a+iQMU2QE++QdSGIqlXybM
	 BG/JNuw6M6FHHnf6ndq4QGbBjHr0wjvhnj3QvbiC3qKIMb0sfm78FmQrgv3AKYX2+N
	 rUgVKzl2QSOVuRJoRl6wpxAbR7R5Va9AoEgjn1Tb0/1IXKKrWcFx5xDdpywx62d6J4
	 nxs6ncBODDil4d4/8BBZ/Ttx5GrpI7wIq3+5SbzAUzDtznCvcGr37OXVNO1UZiyyrf
	 xg2bxmCMwuOqA==
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
Subject: [PATCHv2 bpf-next 13/24] libbpf: Add uprobe multi link detection
Date: Tue, 20 Jun 2023 10:35:39 +0200
Message-ID: <20230620083550.690426-14-jolsa@kernel.org>
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

Adding uprobe-multi link detection. It will be used later in
bpf_program__attach_usdt function to check and use uprobe_multi
link over standard uprobe links.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e42080258ec7..3d570898459e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4815,6 +4815,32 @@ static int probe_perf_link(void)
 	return link_fd < 0 && err == -EBADF;
 }
 
+static int probe_uprobe_multi_link(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, link_fd, err;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), NULL);
+	if (prog_fd < 0)
+		return -errno;
+
+	/* No need to specify attach function. If the link is not supported
+	 * we will get -EOPNOTSUPP error before any other check is performed.
+	 */
+	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, NULL);
+	err = -errno; /* close() can clobber errno */
+
+	if (link_fd >= 0)
+		close(link_fd);
+	close(prog_fd);
+
+	return link_fd < 0 && err != -EOPNOTSUPP;
+}
+
 static int probe_kern_bpf_cookie(void)
 {
 	struct bpf_insn insns[] = {
@@ -4911,6 +4937,9 @@ static struct kern_feature_desc {
 	[FEAT_SYSCALL_WRAPPER] = {
 		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
 	},
+	[FEAT_UPROBE_LINK] = {
+		"BPF uprobe multi link support", probe_uprobe_multi_link,
+	},
 };
 
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 22b0834e7fe1..a257eb81af25 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -354,6 +354,8 @@ enum kern_feature_id {
 	FEAT_BTF_ENUM64,
 	/* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) */
 	FEAT_SYSCALL_WRAPPER,
+	/* BPF uprobe_multi link support */
+	FEAT_UPROBE_LINK,
 	__FEAT_CNT,
 };
 
-- 
2.41.0



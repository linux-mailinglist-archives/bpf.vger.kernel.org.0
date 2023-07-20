Return-Path: <bpf+bounces-5456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81E75AD27
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8785281E55
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE7117ADF;
	Thu, 20 Jul 2023 11:38:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8826174E9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728EBC433C8;
	Thu, 20 Jul 2023 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689853110;
	bh=+djboRr26HxL+35498Z/uHBMl+2Oe49g9S73NnPQ9y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EO/8nRfgAniNpxwCtUawW8TFBhNzCi5vGSP00L/GhpnHvnobPnz0s0a18yLapVRMq
	 dFMCF79bNTtpp5hSqDlpRSyvWLWJZJq82udwRb214tcYisgb2wEkpZ9cIFGTifptVF
	 FrdPxSkhb2DS5TWiCHAHxDfyJRBuLU9PPM/bmTQxosrSm9inUj/bnQp9NmlQOF94vn
	 ZMmolx70WxSN5StfQsg+IVNW8s+m9umkQIinEm2qZTNtWqh0sQM5e3SjvbZwVcsVgG
	 jfWZ1gPwV/TKNYIXq0Clu0/IU8tb0IEds9aziBBeTnDE4DslMJ0YDhZm4214D/eor9
	 GbqLCQK9F3alw==
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
Subject: [PATCHv4 bpf-next 15/28] libbpf: Add support for u[ret]probe.multi[.s] program sections
Date: Thu, 20 Jul 2023 13:35:37 +0200
Message-ID: <20230720113550.369257-16-jolsa@kernel.org>
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

Adding support for several uprobe_multi program sections
to allow auto attach of multi_uprobe programs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7a10a8b57dbc..527f02960156 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8680,6 +8680,7 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
@@ -8695,6 +8696,10 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
+	SEC_DEF("uprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
+	SEC_DEF("uretprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
+	SEC_DEF("uprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
+	SEC_DEF("uretprobe.multi.s+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
@@ -10897,6 +10902,37 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return libbpf_get_error(*link);
 }
 
+static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	int n, ret = -EINVAL;
+
+	*link = NULL;
+
+	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%ms",
+		   &probe_type, &binary_path, &func_name);
+	switch (n) {
+	case 1:
+		/* handle SEC("u[ret]probe") - format is valid, but auto-attach is impossible. */
+		ret = 0;
+		break;
+	case 3:
+		opts.retprobe = strcmp(probe_type, "uretprobe.multi") == 0;
+		*link = bpf_program__attach_uprobe_multi(prog, -1, binary_path, func_name, &opts);
+		ret = libbpf_get_error(*link);
+		break;
+	default:
+		pr_warn("prog '%s': invalid format of section definition '%s'\n", prog->name,
+			prog->sec_name);
+		break;
+	}
+	free(probe_type);
+	free(binary_path);
+	free(func_name);
+	return ret;
+}
+
 static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *binary_path, uint64_t offset)
 {
-- 
2.41.0



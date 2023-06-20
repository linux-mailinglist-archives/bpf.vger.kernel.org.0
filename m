Return-Path: <bpf+bounces-2892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8834736669
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E2B1C20BE4
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A695AD56;
	Tue, 20 Jun 2023 08:37:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28EA92D
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA7FC433C8;
	Tue, 20 Jun 2023 08:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250272;
	bh=He9DsUYtpOl3ySXBGF7rzUxoRYpxIWH1lg3O5a+kdDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzCx1VS3K+BsiTMmQzZ1y5SSMT9GWGAVP1Uv5FGjVAXsxPoZ+SuzU1RACegg/xN3K
	 fOPz4RybiORrny+1EKEYR+Y7E2FK1J0xghs4ySSXY+yl066cfHPOoqw6xt3QlULOkB
	 AoWFT5b4JOsOu47aNIMAzWiixrUCt2GeYwfBPpZaRG3hjFNYS8NJOBYNR8zNifZ627
	 Q7T0lSj87iht7lUnzw6m54kgz+XdNjpj3zyQmro/NWHogsDXvku6bPflskBh8d2pWF
	 Lr2SLHOQneLHbNlqA0UfJRXksy3oUl0pHeAd/Sxn5H6bIdztAHn5lg9IX+INk1vETn
	 o/9z7vuP5/34g==
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
Subject: [PATCHv2 bpf-next 12/24] libbpf: Add support for u[ret]probe.multi[.s] program sections
Date: Tue, 20 Jun 2023 10:35:38 +0200
Message-ID: <20230620083550.690426-13-jolsa@kernel.org>
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

Adding support for several uprobe_multi program sections
to allow auto attach of multi_uprobe programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d972cea4c658..e42080258ec7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8652,6 +8652,7 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
@@ -8667,6 +8668,10 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -10728,6 +10733,41 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
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
+	case 2:
+		pr_warn("prog '%s': section '%s' missing ':function[+offset]' specification\n",
+			prog->name, prog->sec_name);
+		break;
+	case 3:
+		opts.retprobe = strcmp(probe_type, "uretprobe.multi");
+		*link = bpf_program__attach_uprobe_multi_opts(prog, -1, binary_path, func_name, &opts);
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



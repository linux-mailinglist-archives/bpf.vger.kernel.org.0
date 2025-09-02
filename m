Return-Path: <bpf+bounces-67189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9F3B40722
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12D156310A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845530EF6B;
	Tue,  2 Sep 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYFRTdC2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1B2EA49D;
	Tue,  2 Sep 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823791; cv=none; b=EfcbBGFBHlkUS0XevPfA4atAXTjtjJu5e1taBDlQoTW6kiH2V4des8U1ZbJhBtSPFzeKdWPx8p65p41qKe5R+tJ5LxPKpgpF2QbJKCk1prfqZrEntQF27Ew3LCK0UXSVc+5Oox68U7z1kDasa+gcmhYwr8586wqBkZf4ZketkeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823791; c=relaxed/simple;
	bh=6eENUiVylxO8M48Iw25t4r5Dlvc4cgE0fyAMvijAXqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ+BIXMepQ4b89wQaPOx+WoC3SRQ1ADF3FHvYFCwqbDr8gD9w0U5UzeM6alfninqQ5HY49Kqj3Ytz0LBV7G8xCe3k3BCV1NhXyUaxYPrIiSWd+t6jtYub0sVcyLTA67JVLVKObtNVhsNFTDse1IAk2CMIxjkNKMSQs+QDcCoWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYFRTdC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30040C4CEED;
	Tue,  2 Sep 2025 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823790;
	bh=6eENUiVylxO8M48Iw25t4r5Dlvc4cgE0fyAMvijAXqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYFRTdC2bVHsR6rOQwmGc6m2GBNR/uvQND2mKnY+Z6aoOjOxVMemdvWw5x8eR1vKA
	 42YIUzOt7NVII2BKTGY7c/oLyUZd83+b4/rIlUam53z+G2Nng3RsC9SCLmv2ZmyuEF
	 idLe4uf+fcQ0nOFqUd4BdA3cb1EtdH2h7asNQo756wKvkIxCEXVqa8hy4ixC/5vnVJ
	 nETBusXUKbHlYfyxIgRE/sTstszy/JdrFTg+wsrrkn/Vg+TSgXnMYp5VspYp3sZF52
	 Xaisxqeb8ayCSct/XhkAqYHbBA112NYdgx771FrtJgZjUkS5GQNqc13Wj0eignhSEA
	 CvHchmEK56QJw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 07/11] libbpf: Add support to attach generic unique uprobe
Date: Tue,  2 Sep 2025 16:35:00 +0200
Message-ID: <20250902143504.1224726-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach unique generic uprobe by adding the 'unique'
bool flag to struct bpf_uprobe_opts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 29 ++++++++++++++++++++++++-----
 tools/lib/bpf/libbpf.h |  4 +++-
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1f613a5f95b6..aac2bd4fb95e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11045,11 +11045,19 @@ static int determine_uprobe_retprobe_bit(void)
 	return parse_uint_from_file(file, "config:%d\n");
 }
 
+static int determine_uprobe_unique_bit(void)
+{
+	const char *file = "/sys/bus/event_source/devices/uprobe/format/unique";
+
+	return parse_uint_from_file(file, "config:%d\n");
+}
+
 #define PERF_UPROBE_REF_CTR_OFFSET_BITS 32
 #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
 
 static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
-				 uint64_t offset, int pid, size_t ref_ctr_off)
+				 uint64_t offset, int pid, size_t ref_ctr_off,
+				 bool unique)
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
@@ -11080,6 +11088,16 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 		}
 		attr.config |= 1 << bit;
 	}
+	if (uprobe && unique) {
+		int bit = determine_uprobe_unique_bit();
+
+		if (bit < 0) {
+			pr_warn("failed to determine uprobe unique bit: %s\n",
+				errstr(bit));
+			return bit;
+		}
+		attr.config |= 1 << bit;
+	}
 	attr.size = attr_sz;
 	attr.type = type;
 	attr.config |= (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
@@ -11286,7 +11304,7 @@ int probe_kern_syscall_wrapper(int token_fd)
 	if (determine_kprobe_perf_type() >= 0) {
 		int pfd;
 
-		pfd = perf_event_open_probe(false, false, syscall_name, 0, getpid(), 0);
+		pfd = perf_event_open_probe(false, false, syscall_name, 0, getpid(), 0, false);
 		if (pfd >= 0)
 			close(pfd);
 
@@ -11348,7 +11366,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	if (!legacy) {
 		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
 					    func_name, offset,
-					    -1 /* pid */, 0 /* ref_ctr_off */);
+					    -1 /* pid */, 0 /* ref_ctr_off */, false /* unique */);
 	} else {
 		char probe_name[MAX_EVENT_NAME_LEN];
 
@@ -12251,7 +12269,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	struct bpf_link *link;
 	size_t ref_ctr_off;
 	int pfd, err;
-	bool retprobe, legacy;
+	bool retprobe, legacy, unique;
 	const char *func_name;
 
 	if (!OPTS_VALID(opts, bpf_uprobe_opts))
@@ -12261,6 +12279,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	retprobe = OPTS_GET(opts, retprobe, false);
 	ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
+	unique = OPTS_GET(opts, unique, false);
 
 	if (!binary_path)
 		return libbpf_err_ptr(-EINVAL);
@@ -12321,7 +12340,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 
 	if (!legacy) {
 		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
-					    func_offset, pid, ref_ctr_off);
+					    func_offset, pid, ref_ctr_off, unique);
 	} else {
 		char probe_name[MAX_EVENT_NAME_LEN];
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 13a10299331b..0a38dee1d9c1 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -701,9 +701,11 @@ struct bpf_uprobe_opts {
 	const char *func_name;
 	/* uprobe attach mode */
 	enum probe_attach_mode attach_mode;
+	/* create unique uprobe */
+	bool unique;
 	size_t :0;
 };
-#define bpf_uprobe_opts__last_field attach_mode
+#define bpf_uprobe_opts__last_field unique
 
 /**
  * @brief **bpf_program__attach_uprobe()** attaches a BPF program
-- 
2.51.0



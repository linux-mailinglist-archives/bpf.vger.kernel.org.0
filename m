Return-Path: <bpf+bounces-21416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6B584CE29
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 16:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4937828FCD1
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B47FBC4;
	Wed,  7 Feb 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2dNb9yO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13257FBB5
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320189; cv=none; b=teZpAGzWet6lonI7Vnr23tYAo9ee5zvUyi/6cQlIk+roY002j6vP4t6amOwZjCJXZuKMle4vDtND1/ZmDXtDjka16SDzmjrNUEHWxUl8Th/SvEpnBvvrO59Vs8JwsihzJMqwYCV6S7bpkIG09Qo9FmM5K+HoOzwnDulq+oY/plM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320189; c=relaxed/simple;
	bh=44unExNBi3nr4h8cb3vBqBHAJqkIvX1yP1XM4q3ssLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJiJ7wPVzRq34oJi1fXPVq0FbVn7ZWl8J3rq2CJYaoAOsF9z2xPLDkhJaCAWAM5fKu8C1GOsv9cFoUgLBJohofDbDxrRqpoh8nfNHVot09RHccEKolQRZVCuf08h6Y1w5KfOdKlciglM9dJ7V9zmvyEAo8Cmw7nfLsJzc+ayWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2dNb9yO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383AEC433F1;
	Wed,  7 Feb 2024 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707320188;
	bh=44unExNBi3nr4h8cb3vBqBHAJqkIvX1yP1XM4q3ssLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2dNb9yOXvHtKLgXhw3szVeRxu8zlI3JEvqLb11FIs1SEfi0OE0ACQljwbUEOyywC
	 gHp5gJl/xXtYLbbAlemGAj7sDL773Z3nR0+L24PkxsiNonDqD5Iiwnywu+NiR38SCW
	 TDOaweBfoNSsomunEgkjFvBuxuz6pp0lWpF4jpSSD8ZWnk5zAW8CePbXG6MXs+0lXc
	 Beo0s9d3i8lDPIBuLiPvbeFaXFIAnqnSWpthoJ1rr+OU292W/w3a/h5GuSuoUR9UIF
	 RmXxYSCExRLTDVwgccHlKy/01U76UYh6SW/04SZILFoD+eH4DsLLDZaIyN1jaAaLO7
	 2fa3s+Q9O3tQw==
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH RFC bpf-next 3/4] libbpf: Add return_prog_fd to kprobe multi opts
Date: Wed,  7 Feb 2024 16:35:49 +0100
Message-ID: <20240207153550.856536-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207153550.856536-1-jolsa@kernel.org>
References: <20240207153550.856536-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to specify return prog file descriptor in struct
bpf_kprobe_multi_opts.

When the return_prog bool is set true the return_prog_fd is used
as bpf program to be executed for the return probe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c    | 1 +
 tools/lib/bpf/bpf.h    | 1 +
 tools/lib/bpf/libbpf.c | 5 +++++
 tools/lib/bpf/libbpf.h | 6 +++++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 97ec005c3c47..9f296957bd30 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -771,6 +771,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 		attr.link_create.kprobe_multi.syms = ptr_to_u64(OPTS_GET(opts, kprobe_multi.syms, 0));
 		attr.link_create.kprobe_multi.addrs = ptr_to_u64(OPTS_GET(opts, kprobe_multi.addrs, 0));
 		attr.link_create.kprobe_multi.cookies = ptr_to_u64(OPTS_GET(opts, kprobe_multi.cookies, 0));
+		attr.link_create.kprobe_multi.return_prog_fd = OPTS_GET(opts, kprobe_multi.return_prog_fd, 0);
 		if (!OPTS_ZEROED(opts, kprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f866e98b2436..e04a14134a21 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -399,6 +399,7 @@ struct bpf_link_create_opts {
 			const char **syms;
 			const unsigned long *addrs;
 			const __u64 *cookies;
+			__u32 return_prog_fd;
 		} kprobe_multi;
 		struct {
 			__u32 flags;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..022a68b9fe83 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11073,6 +11073,11 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	lopts.kprobe_multi.cnt = cnt;
 	lopts.kprobe_multi.flags = retprobe ? BPF_F_KPROBE_MULTI_RETURN : 0;
 
+	if (OPTS_GET(opts, return_prog, false)) {
+		lopts.kprobe_multi.return_prog_fd = OPTS_GET(opts, return_prog_fd, 0);
+		lopts.kprobe_multi.flags |= BPF_F_KPROBE_MULTI_RETURN_PROG;
+	}
+
 	link = calloc(1, sizeof(*link));
 	if (!link) {
 		err = -ENOMEM;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..d77b953009d6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -539,10 +539,14 @@ struct bpf_kprobe_multi_opts {
 	size_t cnt;
 	/* create return kprobes */
 	bool retprobe;
+	/* attach return program (specified by return_prog_fd file descriptor) */
+	bool return_prog;
+	/* return program fd */
+	int return_prog_fd;
 	size_t :0;
 };
 
-#define bpf_kprobe_multi_opts__last_field retprobe
+#define bpf_kprobe_multi_opts__last_field return_prog_fd
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
-- 
2.43.0



Return-Path: <bpf+bounces-44946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8F49CDDE9
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1AB24D2D
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFC1BBBF7;
	Fri, 15 Nov 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwjTuT3V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362863BB22;
	Fri, 15 Nov 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671929; cv=none; b=LersPsRFA4wHTSR2+F8LfRgXucIs/PT9AYn+Tkdlxsf65FCO9+4650Idr8o68Xhw783epY/NOV4eNazuU8934T/rPg6VRVKWAdq3KUsyJlqdli0o1MAtH+VyHiJLUAkqn6i0q7kFiLTc2ZkJdVIkwkzNoA/dvZ0s2RZD9dlaJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671929; c=relaxed/simple;
	bh=Z8EbVt263fTad/Uqu0XqI8o0kXZ0ahr5VzZjUIbf1IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHs9Npmy2XTmjZQ9swReF6kou8+xZIFBXvGiaO/s2X4D7PU0H3d17LAyVkVvkQKuv3h7C228eujkMiPIY02uBMx9CaO05ZzUEmImWk/Ls/CpYGyRNZ7ZwSm7cxyY9A6MwTjois3aImrQ9DUM2Lb3K9wJqP05zNO8mPT+Hc6fMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwjTuT3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77992C4CECF;
	Fri, 15 Nov 2024 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731671928;
	bh=Z8EbVt263fTad/Uqu0XqI8o0kXZ0ahr5VzZjUIbf1IQ=;
	h=From:To:Cc:Subject:Date:From;
	b=cwjTuT3VEw/HEr4MB0KVnqK6hZ3e1nzhzwXCT93eipxTT3+PJ+2qRsL5wdviVY7GM
	 xiP0fj8p8AdDs0HRd5XthvtYPFP50tPS9lDhl/aAWWS9o5TqRgwuF5ZWu9t2Fbsfy0
	 0zhP4XKNIwDAUqRPtjVip0MPF609uMKfrn38RIjD1EyE88kvkx+YIWbpltQ88AqZ77
	 DG+ZBZJcS4aWSgQgT4iKfjD/FZDHTUFtQq+8b7LnHdimgMl5bnLpXJAWW6w82/I1oF
	 90EDgwcUkRLVgTspbECOu8219K67Hbn2EUt4scGh04EV6f9DAzlJyyk7CK8rszkd2b
	 0m5IRXojBZbjw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next] libbpf: Fix memory leak in bpf_program__attach_uprobe_multi
Date: Fri, 15 Nov 2024 12:58:43 +0100
Message-ID: <20241115115843.694337-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrii reported memory leak detected by Coverity on error path
in bpf_program__attach_uprobe_multi. Fixing that by moving
the check earlier before the offsets allocations.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 07d5de81dd38..66173ddb5a2d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12006,6 +12006,8 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	ref_ctr_offsets = OPTS_GET(opts, ref_ctr_offsets, NULL);
 	cookies = OPTS_GET(opts, cookies, NULL);
 	cnt = OPTS_GET(opts, cnt, 0);
+	retprobe = OPTS_GET(opts, retprobe, false);
+	session  = OPTS_GET(opts, session, false);
 
 	/*
 	 * User can specify 2 mutually exclusive set of inputs:
@@ -12034,6 +12036,9 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 			return libbpf_err_ptr(-EINVAL);
 	}
 
+	if (retprobe && session)
+		return libbpf_err_ptr(-EINVAL);
+
 	if (func_pattern) {
 		if (!strchr(path, '/')) {
 			err = resolve_full_path(path, full_path, sizeof(full_path));
@@ -12057,12 +12062,6 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 		offsets = resolved_offsets;
 	}
 
-	retprobe = OPTS_GET(opts, retprobe, false);
-	session  = OPTS_GET(opts, session, false);
-
-	if (retprobe && session)
-		return libbpf_err_ptr(-EINVAL);
-
 	attach_type = session ? BPF_TRACE_UPROBE_SESSION : BPF_TRACE_UPROBE_MULTI;
 
 	lopts.uprobe_multi.path = path;
-- 
2.47.0



Return-Path: <bpf+bounces-70077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1918BB04FD
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469DA189B650
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 12:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D16287508;
	Wed,  1 Oct 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLUobxSa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9228BABB;
	Wed,  1 Oct 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321374; cv=none; b=c7QnQIIjIgsIxpmx9ZqpvX6dvA+SUhnFw6KSrgcin232HAkWmoPnwjRHJ/7KwYuZASdr5gwPpVDe3cIC4CWc6oIH6iuDOmXfhSQvRgmOa79kJgDZ9ecwM3bojpxa9eJMTkAS6WhySKrgtoyHgcYkEtBZJRkAYvLEFUh9HH1XWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321374; c=relaxed/simple;
	bh=KZBIwpE/dUaQ6yqPW0VbfLHwIlRHzdrC2IyDjReQsQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ/3V9iiqDmg364zVsRtCLUU14x1url86vV5Z/35XvSeWWH1cRtAW8EYIIkHtc/E+uiv/TlXjVGfl74kWOZ6rw2xH+xzl2Enqmp5TgwIfWIbF78egBqpfFmdywBhLTykjsDd6EgeMiLGZfCHz8Xc3b7zWnJRi0hASGj/nUEzsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLUobxSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A676C4CEF4;
	Wed,  1 Oct 2025 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759321374;
	bh=KZBIwpE/dUaQ6yqPW0VbfLHwIlRHzdrC2IyDjReQsQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLUobxSaV3DBpQG20sHTSzC0ahLlDLAT0QI2kQ4RlhgB1nhm2DM6ziI67U6/Pgt/m
	 5+pVFWdkLxvRi6dwgN85TkCNd2GaNAg8MAPmE9V18No9kMptYidEHVSZA+dUGgGO/e
	 Cg4dhglki/Q+mRhE9bwc2csZB9YycP20NgK0vtaQJ/G+9BDYTmL3ZzgczKeqLVE5bB
	 fk3TSbf5M+e6JEA5wRcfYt/pw62nWMTWDO46wvUUHUDPV1oZ+Zt8VacTZb0Fx8mfpp
	 wVhIrJdhXV9uyC8Fg9W/yrplYYNKjPhGK52svp5pWuHE3GZ7Itf4Qrawy801IuJHtV
	 24JRLuy6MbFIA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf 3/3] selftests/bpf: Fix realloc size in bpf_get_addrs
Date: Wed,  1 Oct 2025 14:22:23 +0200
Message-ID: <20251001122223.170830-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001122223.170830-1-jolsa@kernel.org>
References: <20251001122223.170830-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will segfault once we call realloc in bpf_get_addrs due to
wrong size argument.

Fixes: 6302bdeb91df ("selftests/bpf: Add a kprobe_multi subtest to use addrs instead of syms")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 171987627f3a..eeaab7013ca2 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -732,7 +732,7 @@ int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
 
 		if (cnt == max_cnt) {
 			max_cnt += inc_cnt;
-			tmp_addrs = realloc(addrs, max_cnt);
+			tmp_addrs = realloc(addrs, max_cnt * sizeof(long));
 			if (!tmp_addrs) {
 				err = -ENOMEM;
 				goto error;
-- 
2.51.0



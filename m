Return-Path: <bpf+bounces-47989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC846A02F52
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F5D3A4F23
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07A1DF25C;
	Mon,  6 Jan 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J38bKP1O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB91DE8B8;
	Mon,  6 Jan 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185866; cv=none; b=GehY4vc6Km2L6lCWomO1Q/04UUx3PF+Mp51HcwPPzpyPTeOZwI0/I5lB7LNSNH8xWMXkan23O48gFd38j1HUNBEo+15zDKI0pbcCLPz0m/+Oai5dh1z4VrBT3K3nGe/WPuMs4dlDDAPr5+pf+A0t41qxn7vsFhTSkXgtBMdqr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185866; c=relaxed/simple;
	bh=le9JywARPIuQy+S+I0HV71655NJxy56umHLs4BFGYm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPvz6ad2ugWG6RHH0U+1bKnAhsy+7tRwi3BInvSaE/yDZkkiaQGDpootfukmKJrJ9ou16x59aoTKXGC8KVP3mJkxLRQD26PPOXdpWzB498uOxo+HOCK9JXobtzu86VtACcM+gd9t2k6AJWCnVsqQwGtRa/EnXA+RwAcY1PhpwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J38bKP1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A667AC4CED2;
	Mon,  6 Jan 2025 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736185865;
	bh=le9JywARPIuQy+S+I0HV71655NJxy56umHLs4BFGYm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J38bKP1OkdN8DLIkXsWW/w8Dnml50V/zsgPdKFamFqxLHScdwFL2huzEgnu/cnbEx
	 M4VwmLkdL1u59fdTj8+Wd6h4p/vvUHl4S93cPAMFjkMNcH5BakZ+rUso6ofFDO7gW8
	 vPYuD6HG9G2P2nG37xNYHohqVV+mvOu9Fna5wVOnnotiS61u00sspS3xsYm4/IG82d
	 MCjAwWmO3/cXi9gn1bfI1UvQmLuNjW+5PsRd9F7I1eB/5XuaOdqKern15gnSGh/Mzm
	 EMFSsVvzEgeJBWfGFdkqFXIzR/Ax1VMeFRCct+ib5NzdexLH+YrllkOqNK0/sw+8Uh
	 ZsoVdOL507AyA==
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
	Hao Luo <haoluo@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add kprobe session recursion check test
Date: Mon,  6 Jan 2025 18:50:48 +0100
Message-ID: <20250106175048.1443905-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250106175048.1443905-1-jolsa@kernel.org>
References: <20250106175048.1443905-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding kprobe.session probe to bpf_kfunc_common_test that misses bpf
program execution due to recursion check and making sure it increases
the program missed count properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/missed.c             | 1 +
 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/testing/selftests/bpf/prog_tests/missed.c
index 70d90c43537c..ed8857ae914a 100644
--- a/tools/testing/selftests/bpf/prog_tests/missed.c
+++ b/tools/testing/selftests/bpf/prog_tests/missed.c
@@ -85,6 +85,7 @@ static void test_missed_kprobe_recursion(void)
 	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test3)), 1, "test3_recursion_misses");
 	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test4)), 1, "test4_recursion_misses");
 	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test5)), 1, "test5_recursion_misses");
+	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test6)), 1, "test6_recursion_misses");
 
 cleanup:
 	missed_kprobe_recursion__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c b/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
index c4bf679a9876..29c18d869ec1 100644
--- a/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
+++ b/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
@@ -46,3 +46,9 @@ int test5(struct pt_regs *ctx)
 {
 	return 0;
 }
+
+SEC("kprobe.session/bpf_kfunc_common_test")
+int test6(struct pt_regs *ctx)
+{
+	return 0;
+}
-- 
2.47.0



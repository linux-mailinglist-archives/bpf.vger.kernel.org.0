Return-Path: <bpf+bounces-7320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC67755D6
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E244F281B30
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5D7182CB;
	Wed,  9 Aug 2023 08:39:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB251FA6
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61731C433C7;
	Wed,  9 Aug 2023 08:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570371;
	bh=Kid9fO7l0EEPLiNtm8+efFoCtWuu7g/UhmYXBMWNLIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7o2nGMUIpof5Ti8YiSSMp4zuln9rtKjFHrwzFI8tnGDkynD1ycl8IqD1gBabTXi0
	 Lrb7MrFKVk5RCBGDyz4s1Qu78mjPcrVlt6jX2ChirGY4DIbht3iK3Df9Az09sXdAk2
	 BCTKBVy79dJ45HwaxCbLBuL4SaqvllLtyYWsuxoUGoTDzbevtg/2d40oJ8i+6AW263
	 4bHqiqDs/mbAhdHwHPDmAJVnurMIQT+tEnTleuZaUeKM6KjwIzCyu4MA7ELgFtBmGH
	 cAkOFowk/qgkFOAus2C5OIXtNeoxwybNufiGxGUlq7sZMYNWSO20TUatPLgOWNAXoR
	 n2jEcB8DTJ+Vg==
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
Subject: [PATCHv7 bpf-next 28/28] selftests/bpf: Add extra link to uprobe_multi tests
Date: Wed,  9 Aug 2023 10:34:40 +0200
Message-ID: <20230809083440.3209381-29-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching extra program to same functions system wide for api
and link tests.

This way we can test the pid filter works properly when there's
extra system wide consumer on the same uprobe that will trigger
the original uprobe handler.

We expect to have the same counts as before.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_multi_test.c | 16 ++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index bc07921a5a77..cd051d3901a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -184,6 +184,12 @@ __test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_mul
 	if (!ASSERT_OK_PTR(skel->links.uretprobe_sleep, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
+	opts->retprobe = false;
+	skel->links.uprobe_extra = bpf_program__attach_uprobe_multi(skel->progs.uprobe_extra, -1,
+								    binary, pattern, opts);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_extra, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
 	uprobe_multi_test_run(skel, child);
 
 cleanup:
@@ -240,6 +246,7 @@ static void __test_link_api(struct child *child)
 		"uprobe_multi_func_2",
 		"uprobe_multi_func_3",
 	};
+	int link_extra_fd = -1;
 	int err;
 
 	err = elf_resolve_syms_offsets(path, 3, syms, (unsigned long **) &offsets);
@@ -279,6 +286,13 @@ static void __test_link_api(struct child *child)
 	if (!ASSERT_GE(link4_fd, 0, "link4_fd"))
 		goto cleanup;
 
+	opts.kprobe_multi.flags = 0;
+	opts.uprobe_multi.pid = 0;
+	prog_fd = bpf_program__fd(skel->progs.uprobe_extra);
+	link_extra_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link_extra_fd, 0, "link_extra_fd"))
+		goto cleanup;
+
 	uprobe_multi_test_run(skel, child);
 
 cleanup:
@@ -290,6 +304,8 @@ static void __test_link_api(struct child *child)
 		close(link3_fd);
 	if (link4_fd >= 0)
 		close(link4_fd);
+	if (link_extra_fd >= 0)
+		close(link_extra_fd);
 
 	uprobe_multi__destroy(skel);
 	free(offsets);
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index ec648a6699e6..419d9aa28fce 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -93,3 +93,9 @@ int uretprobe_sleep(struct pt_regs *ctx)
 	uprobe_multi_check(ctx, true, true);
 	return 0;
 }
+
+SEC("uprobe.multi//proc/self/exe:uprobe_multi_func_*")
+int uprobe_extra(struct pt_regs *ctx)
+{
+	return 0;
+}
-- 
2.41.0



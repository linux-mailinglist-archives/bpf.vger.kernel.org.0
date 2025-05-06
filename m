Return-Path: <bpf+bounces-57519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D47AAC71F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0AB4A78A4
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BE281358;
	Tue,  6 May 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9uMmFz+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F0280A3D;
	Tue,  6 May 2025 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539873; cv=none; b=i71lewrwUf5JJKCBpGGvAgSx9g/Us0ngOBL6jZzL6RVxWWqZxkfy7UMQkSN13EsdvTfOpoclHG5epiBkENZJGXzgkBMR2YDwpnvKLcGu1kH8zMtpm/4Ql3IEOxhDcRVgE2Ca62UICXTf8VCwTrV4OMV9IJmnujN7PcudzfKnKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539873; c=relaxed/simple;
	bh=gR4OD8QUFHK7s24r6f84weBoj6MO4n2JSGsb1Lnw4lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOM0MvxWYUFlDz/USV8St7C8aoNZDsEAuk7xX60YHTXzqwyr3hSlOsqyLFhmk9V7bXeSpyxywxT4XVcYRIlUjDSuVbiM7PyDtEQfdA/k5TncB1KXWmk2wOa9f7SfxdSGy5Hf/P7HJYvn+sLMVkIsmzqtsWqDjk2ta8n5Mnwtqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9uMmFz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB82AC4CEE4;
	Tue,  6 May 2025 13:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539872;
	bh=gR4OD8QUFHK7s24r6f84weBoj6MO4n2JSGsb1Lnw4lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9uMmFz+gEb5AgQP96J0nUfFQzHhLATeAPThd63TBqMpUIkQWgHXOoABfa0IohQMr
	 FzqDx4bTlTgjMxS0RyMB/XlEaecxXQE/9p7SI7WUhOQh/J6dGzYlgTa0/xQI3yFOh1
	 7lULbn5ztvWrEKIsBTvUaaUQx8WR1rpvxK8E5Hg46/maJKexNvw6KZ12E2tun2WiTQ
	 OcMICuZnZUIXBfHYGUJbWai4oDHDi8bXU0UttHjVxJyKywF5S6lGjsKrMP8p5hi4Qw
	 LhdHGnTfRei89i0FE80neuXtP9Dt0+KfqLMpMbPFnoPVlcgsCxNLsTHaQcZqqUr1xI
	 Jbts+6DsaXrOQ==
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
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add link info test for ref_ctr_offset retrieval
Date: Tue,  6 May 2025 15:57:26 +0200
Message-ID: <20250506135727.3977467-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506135727.3977467-1-jolsa@kernel.org>
References: <20250506135727.3977467-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding link info test for ref_ctr_offset retrieval for both
uprobe and uretprobe probes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c  | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index e59af2aa6601..e40114620751 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -37,6 +37,7 @@ static noinline void uprobe_func(void)
 static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long addr,
 				 ssize_t offset, ssize_t entry_offset)
 {
+	ssize_t ref_ctr_offset = entry_offset /* ref_ctr_offset for uprobes */;
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
 	char buf[PATH_MAX];
@@ -97,6 +98,7 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 	case BPF_PERF_EVENT_UPROBE:
 	case BPF_PERF_EVENT_URETPROBE:
 		ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_offset");
+		ASSERT_EQ(info.perf_event.uprobe.ref_ctr_offset, ref_ctr_offset, "uprobe_ref_ctr_offset");
 
 		ASSERT_EQ(info.perf_event.uprobe.name_len, strlen(UPROBE_FILE) + 1,
 				  "name_len");
@@ -241,20 +243,32 @@ static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
 		.retprobe = type == BPF_PERF_EVENT_URETPROBE,
 		.bpf_cookie = PERF_EVENT_COOKIE,
 	);
+	const char *sema[1] = {
+		"uprobe_link_info_sema_1",
+	};
+	__u64 *ref_ctr_offset;
 	struct bpf_link *link;
 	int link_fd, err;
 
+	err = elf_resolve_syms_offsets("/proc/self/exe", 1, sema,
+				       (unsigned long **) &ref_ctr_offset, STT_OBJECT);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_object"))
+		return;
+
+	opts.ref_ctr_offset = *ref_ctr_offset;
 	link = bpf_program__attach_uprobe_opts(skel->progs.uprobe_run,
 					       0, /* self pid */
 					       UPROBE_FILE, uprobe_offset,
 					       &opts);
 	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
-		return;
+		goto out;
 
 	link_fd = bpf_link__fd(link);
-	err = verify_perf_link_info(link_fd, type, 0, uprobe_offset, 0);
+	err = verify_perf_link_info(link_fd, type, 0, uprobe_offset, *ref_ctr_offset);
 	ASSERT_OK(err, "verify_perf_link_info");
 	bpf_link__destroy(link);
+out:
+	free(ref_ctr_offset);
 }
 
 static int verify_kmulti_link_info(int fd, bool retprobe, bool has_cookies)
-- 
2.49.0



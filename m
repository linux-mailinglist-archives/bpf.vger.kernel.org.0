Return-Path: <bpf+bounces-8982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AF478D495
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 11:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D2928127E
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F981FB5;
	Wed, 30 Aug 2023 09:35:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132CD1C03
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 09:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEEBC433C7;
	Wed, 30 Aug 2023 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693388108;
	bh=+utkRiQWFgivGb8JOVNDfTEU5ThyQmuoZsV+6WhSgSg=;
	h=From:To:Cc:Subject:Date:From;
	b=kazcLSkfE1cy3pPFHYkdjBslzJOY3238EMeoN7olvbBXDteuDlRZdENqtnjGx/f9t
	 bqUjsco72D5+kNG6ItS12otsyB7yUCDNw9HdGt8Bxs7qNZmblfuaSvfOFKEgo0u3yX
	 BoOxAooW46kITNE9w8qkHuHw3LOCeQtG1YaFCGfUw9mACNbEzm3ttbqN76tyzo3n8Z
	 dXqMA8ykcyQ0YkPwvSsViSDZXq0mJekF+/ReH09mlOlYyAyvKc/MKt0FHEDQSs2YFU
	 RFXpBF5D76JqECGe+uz4mE9YdjEtUawDgFeZRCCD/n1nH8WptRi3u7U5spDkBRl3BO
	 61tJ1ZebGoNgg==
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
	Hou Tao <houtao1@huawei.com>
Subject: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
Date: Wed, 30 Aug 2023 11:35:02 +0200
Message-ID: <20230830093502.1436694-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit [1] broken d_path test, because now filp_close is not
called directly from sys_close, but eventually later when the file
is finally released.

I can't see any other solution than to hook filp_flush function and
that also means we need to add it to btf_allowlist_d_path list, so
it can use the d_path helper.

But it's probably not very stable because filp_flush is static so it
could be potentially inlined.

Also if we'd keep the current filp_close hook and find a way how to 'wait'
for it to be called so user space can go with checks, then it looks
like d_path might not work properly when the task is no longer around.

thoughts?
jirka


[1] 021a160abf62 ("fs: use __fput_sync in close(2)")
---
 kernel/trace/bpf_trace.c                        | 1 +
 tools/testing/selftests/bpf/progs/test_d_path.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a7264b2c17ad..c829e24af246 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
 BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
+BTF_ID(func, filp_flush)
 BTF_SET_END(btf_allowlist_d_path)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..3467d1b8098c 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
 	return 0;
 }
 
-SEC("fentry/filp_close")
-int BPF_PROG(prog_close, struct file *file, void *id)
+SEC("fentry/filp_flush")
+int BPF_PROG(prog_close, struct file *file)
 {
 	pid_t pid = bpf_get_current_pid_tgid() >> 32;
 	__u32 cnt = cnt_close;
-- 
2.41.0



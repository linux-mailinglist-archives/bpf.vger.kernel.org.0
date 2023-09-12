Return-Path: <bpf+bounces-9753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55F79D35C
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 16:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2862812E0
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826D18AED;
	Tue, 12 Sep 2023 14:14:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A1168DA
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBE1C433C8;
	Tue, 12 Sep 2023 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694528082;
	bh=4EkrK9Zpg6IzX5GNZNPo8ikLWq33WodnDjc4kQq/1wI=;
	h=From:To:Cc:Subject:Date:From;
	b=n3uJsJ3B6rtM32gVLOhmaukDhzaz19QU/RP0aw/0/Ovmu4eeUtPToNNMSP5TqU+1r
	 l11uZ27uHu7i2VnYjMG7sFvlZRWm2fpFF+0Z3ZVBpOHniEFH1vi8kGyt8tIRMGJ753
	 n+MoQ3hfcIP8LSss3yj5Oh52HRwZ4e6Ix7lleGycDxg/YlZjPDsZN3q3qn4pGAC0M8
	 We8QL1v4aNulHhGyMVIO/aYkWM0aEcmTqiev4LcFU967EEMuczqQiKifoz+yaRdZq1
	 5nx9rwEBPxgUYpFtCNXm2ThCFZoEMcSZnO2jF9+ufFo9luzaJrQH5DJ2/M8pTPpO8z
	 cu6SuXjWRPs3A==
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
Subject: [PATCH bpf] selftests/bpf: Fix kprobe_multi_test/attach_override test
Date: Tue, 12 Sep 2023 16:14:37 +0200
Message-ID: <20230912141437.366046-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to deny the attach_override test for arm64
and make it static.

Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64               | 1 +
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 7f768d335698..b32f962dee92 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -9,6 +9,7 @@ kprobe_multi_test/bench_attach                   # bpf_program__attach_kprobe_mu
 kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: actual -95 < expected 0
 kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
 kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
+kprobe_multi_test/attach_override                # test_attach_override:FAIL:kprobe_multi_empty__open_and_load unexpected error: -22
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
 fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
 fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index e05477b210a5..4041cfa670eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -454,7 +454,7 @@ static void test_kprobe_multi_bench_attach(bool kernel)
 	}
 }
 
-void test_attach_override(void)
+static void test_attach_override(void)
 {
 	struct kprobe_multi_override *skel = NULL;
 	struct bpf_link *link = NULL;
-- 
2.41.0



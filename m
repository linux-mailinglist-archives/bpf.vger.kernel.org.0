Return-Path: <bpf+bounces-9900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1779E717
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EAE28252A
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8181EA7D;
	Wed, 13 Sep 2023 11:47:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009661E526
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 11:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4011C433C8;
	Wed, 13 Sep 2023 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694605636;
	bh=QqPRdNeD+/dYvnBl0JYSi5mYEsu9mAiNJAnLBzOCV5k=;
	h=From:To:Cc:Subject:Date:From;
	b=pico752EkLjCM5CfS+5xo1Dr41HK8nid9QlRu+WFeYc7JM+WEpmanE1kkE9awwJfc
	 V4gXW2W39lU7JtLWXNJd/gP9XvQZKJrNWHZoyit/Yp0pHTNUdm0+wrRBTmgtH38UFx
	 s2iHJ2gF6F3r8ukFf8pXH7sJLRp9wMXn+TtnhSkfyPqzpwMxTWUdeyI3pJovsRsfSV
	 0EWzqpNYjCSrXWxbEO+Z38bOQWBDz1hkQrkjKJ698G0NAfgzbBsHUR1VTSfeiieCvc
	 9n5pL4EQ6ilzqKljBAeP0/de/kBreqFbfOr4uAoEYrhUUv9Q6B7l6Gq+AKPNTJ3fYz
	 RjWY3JJFBceTw==
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
Subject: [PATCHv2 bpf] selftests/bpf: Fix kprobe_multi_test/attach_override test
Date: Wed, 13 Sep 2023 13:47:11 +0200
Message-ID: <20230913114711.499829-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to deny the attach_override test for arm64, denying the
whole kprobe_multi_test suite. Also making attach_override static.

Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64             | 9 +--------
 .../testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

v2 changes:
  - rebased on latest bpf/master, used just kprobe_multi_test suite name
    in DENYLIST.aarch64 to cover all kprobe_multi tests

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 7f768d335698..b733ce16c0f8 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,14 +1,7 @@
 bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 fexit_sleep                                      # The test never returns. The remaining tests cannot start.
-kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-kprobe_multi_test/attach_api_pattern             # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-kprobe_multi_test/attach_api_syms                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-kprobe_multi_test/bench_attach                   # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: actual -95 < expected 0
-kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
-kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
+kprobe_multi_test                                # needs CONFIG_FPROBE
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



Return-Path: <bpf+bounces-528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D7C702E75
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FAA281220
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD585C8FC;
	Mon, 15 May 2023 13:39:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF992C8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5E1C433D2;
	Mon, 15 May 2023 13:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157953;
	bh=Bk6SaRcCdQmCVK+W59d/ExJHMl1ZjJ1DPgMcebd+Nmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9RKG4JYcaNkRrn4SB6e+6xC9YuKjeWCIw0H0cG/z2wmiSIMdrJkLQXBZkCHB8zjT
	 pv3u0Il0/1WN0h1T/CFIqcVBXejiz75GttIgl1dCkdXr+AGVpPvr92FVDDXHciaWMt
	 0Ig19OPpU7fjvWWX1l3WhJ7gxJLhsCIbJqYlMh8jd7xcUDpqkXNobYXpJtsi3W2Cti
	 FaQYm+0Z0vjWOpWH4QO/xkV8+ePLAlYx3uaFkuYNEcZj1yjtFOogyOC/JsPL4P9/IX
	 gGg3L+2yszPGyxFBKkQ4lOfdw6bVfi8XDVi0ikGrsrrRLdvFZLvzj4/H0C1TfIWFFk
	 Cty+P8rW8AA9w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 07/10] selftests/bpf: Load bpf_testmod for verifier test
Date: Mon, 15 May 2023 15:37:53 +0200
Message-Id: <20230515133756.1658301-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
References: <20230515133756.1658301-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loading bpf_testmod kernel module for verifier test. We will
move all the tests kfuncs into bpf_testmod in following change.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index e4657c5bc3f1..285ea4aba194 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -40,6 +40,7 @@
 #include "bpf_util.h"
 #include "test_btf.h"
 #include "../../../include/linux/filter.h"
+#include "testing_helpers.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -1684,6 +1685,12 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 {
 	int i, passes = 0, errors = 0;
 
+	/* ensure previous instance of the module is unloaded */
+	unload_bpf_testmod(verbose);
+
+	if (load_bpf_testmod(verbose))
+		return EXIT_FAILURE;
+
 	for (i = from; i < to; i++) {
 		struct bpf_test *test = &tests[i];
 
@@ -1711,6 +1718,8 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 		}
 	}
 
+	unload_bpf_testmod(verbose);
+
 	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
 	       skips, errors);
 	return errors ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
2.40.1



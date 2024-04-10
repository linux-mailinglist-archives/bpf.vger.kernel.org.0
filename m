Return-Path: <bpf+bounces-26448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BAB89FBAE
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 17:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63695B27210
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03E16F263;
	Wed, 10 Apr 2024 15:33:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73ED156F4F
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763222; cv=none; b=C2eyrfvVX71CYkHJ3QDDoO6jRzk4H4FCn0dkjW7nrIDQ1H+CjpXel3QoD6yvv9H3Bw+lU8mtSZjx/DkYzHwywnpJC7AiTVyveGa3zLOgMu7RColbR7oC/l4Zc2CnYhHgzg8NS0vln194oG5+PyaTjPqgKv20RhiAI2DFXWN59fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763222; c=relaxed/simple;
	bh=4QEV6z1/RLAGOc0PuZJZXyjx6GE3jcy6LBRN0+AFVLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbKOKdJj3vVX5JPRAHKMqpYlndDWqvvAS3eZYwW89KNVMlNsn9kpLI+k8qXMXQtSS6K0YeQznWWg8OU4UaAQa+/HBVD3vN8utEMbEy5yJvgx26c4BSNoNLr0Isz4JxXBYp3it2Cau/Z4I8YJgynA7lVsTTvz2UMHwlRSBDdht3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9AC0F2DC4DF8; Wed, 10 Apr 2024 08:33:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Enable tests for atomics with cpuv4
Date: Wed, 10 Apr 2024 08:33:26 -0700
Message-ID: <20240410153326.1851055-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When looking at Alexei's patch ([1]) which added tests for atomics,
I noticed that the tests will be skipped with cpuv4. For example,
with latest llvm19, I see:
  [root@arch-fb-vm1 bpf]# ./test_progs -t arena_atomics
  #3/1     arena_atomics/add:OK
  ...
  #3/7     arena_atomics/xchg:OK
  #3       arena_atomics:OK
  Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED
  [root@arch-fb-vm1 bpf]# ./test_progs-cpuv4 -t arena_atomics
  #3       arena_atomics:SKIP
  Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
  [root@arch-fb-vm1 bpf]#

It is perfectly fine to enable atomics-related tests for cpuv4.
With this patch, I have
  [root@arch-fb-vm1 bpf]# ./test_progs-cpuv4 -t arena_atomics
  #3/1     arena_atomics/add:OK
  ...
  #3/7     arena_atomics/xchg:OK
  #3       arena_atomics:OK
  Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED

  [1] https://lore.kernel.org/r/20240405231134.17274-2-alexei.starovoitov=
@gmail.com

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index eea5b8deaaf0..edc73f8f5aef 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -658,7 +658,7 @@ $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32)=
)
 # Define test_progs-cpuv4 test runner.
 ifneq ($(CLANG_CPUV4),)
 TRUNNER_BPF_BUILD_RULE :=3D CLANG_CPUV4_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
+TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_T=
ESTS
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
 endif
=20
--=20
2.43.0



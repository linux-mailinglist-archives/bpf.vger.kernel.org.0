Return-Path: <bpf+bounces-65378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0371BB21612
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051A6626764
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1429BDA7;
	Mon, 11 Aug 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVx5HS92"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7452E2832
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942351; cv=none; b=WXbFrJLgoz89QHlmNCKMLcyPLxZDEwZt86395/brNvavP0VIlkE+nspdjM7I0gQr/jJmBSNrY9VhAawEUTkA6r3hEBOc/ZCmvISEhhJ3WWZ7vl3XKQrYXBX7t/wXdMH5jUZC8X1WsUdhCBdNj6eIC/Y5BP38lU+crkIutWhwe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942351; c=relaxed/simple;
	bh=y7R90BneNdMQQ5AIpl4CqOWm3v8N+yFyhDKVaF55++M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooAd+HV6SdO0tS4w581xjRPENEJGoQ3Qs5v9LXH++BWVz5lYgjVsWIwd5SDwVo1EfZn9nYO7UwnmjdJOy3JmWR8Dm4MZnoXwyztpmgf9CVfTa/VAMtYLCuhEKXrLu/JiIjuQ1ef+dGAV3ZMHHLtvumiGheaJKxAXSsEwPja39Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVx5HS92; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso794891866b.1
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942347; x=1755547147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KA4MSrSCDWqpV/vlomKnbnV4nsqnERlAyLlhkUmXgY=;
        b=AVx5HS927ld2UGEUCyrM+9X9mNgDjsTuY2YJ9pv0UedWVbZRKTqIzj9oKta27FtNj1
         1xvZ/Z0mG6BmRDE23BDkL1N+3oNY4hFJ4g24rBfcOjPasRsxUVmt0eidZ1nl36mzti5e
         b3SbT1NN4jC6/wKyIOI0v1Fj3PUivA7xotCqB4lGTaW8qBIqwh7Hrk2zHWWZwL+eT3iE
         tn8zE8GFO7NANiLqjpohAtWMfojcVcZlvlmgK24h2Gzjll6cXb0Ulqbad1Vu7ehnzvH7
         L2PdqqhxXNip10lr3jODDvCw22mufG789fC5JGX7qilk8l+9ZXKjH6h1/LUT26iWhJBm
         NvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942347; x=1755547147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KA4MSrSCDWqpV/vlomKnbnV4nsqnERlAyLlhkUmXgY=;
        b=AN3AvzJXKRSTR3FvkSLy5OWzD0c9v4XN8EzIv8pcrumQ2IPt/i9GCU6HvUmPh9DG0b
         L0LdUPIyFnyRCpMLezU632QzcF6htNF4f9evddK2CmDyX38HXY8xKmc535VqOPWX+MT6
         k1vEYneBJ2lzyRx9IwCcqKJvju6mdEzYSjbATr3bnZUCXu11msN5DaEwE6Rb1486tKBx
         pXlvFGaF64refjf9lRqXS9/ZP8O3HkKXvGB0OUouCSso9inRxGT9ahBwUmeGRfTLEvfn
         PuFkZq8tGR4De/PLBWkQxMzGz0V2VK44txI9D8SUcNSXGvNnYVKCc2ZvyPlxQ2OzrL7e
         LQSw==
X-Gm-Message-State: AOJu0YyHsvO0Neyjw3izaz+rRG2AJ2IqaqKivlzNBJlfp7/47m0iRAbc
	Fj/GtQo+01gsqKHNPYeLc7xYB7tb1L2tG693fz8E5UopxIpMNPTQH4uAlWtmOy5UBdU=
X-Gm-Gg: ASbGncvwTUSh3CiyhHF34bDNVyo1ZzBdExtQyKsVJ0L0MeawiTDeTVZGi2EdWhD6Cz5
	RI6u0ZYrDDdP37qaSL4yjrugYy+qmLil6piPaeQj90vMaY84qJ6WSVTiJMBfbqJ0vqnjj1t8WOE
	WH/i9ezNDQJTJDpt9UcKKwJWyqLYFZqFvanvHLtGl8+N1+sOIHFfMob+sEjQoOx7kTfvZ1zANj3
	linEUynkUKVdExV/8O1/sUO2oUWB2iBkB2iopjHiWVnSAz8XtnQF5zJGXWbViDveSBCywt75jpj
	Nto/2Dy29PCawlHN+5wbCJR8R4iuVeiEE+cyJL5yysoR03mHLaBAwMWfRD0QoHNhgXVF0iRu3kT
	rEuyfZdXqfPU=
X-Google-Smtp-Source: AGHT+IGwLVt+CWc0mSpZp6v19lh++vTy+j6E1/5zEhvuMcBrrggFc9cgA5YGnZYl74EaCw14YN0FBg==
X-Received: by 2002:a17:906:c14f:b0:af9:3019:6aef with SMTP id a640c23a62f3a-afa1dfa0e1emr70950866b.10.1754942346997;
        Mon, 11 Aug 2025 12:59:06 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af95734a066sm1686476066b.44.2025.08.11.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:59:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	tj@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root cgns
Date: Mon, 11 Aug 2025 12:59:01 -0700
Message-ID: <20250811195901.1651800-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811195901.1651800-1-memxor@gmail.com>
References: <20250811195901.1651800-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3631; h=from:subject; bh=y7R90BneNdMQQ5AIpl4CqOWm3v8N+yFyhDKVaF55++M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBomkt74yuPnU6RCILuv3q+dRxypngla+7RgtGNuTjy KzDuHzGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaJpLewAKCRBM4MiGSL8RylbpEA C4YCkVYqp3Qn7je42b7fWDkh4vlBA+XYz5OUatsKvq8stufDjXa5PKTcH6zoHhk5nmyGMMvjz2DpLS AbT/SE2sXvg3o03RzKgDPxAtuIRDU1acps0cvrg9TOhOICuNS9UblWboFAnQADwPOUOX/br1wwAvpB 5pmCQ8dSWsyX2hcxvC0geQCllzTz+e7n7TBie7TUQYCnZdXhqYTIXwogALS0jt18MAKzw33sShxEla HOagpVuqk5wlSW/KWCuged1TfKqaMdBWiby3nRpa9r64xPmo3vZHPbufgRkPBX4fKpnejBRXR3KBWN 9FLkvtI9rWtI8TWe1s36BL6kXW1CPkXa/Z5GjtelShiHEG9Ls+soGGd72Vn7y9l3aCQjpRt4NoD8mV tu6CbFw11QZbCBBXKdOP0fZv87xxkur6IBQRIPCU2IvB6vhOyUR/C0K99H5GUr/KYb1l5YZ88RJIzu KD36jKUBKfKgHPnTBQjDzkPqIY3eh8GtKf/pz5dwKU3eexYvGHZPc0CjQnPLcWAbKecq0xwPD8DpIA YbqIXsbZgxOqD6Qh/wX1qzTwuh1FivaLls/RHlUY/JaIOhsEZMQ/iLNZd00JqWkR03pjvY9jG62Z4U 0vEZCs3wgaIgTmAZ6+o87tVXzl0E4ElDtgeuO9AkWA0H9R7pxe5C2pwlUiSg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Make sure that we only switch the cgroup namespace and enter a new
cgroup in a child process separate from test_progs, to not mess up the
environment for subsequent tests.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 76 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 12 +++
 2 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index adda85f97058..e75a29728f9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -4,6 +4,7 @@
 #define _GNU_SOURCE
 #include <cgroup_helpers.h>
 #include <test_progs.h>
+#include <sched.h>
 
 #include "cgrp_kfunc_failure.skel.h"
 #include "cgrp_kfunc_success.skel.h"
@@ -87,6 +88,78 @@ static const char * const success_tests[] = {
 	"test_cgrp_from_id",
 };
 
+static void test_cgrp_from_id_ns(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct cgrp_kfunc_success *skel;
+	struct bpf_program *prog;
+	int fd, pid, pipe_fd[2];
+
+	skel = open_load_cgrp_kfunc_skel();
+	if (!ASSERT_OK_PTR(skel, "open_load_skel"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_mkdir_err"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, "test_cgrp_from_id_ns");
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	if (!ASSERT_OK(pipe(pipe_fd), "pipe"))
+		goto cleanup;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork result"))
+		goto pipe_cleanup;
+
+	if (pid == 0) {
+		int ret = 1;
+
+		close(pipe_fd[0]);
+		fd = create_and_get_cgroup("cgrp_from_id_ns");
+		if (!ASSERT_GE(fd, 0, "cgrp_fd"))
+			_exit(1);
+
+		if (!ASSERT_OK(join_cgroup("cgrp_from_id_ns"), "join cgrp"))
+			goto fail;
+
+		if (!ASSERT_OK(unshare(CLONE_NEWCGROUP), "unshare cgns"))
+			goto fail;
+
+		ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+		if (!ASSERT_OK(ret, "test run ret"))
+			goto fail;
+
+		remove_cgroup("cgrp_from_id_ns");
+
+		if (!ASSERT_OK(opts.retval, "test run retval"))
+			_exit(1);
+		ret = 0;
+		close(fd);
+		if (!ASSERT_EQ(write(pipe_fd[1], &ret, sizeof(ret)), sizeof(ret), "write pipe"))
+			_exit(1);
+
+		_exit(0);
+fail:
+		remove_cgroup("cgrp_from_id_ns");
+		_exit(1);
+	} else {
+		int res;
+
+		close(pipe_fd[1]);
+		if (!ASSERT_EQ(read(pipe_fd[0], &res, sizeof(res)), sizeof(res), "read res"))
+			goto pipe_cleanup;
+		if (!ASSERT_OK(res, "result from run"))
+			goto pipe_cleanup;
+	}
+
+pipe_cleanup:
+	close(pipe_fd[1]);
+cleanup:
+	cgrp_kfunc_success__destroy(skel);
+}
+
 void test_cgrp_kfunc(void)
 {
 	int i, err;
@@ -102,6 +175,9 @@ void test_cgrp_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
 
+	if (test__start_subtest("test_cgrp_from_id_ns"))
+		test_cgrp_from_id_ns();
+
 	RUN_TESTS(cgrp_kfunc_failure);
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index 5354455a01be..02d8f160ca0e 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -221,3 +221,15 @@ int BPF_PROG(test_cgrp_from_id, struct cgroup *cgrp, const char *path)
 
 	return 0;
 }
+
+SEC("syscall")
+int test_cgrp_from_id_ns(void *ctx)
+{
+	struct cgroup *cg;
+
+	cg = bpf_cgroup_from_id(1);
+	if (!cg)
+		return 42;
+	bpf_cgroup_release(cg);
+	return 0;
+}
-- 
2.47.3



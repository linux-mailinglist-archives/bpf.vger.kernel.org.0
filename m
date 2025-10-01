Return-Path: <bpf+bounces-70075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA9BB04F7
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F0CE4E1696
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252A28BABB;
	Wed,  1 Oct 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D00jlh8g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A041F462D;
	Wed,  1 Oct 2025 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321354; cv=none; b=UgNvDhoamp85QGnH7I21aQ5fGerI0rXQmRMTZvY1kpXYLRh/zZVaBk+XA9U21pJF5YrNMeva3CquQHqDltb+eMsfWRASVNjr7o5XO9f7lQfJFGRhwJUhAFqPGvaxRoA0uCDB4VaE/0Nui/8sh13q6QohpulgJyGA5D/ii/isg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321354; c=relaxed/simple;
	bh=2v7/FdSHTvFXwH044aano9W24FMRjsdOh9lzYgAjJjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrFsnUo0I9F4ajWm/HwqixhqD/y5as1uoctFzAMGBLcZr7+Tn7bZp85Ig3vGgLG/OFCdovzhkawLUS1KvURkXdOCgiHWK2dj1LF2r5E71YEhcXkORUM9dUCvqiWHcP6bc8WbJZmYuIZq3IX3f3Ny3uTmTh9TSk692iI16jTBW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D00jlh8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FCEC4CEF4;
	Wed,  1 Oct 2025 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759321353;
	bh=2v7/FdSHTvFXwH044aano9W24FMRjsdOh9lzYgAjJjo=;
	h=From:To:Cc:Subject:Date:From;
	b=D00jlh8gJAVtxhLIRcZBbr4JE3PBRM5WfidWTOj0f0IMY02YKpWoKEqmGmFBvmn+3
	 7n3KXhpFFTKY2pmO07UPjWNGNO5G26zMh5NxOR+FT82g8KJmPnhdMXgS1wwQYxuxoa
	 QVHm40cDMKeczrKe9m6MjODXLJj/HIfGO6wzUyqMZAy19fLHNFnmUUQOUcfJQqTScm
	 46uvO7qRR/Tei498CzqE1OJ0WX4to/bwuBrF4iFUapXTz4/3P3D9K8pnxlaaCKJTN1
	 mRPVtVLNSvrH6efR8/zWQsy934vM454+z81OnkDKuvmzS1qvIchjkWRigXcTiTajc+
	 ioQ6UyCYg/5Kw==
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
Subject: [PATCH bpf 1/3] selftests/bpf: Fix open-coded gettid syscall in uprobe syscall tests
Date: Wed,  1 Oct 2025 14:22:21 +0200
Message-ID: <20251001122223.170830-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall
invocations") addressed the issue that older libc may not have a gettid()
function call wrapper for the associated syscall.

The uprobe syscall tests got in from tip tree, using sys_gettid in there.

Fixes: 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall invocations")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 6d75ede16e7c..955a37751b52 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -661,7 +661,7 @@ static void *worker_trigger(void *arg)
 		rounds++;
 	}
 
-	printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
+	printf("tid %ld trigger rounds: %lu\n", sys_gettid(), rounds);
 	return NULL;
 }
 
@@ -704,7 +704,7 @@ static void *worker_attach(void *arg)
 		rounds++;
 	}
 
-	printf("tid %d attach rounds: %lu hits: %d\n", gettid(), rounds, skel->bss->executed);
+	printf("tid %ld attach rounds: %lu hits: %d\n", sys_gettid(), rounds, skel->bss->executed);
 	uprobe_syscall_executed__destroy(skel);
 	free(ref);
 	return NULL;
-- 
2.51.0



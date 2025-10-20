Return-Path: <bpf+bounces-71367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F6DBF0000
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6857189EAA8
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9672EC559;
	Mon, 20 Oct 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g++C1C8v"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D131F1517;
	Mon, 20 Oct 2025 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949668; cv=none; b=kwVSVv8l8xTWxZ6ljdCavttSBbmn3ZtqA24cmj+xK/gvJYq0XLzxIk1rvPWHt0jToX+Zi7Y9PbLi3Ka9EU37iiW9ygA3BgjZReRTZW+q7oQaXSzGe+PAkkuvaSB487O1Bcyg10UQYR+DhovQ7xJRqsOVKD8s8pc7j8AfU4FhmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949668; c=relaxed/simple;
	bh=j9yEkHBaZTQHcGD0XBLUbfsvIwG+WLkyVW8M9OqBigQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DohddONyk4EhEOqXrroaoQd+jo2fKWGxy/fgtsgnOCeWPIDSZ+P9SETucbR+uzOCgAf6xcou44DpFEp3WvtxwP8QMWP9u0NfQiSx0Jh3nH/4hgLIYWGc6r9vLs3VXjk98g06B6aEfPQmUD0m+TuZQcu++EnfBZg9vAtqt1acV8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g++C1C8v; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760949654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2ASlFl8CZjWKl3AeuWdFgcOERTPwTmFTKMyRlTsQbM=;
	b=g++C1C8v24WDqr9GGUDcKFTgHO62v13d1uXca2eTAfV2jsuIKtdL6Sp8stnwi1co7315ns
	452UZnaNonN8zXG1+PhwXHGmsLgfLofrzOQEz6PWN7CFenNk6y31Tw2EigaSYxxuM1vIaY
	oLe+eh5TC1SsUc5rMjohqwnTB1v0Rv8=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC bpf-next 5/5] selftests/bpf: add testcases for tracing session
Date: Mon, 20 Oct 2025 16:40:17 +0800
Message-ID: <2243183.irdbgypaU6@7950hx>
In-Reply-To: <aPXwo0puQI3t0CXC@krava>
References:
 <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-6-dongml2@chinatelecom.cn> <aPXwo0puQI3t0CXC@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/20 16:19, Jiri Olsa wrote:
> On Sat, Oct 18, 2025 at 10:21:24PM +0800, Menglong Dong wrote:
> 
> SNIP
> 
> > +static void test_fsession_reattach(void)
> > +{
> > +	struct fsession_test *skel = NULL;
> > +	int err, prog_fd;
> > +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +
> > +	skel = fsession_test__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
> > +		goto cleanup;
> > +
> > +	/* First attach */
> > +	err = fsession_test__attach(skel);
> > +	if (!ASSERT_OK(err, "fsession_first_attach"))
> > +		goto cleanup;
> > +
> > +	/* Trigger test function calls */
> > +	prog_fd = bpf_program__fd(skel->progs.test1);
> > +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> > +	if (!ASSERT_OK(err, "test_run_opts err"))
> > +		return;
> 
> goto cleanup

ACK.

> 
> > +	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> > +		return;
> 
> goto cleanup

ACK.

> 
> > +
> > +	/* Verify first call */
> > +	ASSERT_EQ(skel->bss->test1_entry_called, 1, "test1_entry_first");
> > +	ASSERT_EQ(skel->bss->test1_exit_called, 1, "test1_exit_first");
> > +
> > +	/* Detach */
> > +	fsession_test__detach(skel);
> > +
> > +	/* Reset counters */
> > +	memset(skel->bss, 0, sizeof(*skel->bss));
> > +
> > +	/* Second attach */
> > +	err = fsession_test__attach(skel);
> > +	if (!ASSERT_OK(err, "fsession_second_attach"))
> > +		goto cleanup;
> > +
> > +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> > +	if (!ASSERT_OK(err, "test_run_opts err"))
> > +		return;
> 
> goto cleanup

ACK.

> 
> > +	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> > +		return;
> 
> goto cleanup

ACK.

> 
> > +
> > +	/* Verify second call */
> > +	ASSERT_EQ(skel->bss->test1_entry_called, 1, "test1_entry_second");
> > +	ASSERT_EQ(skel->bss->test1_exit_called, 1, "test1_exit_second");
> > +
> > +cleanup:
> > +	fsession_test__destroy(skel);
> > +}
> > +
> > +void test_fsession_test(void)
> > +{
> > +#if !defined(__x86_64__)
> > +	test__skip();
> > +	return;
> > +#endif
> > +	if (test__start_subtest("fsession_basic"))
> > +		test_fsession_basic();
> > +	if (test__start_subtest("fsession_reattach"))
> > +		test_fsession_reattach();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> > new file mode 100644
> > index 000000000000..cce2b32f7c2c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 ChinaTelecom */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +__u64 test1_entry_result = 0;
> > +__u64 test1_exit_result = 0;
> > +__u64 test1_entry_called = 0;
> > +__u64 test1_exit_called = 0;
> > +
> > +SEC("fsession/bpf_fentry_test1")
> > +int BPF_PROG(test1, int a)
> > +{
> 
> I guess we can access return argument directly but it makes sense only
> for exit session program, or we could use bpf_get_func_ret

Yeah, we can access the return value directly here or use
bpf_get_func_ret(). For fentry, it is also allow to access the return value.
It makes no sense to obtain the return value in the fentry, and
what it gets is just the previous fsession-fentry returned.
And it needs more effort in the verifier to forbid such operation.

The testcases is not complete, and I'll add more testcases in the
next version to cover more cases.

Thanks!
Menglong Dong

> 
> jirka
> 
> 
> > +	bool is_exit = bpf_tracing_is_exit(ctx);
> > +
> > +	if (!is_exit) {
> > +		/* This is entry */
> > +		test1_entry_called = 1;
> > +		test1_entry_result = a == 1;
> > +		return 0; /* Return 0 to allow exit to be called */
> > +	}
> > +
> > +	/* This is exit */
> > +	test1_exit_called = 1;
> > +	test1_exit_result = a == 1;
> > +	return 0;
> > +}
> > +
> > +__u64 test2_entry_result = 0;
> > +__u64 test2_exit_result = 0;
> > +__u64 test2_entry_called = 0;
> > +__u64 test2_exit_called = 0;
> > +
> 
> SNIP
> 
> 






Return-Path: <bpf+bounces-65162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617FAB1CF59
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1287246C6
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006C26B74F;
	Wed,  6 Aug 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cr6KAsqV"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2526A0EE
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522408; cv=none; b=RJ955JN2VYiEf6BgvNxLr95GbWmWXxB0nXPriVLcC38SOAKiWdx5ybloDjRPJaJd9LiqKLCkZTVvr8c4dPwctQcXFzi9hr1lktoaMUP5bU+If1E0NI0IuVnTA3LMNlaqF8JLhriZaePl1khxk2rW2dsaOcM+9CxQEQYEVmXoasc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522408; c=relaxed/simple;
	bh=wHsW6SIbPMwkbBblDPt7VXJn9JrfT2AFVFwEQUK6xNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAXoRknryNDVoDLznfRMRNekc5p08eAhDv0Dgp9mV08ZYJWRvJWyVWIwQTM7wnx7ZkcAE+v4p1kLz0PoYkYlNDmNy3X3oP5dcHk8JHLYgdgAwiCZx8hzUQ7E5ENDDYqw6fDKD9p/9ZCSYTrTYM0EImw/Kw5dMUG/mrWLyQeRNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cr6KAsqV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9140ce6-8352-4aaa-8b18-d35d762c0d63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754522404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2xgw2I4tQxBFyi7ikU0TjxCVGpF6S1DUopFBEFwPM4=;
	b=cr6KAsqVllTpDNas5Vlq5gcPinIa55t4nbNRJVwBRtIZ6Rvt4IohVMF3yRWOzCLi1TS7gV
	Mf0tFilHGREtkPl3keKwPZX4MBfVyvFvPrKTcanPCgSMhk0XyTLKKwnTdw0ekKVzNpUjRF
	7/sWnCIoNYEjrWm0GwdNjOW8VTt9n6E=
Date: Wed, 6 Aug 2025 16:20:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Test multi_st_ops and
 calling kfuncs from different programs
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com, bpf@vger.kernel.org
References: <20250806162540.681679-1-ameryhung@gmail.com>
 <20250806162540.681679-4-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250806162540.681679-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/25 9:25 AM, Amery Hung wrote:
> +static void test_st_ops_id_ops_mapping(void)
> +{
> +	struct struct_ops_id_ops_mapping1 *skel1 = NULL;
> +	struct struct_ops_id_ops_mapping2 *skel2 = NULL;
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);

A default topts is not needed. Passing NULL is as good, so removed.

> +	struct bpf_map_info info = {};
> +	__u32 len = sizeof(info);
> +	int err, pid, prog1_fd, prog2_fd;
> +
> +	skel1 = struct_ops_id_ops_mapping1__open_and_load();
> +	if (!ASSERT_OK_PTR(skel1, "struct_ops_id_ops_mapping1__open"))
> +		goto out;
> +
> +	skel2 = struct_ops_id_ops_mapping2__open_and_load();
> +	if (!ASSERT_OK_PTR(skel2, "struct_ops_id_ops_mapping2__open"))
> +		goto out;
> +
> +	err = bpf_map_get_info_by_fd(bpf_map__fd(skel1->maps.st_ops_map),
> +				     &info, &len);
> +	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
> +		goto out;
> +
> +	skel1->bss->st_ops_id = info.id;
> +
> +	err = bpf_map_get_info_by_fd(bpf_map__fd(skel2->maps.st_ops_map),
> +				     &info, &len);
> +	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
> +		goto out;
> +
> +	skel2->bss->st_ops_id = info.id;
> +
> +	err = struct_ops_id_ops_mapping1__attach(skel1);
> +	if (!ASSERT_OK(err, "struct_ops_id_ops_mapping1__attach"))
> +		goto out;
> +
> +	err = struct_ops_id_ops_mapping2__attach(skel2);
> +	if (!ASSERT_OK(err, "struct_ops_id_ops_mapping2__attach"))
> +		goto out;
> +
> +	/* run tracing prog that calls .test_1 and checks return */
> +	pid = getpid();
> +	skel1->bss->test_pid = pid;
> +	skel2->bss->test_pid = pid;
> +	sys_gettid();
> +	skel1->bss->test_pid = 0;
> +	skel2->bss->test_pid = 0;
> +
> +	/* run syscall_prog that calls .test_1 and checks return */
> +	prog1_fd = bpf_program__fd(skel1->progs.syscall_prog);
> +	err = bpf_prog_test_run_opts(prog1_fd, &topts);
> +	ASSERT_OK(err, "bpf_prog_test_run_opts");
> +
> +	prog2_fd = bpf_program__fd(skel2->progs.syscall_prog);
> +	err = bpf_prog_test_run_opts(prog2_fd, &topts);
> +	ASSERT_OK(err, "bpf_prog_test_run_opts");
> +
> +	ASSERT_EQ(skel1->bss->test_err, 0, "skel1->bss->test_err");
> +	ASSERT_EQ(skel2->bss->test_err, 0, "skel2->bss->test_err");
> +
> +out:
> +	if (skel1)
> +		struct_ops_id_ops_mapping1__destroy(skel1);
> +	if (skel2)

NULL check on skel[12] is not needed, so removed.

Applied. Thanks.

> +		struct_ops_id_ops_mapping2__destroy(skel2);
> +}
> +


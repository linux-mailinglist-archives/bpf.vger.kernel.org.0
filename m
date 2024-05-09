Return-Path: <bpf+bounces-29145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27B8C0834
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 02:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1A282CEA
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5730917F5;
	Thu,  9 May 2024 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TgKwkZXM"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03510E5
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213069; cv=none; b=cjLjmmWAQHXrlYBSqaaKNXKsVPr8ZHnyM6FDI2m4niH8Jrt+I3AW1XvIvEGyXc/Bst6Qb/ajmT7pjZHM1CVoHiX/6KhYXuOltuIhJkjmOWNj9agAeR1FotlLIOrlIJBsl5HcdtEwCtln8hmvIVkVDZIWlYBSpD6AWmUCTuS7s2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213069; c=relaxed/simple;
	bh=k7eg5aU3tk2w9HQKz8ilembG698O91pbnT36IuSt1Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjvCmbiIq+NKPfaPji3+nmOEuJ4vdNpLqmS5rdBnf8Y97Zh6MFxH2zX6eOCtDgO+i4ypgGqyzi8GQk/Bir+apf3oqAJGxZbo1Ak6UVFNMm8WTtBBX4+yc/1ONx/Qw9pX/VRsLJz62kwybEpK7KCXXc04UTk9FMfiXei/aMula0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TgKwkZXM; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4a5571b-7536-402b-b099-19a9e54524b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715213065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kH7mM4Ywg6k0GQxauwtedYjszd+t/xe949oWQ9fNZwY=;
	b=TgKwkZXMqkwwApPKKC58y+iROu0c0NaN9nYkxRSiGAMRoV/xZC/j0XcllJUCNq/FE8HQrp
	dXefDy2XAyPE24tOQZBQ6m7xrpbawTiFz1RESMStjR1O0pynrlvSKSAX7iFEBhAhqBDzAM
	LOcNNpgQRfDfrM/rmVtrb8SN288o2nk=
Date: Wed, 8 May 2024 17:04:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: make sure bpf_testmod
 handling racing link destroying well.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-7-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240507055600.2382627-7-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 10:56 PM, Kui-Feng Lee wrote:
> Subsystems that manage struct_ops objects may attempt to detach a link when
> the link has been released or is about to be released. The test in
> this patch demonstrate to developers the correct way to handle this
> situation using a locking mechanism and atomic64_inc_not_zero().
> 
> A subsystem must ensure that a link is valid when detaching the link. In
> order to achieve that, the subsystem may need to obtain a lock to safeguard
> a table that holds the pointer to the link being detached. However, the
> subsystem cannot invoke link->ops->detach() while holding the lock because
> other tasks may be in the process of unregistering, which could lead to a
> deadlock. This is why atomic64_inc_not_zero() is used to maintain the

Other tasks un-registering in parallel is not the reason for deadlock. The 
deadlock is because the link detach will call unreg() which usually will acquire 
the same lock (the detach_mutex here) and there is lock ordering with the 
update_mutex also. Hence, the link detach must be done after releasing the 
detach_mutex. After releasing the detach_mutex, the link is protected by its refcnt.

I think the above should be put as comments in bpf_dummy_do_link_detach for the 
subsystem to reference later.

> link's validity. (Refer to bpf_dummy_do_link_detach() in the previous patch
> for more details.)
> 
> This test make sure the pattern mentioned above work correctly.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   .../bpf/prog_tests/test_struct_ops_module.c   | 44 +++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index 9f6657b53a93..1e37037cfd8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -292,6 +292,48 @@ static void test_subsystem_detach(void)
>   	struct_ops_detach__destroy(skel);
>   }
>   
> +/* A subsystem detachs a link while the link is going to be free. */
> +static void test_subsystem_detach_free(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .data_in = &pkt_v4,
> +		    .data_size_in = sizeof(pkt_v4));
> +	struct struct_ops_detach *skel;
> +	struct bpf_link *link = NULL;
> +	int prog_fd;
> +	int err;
> +
> +	skel = struct_ops_detach__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_detach_open_and_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> +		goto cleanup;
> +
> +	bpf_link__destroy(link);
> +
> +	prog_fd = bpf_program__fd(skel->progs.start_detach);
> +	if (!ASSERT_GE(prog_fd, 0, "start_detach_fd"))
> +		goto cleanup;
> +
> +	/* Do detachment from the registered subsystem */
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	if (!ASSERT_OK(err, "start_detach_run"))
> +		goto cleanup;
> +
> +	/* The link may have zero refcount value and may have been
> +	 * unregistered, so the detachment from the subsystem should fail.
> +	 */
> +	ASSERT_EQ(topts.retval, (u32)-ENOENT, "start_detach_run retval");
> +
> +	/* Sync RCU to make sure the link is freed without any crash */
> +	ASSERT_OK(kern_sync_rcu(), "sync rcu");
> +
> +cleanup:
> +	struct_ops_detach__destroy(skel);
> +}
> +
>   void serial_test_struct_ops_module(void)
>   {
>   	if (test__start_subtest("test_struct_ops_load"))
> @@ -304,5 +346,7 @@ void serial_test_struct_ops_module(void)
>   		test_detach_link();
>   	if (test__start_subtest("test_subsystem_detach"))
>   		test_subsystem_detach();
> +	if (test__start_subtest("test_subsystem_detach_free"))
> +		test_subsystem_detach_free();
>   }
>   



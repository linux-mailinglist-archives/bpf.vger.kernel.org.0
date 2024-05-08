Return-Path: <bpf+bounces-29144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4B38C081F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 01:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995871C21255
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA381339B8;
	Wed,  8 May 2024 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KjE+CIYV"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CAC29CEE
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212235; cv=none; b=CloaeDmVjky62k0dGhM3jzBSdpv3qEPl7Ku2FAt7iAm9x5PpW2TPBvDXeBHnf0QHKC2emMeZEzr+XCCDS+mnq8iu/DMAGrf2gLwOeahMLSpRi8pOA4w4n8+9vSWcJOQC+e3xaueDm4WDP5XoEmJEJfTpvWbiOCX1rhVcriyBdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212235; c=relaxed/simple;
	bh=Y2WTTWOCzd3RbI+ILjLNBx0/A5JxPTnLamuQ1QAD9T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ld7DCEgrQkcBdElofrSWdeMJMtgexe1DUOPVtjphU7WSrlnXQXcbdTsg5GXXA4kLc9yW0smZQAYP05apQl9P3JesI4N7/GKVTDcW5IOSh1DpQMXkQjoxmBf3P2TbsMWdVLd/RXY9i9av7uxjc4Spjv0ZsZC8eiCzISey8auwRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KjE+CIYV; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0f66283-9c11-4fd8-9880-d9bbc6e36b55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715212231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpJm7O8dOyMuBfTJ/TfbQ9fjwZptXbd3WCtd7juBs8U=;
	b=KjE+CIYVzbRQQqyQnpKrtrKQENvtxvKDfRu2MB4zC07KUh+6nRUQl2USKxKO6bUakgtv3I
	+KWVR7CTEDeYhOyPrMXPwGhl9775NO4XwzPpfWR++xNQlm6+2e68u4X6xPT6401WtoDgoK
	TT1rQYGB017epdcdP7cWMxsofgpA5Ak=
Date: Wed, 8 May 2024 16:50:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 5/6] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-6-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240507055600.2382627-6-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 10:55 PM, Kui-Feng Lee wrote:
> Not only a user space program can detach a struct_ops link, the subsystem
> managing a link can also detach the link. This patch add a kfunc to
> simulate detaching a link by the subsystem managing it.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 21 ++++++
>   .../bpf/prog_tests/test_struct_ops_module.c   | 65 +++++++++++++++++++
>   .../selftests/bpf/progs/struct_ops_detach.c   |  6 ++
>   3 files changed, 92 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index c89a6414c69f..0bf1acc1767a 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -502,6 +502,26 @@ __bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
>   static DEFINE_MUTEX(detach_mutex);
>   static struct bpf_link *link_to_detach;
>   
> +__bpf_kfunc int bpf_dummy_do_link_detach(void)
> +{
> +	struct bpf_link *link;
> +	int ret = -ENOENT;
> +
> +	mutex_lock(&detach_mutex);
> +	link = link_to_detach;
> +	/* Make sure the link is still valid by increasing its refcnt */
> +	if (link && !atomic64_inc_not_zero(&link->refcnt))

It is better to reuse the bpf_link_inc_not_zero().

> +		link = NULL;
> +	mutex_unlock(&detach_mutex);
> +
> +	if (link) {
> +		ret = link->ops->detach(link);
> +		bpf_link_put(link);
> +	}
> +
> +	return ret;
> +}
> +
>   BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>   BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> @@ -529,6 +549,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_dummy_do_link_detach)

It should need KF_SLEEPABLE. mutex is used.

>   BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>   
>   static int bpf_testmod_ops_init(struct btf *btf)
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index f39455b81664..9f6657b53a93 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -229,6 +229,69 @@ static void test_detach_link(void)
>   	struct_ops_detach__destroy(skel);
>   }
>   
> +/* Detach a link from the subsystem that the link was registered to */
> +static void test_subsystem_detach(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .data_in = &pkt_v4,
> +		    .data_size_in = sizeof(pkt_v4));
> +	struct epoll_event ev, events[2];
> +	struct struct_ops_detach *skel;
> +	struct bpf_link *link = NULL;
> +	int fd, epollfd = -1, nfds;
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
> +	fd = bpf_link__fd(link);
> +	if (!ASSERT_GE(fd, 0, "link_fd"))
> +		goto cleanup;
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
> +	if (!ASSERT_EQ(topts.retval, 0, "start_detach_run retval"))
> +		goto cleanup;
> +
> +	epollfd = epoll_create1(0);
> +	if (!ASSERT_GE(epollfd, 0, "epoll_create1"))
> +		goto cleanup;
> +
> +	ev.events = EPOLLHUP;
> +	ev.data.fd = fd;
> +	err = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
> +	if (!ASSERT_OK(err, "epoll_ctl"))
> +		goto cleanup;
> +
> +	/* Wait for EPOLLHUP */
> +	nfds = epoll_wait(epollfd, events, 2, 5000);
> +	if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
> +		goto cleanup;
> +	if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
> +		goto cleanup;
> +
> +cleanup:
> +	close(epollfd);
> +	bpf_link__destroy(link);
> +	struct_ops_detach__destroy(skel);
> +}
> +
>   void serial_test_struct_ops_module(void)
>   {
>   	if (test__start_subtest("test_struct_ops_load"))
> @@ -239,5 +302,7 @@ void serial_test_struct_ops_module(void)
>   		test_struct_ops_incompatible();
>   	if (test__start_subtest("test_detach_link"))
>   		test_detach_link();
> +	if (test__start_subtest("test_subsystem_detach"))
> +		test_subsystem_detach();
>   }
>   
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> index aeb355b3bea3..139f9a5c5601 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> @@ -29,3 +29,9 @@ struct bpf_testmod_ops testmod_do_detach = {
>   	.test_1 = (void *)test_1,
>   	.test_2 = (void *)test_2,
>   };
> +
> +SEC("tc")

The bpf_dummy_do_link_detach() uses a mutex. There is no lockdep splat in the test?

> +int start_detach(void *skb)
> +{
> +	return bpf_dummy_do_link_detach();
> +}



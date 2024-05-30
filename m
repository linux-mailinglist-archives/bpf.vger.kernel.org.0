Return-Path: <bpf+bounces-30981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3148D55E9
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601311F263B0
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79617618E;
	Thu, 30 May 2024 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xt4i73yr"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9A15666B
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110138; cv=none; b=Oh9miezpjwe9pkx6CX5wMSa3JsSzm4DLR+qRXk1RC4Ix85/3fjCxTFJ+wu4Ng16fDQEzEgGomLFHO3U0jDVR3ZLe9PG3Aa8w/uYEAXv0OB5mFTeU++S0JYLYAwS2vtRr0pRajc67XFQ1ktWuZOuyoPEic0TFh1geAjC5HkvjvY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110138; c=relaxed/simple;
	bh=Nxs6HeBBLWdAqGdDt3YuWo3M5XfYU20i8pUELBOaAbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hFq/4UXeLFyboKRtDHPyEuoPDhH7JD0R4nBZjinFOzEfE43iTwFGO4/iNLMJLjedEdfuiin/51YbE8cyWWYxsemTZO8LGDkm7XV2fKIPzD7vVY2QVdWysoGd1ItuglGrAx/GNFvX/S/I2Nw1tD35K2LWLAMK5QY6Ty+bMtXBL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xt4i73yr; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: thinker.li@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717110133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjyXrLel29S3ypn1P2rTPHBdmBw77pyRLwg9iERo0fs=;
	b=Xt4i73yrAf2bStNWWVJ9Ot2euMU+LM2PmVzKvPQKRA4NJrhB4RVeUPL+5LF7X663gsbmDV
	4F4Xp2z5u9WuToZPX2nWx0N9cGSdgA5hLbv+5O9d73lgEBRnXJkx5p1xdLQ2lnUR6A1NXq
	eFAqb9vwtpv/TR2cMNJ35l1smecWMSc=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: kuifeng@meta.com
Message-ID: <08348ecb-5c6d-4937-8bfd-13e2b4d28260@linux.dev>
Date: Thu, 30 May 2024 16:02:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 6/8] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: thinker.li@gmail.com
References: <20240530065946.979330-1-thinker.li@gmail.com>
 <20240530065946.979330-7-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
In-Reply-To: <20240530065946.979330-7-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/29/24 11:59 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Not only a user space program can detach a struct_ops link, the subsystem
> managing a link can also detach the link. This patch adds a kfunc to
> simulate detaching a link by the subsystem managing it and makes sure user
> space programs get notified through epoll.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 ++++++++++++
>   .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
>   .../bpf/prog_tests/test_struct_ops_module.c   | 67 +++++++++++++++++++
>   .../selftests/bpf/progs/struct_ops_detach.c   |  7 ++
>   4 files changed, 117 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 0a09732cde4b..2b3a89609b7e 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -744,6 +744,38 @@ __bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
>   	return err;
>   }
>   
> +static DEFINE_SPINLOCK(detach_lock);
> +static struct bpf_link *link_to_detach;
> +
> +__bpf_kfunc int bpf_dummy_do_link_detach(void)
> +{
> +	struct bpf_link *link;
> +	int ret = -ENOENT;
> +
> +	/* A subsystem must ensure that a link is valid when detaching the
> +	 * link. In order to achieve that, the subsystem may need to obtain
> +	 * a lock to safeguard a table that holds the pointer to the link
> +	 * being detached. However, the subsystem cannot invoke
> +	 * link->ops->detach() while holding the lock because other tasks
> +	 * may be in the process of unregistering, which could lead to
> +	 * acquiring the same lock and causing a deadlock. This is why
> +	 * bpf_link_inc_not_zero() is used to maintain the link's validity.
> +	 */
> +	spin_lock(&detach_lock);
> +	link = link_to_detach;
> +	/* Make sure the link is still valid by increasing its refcnt */
> +	if (link && IS_ERR(bpf_link_inc_not_zero(link)))
> +		link = NULL;
> +	spin_unlock(&detach_lock);
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
> @@ -780,6 +812,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg, KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg, KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname, KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_dummy_do_link_detach)
>   BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>   
>   static int bpf_testmod_ops_init(struct btf *btf)
> @@ -832,11 +865,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
>   	if (ops->test_2)
>   		ops->test_2(4, ops->data);
>   
> +	spin_lock(&detach_lock);
> +	if (!link_to_detach)
> +		link_to_detach = link;
> +	spin_unlock(&detach_lock);
> +
>   	return 0;
>   }

[ ... ]

>   void serial_test_struct_ops_module(void)
>   {
>   	if (test__start_subtest("struct_ops_load"))
> @@ -311,5 +376,7 @@ void serial_test_struct_ops_module(void)
>   		test_struct_ops_forgotten_cb();
>   	if (test__start_subtest("test_detach_link"))
>   		test_detach_link();
> +	if (test__start_subtest("test_subsystem_detach"))
> +		test_subsystem_detach();

A summary of the offline discussion with Kui-Feng.

* serial_ is currently unnecessary for the test_struct_ops_module. It was a 
leftover because of a negative test case that was removed in the later revision 
of the initial struct_ops kmod support.
* Better don't renew this currently unnecessary serial_ requirement.
* The link_to_detach should only be initialized for a particular test. This can 
be done by checking a poison value in the bpf_testmod_ops.
* The reg() should complain and error out if the link_to_detach has already been 
set.

Patch 6 and 7 needs to be a followup. Path 1-5 and 8 look good and are applied. 
Thanks.




Return-Path: <bpf+bounces-65160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987D5B1CF4D
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B218C43E0
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308372690ED;
	Wed,  6 Aug 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozAk8y4t"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FED26980E
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522229; cv=none; b=YessbHnN2WHg6t1LiAaiHEK/J8qGk29MJGE6a+qUhrO5CI6sqzzQWS5/TS+JzlNw6SLqN2z8FwDYFml35Gy2PR2+gZiobJaZJfIihmgTJ/HyFpjwd5IwBcbUVZDq2p9ZQGdIjAG0DmeNEPeI+Fzb68nIvFnZZC48mGdZp7flZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522229; c=relaxed/simple;
	bh=FeCWmPQiD/cqpQoXX+18fO/ItdirJ60NrDGDwnL9tn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5PyHWuBN84Z1QHirc8hkBN0x3xIr+P0VGRUNrGtR3muY57kQrNMm++b3/oGbDlj+bfK/9QoNxq/FM58wpw1oPqMuMxHNsQHeNktd2kdzIWIRC4QZ9DLd5HWmk3kh+t6y56+haH9mzoXa2RzyKmiZTl2GOEj+F0FOBAnF11Z4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozAk8y4t; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3dba1e87-5087-4641-ac9b-db800cbbf994@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754522224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxYvcoRoayv+MkFE8DXXWCxjBeMenqdmnelOyMnQHG8=;
	b=ozAk8y4tmU7Y4eQQeB4Ru/yI+fGj8kIOM/77kHpARmCPMs8aRq9TAy5e9JRXMfCA30s6Yv
	7n6X7M23dyI6KAnGsm43MHiNqzMfHGWYPk1KqT/2ddNiCj3J1nch9L/DURtgLAX5EUYZ7w
	edGjBrT3NOtW6u8eAACftYNohdGLYmk=
Date: Wed, 6 Aug 2025 16:16:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Add multi_st_ops that
 supports multiple instances
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 tj@kernel.org, memxor@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
References: <20250806162540.681679-1-ameryhung@gmail.com>
 <20250806162540.681679-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250806162540.681679-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/25 9:25 AM, Amery Hung wrote:
> +int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
> +{
> +	struct bpf_testmod_multi_st_ops *st_ops;
> +	unsigned long flags;
> +	int ret = -1;
> +
> +	spin_lock_irqsave(&multi_st_ops_lock, flags);
> +	st_ops = multi_st_ops_find_nolock(id);
> +	if (st_ops)
> +		ret = st_ops->test_1(args);

test_1 cannot be NULL,

> +	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
> +
> +	return ret;
> +}
> +
> +static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_testmod_multi_st_ops *st_ops =
> +		(struct bpf_testmod_multi_st_ops *)kdata;
> +	unsigned long flags;
> +	int err = 0;
> +	u32 id;
> +

so I added a "if (!st_ops->test_1)" test.

> +	id = bpf_struct_ops_id(kdata);
> +
> +	spin_lock_irqsave(&multi_st_ops_lock, flags);
> +	if (multi_st_ops_find_nolock(id)) {
> +		pr_err("multi_st_ops(id:%d) has already been registered\n", id);
> +		err = -EEXIST;
> +		goto unlock;
> +	}
> +
> +	st_ops->id = id;
> +	hlist_add_head(&st_ops->node, &multi_st_ops_list);
> +unlock:
> +	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
> +
> +	return err;
> +}


[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> index c9fab51f16e2..b8001ba7c368 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> @@ -116,4 +116,12 @@ struct bpf_testmod_st_ops {
>   	struct module *owner;
>   };
>   
> +#define BPF_TESTMOD_NAME_SZ 16

Not sure why it is here. I don't see it is used, so removed.


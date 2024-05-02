Return-Path: <bpf+bounces-28471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143608BA021
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452791C20C68
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63131172BD2;
	Thu,  2 May 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PrXTW38H"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E2171E6E
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673721; cv=none; b=Lcbd6fdiasE6sn7QyljFp6lIKmGB5YFn6KA5gCFi3rBcrOvIHGSX9AkBjji4qdQJOLwcfMIouClSU/5LhnC5t58c9Ipw3tGJTvKnBy+pWeq2eUBEYVj7sJcSDfmENEbgn0ZLuFocmWak4qtZ/+DR6FfMgbf3J5g5UVxKhy1tiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673721; c=relaxed/simple;
	bh=F+pa46cRYEHFtyOnCWrsyqLK1qo8dmsPtxpTEyLLFT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqXItRXAr9rwkwMAk7Cf7i0B+ggUy4A4DM0VQwIwYxIbu5G+anjjUNSOqh7k4/sbS5Y92/dNpbd7u4ZlJ5Uhp4psDFSH/PcmIpOzHHYYiFtLQMDoFi+yecS1R3N770dxCGX4gUnO4LyEVzR8DyCezGIUffwF6/8ms5Qu1WIS+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PrXTW38H; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7d50210-bc21-4de4-9b2b-01b299a15bd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714673718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE7AjOimVKATmTWXVFbafwqYLs82Mod+K3TBD5lJ6uw=;
	b=PrXTW38HfdccEupFHRo8lMblypCRbYs5MEEBlHlnHXnQl9XN2CrHbl0FIWhOGJT673/O8l
	TwGcUpJIvcWNLunbEjRwRwcbIo5uxXF8HLlzGHJ2w5Co0Sb1lKey+4sK/fFKKdCWaxV8x0
	RZUp85Tx+LUgO8+dIO6npbUS99crCrY=
Date: Thu, 2 May 2024 11:15:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: test detaching struct_ops
 links.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-7-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240429213609.487820-7-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
> @@ -572,6 +576,12 @@ static int bpf_dummy_reg(void *kdata)
>   	if (ops->test_2)
>   		ops->test_2(4, ops->data);
>   
> +	if (ops->do_unreg) {
> +		rcu_read_lock();
> +		bpf_struct_ops_kvalue_unreg(kdata);

Instead of unreg() immediately before the reg() has returned, the test should 
reflect more on how the subsystem can use it in practice. The subsystem does not 
do unreg() during reg().

It also needs to test a case when the link is created and successfully 
registered to the subsystem. The user space does BPF_LINK_DETACH first and then 
the subsystem does link->ops->detach() by itself later.

It can create a kfunc in bpf_testmod.c to trigger the subsystem to do 
link->ops->detach(). The kfunc can be called by a SEC("syscall") bpf prog which 
is run by bpf_prog_test_run_opts(). The test_progs can then decide on the timing 
when to do link->ops->detach() to test different cases.

> +		rcu_read_unlock();
> +	}
> +
>   	return 0;
>   }



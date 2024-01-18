Return-Path: <bpf+bounces-19838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419598320F7
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF3285FBF
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166E731A79;
	Thu, 18 Jan 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rxQec4Q7"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C831A78
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614151; cv=none; b=BNunUsvtnjQwQda+03Z/fjpaD+ky0BYnDNHh2pX8psCgSUqXX8Dmh1hdLcN4vlzFbzCcBJOxgyY0Opy8bjoY9LoF937pmJqm517tEcV5cbfeUIOzgwrhM182EeUWj9Q+x7yWdT4KB6y+Qx3NMiEjxp0rgrOkjfgGK6qnjJfIRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614151; c=relaxed/simple;
	bh=LTXoiY2/QzJyEM4OSn0fm1YmVJ8NhenvrkfLdXTn2Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmeRD4h1dqT+CEGXdlhMkPs20C4hP7cLzoAXeqr0A11LshNFO1qgX6Kay3JXznQ4iY+BKdENrr+UYA571itChUs7aqFTB8ICLaVXYWb1BFzXmh/I/lhyXVAdwMMNU66DiSelq7qQZR7CevYeMDF5TqjHqcXFHJUjhvg8SqUkbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rxQec4Q7; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a504ae9d-56d3-4c45-8f75-a0a77ba998cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705614148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ASt4aeSqIBa37Rvc8y5xk+t74VOhxOrPWwR8EGEf74=;
	b=rxQec4Q7vSkbogGo7kKS5J5c/TMLSkeQW/75xAr50YYJD0zoKjAXvy0USrwx7eN0xodLwC
	OdS+lvyw6+PZO+UUeg+0jjE8gHuY2l5GwXNhb/4226f1gqpYz1Gsg/DGnjEh56hwVyP+kR
	xifz1IIg8/h0eua62025t5FanU2XTdk=
Date: Thu, 18 Jan 2024 13:42:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v16 06/14] bpf: pass btf object id in
 bpf_map_info.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-7-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240118014930.1992551-7-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ed4352f56d21..1e969d035b42 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1732,6 +1732,7 @@ struct bpf_dummy_ops {
>   int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   			    union bpf_attr __user *uattr);
>   #endif
> +void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);

Does it need an implementation for !CONFIG_BPF_JIT?

--

pw-bot: cr


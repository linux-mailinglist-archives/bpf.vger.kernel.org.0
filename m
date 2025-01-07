Return-Path: <bpf+bounces-48035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85826A03413
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 01:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93563A0687
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 00:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9A046BF;
	Tue,  7 Jan 2025 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/iz/20G"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F732EB10
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210103; cv=none; b=N/F8r6OQxDLMm++ie6DKCB3G+4/A2JzMKDeua6peiRz+cZyLk6GoxdrV0qFZ777GG69BcXB9fsuoTKe7GO6GoyXpcs1m0MXXoK8Dll+Qh0Kv8Xa88AD7fto2+BhbYSM2vJHAqStPeX4tjhOf+ipKs1EdEwTPIgvkJ2hD/fvj5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210103; c=relaxed/simple;
	bh=hTjZ/C/ahUWCmWFklByKBt+ub7O5iJpxXAD0uVUxZM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAq4rcj/TDzvjg0l2v7RSY3NNuF2RVzonOset00IiMsXgZ15ECyRSpj1nOsZJB4QC4FCyNwu37q8JXmJAiliTqmjh5SYB/BP3r1ucEL7RXjvJgHPhUWuzDpiacKj3/MAUVMChz4oYp/9nYEff4TdeUb/SaakpIiw9qnoPfls8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/iz/20G; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <932975bf-e413-4eb6-9643-5102f68b1905@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736210093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbaXRjU0xnFyXcSF4Obte8KhypxXDNfasXNDcTyS7SE=;
	b=P/iz/20GKTlaeLzEgp+QVHJoP0n1MIvrgHqzZ4OxX7oURYTxT6uF/fCXD/4W5xe3M10V6/
	SDWQ2DKgKgodI0LIhsgq00emS+Afkudt/X8dosRQYzJYa7HZJmXjvNpg723t903TULwT40
	uZVasPlHvaG1/05ATQDWIu3/+INUfd4=
Date: Mon, 6 Jan 2025 16:34:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Reject struct_ops registration that uses
 module ptr and the module btf_id is missing
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@meta.com, Robert Morris <rtm@csail.mit.edu>
References: <20241220201818.127152-1-martin.lau@linux.dev>
 <1983b3bd389865ddf33d80e9a990c6749eae29b9.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <1983b3bd389865ddf33d80e9a990c6749eae29b9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/2/25 10:14 PM, Eduard Zingerman wrote:
> It was a bit hard for me to figure out what went wrong from the description,
> could you please double-check my understanding below?
> - when struct_ops program is attached,
>    bpf_struct_ops_map_update_elem() scans every member of specific
>    struct_ops type (e.g. struct tcp_congestion_ops) looking for fields
>    with type 'struct module *';
> - to find these fields BTF id of 'struct module' is used, this id does
>    not exist when CONFIG_MODULES=n, bpf_struct_ops_map_update_elem()
>    does not check if 'struct module' BTF id is non-zero;
> - bpf_struct_ops_map_update_elem() initializes 'struct module *'
>    fields using a magic value BPF_MODULE_OWNER, this initialization
>    would not happen if fields are not found;

Thanks for reviewing and testing it!

Yes, the understanding is correct. These are pretty much the only two places 
where st_ops_ids[IDX_MODULE_ID] and BPF_MODULE_OWNER are used.



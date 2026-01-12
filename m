Return-Path: <bpf+bounces-78619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 783A7D153CF
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0917306D29D
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 20:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049122D5C8E;
	Mon, 12 Jan 2026 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EUhMqNkC"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB931326C;
	Mon, 12 Jan 2026 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250018; cv=none; b=WmeTvlZ0q9XcE2BE9VFuQo14WGxBvlM6IwIm1EExZwIQShTRYXOfOWAVyGDhW/ivZ8jJ0mjNx9YV2oFebaY4J+317tSkkAe5VjoQKUE2hNblimn2mts6DmDNqgtOerdo5fiKouEJOakM4nwEhxubCMKlw2tWfz8dRGcqqJav1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250018; c=relaxed/simple;
	bh=6E5ir0MKvTzLi3KjeQ67vT4rjxiQJWGb+HPPvyVahF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psP+1o1/uQMW98B+IJOVR/G9vtSYwFnv2A0yK+2wPVZ/be3AHqMsjy+lU2Yh2ZEMwPaUcR3uBNDnhzDYlczajCPfnN5n0mGIZ1SkvTS+H+GaEZDbhyOkH3IYmEf/zi3LEISZWtqlZ1FxGitTwaT3fNhWmQm3DdbQ6cHscrvsJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EUhMqNkC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a71a2980-9814-4f94-875b-cd6da6822a31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768250004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZwAZadttIzjQgCgVSRvtALF13IG3cbZd+R+sJcZlcY=;
	b=EUhMqNkCjNyynrPQz1qcS4A/nBCP6IMO+ZRiU6uQgjq41ze4qU3IYqJotfgfSM61LKypAE
	ZlTdXNkEeMdTYc6CHzikiBEyiOFKgVInodHi20Oh1mTEj1R6eBZGTE/6N0H/uSNqU4FbNg
	YNwxAOJYzzIixOR2qdxxhzTt6xxCB4M=
Date: Mon, 12 Jan 2026 12:33:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 0/4] Use correct destructor kfunc types
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260110082548.113748-6-samitolvanen@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260110082548.113748-6-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/10/26 12:25 AM, Sami Tolvanen wrote:
> Hi folks,
> 
> While running BPF self-tests with CONFIG_CFI (Control Flow
> Integrity) enabled, I ran into a couple of failures in
> bpf_obj_free_fields() caused by type mismatches between the
> btf_dtor_kfunc_t function pointer type and the registered
> destructor functions.
> 
> It looks like we can't change the argument type for these
> functions to match btf_dtor_kfunc_t because the verifier doesn't
> like void pointer arguments for functions used in BPF programs,
> so this series fixes the issue by adding stubs with correct types
> to use as destructors for each instance of this I found in the
> kernel tree.
> 
> The last patch changes btf_check_dtor_kfuncs() to enforce the
> function type when CFI is enabled, so we don't end up registering
> destructors that panic the kernel.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


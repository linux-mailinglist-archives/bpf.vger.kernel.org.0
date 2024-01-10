Return-Path: <bpf+bounces-19347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45282A50D
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 00:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304501C21CA9
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 23:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204564F8A2;
	Wed, 10 Jan 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RyvisG7e"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256994A9BE
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55ada30c-039d-4121-a4d2-efda578f600f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704930277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXAd9zMi+mlDNsGWyVJIiLZwy+nSz6ome/R4wOApbwQ=;
	b=RyvisG7eBPm60sGTA/CFi8/nY3RvqnWARSiJetDzzbOtoTYRKhq4kLVLbF/C0TdY+b3HqC
	mEmanBThf4Syt47g31TzXQGNpUwL9SEoy0KcXDlRo53MhWnHBC2OApQ0AxWWgQin2+8jCm
	g7OkE0mBzjowru2mYVltUCsnZid94QM=
Date: Wed, 10 Jan 2024 15:44:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com
References: <20240110221750.798813-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240110221750.798813-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/10/24 2:17 PM, thinker.li@gmail.com wrote:
> The proposed solution here is to add PTR_MAYBE_NULL annotations to
> arguments

[ ... ]

> == Future Work ==
> 
> We require an improved method for annotating arguments. Initially, we
> anticipated annotating arguments by appending a suffix to argument names,
> such as arg1__maybe_null. However, this approach does not function for
> function pointers due to compiler limitations. Nevertheless, it does work
> for functions. To resolve this, we need compiler support to enable the
> inclusion of argument names in the DWARF for function pointer types.

After reading the high level of the patch,
while it needs compiler work to support decl tagging (or arg name) in a 
struct_ops's func_proto, changing the info->reg_type of a struct_ops's argument 
have been doable in the ".is_valid_access" without new kernel code change in 
verifier/btf.c.

Take a look at the bpf_tcp_ca_is_valid_access() which promotes the info->btf_id 
to "struct tcp_sock". The same could be done for info->reg_type (e.g. adding 
PTR_MAYBE_NULL).


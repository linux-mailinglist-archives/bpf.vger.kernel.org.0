Return-Path: <bpf+bounces-22608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6E861BEF
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 19:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5AEB22E5E
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5614263A;
	Fri, 23 Feb 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IvgZHBN/"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588F79E1
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713787; cv=none; b=U54GtZssXSu1nDJG0WBRkeWdlqcVuuKBF2aq8X0xlsfUgTzLDg4J+l5/Zk+SMudqC+ZuRChXuM3wgUwuyywF+umLM9E9NTGB215EpFTR+Y8CGZsTAvJcb2+pskv/U84ARuogVMaRLtLNfwb0i1yXcRH0q4IaH0PMv30Nj38o2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713787; c=relaxed/simple;
	bh=SJ3XXbJqzGHp0gLy3E4FW3WSU+dPzJksFfr7SQ9KKtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl0SU3ujaC6j+tiJdb04eg1V01IUsQQsl7G8AAgK1fAad6P9uEBT2nzfbl+6jU+U8MUOz3e6nmWODZpBQ06UUwCEPlfW98hdLo2v90vrkoleZGy6ve0Gz4M3U9u84D2PQLqg/7fmOeEfz+AP5iXEQkhbDbZY0zfe9WLhZMV0pqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IvgZHBN/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ded8001c-2437-48f4-88ff-4c0633f1da7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708713783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9wWBufcL5nVsD1/jTuzRxseQoxm9e45fKML+Vx+Z9Y=;
	b=IvgZHBN/U9fbStDt0YIrjWd8VU3hVwG0vhYEWkHPG99LA8Xd0bAzA76+2Nzadwsgy3cXAQ
	6fN0adEFpQxEB4lzoH1tdcRJOfPJTn9PmckC6YCWZfmAeqpoqzuDXlCykEtNilJkmtBzon
	ugVFQj6uD5cnSyrbA64LADW4ZWPBCUo=
Date: Fri, 23 Feb 2024 10:42:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221225911.757861-1-thinker.li@gmail.com>
 <20240221225911.757861-3-thinker.li@gmail.com>
 <c59cc446-531b-4b4a-897d-3b298ac72dd2@linux.dev>
 <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
 <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
 <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
 <b8bac273-27c7-485a-8e45-8825251d6d5a@linux.dev>
 <33c2317c-fde0-4503-991b-314f20d9e7f7@gmail.com>
 <c938c3b1-8cce-4563-930d-7e8150365117@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <c938c3b1-8cce-4563-930d-7e8150365117@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/23/24 10:29 AM, Kui-Feng Lee wrote:
> One thing I forgot to mention is that bpf_dummy_ops has to call
> bpf_jit_uncharge_modmem(PAGE_SIZE) as well. The other option is to move
> bpf_jit_charge_modmem() out of bpf_struct_ops_prepare_trampoline(),
> meaning bpf_struct_ops_map_update_elem() should handle the case that the
> allocation in bpf_struct_ops_prepare_trampoline() successes, but
> bpf_jit_charge_modmem() fails.

Keep the charge/uncharge in bpf_struct_ops_prepare_trampoline().

It is fine to have bpf_dummy_ops charge and then uncharge a PAGE_SIZE. There is 
no need to optimize for bpf_dummy_ops. Use bpf_struct_ops_free_trampoline() in 
bpf_dummy_ops to uncharge and free.


>>> void bpf_struct_ops_free_trampoline(void *image)
>>> {
>>>      bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>      arch_free_bpf_trampoline(image, PAGE_SIZE);
>>> }
>>>



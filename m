Return-Path: <bpf+bounces-36804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D2B94D8F8
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 01:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC231F22A68
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77316C686;
	Fri,  9 Aug 2024 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g1cthTFp"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F21607AF
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244780; cv=none; b=Q7LATghjdhdAxJ7KdD84C/wjNCG2pAQBMpT3wIVKCfmmHfBK1TlzNPVKmClOhO/JT8k8zR4BrpdB5+5qZSxrN0wAD+bWAHAVCfeFSgCEdMPvz6K10LCiJ+TqOcp5NBt25TwA2ftyI/M7lWXVsOglXC0SPVbbRfAFpfb1ITa3iRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244780; c=relaxed/simple;
	bh=i/VrPRpQOEI+dEYAVdCdujcB/DrY1eqmRWkWPj3npZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMNG+M5WARoEYbvPJB2HpUVwEBEnQCUgaps+WDiDku018qVqmQo6mDP7zcWZBJjARzRgLHubgm4SOI74Vhem2GZ+0lY/lqFrGWsMjqEhMEDx3dsuRhz1fgbz+6IaHinC0A1s4ulWGIUqCX1ekLGLGLl5Yr6VPrNgsG699+N6C0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g1cthTFp; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f9c21f8-1108-4f12-a06e-58837b53e7fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723244775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zus6dRTDl7Yi7cL8178cW5ToMJ6iMDBO3NLgsVM75v4=;
	b=g1cthTFpDXFUzzC26i3OaemrWSiy2nVUNrjFwJ7jp+nBH9w/SolbPYYhuLn5IcHQQgMLp6
	bNBZVWNWXf4izjrqqr8KVr/pSG3hLzLqYFSeYWn9AFGpJh2EfjSgzu02nGxi2otyiLiEd/
	lp3x7ytX0fHBGvLU0VKB359qLM5tF7s=
Date: Fri, 9 Aug 2024 16:06:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Let callers of btf_parse_kptr()
 track life cycle of prog btf
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, houtao@huaweicloud.com,
 sinquersw@gmail.com, davemarchevsky@fb.com,
 Amery Hung <amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
 <20240809005131.3916464-2-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240809005131.3916464-2-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/8/24 5:51 PM, Amery Hung wrote:
> btf_parse_kptr() and btf_record_free() do btf_get() and btf_put()
> respectively when working on btf_record in program and map if there are
> kptr fields. If the kptr is from program BTF, since both callers has
> already tracked the life cycle of program BTF, it is safe to remove the
> btf_get() and btf_put().
> 
> This change prevents memory leak of program BTF later when we start
> searching for kptr fields when building btf_record for program. It can
> happen when the btf fd is closed. The btf_put() corresponding to the
> btf_get() in btf_parse_kptr() was supposed to be called by
> btf_record_free() in btf_free_struct_meta_tab() in btf_free(). However,
> it will never happen since the invocation of btf_free() depends on the
> refcount of the btf to become 0 in the first place.
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Need to fix the checkpatch warning though:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Amery Hung 
<ameryhung@gmail.com>' != 'Signed-off-by: Amery Hung <amery.hung@bytedance.com>'



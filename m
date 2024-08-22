Return-Path: <bpf+bounces-37807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CB95AA18
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219EE282078
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0420B165F11;
	Thu, 22 Aug 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIpKgpfP"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50874D8A3
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289790; cv=none; b=dOdjKaV9enfTLUxep8894AbhzVNVoq9ukLatUdgUsfDNzZqmYsKBgofN/yoyVfjY6SRWOMIi697gxWWlgaNvwTapcqfEcHa5Os5I/HH/SHbdtNoVXN24J8+1Mq1ssk6R+qs1ebD+6W87Ji9zF1xLLp+gy1vhejSFwJNTUrTcgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289790; c=relaxed/simple;
	bh=vWEGLg+ijLBPb7iQGoX0wTUWO6+4/W/DcS70DI4b9Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAx2nXEU9fxY6psPkmLtPtnCKGphrjrPHXVwQNJrkTc77vLh6QfSaeER/XPhcYytXhR0Udk4VFhsbZ2HY1iJakNjLCN4jN1bKnRfJrVc/gozih6y93fVZnto7HIKvhBnt4pf/lkUEgsJFUYUVJqBoMXpIkn5xjSJcIqpACbIj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIpKgpfP; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db0c935c-6997-425b-9e0d-d5bf13beffcc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724289787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpSr5R4og2C+t3V5dJLPZKNxa5BwWKtT0+YDT+BILx4=;
	b=fIpKgpfPxMfjPvbTvGm5BFNjTq6AUEkdExYBBad2kNt98Ew9IYxT6Iuqdu8IR4DG03Wfu4
	6e3CRgLpJCB2fd5ryiBVokKmv6k+hQUAGbk0hlGy47r8ee7TjxHXr1w1IIlCFSosIB/CnR
	rCceH+E9hSfsoK50+LsaZqcD0bYKkrk=
Date: Wed, 21 Aug 2024 18:23:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/5] bpf: support bpf_fastcall patterns for
 kfuncs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20240817015140.1039351-1-eddyz87@gmail.com>
 <20240817015140.1039351-4-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240817015140.1039351-4-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/16/24 6:51 PM, Eduard Zingerman wrote:
> Recognize bpf_fastcall patterns around kfunc calls.
> For example, suppose bpf_cast_to_kern_ctx() follows bpf_fastcall
> contract (which it does), in such a case allow verifier to rewrite BPF
> program below:
>
>    r2 = 1;
>    *(u64 *)(r10 - 32) = r2;
>    call %[bpf_cast_to_kern_ctx];
>    r2 = *(u64 *)(r10 - 32);
>    r0 = r2;
>
> By removing the spill/fill pair:
>
>    r2 = 1;
>    call %[bpf_cast_to_kern_ctx];
>    r0 = r2;
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>


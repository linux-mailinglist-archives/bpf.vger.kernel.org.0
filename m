Return-Path: <bpf+bounces-37802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CDB95A93D
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A842B218A0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E362D1D12E2;
	Thu, 22 Aug 2024 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bXuSvUjX"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C0B67E
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287986; cv=none; b=Bsnxj6FG8QxOT04b4pcYtDacTPIzrZVXrK8zLwSaY6bb9ZLPr8dbpeCE92+WoHbNheY3GQOF/0PLXrbW4LBZb2fNBId8hE2jaufXDUHG1Msh93mufbaHbi8WmN/dRzsK0HDXFqb5er6s/t8bl/nHi44CC5XSoS8JM8l+iN6Qw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287986; c=relaxed/simple;
	bh=/5Hq0hPjBfdDtKimoGPNTBExWY38IX0Hg30GxAx7YaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIXtjKkcUy+kCCxNo95T+UW2PWmNfIVf3g7h1VGKiwBpnXcTY7LnrwTv31I79UfaEeEIboL7xmxbd4rUwVzev856TGuOzfTMpWDxlh4IBmJZ+B/IrId7DHF21/GqDn2mnxfcGrP/juYXSnv3aDPCtlWNR6wOX8UpnCr/DTfcyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bXuSvUjX; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <18149417-a51d-4760-ac99-04f4cf22fcbb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724287981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8734dpZcqE8Efk7mJtqIGqKC3guxqz28dQ6kCrr8JNw=;
	b=bXuSvUjXgpbBNkiyyecDxFn731gSrwoRWc9jOU5MGiXrk2wFMTP3iTJmpa7YCC/3ux4GD2
	WqI0r9S7DWIbF5khJv7frpaMIOfId0VS5pA2MxyMS2HzWsRWP3SpV4r79/GJ42AoppeD2q
	taB+1WfURQPGCwT4eUcGlUbrlh9hPuM=
Date: Wed, 21 Aug 2024 17:52:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: Add gen_epilogue to bpf_verifier_ops
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 Kernel Team <kernel-team@meta.com>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
 <20240821233440.1855263-2-martin.lau@linux.dev>
 <CAADnVQKgT_vJJfOnFdTa6Gpf8s+_D79DwtT8pNzxfw2H4aq1Fg@mail.gmail.com>
 <958b4d92363729f1bed444bc1f4a7d58a54275b1.camel@gmail.com>
 <CAADnVQ++V49=-_bK_dSvxG-WxYEOT=3m1u8tQH1ArALKDy+WhA@mail.gmail.com>
 <c67bb633ced9a345f35e12ee06e29fbc63318024.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <c67bb633ced9a345f35e12ee06e29fbc63318024.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/21/24 5:38 PM, Eduard Zingerman wrote:
> On Wed, 2024-08-21 at 17:34 -0700, Alexei Starovoitov wrote:
> 
> [...]
> 
>> Something like
>> insn_0
>> ...
>> r1 = 0
>> if rX == .. goto insn_0
>>
>> this jmp will be rewritten to point to newly added *(u64*)(r10 - ..) = r1
>>
>> so at run time it will overwrite that slot with zero and
>> epilogue will read zero from it instead of ctx.
> 
> That's exactly what I tried on paper and jmp target was just moving down.

Thanks for bringing this up. I will try a test case to confirm.


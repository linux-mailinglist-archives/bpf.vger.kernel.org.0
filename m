Return-Path: <bpf+bounces-37551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0498957774
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5745C1F21DFE
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A371598E9;
	Mon, 19 Aug 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D3243Jpv"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29538EEA5
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106619; cv=none; b=KSSaBs8vesg1tgH+YAqOc/nhmcfQzvbKbLN3c/akHddlohNSdzhsLEQK0ChZM+l6rFGJr059vEbjqTN4Q/xY4bXWZXZnnXwXwwQJzrFZA+01Eb6MaAAxJSyH8gpVm0ueeaeprL+EmO1Xq8rnlGe6A3wJMRCnPvaHhVqszqnicSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106619; c=relaxed/simple;
	bh=x2rPivRJRngqkhZMjXuu0Kp073R3j5Aj+Cof0OPOOO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nyn+YN6iCJVzmOt6m/BxlTTREoEq6vVOybbF3owdRot+UZ2BcVH2HC/yZeAl4KC36PKtsEq/RxyKhTDcl9tZ/JTK/xEHS91h+vGSh7LhMWvye9XXZAD8+AOEe3d+Ki/G+Sox/i0UZlP+hzdCTFhEOcYbcPki4gSfG52dOT5fQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D3243Jpv; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3887fe5-6093-4829-ab4d-025dc05aff9d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724106615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NodTxGDId7JU3DhkQ9iiKn6yZf8ysf/nnFFbJgI+Pk=;
	b=D3243JpvvfbB89k6UEz6ePArZ/P1hW2bh2VCR+Z+LXYMIZj1ltU1kM97O59aL5bHLFg0Tr
	F3do1oQ9HgRMm82f3Z6xAU0ofcElBS3pV0g/bIuEOS7LgXj6BMhN2svPiXcQjw1TBJf7v4
	A4iej7k+JS/toSoYVXfoFHieLYyDIHI=
Date: Mon, 19 Aug 2024 15:30:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 3/6] selftests/test: test gen_prologue and
 gen_epilogue
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20240813184943.3759630-1-martin.lau@linux.dev>
 <20240813184943.3759630-4-martin.lau@linux.dev>
 <b9fc529dbe218419820f1055fed6567e2290201c.camel@gmail.com>
 <0625a342-887c-4c27-a7a7-9f0eadc31b9d@linux.dev>
 <92f724366153f2fbd7d9e92b6ba6f82408970dd7.camel@gmail.com>
 <2e86ab640b6acbe8e21af826ccfeeac6c055bc69.camel@gmail.com>
 <13f4dee5-845a-4eae-95e3-27c340261098@linux.dev>
 <82a85e54945e6832f5eed24b59dd8950941345c5.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <82a85e54945e6832f5eed24b59dd8950941345c5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/16/24 1:27 PM, Eduard Zingerman wrote:
> On Fri, 2024-08-16 at 10:27 -0700, Martin KaFai Lau wrote:
> 
> [...]
> 
>> Thanks for checking!
>>
>> I think the bpf_map__attach_struct_ops() is not done such that st_ops is NULL.
>>
>> It probably needs another tag in the SEC("syscall") program to tell which st_ops
>> map should be attached first before executing the "syscall" program.
>>
>> I like the idea of using the __xlated macro to check the patched prologue, ctx
>> pointer saving, and epilogue. I will add this test in the respin. I will keep
>> the current way in this patch to exercise syscall and the ops/func in st_ops for
>> now. We can iterate on it later and use it as an example on what supports are
>> needed on the test_loader side for st_ops map testing. On the repetitive-enough
>> to worth test_loader refactoring side, I suspect some of the existing st_ops
>> load-success/load-failure tests may be worth to look at also. Thoughts?
> 
> You are correct, this happens because bpf_map__attach_struct_ops() is
> not called. Fortunately, the change for test_loader.c is not very big.
> Please check two patches in the attachment.

The patch looks good. I tried and it works. I will add it in the next respin.
That will help to cover the __xlated check on the instructions generated by 
gen_pro/epilogue and also check the syscall return value for the common case.

Except the tail_call test which needs to load a struct_ops program that does 
bpf_tail_call and another struct_ops program that was used in the prog_array. 
These two struct_ops programs need to be used in two separate struct_ops maps to 
be able to load. The way that test_loader attaching all maps in your patch will 
fail because bpf_testmod does not support attaching more than one struct_ops map.

I don't want to further polish on the tail_call testing side. I will stay with 
the current way to do the tail_call test which also allows the more regular 
trampoline "unsigned long long *ctx" for the main struct_ops prog and also 
allows using ctx_in in the SEC("syscall") prog.

Thanks.


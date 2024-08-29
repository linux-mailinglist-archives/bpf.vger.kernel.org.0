Return-Path: <bpf+bounces-38462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C3965080
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 22:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84702B21E5E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD071BA297;
	Thu, 29 Aug 2024 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZBjHfb4z"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E81494A7
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962161; cv=none; b=HDWiZaJ0yqkAeSMQfH2SCZesbpOJF+ZDNm3BL5MJNOP1ryc0C4ZAwcEKZCWQP0zjUzcuakyff4wP7mq10kLNd8/yurwoFak674c9p+wsY6Ql3bNW7pbjyUntvoBKpYcJwh+kFj6A25teNUCgkOzwYQYH+leg2KVMaUdI9mcvK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962161; c=relaxed/simple;
	bh=oK9FKdaXDr7wVghPTrW1PVGLzB1VPjUXNLKrWQyUwD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCAErEeB+mxCaMj4+Wg9CkX5GTmr9HfiaYTMCKGlZbpz+TkIWXbpVitWrmLbW9iG8ZFm4ZM8KWMvWM4eZQCF4YB1aGWfx5MtcNLTi6zYSzHKzNQvDlDTA+Kkv5qZ7VY9rZi+b1eTBkUHyturuEJM2DxuWIWkw6d/Sz9XFJPlvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZBjHfb4z; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c6b9355-f64f-4c4c-8943-3f1a443ddb02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724962156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g62kdf/7a1fE7OyS3AUUMNgr2Bj0IFV3/xoEEB68RbA=;
	b=ZBjHfb4zYSOqnpTjHvJo+3efcqIgRx7plr3+U37yvlRevgchaCQwijbodGw2EIO3nQxgML
	fMJ19j7o8JwkjvdFk3n2ND/AyI4Q8bppZr0+yHH7CjTUwORRX3v0jZEqd5TZgAwFYSfoxq
	IAntZriQfNeORJB40c96PVbZs0v43VU=
Date: Thu, 29 Aug 2024 13:09:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 9/9] selftests/bpf: Test epilogue patching
 when the main prog has multiple BPF_EXIT
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-10-martin.lau@linux.dev>
 <08bc097d-6e95-4fc9-8899-1c0c69712005@linux.dev>
 <7e254fb2c9bdb9350d9be5f894e346e5cbf7382c.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7e254fb2c9bdb9350d9be5f894e346e5cbf7382c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/24 11:28 PM, Eduard Zingerman wrote:
> On Tue, 2024-08-27 at 17:58 -0700, Martin KaFai Lau wrote:
> 
> [...]
> 
>>> +SEC("struct_ops/test_epilogue_exit")
>>> +__naked int test_epilogue_exit(void)
>>> +{
>>> +	asm volatile (
>>> +	"r1 = *(u64 *)(r1 +0);"
>>> +	"r2 = *(u32 *)(r1 +0);"
>>> +	"if r2 == 0 goto +3;"
>>> +	"r0 = 0;"
>>> +	"*(u32 *)(r1 + 0) = 0;"
>>
>> llvm17 cannot take "*(u32 *)(r1 +0) = 0".
>>
>> Instead:
>>
>> r3 = 0;
>> *(u32 *)(r1 + 0) = r3;
>>
>> The above solved the llvm17 error:
>> https://github.com/kernel-patches/bpf/actions/runs/10586206183/job/29334690461
>>
>> However, there is still a zext with s390 that added extra insn and failed the
>> __xlated check. will try an adjustment in the tests to avoid the zext.
> 
> Another option would be to limit archs for the test, e.g. use
> __arch_x86_64 and __arch_arm64.

Ah. good to know.

I have used all 64bits ops to solve it. It passed the earlier bpf CI run:
https://github.com/kernel-patches/bpf/actions/runs/10590714532
I will respin with the 64bits ops solution.



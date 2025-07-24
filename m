Return-Path: <bpf+bounces-64232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3BBB0FEE5
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 04:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E0D4E8235
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3771A83F8;
	Thu, 24 Jul 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xilrkq4v"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADD7081E
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324989; cv=none; b=HMWRenZTc1022geJEtNPBNAA9Z7KY9YKPatwNBx0OFFVphJmj2YpepYVyIZPzF+T0wxYAEykmz8MyDUgUfzXGIRvge5ZnO0VOjyUn7R9YUg3WyrPSRPn2l02w3QOYoNFdTTJv/aFcNqG3JdIoEs66nTd6OGHc+HZ0laLNGk68Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324989; c=relaxed/simple;
	bh=aarN4YJ3NdxokyWQGR+o+2jPluJhpyLfAuO58uBhmRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxAqy+l/IrMQH0DAX7wZYLwWHw9hU3fu2chJ8p4QfP0Vr/TwCcXS7FiwMNe/yOd8lVcR8VX8GSRWHA3U4Hi4B6Xe7rUBFbWtqtTEr2veQSSsxT1IaiJ8aixAoGhdYp5yAmfRe/2ZrpYnsO0nuCz2rOaDBNqSLKgvuEuJ6Zp7g9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xilrkq4v; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <697adce5-2afe-45bb-9e01-1022efb94e39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753324983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRAteS0Uw+84AjpwgLgA3yn9D95AAawY8ZxyiDWMwmU=;
	b=Xilrkq4vIQfJArGRAMnZ59KHzMJwyfk7PXl1tt1HrJKLAVD4OxHvorDZ6AmcQ9oEv8n/xv
	Hgmp42Q+kur6zep/XpOT1mVOYt8r7OI9m9EwWUZ8AjT9HWyjiGe052i8mijIOdli0AmD/A
	ChqCXbsVARUK4Lhq9Jib/YCvffE3fLc=
Date: Wed, 23 Jul 2025 19:42:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject narrower access to pointer
 ctx fields
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>
References: <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
 <0e81620a-a03f-4a95-9f7d-45ca63813368@linux.dev>
 <aICZqWFT77dvmJqc@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <aICZqWFT77dvmJqc@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/23/25 1:13 AM, Paul Chaignon wrote:
> On Tue, Jul 22, 2025 at 03:28:40PM -0700, Martin KaFai Lau wrote:
>> On 7/22/25 7:32 AM, Paul Chaignon wrote:
>>> The following BPF program, simplified from a syzkaller repro, causes a
>>> kernel warning:
>>>
>>>       r0 = *(u8 *)(r1 + 169);
>>>       exit;
>>>
>>> With pointer field sk being at offset 168 in __sk_buff. This access is
>>> detected as a narrower read in bpf_skb_is_valid_access because it
>>> doesn't match offsetof(struct __sk_buff, sk). It is therefore allowed
>>> and later proceeds to bpf_convert_ctx_access. At that point,
>>> target_size is null and the verifier errors with a kernel warning and:
>>
>> I think it meant target_size is 0. I suspect !cnt is the condition causing
>> the 'verifier bug: ...'. Please check. No need to resend. The patch lgtm.
> 
> I also initially though the error was triggered because cnt was 0, but
> it is not. In case of narrower load, the offset is aligned before
> calling convert_ctx_access, which means we match
> offsetof(struct __sk_buff, sk) in bpf_convert_ctx_access. An
> instruction is added and cnt is thus 1. target_size however stays 0 so
> we hit the verifier bug error.

Got it. I have added this details to the commit message. Applied. Thanks!


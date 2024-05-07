Return-Path: <bpf+bounces-28918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421AF8BEAFA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42B2282A7D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B716C857;
	Tue,  7 May 2024 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRJxCELM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FC10E6
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104743; cv=none; b=O2rqB0gJI3gfjFG0wvXQmw5UnMHYTkKvE1H7EErsP0qCYUcI/KGzcl84xVzwbLEupui8g2EGeCfEDS3T1qoNHywxSu/5E/ICud/jSs1bvVDKtdQgEvM5UhIDZAXmy5Xi6gaRVYzTUVjLPLPzf/sclfiWU2Mg9VDGi089as+tcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104743; c=relaxed/simple;
	bh=AFNM8weygNe//MJR86qy1aGU2LKCBu/DC5zsAWs51PU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qM54+EMSxe5FQTv7Ms9/LIfM+lFIQp+bpohuEmE0fhYOYmEtxn4dGmK41VG0QnSyxJadW/3WRCvgY0vgiaV7tBLeHNesY9/l1/Crj/ND+ZWwoop46Qn//QarzpNrhxK6bUV+L7kZohFmuRagpXvmkoOmiXcnXZL+dH6YuObKJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRJxCELM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D60C2BBFC;
	Tue,  7 May 2024 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715104743;
	bh=AFNM8weygNe//MJR86qy1aGU2LKCBu/DC5zsAWs51PU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CRJxCELMVzKSTxCzc/4lNfoA09gawZsrX6grUUvc6GSLe56d/Df6735sF9P/R7I0E
	 wSygLx3jemZo0ePB3Cd2LMaVugUXUB5N/VvT/wt+xh7PBQS2M4oG82f3EFVkqfnBL3
	 BJotvhxHFJ2ahjEDB9RKPgdIjEc6bVxNLyMbKiqQZ5G02qQvJykPJHiL6L4KdtXc7p
	 hHnHVVd2fSd6MdcQSF6koXEk5EzFiyun4VVWIg6tDnNk2YhMcosz3jI7AsLolIsnIm
	 lovX5svWFq/iAUoyP/Cs6hjOkS8jVBX9xW6wpLmEa9t+OHlRKWxRWbBVrIPMz7lczS
	 SyZvrVbgvgAtw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu
 Lehui
 <pulehui@huawei.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, Michael Ellerman <mpe@ellerman.id.au>, Hari
 Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH bpf] riscv, bpf: make some atomic operations fully ordered
In-Reply-To: <zdyarsgcnk6fwiqg7ir3e7m5vggchd77vlac2bkstkenenplam@i4ecorifshni>
References: <20240505201633.123115-1-puranjay@kernel.org>
 <mb61p34qvq3wf.fsf@kernel.org>
 <zdyarsgcnk6fwiqg7ir3e7m5vggchd77vlac2bkstkenenplam@i4ecorifshni>
Date: Tue, 07 May 2024 17:58:59 +0000
Message-ID: <mb61pfrut4i70.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Naveen N Rao <naveen@kernel.org> writes:

> Hi Puranjay,
>
> On Sun, May 05, 2024 at 10:40:00PM GMT, Puranjay Mohan wrote:
>> Puranjay Mohan <puranjay@kernel.org> writes:
>> 
>> > The BPF atomic operations with the BPF_FETCH modifier along with
>> > BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT implements
>> > all atomic operations except BPF_CMPXCHG with relaxed ordering.
>> 
>> I know that the BPF memory model is in the works and we currently don't
>> have a way to make all the JITs consistent. But as far as atomic
>> operations are concerned here are my observations:
>> 
> ...
>> 
>> 
>> 3. POWERPC
>>    -------
>> 
>> JIT is emitting all atomic instructions with relaxed ordering. It
>> implements atomic operations using LL and SC instructions, we need to
>> emit "sync" instructions before and after this sequence to make it
>> follow the LKMM. This is how the kernel is doing it.
>
> Indeed - good find!
>
>> 
>> Naveen, can you ack this? if this is the correct thing to do, I will
>> send a patch.
>
> Please do.
>

Hi Naveen,
I have sent a patch fixing both ppc32 and ppc64. But I don't have a way
to test this or even compile it:
https://lore.kernel.org/all/20240507175439.119467-1-puranjay@kernel.org/

Can you help me test this? the change is trivial.

Thanks,
Puranjay


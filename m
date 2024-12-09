Return-Path: <bpf+bounces-46412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B69E9C90
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF2828170D
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FF150980;
	Mon,  9 Dec 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf7WqEz8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BA14AD22;
	Mon,  9 Dec 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763963; cv=none; b=rSwWHyJXMXS8Vj/eJHF4+qjD2RAHw3qaXtNmeJ+yaP2X6tVt1k2/XR1J5ZOA+2r4wFM+tt84vSnhLAIS8Q/guOLg5mk/mmVzbd9In7vuEM+zmDdX622ZMdl2b0mkQQgHQPSrMZXdRp+3rIxhSLwDqCLU72S/IynzvvCcBCZXuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763963; c=relaxed/simple;
	bh=tk78KDuHOa/sqaRSeNjA7K/YjzQk0tS59Phe41D4EHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOZjes5mIwJDa4+1ns+FM44PActyiDRsTAMdcn255ka5rVWlzrK9H7uqZXj0SLFCnkdC6FEuKYiIzI3MkaYEUgBxZ46FwSwAYWflNaboCCW1EB1Z999ymqaVFXmTGGb8bm0wAy9HPlRI9ZuMUTyKq+Rh5le11h8/RAq1DEVrnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf7WqEz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE0C4CED1;
	Mon,  9 Dec 2024 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733763963;
	bh=tk78KDuHOa/sqaRSeNjA7K/YjzQk0tS59Phe41D4EHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uf7WqEz8xWAkbrSTsIs789CjOJo//drHCAuS0YczcNy3z5pIryY2KRmgAvLPJGRVk
	 rmsLLBXGVpiqnFg7lftlth4mUt10A4otOxZgNRjtdXXxrzu7e/lK1QIXyl0+gDftvq
	 u11CnzfUFONXm+HfdFcTi3Xichs0tY3lxkoayXTblCU4uANZQYBle/ogzKcMn2r8u3
	 4vKIBknhzL5Jy//uemNIU8j+0pUZwzexal2TSJBCWqTOFmpvVZNZbkkm+6H3RD3OXG
	 xFAWZYaNU9/+yVXdQfaVz/faAX5WKE175KyoIWC88Mh1FRdW7pUG6WH+wSWGBKKb+t
	 6Rd6KnvjLxHaA==
Message-ID: <98c2ad67-2672-4eef-b952-18e6ad28a027@kernel.org>
Date: Mon, 9 Dec 2024 17:05:57 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Probe for ISA v4 instruction set
 extension
To: Simone Magnani <simone.magnani@isovalent.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241209102644.29880-1-simone.magnani@isovalent.com>
 <20241209145439.336362-1-simone.magnani@isovalent.com>
 <11d588c2-febe-46c4-ab49-8fb0ed80faac@kernel.org>
 <ca871055-0b4c-4380-8f32-a4a7152345c6@isovalent.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <ca871055-0b4c-4380-8f32-a4a7152345c6@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-09 18:01 UTC+0100 ~ Simone Magnani <simone.magnani@isovalent.com>
> On 09/12/24 16:20, Quentin Monnet wrote:
>> Looking again at the probe itself, does the second instruction serve any
>> practical purpose here? Don't you just need to test the BPF_JMP32_A?
>>
>> Looks good otherwise, thank you!
>>
>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 
> I wanted to keep probes similar to the previous ones (especially v3
> and v2), despite we never check their return codes. This means
> having as 4th instruction `BPF_MOV64_IMM(BPF_REG_0, 1)`. However,
> to do so, I also need the 2nd instruction, otherwise I'd hit an
> `Invalid Argument` error while calling `bpf_prog_load()`: I think
> that would be due to the fact that no execution paths would
> execute that instruction otherwise.


Right, that's what I missed.


> 
> An alternative approach less consistent with the others would be:
> 
> struct bpf_insn insns[3] = {
> 		BPF_MOV64_IMM(BPF_REG_0, 0),
> 		BPF_JMP32_A(0),
> 		BPF_EXIT_INSN()
> 	};
> 
> Please let me know if you have any further questions, need
> additional information, or if I could improve the patch.


No it's all good to me in that case, thank you!

Quentin


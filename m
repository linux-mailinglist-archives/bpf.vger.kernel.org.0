Return-Path: <bpf+bounces-18803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B61822235
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C5F1C22944
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FD15EA1;
	Tue,  2 Jan 2024 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p00FYzsS"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA515E94
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1b45ec38-3a7f-4745-a063-8b16b040004c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704224496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzL7Ac3xL2i6ZN+qRT7SHN2zT5JTjIEDihVwjlBX3K4=;
	b=p00FYzsSYLlOjxx8wKezWuy7IGKCP4FoUPLd+B0y45NCOxCjm9Jg+7xG/YLJftlSrBiZiI
	uL3GVmQXHjDVto4aCRoPGb4euvqMwuwt2N8eBVnkTmu1z8VQPwQVT3va9/7LIeOfsRAq/m
	sQP/MvHTTWQOxZJeL+mzyFLjO8lLBMc=
Date: Tue, 2 Jan 2024 11:41:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: test_kmod.sh fails with constant blinding
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, Bram Schuur
 <bschuur@stackstate.com>, "ykaliuta@redhat.com" <ykaliuta@redhat.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "johan.almbladh@anyfinetworks.com" <johan.almbladh@anyfinetworks.com>
References: <AM0PR0202MB3412F6D0F59E5EBA0CA74747C461A@AM0PR0202MB3412.eurprd02.prod.outlook.com>
 <08287f7c-d0aa-4ded-a26d-34023051dd14@linux.dev>
 <28bcf5ae2df9ed0bd1603ed161e1d4488694c0d9.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <28bcf5ae2df9ed0bd1603ed161e1d4488694c0d9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/2/24 9:47 AM, Eduard Zingerman wrote:
> On Tue, 2024-01-02 at 08:56 -0800, Yonghong Song wrote:
>> On 1/2/24 7:11 AM, Bram Schuur wrote:
>>> Me and my colleague Jan-Gerd Tenberge encountered this issue in production on the 5.15, 6.1 and 6.2 kernel versions. We make a small reproducible case that might help find the root cause:
>>>
>>> simple_repo.c:
>>>
>>> #include <linux/bpf.h>
>>> #include <bpf/bpf_helpers.h>
>>>
>>> SEC("socket")
>>> int socket__http_filter(struct __sk_buff* skb) {
>>>     volatile __u32 r = bpf_get_prandom_u32();
>>>     if (r == 0) {
>>>       goto done;
>>>     }
>>>
>>>
>>> #pragma clang loop unroll(full)
>>>     for (int i = 0; i < 12000; i++) {
>>>       r += 1;
>>>     }
>>>
>>> #pragma clang loop unroll(full)
>>>     for (int i = 0; i < 12000; i++) {
>>>       r += 1;
>>>     }
>>> done:
>>>     return r;
>>> }
>>>
>>> Looking at kernel/bpf/core.c it seems that during constant blinding every instruction which has an constant operand gets 2 additional instructions. This increases the amount of instructions between the JMP and target of the JMP cause rewrite of the JMP to fail because the offset becomes bigger than S16_MAX.
>> This is indeed possible as verifier might increase insn account in various cases.
>> -mcpu=v4 is designed to solve this problem but it is only available at 6.6 and above.
> There might be situations when -mcpu=v4 won't help, as currently llvm
> would generate long jumps only when it knows at compile time that jump
> is indeed long. However here constant blinding would probably triple
> the size of the loop body, so for llvm this jump won't be long.
>
> If we consider this corner case an issue, it might be possible to fix

This definitely a corner case. But full unroll is not what we recommended although
we do try to accommodate it with cpuv4.

> it by teaching bpf_jit_blind_constants() to insert 'BPF_JMP32 | BPF_JA'
> when jump targets cross the 2**16 thresholds.
> Wdyt?

If we indeed hit an issue with cpuv4, I prefer to fix in llvm side.
Currently, gotol is generated if offset is >= S16_MAX/2 or <= S16_MIN/2.
We could make range further smaller or all gotol since there are quite
some architectures supporting gotol now (x86, arm, riscv, ppc, etc.).



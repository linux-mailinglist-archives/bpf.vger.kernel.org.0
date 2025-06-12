Return-Path: <bpf+bounces-60531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E71EAD7DAA
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742BE1891876
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637B2DCBE4;
	Thu, 12 Jun 2025 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BVUoNVob"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C32253B0
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764364; cv=none; b=VCo3wcUX/8UzWwu9ZGxXZz+7A5AtmAmMpcsdRNIj2ObYibdE34zpfZDZ0Z6EVcO+m7b6KI4U89HigpqzDcJOByXpWWTAzsYLfkpFyY+1iJg6bY03xjoSebszErCZuhIMantHor+8bgG15EToeSmuR7jm2dUfOi33AlD32xLdEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764364; c=relaxed/simple;
	bh=bMQWOKfUjvG0dqMSJ/90QiK3ilg2BJbnK86wTHlpIpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYUcBNPa1ejpAZcygw79BtLwxchN8PA1CatolTf1eXp79AFc5qfo7yw1QKh7oVSP/SdZMolccH+2MyQclwpEMU5elgfUzDrKMOgdgnaZ2UCvSH9L7PttqaKaa8AZ5hTl6oDN+clJbhcfezJ2UAg/wRogzpeAWxtr8T9SZktKeg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BVUoNVob; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9665f3b3-1c8e-4dae-b8df-c3147b119ff2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749764360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMQWOKfUjvG0dqMSJ/90QiK3ilg2BJbnK86wTHlpIpw=;
	b=BVUoNVobEfjxJ90BWK2gEpetPQVyS72I2rsfcAZHlr6phaVtR63u4u9OOWMyZeOb01kyxu
	5e9Znf+cWO02fL1qxR1pQCo/gtGHnLwz5+J9a8fSyMP8wQmmsulBSA7QqI/PqlXuDEuQ15
	/MOvx21XUM/LY4pFVYC0NtYuMspMjBU=
Date: Thu, 12 Jun 2025 14:39:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm
 codes
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
 <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
 <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
 <cbc60943-783e-4444-9d46-3a25e71a6e63@linux.dev>
 <b35717b7c65a0ee8baba9800dbbb2c9e58c62b32.camel@gmail.com>
 <CAADnVQKrrEFcUdUvagwSkrCLJSoud4Jv0=CM2rX7p5MYKYOC=Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKrrEFcUdUvagwSkrCLJSoud4Jv0=CM2rX7p5MYKYOC=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/12/25 2:15 PM, Alexei Starovoitov wrote:
> On Thu, Jun 12, 2025 at 12:49 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Thu, 2025-06-12 at 12:29 -0700, Yonghong Song wrote:
>>
>> [...]
>>
>>>> Warning in llvm/gcc on imm32 > UINT_MAX is not correct either.
>>>> llvm should probably accept 0xffffFFFFdeadbeef as imm32.
>>> In llvm, the value is represented as an int64, we probably
>>> can just check the upper 32bit must be 0 or 0xffffFFFF.
>>> Otherwise, the value is out of range.
>> I agree with Yonghong, supporting things like 0xffffFFFFdeadbeef and
>> rejecting things like 0x8000FFFFdeadbeef would require changes to the
>> assembly parser to behave differently for literals of length 8 (signe
>> extend them) and >8 (zero extend them), which might be surprising in
>> some other ways.
> Ok. So what's the summary?
> No selftest changes needed and we add a check to llvm
> to warn when upper 32 bits !=0 and != 0xffffFFFF ?

I did a little more checking, I think the value range
in [INT_MIN, UINT_MAX] is what we want. This is also my v1 of
llvm patch.

Support we have 64bit value, 0xffffFFFF00000001,
truncating the top 32bit, it becomes 1 and this value 1
won't be able to sign extension properly to 0xffffFFFF00000001.

But for any 64bit value in [INT_MIN, UINT_MAX],
if truncated to 32bit, it can still do proper sign
extenstion to get the original value.



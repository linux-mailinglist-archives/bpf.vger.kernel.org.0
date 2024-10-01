Return-Path: <bpf+bounces-40706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9B98C56A
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 20:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39101C255E3
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACD61CF7B2;
	Tue,  1 Oct 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="QmIs2LR5"
X-Original-To: bpf@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B311CF5C9
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807376; cv=none; b=JgVt8Orph5y8NfVq9ml4vw64S0sEAL2iHmXe9GYgl0EjyKZaEI0RSYDmOVkB8udG997iTH2+CcuNDtuRQBckbjP8f4xEwWkUIDCN93uiFuAg96I5ybvlT/Ed6ZGPMa4DM49F0bgCbZRvxsqSVdaJ3I2B/ZFBdrng7uTcSLvqiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807376; c=relaxed/simple;
	bh=rymCLRp8bc5Xk7Lvs02fz5ko8TL4pTl+rn9UZSQGRFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efjfp6POOOCBbblj2tg/qpB3LYJF+Ka/c1xxdYJuKIsaS2hj5nPcxjs04uUDr+Onq7oHU5AQf9ShQe97dzqfq+hy0aYFQ9TOYwvn3ndCqTUlsXqfvhoQX0WGjDqc2ZAfML05Cvg07aeV0jygl1MLBnFqIhB5rUO2aTzLXR4JYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=QmIs2LR5; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1727807365; bh=rymCLRp8bc5Xk7Lvs02fz5ko8TL4pTl+rn9UZSQGRFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QmIs2LR53IzE40awmPRTeIqc1zThsSsaAYexPA0XtYpWRrErvZqrRy5fB5v32MAdQ
	 5CJf//4O21+/AxyQ5FKbI/B2qarZElyH/m4xRz5hxmSjgmLLRg0lbuTuaCeiALb17I
	 U3OtFn2tzbkz05AcZWXKp6gdvtRhSxdCHJqz1I8x92KYxzzGWfB0Khcwa2Ur3IFNrf
	 bO6yOkt/GHpk+wtQiEx+cpBn+91WnV0v6o7ooyPSFgKi2sd1q5mMiLib1jTjtBVKfZ
	 3qFXtAelOudUGQceeVERm+z2Jpag8PRFL5Do9I3N0s2c621UTJ8h0G0klZZJWGF0XR
	 ai0/tbIaz7sCLrdldEKqYLgjZrfPJ71AoDJuEIX7Q/e93AkERAtPVOcwO9V44v9oYe
	 bl7MfclQIBgI0LfyZ/BVF8gWTGg5ZQniRAjNM7+kjBn1+cr+HhMzqrrakkRZ5em/jB
	 q5u+jtVRiMcHz/o4Um/VZZa3ZYVk53J8epz4GK9erYcK2ekAGoe3CywBkhJl/ymKEu
	 ia7ZxK/tgbhILiz6u24ixJe0JpPQ63W0fxLtmz8sIVkMJVtAtVo/bxr1iMb9fH6Nnq
	 M8q5DXkt3BEBLrM9PfZT1MpOUgpRbyDu/7FmxEkSwUqcKoE7WTu35jyFkA+oDQmmkt
	 WLUZSRUkFJPcZG+gqKXGzZ+U=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 6ACEA18D812;
	Tue,  1 Oct 2024 20:29:25 +0200 (CEST)
Message-ID: <95f347c1-4393-4a70-81ac-e339aa5d9bb6@ijzerbout.nl>
Date: Tue, 1 Oct 2024 20:29:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible out-of-bounds writing at kernel/bpf/verifier.c:19927
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>
References: <1058f400-50d8-4799-b5ed-149dba761966@ijzerbout.nl>
 <CAADnVQK7VfTZNPO4rDDdH0HaD9XEy4-CF7h65i_4oJeeEYwpww@mail.gmail.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <CAADnVQK7VfTZNPO4rDDdH0HaD9XEy4-CF7h65i_4oJeeEYwpww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 01-10-2024 om 03:21 schreef Alexei Starovoitov:
> On Mon, Sep 30, 2024 at 11:01 AM Kees Bakker <kees@ijzerbout.nl> wrote:
>> Hi,
>>
>> In the following commit you added a few lines to kernel/bpf/verifier.c
>>
>> commit 1f1e864b65554e33fe74e3377e58b12f4302f2eb
>> Author: Yonghong Song <yonghong.song@linux.dev>
>> Date:   Thu Jul 27 18:12:07 2023 -0700
>>
>>       bpf: Handle sign-extenstin ctx member accesses
>>
>>       Currently, if user accesses a ctx member with signed types,
>>       the compiler will generate an unsigned load followed by
>>       necessary left and right shifts.
>>
>>       With the introduction of sign-extension load, compiler may
>>       just emit a ldsx insn instead. Let us do a final movsx sign
>>       extension to the final unsigned ctx load result to
>>       satisfy original sign extension requirement.
>>
>>       Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>>       Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>       Link:
>> https://lore.kernel.org/r/20230728011207.3712528-1-yonghong.song@linux.dev
>>       Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ...
>>
>> +               if (mode == BPF_MEMSX)
>> +                       insn_buf[cnt++] = BPF_RAW_INSN(BPF_ALU64 |
>> BPF_MOV | BPF_X,
>> + insn->dst_reg, insn->dst_reg,
>> +                                                      size * 8, 0);
>>
>> However, you forgot to check for array out-of-bounds check. In the if
>> statement
>> right above it, it is possible that insn_buf is filled up to the max.
> I don't think it's possible.
> There is no need for such a check.
Why do you think it is not possible? Isn't it better to be safe than sorry?
>
> Next time pls cc bpf@vger right away.
>
>> I've attached a patch which will catch that situation. I've used the
>> same error
>> message from earlier in the code.
>>
>> Please consider adding my patch.
>> --
>> Kees Bakker



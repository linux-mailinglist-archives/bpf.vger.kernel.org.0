Return-Path: <bpf+bounces-27250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E88AB545
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8BC1C2181D
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33013B5BE;
	Fri, 19 Apr 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akeL0E3X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5B22071;
	Fri, 19 Apr 2024 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552756; cv=none; b=ID8eiULdu1zgAW1tudj2YOgTfuTLI7GiGTJpccsW2fevaZWecxKgPzGNwwXstsla+L02QuhET5CC9yFXsUXeDM+Huj6EqZ7MpKT02+1jfoOvARNp7c9+ePeEXUmY6pdGGx8K548JrZJsmrLC9LnZ2YiyORSG8aDoBsRdQyqUIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552756; c=relaxed/simple;
	bh=rdVZSny6BIgCS3vGo8EaqhW6D/kyD4McSwc8Nifxnd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nOVnwnsmiySHnFiR9xG5vxUKwuwmMwEpY8Y0xD6jxZfCa1hjC8RbMBzWyWnS0H2QL/afeTJn4IelO/hC2Uv/OfJ8xVJij6WexUZDSBEuGesUVIP8PgklsXnirdLF4/IV/itYm5zI4KzNXfUfFMtYGpDtGUcBcZAh74H9bxjl0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akeL0E3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B00C072AA;
	Fri, 19 Apr 2024 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713552755;
	bh=rdVZSny6BIgCS3vGo8EaqhW6D/kyD4McSwc8Nifxnd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=akeL0E3X9MKdKb+NkeF9gFpoDwSm//+rx16chpD3E/IS0lg7e/DFyQwF7g3koWXgY
	 ea5+YLs3SiTjgyBkLUsAV4PD92t7ITrGIrCkF1KX5rp0pQnpMqpDVjb95RRQOha0DN
	 Kds9i+BNWrkRJ7gkLxnq19/EhsP6uiTjBDpGijaZ2ZL3LADYooJIq8bkwDD3RfE75m
	 wHmksuPbEMqD1egfznJJ2vicDv7B+B6sDxH3+F2EjPG3UA3qmbModEKHqNblCnXf5F
	 /0CfdCM3DIar2gHArNU0zkKg5KAh0/ld6pmX1SsGiKXjuh3M5npmuoLmeBUOufu64l
	 DHjKDFXW+FUZw==
From: Puranjay Mohan <puranjay@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] arm32, bpf: Fix sign-extension mov instruction
In-Reply-To: <ZhVhh3bDTQ+sks6b@shell.armlinux.org.uk>
References: <20240409095038.26356-1-puranjay@kernel.org>
 <ZhVhh3bDTQ+sks6b@shell.armlinux.org.uk>
Date: Fri, 19 Apr 2024 18:52:31 +0000
Message-ID: <mb61pcyqldw28.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> On Tue, Apr 09, 2024 at 09:50:38AM +0000, Puranjay Mohan wrote:
>> The current implementation of the mov instruction with sign extension
>> clobbers the source register because it sign extends the source and then
>> moves it to the destination.
>> 
>> Fix this by moving the src to a temporary register before doing the sign
>> extension only if src is not an emulated register (on the scratch stack).
>> 
>> Also fix the emit_a32_movsx_r64() to put the register back on scratch
>> stack if that register is emulated on stack.
>
> It would be good to include in the commit message an example or two of
> the resulting assembly code so that it's clear what the expected
> generation is. Instead, I'm going to have to work it out myself, but
> I'm quite sure this is information you already have.
>
>> Fixes: fc832653fa0d ("arm32, bpf: add support for sign-extension mov instruction")
>> Reported-by: syzbot+186522670e6722692d86@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/000000000000e9a8d80615163f2a@google.com/
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  arch/arm/net/bpf_jit_32.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
>> index 1d672457d02f..8fde6ab66cb4 100644
>> --- a/arch/arm/net/bpf_jit_32.c
>> +++ b/arch/arm/net/bpf_jit_32.c
>> @@ -878,6 +878,13 @@ static inline void emit_a32_mov_r(const s8 dst, const s8 src, const u8 off,
>>  
>>  	rt = arm_bpf_get_reg32(src, tmp[0], ctx);
>>  	if (off && off != 32) {
>> +		/* If rt is not a stacked register, move it to tmp, so it doesn't get clobbered by
>> +		 * the shift operations.
>> +		 */
>> +		if (rt == src) {
>> +			emit(ARM_MOV_R(tmp[0], rt), ctx);
>> +			rt = tmp[0];
>> +		}
>
> This change is adding inefficiency, don't we want to have the JIT
> creating as efficient code as possible within the bounds of
> reasonableness?
>
>>  		emit(ARM_LSL_I(rt, rt, 32 - off), ctx);
>>  		emit(ARM_ASR_I(rt, rt, 32 - off), ctx);
>
> LSL and ASR can very easily take a different source register to the
> destination register. All this needs to be is:
>
> 		emit(ARM_LSL_I(tmp[0], rt, 32 - off), ctx);
> 		emit(ARM_ASR_I(tmp[0], tmp[0], 32 - off), ctx);
> 		rt = tmp[0];
>
> This will generate:
>
> 		lsl	tmp[0], src, #32-off
> 		asr	tmp[0], tmp[0], #32-off
>
> and then the store to the output register will occur.
>
> What about the high-32 bits of the register pair - should that be
> taking any value?
>
>>  	}
>
> I notice in passing that the comments are out of sync with the
> code - please update the comments along with code changes.
>
>> @@ -919,15 +926,15 @@ static inline void emit_a32_movsx_r64(const bool is64, const u8 off, const s8 ds
>>  	const s8 *tmp = bpf2a32[TMP_REG_1];
>>  	const s8 *rt;
>>  
>> -	rt = arm_bpf_get_reg64(dst, tmp, ctx);
>> -
>>  	emit_a32_mov_r(dst_lo, src_lo, off, ctx);
>>  	if (!is64) {
>>  		if (!ctx->prog->aux->verifier_zext)
>>  			/* Zero out high 4 bytes */
>>  			emit_a32_mov_i(dst_hi, 0, ctx);
>>  	} else {
>> +		rt = arm_bpf_get_reg64(dst, tmp, ctx);
>>  		emit(ARM_ASR_I(rt[0], rt[1], 31), ctx);
>> +		arm_bpf_put_reg64(dst, rt, ctx);
>>  	}
>>  }
>
> Why oh why oh why are we emitting code to read the source register
> (which may be a load), then write it to the destination (which may
> be a store) to only then immediately reload from the destination
> to then do the sign extension? This is madness.
>
> Please... apply some thought to the code generation from the JIT...
> or I will remove you from being a maintainer of this code. I spent
> time crafting some parts of the JIT to generate efficient code and
> I'm seeing that a lot of that work is now being thrown away by
> someone who seemingly doesn't care about generating "good" code.
>

Sorry for this, I also like to make sure the JITs are as efficient as
possible. I was too focused on fixing this as fast as possible and
didn't pay attention that day.

I have reimplemented the whole thing again to make sure all bugs are
fixed. The commit message has the generated assembly for all cases:

https://lore.kernel.org/all/20240419182832.27707-1-puranjay@kernel.org/

Thanks,
Puranjay


Return-Path: <bpf+bounces-30039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A94B8CA31F
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22450281C6F
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9EB137C26;
	Mon, 20 May 2024 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b5URUcBG"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8126AC1
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235718; cv=none; b=nZcMcMMCWVnDb3GbXIZy9PdDmYzSTYkiFZY4zF/zFUcCC6XW3uSPFVpQwqBSsJQ2XhQiPuDJQk5L9PJ4FLALmws+jxVXYDcqsdgIlX+Uw1E/GTius1FfxyX7cPFU+ohCCBPA1bb5waE0jWAwoPuVALgynSBlcvvlcVPj9ZWXnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235718; c=relaxed/simple;
	bh=NYU4wxvMw3J2NV5GYQYXnJlutURjZhbLjEaQ8FTtjjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxGDEWo9Wq+I7kbcrJ7WxEmJkNMOc890EgPVLhe6icSCF/i7kLBsIIJuVw/Ysx1364XzH6aPJckgQjCCAvhQsKnIYT9CrKo9u8XRwztpFfnaBUdbYt9S8/ixiefg1yjVOVMidRCmMFIs+VVLN2oubq3mxakRTJTxbfpPfUnXjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5URUcBG; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dthaler1968@googlemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716235713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA6XH729d4apsCX8A+BcKu8efDxZnu41fyBNQ5jOQL0=;
	b=b5URUcBGGCGn8j8ShZDG5QEQ1fkAFNBzaUdOiLglULJs3AaEaCIUF0MHObMeL1BcCyM82S
	yCjkmoUKbfTTOrJfkwiXqGXQw36bPCplVHXKME0b9IAX7OABq6jJcjPbiNig64t9AGpHET
	rS8XCBZlb1B7xZRb2BIGUxqrpoRksM0=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: bpf@ietf.org
X-Envelope-To: dthaler1968@gmail.com
Message-ID: <3f5949c8-6dcc-4348-9cda-4813c5e2455b@linux.dev>
Date: Mon, 20 May 2024 13:08:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, docs: clarify sign extension of 64-bit use
 of 32-bit imm
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240517161612.4385-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240517161612.4385-1-dthaler1968@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/17/24 10:16 AM, Dave Thaler wrote:
> imm is defined as a 32-bit signed integer.
>
> {MOV, K, ALU64} says it does "dst = src" (where src is 'imm') but it does
> not sign extend, but instead does dst = (u32)src.  The "Jump instructions"

I am not sure about this. In kernel/bpf/core.c, we have
         ALU64_MOV_K:
                 DST = IMM;
                 CONT;
here DST is u64 and IMM is s32. IIUC, IMM needs to extend to s64 and then
convert to u64.

> section has "unsigned" by some instructions, but the "Arithmetic instructions"
> section has no such note about the MOV instruction, so added an example to
> make this more clear.
>
> {JLE, K, JMP} says it does "PC += offset if dst <= src" (where src is 'imm',
> and the comparison is unsigned). This was apparently ambiguous to some
> readers as to whether the comparison was "dst <= (u64)(u32)imm" or
> "dst <= (u64)(s64)imm", since the correct assumption would be the latter
> except that the MOV instruction doesn't follow that, so added an example
> to make this more clear.
>
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
> ---
>   .../bpf/standardization/instruction-set.rst       | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index 997560aba..f96ebb169 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -378,13 +378,22 @@ etc. This specification requires that signed modulo use truncated division
>   
>      a % n = a - n * trunc(a / n)
>   
> -The ``MOVSX`` instruction does a move operation with sign extension.
> +The ``MOV`` instruction does a move operation without sign extension, whereas
> +the ``MOVSX`` instruction does a move operation with sign extension.
>   ``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
>   32-bit operands, and zeroes the remaining upper 32 bits.
>   ``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
>   operands into 64-bit operands.  Unlike other arithmetic instructions,
>   ``MOVSX`` is only defined for register source operands (``X``).
>   
> +``{MOV, K, ALU}`` means::
> +
> +  dst = (u32) imm
> +
> +``{MOVSX, X, ALU}`` with 'offset' 32 means::
> +
> +  dst = (s32) src

For {MOVSX, X, ALU}, offset 32 is not supported. The correct offset value
is 8 and 16. For example for offset 8, we have dst = (u32)(s8)src.

> +
>   The ``NEG`` instruction is only defined when the source bit is clear
>   (``K``).
>   
> @@ -486,6 +495,10 @@ Example:
>   
>   where 's>=' indicates a signed '>=' comparison.
>   
> +``{JLE, K, JMP}`` means::
> +
> +  if dst <= (u64)(s64)imm goto +offset
> +
>   ``{JA, K, JMP32}`` means::
>   
>     gotol +imm


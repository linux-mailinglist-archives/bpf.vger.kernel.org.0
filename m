Return-Path: <bpf+bounces-19623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9982F502
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C139FB219B4
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD61CFAD;
	Tue, 16 Jan 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SLtCwHeh"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8F1BF29
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432032; cv=none; b=r+jYoRMEU9RvXXvi1gg5oPLYRADo4E1hPeYvaIClrBHuNe42vLuk16R/Ijn31HIUg1Ql2gpnDilMHbPFXhVefoqyb0uNq7zXOJP1uPMQdOhA+JEKo7mAeYPYnBn1JML3XD+nFCA20SsNKrDJP68euC/UVhOCgX3vyWm1oUty+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432032; c=relaxed/simple;
	bh=3AtgXEpK8vQ5MESLMTOQ0M0Ay6IPoyFiW7poQSK/D/Q=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=GweTAlMLwdPNh54PYkcpXWBZJLh1LaWc8efJ5HjIyUiCuIPGxUlU2NE2qdM+F/E6oWjTjHwd4ldS4BNSYxf8V86odt9kt9msWKkVOv7fGfoqwJF1HjBtzkS3vgtxvGW3uRsHwaxDfJhkqGcH87s4G1331D1sZsMKZXLX2HNYhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SLtCwHeh; arc=none smtp.client-ip=95.215.58.178
Message-ID: <48a7a7db-978d-4e8c-8378-2851975a1ddb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705432029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5An8TEr7+MzYJFBAV3udGVA29e5419tQnu3uF9ukn0=;
	b=SLtCwHehlhHttj9QE4bNNHZQOLlpvOiRFpaIK2KBa86vb2e6+d/XjGBg1FAlgzzVf9m6pX
	cx7vVd+j1UL+xlVdawgAB3JSju/pelU3XHcuOr7UxAh9yfARO3JtWanf7ZC8U0YY0Vp7MM
	HLognb4TtG9kbvJU9vQayMdR6Zm3Ugo=
Date: Tue, 16 Jan 2024 11:07:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
 <87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com>
 <878r4vra87.fsf@oracle.com>
 <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
 <CAADnVQKGkPaCMyesJ=U469AOS5iJ=vmL20B7Ya7HFp8ouC3C5g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKGkPaCMyesJ=U469AOS5iJ=vmL20B7Ya7HFp8ouC3C5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/16/24 9:47 AM, Alexei Starovoitov wrote:
> On Mon, Jan 15, 2024 at 8:33 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> [0] Updated LLVM
>>      https://github.com/eddyz87/llvm-project/tree/bpf-inline-asm-polymorphic-r
> 1.
> // Use sequence 'wX = wX' if 32-bits ops are available.
> let Predicates = [BPFHasALU32] in {
>
> This is unnecessary conservative.
> wX = wX instructions existed from day one.
> The very first commit of the interpreter and the verifier recognized it.
> No need to gate it by BPFHasALU32.

Actually this is not true from llvm perspective.
wX = wX is available in bpf ISA from day one, but
wX register is only introduced in llvm in 2017
and at the same time alu32 is added to facilitate
its usage.

>
> 2.
> case 'w':
> if (Size == 32 && HasAlu32)
>
> This is probably unnecessary as well.
> When bpf programmer specifies 'w' constraint, llvm should probably use it
> regardless of alu32 flag.
>
> aarch64 has this comment:
>      case 'x':
>      case 'w':
>        // For now assume that the person knows what they're
>        // doing with the modifier.
>        return true;
>
> I'm reading it as the constraint is a final decision.
> Inline assembly shouldn't change with -mcpu flags.


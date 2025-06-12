Return-Path: <bpf+bounces-60514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01BAD7B0B
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AF5F7A6BC4
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550722D322C;
	Thu, 12 Jun 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sDVOrWfD"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B951F473A
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756568; cv=none; b=euF9jNJcL6BV5iW6ajOgMIVvYE3o4EbixYuFrJwH3zRQLGd1k5boiiYhn1SarJ02xQrfhnUybmFqarfWiDccwZc/o7ksqF08ph3HB1RAfOlZrWPnfVQN4bMaaeimrcGl/BOaL8LNkPBTQOc8zrHYDXKiyewfvnWFTQ5i9LELCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756568; c=relaxed/simple;
	bh=oeU240QVzlH0svp2P9zRa1DdZKVBOBRieBZU2Qumgvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oeom2612aHCin18WIQM5drSsG1n5dr1BctvpwxM+th2Y8x0a1KOq3dmUoHwAqircCMnrp0HQKdr2QYfcdYL+VpnAHKlOGiFIfhtXvBxo+u+KDh9uwX3+fFC/E2P5GYNODB8ymulpm91M30Mdapcd8flDcMygthxszRJEm3I0k/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sDVOrWfD; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cbc60943-783e-4444-9d46-3a25e71a6e63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749756564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhP3wGuJsBP62stq0GKHDdBbTFDXWBogGf/AgQk61cI=;
	b=sDVOrWfDYoZjJSBRu/Wu0YBxilAaduvRjVdiFK9N026K0AxF2peaTYlKxKKKglX9eeWlVC
	7X+fYhDor/GJ2zmFxF5kAS8iGHn9S/1LyxCvIMGqAYwh8LwyTa6QF9uOn+Ydmrolrjj1XE
	xW3rvI+nNaUPk/6vEDgu0MtICiJoO6U=
Date: Thu, 12 Jun 2025 12:29:20 -0700
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
 Eduard Zingerman <eddyz87@gmail.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
 <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
 <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/12/25 12:18 PM, Alexei Starovoitov wrote:
> On Thu, Jun 12, 2025 at 12:10 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Thu, 2025-06-12 at 10:19 -0700, Yonghong Song wrote:
>>> In one of upstream thread ([1]), there is a discussion about
>>> the below inline asm code:
>>>
>>>    if r1 == 0xdeadbeef goto +2;
>>>    ...
>>>
>>> In actual llvm backend, the above 0xdeadbeef will actually do
>>> sign extension to 64bit value and then compare to register r1.
>>>
>>> But the code itself does not imply the above semantics. It looks
>>> like the comparision is between r1 and 0xdeadbeef. For example,
>>> let us at a simple C code:
>>>    $ cat t1.c
>>>    int foo(long a) { return a == 0xdeadbeef ? 2 : 3; }
>>>    $ clang --target=bpf -O2 -c t1.c && llvm-objdump -d t1.o
>>>      ...
>>>      w0 = 0x2
>>>      r2 = 0xdeadbeef ll
>>>      if r1 == r2 goto +0x1
>>>      w0 = 0x3
>>>      exit
>>> It does try to compare r1 and 0xdeadbeef.
>>>
>>> To address the above confusing inline asm issue, llvm backend ([2])
>>> added some range checking for such insns and beyond. For the above
>>> insn asm, the warning like below
>>>    warning: immediate out of range, shall fit in int range
>>> will be issued. If -Werror is in the compilation flags, the
>>> error will be issued.
>>>
>>> To avoid the above warning/error, the afore-mentioned inline asm
>>> should be rewritten to
>>>
>>>    if r1 == -559038737 goto +2;
>>>    ...
>>>
>>> Fix a few selftest cases like the above based on insn range checking
>>> requirement in [2].
>>>
>>>    [1] https://lore.kernel.org/bpf/70affb12-327b-4882-bd1d-afda8b8c6f56@linux.dev/
>>>    [2] https://github.com/llvm/llvm-project/pull/142989
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>> Changes like 0xffffffff -> -1 and 0xfffffffe -> -2 look fine,
>> but changes like 0xffff1234 -> -60876 are an unnecessary obfuscation,
>> maybe we need to reconsider.
> I have to agree.
> I didn't expect there to be so many warnings.
> I thought it would be good to warn for
> r3 = 0xdeadbeef
>
> since r3 will have 0xffffFFFFdeadbeef value after assignment,
> but warn on
> r0 &= 0xFFFF1234
> and replacement with -60876 is taking the warning too far.

Agree this -60876 is bad.

>
> Also considering Jose's point.
>
> Warning in llvm/gcc on imm32 > UINT_MAX is not correct either.
> llvm should probably accept 0xffffFFFFdeadbeef as imm32.

In llvm, the value is represented as an int64, we probably
can just check the upper 32bit must be 0 or 0xffffFFFF.
Otherwise, the value is out of range.

> But that is a separate discussion.



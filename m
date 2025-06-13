Return-Path: <bpf+bounces-60564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C2AD80C6
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCF41891363
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C51DF268;
	Fri, 13 Jun 2025 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RH+W2vxV"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C672F4317
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 02:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780299; cv=none; b=X879MANSh6TeKZZaMMvjk2Xmf/vkKrJZbEpBolZU/dZHvO8kA+ZvTCo9mQuGhhKGvcV3l1sZ9XgFSD1NWXMQeHtpK7McmXGX2RVPNEM0arJ2YiU6YbGRJd/bA+TC0f08e8MICiPB/HPrpuqwZeazMOLLk8fwWwSYNnVum/tWcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780299; c=relaxed/simple;
	bh=b1NwGXziPuiEtzg8q4rgrEA2clxx8KG5yocHGOauRww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS68ez3ixfwXhV8X42X8SFtLEgyk3zT6VEctjR/EFLPDSOcbDnHU1UtNA6m8PukxZEFGIu3lDwm4quv+qiOpnQccGEWOTfIp3B8zT8S/FKwi94YKg5eBsYzCLfGrCEt4/7Sp5BkEO4uj/fvWQeQYdgecEs0UZbkFDUNHyd4xAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RH+W2vxV; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac5b07b0-97b5-4f51-84bd-343c19a00660@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749780293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=haQaEUxie13iosvitaSwvORL082+TwgVbxxuiIyz0D0=;
	b=RH+W2vxVTs+2gmEBXo4uFSGNTVXouqa87yqnlzH4EuXmhr7Msj//PANRppwNF1AkUtctZa
	aDuwAQiR5KnCDnB/6SekIiqErJBSDLXS69e15DIIwC83Ifso6lXeD/jksU/7dOC1CUyvnX
	hFyD5/jraePRBaxfMO72BJN933IgGaE=
Date: Thu, 12 Jun 2025 19:04:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm
 codes
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
 <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
 <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
 <cbc60943-783e-4444-9d46-3a25e71a6e63@linux.dev>
 <b35717b7c65a0ee8baba9800dbbb2c9e58c62b32.camel@gmail.com>
 <CAADnVQKrrEFcUdUvagwSkrCLJSoud4Jv0=CM2rX7p5MYKYOC=Q@mail.gmail.com>
 <9665f3b3-1c8e-4dae-b8df-c3147b119ff2@linux.dev>
 <CAADnVQL+xOejJySjwuL3X0M_Ysurwcuf5zRJq5K4E9CVMcq8gg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL+xOejJySjwuL3X0M_Ysurwcuf5zRJq5K4E9CVMcq8gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/12/25 2:42 PM, Alexei Starovoitov wrote:
> On Thu, Jun 12, 2025 at 2:39 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 6/12/25 2:15 PM, Alexei Starovoitov wrote:
>>> On Thu, Jun 12, 2025 at 12:49 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>> On Thu, 2025-06-12 at 12:29 -0700, Yonghong Song wrote:
>>>>
>>>> [...]
>>>>
>>>>>> Warning in llvm/gcc on imm32 > UINT_MAX is not correct either.
>>>>>> llvm should probably accept 0xffffFFFFdeadbeef as imm32.
>>>>> In llvm, the value is represented as an int64, we probably
>>>>> can just check the upper 32bit must be 0 or 0xffffFFFF.
>>>>> Otherwise, the value is out of range.
>>>> I agree with Yonghong, supporting things like 0xffffFFFFdeadbeef and
>>>> rejecting things like 0x8000FFFFdeadbeef would require changes to the
>>>> assembly parser to behave differently for literals of length 8 (signe
>>>> extend them) and >8 (zero extend them), which might be surprising in
>>>> some other ways.
>>> Ok. So what's the summary?
>>> No selftest changes needed and we add a check to llvm
>>> to warn when upper 32 bits !=0 and != 0xffffFFFF ?
>> I did a little more checking, I think the value range
>> in [INT_MIN, UINT_MAX] is what we want. This is also my v1 of
>> llvm patch.
> and that's buggy because it will reject 0xffffFFFFdeadbeef
>
>> Support we have 64bit value, 0xffffFFFF00000001,
>> truncating the top 32bit, it becomes 1 and this value 1
>> won't be able to sign extension properly to 0xffffFFFF00000001.
> well, yeah, 0xfff.. case should match 31-bit, of course.

Right. Just uploaded a new llvm patch for this issue:
    https://github.com/llvm/llvm-project/pull/142989



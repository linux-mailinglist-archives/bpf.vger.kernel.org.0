Return-Path: <bpf+bounces-38912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D123F96C67E
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106771C22477
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081151DC051;
	Wed,  4 Sep 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f79Oawf7"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E187F9
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474735; cv=none; b=W+GQVD/DfV/tu0yZpatn2nYQHQvIChLlaySFLxbudJakmdHjSVgQ/BvKrOCCDlgg1Un1vBRyQyzIIjQ3SDJe7IIAyocNFDIlLNkNm2eMTzEzC5LzPUqedt5ehx20u+26RY30TcptBbG5X1Rcj1oV35Qlc5O+9FAHjYlsnNjaPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474735; c=relaxed/simple;
	bh=yuNjCFg6QY3nNk/dHMjjmAy4f2MMVkJPQcU4NfgJY0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmXoCsAGMYCO0sfO0AjaBQ1AinNjm/jgpg06Ow+IMbip37YB9WxAbSTo4fhsj2KkB73JqA+S3Er1tqHBJspNI7AMMi7zWDE1mIPUtVaNR+zUZH5sEB1rb7Xk8uJS2Ej6rCHm6dWxBSdSSIOutMMIViXC7GeNtET8uvbIXojv8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f79Oawf7; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a18f6bb9-2b9e-4f30-9cb4-20c326cf49b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725474732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8AOXrdwT/O/K3D9ppH06Q4ftwmV3k/sIys8nSkB+5M=;
	b=f79Oawf7mSqDPKJXIQr2RR8fuZlHrldHWHZ0OyffzynhqjFboL0zlwQWcZYl2uznK0ByOH
	q1A77qDC6d2TOkT/K8OyV9LJboEcZTOiaWnkPBNVdj0fLAUXNWHQqJgZGUhtf3e1Np+knJ
	AXU23NMyXQn2asHBoYHtmHBliZUq/Xw=
Date: Wed, 4 Sep 2024 11:32:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix a jit convergence issue
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240903225949.2066234-1-yonghong.song@linux.dev>
 <CAADnVQ+iqrfTgvPieBz8cTpdUdU94tTrFW88xttwthqmtx2Qwg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+iqrfTgvPieBz8cTpdUdU94tTrFW88xttwthqmtx2Qwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/4/24 9:56 AM, Alexei Starovoitov wrote:
> On Tue, Sep 3, 2024 at 4:00 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 074b41fafbe3..63c4816ed4e7 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -64,6 +64,57 @@ static bool is_imm8(int value)
>>          return value <= 127 && value >= -128;
>>   }
>>
>> +/*
>> + * Let us limit the positive offset to be <= 124.
> I think the comment will read better if the above says "<= 123",
> since that's the final outcome.
> 124 above is a bit confusing.
> I can tweak while applying if you agree.

Correct. Let us do "<= 123".

>
>> + * to mamximum 123 (0x7b). This way, the jit pass can eventually converge.
> Can fix this typo too.

Sounds good.

Since I need to change test in the second patch (enabling tests for arm64/s390),
let me send v3 to address all comments.



Return-Path: <bpf+bounces-52643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4BA46254
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367DF163AB8
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE122173F;
	Wed, 26 Feb 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtpdV7K+"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16222171D
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579477; cv=none; b=NAhoVQ5KibxvYS9wI6MakJtINFR2mYA2wFsVxuvyDa1SjtqiSIKRMKUkS0rOzvNW6GiW4RK7UqjM29vVB/NDanXxINNpFjS6pTYaWo8rNlaMYg4Tki5DdDYfFQPxb7T1x5Ro5lh5QkH4PrcEQoSun1teXYaVwRye32CGS+sepec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579477; c=relaxed/simple;
	bh=BYK9UW+feD1efK/vCwE6AnjY1kz3e0Th0tQQp7mSvNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNnRRjPYWWA7RXQpT+TAv5gEeVjgR4MJ1yIujsDjCm790n7h3EEvW1FqzQHqERXCnX9xcf0yZvyWRI3KWJl0fvr9PLJeo3V9Qcg+zsXh6FD1IcAqr/r/I4hlAoGDC6awIggJjZTLH31E8Ps/scCO/yUAiCX69hFyb8IT7YCoKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtpdV7K+; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <690b7c18-318a-46b8-aad5-7d4026cbf498@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740579473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSveXtiuXdVD7xB2WG3O6hevU2ck8ZGwxzk2IebnfSQ=;
	b=ZtpdV7K+DPveoxWXO8zcoI84BJxjZWYXIni1FU3sLwWPXirmx7Tmgy1BlaOY07xaTV+x3K
	fwgBw2L8i+MfsrjJ57m8QTBZJrbxAvDE3SsJjO6iRCkRgM1q6xPediGQQla4FEv583F/Hh
	e7lA9bMtCDYCIP2D9sGtN4qf4xlO+Kc=
Date: Wed, 26 Feb 2025 22:17:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Manjusaka <me@manjusaka.me>,
 kernel-patches-bot@fb.com
References: <20250224153352.64689-1-leon.hwang@linux.dev>
 <20250224153352.64689-3-leon.hwang@linux.dev>
 <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
 <CAEf4BzaE+sRmnPMN_ePQ1sa7wHuRNn9zktu85Z5=BRyyVEXM=A@mail.gmail.com>
 <f6a428a0-9016-4c38-b03f-f47504d08826@linux.dev>
 <CAEf4BzYQuX_+sz+0jsD_YHdoH7S4ROja28nhQH4ixzDcyW94PA@mail.gmail.com>
 <CAADnVQKf7k-qW2Bccka_vHEeC4C9b=SbcCOCe-ZDPskW8Gd6Dw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKf7k-qW2Bccka_vHEeC4C9b=SbcCOCe-ZDPskW8Gd6Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/2/26 11:17, Alexei Starovoitov wrote:
> On Tue, Feb 25, 2025 at 9:19 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>>> But, how can we achieve it?
>>
>> There is no *elegant* way to do this, but I think we could retrofit
>> this as extra common bpf_attrs into existing bpf() syscall. Something
>> along the lines of:
>>
>> struct bpf_common_attr {
>>     __u64 log_buf;
>>     __u32 log_size;
> 
> other than missing log_level I like this approach.
> 
>> }
>>
>> #define BPF_COMMON_ATTRS 0x80000000
> 
> negative enum/int is a bit meh, can we use 64 instead?
> In token we have:
> BUILD_BUG_ON(__MAX_BPF_CMD >= 64);
> and delegate_cmds mount option too.
> 
> Currently __MAX_BPF_CMD = 37
> so we have some room.
> BPF_COMMON_ATTRS (1 << 16) is fine too.
> Just not the sign bit.
> 

Let me try this approach with BPF_COMMON_ATTRS (1 << 16).

Thanks,
Leon



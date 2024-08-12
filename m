Return-Path: <bpf+bounces-36942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A894F7CF
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3D1B21FBF
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A91922D8;
	Mon, 12 Aug 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GV6AaXJe"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD32F2C
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492949; cv=none; b=sAjMNBgxC4bqMWlQik6S/gBEXfsgJpPCDfuTdpnZLmbZe1I09EucWbRoOAJihfH9APA+rrCelxoE8sFBOl5RJsMnKcRTFVeN66XOCqJbqL3eXgTb7EeDwJkUrEpDey8UF2RM3SAfZPnAcifkQr1V/aJbsAYhI7SqJh2RqkEgQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492949; c=relaxed/simple;
	bh=Lu7oke4JMOx9p59bax+0MoJ+1cDrXFg1MgZVoBFDwp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uO9kPX/ELZebta3O8WUj8FagardBv9cCLEMfmDrJHPYVryfZW5OrvxAr2VrfSc4ZF8YLoIBFZ4URJck2wmU8tDLMDOmzbynR5yyFsf+WtXo0K03y3K+T6Ue3NoPkwQerhJR7l1V3iqusEtzeJiCyzgYjhH7T88Rcbo9DAhLAOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GV6AaXJe; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <666340c4-daed-4a92-a7eb-b6063b13c345@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723492944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSgcQIqEtKdgt9tdJLsK6yPNQDKT5zjj0tA6VZIHgqk=;
	b=GV6AaXJeMFlYXfP2W6/8kW8wCyOOuSb/5bh5jhcQfsWoYN0DT5SRlgo4a6eyR3HMxQ9lqy
	cqPc/dXaWXSUppVTiL9glMYYW4fHOYqqbddzCOsRgvQ17hRJPew4yH9uCpHTbHa48gsDT3
	2f6H/6cGO46MniWGNOHKnE7uOq7hxYw=
Date: Mon, 12 Aug 2024 13:02:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
 <551847ff89db0df953c455761e746a0d80d3a968.camel@gmail.com>
 <CAADnVQJ2hFpT7ZxU8O36NB0YOq-ze96KJ0T=K3Wp1-qZU+0jBw@mail.gmail.com>
 <e1700911e1d36c40b471c4ec1b229eee50490949.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e1700911e1d36c40b471c4ec1b229eee50490949.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/12/24 12:43 PM, Eduard Zingerman wrote:
> On Mon, 2024-08-12 at 12:29 -0700, Alexei Starovoitov wrote:
>
> [...]
>
>>> It does not seem correct to swap the order for these two checks:
>>>
>>>                  if (exact != NOT_EXACT && i < cur->allocated_stack &&
>>>                      old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
>>>                      cur->stack[spi].slot_type[i % BPF_REG_SIZE])
>>>                          return false;
>>>
>>>                  if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
>>>                      && exact == NOT_EXACT) {
>>>                          i += BPF_REG_SIZE - 1;
>>>                          /* explored state didn't use this */
>>>                          continue;
>>>                  }
>>>
>>> if we do, 'slot_type' won't be checked for 'cur' when 'old' register is not marked live.
>> I see. This is to compare states in open coded iter loops when liveness
>> is not propagated yet, right?
> Yes
>
>> Then when comparing for exact states we should probably do:
>> if (exact != NOT_EXACT &&
>>      (i >= cur->allocated_stack ||
>>       old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
>>       cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
>>     return false;
>>
>> ?
> Hm, right, otherwise the old slots in the interval
> [cur->allocated_stack..old->allocated_stack)
> won't be checked using exact rules.

Okay, for *exact* stack slot_type comparison. Will make the change
and send v2 soon.



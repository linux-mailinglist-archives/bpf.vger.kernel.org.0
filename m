Return-Path: <bpf+bounces-61255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FEAE3397
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 04:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021417A6B95
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 02:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427D19E7D0;
	Mon, 23 Jun 2025 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sl30Inp7"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07720183CA6
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750645981; cv=none; b=fnjwXSoT/iSBk1p1wrur4THGdCMM73Rh1UdgVmOrA0WPoZcjHlM1PVekmQw31xwEhZll2MlpKrK3k1pwfK4rG/XV6vL5mbUcGSiCXtwi+wA4wvLLkrAadCK1zhyzwXh3wDiz9qkNYH8RtPvUbNgvA+HCgeZXx8lMlkCEK+2p4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750645981; c=relaxed/simple;
	bh=8hluwjVTmXXog4aTRxgoRd/tz2EcAslNixaPAR1dtNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mymI3B132YKZMm5ZuN+HZVQwkbkiZeABGqJZ2syUbQQSIEgmvcj5cCEQLWpVL4gj9v04fQTFJ2FOl9BM8/pk6SNoJH2SsXnoudjkII8IsGYFP01gHEeGxGmxlZRBf1YiLJKOYO7bVGGW116fgDgzVnB4yfeVRYNFqEMFC+Ts8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sl30Inp7; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2656172-091a-435b-a197-6472ca9a038a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750645968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voS/IXxDZSgvXt/HTZvb06bjDBsLY8G70iK7t5CzXcc=;
	b=sl30Inp7L/uRJ9KlWfg7mh20YwAu/RTNbG+JqwALSU3CmnMZgQP4CJaIZcn9BdGjhz6dn0
	0TCN/xTkJNH1YjvfJHIKGd1ChZV6jrNs1v2+IKrc4aSuY+GhejGCRtf2HG1fWJCHUgR4Fl
	9afyH2U6vEpvvI63s7aftIqRAeawro8=
Date: Mon, 23 Jun 2025 10:32:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20250619034257.70520-1-chen.dylane@linux.dev>
 <20250619034257.70520-2-chen.dylane@linux.dev>
 <CAADnVQLyAeo9ztPoJzU1QJUQf6SMptVNoOzZza02xPuXO1ES2g@mail.gmail.com>
 <9eedd830-9222-4ac0-8ccd-72499fb85b13@linux.dev>
 <CAADnVQJcdVCKPu8aPPj5hZExNTFYAYTd5xkF=Ljfm__+ugirGg@mail.gmail.com>
 <77b09f48-01d9-46f1-8a31-a1824c0eef8d@linux.dev>
 <CAADnVQ+SgYop50-1S7424ecRKWDM3R=8cHeizRCjeC_FXdkdLA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQ+SgYop50-1S7424ecRKWDM3R=8cHeizRCjeC_FXdkdLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/21 02:25, Alexei Starovoitov 写道:
> On Thu, Jun 19, 2025 at 8:31 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> 在 2025/6/20 10:59, Alexei Starovoitov 写道:
>>> On Thu, Jun 19, 2025 at 7:46 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>
>>>> 在 2025/6/20 01:17, Alexei Starovoitov 写道:
>>>>> On Wed, Jun 18, 2025 at 8:44 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>>>
>>>>>> Show kprobe_multi link info with fdinfo, the info as follows:
>>>>>>
>>>>>> link_type:      kprobe_multi
>>>>>> link_id:        1
>>>>>> prog_tag:       a15b7646cb7f3322
>>>>>> prog_id:        21
>>>>>> type:   kprobe_multi
>>>>>
>>>>> ..
>>>>>
>>>>>> +       seq_printf(seq,
>>>>>> +                  "type:\t%s\n"
>>>>>> +                  "kprobe_cnt:\t%u\n"
>>>>>> +                  "missed:\t%lu\n",
>>>>>> +                  kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
>>>>>> +                                        "kprobe_multi",
>>>>>
>>>>> why print the same info twice ?
>>>>> seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
>>>>> in bpf_link_show_fdinfo() already did it in a cleaner way.
>>>>>
>>>>
>>>> link_type only shows 'kprobe_multi', maybe we can show the format like:
>>>
>>> Ohh. Especially so. It would be wrong and confusing to display:
>>> link_type:      kprobe_multi
>>> type: kretprobe_multi
>>>
>>> Let's fix 'link_type' to display it properly.
>>
>> What do you think show like this:
>>
>>       link_type:      kprobe_multi
>>       link_id:        1
>>       prog_tag:       33be53a4fd673e1d
>>       prog_id:        21
>>       retprobe:       false
> 
> It leaks implementation details.
> For the kernel the link type is BPF_LINK_TYPE_KPROBE_MULTI for retprobe too,
> but show_fdinfo is for humans.
> 'link_type:' field can be more precise and differentiate
> what's effectively a subtype of the link.

Well, i will fix it in v5. Thanks.

-- 
Best Regards
Tao Chen


Return-Path: <bpf+bounces-44053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE499BD264
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5421C22622
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223DE1D6190;
	Tue,  5 Nov 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jeS2YHnZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09915DBB3
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824406; cv=none; b=l7I5x9Opb7e42woOONmqVSrca1jmJ7Yy8dLvywPadjwCGoyJ62kyuatjve7N4UACkhUuKPmA8x+v2OUA/lwWF3QbnwI1SwEuKgG94By5/lQnOWXsaU4w9YE1OiBpnFzJ+BUOm/v1OEK2jG7dQpXJ7K/Y4GFqQOpXXLUeiQBU6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824406; c=relaxed/simple;
	bh=+7Peqb5YWseDEkigRfa7wwqM/x2X4fk2REuNpPZyC0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5XAHMkz2SMMXs/kUFpGgLGH26emLwwO7TSExzQty4bW+NY794jTnNVHVfFW9j1BfBwjy/D0W+w2RRAOHqxrYmUCrw5kpEWVVLHzsyGZaJxlFnyZ2JlTSTFVrAQDWkSJ0w7qKs4FYmgZMDRmbFd+PIXuo1KrVzQYJmj6bzwObvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jeS2YHnZ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <43dc0d7d-ca6e-4ba1-a831-e2a1e43f6311@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730824403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qh70Angxv6P42eXAzDtoFyUntBGIhmcqR5D7QxYBQ58=;
	b=jeS2YHnZusS5LDqBB0fhHEXKXRHkU8Qujtns1vzVbZ2jtOfR1IdWCd7MVMQJZ1K0lpaiAQ
	wSHkYG2ZjJZDplAO5jEOrn0wGCBo8KSiEUt5ZPdGz2mBS+FmSO9yIalvvuz8RQeXqLFixd
	sQQadCQUcuOfnjCNTrRat9VyzvfIL1s=
Date: Tue, 5 Nov 2024 08:33:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev>
 <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
 <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev>
 <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
 <6c78f973-341e-4260-aed4-a5cb8e873acc@linux.dev>
 <29e2658c-02c9-4ef1-a633-ee5017e72bc3@linux.dev>
 <CAADnVQL54BFUpzAWx-4B6_UFyHp4O88=+x8zeWJupiyjNarRfg@mail.gmail.com>
 <97ea8f52-96c3-4109-92b7-cf2631a34e2d@linux.dev>
 <CAADnVQK-AXqxEhDwWK=RKx-dA0PZ=N1j6vSshBWS4bGNfv=a7g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQK-AXqxEhDwWK=RKx-dA0PZ=N1j6vSshBWS4bGNfv=a7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/5/24 7:50 AM, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 10:02 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> I also don't understand the point of this patch 2.
>>> The patch 3 can still do:
>>>
>>> + switch (prog->type) {
>>> + case BPF_PROG_TYPE_KPROBE:
>>> + case BPF_PROG_TYPE_TRACEPOINT:
>>> + case BPF_PROG_TYPE_PERF_EVENT:
>>> + case BPF_PROG_TYPE_RAW_TRACEPOINT:
>>> +   return PRIV_STACK_ADAPTIVE;
>>> + default:
>>> +   break;
>>> + }
>>> +
>>> + if (!bpf_prog_check_recur(prog))
>>> +   return NO_PRIV_STACK;
>>>
>>> which would mean that iter, lsm, struct_ops will not be allowed
>>> to use priv stack.
>> One example is e.g. a TC prog. Since bpf_prog_check_recur(prog)
>> will return true (means supporting recursion), and private stack
>> does not really support TC prog, the logic will become more
>> complicated.
>>
>> I am totally okay with removing patch 2 and go back to my
>> previous approach to explicitly list prog types supporting
>> private stack.
> The point of reusing bpf_prog_check_recur() is that we don't
> need to duplicate the logic.
> We can still do something like:
> switch (prog->type) {
>   case BPF_PROG_TYPE_KPROBE:
>   case BPF_PROG_TYPE_TRACEPOINT:
>   case BPF_PROG_TYPE_PERF_EVENT:
>   case BPF_PROG_TYPE_RAW_TRACEPOINT:
>      return PRIV_STACK_ADAPTIVE;
>   case BPF_PROG_TYPE_TRACING:
>   case BPF_PROG_TYPE_LSM:
>   case BPF_PROG_TYPE_STRUCT_OPS:
>      if (bpf_prog_check_recur())
>        return PRIV_STACK_ADAPTIVE;
>      /* fallthrough */
>    default:
>      return NO_PRIV_STACK;
> }

Right. Listing trampoline related prog types explicitly
and using bpf_prog_check_recur() will be safe.

One thing is for BPF_PROG_TYPE_STRUCT_OPS, PRIV_STACK_ALWAYS
will be returned. I will make adjustment like

switch (prog->type) {
  case BPF_PROG_TYPE_KPROBE:
  case BPF_PROG_TYPE_TRACEPOINT:
  case BPF_PROG_TYPE_PERF_EVENT:
  case BPF_PROG_TYPE_RAW_TRACEPOINT:
     return PRIV_STACK_ADAPTIVE;
  case BPF_PROG_TYPE_TRACING:
  case BPF_PROG_TYPE_LSM:
  case BPF_PROG_TYPE_STRUCT_OPS:
     if (bpf_prog_check_recur()) {
       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
           return PRIV_STACK_ALWAYS;
       else
           return PRIV_STACK_ADAPTIVE;
     }
     /* fallthrough */
   default:
     return NO_PRIV_STACK;
}



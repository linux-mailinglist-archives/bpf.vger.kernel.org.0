Return-Path: <bpf+bounces-19201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA2827806
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 20:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819A2B2266D
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501854FB3;
	Mon,  8 Jan 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mHH4UGRk"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65354F91
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07d7d6e0-d090-47e6-9f17-0b083aeaa7af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704740369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4U2UGpknTeT4qu0rjO4URBaeASTEbyKxvTVb4BRdoxY=;
	b=mHH4UGRkMpNt/7SK++2d+OdQKuAGsiHl7WnB2Yk71YD9Y8T/ST3sE5vDG4wueL751xrQD5
	b3O1cqBzNo83K4eFgmqccKhqvncK0UksrihcuSs1dL3iRjIjyg2AhXTivDg3SuitMM96/3
	CAT2iFANwLFOtQKE0NV+nsLzeNe32Ek=
Date: Mon, 8 Jan 2024 10:59:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
 <ddc70b06-9fde-412f-88c0-3097e967dc6a@linux.dev>
 <5e31a6835b648fae9880f6bfbc40801539b2d143.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5e31a6835b648fae9880f6bfbc40801539b2d143.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/5/24 3:37 PM, Eduard Zingerman wrote:
> On Thu, 2024-01-04 at 23:14 -0800, Yonghong Song wrote:
> [...]
>> There is an alternative implementation in check_stack_write_var_off().
>> For a spill of value/reg 0, we can convert it to STACK_ZERO instead
>> of trying to maintain STACK_SPILL. If we convert it to STACK_ZERO,
>> then we can reuse the rest of logic in check_stack_write_var_off()
>> and at the end we have
>>
>>           if (zero_used) {
>>                   /* backtracking doesn't work for STACK_ZERO yet. */
>>                   err = mark_chain_precision(env, value_regno);
>>                   if (err)
>>                           return err;
>>           }
>>
>> although I do not fully understand the above either. Need to go back to
>> git history to find why.
> Regarding this particular code (unrelated to this the patch-set).
>
> Both check_stack_read_fixed_off() and check_stack_read_var_off()
> set destination register to zero if all bytes at varying offset are STACK_ZERO.
> Backtracking can handle fixed offset writes, but does not know how to
> handle varying offset writes. E.g. if:
> - there is some code 'arr[i] = r0';
> - and r0 happens to be zero for some state;
> - later arr[i] is used in precise context;
> Verifier would have no means to propagate precision mark to r0.
> Hence apply precision mark conservatively.
>
> Does that makes sense?

Thanks for explanation. I guess I understand now, it does make sense.
let us say arr array's element type is long (8 byte) and the range of i could be
from -32 to -1. I guess one way could be doing backtracking with "... = arr[i]"
is to have four ranges, [-32, -24), [-24, -16), [-16, -8), [-8, 0).
Later, when we see arr[i] = r0 and i has range [-32, 0). Since it covers [-32, -24), etc.,
precision marking can proceed with 'r0'. But I guess this can potentially
increase verifier backtracking states a lot and is not scalable. Conservatively
doing precision marking with 'r0' (in arr[i] = r0) is a better idea.

Andrii has similar comments in
   https://lore.kernel.org/bpf/CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com/



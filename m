Return-Path: <bpf+bounces-42743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5209A9773
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 06:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E450B224F1
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001AA83CDB;
	Tue, 22 Oct 2024 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZqVTbUOV"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0F7E59A
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570121; cv=none; b=FWX3vT1g8XO5hPJMdPel5CMrfu3u1ngFMywk6rqUtvhXXToxHoc8IxYwEoY9onqsEK1VrfulBSaeT1iUBlS54x5T0E6i3wiVLT3GSD7FHUVASD6GQxY2HorFfaAKae3iYfI/cEXVcC7N0bNk0bbbadaFwcWRuq8vsIJvKM8jyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570121; c=relaxed/simple;
	bh=FO6SFU4mWlNJ7byxBqoGkMrjaCsrOOLRBfvZGs5PCI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPgAYiU3HryuOlefUf5JepIWls8wEqdtnftrdiMzGkU3gfQcCd+vYssf5oGs2o14KBIhGTw8vgyduoboibMlxDSZkwVTwBQMLCTMI4hQfrSvrjWTEV8mAkuYJsIYqtH7Q8J6FimTXmAeMQC5Epje7F5X/li65g9uFC8M0GB/8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZqVTbUOV; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91687126-f44e-46ae-baa5-0050d93fa56e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729570116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iW9wd/+AhGbrvMzXzcbgDgc5p9eOAq3dOGfXkUaqNeo=;
	b=ZqVTbUOVTmej8mMLi/K6FJjco5bWJvUmyMZyhIahTQ7Mpw20CLoay9jIfMX1ZokVkBK1Wd
	vwkgntZdNUfPCA/eM6Rf+dj1neLdODbno2MbiuyYKT+C2SSRJW8MxoIu8FQROXxwb194sz
	ahBJPto7LKeaNKGd9lNAb610k+Z8ysE=
Date: Mon, 21 Oct 2024 21:08:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191347.2105090-1-yonghong.song@linux.dev>
 <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
 <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev>
 <CAADnVQJCfiNEgrvf6GuaUadz6rDSNU6QB3grpOfk2-jQP6is4Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJCfiNEgrvf6GuaUadz6rDSNU6QB3grpOfk2-jQP6is4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/21/24 8:43 PM, Alexei Starovoitov wrote:
> On Mon, Oct 21, 2024 at 8:21 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>           for (int i = 0; i < env->subprog_cnt; i++) {
>>>> -               if (!i || si[i].is_async_cb) {
>>>> -                       ret = check_max_stack_depth_subprog(env, i);
>>>> +               check_subprog = !i || (check_priv_stack ? si[i].is_cb : si[i].is_async_cb);
>>> why?
>>> This looks very suspicious.
>> This is to simplify jit. For example,
>>      main_prog   <=== main_prog_priv_stack_ptr
>>        subprog1  <=== there is a helper which has a callback_fn
>>                  <=== for example bpf_for_each_map_elem
>>
>>          callback_fn
>>            subprog2
>>
>> In callback_fn, we cannot simplify do
>>      r9 += stack_size_for_callback_fn
>> since r9 may have been clobbered between subprog1 and callback_fn.
>> That is why currently I allocate private_stack separately for callback_fn.
>>
>> Alternatively we could do
>>      callback_fn_priv_stack_ptr = main_prog_priv_stack_ptr + off
>> where off equals to (stack size tree main_prog+subprog1).
>> I can do this approach too with a little more information in prog->aux.
>> WDYT?
> I see. I think we're overcomplicating the verifier just to
> be able to do 'r9 += stack' in the subprog.
> The cases of async vs sync and directly vs kfunc/helper
> (and soon with inlining of kfuncs) are getting too hard
> to reason about.
>
> I think we need to go back to the earlier approach
> where every subprog had its own private stack and was
> setting up r9 = my_priv_stack in the prologue.

Indeed, per private_stack per prog(subprog) will be much
simpler.

>
> I suspect it's possible to construct a convoluted subprog
> that calls itself a limited amount of time and the verifier allows that.
> I feel it will be easier to detect just that condition
> in the verifier and fallback to the normal stack.

Yes, I think check_max_stack_depth_subprog() should be able to detect 
subprog recursion.



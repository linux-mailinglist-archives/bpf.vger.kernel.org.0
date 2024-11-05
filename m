Return-Path: <bpf+bounces-43995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFAE9BC3A1
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 04:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D3CB224CE
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FEE139CFF;
	Tue,  5 Nov 2024 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VxZB/Vxu"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24184E18
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776170; cv=none; b=srkdCOAIvWiv8TkzE6MRBPymZrtA2Qjds2eidu/WV4zapLsI6oagXs3Jv2bJ0BDRjI47WTh6ucfLrCWuy416Mf7aK8Cbgje4YwgUT3ShQeRqrUUF423XuUGtU0sMNe6OFurYWI70uzk6TOPxGIBzz42ckjHZ6UhSJ5Er0iSom7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776170; c=relaxed/simple;
	bh=413vjIAK35rg8qPi4ruEjYuOZYFg1xogBU2QFcxkcsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjXYyDsUBwyloWsd4whoBJxnzr/cOVqqEsSwOC2uCfJ39aSXyAhX8JRYYuQ0rvopBT51HuiBkVhW9Qzxu3kowez17f2Uqsx5MITg7VWha4lrcRKAkb4US76W1vIq7PQSqtBcqaJo1SGWofJx6nybW6g7gE5IkolleXr7wq7caWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VxZB/Vxu; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea1f6dd2-380e-43fd-96b4-b0e189e5d016@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730776164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdJ5B6edGG29XfWXFLe8I19iE8TwPAmnHczY4SEhvMg=;
	b=VxZB/VxuZn8awaZpzTPkUfSZKyQZBLCX8nARCFw74e3EjZn91DApucyl7tmZ7rTF8XfJ4z
	nT5nKxRQ1KC4ngRNuVOhFJUVXHW8miP8Vb1wB0le1XzbDSncN8ppgw1VXE2u18NP3ZGV7T
	Au2mmhN25X5bv3DDirzUtV8UXWRWl0M=
Date: Mon, 4 Nov 2024 19:09:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 03/10] bpf: Allow private stack to have each
 subprog having stack size of 512 bytes
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193510.3243093-1-yonghong.song@linux.dev>
 <CAADnVQK-dCC68pPbrt2DLY5022V64Kget7xyShHqRoK+c5ZTiw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQK-dCC68pPbrt2DLY5022V64Kget7xyShHqRoK+c5ZTiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/4/24 6:47 PM, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 11:35 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> @@ -6070,11 +6105,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>                          depth);
>>                  return -EACCES;
>>          }
>> -       depth += round_up_stack_depth(env, subprog[idx].stack_depth);
>> +       subprog_depth = round_up_stack_depth(env, subprog[idx].stack_depth);
>> +       depth += subprog_depth;
>>          if (depth > MAX_BPF_STACK && !*subtree_depth) {
>>                  *subtree_depth = depth;
>>                  *depth_frame = frame + 1;
>>          }
>> +       if (priv_stack_supported != NO_PRIV_STACK) {
>> +               if (!subprog[idx].use_priv_stack) {
>> +                       if (subprog_depth > MAX_BPF_STACK) {
>> +                               verbose(env, "stack size of subprog %d is %d. Too large\n",
>> +                                       idx, subprog_depth);
>> +                               return -EACCES;
>> +                       }
>> +                       if (subprog_depth >= BPF_PRIV_STACK_MIN_SIZE)
>> +                               subprog[idx].use_priv_stack = true;
>> +               }
>> +       }
> Hold on. If I'm reading this correctly this adaptive priv stack
> concept will make some subprogs with stack >= 64 to use priv_stack
> while other subprogs will still use normal stack?
> Same for the main prog. It may or may not use priv stack ?
>
> I guess this is ok-ish, but needs to be clearly explained in comments
> and commit log.

Will do.

> My first reaction to such adaptive concept was negative, since
> such "random" mix of priv stack in some subprogs makes
> the whole thing pretty hard to reason about it,
> but I guess it's valid to use normal stack when stack usage
> is small. No need to penalize every subprog.
>
> I wonder what others think about it.

Ya, other opinions are very welcome!

>
> Also it would be cleaner to rewrite above as:
> if (subprog_depth > MAX_BPF_STACK) {
>     verbose();
>     return -EACCESS;
> }
> if (priv_stack_supported == PRIV_STACK_ADAPTIVE &&
>      subprog_depth >= BPF_PRIV_STACK_MIN_SIZE)
>     subprog[idx].use_priv_stack = true;
>
> less indent and easier to read.

Okay, will do with less indent.



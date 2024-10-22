Return-Path: <bpf+bounces-42821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82AB9AB784
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67FE1C235A8
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6DC1CBE94;
	Tue, 22 Oct 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUvtQNI1"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CFF1A0BE0
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628029; cv=none; b=PQKJtchObdzArtZu0zeUmcc0e/d1qEA6VRQAFBeaDsM+en/vzbSJHYRCl5Zn16DuTzSiiTzp3QWEi5OKNA1tze5XeLAb44hJEVr7uvok08hFwPrh7lFB0dH+xKNCE/q7Rv4mkNiPQH0L0JhydtMzwhbWTo4xFZ9G8JjiZ1V7z+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628029; c=relaxed/simple;
	bh=BTkbxbkGCG9YlmXlj8jYcp5RbAjWcH/5gqTJQ2Z0Ycw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qO4ZHaVYXK5WwOutYXKxwOuiSsXHDE0Y64lM7qeSuTbhdZtxpAy3gJhnGgYPuDpiKKX+5mo0MQzHvsjgAJdwd8BChmSkfqwMoE3RdGZusbl848Xfhq7L2Ag9V1L35r5fL18q1jcCoMIZ9i6OL8Lm+IHbXtwsD21+GmqRGzsEcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nUvtQNI1; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <179d5f87-4c70-438b-9809-cc05dffc13de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729628024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfOLrm4eXALruk4SKS+0Ol88/zfKz9dH45/eNI+2GgQ=;
	b=nUvtQNI1O+nu5W52SHNXkTliSULC7q9QMKNWpJRDvjKiUiJS5DuWiQ1kxomZQophC/bifj
	fhCaKMszIWdOdGiG6eyu5ZE5KO2YNdxSJdij/kvvxbEWOmvtus+IRz4BDnNOc4LCEwG/fW
	3UVHc3i7P4/429e6o0MXWQebtxJeZe4=
Date: Tue, 22 Oct 2024 13:13:38 -0700
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
>
> I suspect it's possible to construct a convoluted subprog
> that calls itself a limited amount of time and the verifier allows that.
> I feel it will be easier to detect just that condition
> in the verifier and fallback to the normal stack.

I tried a simple bpf prog below.

$ cat private_stack_subprog_recur.c
// SPDX-License-Identifier: GPL-2.0

#include <vmlinux.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include "../bpf_testmod/bpf_testmod.h"

char _license[] SEC("license") = "GPL";

#if defined(__TARGET_ARCH_x86)
bool skip __attribute((__section__(".data"))) = false;
#else
bool skip = true;
#endif

int i;

__noinline static void subprog1(int level)
{
         if (level > 0) {
                 subprog1(level >> 1);
                 i++;
         }
}

SEC("kprobe")
int prog1(void)
{
         subprog1(1);
         return 0;
}

In the above prog, we have a recursion of subprog1. The
callchain is:
    prog -> subprog1 -> subprog1

The insn-level verification is successful since argument
of subprog1() has precise value.

But eventually, verification failed with the following message:
   the call stack of 8 frames is too deep !

The error message is
                 if (frame >= MAX_CALL_FRAMES) {
                         verbose(env, "the call stack of %d frames is too deep !\n",
                                 frame);
                         return -E2BIG;
                 }
in function check_max_stack_depth_subprog().
Basically in function check_max_stack_depth_subprog(), tracing subprog
call is done only based on call insn. All conditionals are ignored.
In the above example, check_max_stack_depth_subprog() will have the
call graph like
     prog -> subprog1 -> subprog1 -> subprog1 -> subprog1 -> ...
and eventually hit the error.

Basically with check_max_stack_depth_subprog() self recursion is not
possible for a bpf prog.

This limitation is back to year 2017.
   commit 70a87ffea8ac  bpf: fix maximum stack depth tracking logic

So I assume people really do not write progs with self recursion inside
the main prog (including subprogs).



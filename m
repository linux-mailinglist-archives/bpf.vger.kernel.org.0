Return-Path: <bpf+bounces-43858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251509BA9AD
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 01:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D0F1C209A4
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 00:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743510F1;
	Mon,  4 Nov 2024 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BEs+yw8H"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4717C
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730678897; cv=none; b=A3UpAwcRwpw71EhV3uRAER4unpgIOK/799KlwNE/lxjKLOKE9qhNcYpZ7WCvxaK5BUAsmbHe5qbsBW1Eg8oggK3Wyr63YOlIF+QLh49VDP8B6d3Fc7TuU776tJ44SjTioZw3wd8c0UVWRKTXgAF4Vbg9AKO4NhBah6DzVELUS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730678897; c=relaxed/simple;
	bh=yckfSV/Tb5Ir2FEOSlPBkwPdmgiNa/Yr9qdPgkfJXAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgm75kx2AmknTglQjFZ6bFYDcroK3Obm6nAiOXnX3XPYSSncU16yNrdOeAZEytObR7MwlV0QUwdaTHJpASlEnWnmwI/FaY6HbtBvO0ONrefgq3LImpTqez9KkuiJn76y1lH6GHVKt3BtfpoIq0kJxUjTqbrESBaOT9Zmln2tIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BEs+yw8H; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <caa1ae27-ffd6-4888-ad0c-121191609238@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730678891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/0qDfaEuSUV1aWvB2vaz6q2KY2A0FCjBzwU/YTt2GI=;
	b=BEs+yw8HqvvFaZ7WxvrXH3QG3JnFDjr2QBevQfRs6lAbmkOz88YR1yEErLcr2247eAYyDX
	IOg0ooPl67CbxIW90t4ii/U/IsKqwwQcvCTw1XuCvweZZfAIGIPNiuekc5R3L6QC9x2kE3
	h129r39ZLyBunb0G+yuZnnmQi7RFgDI=
Date: Sun, 3 Nov 2024 16:08:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 3/9] bpf: Check potential private stack
 recursion for progs with async callback
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241101030950.2677215-1-yonghong.song@linux.dev>
 <20241101031006.2678685-1-yonghong.song@linux.dev>
 <CAADnVQ+r2zxVmXOwQHPZjTjRS1FhUycnMufKf1KvrhxH40REtg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+r2zxVmXOwQHPZjTjRS1FhUycnMufKf1KvrhxH40REtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/1/24 12:55 PM, Alexei Starovoitov wrote:
> On Thu, Oct 31, 2024 at 8:12 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> In previous patch, tracing progs are enabled for private stack since
>> recursion checking ensures there exists no nested same bpf prog run on
>> the same cpu.
>>
>> But it is still possible for nested bpf subprog run on the same cpu
>> if the same subprog is called in both main prog and async callback,
>> or in different async callbacks. For example,
>>    main_prog
>>     bpf_timer_set_callback(timer, timer_cb);
>>     call sub1
>>    sub1
>>     ...
>>    time_cb
>>     call sub1
>>
>> In the above case, nested subprog run for sub1 is possible with one in
>> process context and the other in softirq context. If this is the case,
>> the verifier will disable private stack for this bpf prog.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 46 ++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d3f4cbab97bc..596afd29f088 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6070,7 +6070,8 @@ static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
>>    */
>>   static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>                                           int *subtree_depth, int *depth_frame,
>> -                                        int priv_stack_supported)
>> +                                        int priv_stack_supported,
>> +                                        char *subprog_visited)
>>   {
>>          struct bpf_subprog_info *subprog = env->subprog_info;
>>          struct bpf_insn *insn = env->prog->insnsi;
>> @@ -6120,8 +6121,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>                                          idx, subprog_depth);
>>                                  return -EACCES;
>>                          }
>> -                       if (subprog_depth >= BPF_PRIV_STACK_MIN_SIZE)
>> +                       if (subprog_depth >= BPF_PRIV_STACK_MIN_SIZE) {
>>                                  subprog[idx].use_priv_stack = true;
>> +                               subprog_visited[idx] = 1;
>> +                       }
>> +               } else {
>> +                       subprog_visited[idx] = 1;
>>                  }
>>          }
>>   continue_func:
>> @@ -6222,19 +6227,42 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>   static int check_max_stack_depth(struct bpf_verifier_env *env)
>>   {
>>          struct bpf_subprog_info *si = env->subprog_info;
>> +       char *subprogs1 = NULL, *subprogs2 = NULL;
>>          int ret, subtree_depth = 0, depth_frame;
>> +       int orig_priv_stack_supported;
>>          int priv_stack_supported;
>>
>>          priv_stack_supported = bpf_enable_priv_stack(env);
>>          if (priv_stack_supported < 0)
>>                  return priv_stack_supported;
>>
>> +       orig_priv_stack_supported = priv_stack_supported;
>> +       if (orig_priv_stack_supported != NO_PRIV_STACK) {
>> +               subprogs1 = kvmalloc(env->subprog_cnt * 2, __GFP_ZERO);
> Just __GFP_ZERO ?!
>
> Overall the algo is messy. Pls think of a cleaner way of checking.
> Add two bool flags to bpf_subprog_info:
> visited_with_priv_stack
> visited_without_priv_stack

Actually this is what I thought initially as well with two bool flags
in bpf_subprog_info. Later on, I think since these two bool flags are
used ONLY in this function, probably not worthwhile to add them to
the head file.

But since you suggest this, I can go to two bool flag approach.

> and after walking all subrpogs add another loop over subprogs
> that checks for exclusivity of these flags?
>
> Probably other algos are possible.
>
>> +               if (!subprogs1)
>> +                       priv_stack_supported = NO_PRIV_STACK;
>> +               else
>> +                       subprogs2 = subprogs1 + env->subprog_cnt;
>> +       }
>> +
>>          for (int i = 0; i < env->subprog_cnt; i++) {
[...]


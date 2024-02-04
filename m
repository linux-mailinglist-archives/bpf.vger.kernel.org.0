Return-Path: <bpf+bounces-21185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9148491F0
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 00:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652E91F21BEC
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11916BE5D;
	Sun,  4 Feb 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mvum6iXl"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012EC10A13
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090961; cv=none; b=h/eD12OEoNnD9d49vXKvFgkGxLmNs1E4VI0yGJnwxIqTfUn4kQA/Dh7xw8qbAFcZ/aBGJfyxgJrR48kBxKco7CvZDQ6gLVu+rph7WIdY1Y3ryiBUgFywlwV56+UVas9/6gDPBpQWaug4uhB0Krva9TKsJS7ujJDQrgoQ7tUZsqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090961; c=relaxed/simple;
	bh=bx+yzkoiDRfkO1GSwdFBVxJH7+SX44JZV0tcPTU5r0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZl7iEduk8+ArK6hcuF4EnR8JPtef4lm2E+adNmcWx5nlzkB/tvjG8Mk1XwRvQcM/Iv1w0B87BYhK9o98tXl/dJ4d4MhWUOy/ueBFijUwf2QLl1FEuCxV4NlV4FtXjpL+nfUiuaQLZaXI0J8ncgAir/EP5z7Cq+I6ANJl2/ttCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mvum6iXl; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd7f19f9-71b7-427d-8a5c-92b349dd9abb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707090956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeaRFdSTi2buYi/NOWBm0kjI9D9PhKXSGbCvV8a81zs=;
	b=Mvum6iXl7LZpllMMtcSBjkDZDDCumgcjAF55dPK6gLA7FTow9/aYX0e2nTAhPtZOuEeZI4
	PBlFXiwRhUTeExfZ6bE/XpcgFD5rbHsSZ+XgrRxmiuf4H9bJuhnq38VNXqjIagvUuaFltU
	gTCWNNeN7pLkZHVvEcrR2oc0bijTHP0=
Date: Sun, 4 Feb 2024 15:55:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow calling static subprogs while
 holding a bpf_spin_lock
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Barret Rhoden <brho@google.com>,
 Tejun Heo <tj@kernel.org>
References: <20240204120206.796412-1-memxor@gmail.com>
 <20240204120206.796412-2-memxor@gmail.com>
 <20240204213313.GB120243@maniforge>
 <CAP01T75Qq8DN=A0uxF4F5hNm6igLRLnGWQFXst=DAO95Lrzsvg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP01T75Qq8DN=A0uxF4F5hNm6igLRLnGWQFXst=DAO95Lrzsvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/4/24 2:10 PM, Kumar Kartikeya Dwivedi wrote:
> On Sun, 4 Feb 2024 at 22:33, David Vernet <void@manifault.com> wrote:
>> On Sun, Feb 04, 2024 at 12:02:05PM +0000, Kumar Kartikeya Dwivedi wrote:
>>> Currently, calling any helpers, kfuncs, or subprogs except the graph
>>> data structure (lists, rbtrees) API kfuncs while holding a bpf_spin_lock
>>> is not allowed. One of the original motivations of this decision was to
>>> force the BPF programmer's hand into keeping the bpf_spin_lock critical
>>> section small, and to ensure the execution time of the program does not
>>> increase due to lock waiting times. In addition to this, some of the
>>> helpers and kfuncs may be unsafe to call while holding a bpf_spin_lock.
>>>
>>> However, when it comes to subprog calls, atleast for static subprogs,
>>> the verifier is able to explore their instructions during verification.
>>> Therefore, it is similar in effect to having the same code inlined into
>>> the critical section. Hence, not allowing static subprog calls in the
>>> bpf_spin_lock critical section is mostly an annoyance that needs to be
>>> worked around, without providing any tangible benefit.
>>>
>>> Unlike static subprog calls, global subprog calls are not safe to permit
>>> within the critical section, as the verifier does not explore them
>>> during verification, therefore whether the same lock will be taken
>>> again, or unlocked, cannot be ascertained.
>>>
>>> Therefore, allow calling static subprogs within a bpf_spin_lock critical
>>> section, and only reject it in case the subprog linkage is global.
>>>
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Looks good, thanks for this improvement. I had the same suggestion as
>> Yonghong in [0], and also left a question below.
>>
>> [0]: https://lore.kernel.org/all/2e008ab1-44b8-4d1b-a86d-1f347d7630e6@linux.dev/
>>
>> Acked-by: David Vernet <void@manifault.com>
>>
>>> ---
>>>   kernel/bpf/verifier.c                                  | 10 +++++++---
>>>   tools/testing/selftests/bpf/progs/verifier_spin_lock.c |  2 +-
>>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 64fa188d00ad..f858c959753b 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -9493,6 +9493,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>        if (subprog_is_global(env, subprog)) {
>>>                const char *sub_name = subprog_name(env, subprog);
>>>
>>> +             /* Only global subprogs cannot be called with a lock held. */
>>> +             if (env->cur_state->active_lock.ptr) {
>>> +                     verbose(env, "function calls are not allowed while holding a lock\n");
>>> +                     return -EINVAL;
>>> +             }
>>> +
>>>                if (err) {
>>>                        verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
>>>                                subprog, sub_name);
>>> @@ -17644,7 +17650,6 @@ static int do_check(struct bpf_verifier_env *env)
>>>
>>>                                if (env->cur_state->active_lock.ptr) {
>>>                                        if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
>>> -                                         (insn->src_reg == BPF_PSEUDO_CALL) ||
>>>                                            (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>>>                                             (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
>>>                                                verbose(env, "function calls are not allowed while holding a lock\n");
>>> @@ -17692,8 +17697,7 @@ static int do_check(struct bpf_verifier_env *env)
>>>                                        return -EINVAL;
>>>                                }
>>>   process_bpf_exit_full:
>>> -                             if (env->cur_state->active_lock.ptr &&
>>> -                                 !in_rbtree_lock_required_cb(env)) {
>>> +                             if (env->cur_state->active_lock.ptr && !env->cur_state->curframe) {
>> Can we do the same thing here for the RCU check below? It seems like the
>> exact same issue, as we're already allowed to call subprogs from within
>> an RCU read region, but the verifier will get confused and think we
>> haven't unlocked by the time we return to the caller.
>>
>> Assuming that's the case, we can take care of it in a separate patch
>> set.
> Makes sense, I'll send a separate patch for the RCU fix.
> Thanks for the review.

The following is what I recommended as well in another thread:

https://lore.kernel.org/bpf/20240131145454.86990-1-laoar.shao@gmail.com/T/#mff17cd64eeb1e17bd0e3e046fb52efeef9c86c25

>


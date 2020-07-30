Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C05233999
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgG3UQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 16:16:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:40840 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgG3UQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 16:16:05 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k1Ey9-0001Mu-1e; Thu, 30 Jul 2020 22:16:01 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k1Ey8-000SV1-R2; Thu, 30 Jul 2020 22:16:00 +0200
Subject: Re: [PATCH v5 bpf-next 4/6] bpf, x64: rework pro/epilogue and
 tailcall handling in JIT
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        bjorn.topel@intel.com, magnus.karlsson@intel.com
References: <20200724173557.5764-1-maciej.fijalkowski@intel.com>
 <20200724173557.5764-5-maciej.fijalkowski@intel.com>
 <e0c1f8c5-cd73-48eb-7c92-fcf755319173@iogearbox.net>
 <20200729161044.GA2961@ranger.igk.intel.com>
 <20200729211005.GA2806@ranger.igk.intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f427a00f-eaf0-d5e0-8542-2f6bc90ba3ce@iogearbox.net>
Date:   Thu, 30 Jul 2020 22:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200729211005.GA2806@ranger.igk.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25889/Thu Jul 30 17:03:53 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/29/20 11:10 PM, Maciej Fijalkowski wrote:
> On Wed, Jul 29, 2020 at 06:10:44PM +0200, Maciej Fijalkowski wrote:
>> On Wed, Jul 29, 2020 at 12:07:52AM +0200, Daniel Borkmann wrote:
>>> On 7/24/20 7:35 PM, Maciej Fijalkowski wrote:
>>>> This commit serves two things:
>>>> 1) it optimizes BPF prologue/epilogue generation
>>>> 2) it makes possible to have tailcalls within BPF subprogram
>>>>
>>>> Both points are related to each other since without 1), 2) could not be
>>>> achieved.
>>>>
>>> [...]
>>>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>>>> index 6fe6491fa17a..e9d62a60134b 100644
>>>> --- a/kernel/bpf/arraymap.c
>>>> +++ b/kernel/bpf/arraymap.c
>>>> @@ -750,6 +750,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
>>>>    				    struct bpf_prog *old,
>>>>    				    struct bpf_prog *new)
>>>>    {
>>>> +	u8 *old_addr, *new_addr, *old_bypass_addr;
>>>>    	struct prog_poke_elem *elem;
>>>>    	struct bpf_array_aux *aux;
>>>> @@ -800,13 +801,47 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
>>>>    			if (poke->tail_call.map != map ||
>>>>    			    poke->tail_call.key != key)
>>>>    				continue;
>>>> +			/* protect against un-updated poke descriptors since
>>>> +			 * we could fill them from subprog and the same desc
>>>> +			 * is present on main's program poke tab
>>>> +			 */
>>>> +			if (!poke->tailcall_bypass || !poke->tailcall_target ||
>>>> +			    !poke->bypass_addr)
>>>> +				continue;
>>>
>>> Thinking more about this, this check here is not sufficient. You basically need this here
>>> given you copy all poke descs over to each of the subprogs in jit_subprogs(). So for those
>>> that weren't handled by the subprog have the above addresses as NULL. But in jit_subprogs()
>>> once we filled out the target addresses for the bpf-in-bpf calls we loop over each subprog
>>> and do the extra/final pass in the JIT to complete the images. However, nothing protects
>>> bpf_tail_call_direct_fixup() as far as I can see from patching at the NULL addr if there is
>>> a target program loaded in the map at the given key. That will most likely blow up and hit
>>> the BUG_ON().
>>
>> Okay, I agree with this reasoning but must admit that I don't understand
>> when exactly during fixup the target prog for a given key might be already
>> present? Could you shed some light on it? I recall that I was hitting
>> this case in test_verifier kselftest, so maybe I'll dig onto that, but
>> otherwise I didn't stumble upon this.

If the tail call map as first created and some programs attached to it, then you
would hit this in bpf_tail_call_direct_fixup() for the subprogs where not all poke
descs in the subprog's table belong to the actual prog.

>>> Instead of these above workarounds, did you try to go the path to only copy over the poke
>>> descs that are relevant for the individual subprog (but not all the others)?
>>
>> I was able to come up with something today, but I'd like to share it here
>> and discuss whether you think it's correct approach before rushing with
>> another revision.
>>
>> Generally in fixup_bpf_calls I store the index of tail call insn onto the
>> generated poke descriptor, then in jit_subprogs() I check whether the
>> given poke descriptor belongs to the current subprog by checking if that
>> previously stored absolute index of tail call insn is in the scope of the
>> insns of given subprog. Then the insn->imm needs to be updated with new
>> poke descriptor slot so that while JITing we will be able to grab the
>> proper poke desc - previously it worked because we emulated the main
>> prog's poke tab state onto each subprog.
>>
>> This way the subprogs actually get only relevant poke descs, but I have a

That sounds reasonable to me, yes, and the below code also looks good.

>> concern about the main prog's poke tab. Shouldn't we pull out the descs
>> that have been copied to the subprog out of the main poke tab?
>>
>> If yes, then shouldn't the poke tab be converted to a linked list?
> 
> Thinking a bit more about this, I think we can just untrack the main
> prog's aux struct from prog array map. If there are subprograms then the
> main prog is treated as subprog 0 and with the logic below every poke desc
> will be propagated properly.
> 
> I checked that doing:
> 
> 	for (i = 0; i < prog->aux->size_poke_tab; i++) {
> 		map_ptr = prog->aux->poke_tab[i].tail_call.map;
> 
> 		map_ptr->ops->map_poke_untrack(map_ptr, prog->aux);
> 	}
> 
> after the initial JIT subprogs loop works just fine and we can drop the
> cumbersome check from map_poke_run().
> 
> wdyt?

Yes, that is needed as well. Given we test on prog->aux for tracking, the subprogs
enries will get added in prog_array_map_poke_track() individually given their aux
pointer is different and untracking main progs aux then also works since it has no
effect on subprogs.

>> The patch that I will merge onto the 2/6 if you would say that we can live
>> with this approach, it's on top of this series:
>>
>>  From 57baac74647a4627fe85bb3393365de906070eb1 Mon Sep 17 00:00:00 2001
>> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Date: Wed, 29 Jul 2020 17:51:59 +0200
>> Subject: [PATCH] bpf: propagate only those poke descs that are used in subprog
>>
>> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> ---
>>   include/linux/bpf.h   |  1 +
>>   kernel/bpf/verifier.c | 11 ++++++++++-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 14b796bf35de..74ab8ec2f2d3 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -664,6 +664,7 @@ struct bpf_jit_poke_descriptor {
>>   	bool tailcall_target_stable;
>>   	u8 adj_off;
>>   	u16 reason;
>> +	u32 abs_insn_idx;

tiny nit: I think just calling insn_idx is sufficient.

>>   };
>>   
>>   /* reg_type info for ctx arguments */
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 3ea769555246..d6402dc05087 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -9971,15 +9971,23 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   		func[i]->aux->func_info = prog->aux->func_info;
>>   
>>   		for (j = 0; j < prog->aux->size_poke_tab; j++) {
>> +			u32 abs_insn_idx = prog->aux->poke_tab[j].abs_insn_idx;
>>   			int ret;
>>   
>> +			if (!(abs_insn_idx >= subprog_start &&
>> +			      abs_insn_idx <= subprog_end))
>> +				continue;
>> +
>>   			ret = bpf_jit_add_poke_descriptor(func[i],
>>   							  &prog->aux->poke_tab[j]);
>>   			if (ret < 0) {
>>   				verbose(env, "adding tail call poke descriptor failed\n");
>>   				goto out_free;
>>   			}
>> -			map_ptr = func[i]->aux->poke_tab[j].tail_call.map;
>> +
>> +			func[i]->insnsi[abs_insn_idx - subprog_start].imm = ret + 1;
>> +
>> +			map_ptr = func[i]->aux->poke_tab[ret].tail_call.map;
>>   			ret = map_ptr->ops->map_poke_track(map_ptr, func[i]->aux);
>>   			if (ret < 0) {
>>   				verbose(env, "tracking tail call prog failed\n");
>> @@ -10309,6 +10317,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
>>   					.reason = BPF_POKE_REASON_TAIL_CALL,
>>   					.tail_call.map = BPF_MAP_PTR(aux->map_ptr_state),
>>   					.tail_call.key = bpf_map_key_immediate(aux),
>> +					.abs_insn_idx = i,
>>   				};
>>   
>>   				ret = bpf_jit_add_poke_descriptor(prog, &desc);
>> -- 
>> 2.20.1

Lets ship it, thanks!
Daniel

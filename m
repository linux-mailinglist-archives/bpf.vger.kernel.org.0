Return-Path: <bpf+bounces-77889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90356CF5D33
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 23:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4ED43071A06
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 22:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE13126CD;
	Mon,  5 Jan 2026 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NUzh8Js3"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73892EC0A1
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651972; cv=none; b=mmTZ+1WeIk4MTZPzJKV/TN5vK1NINFQhZ0r4fC9Wch4bdZ2PdBQWNOijf2OuYTKMyLg9HoJi+ARCRQeF2h6C4c3R6TgsnoSfCRSY5tcFFoJAprowsNiykcTUAhXHBk7TAXDcmOyoj4vd+HpuIJBvSMfyDj1raxtbOzk6EWD5Sfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651972; c=relaxed/simple;
	bh=LIzuWDpET3y2Lfu6dFUlN8AXfJbsSK1Ewb0UHNuKyHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stORGEi8Ui7uN9XIpdW08uNlHTym6fSObjQnMFkiBA9t91PGI2Ig1gE+Lqobv2Yhbh+22lcNq7aSwnY1nzrrMXhpkW1kAVHh5Hf9j9jvmrR0c/wWwMgyV5fqs+kl4d19ZHAN/YbJ6Bbq94vlxD7RGdbvww/U6m9b4ldrrDp0rLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NUzh8Js3; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767651968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLFg1xSsj8PExbeHYABEqcvfWLJihB0hQrXci5fD/sg=;
	b=NUzh8Js3Qj7lBWc2bx5YJU/XUanjhBeHSsQ03CGwDqU5hQzY/3QGDJglgWuxWGUq0ixS1L
	aFvcYo+gHzQVBGThdHMPiX3DMLuyzzxwwa/xVUPcPazUGZSdIStd/maXSLWgDnSal71fgs
	sZKw/WoIKcuRPoGJxQ//5ZFeiIBBBXE=
Date: Mon, 5 Jan 2026 14:25:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, kernel-team <kernel-team@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
 <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev>
 <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/5/26 1:47 PM, Alexei Starovoitov wrote:
> On Mon, Jan 5, 2026 at 12:55 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>>
>>
>> On 1/5/26 11:42 AM, Amery Hung wrote:
>>> On Mon, Jan 5, 2026 at 11:14 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Mon, Jan 5, 2026 at 4:15 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>>>>
>>>>>
>>>>> +__bpf_kfunc_start_defs();
>>>>> +
>>>>> +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
>>>>> +{
>>>>> +       struct sk_buff *skb = (typeof(skb))skb_;
>>>>> +       u8 *meta_end = skb_metadata_end(skb);
>>>>> +       u8 meta_len = skb_metadata_len(skb);
>>>>> +       u8 *meta;
>>>>> +       int gap;
>>>>> +
>>>>> +       gap = skb_mac_header(skb) - meta_end;
>>>>> +       if (!meta_len || !gap)
>>>>> +               return;
>>>>> +
>>>>> +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
>>>>> +               skb_metadata_clear(skb);
>>>>> +               return;
>>>>> +       }
>>>>> +
>>>>> +       meta = meta_end - meta_len;
>>>>> +       memmove(meta + gap, meta, meta_len);
>>>>> +       skb_shinfo(skb)->meta_end += gap;
>>>>> +
>>>>> +       bpf_compute_data_pointers(skb);
>>>>> +}
>>>>> +
>>>>> +__bpf_kfunc_end_defs();
>>>>> +
>>>>> +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
>>>>> +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
>>>>> +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
>>>>> +
>>>>> +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realign)
>>>>> +
>>>>>    static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
>>>>>                                  const struct bpf_prog *prog)
>>>>>    {
>>>>> -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
>>>>> -                                   TC_ACT_SHOT);
>>>>> +       struct bpf_insn *insn = insn_buf;
>>>>> +       int cnt;
>>>>> +
>>>>> +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
>>>>> +               /* Realign skb metadata for access through data_meta pointer.
>>>>> +                *
>>>>> +                * r6 = r1; // r6 will be "u64 *ctx"
>>>>> +                * r0 = bpf_skb_meta_realign(r1); // r0 is undefined
>>>>> +                * r1 = r6;
>>>>> +                */
>>>>> +               *insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>>>>> +               *insn++ = BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[0]);
>>>>> +               *insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
>>>>> +       }
>>>>
>>>> I see that we already did this hack with bpf_qdisc_init_prologue()
>>>> and bpf_qdisc_reset_destroy_epilogue().
>>>> Not sure why we went that route back then.
>>>>
>>>> imo much cleaner to do BPF_EMIT_CALL() and wrap
>>>> BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)
>>>>
>>>> BPF_CALL_x doesn't make it an uapi helper.
>>>> It's still a hidden kernel function,
>>>> while this kfunc stuff looks wrong, since kfunc isn't really hidden.
>>>>
>>>> I suspect progs can call this bpf_skb_meta_realign() explicitly,
>>>> just like they can call bpf_qdisc_init_prologue() ?
>>>>
>>>
>>> qdisc prologue and epilogue qdisc kfuncs should be hidden from users.
>>> The kfunc filter, bpf_qdisc_kfunc_filter(), determines what kfunc are
>>> actually exposed.
>>
>> Similar to Amery's comment, I recalled I tried the BPF_CALL_1 in the
>> qdisc but stopped at the "fn = env->ops->get_func_proto(insn->imm,
>> env->prog);" in do_misc_fixups(). Potentially it could add new enum ( >
>> __BPF_FUNC_MAX_ID) outside of the uapi and the user space tool should be
>> able to handle unknown helper also but we went with the kfunc+filter
>> approach without thinking too much about it.
> 
> hmm. BPF_EMIT_CALL() does:
> #define BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)
> .imm   = BPF_CALL_IMM(FUNC)
> 
> the imm shouldn't be going through validation anymore.
> none of the if (insn->imm == BPF_FUNC_...) in do_misc_fixups()
> will match, so I think I see the path where get_func_proto() is
> called.
> But how does it work then for all cases of BPF_EMIT_CALL?
> All of them happen after do_misc_fixups() ?

yeah, I think most (all?) of them (e.g. map_gen_lookup) happens in 
do_misc_fixups which then does "goto next_insn;" to skip the 
get_func_proto().

> 
> I guess we can mark such emitted call in insn_aux_data as finalized
> and get_func_proto() isn't needed.

It is a good idea.



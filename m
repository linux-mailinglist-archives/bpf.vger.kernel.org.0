Return-Path: <bpf+bounces-17774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C38125B7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 04:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C0B214E0
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1ED1376;
	Thu, 14 Dec 2023 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XzTBUYwA"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9AD0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:04:46 -0800 (PST)
Message-ID: <b0530d96-ab92-47e7-94e9-61b961a73557@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702523084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WI7Hj39M13g6UnuEBYTxkATXZahu74DIbxQI/ilU9do=;
	b=XzTBUYwAk8jstjc3/o2QzBvkp140+E+j6/1aPYwkNR9L6hR7ukqZjbMV0ZI2zUGPH3rYb1
	wzIHScKXe9a/1b7LX0kmbNK99gXMIIy6I9MHSiTPkeZle3eShUyDb9XmLWWXhNhAsuYlQ3
	v3HQ2LVSSL0r2heHWKZh+sliWVb0gvc=
Date: Wed, 13 Dec 2023 19:04:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Anton Protopopov <aspsk@isovalent.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@google.com>, bpf <bpf@vger.kernel.org>
References: <ZXNCB5sEendzNj6+@zh-lab-node-5>
 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
 <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
 <8e45c28fa0827be2b01a7cd36aa68750ceff69f5.camel@gmail.com>
 <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com>
 <ZXg1ApeYXi0g7WeM@zh-lab-node-5>
 <CAADnVQ+b3_5qzaR9pr6B23xDxCO10iz685tHfsakW3MnoVYMbg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+b3_5qzaR9pr6B23xDxCO10iz685tHfsakW3MnoVYMbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/13/23 6:15 PM, Alexei Starovoitov wrote:
> On Tue, Dec 12, 2023 at 2:28 AM Anton Protopopov <aspsk@isovalent.com> wrote:
>>
>> This seems to have a benefit that there is no back compatibility issue
>> (if we use r1, because r0/r11 will be rejected by old verifiers). We
>> can have
>>
>>      r1 = 64bit_const
>>      if r1 == r1 goto
>>
>> and
>>
>>      r1 = 64bit_const
>>      if r1 != r1 goto
>>
>> and translate it on prog load to new instruction as JUMP_OF_NOP and
>> NOP_OR_JUMP, correspondingly. On older kernels it will have the
>> default (key is off) behaviour.
> As Andrii pointed out any new insn either JA with extra bits
> or special meaning if rX == rX can be sanitized by libbpf
> into plain JA.
> There will be no backward compat issues.
>
>> Ok, from BPF arch perspective this can work with two bits (not for
>> practical purposes though, IMO, see my next e-mail).
> I read this email and I still don't understand why you need a 3rd bit.
>
>>> And the special map really doesn't fit.
>>> Whatever we do, let's keep text_poke-able insn logic separate
>>> from bookkeeping of addresses of those insns.
>>> I think a special prefixed section that is understood by libbpf
>>> (like what I proposed with "name.static_branch") will do fine.
>>> If it's not good enough we can add a "set" map type
>>> that will be a generic set of values.
>>> It can be a set of 8-byte addresses to keep locations of static_branches,
>>> but let's keep it generic.
>>> I think it's fine to add:
>>> __uint(type, BPF_MAP_TYPE_SET)
>>> and let libbpf populate it with addresses of insns,
>>> or address of variables, or other values
>>> when it prepares a program for loading.
>> What is the higher-level API in this case? The static_branch_set(branch,
>> bool on) is not enough because we want to distinguish between "normal"
>> and "inverse" branches (for unlikely/likely cases).
> What is "likely/unlikely cases" ?
> likely() is a hint to the compiler to order basic blocks in
> a certain way. There is no likely/unlikely bit in the binary code
> after compilation on x86 or other architectures.
>
> There used to be a special bit on sparc64 that would mean
> a default jmp|fallthrough action for a conditional jmp.
> But that was before sparc became out of order and gained proper
> branch predictor in HW.
>
>>   We can implement
>> this using something like this:
>>
>> static_key_set(key, bool new_value)
>> {
>>      /* true if we change key value */
>>      bool key_changed = key->old_value ^ new_value;
>>
>>      for_each_prog(prog, key)
>>          for_each_branch(branch, prog, key)
>>              static_branch_flip(prog, branch, key_changed)
>> }
>>
>> where static_branch_flip flips the second bit of SRC_REG.
> I don't understand why you keep bringing up 'flip' use case.
> The kernel doesn't have such an operation on static branches.
> Which makes me believe that it wasn't necessary.
> Why do we need one for the bpf static branch?
>
>> We need to
>> keep track of prog->branches and key->progs. How is this different
>> from what my patch implements?
> What I'm proposing is to have a generic map __uint(type, BPF_MAP_TYPE_SET)
> and by naming convention libbpf will populate it with addresses
> of JA_OR_NOP from all progs.
> In asm it could be:
> asm volatile ("r0 = %[set_A] ll; goto_or_nop ...");
> (and libbpf will remove ld_imm64 from the prog before loading.)
>
> or via
> asm volatile ("goto_or_nop ...; .pushsection set_A_name+suffix; .long");
> (and libbpf will copy from the special section into a set and remove
> special section).

This is one more alternative.

|asm volatile goto ("r0 = 0; \ static_key_loc_1: \ gotol_or_nop 
%l[label]; \ r2 = 2; \ r3 = 3; \ ":: : "r0", "r2", "r3" :label);|

User code can use libbpf API static_key_enable("|static_key_loc_1|")
to enable the above gotol_or_nop. static_key_disable("static_key_loc_1")
or static_key_enabled("static_key_loc_1") can be similary defined.

Inside the libbpf, it can look at ELF file, find label "static_key_loc_1",
and also find label's corresponding insn index and verify that
the insn with label "static_key_loc_1" must be a gotol_or_nop
or nop_or_gotol insn. Eventually libbpf can call a bpf syscall
e.g. sys_bpf(cmd=STATIC_KEY_ENABLE, prog_fd, insn_offset)
to actually change the "current" state to gotol or nop depending
on what ENABLE means.

For enable/disable static keys in the bpf program itself,
similary, bpf program can have bpf_static_key_enable("static_key_loc_1"),
the libbpf needs to change it to bpf_static_key_enable(insn_offset)
and kernel verifier should process it properly.

Slightly different from what Alexei proposed, but another approach
for consideration and discussion.

>
> It will be a libbpf convention and the kernel doesn't need
> to know about a special static branch map type or array of addresses
> in prog_load cmd.
> Only JA insn is relevant to the verifier and JITs.
>
> Ideally we don't need to introduce SET map type and
> libbpf wouldn't need to populate it.
> If we can make it work with an array of values that .pushsection + .long
> automatically populates and libbpf treats it as a normal global data array
> that would be ideal.
> Insn addresses from all progs will be in that array after loading.
> Sort of like ".kconfig" section that libbpf populates,
> but it's a normal array underneath.
>
>> If this is implemented in userspace, then how we prevent synchronous
>> updates of the key (and a relocation variant doesn't seem to work from
>> userspace)? Or is this a new kfunc? If yes, then how is it
>> executed,
> then user space can have small helper in libbpf that iterates
> over SET (or array) and
> calls sys_bpf(cmd=STATIC_BRANCH_ENABLE, one_value_from_set)
>
> Similar in the kernel. When bpf progs want to enable a key it does
> bpf_for_each(set) { // open coded iterator
>     bpf_static_branch_enable(addr); // kfunc call
> }


Return-Path: <bpf+bounces-17308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72580B1FD
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 05:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF0281162
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 04:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7321389;
	Sat,  9 Dec 2023 04:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QB9K0PZA"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFEE10D9
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 20:16:01 -0800 (PST)
Message-ID: <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702095359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4mWm4jjvNU/rXOEij3EsaxTs47CVNTndbWcwE88nEc=;
	b=QB9K0PZAOy8Dg4ZahcEVMmWs7qbr+7zH3wIK7e53gMbHri2NO1vMvHAXEedXyMBDQLlY8n
	DTwmmhAacaZRRHeCSULLdRbPTCEtasJ2BmLSAkds3/PbYsNb0HSfXq+LmSzlCGVrnTkBfH
	tm6ErW05SLHefi4cYSNuwW3LsMYTRCE=
Date: Fri, 8 Dec 2023 20:15:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@google.com>, bpf <bpf@vger.kernel.org>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
 <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5>
 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/8/23 8:05 PM, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 2:04 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> I feel like embedding some sort of ID inside the instruction is very..
>> unusual, shall we say?
> yeah. no magic numbers inside insns pls.
>
> I don't like JA_CFG name, since I read CFG as control flow graph,
> while you probably meant CFG as configurable.
> How about BPF_JA_OR_NOP ?
> Then in combination with BPF_JMP or BPF_JMP32 modifier
> the insn->off|imm will be used.
> 1st bit in src_reg can indicate the default action: nop or jmp.
> In asm it may look like asm("goto_or_nop +5")

How does the C source code looks like in order to generate
BPF_JA_OR_NOP insn? Any source examples?

>
>> 2. bpf_static_branch_{likely,unlikely}() macro accepts a reference to
>> one such special global variable and and instructs compiler to emit
>> relocation between static key variable and JMP_CFG instruction.
>>
>> Libbpf will properly update these relocations during static linking
>> and subprog rearrangement, just like we do it for map references
>> today.
> Right. libbpf has RELO_SUBPROG_ADDR.
> This new relo will be pretty much that.
> And we have proper C syntax for taking an address: &&label.
> The bpf_static_branch macro can use it.
> We wanted to add it for a long time to support proper
> switch() and jmp tables.
>
> I don't like IDs and new map type for this.
> The macro can have 'branch_name' as one of the arguments and
> it will populate addresses of insns into "name.static_branch" section.
>
>  From libbpf pov it will be yet another global section which
> is represented as a traditional bpf array of one element.
> No extra handling on the libbpf side.
>
> The question is how to represent the "address" of the insn.
> I think 4 byte prog_id + 4 byte insn_idx will do.
>
> Then bpf prog can pass such "address" into bpf_static_branch_enable/disable
> kfunc.
>
> The user space can iterate over 8 byte "addresses"
> in that 1 element array map and call BPF_STATIC_BRANCH_ENABLE/DISABLE
> syscall cmds.
> We can have a helper on libbpf side for that.
>
> I see no need to introduce a new map type just to reuse map_update_elem cmd.
>


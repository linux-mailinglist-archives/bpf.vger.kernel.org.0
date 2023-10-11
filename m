Return-Path: <bpf+bounces-11920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F747C5756
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E521C20F53
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0718AF8;
	Wed, 11 Oct 2023 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GMRqCZtF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE11D68F
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 14:50:13 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB090;
	Wed, 11 Oct 2023 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0aQhKrb4/+Xz4qVKIM0Ni2OXXGUwXMSHkhmb0dr/HI8=; b=GMRqCZtFYuT29eLIyGZ01UZv5c
	gP7ASRlMKnQPbIcRLKCnxfO/uZ+io0b+prSrCY9nJyXXsV+y3Yu5hGoLb6/Dp2ZcGuGOXLnCRrcVG
	7dHEWCyx3CPka+d6/IdN58HH4K32As7jX4Jjnp6DHvsS3b3d0t8iJg+X6iucx85PKDhwExnvuQpLr
	hHYUoJIUmijxEE+jo7ZZ7X1WG0XMFmG7O15xVeDp1bqSh1O5DDZxroAoihS4BaUYKATfH/KGb33am
	0H1LNM40etqqiwGGi/lo8GiZwFTwGG0uDU7W3eRoXI6pLD5j61l/CJ84ync02ff3JKHCZ0SXv5bux
	0+AATayg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qqaXC-000MiE-6e; Wed, 11 Oct 2023 16:50:02 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qqaXB-000KHF-6t; Wed, 11 Oct 2023 16:50:01 +0200
Subject: Re: [PATCH bpf-next] Detect jumping to reserved code during
 check_cfg()
To: Hao Sun <sunhao.th@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
 <6524f6f77b896_66abc2084d@john.notmuch>
 <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
 <CAEf4Bza2s=JwR8b6d_x+bj5Y7iZ+ZDOMOJRNwcXF1ATWzHCxcA@mail.gmail.com>
 <CACkBjsZiaXTANv=c5QE3OvcB=KUgdFuMY8O4ft4Q3h6dDNVarg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <79dd71a5-446d-9b05-7d37-40e49bbf04ae@iogearbox.net>
Date: Wed, 11 Oct 2023 16:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACkBjsZiaXTANv=c5QE3OvcB=KUgdFuMY8O4ft4Q3h6dDNVarg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27058/Wed Oct 11 09:39:37 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 8:46 AM, Hao Sun wrote:
> On Wed, Oct 11, 2023 at 4:42 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Tue, Oct 10, 2023 at 1:33 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> On 10/10/23 9:02 AM, John Fastabend wrote:
>>>> Hao Sun wrote:
>>>>> Currently, we don't check if the branch-taken of a jump is reserved code of
>>>>> ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifier
>>>>> gives the following log in such case:
>>>>>
>>>>> func#0 @0
>>>>> 0: R1=ctx(off=0,imm=0) R10=fp0
>>>>> 0: (18) r4 = 0xffff888103436000       ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
>>>>> 2: (18) r1 = 0x1d                     ; R1_w=29
>>>>> 4: (55) if r4 != 0x0 goto pc+4        ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
>>>>> 5: (1c) w1 -= w1                      ; R1_w=0
>>>>> 6: (18) r5 = 0x32                     ; R5_w=50
>>>>> 8: (56) if w5 != 0xfffffff4 goto pc-2
>>>>> mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
>>>>> mark_precise: frame0: regs=r5 stack= before 6: (18) r5 = 0x32
>>>>> 7: R5_w=50
>>>>> 7: BUG_ld_00
>>>>> invalid BPF_LD_IMM insn
>>>>>
>>>>> Here the verifier rejects the program because it thinks insn at 7 is an
>>>>> invalid BPF_LD_IMM, but such a error log is not accurate since the issue
>>>>> is jumping to reserved code not because the program contains invalid insn.
>>>>> Therefore, make the verifier check the jump target during check_cfg(). For
>>>>> the same program, the verifier reports the following log:
>>>>
>>>> I think we at least would want a test case for this. Also how did you create
>>>> this case? Is it just something you did manually and noticed a strange error?
>>>
>>> Curious as well.
>>>
>>> We do have test cases which try to jump into the middle of a double insn as can
>>> be seen that this patch breaks BPF CI with regards to log mismatch below (which
>>> still needs to be adapted, too). Either way, it probably doesn't hurt to also add
>>> the above snippet as a test.
>>>
>>> Hao, as I understand, the patch here is an usability improvement (not a fix per se)
>>> where we reject such cases earlier during cfg check rather than at a later point
>>> where we validate ld_imm instruction. Or are there cases you found which were not
>>> yet captured via current check_ld_imm()?
>>>
>>> test_verifier failure log :
>>>
>>>     #458/u test1 ld_imm64 FAIL
>>>     Unexpected verifier log!
>>>     EXP: R1 pointer comparison
>>>     RES:
>>>     FAIL
>>>     Unexpected error message!
>>>          EXP: R1 pointer comparison
>>>          RES: jump to reserved code from insn 0 to 2
>>>     verification time 22 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>
>>>     jump to reserved code from insn 0 to 2
>>>     verification time 22 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>     #458/p test1 ld_imm64 FAIL
>>>     Unexpected verifier log!
>>>     EXP: invalid BPF_LD_IMM insn
>>>     RES:
>>>     FAIL
>>>     Unexpected error message!
>>>          EXP: invalid BPF_LD_IMM insn
>>>          RES: jump to reserved code from insn 0 to 2
>>>     verification time 9 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>
>>>     jump to reserved code from insn 0 to 2
>>>     verification time 9 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>     #459/u test2 ld_imm64 FAIL
>>>     Unexpected verifier log!
>>>     EXP: R1 pointer comparison
>>>     RES:
>>>     FAIL
>>>     Unexpected error message!
>>>          EXP: R1 pointer comparison
>>>          RES: jump to reserved code from insn 0 to 2
>>>     verification time 11 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>
>>>     jump to reserved code from insn 0 to 2
>>>     verification time 11 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>     #459/p test2 ld_imm64 FAIL
>>>     Unexpected verifier log!
>>>     EXP: invalid BPF_LD_IMM insn
>>>     RES:
>>>     FAIL
>>>     Unexpected error message!
>>>          EXP: invalid BPF_LD_IMM insn
>>>          RES: jump to reserved code from insn 0 to 2
>>>     verification time 8 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>
>>>     jump to reserved code from insn 0 to 2
>>>     verification time 8 usec
>>>     stack depth 0
>>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>     #460/u test3 ld_imm64 OK
>>>
>>>>> func#0 @0
>>>>> jump to reserved code from insn 8 to 7
>>>>>
>>>>> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
>>>
>>> nit: This needs to be before the "---" line.
>>>
>>>>> ---
>>>>>    kernel/bpf/verifier.c | 7 +++++++
>>>>>    1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>> index eed7350e15f4..725ac0b464cf 100644
>>>>> --- a/kernel/bpf/verifier.c
>>>>> +++ b/kernel/bpf/verifier.c
>>>>> @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>>>>>    {
>>>>>       int *insn_stack = env->cfg.insn_stack;
>>>>>       int *insn_state = env->cfg.insn_state;
>>>>> +    struct bpf_insn *insns = env->prog->insnsi;
>>>>>
>>>>>       if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
>>>>>               return DONE_EXPLORING;
>>>>> @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>>>>>               return -EINVAL;
>>>>>       }
>>>>>
>>>>> +    if (e == BRANCH && insns[w].code == 0) {
>>>>> +            verbose_linfo(env, t, "%d", t);
>>>>> +            verbose(env, "jump to reserved code from insn %d to %d\n", t, w);
>>>>> +            return -EINVAL;
>>>>> +    }
>>>
>>> Other than that, lgtm.
>>
>> We do rely quite a lot on verifier not complaining eagerly about some
>> potentially invalid instructions if it's provable that some portion of
>> the code won't ever be reached (think using .rodata variables for
>> feature gating, poisoning intructions due to failed CO-RE relocation,
>> which libbpf does actively, except it's using a call to non-existing
>> helper). As such, check_cfg() is a wrong place to do such validity
>> checks because some of the branches might never be run and validated
>> in practice.
> 
> Don't really agree. Jump to the middle of ld_imm64 is just like jumping
> out of bounds, both break the CFG integrity immediately. For those
> apparently incorrect  jumps, rejecting early makes everything simple;
> otherwise, we probably need some rewrite in the end.

Could you elaborate on the 'breaking CFG integrity immediately'? This was
what I was trying to gather earlier with log improvement vs actual fix.

Do you mean /potentially/ breaking CFG integrity, if, say, we had a double
insn jump in future and there is a back-jump to the 2nd part of the insn?

> Also, as you mentioned, libbpf relies on non-existing helpers, not jump
> to the middle of ld_imm64. It seems better and easier to not leave this
> hole.

Thanks,
Daniel


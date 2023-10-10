Return-Path: <bpf+bounces-11801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D657BF5F7
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 10:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D30A281D4E
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058DD2F2;
	Tue, 10 Oct 2023 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="radjw9BX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D215AE4
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 08:33:22 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76465B8;
	Tue, 10 Oct 2023 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jyjlaaG3hW2ChkhvKYwd0QsFvY28nBRZeGKF8c7O9Zo=; b=radjw9BXp3ckUNE6kH1pexBReh
	wPcbf76MENcHaZYwn3g3U62Y5aKt/Z0mqc2l3rI0ovTDXXb5wsdATkECqFVhqbsdDiNH9pT6wBvgg
	lahzZN7IguMZV1q9dnCXGibPWZLnZtgfe2+j4hsQnVRjiYwndTBWf9WC2wG1M1s6q6udJiYWYqz2I
	zptc60Mhek9VTfseUXW8UKYdOk4aQTl6QZa2Z7KqozvctYTIxZU9Hc6VTLNCDWUI8dY/lvOHp8ejM
	2cbgmcQiqiOFfT4LiR0TkRUrMM4XSZHZVPqH6cC+EzvISu8SCYKX2W0MEadaGyz4aGKmS0N88y/bk
	Ce3BM5Gw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qq8B0-0003LZ-SC; Tue, 10 Oct 2023 10:33:14 +0200
Received: from [178.197.249.27] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qq8B0-000Lda-4n; Tue, 10 Oct 2023 10:33:14 +0200
Subject: Re: [PATCH bpf-next] Detect jumping to reserved code during
 check_cfg()
To: John Fastabend <john.fastabend@gmail.com>, Hao Sun <sunhao.th@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
 <6524f6f77b896_66abc2084d@john.notmuch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
Date: Tue, 10 Oct 2023 10:33:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6524f6f77b896_66abc2084d@john.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27056/Mon Oct  9 09:40:11 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 9:02 AM, John Fastabend wrote:
> Hao Sun wrote:
>> Currently, we don't check if the branch-taken of a jump is reserved code of
>> ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifier
>> gives the following log in such case:
>>
>> func#0 @0
>> 0: R1=ctx(off=0,imm=0) R10=fp0
>> 0: (18) r4 = 0xffff888103436000       ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
>> 2: (18) r1 = 0x1d                     ; R1_w=29
>> 4: (55) if r4 != 0x0 goto pc+4        ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
>> 5: (1c) w1 -= w1                      ; R1_w=0
>> 6: (18) r5 = 0x32                     ; R5_w=50
>> 8: (56) if w5 != 0xfffffff4 goto pc-2
>> mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
>> mark_precise: frame0: regs=r5 stack= before 6: (18) r5 = 0x32
>> 7: R5_w=50
>> 7: BUG_ld_00
>> invalid BPF_LD_IMM insn
>>
>> Here the verifier rejects the program because it thinks insn at 7 is an
>> invalid BPF_LD_IMM, but such a error log is not accurate since the issue
>> is jumping to reserved code not because the program contains invalid insn.
>> Therefore, make the verifier check the jump target during check_cfg(). For
>> the same program, the verifier reports the following log:
> 
> I think we at least would want a test case for this. Also how did you create
> this case? Is it just something you did manually and noticed a strange error?

Curious as well.

We do have test cases which try to jump into the middle of a double insn as can
be seen that this patch breaks BPF CI with regards to log mismatch below (which
still needs to be adapted, too). Either way, it probably doesn't hurt to also add
the above snippet as a test.

Hao, as I understand, the patch here is an usability improvement (not a fix per se)
where we reject such cases earlier during cfg check rather than at a later point
where we validate ld_imm instruction. Or are there cases you found which were not
yet captured via current check_ld_imm()?

test_verifier failure log :

   #458/u test1 ld_imm64 FAIL
   Unexpected verifier log!
   EXP: R1 pointer comparison
   RES:
   FAIL
   Unexpected error message!
   	EXP: R1 pointer comparison
   	RES: jump to reserved code from insn 0 to 2
   verification time 22 usec
   stack depth 0
   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

   jump to reserved code from insn 0 to 2
   verification time 22 usec
   stack depth 0
   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
   #458/p test1 ld_imm64 FAIL
   Unexpected verifier log!
   EXP: invalid BPF_LD_IMM insn
   RES:
   FAIL
   Unexpected error message!
   	EXP: invalid BPF_LD_IMM insn
   	RES: jump to reserved code from insn 0 to 2
   verification time 9 usec
   stack depth 0
   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

   jump to reserved code from insn 0 to 2
   verification time 9 usec
   stack depth 0
   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
   #459/u test2 ld_imm64 FAIL
   Unexpected verifier log!
   EXP: R1 pointer comparison
   RES:
   FAIL
   Unexpected error message!
   	EXP: R1 pointer comparison
   	RES: jump to reserved code from insn 0 to 2
   verification time 11 usec
   stack depth 0
   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

   jump to reserved code from insn 0 to 2
   verification time 11 usec
   stack depth 0
   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
   #459/p test2 ld_imm64 FAIL
   Unexpected verifier log!
   EXP: invalid BPF_LD_IMM insn
   RES:
   FAIL
   Unexpected error message!
   	EXP: invalid BPF_LD_IMM insn
   	RES: jump to reserved code from insn 0 to 2
   verification time 8 usec
   stack depth 0
   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

   jump to reserved code from insn 0 to 2
   verification time 8 usec
   stack depth 0
   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
   #460/u test3 ld_imm64 OK

>> func#0 @0
>> jump to reserved code from insn 8 to 7
>>
>> ---
>>
>>
>> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

nit: This needs to be before the "---" line.

>> ---
>>   kernel/bpf/verifier.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index eed7350e15f4..725ac0b464cf 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>>   {
>>   	int *insn_stack = env->cfg.insn_stack;
>>   	int *insn_state = env->cfg.insn_state;
>> +	struct bpf_insn *insns = env->prog->insnsi;
>>   
>>   	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
>>   		return DONE_EXPLORING;
>> @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (e == BRANCH && insns[w].code == 0) {
>> +		verbose_linfo(env, t, "%d", t);
>> +		verbose(env, "jump to reserved code from insn %d to %d\n", t, w);
>> +		return -EINVAL;
>> +	}

Other than that, lgtm.

>>   	if (e == BRANCH) {
>>   		/* mark branch target for state pruning */
>>   		mark_prune_point(env, w);
>>


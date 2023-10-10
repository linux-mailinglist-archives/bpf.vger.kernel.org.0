Return-Path: <bpf+bounces-11812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B597C005D
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D5B1C20D92
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAC27458;
	Tue, 10 Oct 2023 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="e5cMpPzV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D9F27453
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 15:27:20 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3A93;
	Tue, 10 Oct 2023 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xGw5JKNGroV+nJlTtMZo29gp/zDG1Ff4DcIXxL9FLSg=; b=e5cMpPzV0p2fC8a6LvrbQnL+CV
	umzdLmpEaEjXgawmLVM4bPQhb3wweNa3SWdHUb+Y4RWf0MJyW+C41v73dZWMFy/1zoIKWSnLSRNaV
	cHwLlUKg1uUfy6N9Y52A6TM8B5J5tpxV+aA+hbV7g6WPeindOmuzdX9oR3oiIQm65nQfDwd9b5yW8
	f88T3T63gJdcU5sraWh+bUN7R2NQLnRK4/Rl9xz+hjp6qa2pYsz1JLz0HrncQ7Gwc3pgSG8npaPVA
	C/+RB1yNEjhkBiVsddurbhMdY5xCq8RbRSNtL4w8nVr9EgRZ+AYT+QCGLBrk79NzV77XOJHfNjoTA
	+jqYhLGQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qqEdX-0005Xu-4d; Tue, 10 Oct 2023 17:27:07 +0200
Received: from [178.197.249.27] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qqEdW-00083o-JE; Tue, 10 Oct 2023 17:27:06 +0200
Subject: Re: [PATCH bpf-next v2] bpf: Detect jumping to reserved code during
 check_cfg()
To: Eduard Zingerman <eddyz87@gmail.com>, Hao Sun <sunhao.th@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231010-jmp-into-reserved-fields-v2-1-3dd5a94d1e21@gmail.com>
 <a2a875ca30b2629afe6f9804eb43572ac81dcf42.camel@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <edec9c1b-b181-d9b9-02b5-1f2ee4050022@iogearbox.net>
Date: Tue, 10 Oct 2023 17:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a2a875ca30b2629afe6f9804eb43572ac81dcf42.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27057/Tue Oct 10 09:39:11 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 4:46 PM, Eduard Zingerman wrote:
> On Tue, 2023-10-10 at 14:03 +0200, Hao Sun wrote:
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
>>
>> func#0 @0
>> jump to reserved code from insn 8 to 7
>>
>> Also adjust existing tests in ld_imm64.c, testing forward/back jump to
>> reserved code.
>>
>> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> 
> Please see a nitpick below.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
>> ---
>> Changes in v2:
>> - Adjust existing test cases
>> - Link to v1: https://lore.kernel.org/bpf/20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com/
>> ---
>>   kernel/bpf/verifier.c                           | 7 +++++++
>>   tools/testing/selftests/bpf/verifier/ld_imm64.c | 8 +++-----
>>   2 files changed, 10 insertions(+), 5 deletions(-)
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
>> +
>>   	if (e == BRANCH) {
>>   		/* mark branch target for state pruning */
>>   		mark_prune_point(env, w);
>> diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
>> index f9297900cea6..c34aa78f1877 100644
>> --- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
>> +++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
>> @@ -9,22 +9,20 @@
>>   	BPF_MOV64_IMM(BPF_REG_0, 2),
>>   	BPF_EXIT_INSN(),
>>   	},
>> -	.errstr = "invalid BPF_LD_IMM insn",
>> -	.errstr_unpriv = "R1 pointer comparison",
>> +	.errstr = "jump to reserved code",
>>   	.result = REJECT,
>>   },
>>   {
>>   	"test2 ld_imm64",
>>   	.insns = {
>> -	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
>>   	BPF_LD_IMM64(BPF_REG_0, 0),
>> +	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -2),
> 
> This change is not really necessary, the test reports same error
> either way.

If we don't have a backward jump covered, we could probably also make this
a new test case rather than modifying an existing one. Aside from that it
would probably also make sense to make this a separate commit, so it eases
backporting a bit.

>>   	BPF_LD_IMM64(BPF_REG_0, 0),
>>   	BPF_LD_IMM64(BPF_REG_0, 1),
>>   	BPF_LD_IMM64(BPF_REG_0, 1),
>>   	BPF_EXIT_INSN(),
>>   	},
>> -	.errstr = "invalid BPF_LD_IMM insn",
>> -	.errstr_unpriv = "R1 pointer comparison",
>> +	.errstr = "jump to reserved code",
>>   	.result = REJECT,
>>   },
>>   {
>>
>> ---
>> base-commit: 3157b7ce14bbf468b0ca8613322a05c37b5ae25d
>> change-id: 20231009-jmp-into-reserved-fields-fc1a98a8e7dc
>>
>> Best regards,
> 



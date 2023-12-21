Return-Path: <bpf+bounces-18521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B281B515
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 12:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73AEB21833
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4076D1BF;
	Thu, 21 Dec 2023 11:40:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B56E5A4
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SwpQ72HQWz4f3kGH
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 19:40:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 225571A0830
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 19:40:18 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDX5kYfJIRl__dpEQ--.40548S2;
	Thu, 21 Dec 2023 19:40:17 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Support inlining bpf_kptr_xchg() helper
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
 <20231219135615.2656572-2-houtao@huaweicloud.com>
 <3ced2738d99310fdd448ecbcbf1370b6f60bc05f.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f8df4493-24b2-d1f8-7e57-ced824644fc4@huaweicloud.com>
Date: Thu, 21 Dec 2023 19:40:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3ced2738d99310fdd448ecbcbf1370b6f60bc05f.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDX5kYfJIRl__dpEQ--.40548S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kZryrtry5AF4UAw1UZFb_yoW8CFWfpa
	yrtFZrGr48tF12kry2vF1xZr18tr48Jw13Wr4FyrWrJanrZr95Way3Kws0qa4fZrs5Aw1F
	v3Wjv3929w15ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU189N3UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Eduard,

On 12/21/2023 1:07 AM, Eduard Zingerman wrote:
> On Tue, 2023-12-19 at 21:56 +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
> [...]
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9456ee0ad129..7814c4f7576e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19668,6 +19668,23 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>  			continue;
>>  		}
>>  
>> +		/* Implement bpf_kptr_xchg inline */
>> +		if (prog->jit_requested && BITS_PER_LONG == 64 &&
>> +		    insn->imm == BPF_FUNC_kptr_xchg &&
>> +		    bpf_jit_supports_ptr_xchg()) {
>> +			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
>> +			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
>> +			cnt = 2;
>> +
>> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>> +			if (!new_prog)
>> +				return -ENOMEM;
>> +
>> +			delta    += cnt - 1;
>> +			env->prog = prog = new_prog;
>> +			insn      = new_prog->insnsi + i + delta;
>> +			continue;
>> +		}
>>  patch_call_imm:
>>  		fn = env->ops->get_func_proto(insn->imm, env->prog);
>>  		/* all functions that have prototype and verifier allowed
> Hi Hou,
>
> I have a suggestion about testing this rewrite.
> It is possible to use function get_xlated_program() from
> tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c,
> to obtain a BPF disassembly for the program after
> do_misc_fixups() are applied.
>
> So, it shouldn't be difficult to:
> - prepare a dummy program in progs/ that uses bpf_kptr_xchg();
> - prepare a new test_* function in prog_tests/ that:
>   - loads that dummy program;
>   - queries it's disassembly using get_xlated_program();
>   - compares it with expected template.
>
> I know that do_misc_fixups() are usually not tested this way,
> but that does not mean they shouldn't, wdyt?

Good idea and thanks for the detailed guidance. Will try it in v2.
>
> Thanks,
> Eduard
> .



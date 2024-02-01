Return-Path: <bpf+bounces-20925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE984529D
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 09:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E701C22FD5
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B49159572;
	Thu,  1 Feb 2024 08:22:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7AF158D94;
	Thu,  1 Feb 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775745; cv=none; b=tZ+/kRycz/1/Gsg5J8+X8vWVrZjy/UWt6TTiSf9LQICbYKm0tD+ccUjQqFo7QwZ+yvhPk+rn41g9Ctonu8q8Vn08jet65wJwc5Kf8yB2jaUrggJNaMfon3IZddU/ZkfN+2WEFZemdkciiQRI0FLBqGKoCGGeQaK/6duylPtHbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775745; c=relaxed/simple;
	bh=UQpWB0NSIhcyE74Zv03n7mmXyIUdRUPxO9taq5uwAqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0Ze8GimVoBHLHb2gvsPsmx1xyYMZKquwNymjmIbZVuK1jFgr4XGhTrMdMbx1hzMLzVglepSb5kD9zF0/jeMaAZsLqDM+EZiewl6tnxjMBJSBq1Tu982UAgSr28KKPK46+hr8UYQ2RGa7AK5EWx38kXjSo2oFN4vv7dSI3TdgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQX2H1Grvz4f3jqt;
	Thu,  1 Feb 2024 16:22:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BCF091A0175;
	Thu,  1 Feb 2024 16:22:17 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgCHVxC4VLtlO4qFCg--.7915S2;
	Thu, 01 Feb 2024 16:22:17 +0800 (CST)
Message-ID: <fab22b9e-7b56-4fef-ba92-bf62ec43007d@huaweicloud.com>
Date: Thu, 1 Feb 2024 16:22:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-5-pulehui@huaweicloud.com>
 <87sf2eohj2.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87sf2eohj2.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHVxC4VLtlO4qFCg--.7915S2
X-Coremail-Antispam: 1UD129KBjvAXoW3CFW8AF15Kw4UtFyxtF1UZFb_yoW8Gw45Wo
	ZxKFs7ua1rG347XryIyrZ7GFyrZa1xKa43ZF45Wwsru3Wxt345KwsrCw4fXay3XF45Wa48
	GFyfta42vFZ7Krn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYb7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/1/31 1:30, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>> the TCC can be propagated from the parent process to the subprocess, but
>> the TCC of the parent process cannot be restored when the subprocess
>> exits. Since the RV64 TCC is initialized before saving the callee saved
>> registers into the stack, we cannot use the callee saved register to
>> pass the TCC, otherwise the original value of the callee saved register
>> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>> similar to x86_64, i.e. using a non-callee saved register to transfer
>> the TCC between functions, and saving that register to the stack to
>> protect the TCC value. At the same time, we also consider the scenario
>> of mixing trampoline.
>>
>> Tests test_bpf.ko and test_verifier have passed, as well as the relative
>> testcases of test_progs*.
> 
> Ok, I'll summarize, so that I know that I get it. ;-)
> 
> All BPF progs (except the main), get the current TCC passed in a6. TCC
> is stored in each BPF stack frame.
> 
> During tail calls, the TCC from the stack is loaded, decremented, and
> stored to the stack again.
> 
> Mixing bpf2bpf/tailcalls means that each *BPF stackframe* can perform up
> to "current TCC to max_tailscalls" number of calls.
> 
> main_prog() calls subprog1(). subprog1() can perform max_tailscalls.
> subprog1() returns, and main_prog() calls subprog2(). subprog2() can
> also perform max_tailscalls.
> 
> Correct?

Your summarize is the same as what I thought, A6 is a carrier. I write a 
use case to verify this:

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c 
b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 59993fc9c0d7..65550e24c843 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -975,6 +975,80 @@ static void test_tailcall_bpf2bpf_6(void)
  	tailcall_bpf2bpf6__destroy(obj);
  }

+#include "tailcall_bpf2bpf7.skel.h"
+
+static void test_tailcall_bpf2bpf_7(void)
+{
+	int err, map_fd, prog_fd, main_fd, data_fd, i;
+	struct tailcall_bpf2bpf7__bss val;
+	struct bpf_map *prog_array, *data_map;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	char prog_name[32];
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load("tailcall_bpf2bpf7.bpf.o", 
BPF_PROG_TYPE_SCHED_CLS,
+				 &obj, &prog_fd);
+	if (CHECK_FAIL(err))
+		return;
+
+	prog = bpf_object__find_program_by_name(obj, "entry");
+	if (CHECK_FAIL(!prog))
+		goto out;
+
+	main_fd = bpf_program__fd(prog);
+	if (CHECK_FAIL(main_fd < 0))
+		goto out;
+
+	prog_array = bpf_object__find_map_by_name(obj, "jmp_table");
+	if (CHECK_FAIL(!prog_array))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (CHECK_FAIL(map_fd < 0))
+		goto out;
+
+	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
+
+		prog = bpf_object__find_program_by_name(obj, prog_name);
+		if (CHECK_FAIL(!prog))
+			goto out;
+
+		prog_fd = bpf_program__fd(prog);
+		if (CHECK_FAIL(prog_fd < 0))
+			goto out;
+
+		err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+		if (CHECK_FAIL(err))
+			goto out;
+	}
+
+	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
+	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "tailcall count");
+	ASSERT_EQ(val.count0, 33, "tailcall count0");
+	ASSERT_EQ(val.count1, 33, "tailcall count1");
+
+out:
+	bpf_object__close(obj);
+}
+
  /* test_tailcall_bpf2bpf_fentry checks that the count value of the 
tail call
   * limit enforcement matches with expectations when tailcall is 
preceded with
   * bpf2bpf call, and the bpf2bpf call is traced by fentry.
@@ -1213,6 +1287,8 @@ void test_tailcalls(void)
  		test_tailcall_bpf2bpf_4(true);
  	if (test__start_subtest("tailcall_bpf2bpf_6"))
  		test_tailcall_bpf2bpf_6();
+	if (test__start_subtest("tailcall_bpf2bpf_7"))
+		test_tailcall_bpf2bpf_7();
  	if (test__start_subtest("tailcall_bpf2bpf_fentry"))
  		test_tailcall_bpf2bpf_fentry();
  	if (test__start_subtest("tailcall_bpf2bpf_fexit"))
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf7.c 
b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf7.c
new file mode 100644
index 000000000000..9818f4056283
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf7.c
@@ -0,0 +1,52 @@
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int count0;
+int count1;
+
+static __noinline
+int subprog_1(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 1);
+	return 0;
+}
+
+static __noinline
+int subprog_0(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return 0;
+}
+
+SEC("tc")
+int classifier_1(struct __sk_buff *skb)
+{
+	count1++;
+	subprog_1(skb);
+	return 0;
+}
+
+SEC("tc")
+int classifier_0(struct __sk_buff *skb)
+{
+	count0++;
+	subprog_0(skb);
+	return 0;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	subprog_0(skb);
+	subprog_1(skb);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

> 
> Some comments below as well.
> 
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit.h        |  1 +
>>   arch/riscv/net/bpf_jit_comp64.c | 89 +++++++++++++--------------------
>>   2 files changed, 37 insertions(+), 53 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index 8b35f12a4452..d8be89dadf18 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -81,6 +81,7 @@ struct rv_jit_context {
>>   	int nexentries;
>>   	unsigned long flags;
>>   	int stack_size;
>> +	int tcc_offset;
>>   };
>>   
>>   /* Convert from ninsns to bytes. */
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 3516d425c5eb..64e0c86d60c4 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -13,13 +13,11 @@
>>   #include <asm/patch.h>
>>   #include "bpf_jit.h"
>>   
>> +#define RV_REG_TCC		RV_REG_A6
>>   #define RV_FENTRY_NINSNS	2
>>   /* fentry and TCC init insns will be skipped on tailcall */
>>   #define RV_TAILCALL_OFFSET	((RV_FENTRY_NINSNS + 1) * 4)
>>   
>> -#define RV_REG_TCC RV_REG_A6
>> -#define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
>> -
>>   static const int regmap[] = {
>>   	[BPF_REG_0] =	RV_REG_A5,
>>   	[BPF_REG_1] =	RV_REG_A0,
>> @@ -51,14 +49,12 @@ static const int pt_regmap[] = {
>>   };
>>   
>>   enum {
>> -	RV_CTX_F_SEEN_TAIL_CALL =	0,
>>   	RV_CTX_F_SEEN_CALL =		RV_REG_RA,
>>   	RV_CTX_F_SEEN_S1 =		RV_REG_S1,
>>   	RV_CTX_F_SEEN_S2 =		RV_REG_S2,
>>   	RV_CTX_F_SEEN_S3 =		RV_REG_S3,
>>   	RV_CTX_F_SEEN_S4 =		RV_REG_S4,
>>   	RV_CTX_F_SEEN_S5 =		RV_REG_S5,
>> -	RV_CTX_F_SEEN_S6 =		RV_REG_S6,
>>   };
>>   
>>   static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
>> @@ -71,7 +67,6 @@ static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
>>   	case RV_CTX_F_SEEN_S3:
>>   	case RV_CTX_F_SEEN_S4:
>>   	case RV_CTX_F_SEEN_S5:
>> -	case RV_CTX_F_SEEN_S6:
>>   		__set_bit(reg, &ctx->flags);
>>   	}
>>   	return reg;
>> @@ -86,7 +81,6 @@ static bool seen_reg(int reg, struct rv_jit_context *ctx)
>>   	case RV_CTX_F_SEEN_S3:
>>   	case RV_CTX_F_SEEN_S4:
>>   	case RV_CTX_F_SEEN_S5:
>> -	case RV_CTX_F_SEEN_S6:
>>   		return test_bit(reg, &ctx->flags);
>>   	}
>>   	return false;
>> @@ -102,32 +96,6 @@ static void mark_call(struct rv_jit_context *ctx)
>>   	__set_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
>>   }
>>   
>> -static bool seen_call(struct rv_jit_context *ctx)
>> -{
>> -	return test_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
>> -}
>> -
>> -static void mark_tail_call(struct rv_jit_context *ctx)
>> -{
>> -	__set_bit(RV_CTX_F_SEEN_TAIL_CALL, &ctx->flags);
>> -}
>> -
>> -static bool seen_tail_call(struct rv_jit_context *ctx)
>> -{
>> -	return test_bit(RV_CTX_F_SEEN_TAIL_CALL, &ctx->flags);
>> -}
>> -
>> -static u8 rv_tail_call_reg(struct rv_jit_context *ctx)
>> -{
>> -	mark_tail_call(ctx);
>> -
>> -	if (seen_call(ctx)) {
>> -		__set_bit(RV_CTX_F_SEEN_S6, &ctx->flags);
>> -		return RV_REG_S6;
>> -	}
>> -	return RV_REG_A6;
>> -}
>> -
>>   static bool is_32b_int(s64 val)
>>   {
>>   	return -(1L << 31) <= val && val < (1L << 31);
>> @@ -252,10 +220,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>>   		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
>>   		store_offset -= 8;
>>   	}
>> -	if (seen_reg(RV_REG_S6, ctx)) {
>> -		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
>> -		store_offset -= 8;
>> -	}
>> +	emit_ld(RV_REG_TCC, store_offset, RV_REG_SP, ctx);
> 
> Why do you need to restore RV_REG_TCC? We're passing RV_REG_TCC (a6) as
> an argument at all call-sites, and for tailcalls we're loading from the
> stack.
> 
> Is this to fake the a6 argument for the tail-call? If so, it's better to
> move it to emit_bpf_tail_call(), instead of letting all programs pay for
> it.

Yes, we can remove this duplicate load. will do that at next version.

> 
>>   
>>   	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>>   	/* Set return value. */
>> @@ -343,7 +308,6 @@ static void emit_branch(u8 cond, u8 rd, u8 rs, int rvoff,
>>   static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>>   {
>>   	int tc_ninsn, off, start_insn = ctx->ninsns;
>> -	u8 tcc = rv_tail_call_reg(ctx);
>>   
>>   	/* a0: &ctx
>>   	 * a1: &array
>> @@ -366,9 +330,11 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>>   	/* if (--TCC < 0)
>>   	 *     goto out;
>>   	 */
>> -	emit_addi(RV_REG_TCC, tcc, -1, ctx);
>> +	emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
>> +	emit_addi(RV_REG_TCC, RV_REG_TCC, -1, ctx);
>>   	off = ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
>>   	emit_branch(BPF_JSLT, RV_REG_TCC, RV_REG_ZERO, off, ctx);
>> +	emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
>>   
>>   	/* prog = array->ptrs[index];
>>   	 * if (!prog)
>> @@ -767,7 +733,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   	int i, ret, offset;
>>   	int *branches_off = NULL;
>>   	int stack_size = 0, nregs = m->nr_args;
>> -	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
>> +	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc_off;
>>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>> @@ -812,6 +778,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   	 *
>>   	 * FP - sreg_off    [ callee saved reg	]
>>   	 *
>> +	 * FP - tcc_off     [ tail call count	] BPF_TRAMP_F_TAIL_CALL_CTX
>> +	 *
>>   	 *		    [ pads              ] pads for 16 bytes alignment
>>   	 */
>>   
>> @@ -853,6 +821,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   	stack_size += 8;
>>   	sreg_off = stack_size;
>>   
>> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
>> +		stack_size += 8;
>> +		tcc_off = stack_size;
>> +	}
>> +
>>   	stack_size = round_up(stack_size, 16);
>>   
>>   	if (!is_struct_ops) {
>> @@ -879,6 +852,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
>>   	}
>>   
>> +	/* store tail call count */
>> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>> +		emit_sd(RV_REG_FP, -tcc_off, RV_REG_TCC, ctx);
>> +
>>   	/* callee saved register S1 to pass start time */
>>   	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
>>   
>> @@ -932,6 +909,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   
>>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>>   		restore_args(nregs, args_off, ctx);
>> +		/* restore TCC to RV_REG_TCC before calling the original function */
>> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>> +			emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
>>   		ret = emit_call((const u64)orig_call, true, ctx);
>>   		if (ret)
>>   			goto out;
>> @@ -963,6 +943,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>   		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
>>   		if (ret)
>>   			goto out;
>> +	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
>> +		/* restore TCC to RV_REG_TCC before calling the original function */
>> +		emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
>>   	}
>>   
>>   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
>> @@ -1455,6 +1438,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   		if (ret < 0)
>>   			return ret;
>>   
>> +		/* restore TCC from stack to RV_REG_TCC */
>> +		emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
>> +
>>   		ret = emit_call(addr, fixed_addr, ctx);
>>   		if (ret)
>>   			return ret;
>> @@ -1733,8 +1719,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>>   		stack_adjust += 8;
>>   	if (seen_reg(RV_REG_S5, ctx))
>>   		stack_adjust += 8;
>> -	if (seen_reg(RV_REG_S6, ctx))
>> -		stack_adjust += 8;
>> +	stack_adjust += 8; /* RV_REG_TCC */
>>   
>>   	stack_adjust = round_up(stack_adjust, 16);
>>   	stack_adjust += bpf_stack_adjust;
>> @@ -1749,7 +1734,8 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>>   	 * (TCC) register. This instruction is skipped for tail calls.
>>   	 * Force using a 4-byte (non-compressed) instruction.
>>   	 */
>> -	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
>> +	if (!bpf_is_subprog(ctx->prog))
>> +		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> 
> You're conditionally emitting the instruction. Doesn't this break
> RV_TAILCALL_OFFSET?
> 

This does not break RV_TAILCALL_OFFSET, because The target of tailcall 
is always `main` prog, but not subprog.

> 
> Björn



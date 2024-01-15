Return-Path: <bpf+bounces-19544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27AC82DAD3
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 15:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A405E1C21A1B
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459BA175B5;
	Mon, 15 Jan 2024 14:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212C1757A;
	Mon, 15 Jan 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDDL969ZXz4f3jq2;
	Mon, 15 Jan 2024 22:00:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EEC511A0BAE;
	Mon, 15 Jan 2024 22:00:19 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBXeg1xOqVlBRm1Aw--.63466S2;
	Mon, 15 Jan 2024 22:00:19 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240115070010.12338-1-yangtiezhu@loongson.cn>
 <20240115070010.12338-3-yangtiezhu@loongson.cn>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <84e15d1c-c2a6-9af4-c123-beea01893a8f@huaweicloud.com>
Date: Mon, 15 Jan 2024 22:00:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240115070010.12338-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBXeg1xOqVlBRm1Aw--.63466S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4rAw48WF1kAr17Zr4DXFb_yoW5tw4rpF
	4kJ3WqkF10va429r17Zwn7GFWYvw4kXw4UGryfW3y8AF4DJr13Jrn3KrWYvF93GrWrWa4S
	va109r45Ww1UJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/15/2024 3:00 PM, Tiezhu Yang wrote:
> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
> exist 6 failed tests.
>
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   #106/p inline simple bpf_loop call FAIL
>   #107/p don't inline bpf_loop call, flags non-zero FAIL
>   #108/p don't inline bpf_loop call, callback non-constant FAIL
>   #109/p bpf_loop_inline and a dead func FAIL
>   #110/p bpf_loop_inline stack locations for loop vars FAIL
>   #111/p inline bpf_loop call in a big program FAIL
>   Summary: 768 PASSED, 15 SKIPPED, 6 FAILED
>
> The test log shows that callbacks are not allowed in non-JITed programs,
> interpreter doesn't support them yet, thus these tests should be skipped
> if jit is disabled, copy some check functions from the other places under
> tools directory, and then handle this case in do_test_single().
>
> With this patch:
>
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   Summary: 768 PASSED, 21 SKIPPED, 0 FAILED
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 23 +++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 1a09fc34d093..70f903e869b7 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -74,6 +74,7 @@
>  		    1ULL << CAP_BPF)
>  #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
>  static bool unpriv_disabled = false;
> +static bool jit_disabled;
>  static int skips;
>  static bool verbose = false;
>  static int verif_log_level = 0;
> @@ -1355,6 +1356,16 @@ static bool is_skip_insn(struct bpf_insn *insn)
>  	return memcmp(insn, &skip_insn, sizeof(skip_insn)) == 0;
>  }
>  
> +static bool is_ldimm64_insn(struct bpf_insn *insn)
> +{
> +	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
> +}
> +
> +static bool insn_is_pseudo_func(struct bpf_insn *insn)
> +{
> +	return is_ldimm64_insn(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
> +}
> +
>  static int null_terminated_insn_len(struct bpf_insn *seq, int max_len)
>  {
>  	int i;
> @@ -1619,6 +1630,16 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>  		goto close_fds;
>  	}
>  
> +	if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled) {
> +		for (i = 0; i < prog_len; i++, prog++) {
> +			if (insn_is_pseudo_func(prog)) {
> +				printf("SKIP (callbacks are not allowed in non-JITed programs)\n");
> +				skips++;
> +				goto close_fds;
> +			}
> +		}
> +	}

I ran test_verifier before applying the patch set, it seems all
expected_ret for these failed programs are ACCEPT, so I think it would
be better to move the not-allowed-checking into "if (expected_ret ==
ACCEPT || expected_ret == VERBOSE_ACCEPT)" block. I should suggest such
modification in v2, sorry about that.
> +
>  	alignment_prevented_execution = 0;
>  
>  	if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
> @@ -1844,6 +1865,8 @@ int main(int argc, char **argv)
>  		return EXIT_FAILURE;
>  	}
>  
> +	jit_disabled = !is_jit_enabled();
> +
>  	/* Use libbpf 1.0 API mode */
>  	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
>  



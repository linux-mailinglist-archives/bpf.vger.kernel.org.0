Return-Path: <bpf+bounces-19408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65382BA50
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 05:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2043D282D35
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 04:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4CF1B298;
	Fri, 12 Jan 2024 04:21:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAF1B28E;
	Fri, 12 Jan 2024 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TB7dk48gFz4f3kkN;
	Fri, 12 Jan 2024 12:21:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9073D1A01A9;
	Fri, 12 Jan 2024 12:21:32 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB3lQ5IvqBlaHlSAg--.3495S2;
	Fri, 12 Jan 2024 12:21:32 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Skip callback tests if jit is
 disabled in test_verifier
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240112015700.19974-1-yangtiezhu@loongson.cn>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1e919c98-2fc4-bd03-df19-97c4e8a24649@huaweicloud.com>
Date: Fri, 12 Jan 2024 12:21:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240112015700.19974-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB3lQ5IvqBlaHlSAg--.3495S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15ZFy7Wr1xZryUZF48Crg_yoWrGF15pa
	ykCF1vkF1DJFyIgr17Zr1xJF9Yvr40qw1UJFy3W3yUAa1DA343Jrn7KryYvF93GrW5ua4S
	vFWI9FW5uw43XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/12/2024 9:57 AM, Tiezhu Yang wrote:
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
> v2: Remove inline keyword in C files, sorry for that.
>
> Thanks very much for the feedbacks from Eduard, John, Jiri and Daniel.
> I do not move loop inlining tests to test_progs, just copy some check
> functions and do the minimal changes in test_verifier.
>
>  tools/testing/selftests/bpf/test_verifier.c | 39 +++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index f36e41435be7..d4e600e3caec 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -21,6 +21,7 @@
>  #include <sched.h>
>  #include <limits.h>
>  #include <assert.h>
> +#include <fcntl.h>
>  
>  #include <linux/unistd.h>
>  #include <linux/filter.h>
> @@ -1397,6 +1398,34 @@ static bool is_skip_insn(struct bpf_insn *insn)
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
> +static bool is_jit_enabled(void)
> +{
> +	const char *jit_sysctl = "/proc/sys/net/core/bpf_jit_enable";
> +	bool enabled = false;
> +	int sysctl_fd;
> +
> +	sysctl_fd = open(jit_sysctl, 0, O_RDONLY);

It should be open(jit_sysctl, O_RDONLY).
> +	if (sysctl_fd != -1) {
> +		char tmpc;
> +
> +		if (read(sysctl_fd, &tmpc, sizeof(tmpc)) == 1)
> +			enabled = (tmpc != '0');
> +		close(sysctl_fd);
> +	}
> +
> +	return enabled;
> +}
> +
>  static int null_terminated_insn_len(struct bpf_insn *seq, int max_len)
>  {
>  	int i;
> @@ -1662,6 +1691,16 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>  		goto close_fds;
>  	}
>  
> +	if (!is_jit_enabled()) {

Is it necessary to check whether jit is enabled or not each time ? Could
we just check it only once just like unpriv_disabled does ?
> +		for (i = 0; i < prog_len; i++, prog++) {

Is it better to only check pseudo_func only when both fd_prog < 0 and
saved_errno == EINVAL are true, so unnecessary check can be skipped ?
> +			if (insn_is_pseudo_func(prog)) {
> +				printf("SKIP (callbacks are not allowed in non-JITed programs)\n");
> +				skips++;
> +				goto close_fds;
> +			}
> +		}
> +	}
> +
>  	alignment_prevented_execution = 0;
>  
>  	if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {



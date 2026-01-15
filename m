Return-Path: <bpf+bounces-78972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B145ED21FDB
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 02:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD0DD3065B75
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 01:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F92A2DE6E3;
	Thu, 15 Jan 2026 01:14:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69B2C0307
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439649; cv=none; b=AwIxmuFGwBYO9J1eC3lzDw7VVXeyxbenCR9hS7yOw2ZtYA7kFMHWj1E2eVVUNUhSZqVPSlPR8mTlIhJwD28WDqDuAONXXbMjhuPcYhIVN4T1bXylIr4x0Wi3QivhwjNeJuwQlTf0JWTyNlffTroSjYzQxHxiCipjH1zp9rDXd5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439649; c=relaxed/simple;
	bh=C9bO0AsgjhtifGNbJzbrxVSBXG7y+2b8jeZWZ186+ZY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cShhPDRlzd35PBzFIidHCXEd8XBYQ6sP6quib/ee5vCdQbglGXM7UjX/DpKEiQ3kVuFnRSWOv8u7TvH1+JTmi5lqPLEWY096YZnzozB+mZ5jakKiKmdBH0fe9QXdY5VhX8ylRG4wETnX6pQqpVnhnIpeTlA+Qmu33tfzHR13EnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxHvBPP2hpBQMJAA--.29896S3;
	Thu, 15 Jan 2026 09:13:51 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxWeBJP2hpnK0eAA--.63651S3;
	Thu, 15 Jan 2026 09:13:47 +0800 (CST)
Subject: Re: [BUG?]: bpf/selftests: ns_bpf_qdisc libbpf: loading object
 'tc_bpf' from buffer
To: Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 loongarch@lists.linux.dev
Cc: ast <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Hengqi Chen <hengqi.chen@gmail.com>, Chenghao Duan
 <duanchenghao@kylinos.cn>, Huacai Chen <chenhuacai@kernel.org>
References: <CAK3+h2yu+XkEMWz6FOHiDEEQw-G_iKG2KHP=F=1CiqLr0mCgNA@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d299d7ba-4e9e-5b16-5aa4-898b62330c24@loongson.cn>
Date: Thu, 15 Jan 2026 09:13:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK3+h2yu+XkEMWz6FOHiDEEQw-G_iKG2KHP=F=1CiqLr0mCgNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeBJP2hpnK0eAA--.63651S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1fWFyrKFWUJw17ArWfCrX_yoW5Jr4rpa
	y5ZFs0yr1kX3Z7Zr1Iy340vFy5Grn3WFykKF48Jryj93srGay8JF1Ut39Y93s8KrWvqr9F
	v34ktas3X34rCagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=

On 2026/1/2 上午2:26, Vincent Li wrote:
> Hi,
> 
> I used AI to enhance my message, hope it helps :)
> 
> I am reporting test failures observed while running BPF selftests on a
> LoongArch machine. Both the ns_bpf_qdisc and xdp_synproxy tests
> exhibit WATCHDOG timeouts and eventual failures. The issue appears
> architecture-specific but I am not sure.
> 
> Issue Summary:
> When building and running 6.19.0-rc3 BPF selftests on a LoongArch machine:
> 
> The "ns_bpf_qdisc/attach to mq" test fails with a WATCHDOG timeout
> after 120 seconds, followed by SIGSEGV.

...

> Are these two test failures (ns_bpf_qdisc and xdp_synproxy) related,
> given they both show similar timeout patterns?
> 
> Environment:
> 
> Kernel: 6.19.0-rc3
> 
> Architecture: LoongArch
> 
> Test Command: ./test_progs -t ns_bpf_qdisc

Tested with the latest 6.19-rc5, the testcase passed on LoongArch.

1. Here are the test results:

$ sudo ./test_progs -t ns_bpf_qdisc
Warning: sch_htb: quantum of class 10001 is small. Consider r2q change.
#219/1   ns_bpf_qdisc/fifo:OK
#219/2   ns_bpf_qdisc/fq:OK
#219/3   ns_bpf_qdisc/attach to mq:OK
#219/4   ns_bpf_qdisc/attach to non root:OK
#219/5   ns_bpf_qdisc/incompl_ops:OK
#219     ns_bpf_qdisc:OK
Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED

2. Here are the toolchains:

$ clang --version | head -1
clang version 21.1.8 (https://github.com/llvm/llvm-project.git 
2078da43e25a4623cab2d0d60decddf709aaea28)
$ gcc --version | head -1
gcc (GCC) 16.0.0 20260105 (experimental)
$ as --version | head -1
GNU assembler (GNU Binutils) 2.45.50.20260105
$ pahole --version
v1.31

3. Here are the test steps:

(1) Compile and update kernel

cd linux.git
make mrproper defconfig -j"$(nproc)"

scripts/config -e FTRACE -e FUNCTION_TRACER -e DYNAMIC_FTRACE \
-e FTRACE_SYSCALLS -e FPROBE -e BPF_LSM -e DEBUG_ATOMIC_SLEEP \
-e KPROBES -e FUNCTION_ERROR_INJECTION -e BPF_KPROBE_OVERRIDE \
-e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e DEBUG_INFO_BTF \
-m TEST_BPF -d BPF_UNPRIV_DEFAULT_OFF -d ARCH_STRICT_ALIGN \
-e NET_SCH_BPF -e NET_SCH_HTB -e DIBS -e DIBS_LO -e SMC \
-e SMC_HS_CTRL_BPF --set-val RCU_CPU_STALL_TIMEOUT 60

make olddefconfig all -j"$(nproc)"
sudo make modules_install -j"$(nproc)"
sudo make install -j"$(nproc)"
sudo reboot

(2) Compile and test bpf

cd linux.git
cd tools/testing/selftests/bpf && make
sudo ./test_progs -t ns_bpf_qdisc

Thanks,
Tiezhu



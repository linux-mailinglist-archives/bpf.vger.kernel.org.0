Return-Path: <bpf+bounces-65407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F74BB21A16
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 03:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A801A4272D8
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 01:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC12D9EDD;
	Tue, 12 Aug 2025 01:23:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCC2D9482
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961804; cv=none; b=ZUfdOy4+APWzJhp9AXt8j7Go5jJwt26Kxr8m+Iv2qslAR51Hbfob26oBbQrxEjpIE7yeACy2JbYzb6Nw0/5tiJDv+RH807RnFo8qzV3kCWWHoPcz02q+WEkFQP9b/UCyjUGw3NfgKevGHAffwvH20vuLiNY5By4PLW6JPbqTJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961804; c=relaxed/simple;
	bh=BIPH46FSobkqtTerc2x4hgocDuZHX8L+W1cJNkPSzpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RbW3OcRl73yntimWqHjBT/NHAQDfVaqTx/JXD+EHHwWjhp5hHeKpu7Rbx0Iu8vKn26CrECMCLmh1RNDz0H9QYereoSE9jvxQFWuQ6bitjkz3U7zJm8wr0Tb23a7Um4cM5MynmoQqBs5CI6TgfpP+QjPIL0oPlP9zIx1diV3QfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1DKF3wxgzKHLx8
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 09:23:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BEBB91A0359
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 09:23:12 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgBHubR+l5ponRVJDQ--.26854S2;
	Tue, 12 Aug 2025 09:23:11 +0800 (CST)
Message-ID: <56205876-a753-4df4-aa1d-49dc1c426b15@huaweicloud.com>
Date: Tue, 12 Aug 2025 09:23:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] bpf, arm64: support for timed may_goto
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250809204833.44803-1-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250809204833.44803-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHubR+l5ponRVJDQ--.26854S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWkZF48KFy8WFWUtr1DWrg_yoW5WF45pa
	yS9F9Iyw1kAa1DGr9aqF1DZFyfAFs3Jw43Gw1xtrWfAF45tFnxGF48Kws8Ar4YyF95uw4r
	ta15Za45C3WDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/10/2025 4:48 AM, Puranjay Mohan wrote:
> Changes in v1->v2:
> v1: https://lore.kernel.org/bpf/20250724125443.26182-1-puranjay@kernel.org/
> - Added comment in arch_bpf_timed_may_goto() about BPF_REG_FP setup (Xu
>    Kuohai)
> 
> This set adds support for the timed may_goto instruction for the arm64.
> The timed may_goto instruction is implemented by the verifier by
> reserving 2 8byte slots in the program stack and then calling
> arch_bpf_timed_may_goto() in a loop with the stack offset of these two
> slots in BPF_REG_AX. It expects the function to put a timestamp in the
> first slot and the returned count in BPF_REG_AX is put into the second
> slot by a store instruction emitted by the verifier.
> 
> arch_bpf_timed_may_goto() is special as it receives the parameter in
> BPF_REG_AX and is expected to return the result in BPF_REG_AX as well.
> It can't clobber any caller saved registers because verifier doesn't
> save anything before emitting the call.
> 
> So, arch_bpf_timed_may_goto() is implemented in assembly so the exact
> registers that are stored/restored can be controlled (BPF caller saved
> registers here) and it also needs to take care of moving arguments and
> return values to and from BPF_REG_AX <-> arm64 R0.
> 
> So, arch_bpf_timed_may_goto() acts as a trampoline to call
> bpf_check_timed_may_goto() which does the main logic of placing the
> timestamp and returning the count.
> 
> All tests that use may_goto instruction pass after the changing some of
> them in patch 2
> 
>   #404     stream_errors:OK
>   [...]
>   #406/2   stream_success/stream_cond_break:OK
>   [...]
>   #494/23  verifier_bpf_fastcall/may_goto_interaction_x86_64:SKIP
>   #494/24  verifier_bpf_fastcall/may_goto_interaction_arm64:OK
>   [...]
>   #539/1   verifier_may_goto_1/may_goto 0:OK
>   #539/2   verifier_may_goto_1/batch 2 of may_goto 0:OK
>   #539/3   verifier_may_goto_1/may_goto batch with offsets 2/1/0:OK
>   #539/4   verifier_may_goto_1/may_goto batch with offsets 2/0:OK
>   #539     verifier_may_goto_1:OK
>   #540/1   verifier_may_goto_2/C code with may_goto 0:OK
>   #540     verifier_may_goto_2:OK
>   Summary: 7/16 PASSED, 25 SKIPPED, 0 FAILED
> 
> Puranjay Mohan (2):
>    bpf, arm64: Add JIT support for timed may_goto
>    selftests/bpf: Enable timed may_goto tests for arm64
> 
>   arch/arm64/net/Makefile                       |  2 +-
>   arch/arm64/net/bpf_jit_comp.c                 | 13 +++++-
>   arch/arm64/net/bpf_timed_may_goto.S           | 40 +++++++++++++++++++
>   .../testing/selftests/bpf/prog_tests/stream.c |  2 +-
>   .../bpf/progs/verifier_bpf_fastcall.c         | 27 ++++++++-----
>   .../selftests/bpf/progs/verifier_may_goto_1.c | 34 +++-------------
>   6 files changed, 76 insertions(+), 42 deletions(-)
>   create mode 100644 arch/arm64/net/bpf_timed_may_goto.S
> 

For the series,

Acked-by: Xu Kuohai <xukuohai@huawei.com>



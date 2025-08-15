Return-Path: <bpf+bounces-65756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 878EEB27C7F
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51636188A740
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3326C384;
	Fri, 15 Aug 2025 09:08:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC65248891;
	Fri, 15 Aug 2025 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248889; cv=none; b=n413eoO4c9Nkci6Tnnm0VM5U6OaKq38e2KQuJjNyRP0AzjLxDFQ7ftU/AmP0oLeONJKPYGAWodp/6DYT4skwNfpi7aVC1uy/BYofgUsIqhkN4YgEA81gn8Ck7r+MvGAbWF+wxdxEucHIZdfLQrQeinJyFyqNLtM8qtUHoRdQN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248889; c=relaxed/simple;
	bh=0O9r5hlK1wdjjDzKZTV39IN26xTdiAJx/BRLVpWcoQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HH2USZuFuHSl0w6UlTI69j305amdG8OwvMPA7UlirWNCZdLV7uuPlOpZIskOsNqlXW9j584e7npxvDcp/LPdHCmgGs/qZrWMjCPUbedMLCjDtZi4x+gKES5/DYfi+8braiMTZLYPFAz3uVWMKluvwE5FvA4vWKDKh7AroySpduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3GVG0Np9zYQvCh;
	Fri, 15 Aug 2025 17:08:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A2E691A1B08;
	Fri, 15 Aug 2025 17:08:04 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgCHUBHz+J5ogLYDDw--.38943S2;
	Fri, 15 Aug 2025 17:08:04 +0800 (CST)
Message-ID: <381def4c-ebe1-4dc1-a301-72cdc7f9176a@huaweicloud.com>
Date: Fri, 15 Aug 2025 17:08:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 00/10] Add support arena atomics for RV64
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <87v7n21deu.fsf@all.your.base.are.belong.to.us>
 <00538107-08e3-4ba3-a11a-19fa9fd0a496@huaweicloud.com>
 <8ef2259d-eb58-4c66-a27a-3ee0b85aa639@iogearbox.net>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <8ef2259d-eb58-4c66-a27a-3ee0b85aa639@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHUBHz+J5ogLYDDw--.38943S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xGF1xKw17tw17Cr1rJFb_yoW5JFWfpw
	s5CasIyrWrCr1fAwnrtr18JryfKr48Jw15Xr1UJFy8Arsrtr4jgF4xX3Wj9r1DJrWrXr15
	Cr1YyrnxZw15ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/8/15 16:55, Daniel Borkmann wrote:
> On 8/5/25 8:52 AM, Pu Lehui wrote:
>> On 2025/8/5 14:38, Björn Töpel wrote:
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> patch 1-3 refactor redundant load and store operations.
>>>> patch 4-7 add Zacas instructions for cmpxchg.
>>>> patch 8 optimizes exception table handling.
>>>> patch 9-10 add support arena atomics for RV64.
>>>>
>>>> Tests `test_progs -t atomic,arena` have passed as shown bellow,
>>>> as well as `test_verifier` and `test_bpf.ko` have passed.
>>>
>>> [...]
>>>
>>>> Pu Lehui (10):
>>>>    riscv, bpf: Extract emit_stx() helper
>>>>    riscv, bpf: Extract emit_st() helper
>>>>    riscv, bpf: Extract emit_ldx() helper
>>>>    riscv: Separate toolchain support dependency from RISCV_ISA_ZACAS
>>>>    riscv, bpf: Add rv_ext_enabled macro for runtime detection 
>>>> extentsion
>>>>    riscv, bpf: Add Zacas instructions
>>>>    riscv, bpf: Optimize cmpxchg insn with Zacas support
>>>>    riscv, bpf: Add ex_insn_off and ex_jmp_off for exception table
>>>>      handling
>>>>    riscv, bpf: Add support arena atomics for RV64
>>>>    selftests/bpf: Enable arena atomics tests for RV64
>>>>
>>>>   arch/riscv/Kconfig                            |   1 -
>>>>   arch/riscv/include/asm/cmpxchg.h              |   6 +-
>>>>   arch/riscv/kernel/setup.c                     |   1 +
>>>>   arch/riscv/net/bpf_jit.h                      |  70 ++-
>>>>   arch/riscv/net/bpf_jit_comp64.c               | 516 
>>>> +++++-------------
>>>>   .../selftests/bpf/progs/arena_atomics.c       |   9 +-
>>>>   6 files changed, 214 insertions(+), 389 deletions(-)
>>>
>>> What a nice series! The best kind of changeset -- new feature, less
>>> code! Thank you, Lehui! Again, apologies for the horrible SLA. The
>>> weather in Sweden was simply Too Good this summer!
>>
>> Sounds like a great vacation!
> 
> Thanks for working on this! I just took this into bpf-next, please also
> make sure to address the small follow-up request from Bjorn.

Hi Daniel,

Already explained and aligned with Bjorn, no further processing is 
required. Thanks.

> 
>>> Tested-by: Björn Töpel <bjorn@rivosinc.com> # QEMU only
>>> Acked-by: Björn Töpel <bjorn@kernel.org>
> 
> Thanks,
> Daniel



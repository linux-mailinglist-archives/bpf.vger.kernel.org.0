Return-Path: <bpf+bounces-43027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB79AE00A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8051128409D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE6F1B395E;
	Thu, 24 Oct 2024 09:03:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1A172BAE;
	Thu, 24 Oct 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760607; cv=none; b=pt9qrZC3uXfOTdI1WsjoG9XyY6bGO5ql63JbS3nnJpAEIkpS+llk6WJqllYg13kK4l4U5vDVDPh7+80tUnO5FEojLQNwVTnqcsuayPsTuKxmagXJX7GHAks6MMWrqmkOr3ZgzUwiqFbLCZSiRaIrETyM5HK8ObtOdtNcmq2evJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760607; c=relaxed/simple;
	bh=88kqoKvZveiC++AA4JP+24ptd59TOga/HcATW1Shhb0=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cfeF8fRYm9YNsy8S47Cu0X03XoNfiVvTQcrlAQsa4CQSblGjUMAzQULMnUVG8XstIsFm23dtlbUMuiNgwd1uqiulwVUfyGJqJLmXq/pVNXrJHqzVq/kDu4Wa+T1ZM6BNyx9CyhoQWEfX/jvkVN/8shWgmJ1QdNtxm99SEu+4S5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxquFRDRpncFwKAA--.24348S3;
	Thu, 24 Oct 2024 17:03:13 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxDuFQDRpnUxIPAA--.18662S3;
	Thu, 24 Oct 2024 17:03:13 +0800 (CST)
Subject: Re: [PATCH v1 4/6] bpf, core: Add weak arch_prepare_goto()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20241015113915.12623-1-yangtiezhu@loongson.cn>
 <20241015113915.12623-5-yangtiezhu@loongson.cn>
 <CAADnVQK6wgy0e5nW220sSDXzxkKcga8zpCDqKmDd=8xdooP37g@mail.gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <2ba0bee2-972a-0374-8ec8-75a91e1217b4@loongson.cn>
Date: Thu, 24 Oct 2024 17:03:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQK6wgy0e5nW220sSDXzxkKcga8zpCDqKmDd=8xdooP37g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxDuFQDRpnUxIPAA--.18662S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFyrXrW8CrWDJr45KFWxGrX_yoWkKwb_Gw
	s09r4Skr15GF9rAFsrGrn5ZFW2kay8X3yfua4UXw1UX34rtFWUJrWkGF9ru34rtFZ8uFnI
	gr4qqw1jyr17uosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 10/16/2024 02:36 AM, Alexei Starovoitov wrote:
> On Tue, Oct 15, 2024 at 4:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> The objtool program needs to analysis the control flow of each
>> object file generated by compiler toolchain, it needs to know
>> all the locations that a branch instruction may jump into.

...

>> +       arch_prepare_goto();
>>         goto *jumptable[insn->code];
>
> That looks fragile. There is no guarantee that compiler will keep
> asm statement next to indirect goto.
> It has all rights to move/copy such goto around.
> There are other parts in the kernel which are not annotated either:
> drm_exec_retry_on_contention(),
> drivers/misc/lkdtm/cfi.c
>
> You're arguing that it's hard to properly in the compiler,
> but that's the only option. It has to be done by the compiler.

Thank you very much for your reply. I will drop this patch
and try to find a proper way to handle this case.

By the way, I spent more time to test and analysis with gcc
and clang on x86 and loongarch, it needs to fix some corner
issues for the other patches compiled with clang.

Anyway, I will submit v2 series without changing bpf file,
patch #4 and patch #5 will be removed.

Thanks,
Tiezhu



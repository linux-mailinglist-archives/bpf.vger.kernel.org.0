Return-Path: <bpf+bounces-76381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B5ECB18BE
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 01:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EDB0301B813
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF61E5B71;
	Wed, 10 Dec 2025 00:48:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23B71E47A3;
	Wed, 10 Dec 2025 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765327714; cv=none; b=ALgIIR42uc0AyMT4jQ9je3f/Ng7YHs6Ft0h0UQ9JUYZKEwB2zpbZeR1FR4NspnkTYp6wYSLVXhu+UDgI0DXd4o2BJ5PRjiGGV+YElh8J6BoAAs/YnYakclhGA/pKwifGMuxsJkHcPvzBOK414r4FSjGx2v2oSjwGgd7Mm1xma+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765327714; c=relaxed/simple;
	bh=ANCXgiltlhetwp0/3uA6mI/PXMOYcyCs8tAHAV9Ra1c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fQX9OTQZ2/hm8/A0kl/DEVrrhVo3I6WakYyK7h00F9xpUEcv/4KhjsDa6+X0dgw2NL9v8l2TyCXIzBQK+l3+lwp5Ngl5bODZFy2ps04wt65X9aUAu/1WKBC178dAvFA6RwjoDF23qaexVrAztbutRbyCpbSTO/kzERahA5150QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx_9NbwzhpedQsAA--.26050S3;
	Wed, 10 Dec 2025 08:48:27 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxC8FWwzhphJxHAQ--.19467S3;
	Wed, 10 Dec 2025 08:48:23 +0800 (CST)
Subject: Re: [PATCH v1 1/2] LoongArch: Modify the jump logic of the trampoline
To: Chenghao Duan <duanchenghao@kylinos.cn>, hengqi.chen@gmail.com,
 chenhuacai@kernel.org
Cc: kernel@xen0n.name, zhangtianyang@loongson.cn, masahiroy@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
 jianghaoran@kylinos.cn, vincent.mc.li@gmail.com,
 Youling Tang <tangyouling@kylinos.cn>
References: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
 <20251209093405.1309253-2-duanchenghao@kylinos.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <53889229-333a-7833-d9bf-42bef71d1d68@loongson.cn>
Date: Wed, 10 Dec 2025 08:48:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251209093405.1309253-2-duanchenghao@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxC8FWwzhphJxHAQ--.19467S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy5tF4UCw4UZFW3CrykZwc_yoW8AF43p3
	y7ua9xur4FyFZYkrn7W3W5ZF1av397JrZ8Ga42y34rZ3Z0gry2yrWIyr1Dur97WryfCrW7
	Xrs5ArWrG3W7Z3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=

On 2025/12/9 下午5:34, Chenghao Duan wrote:
> There are two methods to jump into the trampoline code for execution:
> 1. ftrace-managed.
> 2. Direct call.
> 
> Whether ftrace-managed or direct jump, ensure before trampoline entry:
> t0=parent func return addr, ra=traced func return addr.
> When managed by ftrace, the trampoline code execution flow utilizes
> ftrace direct call, and it is required to ensure that the original
> data in registers t0 and ra is not modification.
> 
> samples/ftrace/ftrace-direct_xxxx.c: update test code for ftrace direct
> call (modify together).
> 
> Trampoline: adjust jump logic to use t0 (parent func return addr) and
> ra (traced func return addr) as jump targets for respective scenarios
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

When several people work on a single patch, please use the tag:
"Co-developed-by", for more info please see:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>   arch/loongarch/kernel/mcount_dyn.S          | 14 +++++---
>   arch/loongarch/net/bpf_jit.c                | 37 +++++++++++++++------
>   samples/ftrace/ftrace-direct-modify.c       |  8 ++---
>   samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
>   samples/ftrace/ftrace-direct-multi.c        |  4 +--
>   samples/ftrace/ftrace-direct-too.c          |  4 +--
>   samples/ftrace/ftrace-direct.c              |  4 +--
>   7 files changed, 50 insertions(+), 29 deletions(-)

Thanks for the patch, it is good news.

Please split this patch into three parts:
(1) ftrace code
(2) sample test
(3) bpf code
and use proper patch subject and commit message for each patch.

Thanks,
Tiezhu



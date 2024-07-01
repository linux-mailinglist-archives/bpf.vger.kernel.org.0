Return-Path: <bpf+bounces-33467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A591D80A
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B8C1F21E13
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634E5028C;
	Mon,  1 Jul 2024 06:22:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134239FCE;
	Mon,  1 Jul 2024 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719814973; cv=none; b=p0EA/vwfhux8HgwKpX2oy99T2nOnNFeZSR8DCXxaAeWY5Nd68mC5FdsIdYiK7+KsmnUApUms+3vgCuJCEq1RPfbDM6UzYyfyXv3EkQP61ztSCvCVKK/LFEX8YMKnr4yoey80N4B7XTFOjksSR7qm3ROH+YSrbyRYVb9J+1KYnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719814973; c=relaxed/simple;
	bh=vodbmlWePU0fqHsCtlWb2D6JH4N4gZ0QSc01Jd4e3VY=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r6lxDOxqY9VohflqiOJl7PkNIAr7T1pHfZ4uphHZrBSVzDhbkUJdlcG2ItyYZYZiFxU/019YVMmbbLH6KlWFD9KOmEg8QaIKB5bs9FwRAqsIh00EPnXBJTuunK65uLoglgWIhc3JE1/zLdXsb66jUWqF5vNhnVqBvKrsYnRoKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxi7o4S4JmMc8LAA--.1787S3;
	Mon, 01 Jul 2024 14:22:48 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxMMQ2S4Jmriw3AA--.26764S3;
	Mon, 01 Jul 2024 14:22:47 +0800 (CST)
Subject: Re: [PATCH] LoongArch: make the users of larch_insn_gen_break()
 constant
To: Oleg Nesterov <oleg@redhat.com>, Huacai Chen <chenhuacai@kernel.org>
References: <20240627173806.GC21813@redhat.com>
 <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
 <20240629133747.GA4504@redhat.com>
 <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
 <20240629150313.GB4504@redhat.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, bpf@vger.kernel.org,
 jolsa@kernel.org, kernel@xen0n.name, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 mhiramat@kernel.org, nathan@kernel.org, rostedt@goodmis.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0ed72555-372a-64ff-5d0e-a6567650bd91@loongson.cn>
Date: Mon, 1 Jul 2024 14:22:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240629150313.GB4504@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8DxMMQ2S4Jmriw3AA--.26764S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww17tF13Kr43Kr4rZr1DurX_yoW8Xry8pa
	nFyr43urs8J3ykJryDXw15ZFyxAw4kGw42grsIy3y5Gay5XwnxGFy8Wr47JryYvryrKay8
	ta1vg3y2qa4UArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==

On 06/29/2024 11:03 PM, Oleg Nesterov wrote:
> LoongArch defines UPROBE_SWBP_INSN as a function call and this breaks
> arch_uprobe_trampoline() which uses it to initialize a static variable.
>
> Add the new "__builtin_constant_p" helper, __emit_break(), and redefine
> the current users of larch_insn_gen_break() to use it.
>
> The patch adds check_emit_break() into kprobes.c and uprobes.c to test
> this change. They can be removed if LoongArch boots at least once, but
> otoh these 2 __init functions will be discarded by free_initmem().
>
> Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20240614174822.GA1185149@thelio-3990X/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Tested on LoongArch machine with Loongson-3A5000 and Loongson-3A6000
CPU, based on 6.10-rc3,

KPROBE_BP_INSN == larch_insn_gen_break(BRK_KPROBE_BP)
KPROBE_SSTEPBP_INSN == larch_insn_gen_break(BRK_KPROBE_SSTEPBP)
UPROBE_SWBP_INSN  == larch_insn_gen_break(BRK_UPROBE_BP)
UPROBE_XOLBP_INSN == larch_insn_gen_break(BRK_UPROBE_XOLBP)

The two functions check_emit_break() can be removed in
arch/loongarch/kernel/kprobes.c and arch/loongarch/kernel/uprobes.c

Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu



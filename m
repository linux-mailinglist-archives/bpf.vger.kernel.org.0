Return-Path: <bpf+bounces-5784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7679C760455
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88F71C20CA5
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBDF15B6;
	Tue, 25 Jul 2023 00:52:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3387C
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:52:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E5EA171E;
	Mon, 24 Jul 2023 17:52:05 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxTeuzHL9kr3wJAA--.18382S3;
	Tue, 25 Jul 2023 08:52:03 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXSOyHL9kwvM5AA--.6637S3;
	Tue, 25 Jul 2023 08:52:03 +0800 (CST)
Subject: Re: LoongArch: Add BPF JIT support
To: "Colin King (gmail)" <colin.i.king@gmail.com>
References: <bcf97046-e336-712a-ac68-7fd194f2953e@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 "bpf@vger.kernel.org >> bpf" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9ce766dd-4bd9-d4a0-6da5-a29af7d9aa28@loongson.cn>
Date: Tue, 25 Jul 2023 08:52:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bcf97046-e336-712a-ac68-7fd194f2953e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8BxXSOyHL9kwvM5AA--.6637S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7XF4kJryxWrW7AFyxZw4UZFc_yoW8JF1rpF
	Z3ua17AryIgF17u3ZrJr45WF4UtrWfGw48Wa1UJ348uFn8Wrn2vw1Ig3yUAF97Xa15ta4S
	qr42k3sFgFW8GabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
	UUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Colin,

On 07/24/2023 08:27 PM, Colin King (gmail) wrote:
> Hi,
>
> Static analysis with clang scan build on arch/loongarch/net/bpf_jit.h
> has detected a potential issue with the following commit:
>
> commit 5dc615520c4dfb358245680f1904bad61116648e
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date:   Wed Oct 12 16:36:20 2022 +0800
>
>     LoongArch: Add BPF JIT support
>
> This issue is as follows:
>
> arch/loongarch/net/bpf_jit.h:153:23: warning: Logical disjunction always
> evaluates to true: imm_51_31 != 0 || imm_51_31 != 0x1fffff.
> [incorrectLogicOperator]
>    if (imm_51_31 != 0 || imm_51_31 != 0x1fffff) {

Thanks for your report.

>
>
> The statement seems to be always true. I suspect it should it be instead:
>
>    if (imm_51_31 != 0 && imm_51_31 != 0x1fffff) {

Yes, you are right. It is same with

if (!(imm_51_31 == 0 || imm_51_31 == 0x1fffff)) {

As the code comment says, the initial aim is to reduce one instruction
in some corner cases, if bit[51:31] is all 0 or all 1, no need to call
lu32id, that is to say, it should call lu32id only if bit[51:31] is not
all 0 and not all 1. The current code always call lu32id, the result is
right but the logic is unexpected and wrong.

I will send a patch to fix it as soon as possible.

Thanks,
Tiezhu



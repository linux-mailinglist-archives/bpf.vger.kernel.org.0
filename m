Return-Path: <bpf+bounces-18671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426EF81E6E0
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 11:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BB6282ED6
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5114E1A1;
	Tue, 26 Dec 2023 10:15:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D724D594;
	Tue, 26 Dec 2023 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxPIfQp4plmsEEAA--.387S3;
	Tue, 26 Dec 2023 18:15:44 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXOTNp4plEiMLAA--.41447S3;
	Tue, 26 Dec 2023 18:15:41 +0800 (CST)
Subject: Re: [PATCH] MAINTAINERS: Add BPF JIT for LOONGARCH entry
To: Huacai Chen <chenhuacai@kernel.org>
References: <20231225090730.6074-1-yangtiezhu@loongson.cn>
 <CAAhV-H4J6qRcC-nwJfVzoQYhOPKAMZmq=3xWuDpgdLrw4A2SPg@mail.gmail.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e9f3c6c3-69f6-621c-92a2-9786f09fe3d6@loongson.cn>
Date: Tue, 26 Dec 2023 18:15:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4J6qRcC-nwJfVzoQYhOPKAMZmq=3xWuDpgdLrw4A2SPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXOTNp4plEiMLAA--.41447S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw1rZFWrGw4rAw1UAFy7Arc_yoW8XF1rpw
	48AFs8ArWkGr1xA3ZrK39avasIqrykCr92ga9Fk395ArnxZw43Gr18Xwn8uFW0qa10kFWI
	vrn2934Sqa15JacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25Ef
	UUUUU



On 12/26/2023 12:05 PM, Huacai Chen wrote:
> Also list the loongarch maillist? See the "KERNEL VIRTUAL MACHINE FOR
> MIPS (KVM/mips)" entry.

I think it is not necessary, it is duplicate.

Because this file is used for get_maintainer.pl, and arch/loongarch/net/
is a subdirectory of arch/loongarch, so when execute the command

   ./scripts/get_maintainer.pl -f arch/loongarch/net/

the outputs will include both bpf@ and loongarch@ maillists automatically.

Thanks,
Tiezhu

> Huacai
>
> On Mon, Dec 25, 2023 at 5:08 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> After commit 5dc615520c4d ("LoongArch: Add BPF JIT support"),
>> there is no BPF JIT for LOONGARCH entry, in order to maintain
>> the current code and the new features timely, just add it.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7cef2d2ef8d7..3ba07b212d38 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3651,6 +3651,13 @@ L:       bpf@vger.kernel.org
>>  S:     Supported
>>  F:     arch/arm64/net/
>>
>> +BPF JIT for LOONGARCH
>> +M:     Tiezhu Yang <yangtiezhu@loongson.cn>
>> +R:     Hengqi Chen <hengqi.chen@gmail.com>
>> +L:     bpf@vger.kernel.org
>> +S:     Maintained
>> +F:     arch/loongarch/net/
>> +
>>  BPF JIT for MIPS (32-BIT AND 64-BIT)
>>  M:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
>>  M:     Paul Burton <paulburton@kernel.org>
>> --
>> 2.42.0
>>
>>



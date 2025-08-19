Return-Path: <bpf+bounces-66013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0771B2C63C
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 15:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48186726491
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5CF341ACD;
	Tue, 19 Aug 2025 13:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2BA322DD7
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611423; cv=none; b=eAmcdFt66Xj588t0nYIOUypWLdyv+xKARcRPBRsNsU3t2BxO8l9TGUsHJ25859AO9WuNpuxE2SietP/S+rlmFPsauRVpDVez/HvfFaDx2A+BkpsSxGj5JKvajaQNcDPtzptp4ujOEUNJiqH1D5h25763UDoiHajedIgjedu9Dis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611423; c=relaxed/simple;
	bh=qUd78w5HqrhKX6ARFrGvyF+FpiEPI8H1+G4pb/MMhKc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IbEsnVS2oD2XbowO1bC9mMHA+rCyvhQEJEambAY6u/1m/VCb75RRX+ko0dTjq2N5D74BU+HjJ4CDdMJsZl862+DBcf22oJ8M8yIPVJdgokrDzTHmv3rq4e6PT0xB3dabpGKPLRNFaAgBvsx79jiewuNvPrc5mQNA1p4pHX/H6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx3tIXgaRokWkAAA--.760S3;
	Tue, 19 Aug 2025 21:50:15 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxTMEVgaRo42JYAA--.20527S3;
	Tue, 19 Aug 2025 21:50:13 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: BPF: Fix incorrect return pointer value in
 the eBPF program
To: Huacai Chen <chenhuacai@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Haoran Jiang <jianghaoran@kylinos.cn>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, kernel@xen0n.name, hengqi.chen@gmail.com,
 jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org,
 john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, ast@kernel.org,
 Jinyang He <hejinyang@loongson.cn>
References: <20250815082931.875216-1-jianghaoran@kylinos.cn>
 <720482db-17de-4831-b64a-0ae3fd7fa5a5@iogearbox.net>
 <CAAhV-H5GxL159jSD1V6G7JZVXasESVFr02Jj=h+mYUU2374N6g@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <715bff59-64e4-2bc4-038e-e4595ad3dcff@loongson.cn>
Date: Tue, 19 Aug 2025 21:50:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5GxL159jSD1V6G7JZVXasESVFr02Jj=h+mYUU2374N6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxTMEVgaRo42JYAA--.20527S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurWfJw45AF1fAw18Cry7XFc_yoWxKFc_Ca
	4Uu34kC34kZF4UAF1DKan0vFWDXan5Kr1ktrW8JrZrZF95XF98Ar42grn2y3y7XFZ5tan7
	ur909rWavr9F9osvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1l
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8loGPUUUUU==

On 2025/8/19 下午5:06, Huacai Chen wrote:
> On Tue, Aug 19, 2025 at 4:24 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 8/15/25 10:29 AM, Haoran Jiang wrote:
>>> In some eBPF programs, the return value is a pointer.
>>> When the kernel call an eBPF program (such as struct_ops),
>>> it expects a 64-bit address to be returned, but instead a 32-bit value.

...

>> Huacai, are you routing the fix or want us to route via bpf tree?
> I will take it, but I'm waiting Tiezhu's Ack now.

This version has problem, with this patch, many test cases failed
when executing "sudo modprobe test_bpf", the root cause is related
with the instruction "sra.d", I will give a detail reply tomorrow.

Thanks,
Tiezhu



Return-Path: <bpf+bounces-71664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E22BF9C96
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 05:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4923BB554
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FF22333D;
	Wed, 22 Oct 2025 03:08:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F417A1D5CF2
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102520; cv=none; b=FJ8eRaR1ARFPMn9OuW+xBvpnJIpIblUa2GmzUUXEaR5uUhGJasyUGP20MN7OQ39xfPhVdIMqa0VQvCvVfKn1F5PVoKbQ/u/x1RWKXv+d7/2Ih/GCAWVxuSEDrYzKmozAoYQurKrfJUR9JWST3C8iDR1Qh2EevHh4ng4HBx7FSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102520; c=relaxed/simple;
	bh=W71ULqXltVbyDiIfTRMV6bTV6Dqcj6NPio0lpVPrJCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMpX7K2hw2iAgmMH3aWEIgUFhG6Ywv5I2++2fZgj9zKlDyBzcE6Ob+p5Wrk2t0nWgqGwCUiY/4IzUBLzUgtItoMgWkdF57JUtBSN68OIBu2ZBJTRdnKnMY+91Gegjh2SSdjFvO6Vigk8pNV2Xvk//r0jcZkvblatA6xzw9eh8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAAnqMiHSvhokSO6BA--.58573S2;
	Wed, 22 Oct 2025 11:07:51 +0800 (CST)
Received: from [58.206.214.186] (unknown [58.206.214.186])
	by gateway (Coremail) with SMTP id _____wA38kiHSvhoB84HAA--.2679S2;
	Wed, 22 Oct 2025 11:07:51 +0800 (CST)
Message-ID: <7b86d9eb-313d-4a3e-8547-6a8c1ec2caaf@hust.edu.cn>
Date: Wed, 22 Oct 2025 11:07:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Information Leakage via Type Confusion in bpf_snprintf_btf()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 dzm91@hust.edu.cn, M202472210@hust.edu.cn,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <636d45a8-cdc4-46ce-b1cb-6d2e4e3226ae@hust.edu.cn>
 <CAADnVQLFuMAYHXXd_=2ebnhsE_tECKrVcLwuOt9b0dK4-Ww+gQ@mail.gmail.com>
 <034fed44-2640-4338-8f7a-89a4c9c4af6f@hust.edu.cn>
 <CAADnVQJ4HeTzm+2DNSFG83HF01OxN98QLXZ_zUVThsMzSF6=CA@mail.gmail.com>
From: Yinhao Hu <dddddd@hust.edu.cn>
In-Reply-To: <CAADnVQJ4HeTzm+2DNSFG83HF01OxN98QLXZ_zUVThsMzSF6=CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAAnqMiHSvhokSO6BA--.58573S2
Authentication-Results: app1; spf=neutral smtp.mail=dddddd@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xXFW7AFyfAF4DXr43KFg_yoW8JF4DpF
	y0yF40y3WDtFsavwn29ay09a4YyFn2g3sxJr95JFyqkrsxuw1fur4Ikr4akF98Cw10yry0
	v3yDWFySgF1qyw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmYb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUVBHqDUUUU
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/

On 10/22/25 10:20 AM, Alexei Starovoitov wrote:
> On Tue, Oct 21, 2025 at 6:42 PM Yinhao Hu <dddddd@hust.edu.cn> wrote:
>>
>> Hi,
>>
>> Thank you for reviewing our report.
>> We have verified the content in the report. Could you please point out
>> which specific part caused confusion? We would be happy to provide
>> additional details or clarification.
> 
> Do not top-post.
> 
> Am I talking to a person or an AI bot?
> 
> Did you read what you wrote: "programs with `CAP_SYS_ADMIN`
> to leak kernel memory" and that made sense to you?

Apologies for the misnomer, it means that if the PoC is granted the
CAP_SYS_ADMIN capability, it can trigger the vulnerability and cause
information leakage.

> 
>> On 10/22/25 2:08 AM, Alexei Starovoitov wrote:
>>> On Sun, Oct 19, 2025 at 8:24 PM Yinhao Hu <dddddd@hust.edu.cn> wrote:
>>>>
>>>> Our fuzzer tool discovered a type confusion vulnerability in the
>>>> `bpf_snprintf_btf()` helper function within the Linux kernel's BPF
>>>> subsystem. This vulnerability allows BPF programs with `CAP_SYS_ADMIN`
>>>> to leak kernel memory by constructing fake `btf_ptr` structures with
>>>> user-controlled addresses.
>>>
>>> Do you proofread what AI generates for you?
>>> Please do. It's hard to take your reports seriously.
>>
>>



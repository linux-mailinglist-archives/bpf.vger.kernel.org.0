Return-Path: <bpf+bounces-75063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A95FDC6E915
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 13:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DA993A2685
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F3C358D07;
	Wed, 19 Nov 2025 12:36:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311F1A7AE3;
	Wed, 19 Nov 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555769; cv=none; b=Pp1RWT04dAHEfec2Fom0kdlR/zxCO2qfiDCdf07h5e+Q+ls2mCYoPV/K8Ja6G0fMcVNEa7gJf4SWGroSIMqWXsYj6mNMokm9aNvg6lYZ9zgPjWTKOxhvYjmPWt7CljPFoWI+RTCgLng1l3Sirn0qEiVfcTnRNMM7c6YDsYhJSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555769; c=relaxed/simple;
	bh=JxKNgjOuwxD41VzXOAYAfjTnv/LNJPKYzm3Ou1xeJYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayqKUadOwMksCriH0GGwnELLqYAoScjEsCXxzi8AsO4pInLSh2wJIWFRejGL+EWDgGpnJV472lfj9giACv3iGOj6Q0hgTxVGYEHo0Qlxew4j41DcU61tgaJySvX4AORHCqzSAu+NtIw5DMXXJQCNNoEXyH+OQooz0AqqNw5nlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dBLYK5GkRzKHMk5;
	Wed, 19 Nov 2025 20:35:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D9D4B1A0359;
	Wed, 19 Nov 2025 20:36:01 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgA3YV6wuR1pZBQqBQ--.21495S2;
	Wed, 19 Nov 2025 20:36:01 +0800 (CST)
Message-ID: <5f4d0bf9-9c74-44ce-8f29-c43fa5e8810a@huaweicloud.com>
Date: Wed, 19 Nov 2025 20:36:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, Menglong Dong
 <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <CAADnVQJF5qkT8J=VJW00pPX7=hVdwn2545BzZPEi=mPwFouThw@mail.gmail.com>
 <8606158.T7Z3S40VBb@7950hx> <97c8e49c-ca27-40ec-8ff6-18b1b9061240@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <97c8e49c-ca27-40ec-8ff6-18b1b9061240@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3YV6wuR1pZBQqBQ--.21495S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1fXr4rWryfCFyUury8Krg_yoW8Gr45pa
	y5JayqkF4kZrs5A3ZxKw47XF1Sy3yfKrs8Wrn5Jr47Cas0vr9rKF42krWj9Fy3uryFgF4a
	vrWUu343XF4rArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 11/19/2025 10:55 AM, Leon Hwang wrote:
> 
> 
> On 19/11/25 10:47, Menglong Dong wrote:
>> On 2025/11/19 08:28, Alexei Starovoitov wrote:
>>> On Tue, Nov 18, 2025 at 4:36 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>>>
>>>> As we can see above, the performance of fexit increase from 80.544M/s to
>>>> 136.540M/s, and the "fmodret" increase from 78.301M/s to 159.248M/s.
>>>
>>> Nice! Now we're talking.
>>>
>>> I think arm64 CPUs have a similar RSB-like return address predictor.
>>> Do we need to do something similar there?
>>> The question is not targeted to you, Menglong,
>>> just wondering.
>>
>> I did some research before, and I find that most arch
>> have such RSB-like stuff. I'll have a look at the loongarch
>> later(maybe after the LPC, as I'm forcing on the English practice),
>> and Leon is following the arm64.
> 
> Yep, happy to take this on.
> 
> I'm reviewing the arm64 JIT code now and will experiment with possible
> approaches to handle this as well.
>

Unfortunately, the arm64 trampoline uses a tricky approach to bypass BTI
by using ret instruction to invoke the patched function. This conflicts
with the current approach, and seems there is no straightforward solution.

> Thanks,
> Leon
> 
>>
>> For the other arch, we don't have the machine, and I think
>> it needs some else help.
>>
>> Thanks!
>> Menglong Dong
> 
> 
> 



Return-Path: <bpf+bounces-64446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C0B12C03
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 21:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92757A68EB
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8C289355;
	Sat, 26 Jul 2025 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="kwWvBdgx"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22367288C93;
	Sat, 26 Jul 2025 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753557258; cv=none; b=JKCn9l+1W8dF/KigZfmG5Ti5LwbPT11hqsSDQH4JqiIpEy7FP+Q4uILf6KbcwhhCXCoI+uQkg1+1ztO1D2AdVGgOBPUX45Jl6hpGsl8jQqNAdQJzus04XsDCIOr+6iAhOZgiLTiRcZaoG8jGJ0T6fPqfHSb7aTfhrLwEw1pL7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753557258; c=relaxed/simple;
	bh=dCCYcb3UvTArvkXljVmXdw7tO+ynw48FiObqCacVNUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYDXF/b0nE3UYFOQtVtfy335NKfGFjqpOtAentaBAXM3bNGQU8T0+4SBU5kdrNEKYRnji0rOUsX+TvAnps4CYP9gu+R7nupQ6bGNltVLZvQye3QnB2W1AlPPcxudqFIAAA0+boK4LOib4s9hyyxy2rQynp/z0qNakIo1KZhFvnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=kwWvBdgx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XWUou2efvAlWAEjRwH8gexVt2F0I9SXQQfpMgUqKfjY=; b=kwWvBdgxftZfz0jSRoSqBlUyl/
	C2oVF4AJ/EVFdHW6v0tyzHklJoqm55c1tThbAyRFAhmWQ5V8R93VC1lXZd5YgJ0N8QKb2vNdS3zW3
	6+wVkN/BJSBoxWXX0s34LMWp7mijS+fNsTc7akeL80FapKf23lC/JoEe+3Jf0QQZ5eM2qCuV94dFT
	Gir614J1ByOHVk2RC0Ry9CkKlma4XLH00wQRGGSqPQFQAv91PwnNS5dnqZrjAC19P2hP7QLEjsOXm
	7jyk86LOPORBmWhmx6Tz3K/6q4Qc9R1eGdI9EZsMMPlbWxLx/ovFIdefalJ2Xa0SvCR2ZE4kkn6pm
	4OUEUDbQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ufkLL-000PkK-24;
	Sat, 26 Jul 2025 21:14:03 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1ufkLK-0001eW-1Z;
	Sat, 26 Jul 2025 21:14:02 +0200
Message-ID: <dbba4e43-c32d-4430-b3e5-7711f24ea4e3@iogearbox.net>
Date: Sat, 26 Jul 2025 21:14:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Support trampoline for LoongArch
To: Chenghao Duan <duanchenghao@kylinos.cn>,
 Vincent Li <vincent.mc.li@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, yangtiezhu@loongson.cn,
 hengqi.chen@gmail.com, chenhuacai@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
 jianghaoran@kylinos.cn
References: <20250724141929.691853-1-duanchenghao@kylinos.cn>
 <CAK3+h2zirm6cV2tAbd38RSYSF3=B1qZ+9jm_GZPsAPrMtaozmg@mail.gmail.com>
 <20250725101857.GA20688@chenghao-pc>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20250725101857.GA20688@chenghao-pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27711/Sat Jul 26 10:35:43 2025)

On 7/25/25 12:18 PM, Chenghao Duan wrote:
> On Thu, Jul 24, 2025 at 08:30:35AM -0700, Vincent Li wrote:
>> On Thu, Jul 24, 2025 at 7:19 AM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
>>>
>>> v4:
>>> 1. Delete the #3 patch of version V3.
>>>
>>> 2. Add 5 NOP instructions in build_prologue().
>>>     Reserve space for the move_imm + jirl instruction.
>>>
>>> 3. Differentiate between direct jumps and ftrace jumps of trampoline:
>>>     direct jumps skip 5 instructions.
>>>     ftrace jumps skip 2 instructions.
>>>
>>> 4. Remove the generation of BL jump instructions in emit_jump_and_link().
>>>     After the trampoline ends, it will jump to the specified register.
>>>     The BL instruction writes PC+4 to r1 instead of allowing the
>>>     specification of rd.
>>>
>>> -----------------------------------------------------------------------
>>> Historical Version:
>>> v3:
>>> 1. Patch 0003 adds EXECMEM_BPF memory type to the execmem subsystem.
>>>
>>> 2. Align the size calculated by arch_bpf_trampoline_size to page
>>> boundaries.
>>>
>>> 3. Add the flush icache operation to larch_insn_text_copy.
>>>
>>> 4. Unify the implementation of bpf_arch_xxx into the patch
>>> "0004-LoongArch-BPF-Add-bpf_arch_xxxxx-support-for-Loong.patch".
>>>
>>> 5. Change the patch order. Move the patch
>>> "0002-LoongArch-BPF-Update-the-code-to-rename-validate_.patch" before
>>> "0005-LoongArch-BPF-Add-bpf-trampoline-support-for-Loon.patch".
>>>
>>> URL for version v3:
>>> https://lore.kernel.org/all/20250709055029.723243-1-duanchenghao@kylinos.cn/
>>> ---------
>>> v2:
>>> 1. Change the fixmap in the instruction copy function to set_memory_xxx.
>>>
>>> 2. Change the implementation method of the following code.
>>>          - arch_alloc_bpf_trampoline
>>>          - arch_free_bpf_trampoline
>>>          Use the BPF core's allocation and free functions.
>>>
>>>          - bpf_arch_text_invalidate
>>>          Operate with the function larch_insn_text_copy that carries
>>>          memory attribute modifications.
>>>
>>> 3. Correct the incorrect code formatting.
>>>
>>> URL for version v2:
>>> https://lore.kernel.org/all/20250618105048.1510560-1-duanchenghao@kylinos.cn/
>>> ---------
>>> v1:
>>> Support trampoline for LoongArch. The following feature tests have been
>>> completed:
>>>          1. fentry
>>>          2. fexit
>>>          3. fmod_ret
>>>
>>> TODO: The support for the struct_ops feature will be provided in
>>> subsequent patches.
>>>
>>> URL for version v1:
>>> https://lore.kernel.org/all/20250611035952.111182-1-duanchenghao@kylinos.cn/
>>> -----------------------------------------------------------------------
>>>
>>> Chenghao Duan (4):
>>>    LoongArch: Add larch_insn_gen_{beq,bne} helpers
>>>    LoongArch: BPF: Update the code to rename validate_code to
>>>      validate_ctx
>>>    LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
>>>    LoongArch: BPF: Add bpf trampoline support for Loongarch
>>>
>>> Tiezhu Yang (1):
>>>    LoongArch: BPF: Add struct ops support for trampoline
>>>
>>>   arch/loongarch/include/asm/inst.h |   3 +
>>>   arch/loongarch/kernel/inst.c      |  60 ++++
>>>   arch/loongarch/net/bpf_jit.c      | 521 +++++++++++++++++++++++++++++-
>>>   arch/loongarch/net/bpf_jit.h      |   6 +
>>>   4 files changed, 589 insertions(+), 1 deletion(-)
>>>
>>> --
>>> 2.25.1
>>>
>>
>> Tested the whole patch series and it resolved the xdp-tool xdp-filter issue
>>
>> [root@fedora ~]# xdp-loader status
>> CURRENT XDP PROGRAM STATUS:
>>
>> Interface        Prio  Program name      Mode     ID   Tag
>>    Chain actions
>> --------------------------------------------------------------------------------------
>> lo                     xdp_dispatcher    skb      53   4d7e87c0d30db711
>>   =>              10     xdpfilt_alw_all           62
>> 320c53c06933a8fa  XDP_PASS
>> dummy0                 <No XDP program loaded!>
>> sit0                   <No XDP program loaded!>
>> enp0s3f0               <No XDP program loaded!>
>> wlp3s0                 <No XDP program loaded!>
>>
>> you can add Tested-by: Vincent Li <vincent.mc.li@gmail.com>
> 
> Hi Vincent,
> 
> Okay, thank you very much for your support. The existing patch has
> included "Tested-by: Vincent Li vincent.mc.li@gmail.com".

Huacai, I presume you'll route this series to Linus, correct?

Thanks,
Daniel


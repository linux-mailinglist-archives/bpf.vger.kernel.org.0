Return-Path: <bpf+bounces-56477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A4A97C89
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 03:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514C116F32F
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D7264FB0;
	Wed, 23 Apr 2025 01:51:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B42701DB;
	Wed, 23 Apr 2025 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745373110; cv=none; b=AeQczy7dHAcKPdVdH0Cotkb1TlCdJxNwSwoncnQhNtkxDnG5P2fSTA/9apcm2+vFafDiu5GgdtcakEsb0DJ9oZvMqnzooze8R4K1WLYQ+uSlzpvkJe2wyVaq9OfXoUiz/B23rXcQOGniXBW1IHvdWeGW4LT2tg6uP42z2rOL/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745373110; c=relaxed/simple;
	bh=524B77zUmQ8K7a2shf7Mu+7jo//vmdRuMIeZyo4ImCM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jYITZtkp+7yaIKxwAbG4LhbrUiT0p58JSaKTRJqHRwDbkJKF9WLG2x5AIUlVUa318MObPBQJh+MMPgv36uPBeETjOatg2wXMS5rXDK1HEZS/r30bj5uxbP95fvwxGsU6q8ngVmnBnLVW0rRfh6PcxOgcBhbpjOXKRYwyXGmFmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxaWpaRwhoIWLEAA--.65011S3;
	Wed, 23 Apr 2025 09:50:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMCxrhtYRwhooO2QAA--.47758S3;
	Wed, 23 Apr 2025 09:50:18 +0800 (CST)
Subject: Re: BUG: bpf test case fails to run on LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
References: <32989acf-93ef-b90f-c3ba-2a3c07dee4a3@loongson.cn>
 <8cd87100-88f3-687d-6704-f4fec0ca48b3@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <c9d7be2b-8c2d-bd5e-b32d-37ed4bb693cc@loongson.cn>
Date: Wed, 23 Apr 2025 09:49:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8cd87100-88f3-687d-6704-f4fec0ca48b3@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxrhtYRwhooO2QAA--.47758S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1xJry3XF15ZF1ftF4UJrc_yoW8Jw1UpF
	ZxtryfKw1Yga40qr10qa10yF9YyFsay3y5AryUJ34kGrs5Ar1qqF18Jr1Svr93tryv9rWU
	A3y0qan0kwnrJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUrNtxDUUUU



On 2025/4/23 上午9:28, Tiezhu Yang wrote:
> On 04/21/2025 10:52 AM, bibo mao wrote:
>> Hi,
>>
>> When I run built-in bpf test case with lib/test_bpf.c,
>> it reports such error, I do not know whether it is a problem.
>>
>>  test_bpf: #843 ALU32_RSH_X: all shift values jited:1 239 PASS
>>  test_bpf: #844 ALU32_ARSH_X: all shift values jited:1 237 PASS
>>  test_bpf: #845 ALU64_LSH_X: all shift values with the same register
>>  ------------[ cut here ]------------
>>  kernel BUG at lib/test_bpf.c:794!
> 
> This is a known issue I have ever encountered.
> I guess your GCC version is 14.1, this is a bug of GCC,
yes, My gcc version is 14.1

> it has been fixed in the higher version, you can update
> you GCC version (14.2+).
OK, I will update my gcc. And sorry for the noise.

Regards
Bibo Mao
> 
> $ gcc --version | head -1
> gcc (GCC) 14.2.1 20241104
> $ dmesg -t | grep Summary
> test_bpf: Summary: 1053 PASSED, 0 FAILED, [0/1041 JIT'ed]
> test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [0/10 JIT'ed]
> test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> test_bpf: Summary: 1053 PASSED, 0 FAILED, [1041/1041 JIT'ed]
> test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> 
> Thanks,
> Tiezhu
> 



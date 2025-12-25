Return-Path: <bpf+bounces-77438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6608CDDB81
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48443019B73
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEAF31AAA5;
	Thu, 25 Dec 2025 11:46:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27D2236E0;
	Thu, 25 Dec 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766663202; cv=none; b=qqz8zZwGmedkdBxlLSnwmcE/5QZS7K3CtelBC+3uhzQB38Z0wMKv+IShT7t7mHwa+0DutkzPwhJWf5ZXVO1AHZx8x32Zn2nTgizmKE4vlykC8/1xB4XL1hkFNvDTL/CgkXKWNPBH+2fYz2tP6lXEX3Yr/Aj9wRPla2GSJx7fXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766663202; c=relaxed/simple;
	bh=RYXFytXrD/F0eNxw51uXP38SO5ODlW0Ufy6oYCUMK88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxTWBs/EJHAhHQ73OC58GJfaFTviF9t5PvEwdL9XwuZLa/14ZUu9D/w2zYaFutgBv/+vmLknb2EF0h9rw2CZZzXm6hdaW+x0CsXr/Hy8EWsvKw8NQgJC69xmt0qCU781T25F6a9XJhFxalHSVZPstU0hB9p3O90vIauO3eB+4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcRlq53r4zKHMXh;
	Thu, 25 Dec 2025 19:46:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 001E440570;
	Thu, 25 Dec 2025 19:46:36 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgA35vYZJE1pTNK6BQ--.65183S2;
	Thu, 25 Dec 2025 19:46:34 +0800 (CST)
Message-ID: <4287f839-d713-44d5-afa0-918f2a44c5c3@huaweicloud.com>
Date: Thu, 25 Dec 2025 19:46:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Content-Language: en-US
To: Anton Protopopov <a.s.protopopov@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251223085447.139301-1-xukuohai@huaweicloud.com>
 <15c26b1f-b78d-45d0-b5d2-e8359ddf5bbc@linux.dev>
 <aU0aW3VE1a8FI0Xm@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <aU0aW3VE1a8FI0Xm@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA35vYZJE1pTNK6BQ--.65183S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1DZw13CF4UKr4UXF1DKFg_yoWkXFXE93
	yDCF4xGr47Grn8Xw1v9FZ7KFy5Kw1Ikr97Z3WDuFy7WFnIy34kCr1vkF9rXa4Skws5Jrnr
	AFnagayfuF4fZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/25/2025 7:04 PM, Anton Protopopov wrote:

[...]

>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index da6a00dd313f..a3a89d4b4dae 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -3875,13 +3875,32 @@ void bpf_insn_array_release(struct bpf_map *map);
>>>    void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
>>>    void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
>>> +enum bpf_insn_array_type {
>>> +	BPF_INSN_ARRAY_VOID,
>>
>> What is the purpose for BPF_INSN_ARRAY_VOID? Do we really need it?
> 
> There seems to be no need for a name for the default case,
> but BPF_INSN_ARRAY_JUMP_TABLE should be != 0, so can be just
>
> enum bpf_insn_array_type {
> 	BPF_INSN_ARRAY_JUMP_TABLE = 1,
> };
>

Having only BPF_INSN_ARRAY_JUMP_TABLE feels incomplete, since there
would be no enum value to indicate an instruction array without a
specific purpose, like the insn_arrays created in selftests [1].

[1] https://lore.kernel.org/bpf/20251105090410.1250500-5-a.s.protopopov@gmail.com/

[...]



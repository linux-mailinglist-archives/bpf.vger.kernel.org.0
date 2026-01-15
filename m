Return-Path: <bpf+bounces-78990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29071D22EA9
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C50303ADC0
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048C2BDC26;
	Thu, 15 Jan 2026 07:47:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77F27732;
	Thu, 15 Jan 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463251; cv=none; b=T5TkmCnPB/fHGmo0ztPb2TKZX/0w3TNNJqwhLi4Ut3EjhJAARFq0MfUsVFNbLT0j+VQT0JEUTC0Jtd0j08qhuqBH2TklBHLvYL5q7CpQqeIr7BN6K9lVs+Kno1kobNQnhcpxP1+VAfUcII9LZGS5h6U9xgbYR5Cv+8ftOtKRycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463251; c=relaxed/simple;
	bh=3+Y8NoDfezFGs2FkAq/2YYEJCg8mFWNei/30bDrBUW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOj+bdYLaeGFq2Lt1/W+dgdSNnn3v0tX0e9j51PY5g2RBtKDlkJrTXMmTgOl2BOViNqA8aH9Vzxp6usCRIOdzhW8Zwjyzy1HIXp7HlUt5l8M/HD1msfYBPP2W9deCAZSEDt2mlHpUOuIgRBsbXbci8s0of6J4nFGmuvwTnRdXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dsFRY33gVzKHMb6;
	Thu, 15 Jan 2026 15:46:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AE2B540572;
	Thu, 15 Jan 2026 15:47:26 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDXQ+mNm2hpyzRFDw--.26048S2;
	Thu, 15 Jan 2026 15:47:26 +0800 (CST)
Message-ID: <21aec5e1-4152-4d51-ad25-91524c544b66@huaweicloud.com>
Date: Thu, 15 Jan 2026 15:47:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Add helper to detect indirect jump
 targets
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
 <20260114093914.2403982-3-xukuohai@huaweicloud.com>
 <2e5ed01463ae8f79780a42c4e7f93baeafd2565a.camel@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <2e5ed01463ae8f79780a42c4e7f93baeafd2565a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXQ+mNm2hpyzRFDw--.26048S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxtF4xuF18Zw1rGw45Wrg_yoW8ZF4Upa
	y7W34YkFWqvFWDKr17ZFW8Aw4aqan8Ww1DJrn8X3yxCryYgrn3KF1vgw4IvF98tr4Yyw1I
	qF4jvr1DZF1UZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 1/15/2026 4:46 AM, Eduard Zingerman wrote:
> On Wed, 2026-01-14 at 17:39 +0800, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Introduce helper bpf_insn_is_indirect_target to determine whether a BPF
>> instruction is an indirect jump target. This helper will be used by
>> follow-up patches to decide where to emit indirect landing pad instructions.
>>
>> Add a new flag to struct bpf_insn_aux_data to mark instructions that are
>> indirect jump targets. The BPF verifier sets this flag, and the helper
>> checks it to determine whether an instruction is an indirect jump target.
>>
>> Since bpf_insn_aux_data is only available before JIT stage, add a new
>> field to struct bpf_prog_aux to store a pointer to the bpf_insn_aux_data
>> array, making it accessible to the JIT.
>>
>> For programs with multiple subprogs, each subprog uses its own private
>> copy of insn_aux_data, since subprogs may insert additional instructions
>> during JIT and need to update the array. For non-subprog, the verifier's
>> insn_aux_data array is used directly to avoid unnecessary copying.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
> 
> Hm, I've missed the fact insn_aux_data is not currently available to jit.
> Is it really necessary to copy this array for each subprogram?
> Given that we still want to free insn_aux_data after program load,
> I'd expect that it should be possible just to pass a pointer with an
> offset pointing to a start of specific subprogram. Wdyt?
>

I think it requires an additional field in struct bpf_prog to record the length
of the global insn_aux_data array. If a subprog inserts new instructions during
JIT (e.g., due to constant blinding), all entries in the array, including those
of the subsequent subprogs, would need to be adjusted. With per-subprog copying,
only the local insn_aux_data needs to be updated, reducing the amount of copying.

However, if you prefer a global array, I’m happy to switch to it.

> [...]



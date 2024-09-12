Return-Path: <bpf+bounces-39676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BD1975E71
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 03:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6345CB213FE
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60932BB09;
	Thu, 12 Sep 2024 01:20:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064F3D0C5
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104035; cv=none; b=Jc3GybVY9GedhTeeG/hKUk8Ia2MVm40nKJeWpajuYIfWSr00Cdb9YsMhkfwwwjUj6AcREUo4CzEaaC6wJKN6s/aPQkcwlONP+iDXtEjFGnSmoL8BD5fwOTevN1diu6h0+65SFlzOqdY5VcLuDoaUA0HkUoJi0MuVS6okLOV2jyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104035; c=relaxed/simple;
	bh=8CimqzjaIxjGH7CV/VCk9O0cd9ngGUCrSxSz6/wRbaM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HBIqgfGPxdiaLPhzZgXy+4l5QVvRGo3e/361+Ckwvj1h0haM+DFxPg2XEPP8cylEv+mQdLxcaRFxWvRrBBD1pKacC9wYQ7ViYRU4tlTkVQ3EpE/7Rs2LIIt45+BCtDWb5hwfYNGH7FEqwBAhf809wxu4pPfp5JHo8TiWX2lFo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X403q2gqFz4f3jrl
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:20:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 72CF21A06D7
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:20:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgA3uMTNQeJmRN9KBA--.52542S2;
	Thu, 12 Sep 2024 09:20:17 +0800 (CST)
Subject: Re: [RESEND][PATCH bpf 1/2] bpf: Check the remaining info_cnt before
 repeating btf fields
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
 <20240911110557.2759801-2-houtao@huaweicloud.com>
 <16794f86fd1030d923e3ab7356c5ff3617b2b193.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <99c3bd09-054a-2c7c-7c6f-f1c613444f1f@huaweicloud.com>
Date: Thu, 12 Sep 2024 09:20:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16794f86fd1030d923e3ab7356c5ff3617b2b193.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgA3uMTNQeJmRN9KBA--.52542S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47Kry7XrW7Cw17Ar45GFg_yoW8Xr13pr
	4fAF1rGF4ktr9xu3WUJFnY9rW3tw1rCw13GFyDKw1Yyan0grn8tFn5Xw4rAFWSkr47AF1F
	yFsFqas0v343urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 9/12/2024 1:37 AM, Eduard Zingerman wrote:
> On Wed, 2024-09-11 at 19:05 +0800, Hou Tao wrote:
>
>
> [...]
>
>> ---
>>  kernel/bpf/btf.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index a4e4f8d43ecf..9a4a074d26f5 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3592,6 +3592,12 @@ static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *
>>  		info[i].off += off;
>>  
>>  	if (nelems > 1) {
>> +		/* The type of struct size or variable size is u32,
>> +		 * so the multiplication will not overflow.
>> +		 */
>> +		if (ret * nelems > info_cnt)
>> +			return -E2BIG;
>> +
>>  		err = btf_repeat_fields(info, ret, nelems - 1, t->size);
>>  		if (err == 0)
>>  			ret *= nelems;
>
> btf_repeat_fields(struct btf_field_info *info,
>                   u32 field_cnt, u32 repeat_cnt, u32 elem_size)
>
> copies field "field_cnt * repeat_cnt" times,
> in this case field_cnt == ret, repeat_cnt == nelems - 1,
> should the check be "ret * (nelems - 1) > info_cnt"?

No. The number of available btf_field_info is info_cnt,
btf_find_struct_field() has already used ret fields, and there are still
ret * (nelems - 1) fields waiting for repetition, so checking ret *
nelems against info_cnt is correct.
>
> I suggest to add info_cnt as a parameter of btf_repeat_fields() and do
> this check there. So that the check won't be forgotten again if
> btf_repeat_fields() is used elsewhere. Wdyt?
Will do in v2.



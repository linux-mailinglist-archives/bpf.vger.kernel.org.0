Return-Path: <bpf+bounces-51515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB5A3558E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B9C3AD4C9
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 04:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA249158D96;
	Fri, 14 Feb 2025 04:04:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4D15749C
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505890; cv=none; b=gyBmgAtdYY5dHpPDZ02YIGrMVoazhTC/q7yho/a0R2WLGAU3euh/12hkA0mGAWgsq87v1uqRdBLuDOgM+964hxAQUie5IR7TEP4RV0UsoA8V4q7bV0jN4Lq6H9cdCbmD2ncnkxFN5yTHUqCoCDUAIOoUvZXHmRz1maoU+GYW5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505890; c=relaxed/simple;
	bh=poxqCgArrGEJ0+ZxfGbXKaYwVIUPTX/uDfC274Hh85Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mqob2/284N096S0MTZMwjWpPda8EPnemXQVnzVHd2zTmYDb4yeQL4E25PdbIJg8Qnmkl3LnxXPlYSRRzVJFNO+HTF0SKCA1gzohSIXM05RqxlsAxdnyP2e78+0beN8wI5nl00YsyvZe2g/doe6YlL+v3ogHoVy+9OSpDTr/PcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YvJMm2646z4f3kvM
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 12:04:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 16D6C1A0B29
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 12:04:43 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgA31sDWwK5n6b72Dg--.37740S2;
	Fri, 14 Feb 2025 12:04:42 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 02/20] bpf: Parse bpf_dynptr in map key
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
 <20250125111109.732718-3-houtao@huaweicloud.com>
 <CAADnVQLOfWZ_5U9ZN4QaQQR1-OHdgDT3GJ1bP-QNPNRZNHbn+A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <25e0116d-a0d5-00f0-ea3a-1269a8601bdc@huaweicloud.com>
Date: Fri, 14 Feb 2025 12:04:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLOfWZ_5U9ZN4QaQQR1-OHdgDT3GJ1bP-QNPNRZNHbn+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgA31sDWwK5n6b72Dg--.37740S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary3GF1kCFyfZrWUJw4xWFg_yoW8WFyDpF
	Z5Jay29r4kGF9Fyws8Xw4fZrZ0yrZ5Gw1UWF10gryUGFyFgFWkCr18CFWFgF13JwsYkr97
	Ja1I9r93Ar95JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/14/2025 1:59 AM, Alexei Starovoitov wrote:
> On Sat, Jan 25, 2025 at 2:59 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> To support variable-length key or strings in map key, use bpf_dynptr to
>> represent these variable-length objects and save these bpf_dynptr
>> fields in the map key. As shown in the examples below, a map key with an
>> integer and a string is defined:

SNIP
>> @@ -271,7 +271,14 @@ struct bpf_map {
>>         u64 map_extra; /* any per-map-type extra fields */
>>         u32 map_flags;
>>         u32 id;
>> +       /* BTF record for special fields in map value. bpf_dynptr is disallowed
>> +        * at present.
>> +        */
> Maybe drop 'at present' to fit on one line.
> I would also capitalize Value to make the difference more obvious...

Will do.
>
>>         struct btf_record *record;
>> +       /* BTF record for special fields in map key. Only bpf_dynptr is allowed
>> +        * at present.
> ...with this line. Key.

Will do.
>
>> +

SNIP
>> +       btf_record_free(key_rec);
>>         btf_record_free(rec);
>>         /* Delay freeing of btf for maps, as map_free callback may need
>>          * struct_meta info which will be freed with btf_put().
>> @@ -1180,6 +1188,8 @@ int map_check_no_btf(const struct bpf_map *map,
>>         return -ENOTSUPP;
>>  }
>>
>> +#define MAX_DYNPTR_CNT_IN_MAP_KEY 1
> I remember we discussed to allow 2 dynptr-s in a key.
> And in patch 11 you already do:
> +       record = map->key_record;
> +       for (i = 0; i < record->cnt; i++) {
>
> so the support for multiple dynptr-s is almost there?

I misunderstood the discussion. However, the change is simple. Only need
to change it from 1 to 2 because the following patches has already
supported multiple dynptrs.



Return-Path: <bpf+bounces-50471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CCFA2817A
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0379B167E79
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11B20E022;
	Wed,  5 Feb 2025 01:51:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E320DD49
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738720284; cv=none; b=hbP5oGYS93y2jfr7knK9ptup28QoB5MNK6j7uQUATVeYguhkK/6t2W7wCbJWhX4U4acz7Yc3ChsDrq/bcyRfqIxirnAR3l+hjDdC8oArwnRPalW85Qo5d8VtEnhSGjXbji5r1nQi/s8+gcnTKzI8nO2IFnOKIaug7RroOZ/Fgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738720284; c=relaxed/simple;
	bh=/W1glwnLBDiIhviEIO4pWRs+JH2NxNxs/+7ZzZsh5NE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M/3zebFvQV73pTeYXGm4wZd2kElQqtrHTdZCtwn28ZRKvj8yMs5dn1yeyiQtXYk86CPH26TtpeicKQlOKtUrzuklKg7gA/CptSaz9zHOn7WjciEs3P9APMw81tafEIkDNbu9UG2oevpK04WHfT65sUOYkkXsoctFL9f4WcW1biU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YnjRH4Fqjz4f3l2p
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 09:32:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AB9EE1A15E0
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 09:33:20 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDnhsHdv6JnG2qXCw--.14430S2;
	Wed, 05 Feb 2025 09:33:20 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 01/20] bpf: Add two helpers to facilitate the
 parsing of bpf_dynptr
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
 <20250125111109.732718-2-houtao@huaweicloud.com>
 <CAADnVQLep5NrLfJkWbtQsBSZZq-BhBJOVcZ4US7EAZ56D27MhQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a49c2a88-cb94-76d6-39eb-a1eb57616d85@huaweicloud.com>
Date: Wed, 5 Feb 2025 09:33:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLep5NrLfJkWbtQsBSZZq-BhBJOVcZ4US7EAZ56D27MhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDnhsHdv6JnG2qXCw--.14430S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWfXF4xtr1UGFyrXw1kZrb_yoW8CFyUpF
	WDGa13ur4vkrZrCr9xtw4xZw45tw48ur1IkryYgry0kFW2qF92gr1kGa1fXFyrKrWSkr40
	yry2vFZ5G34UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UQ6p9UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/5/2025 7:17 AM, Alexei Starovoitov wrote:
> On Sat, Jan 25, 2025 at 10:59 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Add BPF_DYNPTR in btf_field_type to support bpf_dynptr in map key. The
>> parsing of bpf_dynptr in btf will be done in the following patch, and
>> the patch only adds two helpers: btf_new_bpf_dynptr_record() creates an
>> btf record which only includes a bpf_dynptr and btf_type_is_dynptr()
>> checks whether the btf_type is a bpf_dynptr or not.
>>
>> With the introduction of BPF_DYNPTR, BTF_FIELDS_MAX is changed from 11
>> to 13, therefore, update the hard-coded number in cpumask test as well.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  include/linux/bpf.h                           |  5 ++-
>>  include/linux/btf.h                           |  2 +
>>  kernel/bpf/btf.c                              | 42 ++++++++++++++++---
>>  .../selftests/bpf/progs/cpumask_common.h      |  2 +-
>>  4 files changed, 43 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index feda0ce90f5a3..0ee14ae30100f 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -184,8 +184,8 @@ struct bpf_map_ops {
>>  };
>>
>>  enum {
>> -       /* Support at most 11 fields in a BTF type */
>> -       BTF_FIELDS_MAX     = 11,
>> +       /* Support at most 13 fields in a BTF type */
>> +       BTF_FIELDS_MAX     = 13,
> BTF_FIELDS_MAX doesn't need to be incremented when btf_field_type
> learns about a new type.
> The number of fields per map value is independent
> from a number of types that the verifier recognizes.
> The patch that incremented it last time slipped through
> by accident.
> Do you really need to increase it?
> If so, why 13 and not 32 ?

I see. There is no need to increase it for current patch set. The
original idea is that the parsing needs to support all of these special
field in the map key/value, but it is unnecessary. Will remove it.
> pw-bot: cr



Return-Path: <bpf+bounces-48890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A6BA116AD
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CAD3A8298
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15BD35952;
	Wed, 15 Jan 2025 01:35:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1923243D
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904938; cv=none; b=jTfar8KZHOh4egR/bqeCujLBGVB5DkPK8SZHKjACgFJ1WXWffaTWWE/KFrfOHAkbrAdo1Lbq3tKU+lENitxU9N1B8qsSuJwdDvzSGBoQPSnV78TaHCCR2k1sGs7QtuIYXfSE1bYvN25+XV56S/IXKITH77pTB8PYIpTB0qPiFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904938; c=relaxed/simple;
	bh=530B5Mb6tYhelrVwhM5vCufbnXibG91aEMOa3mk9zJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YASEWY9woChsigz22qXmsM903cbbAlSOFuMQGCNRc/oUX76Eb0Ur4TMl3Z/teqPaiWPbX0g7ytB3XNILfmE7gwRnuc7MXlf2YaLYeLDFYi672SgCJaxrgH/S76Z1I80hIoNGBpA/FcDUxeKeeZ1V2ELmgLB6yrkyesL6teag5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YXpTc2qpvz4f3jsw
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 09:35:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 92C9A1A12EE
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 09:35:31 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgAnesThEIdnv2DhAw--.53420S2;
	Wed, 15 Jan 2025 09:35:31 +0800 (CST)
Message-ID: <b7898f5f-aaa4-402f-9a04-240096ca56c6@huaweicloud.com>
Date: Wed, 15 Jan 2025 09:35:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/2] libbpf: Fix incorrect iter rounds when marking
 BTF_IS_EMBEDDED
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20250114140931.3844196-1-pulehui@huaweicloud.com>
 <20250114140931.3844196-2-pulehui@huaweicloud.com>
 <CAEf4Bzbuw_ZskaUti-s6bSqG9peRf1Z+oxp9G80hEwBGrW0CQQ@mail.gmail.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAEf4Bzbuw_ZskaUti-s6bSqG9peRf1Z+oxp9G80hEwBGrW0CQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnesThEIdnv2DhAw--.53420S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4DGw4UJF1DWr15GFykZrb_yoW8ZFW8pF
	W7Gw4xCwn5Jr4I9wn2g3WFg3yFyw4Iq3yUCrW2qw1UAF4DKrn8KF4IqF4FyrWfCr10kw4a
	vayj9a4Uur1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/1/15 7:46, Andrii Nakryiko wrote:
> On Tue, Jan 14, 2025 at 6:06 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> When redirecting the base BTF of the split BTF from the distilled base
>> BTF to the vmlinux base BTF, we need to mark distilled base struct/union
>> members of split BTF structs/unions in id_map with BTF_IS_EMBEDDED,
>> which indicates that these types need to match both name and size later.
>> But, the current implementation uses the incorrect iter rounds, we need
>> to correct it to iter from nr_dist_base_types to nr_types.
> 
> It's hard to understand what this description says without looking at
> the code... the "iter rounds" and "iter" is very confusing, because we
> are actually dealing with type IDs? Can you please reword to make it
> clearer.
> 
> Also, why don't we see this issue in our tests? Can you come up with a
> simple test to demonstrate a problem?

Sure, will make description more sense and add test in next.

> 
> This looks correct, otherwise, but it would be nice for Alan to review
> as well, thanks.
> 
> pw-bot: cr
> 
>>
>> Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   tools/lib/bpf/btf_relocate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
>> index b72f83e15156..53d1f3541bce 100644
>> --- a/tools/lib/bpf/btf_relocate.c
>> +++ b/tools/lib/bpf/btf_relocate.c
>> @@ -212,7 +212,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
>>           * need to match both name and size, otherwise embedding the base
>>           * struct/union in the split type is invalid.
>>           */
>> -       for (id = r->nr_dist_base_types; id < r->nr_split_types; id++) {
>> +       for (id = r->nr_dist_base_types; id < r->nr_dist_base_types + r->nr_split_types; id++) {
>>                  err = btf_mark_embedded_composite_type_ids(r, id);
>>                  if (err)
>>                          goto done;
>> --
>> 2.34.1
>>



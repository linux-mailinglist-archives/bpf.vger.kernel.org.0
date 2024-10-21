Return-Path: <bpf+bounces-42632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D99A6B0C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96264B23CCD
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF041F8F03;
	Mon, 21 Oct 2024 13:51:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADB1F8EE6
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518698; cv=none; b=E14AaYmmOJtp8ODgXvBrczyxAQyhzAk8ewdybNRSPaDSyofFaV8BQyzWOBxbMJTbXloYaH8p1PfeK+nl3Z3vg87tZTgwiysLn2ZxS35goxHcvDxFWt5TOfoOOUHR4ajl+nHV2n+2eR7MBQASEbhjI/3ME5WE6eyQ7DwfVdCFjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518698; c=relaxed/simple;
	bh=Ygs2e6rluBEGv42iPFVLS/GapCqz2XhgEtLmTSqVmGo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BYWl41A/zWP6p7rn/53EjzscaR/cqfS3nvXtA25qflVuInMxzQB975PlTxpj//SIp6OW8Sgi3eqfLQ9Jj9jn+lOzxhpMKzz0a+csDSqslniIEq4p42qXOfyB+ptbxQjUZTKG/VTQbj8eCs4YtDbM+Os/sEURTvjec+T7bYIVZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXGtT5s42z4f3jMx
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:51:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2E7CE1A0A22
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:51:31 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCHu8diXBZnO2fhEg--.60013S2;
	Mon, 21 Oct 2024 21:51:30 +0800 (CST)
Subject: Re: [PATCH bpf-next 07/16] libbpf: Add helpers for bpf_dynptr_user
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-8-houtao@huaweicloud.com>
 <CAEf4BzafbA4S0soDpRp__biWXm5bwFa_BWfbPLO=JSa91rG9Qw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9ef9c21b-26b5-78f4-858e-218b2aab8ecf@huaweicloud.com>
Date: Mon, 21 Oct 2024 21:51:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzafbA4S0soDpRp__biWXm5bwFa_BWfbPLO=JSa91rG9Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCHu8diXBZnO2fhEg--.60013S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF13tFWDXFW7CF17trykAFb_yoW8CFW7pa
	y8GFW3ur4xXFW2ywnxXF4Iy3yrKr4fXr17GrW7t34rAF4qvr98ZF1jvws3Wrn0vr95ur4j
	vFWagrW3Wr18ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07UXyCJUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/11/2024 5:50 AM, Andrii Nakryiko wrote:
> On Tue, Oct 8, 2024 at 2:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Add bpf_dynptr_user_init() to initialize a bpf_dynptr_user object,
>> bpf_dynptr_user_{data,size}() to get the address and length of the
>> dynptr object, and bpf_dynptr_user_set_size() to set the its size.
>>
>> Instead of exporting these symbols, simply adding these helpers as
>> inline functions in bpf.h.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  tools/lib/bpf/bpf.h | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
> I don't think we need this patch and these APIs at all, let user work
> with bpf_udynptr directly

Got it. Will drop it in v2.
>
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index a4a7b1ad1b63..92b4afac5f5f 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -700,6 +700,33 @@ struct bpf_token_create_opts {
>>  LIBBPF_API int bpf_token_create(int bpffs_fd,
>>                                 struct bpf_token_create_opts *opts);
>>
>> +/* sys_bpf() will check the validity of data and size */
>> +static inline void bpf_dynptr_user_init(void *data, __u32 size,
>> +                                       struct bpf_dynptr_user *dynptr)
>> +{
>> +       dynptr->data = (__u64)(unsigned long)data;
>> +       dynptr->size = size;
>> +       dynptr->rsvd = 0;
>> +}
>> +
>> +static inline void bpf_dynptr_user_set_size(struct bpf_dynptr_user *dynptr,
>> +                                           __u32 new_size)
>> +{
>> +       dynptr->size = new_size;
>> +}
>> +
>> +static inline __u32
>> +bpf_dynptr_user_size(const struct bpf_dynptr_user *dynptr)
>> +{
>> +       return dynptr->size;
>> +}
>> +
>> +static inline void *
>> +bpf_dynptr_user_data(const struct bpf_dynptr_user *dynptr)
>> +{
>> +       return (void *)(unsigned long)dynptr->data;
>> +}
>> +
>>  #ifdef __cplusplus
>>  } /* extern "C" */
>>  #endif
>> --
>> 2.44.0
>>



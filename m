Return-Path: <bpf+bounces-41360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DCD996061
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594ADB20C9C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F7717D358;
	Wed,  9 Oct 2024 07:13:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67817C7A3
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457989; cv=none; b=pkGz2J4f94nAMW8+Xe1HJQBom5HvuZC6EN+V7NkhOTnKvCvp+5V5sgXy2F6uL/JlfH6wgccc8jD/M1/zMXXFELChQ0Ysjor0Wuw8AiblbfDQcdEW+URTuKtTvIcjjInT1JJSq1hNiR+6QVbaNsIAZY2vj+JyD8lS12SV8Bdk9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457989; c=relaxed/simple;
	bh=ONy1f5Xh6rz/XKeRkysGm3lLguTJn7yVKsfK8JaltfY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KID0Yk5RaJCi55IODKF/v83kGRbwq7R4zvUvJr5LtnTk/c/SPrxOsB4OgLrEIBw+ZTfGDV23SshbhNmqpEwh2NMGq5hsGQn75D0wB6G5aqiwg5XPRklnmobIK87oZb4BdUt5YU+FvKHJBDN+17SA7me4zhDt9MYKdVo3E/YFQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNkcK4W1Xz4f3kkK
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 15:12:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 613471A0568
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 15:13:01 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3y4f5LAZnvxDpDQ--.62281S2;
	Wed, 09 Oct 2024 15:13:01 +0800 (CST)
Subject: Re: [PATCH bpf RESEND 1/2] bpf: Check the remaining info_cnt before
 repeating btf fields
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241008071114.3718177-1-houtao@huaweicloud.com>
 <20241008071114.3718177-2-houtao@huaweicloud.com>
 <e8b1e868755e0369d212f53f4e00c0cf93477af1.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <eeceba84-0fa0-322a-5236-0f02103f4863@huaweicloud.com>
Date: Wed, 9 Oct 2024 15:12:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e8b1e868755e0369d212f53f4e00c0cf93477af1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3y4f5LAZnvxDpDQ--.62281S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kWFW7tw43Jr4Dtr43Jrb_yoW8ZF13pF
	4fAFy5WFWkKF93Cr1Utr1Yk34ayr4xGa47J3WUK3WYyFsxtr9agFsYqw4Y9FW8Cr4IyF18
	uF4UJF1Du345ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/9/2024 2:42 PM, Eduard Zingerman wrote:
> On Tue, 2024-10-08 at 15:11 +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When trying to repeat the btf fields for array of nested struct, it
>> doesn't check the remaining info_cnt. The following splat will be
>> reported when the value of ret * nelems is greater than BTF_FIELDS_MAX:
> [...]
>
>> Fix it by checking the remaining info_cnt in btf_repeat_fields() before
>> repeating the btf fields.
>>
>> Fixes: 64e8ee814819 ("bpf: look into the types of the fields of a struct type recursively.")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks for the ack.
>
>> @@ -3681,10 +3687,10 @@ static int btf_find_field_one(const struct btf *btf,
>>  
>>  	if (ret == BTF_FIELD_IGNORE)
>>  		return 0;
>> -	if (nelems > info_cnt)
>> +	if (!info_cnt)
>>  		return -E2BIG;
>>  	if (nelems > 1) {
>> -		ret = btf_repeat_fields(info, 1, nelems - 1, sz);
>> +		ret = btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
>>  		if (ret < 0)
>>  			return ret;
>>  	}
>
> I think the change like below (on top of yours) would work the same
> (because nelems is >= 1 at this point):
>
> -       if (!info_cnt)
> -               return -E2BIG;
> -       if (nelems > 1) {
> -               ret = btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
> -               if (ret < 0)
> -                       return ret;
> -       }
> +
> +       ret = btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
> +       if (ret < 0)
> +               return ret;
>
> wdyt?

I don't think they are the same. The main reason is due to the check in
the beginning of btf_repeat_field():

        /* Ensure not repeating fields that should not be repeated. */
        for (i = 0; i < field_cnt; i++) {
                switch (info[i].type) {

There are two cases here:
1) info_cnt == 0
Because info_cnt is 0, the found record isn't saved in info[0], the
check will be incorrect

2) nelements ==1 && info_cnt > 0
If the found record is bpf_timer or similar, btf_repeat_fields() will
return -EINVAL instead of 0.




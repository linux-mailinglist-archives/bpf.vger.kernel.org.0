Return-Path: <bpf+bounces-42631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD19A6B04
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F7A1C22C07
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35711F8EE6;
	Mon, 21 Oct 2024 13:51:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B11E6DC7
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518675; cv=none; b=EOTc8Ms8ApKq49Kd54LoUWf5YkwqzSe1QO0jg84PKC5/Zd2UkNNbR7lYu0g8POUy/GboBv9I5bJAVX/FRQgQkTqdb8g66gw1c+G2ezX/HCET4hTcyVUcbpVJts7RB8qjb6PcfQO+3CODD27Wz+Ut5i0V68k71jJsIuxY3HwadG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518675; c=relaxed/simple;
	bh=SiqTO5miMYD2nWlKz3M0ywvhFafucEFvygt0tE788Is=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DhfhJUC7ZsBuFdqRq/21jBT87468X33CYkome0zSckPXrjfuANqWalljeOfzZDrgyIz8pn/2CCsqpJwALbVBJ/oPdyGVTmOC7Z8st66AnO0BYs1TIEGl7Jncslq8w/VQhAwTVN1BMzxY6Kgz+d75l86p8doyKwRMzw1UD4ntv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXGt400VTz4f3jJ1
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:50:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 56F6E1A08DC
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 21:51:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXDMlMXBZnBmHhEg--.60331S2;
	Mon, 21 Oct 2024 21:51:09 +0800 (CST)
Subject: Re: [PATCH bpf-next 06/16] bpf: Introduce bpf_dynptr_user
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
 <20241008091501.8302-7-houtao@huaweicloud.com>
 <CAEf4BzaVNBaNULS3=9o6hwnruKBTcz-Z3c0DMf+q17G=RfPkEg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6fbbda0b-4676-014f-ed71-948c11f1d388@huaweicloud.com>
Date: Mon, 21 Oct 2024 21:51:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaVNBaNULS3=9o6hwnruKBTcz-Z3c0DMf+q17G=RfPkEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDXDMlMXBZnBmHhEg--.60331S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF13tFWDXFW7CF1xXryrZwb_yoW8tF43pF
	95GFWxur47XFW7CrnrJa1Ivr4ruF4rur17K3y2934jkrZxXF93Zrs7Kas0kFZ8t3yFkw43
	tr92g3s5WrZ5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07UG-eOUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

HI,

On 10/11/2024 5:50 AM, Andrii Nakryiko wrote:
> On Tue, Oct 8, 2024 at 2:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> For bpf map with dynptr key support, the userspace application will use
>> bpf_dynptr_user to represent the bpf_dynptr in the map key and pass it
>> to bpf syscall. The bpf syscall will copy from bpf_dynptr_user to
>> construct a corresponding bpf_dynptr_kern object when the map key is an
>> input argument, and copy to bpf_dynptr_user from a bpf_dynptr_kern
>> object when the map key is an output argument.
>>
>> For now the size of bpf_dynptr_user must be the same as bpf_dynptr, but
>> the last u32 field is not used, so make it a reserved field.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  include/uapi/linux/bpf.h       | 6 ++++++
>>  tools/include/uapi/linux/bpf.h | 6 ++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 07f7df308a01..72fe6a96b54c 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7329,6 +7329,12 @@ struct bpf_dynptr {
>>         __u64 __opaque[2];
>>  } __attribute__((aligned(8)));
>>
>> +struct bpf_dynptr_user {
> bikeshedding: maybe just bpf_udynptr?
>
>> +       __u64 data;
>> +       __u32 size;
>> +       __u32 rsvd;
>> +} __attribute__((aligned(8)));
>> +
>>  struct bpf_list_head {
>>         __u64 __opaque[2];
>>  } __attribute__((aligned(8)));
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 14f223282bfa..f12ce268e6be 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -7328,6 +7328,12 @@ struct bpf_dynptr {
>>         __u64 __opaque[2];
>>  } __attribute__((aligned(8)));
>>
>> +struct bpf_dynptr_user {
>> +       __u64 data;
> what if we use __bpf_md_ptr(void *, data), so users can just directly
> use this struct (and then the next patch won't be necessary at all)

Thanks for the suggestion. Will do in v2.
>> +       __u32 size;
>> +       __u32 rsvd;
> please call it __reserved

Got it.
>
>
>> +} __attribute__((aligned(8)));
>> +
>>  struct bpf_list_head {
>>         __u64 __opaque[2];
>>  } __attribute__((aligned(8)));
>> --
>> 2.44.0
>>



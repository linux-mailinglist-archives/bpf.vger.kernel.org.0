Return-Path: <bpf+bounces-33616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51B923CFE
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C06E1F2263B
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A461015B54E;
	Tue,  2 Jul 2024 11:57:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46015B12A;
	Tue,  2 Jul 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921447; cv=none; b=rgr4btSblkBCt997/ht7rYsx2q6bwAbIW90FY5UgmIXqkZJT/NGLqB+uvnjN2Mj/Wp4XF9FHLOZnXX0j01pubKQQ686lbFfSLfO7WWuRYltw7Zm/x7ZLVE7nhzsR9On9QDROvP+VMPQXvrRclIBOFFpH7Rcy5dfJEKwlqgiJiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921447; c=relaxed/simple;
	bh=kuy2cZPLbHz9e6A9Bj/DCoxwj7MW3iTyXUT94QldROM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mEiNn8eiF9tJt4QL/rNxV2k/qUgh8kBVmI0mDsIeaAUHxk83rcnEBYrnNARWY/v3bKvCl6Aa6+Si5D8yGvnyQPrSXFUquWeksSXyqdSQ1ik2Ldkn6pV3zMLMdVsWDunP+z9BlrB6sM/yJrczCnTkrupodlSqRjzngc8nTyPsJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WD1W63GRVzZhJF;
	Tue,  2 Jul 2024 19:52:50 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id AB824180A9C;
	Tue,  2 Jul 2024 19:57:22 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jul 2024 19:57:21 +0800
Message-ID: <ea07cb5a-da1e-4ba9-b895-1a12be224962@huawei.com>
Date: Tue, 2 Jul 2024 19:57:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: Factor out many args tests
 from tracing_struct
To: Jiri Olsa <olsajiri@gmail.com>, Pu Lehui <pulehui@huaweicloud.com>
CC: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Puranjay Mohan
	<puranjay@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20240702013730.1082285-1-pulehui@huaweicloud.com>
 <20240702013730.1082285-3-pulehui@huaweicloud.com> <ZoPfSe-CvdEwlxjo@krava>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <ZoPfSe-CvdEwlxjo@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2024/7/2 19:06, Jiri Olsa wrote:
> On Tue, Jul 02, 2024 at 01:37:29AM +0000, Pu Lehui wrote:
> 
> SNIP
> 
>> +
>> +static void test_struct_many_args(void)
>> +{
>> +	struct tracing_struct_many_args *skel;
>> +	int err;
>> +
>> +	skel = tracing_struct_many_args__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "tracing_struct_many_args__open_and_load"))
>> +		return;
>> +
>> +	err = tracing_struct_many_args__attach(skel);
>> +	if (!ASSERT_OK(err, "tracing_struct_many_args__attach"))
>> +		goto destroy_skel;
>> +
>> +	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
>> +
>>   	ASSERT_EQ(skel->bss->t7_a, 16, "t7:a");
>>   	ASSERT_EQ(skel->bss->t7_b, 17, "t7:b");
>>   	ASSERT_EQ(skel->bss->t7_c, 18, "t7:c");
>> @@ -74,12 +95,15 @@ static void test_fentry(void)
>>   	ASSERT_EQ(skel->bss->t8_g, 23, "t8:g");
>>   	ASSERT_EQ(skel->bss->t8_ret, 156, "t8 ret");
>>   
>> -	tracing_struct__detach(skel);
>> +	tracing_struct_many_args__detach(skel);
> 
> nit, I know it's in the current code, but tracing_struct_many_args__destroy
> will take care of the detach, so no need to call it explicitly

Alright, will resend a new version. Thanks

> 
> jirka
> 
> 
>>   destroy_skel:
>> -	tracing_struct__destroy(skel);
>> +	tracing_struct_many_args__destroy(skel);
>>   }
>>   
> 
> SNIP


Return-Path: <bpf+bounces-52337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10721A41EB9
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 13:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0207A1648
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC9233732;
	Mon, 24 Feb 2025 12:17:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA3233731
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399422; cv=none; b=D825A7a+Y2kbJnjrsJy1F5niWPVU942QhWFyps1bTfhL/PzrNFXcp8Ai8hXIFxg670y0YyyEGvlPhvj/iPmRwovi+w3XEurW6jv/Yex9SPUYM4/TG1gk0mntApRC0yj1yLOW/julu3ql+QSJArBXhqGpZZEeo4fQNe0hrMNyqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399422; c=relaxed/simple;
	bh=gaCP/++UOxo4VGS5UGiyOU6L9FO4tP3nzXENHE5dsPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nXe/tZ2aMjb8AFLH7WtOheaZeQPvWrHrBDYdOHt/kzr5P8+JYJvsT+Qyl3wSkyA3XqiL4ZFJgW4ZAvJj5HeH7+ycxtocA+THV9z4vyfwDJIOlUA7EoQ5XKWeAGhNfd2Xmmk22gdto0kJioNzdTMR9I4A1SO0srFB8xHT4Isowh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z1fkp6QjSz1ltbY;
	Mon, 24 Feb 2025 20:12:50 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id EC80814013B;
	Mon, 24 Feb 2025 20:16:51 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Feb 2025 20:16:50 +0800
Message-ID: <abf6baeb-ac7a-44da-8c00-a0bb409760df@huawei.com>
Date: Mon, 24 Feb 2025 20:16:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] kbuild, bpf: Correct pahole version that
 supports distilled base btf feature
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Pu Lehui
	<pulehui@huaweicloud.com>, Alan Maguire <alan.maguire@oracle.com>
CC: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>
References: <20250219063113.706600-1-pulehui@huaweicloud.com>
 <CAEf4BzYJLKZpuEsbU-A1s7wtpG0YQKUHG3QDaQoDH8B+VY0oSQ@mail.gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <CAEf4BzYJLKZpuEsbU-A1s7wtpG0YQKUHG3QDaQoDH8B+VY0oSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/2/21 8:30, Andrii Nakryiko wrote:
> On Tue, Feb 18, 2025 at 10:29 PM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> pahole commit [0] of supporting distilled base btf feature released on
>> pahole v1.28 rather than v1.26. So let's correct this.
>>
>> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=c7b1f6a29ba1 [0]
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   scripts/Makefile.btf | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index c3cbeb13de50..fbaaec2187e5 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -24,7 +24,7 @@ else
>>   pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
>>
>>   ifneq ($(KBUILD_EXTMOD),)
>> -module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
>> +module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
>>   endif
> 
> Alan,
> 
> Is this correct? Can you please check and ack? Thanks!

Maybe Alan doesn't have time to reply at the moment. We can use the 
following command to check that in pahole.git:

$ git name-rev c7b1f6a29ba1
c7b1f6a29ba1 tags/v1.28~73

> 
>>
>>   endif
>> --
>> 2.34.1
>>


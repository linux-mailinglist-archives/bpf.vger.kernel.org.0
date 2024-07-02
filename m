Return-Path: <bpf+bounces-33593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA691ECA9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 03:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA8B21801
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD346FCB;
	Tue,  2 Jul 2024 01:24:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E088BFC;
	Tue,  2 Jul 2024 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719883474; cv=none; b=GyB6i2hwLYMd9NRA5RK1xw858D5Jdi7ZL2FOVc9VCdCSVi0ifDuXmO3JjCB+f1WEtCpTgMvjsDv9jSWBEDqES1pNrA3VezoKjlrGC2UebP0L5zj67XuDh4NrxJf/BkqVV9P+TIT/PVKA79MgLz5QmRO+MLNUl/XAG9bPfR6cdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719883474; c=relaxed/simple;
	bh=c1BjsnRBfpmwDDUxkn8V6VTMSfmIx2xT5fIk2cfmFoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KM+dQd4fVwsd9WMb3S49Gk350h+PmXTbsL/F4+pm2Y3pFcpeibfHhYslUhquAZEQwN1FbZF6SoIBlurkpDoj14kq96Sty4m+Wqf9KhPM9SFtX7Yn9YYgpCJMslh3Y4L3N2/9T0lwvLga2vqznQDa75eqodaNBKTqtxWVZqwwixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WClYp1bLZznXv7;
	Tue,  2 Jul 2024 09:24:14 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id EF311180A9C;
	Tue,  2 Jul 2024 09:24:28 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jul 2024 09:24:28 +0800
Message-ID: <f0e18f46-96f9-4f89-802a-4cba349b1db1@huawei.com>
Date: Tue, 2 Jul 2024 09:24:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v4 2/3] selftests/bpf: Factor out many
 args tests from tracing_struct
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, Pu Lehui
	<pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20240622022129.3844473-1-pulehui@huaweicloud.com>
 <20240622022129.3844473-3-pulehui@huaweicloud.com>
 <2bbced4a-1022-aace-52b4-e0abe426347b@iogearbox.net>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <2bbced4a-1022-aace-52b4-e0abe426347b@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100007.china.huawei.com (7.202.181.221)

On 2024/7/2 0:12, Daniel Borkmann wrote:
> On 6/22/24 4:21 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Factor out many args tests from tracing_struct and rename some function
>> names to make more sense.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> [...]
>> diff --git 
>> a/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c 
>> b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
>> new file mode 100644
>> index 000000000000..8bd696dc81d9
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
>> @@ -0,0 +1,62 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2024. Huawei Technologies Co., Ltd */
> 
> Overall looks good and ready to land, one small request: lets drop the 
> copyright

Sure, will drop it in next version.

> comment here since this commit is only moving the existing tests out to 
> its own
> file which have been added originally via 5e9cf77d81f9 ("selftests/bpf: 
> add testcase
> for TRACING with 6+ arguments").
> 
> Thanks,
> Daniel
> 


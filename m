Return-Path: <bpf+bounces-74640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 753BCC5FF47
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 04:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7304D356D43
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E68C1FBC92;
	Sat, 15 Nov 2025 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JDeraHKs"
X-Original-To: bpf@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052E1B7F4
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 03:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763176919; cv=none; b=LG7qbM80/DBfW7J9XVsxJGtORBfzU8v2p6PCDwPr7w7cH4jy4+gBSnqyNX6nlr2U9MZ/HWytGXZKW6NIU5iwHLq7KxeOhjUvMs8b2nCpj7y+e9HjtiA8vyJcHQ1HmcabuRwnX087oxP9UaXJXE2/qkQ+aenLKn7aXZr/vnXSyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763176919; c=relaxed/simple;
	bh=aOiVZZdiJrNYStVntXgUA7p4yDYeZTKSyGzQT7wAaUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DGq2WQdXLy+TASbXWKpkns6gN/0eTmjcggO4Jxk/WrieWZteHfabkzMtoCl69VUPiy2LLBUKHsWAlmmViqyAgDBlbhd2kRCTHSoUQ1P/Q74bs4lHSsee3JUo6/vhn6x6WNDZ7qOaPQCx1Dw1V3rTBctOFeM4ANL7d+ChTihrjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JDeraHKs; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dyT2Y1Fc+AdSQP20nceDDNJFA5KAUilSnzrTI8dDpiU=;
	b=JDeraHKsmJb0ynvgq0EL9hUzgGIMqjergE3xm1bwQWYnBi/qVxw1NHVdxhFnOOBO727IfEHly
	9GohV5eGRSDB2lx/LJl2c2LT5rE5wPODvkuEp/o3UGIU0XQABP6jiySqlSYI2wfNZj995EpYbx3
	yGT16SkJ+Iaav+WqKgYulDI=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d7fQf49SGz1T4Gb;
	Sat, 15 Nov 2025 11:20:26 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id B1E281402F0;
	Sat, 15 Nov 2025 11:21:53 +0800 (CST)
Received: from [10.67.108.204] (10.67.108.204) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Nov 2025 11:21:53 +0800
Message-ID: <b43f13fd-8f18-4505-b705-240166804104@huawei.com>
Date: Sat, 15 Nov 2025 11:21:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Pu Lehui <pulehui@huaweicloud.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
	<alan.maguire@oracle.com>
References: <20251110092536.4082324-1-pulehui@huaweicloud.com>
 <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
 <CAADnVQ+2jdSD=HMMq3tKvu08gF49T=290LNzvc5LDOf4AycEuw@mail.gmail.com>
 <fb7f62db-4dc6-4614-a0c4-3b2a1904aadb@huawei.com>
 <CAADnVQLPJGPwx3CfgXBCZPHi_niGYTy+VFnyd50oNrDSkvyqPw@mail.gmail.com>
 <2612eeec-8948-41d6-9d41-4f1ec813d514@huaweicloud.com>
 <4d22c2f6bdf8327a02d6b03b9e19b0e5df2da4c1.camel@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <4d22c2f6bdf8327a02d6b03b9e19b0e5df2da4c1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/11/15 10:45, Eduard Zingerman wrote:
> On Sat, 2025-11-15 at 10:41 +0800, Pu Lehui wrote:
> 
> [...]
> 
>> Hi Alexei,
>>
>> How about making the stats update a callback function? That is, the
>> dummy flow does nothing, while the others follow the normal process.
> 
> Not Alexei, but am curious.
> Is there a performance differnece between "if" check, dummy stats
> struct or function pointer?

Alexei mention that indirect calls are slower than an extra 'if', so 
let's keep the "if" check. I will send new soon.


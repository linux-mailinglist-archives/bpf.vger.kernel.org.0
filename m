Return-Path: <bpf+bounces-26184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002B89C5A3
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40CF1F20F16
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AE27F47E;
	Mon,  8 Apr 2024 13:58:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05A71742;
	Mon,  8 Apr 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584714; cv=none; b=d9WoZVLftwHIxYQf9wG4X4kJWA4cwckqsGfOWasSEupV5Tf+6oScOC/S6Fj/kzaOy3w0gTFVIbIdOS6pLr9VqGtWqPxdcSNZxYfMDjUJmyzRw8MOM+MOVBLBOh5UQHVOmt9OpKbNIS9jpPLbHKc4eubFWgzMsyMbl1eMAzPaNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584714; c=relaxed/simple;
	bh=ut5nMt1k1x0H51H+5ptS+Asr3jQYVlDPkACkXqPzyoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H6I+lVYbvY8jbMnaE+jmJyprrCugtxomXy6/y1fuwFy5UIaGu+bKzqjX0LEvQMk8Xt2SMM2eB4Bs5koMpXs16QH9gdr7AyLSwhuSJsGvwY2AkH8nJRo+PtSD2A777kLgqhaOupoPbO0+QFT6n9SsvfYHNTawzdF2JI5nedk09is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VCrJQ0XM3z1GGMG;
	Mon,  8 Apr 2024 21:57:42 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F1EE18002D;
	Mon,  8 Apr 2024 21:58:26 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 8 Apr 2024 21:58:25 +0800
Message-ID: <71e2ec5b-e46e-4c85-ad83-b584ef3056a0@huawei.com>
Date: Mon, 8 Apr 2024 21:58:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add testcase where 7th
 argment is struct
To: Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huaweicloud.com>
References: <20240403072818.1462811-1-pulehui@huaweicloud.com>
 <20240403072818.1462811-3-pulehui@huaweicloud.com>
 <0f459fc1-1445-6e83-ace4-b2c42abfe884@iogearbox.net>
 <9bffde6f-ca7f-40d4-9b27-4e53ed274751@huaweicloud.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <9bffde6f-ca7f-40d4-9b27-4e53ed274751@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100009.china.huawei.com (7.221.188.135)


On 2024/4/3 23:50, Pu Lehui wrote:
> 
> 
> On 2024/4/3 22:40, Daniel Borkmann wrote:
>> On 4/3/24 9:28 AM, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Add testcase where 7th argument is struct for architectures with 8
>>> argument registers, and increase the complexity of the struct.
>>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> Acked-by: Björn Töpel <bjorn@kernel.org>
>>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>>> ---
>>>   tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++++++
>>>   .../selftests/bpf/prog_tests/tracing_struct.c | 13 +++++++
>>>   .../selftests/bpf/progs/tracing_struct.c      | 35 +++++++++++++++++++
>>>   4 files changed, 68 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 
>>> b/tools/testing/selftests/bpf/DENYLIST.aarch64
>>> index d8ade15e2789..639ee3f5bc74 100644
>>> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
>>> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
>>> @@ -6,6 +6,7 @@ kprobe_multi_test                                # 
>>> needs CONFIG_FPROBE
>>>   module_attach                                    # prog 
>>> 'kprobe_multi': failed to auto-attach: -95
>>>   fentry_test/fentry_many_args                     # 
>>> fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
>>>   fexit_test/fexit_many_args                       # 
>>> fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
>>> +tracing_struct                                   # 
>>> test_fentry:FAIL:tracing_struct__attach unexpected error: -524
>>
>> Do we need to blacklist the whole test given it had coverage on arm64
>> before.. perhaps this test here could be done as a new subtest and only
>> that one is listed for arm64?
> 
> Yeah, I thought so at first, just like fexit_many_args of fentry/fexit, 
> but I found that the things struct_tracing does are all in the same 
> series, but the number or type of parameters are different, and the new 
> use case I added is the same in this way. And I found that the execution 
> logic of stract_tracing is relatively simple and clear, triggering all 
> hook points, executing all bpf programs, and asserting all parameters.
> Shall we need to slice them up?

ping~ Daniel, shall we need to do that?

> 
>>
>>>   fill_link_info/kprobe_multi_link_info            # 
>>> bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>>   fill_link_info/kretprobe_multi_link_info         # 
>>> bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>>   fill_link_info/kprobe_multi_invalid_ubuff        # 
>>> bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>
>> Thanks,
>> Daniel
> 


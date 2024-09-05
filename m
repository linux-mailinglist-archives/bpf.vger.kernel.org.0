Return-Path: <bpf+bounces-38990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186DB96D244
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC991C24DB2
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D00194AE2;
	Thu,  5 Sep 2024 08:36:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC71898E4;
	Thu,  5 Sep 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525376; cv=none; b=rXurbxTrp95e6piuF6TUeMZPl0hcUqnk/XmrhSzSfHfMYae3+cpHAgcuLNVQNDdwOrRReOXtafnB1J8erCCpijglth2tBrEMym+F7oKWJGqCWyISwfVCpBTGXjLlG1g9zfiiUneMWKX4KSEmeE8ysRA8WSgnFiLaqBLlRQ0Zs/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525376; c=relaxed/simple;
	bh=oSfYpChyPUqxzwYIuKsV5+CLXkmDQfOhI4Op599R7Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0yPVgLEHsWU+E7fL+xlGjp71EW7NMhxSWqlDXnoacSBT933+GPbNQY+hFUaLcNsBacMiyAo8/zIhqyLbxx+i9z2dBQDbXuHjhEJo+kR8p0KMKz/DBreUhR8csDmiao/qio7nVnB2K82xm09Dav9v74ZpiFeNbmVs0+G2qS0ElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wzt3v3LQhz4f3jMP;
	Thu,  5 Sep 2024 16:35:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 81AAE1A0568;
	Thu,  5 Sep 2024 16:36:10 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgDXDMl2bdlm2BnOAQ--.51109S2;
	Thu, 05 Sep 2024 16:36:07 +0800 (CST)
Message-ID: <cdd31b81-8171-4dd0-b336-5229559ba50f@huaweicloud.com>
Date: Thu, 5 Sep 2024 16:36:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 03/10] selftests/bpf: Disable feature-llvm for
 vmtest
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240904141951.1139090-1-pulehui@huaweicloud.com>
 <20240904141951.1139090-4-pulehui@huaweicloud.com>
 <fc9a03f1809cfdd80a9a8cb7b513e32302be5a43.camel@gmail.com>
 <1bd4056c2b311aca03b7707b077f7555db4e55d6.camel@gmail.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <1bd4056c2b311aca03b7707b077f7555db4e55d6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXDMl2bdlm2BnOAQ--.51109S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fCw1UGw4UKFW3Gr4xXrb_yoW8Ww48pa
	yrJ3ZIkF48XFyktFsrKa48W3W5K395t3WUX34Uur1DZFn0kFnYgFZ3Kryj9a4kX39rWF43
	Zw12gasrXr1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/9/5 7:08, Eduard Zingerman wrote:
> On Wed, 2024-09-04 at 12:37 -0700, Eduard Zingerman wrote:
>> On Wed, 2024-09-04 at 14:19 +0000, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> After commit b991fc520700 ("selftests/bpf: utility function to get
>>> program disassembly after jit"), Makefile will link libLLVM* related
>>> libraries to the user binary execution file when detecting that
>>> feature-llvm is enabled, which will cause the local vmtest to appear as
>>> follows mistake:
>>>
>>>    ./test_progs: error while loading shared libraries: libLLVM-17.so.1:
>>>      cannot open shared object file: No such file or directory
>>>
>>> Considering that the get_jited_program_text() function is a useful tool
>>> for user debugging and will not be relied upon by the entire bpf
>>> selftests, let's turn it off in local vmtest.
>>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>
>> I actually don't agree.
>> The __jited tag is supposed to be used by selftests
>> (granted, used by a single selftest for now).
>> Maybe add an option to forgo LLVM linkage when test_progs are compiled?
>> Regarding base image lacking libLLVM -- I need to fix this.
>>
> 
> Please consider using my commit [1] instead of this patch, it forces
> static linking form LLVM libraries, thus avoiding issues with rootfs.
> (This was suggested by Andrii off list).
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ez/bpf-next.git/commit/?h=selftest-llvm-static-linking&id=263bacf2f20fbc17204fd912609e26bdf6ac5a13

Happy to see this modification only on llvm lib. I test it works good 
and have picked this in next version. Thanks



Return-Path: <bpf+bounces-49162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDABCA14A08
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 08:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D763A6CDE
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90151F7915;
	Fri, 17 Jan 2025 07:15:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F51F6690
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098137; cv=none; b=NDlA0gh/cLBK/yeo5dKXeb7m67FmxckbfBto1MHha+Q7Maxie82+I2EM8pTtU8ny32DcoMA7ANgl+OeudM/SivIXEvkNaeH33teBA5PpDe3RGMSJXJDySUoytLEw8RKJMu6Sc5fq4NqdjmFEUKv0f3OaOU/Rln25dc8VF4J4bBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098137; c=relaxed/simple;
	bh=3SRD1YSvLNuRCPp6gY4wD84jQ6QFFkcJtopK6BOj0KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqUaGbMdUInowscoLiXQi/Iyag3hKhiH7ezEQarzmsCntLihVRLS+20hoNDInqBksbt/nZnh+hSapWkdQg41T151tHZxPsM0eNFz3dy3otT+l6TYhi6USn00Gh/xWxGTjXc6mWc4bIEedyDDfL7x9e54SabZNDHJYBCLvvet0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZ9wr0NlHz4f3lDN
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 15:15:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BCC361A1211
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 15:15:29 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgCH6nqQA4pnFC+2BA--.7835S2;
	Fri, 17 Jan 2025 15:15:29 +0800 (CST)
Message-ID: <15f9c4ac-1d02-4db9-9fd7-634b14cde184@huaweicloud.com>
Date: Fri, 17 Jan 2025 15:15:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add distilled BTF test about
 marking BTF_IS_EMBEDDED
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20250115100241.4171581-1-pulehui@huaweicloud.com>
 <20250115100241.4171581-4-pulehui@huaweicloud.com>
 <CAEf4BzYvbeP16EoKFgfgEQwRw_zfiYVu8rRx8VLTxk=2HuxoNw@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAEf4BzYvbeP16EoKFgfgEQwRw_zfiYVu8rRx8VLTxk=2HuxoNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCH6nqQA4pnFC+2BA--.7835S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryxWw13Ary8JrW5uFWDXFb_yoW8Gw47pF
	y8Aa4aya4fZ3Zrtwn3AF4YgrWFgrs2qrWFkr17tr18Cr1kKrykKF4IgF45Wwn3CrWrZr1S
	v34Igrs8Cw48Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/1/17 7:34, Andrii Nakryiko wrote:
> On Wed, Jan 15, 2025 at 2:00 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> When redirecting the split BTF to the vmlinux base BTF, we need to mark
>> the distilled base struct/union members of split BTF structs/unions in
>> id_map with BTF_IS_EMBEDDED. This indicates that these types must match
>> both name and size later. So if a needed composite type, which is the
>> member of composite type in the split BTF, has a different size in the
>> base BTF we wish to relocate with, btf__relocate() should error out.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>> v2: Add test about marking BTF_IS_EMBEDDED.
>>
>>   .../selftests/bpf/prog_tests/btf_distill.c    | 72 +++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
> 
> Nice test, thanks! Applied the series to bpf-next.

Curious, resilient split BTF is currently supported, shall we deprecate 
MODULE_ALLOW_BTF_MISMATCH?

> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
>> index b72b966df77b..fb67ae195a73 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
>> @@ -601,6 +601,76 @@ static void test_distilled_endianness(void)
>>          btf__free(base);
>>   }
>>
> 
> [...]



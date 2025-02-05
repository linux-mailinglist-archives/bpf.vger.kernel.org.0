Return-Path: <bpf+bounces-50466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32765A2809F
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F137A1AE8
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70905FDA7;
	Wed,  5 Feb 2025 01:09:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886D173
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738717789; cv=none; b=NZa8xOqg2+kT0Tgj3T3RBLyTz5uA0jsa22CK4g/AufxxCUdDjhK1Mc6nFVr0KCFRVrwLZPfnV4isNgm39TP12AlbuXB/6Nukr8Pfpgy6aE9eARM0x6P5u8FFfuxCvjssmVtFA3+bJkFf2wQ3DwTK3bI+26pjQ0QXAo4qosCwGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738717789; c=relaxed/simple;
	bh=tN87eHZ/s36O2EL/T0ikZnei5tCnp4eZGSS5JJgMsyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bk7DK87n1rlQn1lEh4Po//o4RbO8RPPsW54H0mnDzrJgj8lwa7B2rSveTIwZaLSzkleNTPTQhskGsEtUN8ahWpG2/CXCl6hlEcN9PIoydEUVMrMvqfSQfI01EPALQVU/TweLgNSMv+r4d6yMwGgBLkeiLi4wtRZC5Mp0UViyekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YnhVt1NLFz4f3jqx
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 08:51:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0A56A1A08F3
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 08:51:18 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgDnl3gEtqJnVVOYCw--.7099S2;
	Wed, 05 Feb 2025 08:51:17 +0800 (CST)
Message-ID: <178eb4b3-1f0c-43c2-ab9c-bc9f1c04db2e@huaweicloud.com>
Date: Wed, 5 Feb 2025 08:51:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix freplace_link segfault in
 tailcalls prog test
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 hffilwlqm@gmail.com, leon.hwang@linux.dev
References: <20250122022838.1079157-1-wutengda@huaweicloud.com>
 <CAEf4BzYzqx_08Sg2YMf+ossSDLStWg2US0j7ohBWjTRxv44FqQ@mail.gmail.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <CAEf4BzYzqx_08Sg2YMf+ossSDLStWg2US0j7ohBWjTRxv44FqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnl3gEtqJnVVOYCw--.7099S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43AFyDurW8Zw4xGw43GFg_yoW8AFWDp3
	48X34jkF1F9F1YqF17ur429rWS9F4DXryFkr15Wwn5Ar4UXF97GF1I9rW5uFna9rZ3Xw1Y
	vw1xtrn3Zw48ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/1/25 2:34, Andrii Nakryiko wrote:
> On Tue, Jan 21, 2025 at 6:29 PM Tengda Wu <wutengda@huaweicloud.com> wrote:
>>
>> There are two bpf_link__destroy(freplace_link) calls in
>> test_tailcall_bpf2bpf_freplace(). After the first bpf_link__destroy()
>> is called, if the following bpf_map_{update,delete}_elem() throws an
>> exception, it will jump to the "out" label and call bpf_link__destroy()
>> again, causing double free and eventually leading to a segfault.
>>
>> Fix it by directly resetting freplace_link to NULL after the first
>> bpf_link__destroy() call.
>>
>> Fixes: 021611d33e78 ("selftests/bpf: Add test to verify tailcall and freplace restrictions")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/testing/selftests/bpf/prog_tests/tailcalls.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> index 544144620ca6..a12fa0521ccc 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> @@ -1602,6 +1602,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
>>         err = bpf_link__destroy(freplace_link);
>>         if (!ASSERT_OK(err, "destroy link"))
>>                 goto out;
>> +       freplace_link = NULL;
>>
> 
> libbpf will free the link even if bpf_link__destroy() returns error,
> so goto out above will still cause double-free. I moved `freplace_link
> = NULL` two lines up to avoid this. applied to bpf-next

Yes, you're right. Sorry that I didn't consider this case. Thanks for pointing it out.

> 
>>         /* OK to update prog_array map then delete element from the map. */
>>
>> --
>> 2.34.1
>>
>>



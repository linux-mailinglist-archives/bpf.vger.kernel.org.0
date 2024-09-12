Return-Path: <bpf+bounces-39674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C2975E53
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 03:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE1F1C21930
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3596FBF;
	Thu, 12 Sep 2024 01:05:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD611712
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103140; cv=none; b=h4OyeffaLbM4rqvuJmy8W9ptU7LJZfKmPn4rMGFrIDDmZD0cFn3ah4ICQxo9mca4b2WIbcanK81/8jUscFJMm8A7CqHCTIJQzcIX9xDJFUT8Pp1Wm0mDipF3+WOLEnVcazgVdKdnuRmh5WrzafY3TIstgo/ca2Ol6SA64CnLL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103140; c=relaxed/simple;
	bh=bW6sEjZv8xfpjK+gpi6gLcChn0Tj1RV7TOKYM7Zzu1I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LdBt78jhrKOfQwT6TQrQVAYLZuvic3YOaTvOVtrJovqZ35TheGJeAD6JWDSVDJjOsf8U4iA/j4iIxrVbhKiMl+unFC1szIYXzyUgbSSAWeDAQFiTgmyQI3c4Ay0clftALacB9IHHz1AEQp22qCMlHOzCgKukw6cvhkUfd0VZPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X3zkc11Kcz4f3jQP
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:05:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 69E7B1A16B0
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:05:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBnuoZUPuJmZhglBA--.12883S2;
	Thu, 12 Sep 2024 09:05:28 +0800 (CST)
Subject: Re: [RESEND][PATCH bpf 2/2] selftests/bpf: Add more test case for
 field flattening
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
 <20240911110557.2759801-3-houtao@huaweicloud.com>
 <4a46fa4393545f54a76f0ffd2fa19d3f0a978d1f.camel@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f5d93124-0f9d-dca8-a11d-a1d21bdf6432@huaweicloud.com>
Date: Thu, 12 Sep 2024 09:05:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4a46fa4393545f54a76f0ffd2fa19d3f0a978d1f.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBnuoZUPuJmZhglBA--.12883S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWkJrW8JFW8ZFyfGr1UGFg_yoW8GF47pa
	48Xa9akFWIqwnrXw1UXa9rGrWrtrZ7WF1Iyr15tr1UtFnxJr97Xr4xKa1UGr9xWrWvgr1a
	v3s2vFZxuw1kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 9/12/2024 1:07 AM, Eduard Zingerman wrote:
> On Wed, 2024-09-11 at 19:05 +0800, Hou Tao wrote:
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
>> index a988d2823b52..e9cb93ce9533 100644
>> --- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
>> +++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
>> @@ -10,6 +10,21 @@
>>  
>>  char _license[] SEC("license") = "GPL";
>>  
>> +struct kptr_nested_array_2 {
>> +	struct bpf_cpumask __kptr * mask;
>> +};
>> +
>> +struct kptr_nested_array_1 {
>> +	/* Make btf_parse_fields() in map_create() return -E2BIG */
>> +	struct kptr_nested_array_2 d_2[BTF_FIELDS_MAX + 1];
> Hi Huo,
>
> I think some headers are missing, I see the following error when
> compiling this test:
>
> progs/cpumask_failure.c:19:33: error: use of undeclared identifier 'BTF_FIELDS_MAX'; did you mean 'BTF_KIND_MAX'?
>    19 |         struct kptr_nested_array_2 d_2[BTF_FIELDS_MAX + 1];
>       |                                        ^~~~~~~~~~~~~~
>       |                                        BTF_KIND_MAX
>
> [...]

BTF_FIELDS_MAX should be defined in vmlinux.h. Could you please check
whether or not it is present ? It seems that BPF CI reports the same
problem for  build-x86_64-llvm-17/build-x86_64-llvm-18 [1], but others
build are OK.  Do you know  is there anything special about
build-x86_64-llvm-17/18 ?



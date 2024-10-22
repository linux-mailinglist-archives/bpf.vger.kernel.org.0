Return-Path: <bpf+bounces-42758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11AC9A9B33
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A955B283B13
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914AE14D433;
	Tue, 22 Oct 2024 07:37:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B014EC6E
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582640; cv=none; b=p5eWUJgyPAgUGOLhRDI/xrxHbAmyDPn5jhtTBzIKnVv/Kpt3J2D45lb+UJzqybMP69BvTdp6u1GxhTfHaBzXNeZy6Jl6z9VRPGwdZmVdIrW7q/SE3QlQuxJMHkB8bz5UrL8rym1ewvvKMjmwBtOnlQCTnO1YnDm/yNZtO59+eZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582640; c=relaxed/simple;
	bh=t3DUVH4J9m8H1ztKN5Bz8VjiYQQ/ozeZyVt3pWgtYZo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B87L00Owng75f+ZTGEPGNuE1m/PhOp8eNXSVPy3/73xTm+KqxXbUHx3xkB+iuUCbk+pb4KEyShn07YCJDTdeCTiA5ht1Ur06lkUyop6JUOyFmmT1EdK8USGYn3Jo8bK6MgK+SASq6Qf04fS2NLIi9JUysPGrlgjjhn+cPAARdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXkX83PmKz4f3kty
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:36:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A61161A0568
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:37:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCnJ8QoVhdnWnsnEw--.1057S2;
	Tue, 22 Oct 2024 15:37:13 +0800 (CST)
Subject: Re: [PATCH bpf v2 0/7] Misc fixes for bpf
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Yafang Shao
 <laoar.shao@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <CAEf4BzZ+J9P327biUtKu6Mqa=vpWk=qdgxt8dmAcy=dNFvaJHQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <d49fa2f4-f743-c763-7579-c3cab4dd88cb@huaweicloud.com>
Date: Tue, 22 Oct 2024 15:37:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZ+J9P327biUtKu6Mqa=vpWk=qdgxt8dmAcy=dNFvaJHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCnJ8QoVhdnWnsnEw--.1057S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw43Xr45uFWDurWfJw1DJrb_yoW8AFy3pF
	Wft3W5W3ykJa9Fvwn2k34IgF9YkFnxKFWUXry5Jw1rAF17ZF1Igr10ga15uF9xJryftF17
	Zw4v93Z3Zay7Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU07PEDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Andrii,

On 10/22/2024 7:11 AM, Andrii Nakryiko wrote:
> On Sun, Oct 20, 2024 at 6:28 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> The patch set is just a bundle of fixes. Patch #1 fixes the out-of-bound
>> for sockmap link fdinfo. Patch #2 adds a static assertion to guarantee
>> such out-of-bound access will never happen again. Patch #3 fixes the
>> kmemleak report when parsing the mount options for bpffs. Patch #4~#7
>> fix issues related to bits iterator.
>>
>> Please check the individual patches for more details. And comments are
>> always welcome.
>>
>> v2:
>>  * patch #1: update tools/include/uapi/linux/bpf.h as well (Alexei)
>>  * patch #2: new patch. Add a static assertion for bpf_link_type_strs[] (Andrii)
>>  * patch #4: doesn't set nr_bits to zero in bpf_iter_bits_next (Andrii)
>>  * patch #5: use 512 as the maximal value of nr_words
>>  * patch #6: change the type of both bits and bits_copy to u64 (Andrii)
>>
>> v1: https://lore.kernel.org/bpf/20241008091718.3797027-1-houtao@huaweicloud.com/
>>
> You have three separate groups of fixes, please send them separately
> so they can be landed separately and tested separately:
>
>> Hou Tao (7):
>>   bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
>>   bpf: Add assertion for the size of bpf_link_type_strs[]
> first, link type fixes
>
>>   bpf: Preserve param->string when parsing mount options
> parsing fix
>
>>   bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
>>   bpf: Check the validity of nr_words in bpf_iter_bits_new()
>>   bpf: Use __u64 to save the bits in bits iterator
>>   selftests/bpf: Test multiplication overflow of nr_bits in bits_iter
> bits iter fixes

Thanks for the suggestion. Will do in v3.



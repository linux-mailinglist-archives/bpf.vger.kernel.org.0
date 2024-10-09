Return-Path: <bpf+bounces-41334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E1995D09
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B3E1C20C7E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6603A1CD;
	Wed,  9 Oct 2024 01:32:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A560364AE
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437548; cv=none; b=WEgsb392THK+bAKFYCm+WwQC+gDDjY6k9kBBFgg4bE7eB3vr6d4DzHCoxJ6KHgp8LH/WhPB/GhwiUEI1WLZRpE5neXMwl6x3+YZ4dXBPUR/Navd5Rpj0P0bQOLXEbnLw+CfmkKfO3ww4LyEEm/ooZM7hB/EEmhJysotz2MRDymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437548; c=relaxed/simple;
	bh=lPZIkdP+UXnBTcsNRdUVFU49QHPf7oZzRZSXcKuGg90=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PgUHqkOr3vb6b2PKtAU+kJ8ICh75XLS3muY2CTodVuZRaZiwwa6w38cDVmXkso3CPAZOTCsQPZq9GElxGcbNjAFeEfpPd4ry7wLt9Tq0tq9ZoJqCamPI786PmWWypspl+38xqZc2w65qOw8glSVw339rxZg36eR/HyRhWen0SrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XNb394HYvz4f3jHg
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 09:32:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6A6151A058E
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 09:32:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgC3DIki3QVn8j_TDQ--.33711S2;
	Wed, 09 Oct 2024 09:32:22 +0800 (CST)
Subject: Re: [PATCH bpf 1/7] bpf: Add the missing BPF_LINK_TYPE invocation for
 sockmap
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
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-2-houtao@huaweicloud.com>
 <CAEf4BzZOo37TZM_tcEq_FV4v3LWXYmrUGAtOr+7ctGLF-w26wg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <20f2714b-39a7-1530-6a7e-af8b7c2e8ee5@huaweicloud.com>
Date: Wed, 9 Oct 2024 09:32:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZOo37TZM_tcEq_FV4v3LWXYmrUGAtOr+7ctGLF-w26wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgC3DIki3QVn8j_TDQ--.33711S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1xtr13CrWfuw1kWFyrXrb_yoW8uF15pF
	n5JF4DGa18u3yUZry5tFWSvry0gw4j9ryUKrZ8Wr1jva4avF1kuF1kGry5AF9aqrWxJF4x
	X3WjkrZ3C3sxZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/9/2024 2:33 AM, Andrii Nakryiko wrote:
> On Tue, Oct 8, 2024 at 2:05 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> There is an out-of-bounds read in bpf_link_show_fdinfo() for the sockmap
>> link fd. Fix it by adding the missing BPF_LINK_TYPE invocation for
>> sockmap link
>>
>> Also add comments for bpf_link_type to prevent missing updates in the
>> future.
>>
>> Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  include/linux/bpf_types.h | 1 +
>>  include/uapi/linux/bpf.h  | 3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>> index 9f2a6b83b49e..fa78f49d4a9a 100644
>> --- a/include/linux/bpf_types.h
>> +++ b/include/linux/bpf_types.h
>> @@ -146,6 +146,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
>> +BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
>>  #endif
>>  #ifdef CONFIG_PERF_EVENTS
>>  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index e8241b320c6d..4a939c90dc2e 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1121,6 +1121,9 @@ enum bpf_attach_type {
>>
>>  #define MAX_BPF_ATTACH_TYPE __MAX_BPF_ATTACH_TYPE
>>
>> +/* Add BPF_LINK_TYPE(type, name) in bpf_types.h to keep bpf_link_type_strs[]
>> + * in sync with the definitions below.
>> + */
>
> Let's also add some static assert making sure that bpf_link_type_strs
> (and probably same for other types) size is equal to
> __MAX_BPF_LINK_TYPE? Comment is good to remind us, but compilation
> error is better.

Good idea. Will check for other candidates for static assert. Will do in v2.
>
>>  enum bpf_link_type {
>>         BPF_LINK_TYPE_UNSPEC = 0,
>>         BPF_LINK_TYPE_RAW_TRACEPOINT = 1,
>> --
>> 2.29.2
>>



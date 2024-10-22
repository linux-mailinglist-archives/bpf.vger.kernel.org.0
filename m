Return-Path: <bpf+bounces-42757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793599A9B2C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2B82837CF
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357114F9F4;
	Tue, 22 Oct 2024 07:36:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753C126C15
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582564; cv=none; b=bTbudYnRJAwNddIkwGalXUH4K3LwijlWbsmItkgWbKPkksJFhQlc1b05bR2THbGtFsiqaY2lAw92qoHkC3w6a6dB6HD6M0uKX2eBwL8XYjQl1RXnvln6q/6Gt5/h5ioYquUQMSyVe6Awyw5vXlcv13uZAET25FTaL+0s1It06wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582564; c=relaxed/simple;
	bh=MNb4DajWdy3JgsUyHaQZ8Fs1kK13uyzq14xXd2TEAhI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k6QUgIuVVEcQ4YiUMGyeroSSFPaBm7aSPaI2Bz+ccIupkjuenuPZn+lfnXZY6wFkjW3VVEgtHzCuoBu1SMKF90Tdklpp9oPH2aG60eHHTINw7+iyy4kVVlRV+JZpdGwP0t/Gv6EktqBdP8SbOtZ7Tz/GfXlClc2O3mD3+woljmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXkVh36mVz4f3jsK
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:35:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C8AE41A0196
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:35:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCn3MjZVRdnFWUnEw--.1298S2;
	Tue, 22 Oct 2024 15:35:57 +0800 (CST)
Subject: Re: [PATCH bpf v2 2/7] bpf: Add assertion for the size of
 bpf_link_type_strs[]
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 John Fastabend <john.fastabend@gmail.com>, Yafang Shao
 <laoar.shao@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-3-houtao@huaweicloud.com> <ZxYOX9_sIrSKGFB2@krava>
 <CAEf4BzbFBbTDGSwTdgFJG5poFpCrjjpPO9OujYVZXPxTEUXqeQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <437ff5b4-4f38-cb3a-8491-d8c7e5cfb8c6@huaweicloud.com>
Date: Tue, 22 Oct 2024 15:35:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbFBbTDGSwTdgFJG5poFpCrjjpPO9OujYVZXPxTEUXqeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCn3MjZVRdnFWUnEw--.1298S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF48KFWfur4UAry5CFyrtFb_yoW7Wr13pF
	1rJF4DG3y8Zw4xXry3tFW2vry8Kw4UW34UJr1kWF1Yv34avrnF9F1jqryY9r9IgrZ7JF17
	Jw1j9r93Zr13A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/22/2024 7:02 AM, Andrii Nakryiko wrote:
> On Mon, Oct 21, 2024 at 1:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>> On Mon, Oct 21, 2024 at 09:39:59AM +0800, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> If a corresponding link type doesn't invoke BPF_LINK_TYPE(), accessing
>>> bpf_link_type_strs[link->type] may result in out-of-bound access.
>>>
>>> To prevent such missed invocations in the future, the following static
>>> assertion seems feasible:
>>>
>>>   BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) != __MAX_BPF_LINK_TYPE)
>>>
>>> However, this doesn't work well. The reason is that the invocation of
>>> BPF_LINK_TYPE() for one link type is optional due to its CONFIG_XXX
>>> dependency and the elements in bpf_link_type_strs[] will be sparse. For
>>> example, if CONFIG_NET is disabled, the size of bpf_link_type_strs will
>>> be BPF_LINK_TYPE_UPROBE_MULTI + 1.
>>>
>>> Therefore, in addition to the static assertion, remove all CONFIG_XXX
>>> conditions for the invocation of BPF_LINK_TYPE(). If these CONFIG_XXX
>>> conditions become necessary later, the fix may need to be revised (e.g.,
>>> to check the validity of link_type in bpf_link_show_fdinfo()).
>>>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  include/linux/bpf_types.h | 6 ------
>>>  kernel/bpf/syscall.c      | 2 ++
>>>  2 files changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>>> index fa78f49d4a9a..6b7eabe9a115 100644
>>> --- a/include/linux/bpf_types.h
>>> +++ b/include/linux/bpf_types.h
>>> @@ -136,21 +136,15 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
>>>
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
>>> -#ifdef CONFIG_CGROUP_BPF
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
>>> -#endif
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
>>> -#ifdef CONFIG_NET
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
>>> -#endif
>>> -#ifdef CONFIG_PERF_EVENTS
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
>>> -#endif
> I'm not sure what's the implication here, but I'd avoid doing that.
> But see below.

OK.
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
>>>  BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 8cfa7183d2ef..9f335c379b05 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -3071,6 +3071,8 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>>>       const struct bpf_prog *prog = link->prog;
>>>       char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
>>>
>>> +     BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) != __MAX_BPF_LINK_TYPE);
> If this is useless, why are you adding it?

It will work after removing these CONFIG_XXX dependencies for
BPF_LINK_TYPE() invocations.
>
> Let's instead do a NULL check inside bpf_link_show_fdinfo() to handle
> sparsity. And to avoid out-of-bounds, just add
>
> [__MAX_BPF_LINK_TYPE] = NULL,
>
> into the definition of bpf_link_type_strs

Instead of outputting a null string for a link_type which didn't invoke
BPF_LINK_TYPE, is outputting the numerical value of link->type more
reasonable as shown below ?

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2873302faf39..9a02cd914ed8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3073,14 +3073,15 @@ static void bpf_link_show_fdinfo(struct seq_file
*m, struct file *filp)
        const struct bpf_link *link = filp->private_data;
        const struct bpf_prog *prog = link->prog;
        char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
+       enum bpf_link_type type;

+       if (type < ARRAY_SIZE(bpf_link_type_strs) &&
bpf_link_type_strs[type])
+               seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+       else
+               seq_printf(m, "link_type:\t[%d]\n", type);
+
+       seq_printf(m, "link_id:\t%u\n", link->id);

-       seq_printf(m,
-                  "link_type:\t%s\n"
-                  "link_id:\t%u\n",
-                  bpf_link_type_strs[link->type],
-                  link->id);

>
> pw-bot: cr
>
>> I wonder it'd be simpler to just kill BPF_LINK_TYPE completely
>> and add link names directly to bpf_link_type_strs array..
>> it seems it's the only purpose of the BPF_LINK_TYPE macro
>>
> This seems like a bit too short-sighted approach, let's not go there just yet.
>
>> jirka



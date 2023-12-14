Return-Path: <bpf+bounces-17754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D75812435
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AF0282615
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7F645;
	Thu, 14 Dec 2023 01:01:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B4E0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:01:04 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SrDYh2ntbz4f3lDG
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:00:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 612311A035B
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:01:01 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXpgzJU3plj7FVDg--.20307S2;
	Thu, 14 Dec 2023 09:01:01 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Limit the number of kprobes when
 attaching program to multiple kprobes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
References: <20231213112531.3775079-1-houtao@huaweicloud.com>
 <20231213112531.3775079-3-houtao@huaweicloud.com>
 <CAEf4BzZerWpU-GW8iqZYHue5qbTrdWXZp1WKvrkxLkDj1y2Lww@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <faf3159c-7479-e2fb-e68b-b173a1cb8b88@huaweicloud.com>
Date: Thu, 14 Dec 2023 09:00:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZerWpU-GW8iqZYHue5qbTrdWXZp1WKvrkxLkDj1y2Lww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXpgzJU3plj7FVDg--.20307S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ury7Cr4rJF15KF1rWr4kJFb_yoW8Wry5pF
	ykJayDAr4rXF47K3Wqva1Fqry2vws0g3y7GF4qqr13ZF4UZrZ5Wr12gr4YvF1FvrZYkrWx
	XFsFqryYvrW7ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/14/2023 7:32 AM, Andrii Nakryiko wrote:
> On Wed, Dec 13, 2023 at 3:24 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> An abnormally big cnt may also be assigned to kprobe_multi.cnt when
>> attaching multiple kprobes. It will trigger the following warning in
>> kvmalloc_node():
>>
>>         if (unlikely(size > INT_MAX)) {
>>             WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>>             return NULL;
>>         }
>>
>> Fix the warning by limiting the maximal number of kprobes in
>> bpf_kprobe_multi_link_attach().
>>
>> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/trace/bpf_trace.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 2d1201f7b554..944678529f5c 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -43,6 +43,7 @@
>>         rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
>>
>>  #define MAX_UPROBE_MULTI_CNT (1U << 20)
>> +#define MAX_KPROBE_MULTI_CNT (1U << 20)
>>
>>  #ifdef CONFIG_MODULES
>>  struct bpf_trace_module {
>> @@ -2970,7 +2971,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>>                 return -EINVAL;
>>
>>         cnt = attr->link_create.kprobe_multi.cnt;
>> -       if (!cnt)
>> +       if (!cnt || cnt > MAX_KPROBE_MULTI_CNT)
>>                 return -EINVAL;
> let's return -E2BIG for `cnt > MAX` cases? Same in another patch

Good point. Will do in v3.
>>         size = cnt * sizeof(*addrs);
>> --
>> 2.29.2
>>



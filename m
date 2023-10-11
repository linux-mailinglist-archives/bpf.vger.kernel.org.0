Return-Path: <bpf+bounces-11864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D677C4A9B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 08:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796941C20F60
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A415E97;
	Wed, 11 Oct 2023 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB64C17986
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 06:31:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE7E98
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 23:31:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S52x30T2vz4f3lVh
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 14:31:51 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAnsdBWQSZlhxytCg--.8746S2;
	Wed, 11 Oct 2023 14:31:53 +0800 (CST)
Subject: Re: [PATCH bpf-next 4/6] bpf: Move the declaration of
 __bpf_obj_drop_impl() to internal.h
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
 <20231007135106.3031284-5-houtao@huaweicloud.com>
 <ZSQqRuC3aBHcrUZ9@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <34d9c871-223c-7598-dc1a-b1dda27073d0@huaweicloud.com>
Date: Wed, 11 Oct 2023 14:31:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZSQqRuC3aBHcrUZ9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAnsdBWQSZlhxytCg--.8746S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1fKFWrAFyfAFWxXryDGFg_yoW8Aw18pF
	s8Ga1UCr40qF4I9wnFgF4xCFW5tw4UKr4jk3WkXr1Fyr1aqF92gw1vgr13WFy3tr47Kr40
	vF1FgFyFv34UX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbG2NtUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/10/2023 12:28 AM, Stanislav Fomichev wrote:
> On 10/07, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> both syscall.c and helpers.c have the declaration of
>> __bpf_obj_drop_impl(), so just move it to a common header file.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/helpers.c  |  3 +--
>>  kernel/bpf/internal.h | 11 +++++++++++
>>  kernel/bpf/syscall.c  |  4 ++--
>>  3 files changed, 14 insertions(+), 4 deletions(-)
>>  create mode 100644 kernel/bpf/internal.h
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index dd1c69ee3375..07f49f8831c0 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/bpf_mem_alloc.h>
>>  #include <linux/kasan.h>
>>  
>> +#include "internal.h"
>>  #include "../../lib/kstrtox.h"
>>  
>>  /* If kernel subsystem is allowing eBPF programs to call this function,
>> @@ -1808,8 +1809,6 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>>  	}
>>  }
>>  
>> -void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
>> -
>>  void bpf_list_head_free(const struct btf_field *field, void *list_head,
>>  			struct bpf_spin_lock *spin_lock)
>>  {
>> diff --git a/kernel/bpf/internal.h b/kernel/bpf/internal.h
>> new file mode 100644
>> index 000000000000..e233ea83eb0a
>> --- /dev/null
>> +++ b/kernel/bpf/internal.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd
>> + */
> Don't think copyright works this way? You can't move the code and
> claim authorship.
>
> In general, git tracks authors and contributors, so not sure
> why we still keep putting these explicit notices..
My bad. Thanks for the remainder. Will fix in v2.



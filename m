Return-Path: <bpf+bounces-11865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56BB7C4ACE
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 08:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1528226E
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22557FBE4;
	Wed, 11 Oct 2023 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1B1798D
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 06:40:55 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872349D
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 23:40:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S537N2wQJz4f3jql
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 14:40:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDXGztuQyZl34QNCg--.7060S2;
	Wed, 11 Oct 2023 14:40:49 +0800 (CST)
Subject: Re: [PATCH bpf-next 4/6] bpf: Move the declaration of
 __bpf_obj_drop_impl() to internal.h
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
 <20231007135106.3031284-5-houtao@huaweicloud.com>
 <20231009165642.vhxucl2nqnolspnw@MacBook-Pro-49.local>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <84184a18-f73b-3f21-ad22-327d452713d9@huaweicloud.com>
Date: Wed, 11 Oct 2023 14:40:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231009165642.vhxucl2nqnolspnw@MacBook-Pro-49.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDXGztuQyZl34QNCg--.7060S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GrWUWw4UCw1xCr1xur15Arb_yoW8JrykpF
	s8KFW0yr4jqF9rC347Zr4Ika45Xw4UGr1UK3WkXryYv3W2gF9Fgw1ktw13WFyftrW8KF40
	vr4YgFWFk34UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU1rMa5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/10/2023 12:56 AM, Alexei Starovoitov wrote:
> On Sat, Oct 07, 2023 at 09:51:04PM +0800, Hou Tao wrote:
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
> Pls use one of the existing headers. No need for new one.

Do you mean one of header files in include/linux, right ? Because there
is no proper header files under kernel/bpf. The best fit is
include/linux/bpf.h, but after modify bpf.h, multiple files need to be
rebuild: (e.g. under net/, kernel, drivers/net, block/, fs/). Maybe it
is time to break bpf.h into multiple independent files ?



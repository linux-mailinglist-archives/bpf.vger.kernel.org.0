Return-Path: <bpf+bounces-17970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C18142F8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 08:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6681D281521
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EE1107A4;
	Fri, 15 Dec 2023 07:51:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AEC14F87
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ss1d26ythz4f3jLq
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:51:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 411DA1A097B
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:51:36 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAHCQ+EBXxlVKLMDg--.53920S2;
	Fri, 15 Dec 2023 15:51:36 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Cope with 512 bytes limit
 with bpf_global_percpu_ma
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
 <20231215001227.3254314-1-yonghong.song@linux.dev>
 <64834348-0758-e388-e57f-0b71d0be42c9@huaweicloud.com>
 <1e5463b1-2291-4df2-8338-5d4011d24037@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <db700cc2-b0fb-4442-e933-8d7c479c7cd0@huaweicloud.com>
Date: Fri, 15 Dec 2023 15:51:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1e5463b1-2291-4df2-8338-5d4011d24037@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAHCQ+EBXxlVKLMDg--.53920S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr48AF1xWFWxGFyktFWkJFb_yoW7WFyxpF
	ykJF15trWUJwn7Gw15tw1j9ryUXr48Jwn8Jry5JFyUJrZxtw10qr4Uur1v9F15Cr4vgw17
	Jwn0gr9ruF17ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/15/2023 3:38 PM, Yonghong Song wrote:
>
> On 12/14/23 7:33 PM, Hou Tao wrote:
>> Hi,
>>
>> On 12/15/2023 8:12 AM, Yonghong Song wrote:
>>> In the previous patch, the maximum data size for bpf_global_percpu_ma
>>> is 512 bytes. This breaks selftest test_bpf_ma. Let us adjust it
>>> accordingly. Also added a selftest to capture the verification failure
>>> when the allocation size is greater than 512.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>

SNIP
>>>   DEFINE_ARRAY_WITH_PERCPU_KPTR(192);
>>>   DEFINE_ARRAY_WITH_PERCPU_KPTR(256);
>>>   DEFINE_ARRAY_WITH_PERCPU_KPTR(512);
>>> -DEFINE_ARRAY_WITH_PERCPU_KPTR(1024);
>>> -DEFINE_ARRAY_WITH_PERCPU_KPTR(2048);
>>> -DEFINE_ARRAY_WITH_PERCPU_KPTR(4096);
>> Considering the update in patch "bpf: Avoid unnecessary extra percpu
>> memory allocation", the definition of DEFINE_ARRAY_WITH_PERCPU_KPTR()
>> needs update as well, because for 512-sized per-cpu kptr, the tests only
>> allocate for (512 - sizeof(void *)) bytes. And we could do
>> DEFINE_ARRAY_WITH_PERCPU_KPTR(8) test after the update. I could do that
>> after the patch-set is landed if you don't have time to do that.
>>
>> A bit of off-topic, but it is still relevant. I have a question about
>> how to forcibly generate BTF info for struct definition in the test ?
>> Currently, I have to include  bin_data_xx in the definition of
>> map_value, but I don't want to increase the size of map_value. I had
>> tried to use BTF_TYPE_EMIT() in prog just like in linux kernel, but it
>> didn't work.
>
> Since you mentioned the btf generation issue, I did some investigation.
> To workaround btf generation issue, we can use the method in
> prog_tests/local_kptr_stash.c:
>
> ====
> /* This is necessary so that LLVM generates BTF for node_data struct
>  * If it's not included, a fwd reference for node_data will be
> generated but
>  * no struct. Example BTF of "node" field in map_value when not included:
>  *
>  * [10] PTR '(anon)' type_id=35
>  * [34] FWD 'node_data' fwd_kind=struct
>  * [35] TYPE_TAG 'kptr_ref' type_id=34
>  *
>  * (with no node_data struct defined)
>  * Had to do the same w/ bpf_kfunc_call_test_release below
>  */
> struct node_data *just_here_because_btf_bug;
> struct refcounted_node *just_here_because_btf_bug2;
> ====

Totally missed it. Thanks for pointing it out to me.
>
> I have hacked the test_bpf_ma.c files and something like below
> should work to generate btf types:
>
>         struct bin_data_##_size { \
>                 char data[_size - sizeof(void *)]; \
>         }; \
> +       /* See Commit 5d8d6634ccc, force btf generation for type
> bin_data_##_size */    \
> +       struct bin_data_##_size *__bin_data_##_size; \
>         struct map_value_##_size { \
>                 struct bin_data_##_size __kptr * data; \
> -               /* To emit BTF info for bin_data_xx */ \
> -               struct bin_data_##_size not_used; \
>         }; \
>         struct { \
>                 __uint(type, BPF_MAP_TYPE_ARRAY); \
> @@ -40,8 +43,12 @@ int pid = 0;
>         } array_##_size SEC(".maps")
>  
>  #define DEFINE_ARRAY_WITH_PERCPU_KPTR(_size) \
> +       struct percpu_bin_data_##_size { \
> +               char data[_size]; \
> +       }; \
> +       struct percpu_bin_data_##_size *__percpu_bin_data_##_size; \
>         struct map_value_percpu_##_size { \
> -               struct bin_data_##_size __percpu_kptr * data; \
> +               struct percpu_bin_data_##_size __percpu_kptr * data; \
>         }; \
>         struct { \
>                 __uint(type, BPF_MAP_TYPE_ARRAY); \
>
> I have a prototype to ensure the type (for percpu kptr) removing these
> '- sizeof(void *)' and enabling DEFINE_ARRAY_WITH_PERCPU_KPTR().
> Once we resolved the check_obj_size() issue, I can then post v3.

Thanks for the update and it looks fine to me. Looking forwards to v3.
>
>>>     SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>>>   int test_batch_alloc_free(void *ctx)
>>> @@ -259,9 +256,6 @@ int test_batch_percpu_alloc_free(void *ctx)
>>>       CALL_BATCH_PERCPU_ALLOC_FREE(192, 128, 6);
>>>       CALL_BATCH_PERCPU_ALLOC_FREE(256, 128, 7);
>>>       CALL_BATCH_PERCPU_ALLOC_FREE(512, 64, 8);
>>> -    CALL_BATCH_PERCPU_ALLOC_FREE(1024, 32, 9);
>>> -    CALL_BATCH_PERCPU_ALLOC_FREE(2048, 16, 10);
>>> -    CALL_BATCH_PERCPU_ALLOC_FREE(4096, 8, 11);
>>>         return 0;
>>>   }
>>> @@ -283,9 +277,6 @@ int test_percpu_free_through_map_free(void *ctx)
>>>       CALL_BATCH_PERCPU_ALLOC(192, 128, 6);
>>>       CALL_BATCH_PERCPU_ALLOC(256, 128, 7);
>>>       CALL_BATCH_PERCPU_ALLOC(512, 64, 8);
>>> -    CALL_BATCH_PERCPU_ALLOC(1024, 32, 9);
>>> -    CALL_BATCH_PERCPU_ALLOC(2048, 16, 10);
>>> -    CALL_BATCH_PERCPU_ALLOC(4096, 8, 11);
>>>         return 0;
>>>   }



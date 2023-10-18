Return-Path: <bpf+bounces-12495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DE07CD20E
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 03:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF551C20CA9
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 01:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF31FD3;
	Wed, 18 Oct 2023 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C764311C
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:58:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C8C6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:58:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S9D9Y6sdzz4f3jHg
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:42:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAHYVDzNy9ltvBADA--.61326S2;
	Wed, 18 Oct 2023 09:42:15 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <songliubraving@meta.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
 "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>,
 Eric Biggers <ebiggers@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
 "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-2-song@kernel.org>
 <CAEf4BzYbQzMU4T6KYt4UudXvZiPg4nQdQCxD9zqzoJLgqOE9bQ@mail.gmail.com>
 <0ABF7860-A331-4161-9599-C781E9650283@fb.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <33c93c8d-5da9-01ac-b72a-c3f62965ad1b@huaweicloud.com>
Date: Wed, 18 Oct 2023 09:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0ABF7860-A331-4161-9599-C781E9650283@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAHYVDzNy9ltvBADA--.61326S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kKry8Ww43tFWkWrW7Arb_yoWrGw1kpF
	W8GFWYkr48JFW7Jry2qF4xZ3Z09w40gr12gF97K340yryqvr97ur1jgr1UurnYyrWqgrW2
	vF4jgFW3ury3ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/18/2023 4:31 AM, Song Liu wrote:
>
>> On Oct 17, 2023, at 11:58 AM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>
>> On Fri, Oct 13, 2023 at 11:29 AM Song Liu <song@kernel.org> wrote:
>>> This kfunc can be used to read xattr of a file.
>>>
>>> Since vfs_getxattr() requires null-terminated string as input "name", a new
>>> helper bpf_dynptr_is_string() is added to check the input before calling
>>> vfs_getxattr().
>>>
>>> Signed-off-by: Song Liu <song@kernel.org>
>>> ---
>>> include/linux/bpf.h      | 12 +++++++++++
>>> kernel/trace/bpf_trace.c | 44 ++++++++++++++++++++++++++++++++++++++++
>>> 2 files changed, 56 insertions(+)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 61bde4520f5c..f14fae45e13d 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -2472,6 +2472,13 @@ static inline bool has_current_bpf_ctx(void)
>>>        return !!current->bpf_ctx;
>>> }
>>>
>>> +static inline bool bpf_dynptr_is_string(struct bpf_dynptr_kern *ptr)
>> is_zero_terminated would be more accurate? though there is nothing
>> really dynptr-specific here...
> is_zero_terminated sounds better. 
>
>>> +{
>>> +       char *str = ptr->data;
>>> +
>>> +       return str[__bpf_dynptr_size(ptr) - 1] == '\0';
>>> +}
>>> +
>>> void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
>>>
>>> void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>>> @@ -2708,6 +2715,11 @@ static inline bool has_current_bpf_ctx(void)
>>>        return false;
>>> }
>>>
>>> +static inline bool bpf_dynptr_is_string(struct bpf_dynptr_kern *ptr)
>>> +{
>>> +       return false;
>>> +}
>>> +
>>> static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
>>> {
>>> }
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index df697c74d519..946268574e05 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -24,6 +24,7 @@
>>> #include <linux/key.h>
>>> #include <linux/verification.h>
>>> #include <linux/namei.h>
>>> +#include <linux/fileattr.h>
>>>
>>> #include <net/bpf_sk_storage.h>
>>>
>>> @@ -1429,6 +1430,49 @@ static int __init bpf_key_sig_kfuncs_init(void)
>>> late_initcall(bpf_key_sig_kfuncs_init);
>>> #endif /* CONFIG_KEYS */
>>>
>>> +/* filesystem kfuncs */
>>> +__diag_push();
>>> +__diag_ignore_all("-Wmissing-prototypes",
>>> +                 "kfuncs which will be used in BPF programs");
>>> +
>>> +/**
>>> + * bpf_get_file_xattr - get xattr of a file
>>> + * @name_ptr: name of the xattr
>>> + * @value_ptr: output buffer of the xattr value
>>> + *
>>> + * Get xattr *name_ptr* of *file* and store the output in *value_ptr*.
>>> + *
>>> + * Return: 0 on success, a negative value on error.
>>> + */
>>> +__bpf_kfunc int bpf_get_file_xattr(struct file *file, struct bpf_dynptr_kern *name_ptr,
>>> +                                  struct bpf_dynptr_kern *value_ptr)
>>> +{
>>> +       if (!bpf_dynptr_is_string(name_ptr))
>>> +               return -EINVAL;
>> so dynptr can be invalid and name_ptr->data will be NULL, you should
>> account for that
> We can add a NULL check (or size check) here. 
>
>> and there could also be special dynptrs that don't have contiguous
>> memory region, so somehow you'd need to take care of that as well
> We can require the dynptr to be BPF_DYNPTR_TYPE_LOCAL. I don't think
> we need this for dynptr of skb or xdp. Would this be sufficient?

I think bpf_dynptr_is_rdonly() is also needed. Because the content of
dynptr may be modified by other bpf program and the zero-terminated
condition will not true. As suggested by Alexei, add string support in
verifier is a better choice.
>
> Thanks,
> Song
>
>>> +
>>> +       return vfs_getxattr(mnt_idmap(file->f_path.mnt), file_dentry(file), name_ptr->data,
>>> +                           value_ptr->data, __bpf_dynptr_size(value_ptr));
>>> +}



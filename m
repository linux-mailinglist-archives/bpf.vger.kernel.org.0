Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2828620557
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 01:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiKHAxp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 19:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiKHAxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 19:53:39 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98370FD35
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 16:53:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5qN05vFPz4f42rg
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 08:53:20 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDHvayAqGljKsyXAA--.18002S2;
        Tue, 08 Nov 2022 08:53:23 +0800 (CST)
Subject: Re: [PATCH bpf-next] bpf: Pass map file to .map_update_batch directly
To:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>, houtao1@huawei.com
References: <20221107075537.1445644-1-houtao@huaweicloud.com>
 <ef14ccf1-fc17-57df-fba7-162845be4722@meta.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <7d81cf6f-9881-32cf-d981-9360e33b5f4d@huaweicloud.com>
Date:   Tue, 8 Nov 2022 08:53:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ef14ccf1-fc17-57df-fba7-162845be4722@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDHvayAqGljKsyXAA--.18002S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGFWkZF13Jr4DWw1rZF4kCrg_yoWDXF4DpF
        95tFyUGryUWr18Xr15Jw1UXa4UAr1UJw1UJr1DJa4UAr4UXry2gr1UXF1q9r15Jr48Jr4U
        Jr1jqry8Zw47Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrcTmDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 11/8/2022 8:08 AM, Yonghong Song wrote:
>
>
> On 11/6/22 11:55 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Currently generic_map_update_batch() will get map file from
>> attr->batch.map_fd and pass it to bpf_map_update_value(). The problem is
>> map_fd may have been closed or reopened as a different file type and
>> generic_map_update_batch() doesn't check the validity of map_fd.
>>
>> It doesn't incur any problem as for now, because only
>> BPF_MAP_TYPE_PERF_EVENT_ARRAY uses the passed map file and it doesn't
>> support batch update operation. But it is better to fix the potential
>> use of an invalid map file.
>
> I think we don't have problem here. The reason is in bpf_map_do_batch()
> we have
>     f = fdget(ufd);
>     ...
>     BPF_DO_BATCH(map->ops->map_update_batch);
>     fdput(f)
>
> So the original ufd is still valid during map->ops->map_update_batch
> which eventually may call generic_map_update_batch() which tries to
> do fdget(ufd) again.
The previous fdget() only guarantees the liveness of struct file. If the map fd
is closed by another thread concurrently, the fd will released by pick_file() as
show below:

static struct file *pick_file(struct files_struct *files, unsigned fd)
{
        struct fdtable *fdt = files_fdtable(files);
        struct file *file;

        file = fdt->fd[fd];
        if (file) {
                rcu_assign_pointer(fdt->fd[fd], NULL);
                __put_unused_fd(files, fd);
        }
        return file;
}

So the second fdget(udf) may return a NULL file or a different file.

>
> Did I miss anything here?
>
>>
>> Checking the validity of map file returned from fdget() in
>> generic_map_update_batch() can not fix the problem, because the returned
>> map file may be different with map file got in bpf_map_do_batch() due to
>> the reopening of fd, so just passing the map file directly to
>> .map_update_batch() in bpf_map_do_batch().
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   include/linux/bpf.h  |  5 +++--
>>   kernel/bpf/syscall.c | 31 ++++++++++++++++++-------------
>>   2 files changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 798aec816970..20cfe88ee6df 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -85,7 +85,8 @@ struct bpf_map_ops {
>>       int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>>                          const union bpf_attr *attr,
>>                          union bpf_attr __user *uattr);
>> -    int (*map_update_batch)(struct bpf_map *map, const union bpf_attr *attr,
>> +    int (*map_update_batch)(struct bpf_map *map, struct file *map_file,
>> +                const union bpf_attr *attr,
>>                   union bpf_attr __user *uattr);
>>       int (*map_delete_batch)(struct bpf_map *map, const union bpf_attr *attr,
>>                   union bpf_attr __user *uattr);
>> @@ -1776,7 +1777,7 @@ void bpf_map_init_from_attr(struct bpf_map *map, union
>> bpf_attr *attr);
>>   int  generic_map_lookup_batch(struct bpf_map *map,
>>                     const union bpf_attr *attr,
>>                     union bpf_attr __user *uattr);
>> -int  generic_map_update_batch(struct bpf_map *map,
>> +int  generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>>                     const union bpf_attr *attr,
>>                     union bpf_attr __user *uattr);
>>   int  generic_map_delete_batch(struct bpf_map *map,
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 85532d301124..cb8a87277bf8 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -175,8 +175,8 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
>>           synchronize_rcu();
>>   }
>>   -static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
>> -                void *value, __u64 flags)
>> +static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>> +                void *key, void *value, __u64 flags)
>>   {
>>       int err;
>>   @@ -190,7 +190,7 @@ static int bpf_map_update_value(struct bpf_map *map,
>> struct fd f, void *key,
>>              map->map_type == BPF_MAP_TYPE_SOCKMAP) {
>>           return sock_map_update_elem_sys(map, key, value, flags);
>>       } else if (IS_FD_PROG_ARRAY(map)) {
>> -        return bpf_fd_array_map_update_elem(map, f.file, key, value,
>> +        return bpf_fd_array_map_update_elem(map, map_file, key, value,
>>                               flags);
>>       }
>>   @@ -205,12 +205,12 @@ static int bpf_map_update_value(struct bpf_map *map,
>> struct fd f, void *key,
>>                                  flags);
>>       } else if (IS_FD_ARRAY(map)) {
>>           rcu_read_lock();
>> -        err = bpf_fd_array_map_update_elem(map, f.file, key, value,
>> +        err = bpf_fd_array_map_update_elem(map, map_file, key, value,
>>                              flags);
>>           rcu_read_unlock();
>>       } else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
>>           rcu_read_lock();
>> -        err = bpf_fd_htab_map_update_elem(map, f.file, key, value,
>> +        err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
>>                             flags);
>>           rcu_read_unlock();
>>       } else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
>> @@ -1390,7 +1390,7 @@ static int map_update_elem(union bpf_attr *attr,
>> bpfptr_t uattr)
>>           goto free_key;
>>       }
>>   -    err = bpf_map_update_value(map, f, key, value, attr->flags);
>> +    err = bpf_map_update_value(map, f.file, key, value, attr->flags);
>>         kvfree(value);
>>   free_key:
>> @@ -1576,16 +1576,14 @@ int generic_map_delete_batch(struct bpf_map *map,
>>       return err;
>>   }
>>   -int generic_map_update_batch(struct bpf_map *map,
>> +int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>>                    const union bpf_attr *attr,
>>                    union bpf_attr __user *uattr)
>>   {
>>       void __user *values = u64_to_user_ptr(attr->batch.values);
>>       void __user *keys = u64_to_user_ptr(attr->batch.keys);
>>       u32 value_size, cp, max_count;
>> -    int ufd = attr->batch.map_fd;
>>       void *key, *value;
>> -    struct fd f;
>>       int err = 0;
>>         if (attr->batch.elem_flags & ~BPF_F_LOCK)
>> @@ -1612,7 +1610,6 @@ int generic_map_update_batch(struct bpf_map *map,
>>           return -ENOMEM;
>>       }
>>   -    f = fdget(ufd); /* bpf_map_do_batch() guarantees ufd is valid */
>>       for (cp = 0; cp < max_count; cp++) {
>>           err = -EFAULT;
>>           if (copy_from_user(key, keys + cp * map->key_size,
>> @@ -1620,7 +1617,7 @@ int generic_map_update_batch(struct bpf_map *map,
>>               copy_from_user(value, values + cp * value_size, value_size))
>>               break;
>>   -        err = bpf_map_update_value(map, f, key, value,
>> +        err = bpf_map_update_value(map, map_file, key, value,
>>                          attr->batch.elem_flags);
>>             if (err)
>> @@ -1633,7 +1630,6 @@ int generic_map_update_batch(struct bpf_map *map,
>>         kvfree(value);
>>       kvfree(key);
>> -    fdput(f);
>>       return err;
>>   }
>>   @@ -4435,6 +4431,15 @@ static int bpf_task_fd_query(const union bpf_attr
>> *attr,
>>           err = fn(map, attr, uattr);    \
>>       } while (0)
>>   +#define BPF_DO_BATCH_WITH_FILE(fn)            \
>> +    do {                        \
>> +        if (!fn) {                \
>> +            err = -ENOTSUPP;        \
>> +            goto err_put;            \
>> +        }                    \
>> +        err = fn(map, f.file, attr, uattr);    \
>> +    } while (0)
>> +
>>   static int bpf_map_do_batch(const union bpf_attr *attr,
>>                   union bpf_attr __user *uattr,
>>                   int cmd)
>> @@ -4470,7 +4475,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
>>       else if (cmd == BPF_MAP_LOOKUP_AND_DELETE_BATCH)
>>           BPF_DO_BATCH(map->ops->map_lookup_and_delete_batch);
>>       else if (cmd == BPF_MAP_UPDATE_BATCH)
>> -        BPF_DO_BATCH(map->ops->map_update_batch);
>> +        BPF_DO_BATCH_WITH_FILE(map->ops->map_update_batch);
>>       else
>>           BPF_DO_BATCH(map->ops->map_delete_batch);
>>   err_put:


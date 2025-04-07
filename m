Return-Path: <bpf+bounces-55378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C693A7D234
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 04:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1707A38D1
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 02:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF719C56C;
	Mon,  7 Apr 2025 02:47:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115279FD
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743994025; cv=none; b=Hxz2tea3xWZWYl5zPwoxCFek4gofofnsUFmnTFeBDrh/pOv0SJtCyjGJkNg0eAu5HnOXiXbT6ayB5YizANFA/e8ev92eoMBBQHo/uO7uz14mM3y1nfRiFOZl2+UDf6BSSCsImWpCQStaht0aWgnQU38utdwcGdRw97UG3aFXddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743994025; c=relaxed/simple;
	bh=3tXwFH/5vB3NscpFbewVD7LOhI531iTJyek0QnlH8ME=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k8daEUBo8KkzzGb1fkxn5sL3fTEsdtcm07uYNXYfXc3d4J5ncWXkANhRy7d7tNxU+y/qmRyCvm/G6mJJ/r/E3vs5ZJj2BNl1ItKU7p3nzFdXcjOAEEBGDYh0sJ1Ytswz2hr4K1zhzRFbwjFRa+3g5TYoYaXh2QxeI59lo5WwYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZWDB71mYRz4f3jt7
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 10:46:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 318051A1B78
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 10:46:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBnF3idPPNnGDdvIg--.26211S2;
	Mon, 07 Apr 2025 10:46:56 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 15/16] selftests/bpf: Add test cases for hash
 map with dynptr key
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20250327083455.848708-1-houtao@huaweicloud.com>
 <20250327083455.848708-16-houtao@huaweicloud.com>
 <CAEf4BzY6Y=40NHs12r3Jb7u_N8CVapwRuF09+dmxBH85J2t88w@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <34a1d3a2-0b63-7f11-9da2-5966b24e179b@huaweicloud.com>
Date: Mon, 7 Apr 2025 10:46:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzY6Y=40NHs12r3Jb7u_N8CVapwRuF09+dmxBH85J2t88w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBnF3idPPNnGDdvIg--.26211S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wryftr1UWr4fZw4fXr1rXrb_yoWftF1UpF
	Z5G342kr4kXF1Iqw13Ww4xZF4Fyr4kXw4UGrZ5t348Ar15uF9avF18KF4rCFsYy3909r4S
	v3yjqr98ua1kA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 4/5/2025 1:58 AM, Andrii Nakryiko wrote:
> On Thu, Mar 27, 2025 at 1:23 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Add three positive test cases to test the basic operations on the
>> dynptr-keyed hash map. The basic operations include lookup, update,
>> delete and get_next_key. These operations are exercised both through
>> bpf syscall and bpf program. These three test cases use different map
>> keys. The first test case uses both bpf_dynptr and a struct with only
>> bpf_dynptr as map key, the second one uses a struct with an integer and
>> a bpf_dynptr as map key, and the last one use a struct with two
>> bpf_dynptr as map key: one in the struct itself and another is nested in
>> another struct.
>>
>> Also add multiple negative test cases for dynptr-keyed hash map. These
>> test cases mainly check whether the layout of dynptr and non-dynptr in
>> the stack is matched with the definition of map->key_record.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  .../bpf/prog_tests/htab_dynkey_test.c         | 446 ++++++++++++++++++
>>  .../bpf/progs/htab_dynkey_test_failure.c      | 266 +++++++++++
>>  .../bpf/progs/htab_dynkey_test_success.c      | 382 +++++++++++++++
>>  3 files changed, 1094 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
>>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
>> new file mode 100644
>> index 0000000000000..84e6931cc19c0
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
>> @@ -0,0 +1,382 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
>> +#include <linux/types.h>
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <errno.h>
>> +
>> +#include "bpf_misc.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +struct pure_dynptr_key {
>> +       struct bpf_dynptr name;
>> +};
>> +
>> +struct mixed_dynptr_key {
>> +       int id;
>> +       struct bpf_dynptr name;
>> +};
>> +
>> +struct multiple_dynptr_key {
>> +       struct pure_dynptr_key f_1;
>> +       unsigned long f_2;
>> +       struct mixed_dynptr_key f_3;
>> +       unsigned long f_4;
>> +};
>> +
> [...]
>
>> +       /* Delete the newly-inserted key */
>> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(systemd_name), 0, &key.f_3.name);
>> +       err = bpf_dynptr_write(&key.f_3.name, 0, (void *)systemd_name, sizeof(systemd_name), 0);
>> +       if (err) {
>> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
>> +               err = 10;
>> +               goto out;
>> +       }
>> +       err = bpf_map_delete_elem(htab, &key);
>> +       if (err) {
>> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
>> +               err = 11;
>> +               goto out;
>> +       }
>> +
>> +       /* Lookup it again */
>> +       value = bpf_map_lookup_elem(htab, &key);
>> +       bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
>> +       if (value) {
>> +               err = 12;
>> +               goto out;
>> +       }
>> +out:
>> +       return err;
>> +}
>
> So, I'm not a big fan of this approach of literally embedding struct
> bpf_dynptr into map key type and actually initializing and working
> with it directly, like you do here with
> bpf_ringbuf_reserve_dynptr(..., &key.f_3.name).
>
> Here's why. This approach only works for *map keys* (not map values)
> and only when **the copy of the key** is on the stack (i.e., for map
> lookups/updates/deletes). This approach won't work for having dynptrs
> inside map value (for variable sized map values), nor does it really
> work when you get a direct pointer to map key in
> bpf_for_each_map_elem().

Yes. The reason why the key should be on the stack is due to the
limitation (or the design) of bpf_dynptr. However I didn't understand
why it doesn't work for map value just like other special field in the
map value (e.g., bpf_timer) ?
>
> Curiously, you do have bpf_for_each_map_elem() "example" in patch #16
> in benchmarks, but you are carefully avoiding actually touching the
> `void *key` passed to your callback. Instead you create a local key,
> do lookup, and then compare the pointers to value to know that you
> "guessed" the key right.
>
> This doesn't seem to be how bpf_for_each_map_elem() is really meant to
> work: you'd want to be able to work with that key for real, get its
> data, etc. Not guess and confirm, like you do.

Er, bpf_for_each_map_elem() for dynptr-keyed hash map has not been
implemented yet (as said in the cover letter), so I used the values in
the array map as the lookup key for the hash map.
>
> And in case it's not obvious why this approach won't work when dynptrs
> are stored inside map value. Dynptr itself relies on not being
> modified concurrently. We achieve that through *always* keeping it on
> BPF programs stack, guaranteeing that no concurrently running BPF
> program (BPF program sharing the map, or same program on different
> CPU) can touch the dynptr. This is pretty fundamental. And I don't
> think we should add more locking to dynptr itself just to enable this.

I didn't follow that. Even dynptr is kept in map value, how will it be
modified concurrently ? When there are special fields in the map value,
the update of the map value will be out-of-place update and the old
dynptr will be kept as intact.

>
> So I have an alternative proposal that will extend to map values and
> real map keys (not they local copy on the stack).
>
> I say, we stop pretending that it's an actual dynptr that is stored in
> the key. It should be some sort of "dynptr impression" (I don't want
> to bikeshed right now), and user would have to put it into map key for
> lookup/update/delete through a special kfunc (let's call this
> "bpf_dynptr_stash" for now). When working with an existing map key
> (and map value in the future), we need to create a local real dynptr
> from its map key/value "impression", say, with "bpf_dynptr_unstash".
>
> bpf_dynptr_stash() is effectively bpf_dynptr_clone() (so all the
> mechanics is already supported by verifier). bpf_dynptr_unstash() is
> effectively bpf_dynptr_from_mem(). But they might need a slight change
> to accommodate a different actual struct type we'll use for that
> stashed dynptr.
>
> So just to show what I mean on pseudo example:
>
>
> struct bpf_stashed_dynptr {
>    __bpf_md_ptr(void *, data);
>    __u32 size;
>    __u32 reserved;
> }

It will be an ABI for both bpf program and bpf syscall just like
bpf_dynptr, right ? Therefore, when bpf_stashed_dynptr is used in the
bpf program, we need to implement something similar for the struct just
like dynptr, because we need to ensure both ->data and ->size are valid,
right ? If it may be not safe to keep dynptr in the map key/value, how
will it be safe to keep bpf_stashed_dynptr in the map key/value ?
>
> struct id_dname_key {
>        int id;
>        struct bpf_stashed_dynptr name;
> };
>
> struct {
>        __uint(type, BPF_MAP_TYPE_HASH);
>        __uint(max_entries, 10);
>        __uint(map_flags, BPF_F_NO_PREALLOC);
>        __type(key, struct id_dname_key);
>        __type(value, unsigned long);
> } htab SEC(".maps");
>
> int bpf_dynptr_stash(const struct bpf_dynptr *src, struct
> stashed_dynptr *dst) SEC(".ksyms"); /* kfunc */
> int bpf_dynptr_unstash(const struct stashed_dynptr *dst, struct
> bpf_dynptr *dst) SEC(".ksyms"); /* kfunc */
>
>
> /* LOOKUP/UPDATE/DELETE APPROACH */
>
> struct id_name_key my_key = { .id = 123 };
> char buf[128] = "my_string";
> struct bpf_dynptr dptr;
>
> /* create real dynptr */
> bpf_dynptr_from_mem(buf, sizeof(buf), 0, &dptr);
> /* stash it into our on-the-stack key copy */
> bpf_dynptr_stash(&dptr, &my_key.name);
>
> /* here, kernel will read "my_string" through "stashed dynptr"
>  * my_key.name pointing to buf, same as dptr
>  */
> bpf_map_update_elem(&htab, &my_key, BPF_ANY);
>
>
> /* FOR_EACH_MAP_ELEM_KEY READING */
> static int cb(void *map, void *key, void *value, void *ctx)
> {
>     struct id_dname_key *k = key;
>     struct bpf_dynptr dptr;
>     const void *name;
>
>     /* create local real dynptr from stashed one in the key in the map */
>     bpf_dynptr_unstash(&k->name, &dptr);
>
>     /* get direct memory access to the data stored in the key, NO COPIES! */
>     name = bpf_dynptr_slice(&dptr, ....);
>     if (name)
>         bpf_printk("my_key.name: %s", name);
> }

The point here is to avoid keeping bpf_dynptr in the map key and to save
it in the stack instead, right ?
>
> ...
>
> bpf_for_each_map_elem(&htab, cb, NULL, 0); /* iterate */
>
>
>
> And I'm too lazy to write this for hypothetical map value use case.
> Map value has an extra challenge of making sure stashing/unstashing
> handle racy updates from other CPUs, which I believe you can do with
> seqcount-like approach (no heavy-weight locking).
>
> BTW, this dedicated `struct bpf_stashed_dynptr` completely avoids that
> double-defined `struct bpf_dynptr` you do in patch #6. Kernel will
> know it's something like a real dynptr when doing update/lookup/delete
> from on-the-stack key copy, and that it's a completely different thing
> when it's actually stored inside the map in the key (and, eventually,
> in the value). And in user space it will be a still different
> definition, which kernel will provide when doing lookups from user
> space.
>
> Hope this makes sense.

Thanks for the suggestion.
> [...]



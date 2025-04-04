Return-Path: <bpf+bounces-55348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADAA7C302
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 19:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B511891D0A
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48923219A90;
	Fri,  4 Apr 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyH1YYsW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2018FC92
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789531; cv=none; b=qkEWzGCBg2E12q3SkL338EhuVE/rkwbpko9/V2B82r+oCW+hLANJ+arFBUfrpAEpQPRTT1NbkISRqDzS2Hlr/wM/xd9GijbJ2EmyBy06Uw5M3xVLn3s4oaTEStaikcI0XiRIWJ//cJCV0eI93NtfW0HEfQHYX5LU4hCSsCSZMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789531; c=relaxed/simple;
	bh=Vg2GTShh6vQca32Zz34Llm2oa0hnM4x87gjG8Apr8Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItcvZgkjb+6swAH2Y+VKBCgxV1JUpxy1CcwFPqTwrE+sjZOfWUf0c3QLlxGkUngHsI4RrAr92goaMaOFsL/1wphc0ZOHOqF7vlfiRCE8WE9560WCKnfZEJ7d9jqsVUT3Nh+hPMTOL/B7R6mChNGKZgw4EwybIR6ZMkaMNq0BHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyH1YYsW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73712952e1cso2250706b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743789529; x=1744394329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnHpYDtKX5x6eELNrvKuka3LKQCjylIpXxRnCz78l7s=;
        b=FyH1YYsWyC5uWBUxlO6uZ28gDTmBsYwSosOhmqp5jR6yrHmuLVZ4MDyKSbpJejym6V
         7i3YJCGKWgFOY4/zzh7HPVgFTQUv6crcedw3I3Lt9b/fxgT0wZlcDEi/INjcGLZSwjFT
         qrE0jxGkau7e/p0QP7LNG0roj81j5HdFHu9aztFy2O/sGkVS4t13xP3jc4z9z/bIh/aK
         H9/yGZQBDVy4cil7c2SpsMkyBU9HNAHT3lRASSh/tZ5l8cSTFuvBv2DBCKUGPW5PdZcT
         kiJ8b+jH22BBTM1zhzJWusx5Lsb1/A1Pti0/VklQxqCJPISr2YuODibCpE3Rnxy2tzQl
         s7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743789529; x=1744394329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnHpYDtKX5x6eELNrvKuka3LKQCjylIpXxRnCz78l7s=;
        b=mt++QwRbiXy0EhVlLO+9Pp6ZJc2RpC3Ni+AgOJdSq3FAgk0OidggZ/JPef7faA1gAp
         Xl1Q5C3asp7VUnM6ZtltRebeavCoHNFbgomwU3rBTMDX8RsLyXqG11l8qlB4Pdoet/NV
         tW+5Z4+3ZVK8gyMMO+XoT5lOqbwFiauZ35Ydxzx+lEKnt6blXDVqsokGm14VsaY6GH8X
         tzivp+W84r2wzvUIx6N/IWIm4Rzj/Cbuw3xu5WZWwOTzoGqK+9VKoDphVLNFuMuZn/Vj
         BLdhmodm6vzO4/4uWGryXMva4enAp6FNVAWonN0yIW2W4f1BxZyja2edoRBXuS8NvcAW
         NoOA==
X-Gm-Message-State: AOJu0YzKYPLqZnq8rBbewvZMtN9ZRjjh67zPfM7z9nlUi5f9jQ9n+0jv
	QnBaczWxuI/7Myr85na9A+maQ2UcMw1F1YI1J419zb+FxBP1ulqIlZ9Sp7aUdFml/mWj34US7TT
	Np4fv1beivtUTmdEkSnN36LO7Gwc=
X-Gm-Gg: ASbGncsYMApkk82B/2aZLqTDBYMLMs5W/lLKOkHLY+EPRwkGRIewpqm6CcjAfwggH7t
	L/kqAlklpngh2CU8wzaazcXxINfdNGuQ5kbuw4MdSATSBSAuIFfSs+DCVBMkLP6KnCQgfRSP7NJ
	IOWzQzXMga73vkXj1sHA7BAuOtEuHYr1Nq538L0uKR4Q==
X-Google-Smtp-Source: AGHT+IHELcheVo7vRqkGGML3k0snw44Q8UGUR64LIjdCFtfmpkT3Ch6MNCaqWvpYoTFQLaEF4oTe5mR7Awi4ETWHmHo=
X-Received: by 2002:aa7:8890:0:b0:736:a4ca:62e1 with SMTP id
 d2e1a72fcca58-739e4815f68mr5227355b3a.6.1743789529046; Fri, 04 Apr 2025
 10:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327083455.848708-1-houtao@huaweicloud.com> <20250327083455.848708-16-houtao@huaweicloud.com>
In-Reply-To: <20250327083455.848708-16-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 10:58:37 -0700
X-Gm-Features: ATxdqUG0ILel8hQyB0BxhwYfXD2lig1Kalyd698lKIgKvK5FqMKaluXydd0mTYk
Message-ID: <CAEf4BzY6Y=40NHs12r3Jb7u_N8CVapwRuF09+dmxBH85J2t88w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 15/16] selftests/bpf: Add test cases for hash
 map with dynptr key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 1:23=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Add three positive test cases to test the basic operations on the
> dynptr-keyed hash map. The basic operations include lookup, update,
> delete and get_next_key. These operations are exercised both through
> bpf syscall and bpf program. These three test cases use different map
> keys. The first test case uses both bpf_dynptr and a struct with only
> bpf_dynptr as map key, the second one uses a struct with an integer and
> a bpf_dynptr as map key, and the last one use a struct with two
> bpf_dynptr as map key: one in the struct itself and another is nested in
> another struct.
>
> Also add multiple negative test cases for dynptr-keyed hash map. These
> test cases mainly check whether the layout of dynptr and non-dynptr in
> the stack is matched with the definition of map->key_record.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  .../bpf/prog_tests/htab_dynkey_test.c         | 446 ++++++++++++++++++
>  .../bpf/progs/htab_dynkey_test_failure.c      | 266 +++++++++++
>  .../bpf/progs/htab_dynkey_test_success.c      | 382 +++++++++++++++
>  3 files changed, 1094 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynkey_te=
st.c
>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_fa=
ilure.c
>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_su=
ccess.c
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c=
 b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
> new file mode 100644
> index 0000000000000..84e6931cc19c0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
> +#include <linux/types.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <errno.h>
> +
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct pure_dynptr_key {
> +       struct bpf_dynptr name;
> +};
> +
> +struct mixed_dynptr_key {
> +       int id;
> +       struct bpf_dynptr name;
> +};
> +
> +struct multiple_dynptr_key {
> +       struct pure_dynptr_key f_1;
> +       unsigned long f_2;
> +       struct mixed_dynptr_key f_3;
> +       unsigned long f_4;
> +};
> +

[...]

> +       /* Delete the newly-inserted key */
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(systemd_name), 0, &ke=
y.f_3.name);
> +       err =3D bpf_dynptr_write(&key.f_3.name, 0, (void *)systemd_name, =
sizeof(systemd_name), 0);
> +       if (err) {
> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> +               err =3D 10;
> +               goto out;
> +       }
> +       err =3D bpf_map_delete_elem(htab, &key);
> +       if (err) {
> +               bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> +               err =3D 11;
> +               goto out;
> +       }
> +
> +       /* Lookup it again */
> +       value =3D bpf_map_lookup_elem(htab, &key);
> +       bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> +       if (value) {
> +               err =3D 12;
> +               goto out;
> +       }
> +out:
> +       return err;
> +}


So, I'm not a big fan of this approach of literally embedding struct
bpf_dynptr into map key type and actually initializing and working
with it directly, like you do here with
bpf_ringbuf_reserve_dynptr(..., &key.f_3.name).

Here's why. This approach only works for *map keys* (not map values)
and only when **the copy of the key** is on the stack (i.e., for map
lookups/updates/deletes). This approach won't work for having dynptrs
inside map value (for variable sized map values), nor does it really
work when you get a direct pointer to map key in
bpf_for_each_map_elem().

Curiously, you do have bpf_for_each_map_elem() "example" in patch #16
in benchmarks, but you are carefully avoiding actually touching the
`void *key` passed to your callback. Instead you create a local key,
do lookup, and then compare the pointers to value to know that you
"guessed" the key right.

This doesn't seem to be how bpf_for_each_map_elem() is really meant to
work: you'd want to be able to work with that key for real, get its
data, etc. Not guess and confirm, like you do.

And in case it's not obvious why this approach won't work when dynptrs
are stored inside map value. Dynptr itself relies on not being
modified concurrently. We achieve that through *always* keeping it on
BPF programs stack, guaranteeing that no concurrently running BPF
program (BPF program sharing the map, or same program on different
CPU) can touch the dynptr. This is pretty fundamental. And I don't
think we should add more locking to dynptr itself just to enable this.

So I have an alternative proposal that will extend to map values and
real map keys (not they local copy on the stack).

I say, we stop pretending that it's an actual dynptr that is stored in
the key. It should be some sort of "dynptr impression" (I don't want
to bikeshed right now), and user would have to put it into map key for
lookup/update/delete through a special kfunc (let's call this
"bpf_dynptr_stash" for now). When working with an existing map key
(and map value in the future), we need to create a local real dynptr
from its map key/value "impression", say, with "bpf_dynptr_unstash".

bpf_dynptr_stash() is effectively bpf_dynptr_clone() (so all the
mechanics is already supported by verifier). bpf_dynptr_unstash() is
effectively bpf_dynptr_from_mem(). But they might need a slight change
to accommodate a different actual struct type we'll use for that
stashed dynptr.

So just to show what I mean on pseudo example:


struct bpf_stashed_dynptr {
   __bpf_md_ptr(void *, data);
   __u32 size;
   __u32 reserved;
}

struct id_dname_key {
       int id;
       struct bpf_stashed_dynptr name;
};

struct {
       __uint(type, BPF_MAP_TYPE_HASH);
       __uint(max_entries, 10);
       __uint(map_flags, BPF_F_NO_PREALLOC);
       __type(key, struct id_dname_key);
       __type(value, unsigned long);
} htab SEC(".maps");

int bpf_dynptr_stash(const struct bpf_dynptr *src, struct
stashed_dynptr *dst) SEC(".ksyms"); /* kfunc */
int bpf_dynptr_unstash(const struct stashed_dynptr *dst, struct
bpf_dynptr *dst) SEC(".ksyms"); /* kfunc */


/* LOOKUP/UPDATE/DELETE APPROACH */

struct id_name_key my_key =3D { .id =3D 123 };
char buf[128] =3D "my_string";
struct bpf_dynptr dptr;

/* create real dynptr */
bpf_dynptr_from_mem(buf, sizeof(buf), 0, &dptr);
/* stash it into our on-the-stack key copy */
bpf_dynptr_stash(&dptr, &my_key.name);

/* here, kernel will read "my_string" through "stashed dynptr"
 * my_key.name pointing to buf, same as dptr
 */
bpf_map_update_elem(&htab, &my_key, BPF_ANY);


/* FOR_EACH_MAP_ELEM_KEY READING */
static int cb(void *map, void *key, void *value, void *ctx)
{
    struct id_dname_key *k =3D key;
    struct bpf_dynptr dptr;
    const void *name;

    /* create local real dynptr from stashed one in the key in the map */
    bpf_dynptr_unstash(&k->name, &dptr);

    /* get direct memory access to the data stored in the key, NO COPIES! *=
/
    name =3D bpf_dynptr_slice(&dptr, ....);
    if (name)
        bpf_printk("my_key.name: %s", name);
}

...

bpf_for_each_map_elem(&htab, cb, NULL, 0); /* iterate */



And I'm too lazy to write this for hypothetical map value use case.
Map value has an extra challenge of making sure stashing/unstashing
handle racy updates from other CPUs, which I believe you can do with
seqcount-like approach (no heavy-weight locking).

BTW, this dedicated `struct bpf_stashed_dynptr` completely avoids that
double-defined `struct bpf_dynptr` you do in patch #6. Kernel will
know it's something like a real dynptr when doing update/lookup/delete
from on-the-stack key copy, and that it's a completely different thing
when it's actually stored inside the map in the key (and, eventually,
in the value). And in user space it will be a still different
definition, which kernel will provide when doing lookups from user
space.

Hope this makes sense.

[...]


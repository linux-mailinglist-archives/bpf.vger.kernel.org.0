Return-Path: <bpf+bounces-44149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7AE9BF7B7
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E8E1C2126F
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2B209F30;
	Wed,  6 Nov 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7Z/X/cO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEC205E0C;
	Wed,  6 Nov 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923337; cv=none; b=X3vcPmUDhmNlMcyb1Z4P8BdhdusxLV444YGXJ2w3EkAZqRVdimlIXaBl4kW5I4J2M7PvyEJKci5OEZ5eIyyPvjiX5FmpXoDHn0ffo9+y1V8ucIM5LchDfafpj7Suo+VnjtFlIwF3w3FoNlZb5SQFZKVjPmO5MZog8ZLeZMZ888I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923337; c=relaxed/simple;
	bh=0ndvj0LRyugEXOQTiBA+yGXCTnbfUBHqt3oqkAeUor8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0DcjQLjKj78wLleGs4VFmOBvvdVUl/ZAN2c/9JF0Y40AtqkJ8/IrxGAbIKTQX3w9NbPq0k+obcfwbgQZNOx0F5nBW4yrXB5o7yBCOvAmaHmaNFzRJWvZEuBTUv411cXpZhigcyxFCJj3LLUi98x3Rm0yQN7zF+2qcHNJFd2Hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7Z/X/cO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so180148a91.0;
        Wed, 06 Nov 2024 12:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730923335; x=1731528135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiYpdHaszdyuaXQQsVN004xtHRYdDKQWMIi87TqO2Us=;
        b=F7Z/X/cONcfgdszLDKmYEAd2X0Xz2zsAfI08pzZHeGbnx+yOtfZJb0cod49Kwp4wP8
         UAUl6wjAiI4JkqEmLLUvn1/FwOWm4xeAWtu73zADicCm1uIXKoAr7XZHKrMaJxlo6LOP
         /qL7gXaU9FiQbsiKqJ/Z28wPoZIqzdwbw7aZSSU0QfohZ6VJK6ZKnuBMRwwF5zRZjv6C
         XaufLbzSqg7d8qyFn1ds+a5yuU/sKf7niY2qfPbycMrO8A7KlaAwbU0l+u8z2vlt8+Kx
         aDssDoyOeltiIRa+H+9ExfmXZyviuPPntyd5tWoPfPSHyZvLA/Iwbol3o52dQioIssCc
         Xw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730923335; x=1731528135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiYpdHaszdyuaXQQsVN004xtHRYdDKQWMIi87TqO2Us=;
        b=fU2IVJd0qqjhoaj4GALx5GYgmBZ+ckVuJrOj8L+gKK1rHBTcj3DqYyDioj+o7wF3W2
         a8FHKQppCVqvwABiTsZZE9/Hu4KuWdOWgL0WTzSd8zI3ggonT52NCWr0Oy3vaIW3xUe0
         a2zR6Ut7UaxVFwFh9RDpNXUnk+F5lDA9EtxAmVdnD3mjPrJ69cQBjKVwLCIOZVe02F1w
         5e9b9w+uv/yPcQ/ee8nsrS6sHOpf2/HINrFruQH1C1h0eg6v5cGGKt1DtkrgRJcT0TsJ
         3Q5Zfwaldp4nccmTnXhHovwFR/prt1SErhbunuKzugyzg16NGs4LuVeqkj5LrutwrPEX
         fyNw==
X-Forwarded-Encrypted: i=1; AJvYcCVT0I6NbQOXlZZpkUzhpjfDwAKa2eqCtLVU7PTFVuE+HWLvvuElqzlmXPmn1HKWBlCCyNE=@vger.kernel.org, AJvYcCWJqQ2RTcK+OarSFI9Ntu/xrtxLUq+1qr47jMSu90dn+Ky0IZCqgimq4FMSUm+R2KeqPZArwNFjaJrsBZg9@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKklxV+H7bUFHF3WiZpwLe1pVrtWQ1xCYqjxO+Zvcidb4KVp8
	1FqVIofKoLxT9PM+yyiyVkyd2eHr95LYMTHn06OTm8yNNTL4e7F15bt04uU8U2Q7yDvomxom6mS
	fs1ZaOrE8KYIbUmPJH71BSTqa/cIbMw==
X-Google-Smtp-Source: AGHT+IEdcv4otZxkYQZ+yUubB28SU7wCq/NglXS2cqh0QetasEdWKRugj+U40BpzMg3KMRkWkADBfy2AVSG0kTER29A=
X-Received: by 2002:a17:90b:1804:b0:2e2:e597:6cdc with SMTP id
 98e67ed59e1d1-2e93c1750bamr32782774a91.22.1730923335019; Wed, 06 Nov 2024
 12:02:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB584846B635B10C59EFAF596099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4Bzbt0kh53xYZL57Nc9AWcYUKga_NQ6uUrTeU4bj8qyTLng@mail.gmail.com> <AM6PR03MB584814D93FE3680635DE61A199562@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB584814D93FE3680635DE61A199562@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 12:02:03 -0800
Message-ID: <CAEf4Bzba2N7pxPQh8_BDrVgupZdeow_3S7xSjDmsdhL19eXb3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:22=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
> On 2024/11/1 19:06, Andrii Nakryiko wrote:
> > On Tue, Oct 29, 2024 at 5:15=E2=80=AFPM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> This patch adds the open-coded iterator style process file iterator
> >> kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
> >> files opened by the specified process.
> >>
> >> In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
> >> the file descriptor corresponding to the file in the current iteration=
.
> >>
> >> The reference to struct file acquired by the previous
> >> bpf_iter_task_file_next() is released in the next
> >> bpf_iter_task_file_next(), and the last reference is released in the
> >> last bpf_iter_task_file_next() that returns NULL.
> >>
> >> In the bpf_iter_task_file_destroy(), if the iterator does not iterate =
to
> >> the end, then the last struct file reference is released at this time.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   kernel/bpf/Makefile      |   1 +
> >>   kernel/bpf/crib/Makefile |   3 ++
> >>   kernel/bpf/crib/crib.c   |  29 +++++++++++
> >>   kernel/bpf/crib/files.c  | 105 +++++++++++++++++++++++++++++++++++++=
++
> >>   4 files changed, 138 insertions(+)
> >>   create mode 100644 kernel/bpf/crib/Makefile
> >>   create mode 100644 kernel/bpf/crib/crib.c
> >>   create mode 100644 kernel/bpf/crib/files.c
> >>
> >> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> >> index 105328f0b9c0..933d36264e5e 100644
> >> --- a/kernel/bpf/Makefile
> >> +++ b/kernel/bpf/Makefile
> >> @@ -53,3 +53,4 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
> >>   obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
> >>   obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
> >>   obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> >> +obj-$(CONFIG_BPF_SYSCALL) +=3D crib/
> >> diff --git a/kernel/bpf/crib/Makefile b/kernel/bpf/crib/Makefile
> >> new file mode 100644
> >> index 000000000000..4e1bae1972dd
> >> --- /dev/null
> >> +++ b/kernel/bpf/crib/Makefile
> >> @@ -0,0 +1,3 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +obj-$(CONFIG_BPF_SYSCALL) +=3D crib.o files.o
> >> diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
> >> new file mode 100644
> >> index 000000000000..e6536ee9a845
> >> --- /dev/null
> >> +++ b/kernel/bpf/crib/crib.c
> >> @@ -0,0 +1,29 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Checkpoint/Restore In eBPF (CRIB)
> >> + */
> >> +
> >> +#include <linux/bpf.h>
> >> +#include <linux/btf.h>
> >> +#include <linux/btf_ids.h>
> >> +
> >> +BTF_KFUNCS_START(bpf_crib_kfuncs)
> >> +
> >> +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_A=
RGS)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NUL=
L)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
> >
> > This is in no way CRIB-specific, right? So I'd drop the CRIB reference
> > and move code next to task_file BPF iterator program type
> > implementation, this is a generic functionality.
> >
> > Even more so, given Namhyung's recent work on adding kmem_cache
> > iterator (both program type and open-coded iterator), it seems like it
> > should be possible to cut down on code duplication by using open-coded
> > iterator logic inside the BPF iterator program. Now that you are
> > adding task_file open-coded iterator, can you please check if it can
> > be reused. See kernel/bpf/task_iter.c (and I think that's where your
> > code should live as well, btw).
> >
> > pw-bot: cr
> >
>
> Thanks for your reply!
>
> Yes, I agree that it would be better to put the task_file open-coded
> iterator together with the traditional task_file iterator (in the
> same file).
>
> I will move it in the next patch series.
>
> >> +
> >> +BTF_KFUNCS_END(bpf_crib_kfuncs)
> >> +
> >> +static const struct btf_kfunc_id_set bpf_crib_kfunc_set =3D {
> >> +       .owner =3D THIS_MODULE,
> >> +       .set   =3D &bpf_crib_kfuncs,
> >> +};
> >> +
> >> +static int __init bpf_crib_init(void)
> >> +{
> >> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_c=
rib_kfunc_set);
> >> +}
> >> +
> >> +late_initcall(bpf_crib_init);
> >> diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
> >> new file mode 100644
> >> index 000000000000..ececf150303f
> >> --- /dev/null
> >> +++ b/kernel/bpf/crib/files.c
> >> @@ -0,0 +1,105 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include <linux/btf.h>
> >> +#include <linux/file.h>
> >> +#include <linux/fdtable.h>
> >> +#include <linux/net.h>
> >> +
> >> +struct bpf_iter_task_file {
> >> +       __u64 __opaque[3];
> >> +} __aligned(8);
> >> +
> >> +struct bpf_iter_task_file_kern {
> >> +       struct task_struct *task;
> >> +       struct file *file;
> >> +       int fd;
> >> +} __aligned(8);
> >> +
> >> +__bpf_kfunc_start_defs();
> >> +
> >> +/**
> >> + * bpf_iter_task_file_new() - Initialize a new task file iterator for=
 a task,
> >> + * used to iterate over all files opened by a specified task
> >> + *
> >> + * @it: the new bpf_iter_task_file to be created
> >> + * @task: a pointer pointing to a task to be iterated over
> >> + */
> >> +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
> >> +               struct task_struct *task)
> >> +{
> >> +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> >> +
> >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(s=
truct bpf_iter_task_file));
> >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=3D
> >> +                    __alignof__(struct bpf_iter_task_file));
> >> +
> >> +       kit->task =3D task;
> >> +       kit->fd =3D -1;
> >> +       kit->file =3D NULL;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +/**
> >> + * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_fil=
e
> >> + *
> >> + * bpf_iter_task_file_next acquires a reference to the returned struc=
t file.
> >> + *
> >> + * The reference to struct file acquired by the previous
> >> + * bpf_iter_task_file_next() is released in the next bpf_iter_task_fi=
le_next(),
> >> + * and the last reference is released in the last bpf_iter_task_file_=
next()
> >> + * that returns NULL.
> >> + *
> >> + * @it: the bpf_iter_task_file to be checked
> >> + *
> >> + * @returns a pointer to the struct file of the next file if further =
files
> >> + * are available, otherwise returns NULL
> >> + */
> >> +__bpf_kfunc struct file *bpf_iter_task_file_next(struct bpf_iter_task=
_file *it)
> >> +{
> >> +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> >> +
> >> +       if (kit->file)
> >> +               fput(kit->file);
> >> +
> >> +       kit->fd++;
> >> +
> >> +       rcu_read_lock();
> >> +       kit->file =3D task_lookup_next_fdget_rcu(kit->task, &kit->fd);
> >> +       rcu_read_unlock();
> >> +
> >> +       return kit->file;
> >> +}
> >> +
> >> +/**
> >> + * bpf_iter_task_file_get_fd() - Get the file descriptor correspondin=
g to
> >> + * the file in the current iteration
> >> + *
> >> + * @it: the bpf_iter_task_file to be checked
> >> + *
> >> + * @returns the file descriptor
> >> + */
> >> +__bpf_kfunc int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *=
it__iter)
> >> +{
> >> +       struct bpf_iter_task_file_kern *kit =3D (void *)it__iter;
> >> +
> >> +       return kit->fd;
> >> +}
> >> +
> >
> > I don't think we need this. It's probably better to return a pointer
> > to a small struct representing "item" returned from this iterator.
> > Something like
> >
> > struct bpf_iter_task_file_item {
> >      struct task_struct *task;
> >      struct file *file;
> >      int fd;
> > };
> >
> > You can then embed this struct into struct bpf_iter_task_file and
> > return a pointer to it on each next() call (avoiding memory
> > allocation)
> >
> >
> > (naming just for illustrative purposes, I spent 0 seconds thinking abou=
t it)
> >
>
> Yes, I agree that it is feasible.
>
> But there is a question here, should we expose the internal state
> structure of the iterator (If we want to embed) ?
>
> I guess that we need two versions of data structures struct bpf_iter_xxx
> and struct bpf_iter_xxx_kern is for the purpose of encapsulation?

Yes, that's what we do for iterator state structure, and you should do
that as well. bpf_iter_xxx one will be opaque (see other examples, we
literally add `u64 __opaque[N];` there).

But this bpf_iter_task_file_item will be sort of internal API that is
returned from bpf_iter_task_file_next(). So you'll have something like

struct bpf_iter_task_file {
    .... additional state ...
    struct bpf_iter_task_file_item item;
};

then you have

struct bpf_iter_task_file_item bpf_iter_task_file_next(struct
bpf_iter_task_file *it)
{
    struct bpf_iter_task_file_kern *kit =3D (void *)it;

    ...
    kit->item.task =3D <sometask>;
    kit->item.file =3D <file>; /* and so on */

    return &kit->item;
}

>
> With two versions of the data structure, users can only manipulate
> the iterator using the iterator kfuncs, avoiding users from directly
> accessing the internal state.
>
> After we decide to return struct bpf_iter_task_file_item, these members
> will not be able to change and users can directly access/change the
> internal state of the iterator.

Yes, you have to carefully set up bpf_iter_task_file_item, but you
could expand it in the future without breaking any old users, because
you only return it by pointer and with BPF CO-RE all the field shifts
will be correctly handled.

>
> >> +/**
> >> + * bpf_iter_task_file_destroy() - Destroy a bpf_iter_task_file
> >> + *
> >> + * If the iterator does not iterate to the end, then the last
> >> + * struct file reference is released at this time.
> >> + *
> >> + * @it: the bpf_iter_task_file to be destroyed
> >> + */
> >> +__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file=
 *it)
> >> +{
> >> +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> >> +
> >> +       if (kit->file)
> >> +               fput(kit->file);
> >> +}
> >> +
> >> +__bpf_kfunc_end_defs();
> >> --
> >> 2.39.5
> >>
>


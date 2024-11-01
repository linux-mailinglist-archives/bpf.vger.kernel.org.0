Return-Path: <bpf+bounces-43762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFF9B9813
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484ABB21336
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5C1CF2B7;
	Fri,  1 Nov 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTKhgjmk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357831CF299;
	Fri,  1 Nov 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487980; cv=none; b=kdaoBk/Fqqdn9C9R6XMLO18zr5FBCPaY5Ma0jVHKBBlkVaBpNHk3RyEvbZ4ByQ9cVC/EnUMYFp0Gn5anMaxphRIr3tFbRZV7dhtwBtvzq4Nm5Ikcmwwx6XtirLuMbPH7E7GQ87al9zl0vmJcl2o7rX0+7czr9/5E4WR/5zuRGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487980; c=relaxed/simple;
	bh=qHsxnBbVATV78WkKf1EckOzOYdJxuzEj0oXCWURA2js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3JHPbUaIDFACEEbDsYqigZGHEGMZ+ICIjvCdAp5o3pa26HuTzNzunpkJABx6xRddpnlZi8HFyFq5ody+1Sgh7ZEMuhnXoD+OXsLMIxjt981RnVXWOKT4qe8nkH+7aDKWv3e+vizY27MfqC4BIV30Kdffzz3ropst7GF1ZGT5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTKhgjmk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71ec997ad06so1934910b3a.3;
        Fri, 01 Nov 2024 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730487978; x=1731092778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2B0t4RxDSvxS/yYokuFKLRf3lQgb/vvZP3JUxPQEZc=;
        b=QTKhgjmk3vnt840kn0HAEqFMFY1y43tLY2Zrx7aM4wbzToo7GsF/sunTgx+U5pRvl3
         caeuz61cDoc98tPPARInHQLg3q0ZwunWjv/vig9v2ljq8/97PS4FW+c8quAH3GlB42PN
         9gJZxU5/pg2N+oQHx4AHcLhYYNjAl64jgxpdpbcG3itZHtWHuxmR5UnG2JmkGrsjkVcb
         O1ZWstx01x1/r/GcVYPAE8mNpAMtjabo1GZfYl3QTzbFAptao5IRKbcGiCmilnMiA7dz
         Htdd57KQg4o1+cGFewE3ZBvBj0qHp3G+pPTt55BnrR5XruR1XuR5C/IJKeqxFWwNH0le
         3aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487978; x=1731092778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2B0t4RxDSvxS/yYokuFKLRf3lQgb/vvZP3JUxPQEZc=;
        b=NHb7ND89+jK7VfWsnfOmJimgiERY46fEWGD99oQa5jjC2Nu+jt5rZb9xmEJ7nBQ3rz
         1qEjxSa5imF7FY96/Z9+Oldf8+tkA3rN6VQPzyZX3wsbLoTRKIVAINE3cyTstKljzDuB
         xWKW19t1gALq63cLpsbN397ZvCGHeN0yP8tRff88Fi2wooc7mO9JKE97pgZEeEzRfk5d
         nFBeOEcYnLjPlxlhgJRQQn+cYDrGAuBcruAVIuP12JyyxaIQpFPL083fVPepoHynTki9
         KFurjjSqDkJGY+CkUsMIwlnhLGVC6z9gcbZxWOPPlQ2PNkgUrXDuOs7RKOreHCCY7FWX
         clUw==
X-Forwarded-Encrypted: i=1; AJvYcCVHeqnb2d+TCSzg2okpZvjjD4IIKBJ7LDNSXEe1hCiWdgPZLiP8/KzxUMi9tH971DLeW9g=@vger.kernel.org, AJvYcCX9WZ8akFm1UnBNTq+vKWF5nK66dBEKY7pMVsMbkYVH+9evG1Ss6DYptZcahJhe/5mWiDujdS9rASf9Vbor@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yv1c7bc88LTDqEZqABBicpRlla6Hvldmi0pOngSTkb/oZSYH
	gGKfqHpIjlh96G9WjZLWhQeLZEJ30xaaaRlONfusGgWqEpNsCMDYLppBw+N/P1pd+ZJoRVJnVJR
	70ex4+eTxaQVU/cJE9h1AqaU2prk=
X-Google-Smtp-Source: AGHT+IGeFIjU0Fs6Lk0krg20KNxZrAC2Uyb/WxyBatKdOZE32SzqsXpvy+IxsydaYXTjCoKi9VW0L5RVAZAMAEZtJWY=
X-Received: by 2002:a17:90a:a58f:b0:2e3:171e:3b8c with SMTP id
 98e67ed59e1d1-2e92cf2d074mr12150620a91.25.1730487978284; Fri, 01 Nov 2024
 12:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB584846B635B10C59EFAF596099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB584846B635B10C59EFAF596099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:06:06 -0700
Message-ID: <CAEf4Bzbt0kh53xYZL57Nc9AWcYUKga_NQ6uUrTeU4bj8qyTLng@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 5:15=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This patch adds the open-coded iterator style process file iterator
> kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
> files opened by the specified process.
>
> In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
> the file descriptor corresponding to the file in the current iteration.
>
> The reference to struct file acquired by the previous
> bpf_iter_task_file_next() is released in the next
> bpf_iter_task_file_next(), and the last reference is released in the
> last bpf_iter_task_file_next() that returns NULL.
>
> In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
> the end, then the last struct file reference is released at this time.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/bpf/Makefile      |   1 +
>  kernel/bpf/crib/Makefile |   3 ++
>  kernel/bpf/crib/crib.c   |  29 +++++++++++
>  kernel/bpf/crib/files.c  | 105 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 138 insertions(+)
>  create mode 100644 kernel/bpf/crib/Makefile
>  create mode 100644 kernel/bpf/crib/crib.c
>  create mode 100644 kernel/bpf/crib/files.c
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 105328f0b9c0..933d36264e5e 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -53,3 +53,4 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D crib/
> diff --git a/kernel/bpf/crib/Makefile b/kernel/bpf/crib/Makefile
> new file mode 100644
> index 000000000000..4e1bae1972dd
> --- /dev/null
> +++ b/kernel/bpf/crib/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_BPF_SYSCALL) +=3D crib.o files.o
> diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
> new file mode 100644
> index 000000000000..e6536ee9a845
> --- /dev/null
> +++ b/kernel/bpf/crib/crib.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Checkpoint/Restore In eBPF (CRIB)
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +
> +BTF_KFUNCS_START(bpf_crib_kfuncs)
> +
> +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS=
)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)

This is in no way CRIB-specific, right? So I'd drop the CRIB reference
and move code next to task_file BPF iterator program type
implementation, this is a generic functionality.

Even more so, given Namhyung's recent work on adding kmem_cache
iterator (both program type and open-coded iterator), it seems like it
should be possible to cut down on code duplication by using open-coded
iterator logic inside the BPF iterator program. Now that you are
adding task_file open-coded iterator, can you please check if it can
be reused. See kernel/bpf/task_iter.c (and I think that's where your
code should live as well, btw).

pw-bot: cr

> +
> +BTF_KFUNCS_END(bpf_crib_kfuncs)
> +
> +static const struct btf_kfunc_id_set bpf_crib_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &bpf_crib_kfuncs,
> +};
> +
> +static int __init bpf_crib_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_crib=
_kfunc_set);
> +}
> +
> +late_initcall(bpf_crib_init);
> diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
> new file mode 100644
> index 000000000000..ececf150303f
> --- /dev/null
> +++ b/kernel/bpf/crib/files.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/btf.h>
> +#include <linux/file.h>
> +#include <linux/fdtable.h>
> +#include <linux/net.h>
> +
> +struct bpf_iter_task_file {
> +       __u64 __opaque[3];
> +} __aligned(8);
> +
> +struct bpf_iter_task_file_kern {
> +       struct task_struct *task;
> +       struct file *file;
> +       int fd;
> +} __aligned(8);
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_iter_task_file_new() - Initialize a new task file iterator for a =
task,
> + * used to iterate over all files opened by a specified task
> + *
> + * @it: the new bpf_iter_task_file to be created
> + * @task: a pointer pointing to a task to be iterated over
> + */
> +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
> +               struct task_struct *task)
> +{
> +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(stru=
ct bpf_iter_task_file));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=3D
> +                    __alignof__(struct bpf_iter_task_file));
> +
> +       kit->task =3D task;
> +       kit->fd =3D -1;
> +       kit->file =3D NULL;
> +
> +       return 0;
> +}
> +
> +/**
> + * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_file
> + *
> + * bpf_iter_task_file_next acquires a reference to the returned struct f=
ile.
> + *
> + * The reference to struct file acquired by the previous
> + * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_=
next(),
> + * and the last reference is released in the last bpf_iter_task_file_nex=
t()
> + * that returns NULL.
> + *
> + * @it: the bpf_iter_task_file to be checked
> + *
> + * @returns a pointer to the struct file of the next file if further fil=
es
> + * are available, otherwise returns NULL
> + */
> +__bpf_kfunc struct file *bpf_iter_task_file_next(struct bpf_iter_task_fi=
le *it)
> +{
> +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> +
> +       if (kit->file)
> +               fput(kit->file);
> +
> +       kit->fd++;
> +
> +       rcu_read_lock();
> +       kit->file =3D task_lookup_next_fdget_rcu(kit->task, &kit->fd);
> +       rcu_read_unlock();
> +
> +       return kit->file;
> +}
> +
> +/**
> + * bpf_iter_task_file_get_fd() - Get the file descriptor corresponding t=
o
> + * the file in the current iteration
> + *
> + * @it: the bpf_iter_task_file to be checked
> + *
> + * @returns the file descriptor
> + */
> +__bpf_kfunc int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it_=
_iter)
> +{
> +       struct bpf_iter_task_file_kern *kit =3D (void *)it__iter;
> +
> +       return kit->fd;
> +}
> +

I don't think we need this. It's probably better to return a pointer
to a small struct representing "item" returned from this iterator.
Something like

struct bpf_iter_task_file_item {
    struct task_struct *task;
    struct file *file;
    int fd;
};

You can then embed this struct into struct bpf_iter_task_file and
return a pointer to it on each next() call (avoiding memory
allocation)


(naming just for illustrative purposes, I spent 0 seconds thinking about it=
)

> +/**
> + * bpf_iter_task_file_destroy() - Destroy a bpf_iter_task_file
> + *
> + * If the iterator does not iterate to the end, then the last
> + * struct file reference is released at this time.
> + *
> + * @it: the bpf_iter_task_file to be destroyed
> + */
> +__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *i=
t)
> +{
> +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> +
> +       if (kit->file)
> +               fput(kit->file);
> +}
> +
> +__bpf_kfunc_end_defs();
> --
> 2.39.5
>


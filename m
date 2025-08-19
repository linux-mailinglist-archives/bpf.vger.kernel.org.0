Return-Path: <bpf+bounces-65967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49225B2B843
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 06:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686E86220A7
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 04:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00C30F551;
	Tue, 19 Aug 2025 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+BbOC9z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418324A063
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576567; cv=none; b=doAPjxdSDJJzOlZVH+jiSIr++j4b3ip2X3iUMj8rMxj5haMqNtSe06SN8lLM1w6f1Hfk+HcUIQI+tL/PRwcUa+1oDKEcpeF2TRrvGWv1Ep8KTP2tbaYVQ5wTnG/bktduuJSB7s2UvFAWbMSBZJoNe007M6iiKQVhINLdnRGesw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576567; c=relaxed/simple;
	bh=gtHdv0uGDK9FXZQNdM8YQuk3LlETOl9J9gj4tkdR3o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1DFk00zUSQSTFjR1CefTSyyMm2SGbDvV44zaMAUjjtCU8MtdNgBuC+T604kEmfk2YI+hFuPxB1Pl8QXluD34QHQ17xWLuU8PcsvrXTvxEtIxpVMNr8EJuZ1ZKPZ21ueG/7itjg7md8VL4cYKZ2jycEv2OmZgdKh79xOTD0HmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+BbOC9z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b0bf08551cso170201cf.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 21:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755576565; x=1756181365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3dUCMV2/nAhvemdCojMd8kJyRCWZtkbIKeHpEaqiNA=;
        b=F+BbOC9zPYyfYtSG8NPFKgQTnquFjmTnnNEiV1Vn6sUG+diFeqR5gbu7t6ZPNg1M87
         EhMsWkhM4HKwDzJM1pIwbedzfYrceK13FM3NGOPppbjJVktF9uUIKQTj07hq4w54i6xg
         kig4hCs8XmSjUmtOUHL53sDdTLKEgOCLinmV++gqXaBqUGyqjupkiXHhgERDmwbaMRky
         cZxR1pze+QY9z6vfQcO1KEKOUGAOR3FyKUTi4fO9ZQAw3Hgka5p+yRSFBsf8piN6jI0M
         C09Xvyse1OuDSy4t9shLrDQq2cmCAjpeiCj8t90ynnaI8gZMuGEz4eALCemUJZ3Ez/Yu
         A5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755576565; x=1756181365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3dUCMV2/nAhvemdCojMd8kJyRCWZtkbIKeHpEaqiNA=;
        b=HCuVPYyK5L5nscBuZcY7IFr8T5jbHkaCkAK++KdQz5h3T9z5yLueiAgvFM38rSRfTr
         KCbn/uiDCq5kBgA0Zmz7JG15OkWtIswLaxHB5+Zga2pp1hYLrI4WSgld7qUCwfy1ZfAy
         tYzl0WtdtL2STJhYFZKrpe8x+aLAocxNlY2od9SGVl1zzZw89euj8VXQBYGSvZch8ZNy
         /+42SObkywe3gTyjqY7fywGolcy/HbBhPTklevVId0E/GYYzRqkGM2jb7h6RDjzUF+A0
         bXvCjlCmf3jXb5U72C2vnvKfLa3XO4Fmpwrv3PY5BwaofRztMgSh7urQArMZtLcGk644
         Y5cg==
X-Forwarded-Encrypted: i=1; AJvYcCWOZZ/HOQOZuN7fUIBS6aLpk54434f8C3kvmGi8RDcPxuT/7Nd89DgNn9K5NL/2Qii8Bko=@vger.kernel.org
X-Gm-Message-State: AOJu0YznUv4+LTlyaS8R/ThN5qAIFrBzq1Y80RjqdHtj5khnbkEMp4rT
	FK2Vyag6oIIrv7Ff8rP9uCbNvLMMPxAV1vnN8nwYD5wC3ifAQ8yzgnfDaO6Q5nNWtU9M/xGu/MY
	qn7hXy25pbJ55KjGgF2E/uXTF7HWy5mKMYP7pvPck
X-Gm-Gg: ASbGncsmUQus3RrRwBj7ejrbw6BoMOsroH5hpmDfoCE5Ds9c7aC1J+G2mtJepFr9ZJU
	m1/3hXTDD36OVc5ZlOGwPFSQvroPZnhr3lUNbnOouPXVuLcPL93a53zNLAShCBMmQIWL0LBLy1B
	DBQmeRHv3hwFQh/XW0Q5peDqOhRLgk7uaj0pny6IBonbElQSciFX/P9jJUJwWrSjw2WQP7doFcl
	RU3BnuPHMduW/f18FaDHpk=
X-Google-Smtp-Source: AGHT+IEXVXKEfHXfycn4KnNeZVZfnSb9NhcC+5+HRSfkOw++08Ddm1Rdv+hEz3lRMSSxCNgbz8/C3hLjkPWapN9Lyys=
X-Received: by 2002:a05:622a:1309:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4b286db8cecmr2005261cf.9.1755576564251; Mon, 18 Aug 2025
 21:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-2-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-2-roman.gushchin@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 18 Aug 2025 21:09:12 -0700
X-Gm-Features: Ac12FXy56yWlGoJq9cRPelkuwpXUpi9_s6Qr7A14WtXyHs4ZdQYEwR0F_Fms8VY
Message-ID: <CAJuCfpF2akVnbZgPoDAXea2joJ1DWvBTHC7wGzEJcYX9xF9dSA@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:01=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Introduce a bpf struct ops for implementing custom OOM handling policies.
>
> The struct ops provides the bpf_handle_out_of_memory() callback,
> which expected to return 1 if it was able to free some memory and 0
> otherwise.
>
> In the latter case it's guaranteed that the in-kernel OOM killer will
> be invoked. Otherwise the kernel also checks the bpf_memory_freed
> field of the oom_control structure, which is expected to be set by
> kfuncs suitable for releasing memory. It's a safety mechanism which
> prevents a bpf program to claim forward progress without actually
> releasing memory. The callback program is sleepable to enable using
> iterators, e.g. cgroup iterators.
>
> The callback receives struct oom_control as an argument, so it can
> easily filter out OOM's it doesn't want to handle, e.g. global vs
> memcg OOM's.
>
> The callback is executed just before the kernel victim task selection
> algorithm, so all heuristics and sysctls like panic on oom,
> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> are respected.
>
> The struct ops also has the name field, which allows to define a
> custom name for the implemented policy. It's printed in the OOM report
> in the oom_policy=3D<policy> format. "default" is printed if bpf is not
> used or policy name is not specified.
>
> [  112.696676] test_progs invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL=
), order=3D0, oom_score_adj=3D0
>                oom_policy=3Dbpf_test_policy
> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0=
-00015-gf09eb0d6badc #102 PREEMPT(full)
> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-5.fc42 04/01/2014
> [  112.698167] Call Trace:
> [  112.698177]  <TASK>
> [  112.698182]  dump_stack_lvl+0x4d/0x70
> [  112.698192]  dump_header+0x59/0x1c6
> [  112.698199]  oom_kill_process.cold+0x8/0xef
> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> [  112.698250]  out_of_memory+0xab/0x5c0
> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> [  112.698288]  charge_memcg+0x2f/0xc0
> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> [  112.698299]  do_anonymous_page+0x40f/0xa50
> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  112.698335]  handle_mm_fault+0xe6/0x370
> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> [  112.698354]  exc_page_fault+0x75/0x1d0
> [  112.698363]  asm_exc_page_fault+0x26/0x30
> [  112.698366] RIP: 0033:0x7fa97236db00
>
> It's possible to load multiple bpf struct programs. In the case of
> oom, they will be executed one by one in the same order they been
> loaded until one of them returns 1 and bpf_memory_freed is set to 1
> - an indication that the memory was freed. This allows to have
> multiple bpf programs to focus on different types of OOM's - e.g.
> one program can only handle memcg OOM's in one memory cgroup.
> But the filtering is done in bpf - so it's fully flexible.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/bpf_oom.h |  49 +++++++++++++
>  include/linux/oom.h     |   8 ++
>  mm/Makefile             |   3 +
>  mm/bpf_oom.c            | 157 ++++++++++++++++++++++++++++++++++++++++
>  mm/oom_kill.c           |  22 +++++-
>  5 files changed, 237 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/bpf_oom.h
>  create mode 100644 mm/bpf_oom.c
>
> diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
> new file mode 100644
> index 000000000000..29cb5ea41d97
> --- /dev/null
> +++ b/include/linux/bpf_oom.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __BPF_OOM_H
> +#define __BPF_OOM_H
> +
> +struct bpf_oom;
> +struct oom_control;
> +
> +#define BPF_OOM_NAME_MAX_LEN 64
> +
> +struct bpf_oom_ops {
> +       /**
> +        * @handle_out_of_memory: Out of memory bpf handler, called befor=
e
> +        * the in-kernel OOM killer.
> +        * @oc: OOM control structure
> +        *
> +        * Should return 1 if some memory was freed up, otherwise
> +        * the in-kernel OOM killer is invoked.
> +        */
> +       int (*handle_out_of_memory)(struct oom_control *oc);
> +
> +       /**
> +        * @name: BPF OOM policy name
> +        */
> +       char name[BPF_OOM_NAME_MAX_LEN];

Why should the name be a part of ops structure? IMO it's not an
attribute of the operations but rather of the oom handler which is
represented by bpf_oom here.

> +
> +       /* Private */
> +       struct bpf_oom *bpf_oom;
> +};
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +/**
> + * @bpf_handle_oom: handle out of memory using bpf programs
> + * @oc: OOM control structure
> + *
> + * Returns true if a bpf oom program was executed, returned 1
> + * and some memory was actually freed.

The above comment is unclear, please clarify.

> + */
> +bool bpf_handle_oom(struct oom_control *oc);
> +
> +#else /* CONFIG_BPF_SYSCALL */
> +static inline bool bpf_handle_oom(struct oom_control *oc)
> +{
> +       return false;
> +}
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
> +#endif /* __BPF_OOM_H */
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 1e0fc6931ce9..ef453309b7ea 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -51,6 +51,14 @@ struct oom_control {
>
>         /* Used to print the constraint info. */
>         enum oom_constraint constraint;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* Used by the bpf oom implementation to mark the forward progres=
s */
> +       bool bpf_memory_freed;
> +
> +       /* Policy name */
> +       const char *bpf_policy_name;
> +#endif
>  };
>
>  extern struct mutex oom_lock;
> diff --git a/mm/Makefile b/mm/Makefile
> index 1a7a11d4933d..a714aba03759 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -105,6 +105,9 @@ obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
>  ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) +=3D swap_cgroup.o
>  endif
> +ifdef CONFIG_BPF_SYSCALL
> +obj-y +=3D bpf_oom.o
> +endif
>  obj-$(CONFIG_CGROUP_HUGETLB) +=3D hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) +=3D gup_test.o
>  obj-$(CONFIG_DMAPOOL_TEST) +=3D dmapool_test.o
> diff --git a/mm/bpf_oom.c b/mm/bpf_oom.c
> new file mode 100644
> index 000000000000..47633046819c
> --- /dev/null
> +++ b/mm/bpf_oom.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * BPF-driven OOM killer customization
> + *
> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/oom.h>
> +#include <linux/bpf_oom.h>
> +#include <linux/srcu.h>
> +
> +DEFINE_STATIC_SRCU(bpf_oom_srcu);
> +static DEFINE_SPINLOCK(bpf_oom_lock);
> +static LIST_HEAD(bpf_oom_handlers);
> +
> +struct bpf_oom {

Perhaps bpf_oom_handler ? Then bpf_oom_ops->bpf_oom could be called
bpf_oom_ops->handler.


> +       struct bpf_oom_ops *ops;
> +       struct list_head node;
> +       struct srcu_struct srcu;
> +};
> +
> +bool bpf_handle_oom(struct oom_control *oc)
> +{
> +       struct bpf_oom_ops *ops;
> +       struct bpf_oom *bpf_oom;
> +       int list_idx, idx, ret =3D 0;
> +
> +       oc->bpf_memory_freed =3D false;
> +
> +       list_idx =3D srcu_read_lock(&bpf_oom_srcu);
> +       list_for_each_entry_srcu(bpf_oom, &bpf_oom_handlers, node, false)=
 {
> +               ops =3D READ_ONCE(bpf_oom->ops);
> +               if (!ops || !ops->handle_out_of_memory)
> +                       continue;
> +               idx =3D srcu_read_lock(&bpf_oom->srcu);
> +               oc->bpf_policy_name =3D ops->name[0] ? &ops->name[0] :
> +                       "bpf_defined_policy";
> +               ret =3D ops->handle_out_of_memory(oc);
> +               oc->bpf_policy_name =3D NULL;
> +               srcu_read_unlock(&bpf_oom->srcu, idx);
> +
> +               if (ret && oc->bpf_memory_freed)

IIUC ret and oc->bpf_memory_freed seem to reflect the same state:
handler successfully freed some memory. Could you please clarify when
they differ?



> +                       break;
> +       }
> +       srcu_read_unlock(&bpf_oom_srcu, list_idx);
> +
> +       return ret && oc->bpf_memory_freed;
> +}
> +
> +static int __handle_out_of_memory(struct oom_control *oc)
> +{
> +       return 0;
> +}
> +
> +static struct bpf_oom_ops __bpf_oom_ops =3D {
> +       .handle_out_of_memory =3D __handle_out_of_memory,
> +};
> +
> +static const struct bpf_func_proto *
> +bpf_oom_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog=
)
> +{
> +       return tracing_prog_func_proto(func_id, prog);
> +}
> +
> +static bool bpf_oom_ops_is_valid_access(int off, int size,
> +                                       enum bpf_access_type type,
> +                                       const struct bpf_prog *prog,
> +                                       struct bpf_insn_access_aux *info)
> +{
> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_verifier_ops bpf_oom_verifier_ops =3D {
> +       .get_func_proto =3D bpf_oom_func_proto,
> +       .is_valid_access =3D bpf_oom_ops_is_valid_access,
> +};
> +
> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct bpf_oom_ops *ops =3D kdata;
> +       struct bpf_oom *bpf_oom;
> +       int ret;
> +
> +       bpf_oom =3D kmalloc(sizeof(*bpf_oom), GFP_KERNEL_ACCOUNT);
> +       if (!bpf_oom)
> +               return -ENOMEM;
> +
> +       ret =3D init_srcu_struct(&bpf_oom->srcu);
> +       if (ret) {
> +               kfree(bpf_oom);
> +               return ret;
> +       }
> +
> +       WRITE_ONCE(bpf_oom->ops, ops);
> +       ops->bpf_oom =3D bpf_oom;
> +
> +       spin_lock(&bpf_oom_lock);
> +       list_add_rcu(&bpf_oom->node, &bpf_oom_handlers);
> +       spin_unlock(&bpf_oom_lock);
> +
> +       return 0;
> +}
> +
> +static void bpf_oom_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +       struct bpf_oom_ops *ops =3D kdata;
> +       struct bpf_oom *bpf_oom =3D ops->bpf_oom;
> +
> +       WRITE_ONCE(bpf_oom->ops, NULL);
> +
> +       spin_lock(&bpf_oom_lock);
> +       list_del_rcu(&bpf_oom->node);
> +       spin_unlock(&bpf_oom_lock);
> +
> +       synchronize_srcu(&bpf_oom->srcu);
> +
> +       kfree(bpf_oom);
> +}
> +
> +static int bpf_oom_ops_init_member(const struct btf_type *t,
> +                                  const struct btf_member *member,
> +                                  void *kdata, const void *udata)
> +{
> +       const struct bpf_oom_ops *uops =3D (const struct bpf_oom_ops *)ud=
ata;
> +       struct bpf_oom_ops *ops =3D (struct bpf_oom_ops *)kdata;
> +       u32 moff =3D __btf_member_bit_offset(t, member) / 8;
> +
> +       switch (moff) {
> +       case offsetof(struct bpf_oom_ops, name):
> +               strscpy_pad(ops->name, uops->name, sizeof(ops->name));
> +               return 1;
> +       }
> +       return 0;
> +}
> +
> +static int bpf_oom_ops_init(struct btf *btf)
> +{
> +       return 0;
> +}
> +
> +static struct bpf_struct_ops bpf_oom_bpf_ops =3D {
> +       .verifier_ops =3D &bpf_oom_verifier_ops,
> +       .reg =3D bpf_oom_ops_reg,
> +       .unreg =3D bpf_oom_ops_unreg,
> +       .init_member =3D bpf_oom_ops_init_member,
> +       .init =3D bpf_oom_ops_init,
> +       .name =3D "bpf_oom_ops",
> +       .owner =3D THIS_MODULE,
> +       .cfi_stubs =3D &__bpf_oom_ops
> +};
> +
> +static int __init bpf_oom_struct_ops_init(void)
> +{
> +       return register_bpf_struct_ops(&bpf_oom_bpf_ops, bpf_oom_ops);
> +}
> +late_initcall(bpf_oom_struct_ops_init);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..ad7bd65061d6 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -45,6 +45,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/cred.h>
>  #include <linux/nmi.h>
> +#include <linux/bpf_oom.h>
>
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -246,6 +247,15 @@ static const char * const oom_constraint_text[] =3D =
{
>         [CONSTRAINT_MEMCG] =3D "CONSTRAINT_MEMCG",
>  };
>
> +static const char *oom_policy_name(struct oom_control *oc)
> +{
> +#ifdef CONFIG_BPF_SYSCALL
> +       if (oc->bpf_policy_name)
> +               return oc->bpf_policy_name;
> +#endif
> +       return "default";
> +}
> +
>  /*
>   * Determine the type of allocation constraint.
>   */
> @@ -458,9 +468,10 @@ static void dump_oom_victim(struct oom_control *oc, =
struct task_struct *victim)
>
>  static void dump_header(struct oom_control *oc)
>  {
> -       pr_warn("%s invoked oom-killer: gfp_mask=3D%#x(%pGg), order=3D%d,=
 oom_score_adj=3D%hd\n",
> +       pr_warn("%s invoked oom-killer: gfp_mask=3D%#x(%pGg), order=3D%d,=
 oom_score_adj=3D%hd\noom_policy=3D%s\n",
>                 current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
> -                       current->signal->oom_score_adj);
> +               current->signal->oom_score_adj,
> +               oom_policy_name(oc));
>         if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
>                 pr_warn("COMPACTION is disabled!!!\n");
>
> @@ -1161,6 +1172,13 @@ bool out_of_memory(struct oom_control *oc)
>                 return true;
>         }
>
> +       /*
> +        * Let bpf handle the OOM first. If it was able to free up some m=
emory,
> +        * bail out. Otherwise fall back to the kernel OOM killer.
> +        */
> +       if (bpf_handle_oom(oc))
> +               return true;
> +
>         select_bad_process(oc);
>         /* Found nothing?!?! */
>         if (!oc->chosen) {
> --
> 2.50.1
>


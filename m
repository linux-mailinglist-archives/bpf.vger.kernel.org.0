Return-Path: <bpf+bounces-63076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6665B0232C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718021C48327
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B52F234C;
	Fri, 11 Jul 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/JPcyEX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA872F1FDE;
	Fri, 11 Jul 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256261; cv=none; b=QyvbbM1txnjCtL/6YaSIVXyaknk319ziR5rvVyV/CFCPOr3deWt8oTOFOg7fP5dYWC0lGhKoQY8tC4xBy5oKQaoUUDuuW5iRBe+3+Tf7OFTm4iHIdSg1mhIsDdN5fr8iYFd3lUK+N3Xb3l+/bJ6Nlv3XgAa6wL7tmT09VijdfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256261; c=relaxed/simple;
	bh=2tqKyWuizuNmLg+fTtLEwYJeoPoexXCOIb2hdKSESBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbDTuPH0OzCfUEIME6FVWNWvARunCZPZuqIXIFBIiEHctbgO8jiML/huHHG7LhhNSZF53wUejOuV0ZNNomMy496Qkoj9DiA8Fi1zNj12mwCefx12gHk+4gfeAcRaY+EQ3Gbe6uOrUwoMg4DKxCc5vD4QN7fV9YoesX2QyXsLRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/JPcyEX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313cde344d4so2559556a91.0;
        Fri, 11 Jul 2025 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752256259; x=1752861059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX68SzxToFpeOVomeuZNv5KE8Z7Adew8/Q+RlU7WVZw=;
        b=a/JPcyEXFQFwS1IyKu3nh9S9aOZmccmh9fGIzc9Z55TUKPJIJoS7OvFH5YixHM3XRA
         nMd4iEJyQrFoNTeRNYNIZ7w5juBTsq0aSYmExZh0rOKpuX7b9O87n4GAcGIUWUSnWh37
         Lyr8Bie6KTODgtvUz3DVbmIaK7bav+wy3L6sB5JNj2dCskAZveloEIsvKllxXOlAKq7L
         LoS7Pp0GRvdMIzNEK4gxYlCSlyCBrJmG5Hp2blkSjUNVh9EnYfY4sUgYUWg1qI07rvgH
         FDVXyUOhUwKfQ4jtJ8kDErNIm4yF4IZqGQxYSiJjrRhcCtfUl9tHx0EEEo+UenD/7dsf
         CNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752256259; x=1752861059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VX68SzxToFpeOVomeuZNv5KE8Z7Adew8/Q+RlU7WVZw=;
        b=iI0tqhCLqvao0z6aSnPXE+YR0guf7bRKdcpGnP7ghBPOFyUPx/Y20LUrfcB3JwnhFq
         pvr2UrC9+74HW/TFksvcdCAzG2dgOI27b/Cgq2HjZWjvikiFJbhXN72uyIyJERaoilvh
         a4yDsxKDVlZ1PPtXZAqPrmCuJ991ufmAoIVOcAeJiWHhTi1H3qXEYxKaht2o24lhtGRh
         4QFAkExeR9CFQsCdHhom8TreS9PTWF0GfrYU/3umGw+Hg833cTcK/yndQV+keixs+N6p
         2iKSe9AbCXKkCIB9Y8iszfdNx6TCYnN/AKsHUiuZWvpbd5WA59SU5ERRVrMVHdfQEn4z
         VoKg==
X-Forwarded-Encrypted: i=1; AJvYcCUb7EUzVtP52t4kIZCnZXVZtFJzyr8OMQetwfNElc3nHLCcrxlMRdum0DX0m/zuc/Qm3zP0fpA+gGElRKL/ZyxkP6uE@vger.kernel.org, AJvYcCUw6oasDJNoYlouvQ2+IUJpLZ8olem8bBAcQHjtoq9IfS2VA8+HotpwY5m3PgA+l/PDiIPs9zsq@vger.kernel.org, AJvYcCV+lCvPsNXeQ/ZcbxHV+GF6frTKbCvRVdX2jCiDeP4ItML4xgVrw0pmeWkfNPM04rXC8yrG2G6S2jsJaUtUUBDI@vger.kernel.org, AJvYcCVkOxkfa2tDsOFHDn/zp074k42CaUTC2yzYWiaO1qOBbGfYaW8+jVoo5NHjV48vPdgXBjbgBbHWMHc2XJXh@vger.kernel.org, AJvYcCXWdwRe+ef0YEo1Fo7t4dFtxMe/7AEJ5ecBaogoV59ohN5abdieHDRFGTaaQRdOFqFCX/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RyUfsuU2hKvEY3rbFd07ZVU6ddPNO4TVJ3QiGyRk8EqcSpzj
	HWhP++s04Xm6YpwFDPymF8l8xiRRCZ4/o69+uK6TWYEfWuOYLBME5Oeps5cs/112E/Q1nea64XC
	sdERh0pYFaCMsTS1cgBP86qZDMI1pURU=
X-Gm-Gg: ASbGncvKFzujWGNgBAMvcjiKdh89Amj/yMDg0Ot+2xSKjLgQgOLwHnnUN7MltSwI+IH
	qJdvafNFLHr6wKkQniNmWAS3NApmZAWKqGjF/CQMTa/dRb0j2WVztvrAbMNt9pYcDD5IsBpeTks
	iglH9sbX0//y4RR+D4KHppE/OQwCEVaZcvoQZVhW53hSj6BTkf9W9HLgDWlS8dWEWKZW+eJap2i
	rBsT6sDANtVXkmRFsXD0BU=
X-Google-Smtp-Source: AGHT+IF7/K0D9nsvfofY6WWDQFF52ZzCqrJiOFsdgjyZ+pDzzMVbIA3ChhDQi5qkPcSPjOFQYeYJmMotjU8u2RsVsz4=
X-Received: by 2002:a17:90b:33d1:b0:313:bf67:b354 with SMTP id
 98e67ed59e1d1-31c4f3a74efmr5857303a91.0.1752256258704; Fri, 11 Jul 2025
 10:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710032038.888700-1-chen.dylane@linux.dev> <20250710032038.888700-2-chen.dylane@linux.dev>
In-Reply-To: <20250710032038.888700-2-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Jul 2025 10:50:44 -0700
X-Gm-Features: Ac12FXxcbZV4WEunwd41YAUgAFpP7MH8xsS-VONXzDrgccYSHZthzAsPHNki4dM
Message-ID: <CAEf4BzZ49LCXQbCvm2qkYO=XmFzZC7t3ihJgXf+p2wjALRdPKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: Add attach_type in bpf_link
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net, razor@blackwall.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, horms@kernel.org, willemb@google.com, 
	jakub@cloudflare.com, pablo@netfilter.org, kadlec@netfilter.org, 
	hawk@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:22=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> Attach_type will be set when link created from user, it is better
> to record attach_type in bpf_link directly suggested by Andrii. So
> add the attach_type field in bpf_link and move the sleepable field to
> the end just to fill the byte hole.
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  drivers/net/netkit.c           |  2 +-
>  include/linux/bpf.h            | 28 ++++++++++++++++-----------
>  kernel/bpf/bpf_iter.c          |  3 ++-
>  kernel/bpf/bpf_struct_ops.c    |  5 +++--
>  kernel/bpf/cgroup.c            |  4 ++--
>  kernel/bpf/net_namespace.c     |  2 +-
>  kernel/bpf/syscall.c           | 35 +++++++++++++++++++++-------------
>  kernel/bpf/tcx.c               |  3 ++-
>  kernel/bpf/trampoline.c        | 10 ++++++----
>  kernel/trace/bpf_trace.c       |  4 ++--
>  net/bpf/bpf_dummy_struct_ops.c |  3 ++-
>  net/core/dev.c                 |  3 ++-
>  net/core/sock_map.c            |  3 ++-
>  net/netfilter/nf_bpf_link.c    |  3 ++-
>  14 files changed, 66 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index d072a7968f5..5928c99eac7 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -775,7 +775,7 @@ static int netkit_link_init(struct netkit_link *nkl,
>                             struct bpf_prog *prog)
>  {
>         bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
> -                     &netkit_link_lops, prog);
> +                     &netkit_link_lops, prog, attr->link_create.attach_t=
ype);
>         nkl->location =3D attr->link_create.attach_type;
>         nkl->dev =3D dev;
>         return bpf_link_prime(&nkl->link, link_primer);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 34dd90ec7fa..dd5070039de 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1729,12 +1729,10 @@ struct bpf_link {
>         enum bpf_link_type type;
>         const struct bpf_link_ops *ops;
>         struct bpf_prog *prog;
> -       /* whether BPF link itself has "sleepable" semantics, which can d=
iffer
> -        * from underlying BPF program having a "sleepable" semantics, as=
 BPF
> -        * link's semantics is determined by target attach hook
> -        */
> -       bool sleepable;
> +
>         u32 flags;
> +       enum bpf_attach_type attach_type;
> +
>         /* rcu is used before freeing, work can be used to schedule that
>          * RCU-based freeing before that, so they never overlap
>          */
> @@ -1742,6 +1740,11 @@ struct bpf_link {
>                 struct rcu_head rcu;
>                 struct work_struct work;
>         };
> +       /* whether BPF link itself has "sleepable" semantics, which can d=
iffer
> +        * from underlying BPF program having a "sleepable" semantics, as=
 BPF
> +        * link's semantics is determined by target attach hook
> +        */
> +       bool sleepable;
>  };
>
>  struct bpf_link_ops {
> @@ -2034,11 +2037,13 @@ int bpf_prog_ctx_arg_info_init(struct bpf_prog *p=
rog,
>
>  #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
>  int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
> -                                   int cgroup_atype);
> +                                   int cgroup_atype,
> +                                   enum bpf_attach_type attach_type);
>  void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
>  #else
>  static inline int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
> -                                                 int cgroup_atype)
> +                                                 int cgroup_atype,
> +                                                 enum bpf_attach_type at=
tach_type)
>  {
>         return -EOPNOTSUPP;
>  }
> @@ -2528,10 +2533,11 @@ int bpf_map_new_fd(struct bpf_map *map, int flags=
);
>  int bpf_prog_new_fd(struct bpf_prog *prog);
>
>  void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
> -                  const struct bpf_link_ops *ops, struct bpf_prog *prog)=
;
> +                  const struct bpf_link_ops *ops, struct bpf_prog *prog,
> +                  enum bpf_attach_type attach_type);
>  void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type t=
ype,
>                              const struct bpf_link_ops *ops, struct bpf_p=
rog *prog,
> -                            bool sleepable);
> +                            bool sleepable, enum bpf_attach_type attach_=
type);
>  int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer=
);
>  int bpf_link_settle(struct bpf_link_primer *primer);
>  void bpf_link_cleanup(struct bpf_link_primer *primer);
> @@ -2883,13 +2889,13 @@ bpf_prog_inc_not_zero(struct bpf_prog *prog)
>
>  static inline void bpf_link_init(struct bpf_link *link, enum bpf_link_ty=
pe type,
>                                  const struct bpf_link_ops *ops,
> -                                struct bpf_prog *prog)
> +                                struct bpf_prog *prog, enum bpf_attach_t=
ype attach_type)
>  {
>  }
>
>  static inline void bpf_link_init_sleepable(struct bpf_link *link, enum b=
pf_link_type type,
>                                            const struct bpf_link_ops *ops=
, struct bpf_prog *prog,
> -                                          bool sleepable)
> +                                          bool sleepable, enum bpf_attac=
h_type attach_type)

It would be more logical to have sleepable as the last argument,
because bpf_link_init_sleepable is conceptually identical to
bpf_link_init with the ability to specify "sleepability". So I
shuffled it while applying.

I also reworded some commit messages for a bit better readability.
Applied to bpf-next, thanks.



>  {
>  }
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 303ab1f42d3..0cbcae72707 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -552,7 +552,8 @@ int bpf_iter_link_attach(const union bpf_attr *attr, =
bpfptr_t uattr,
>         if (!link)
>                 return -ENOMEM;
>
> -       bpf_link_init(&link->link, BPF_LINK_TYPE_ITER, &bpf_iter_link_lop=
s, prog);
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_ITER, &bpf_iter_link_lop=
s, prog,
> +                     attr->link_create.attach_type);
>         link->tinfo =3D tinfo;
>
>         err =3D bpf_link_prime(&link->link, &link_primer);
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 96113633e39..687a3e9c76f 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -808,7 +808,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
>                         goto reset_unlock;
>                 }
>                 bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
> -                             &bpf_struct_ops_link_lops, prog);
> +                             &bpf_struct_ops_link_lops, prog, prog->expe=
cted_attach_type);
>                 *plink++ =3D &link->link;
>
>                 ksym =3D kzalloc(sizeof(*ksym), GFP_USER);
> @@ -1351,7 +1351,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr=
)
>                 err =3D -ENOMEM;
>                 goto err_out;
>         }
> -       bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_map_lops, NULL);
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_map_lops, NULL,
> +                     attr->link_create.attach_type);
>
>         err =3D bpf_link_prime(&link->link, &link_primer);
>         if (err)
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index cd220e861d6..bacdd0ca741 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -867,7 +867,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>         cgrp->bpf.flags[atype] =3D saved_flags;
>
>         if (type =3D=3D BPF_LSM_CGROUP) {
> -               err =3D bpf_trampoline_link_cgroup_shim(new_prog, atype);
> +               err =3D bpf_trampoline_link_cgroup_shim(new_prog, atype, =
type);
>                 if (err)
>                         goto cleanup;
>         }
> @@ -1495,7 +1495,7 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
>                 goto out_put_cgroup;
>         }
>         bpf_link_init(&link->link, BPF_LINK_TYPE_CGROUP, &bpf_cgroup_link=
_lops,
> -                     prog);
> +                     prog, attr->link_create.attach_type);
>         link->cgroup =3D cgrp;
>         link->type =3D attr->link_create.attach_type;
>
> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 868cc2c4389..63702c86275 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -501,7 +501,7 @@ int netns_bpf_link_create(const union bpf_attr *attr,=
 struct bpf_prog *prog)
>                 goto out_put_net;
>         }
>         bpf_link_init(&net_link->link, BPF_LINK_TYPE_NETNS,
> -                     &bpf_netns_link_ops, prog);
> +                     &bpf_netns_link_ops, prog, type);
>         net_link->net =3D net;
>         net_link->type =3D type;
>         net_link->netns_type =3D netns_type;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7db7182a305..14883b3040a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3069,7 +3069,7 @@ static int bpf_obj_get(const union bpf_attr *attr)
>   */
>  void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type t=
ype,
>                              const struct bpf_link_ops *ops, struct bpf_p=
rog *prog,
> -                            bool sleepable)
> +                            bool sleepable, enum bpf_attach_type attach_=
type)
>  {
>         WARN_ON(ops->dealloc && ops->dealloc_deferred);
>         atomic64_set(&link->refcnt, 1);
> @@ -3078,12 +3078,14 @@ void bpf_link_init_sleepable(struct bpf_link *lin=
k, enum bpf_link_type type,
>         link->id =3D 0;
>         link->ops =3D ops;
>         link->prog =3D prog;
> +       link->attach_type =3D attach_type;
>  }
>
>  void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
> -                  const struct bpf_link_ops *ops, struct bpf_prog *prog)
> +                  const struct bpf_link_ops *ops, struct bpf_prog *prog,
> +                  enum bpf_attach_type attach_type)
>  {
> -       bpf_link_init_sleepable(link, type, ops, prog, false);
> +       bpf_link_init_sleepable(link, type, ops, prog, false, attach_type=
);
>  }
>
>  static void bpf_link_free_id(int id)
> @@ -3443,7 +3445,8 @@ static const struct bpf_link_ops bpf_tracing_link_l=
ops =3D {
>  static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>                                    int tgt_prog_fd,
>                                    u32 btf_id,
> -                                  u64 bpf_cookie)
> +                                  u64 bpf_cookie,
> +                                  enum bpf_attach_type attach_type)
>  {
>         struct bpf_link_primer link_primer;
>         struct bpf_prog *tgt_prog =3D NULL;
> @@ -3511,7 +3514,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
>                 goto out_put_prog;
>         }
>         bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
> -                     &bpf_tracing_link_lops, prog);
> +                     &bpf_tracing_link_lops, prog, attach_type);
> +
>         link->attach_type =3D prog->expected_attach_type;
>         link->link.cookie =3D bpf_cookie;
>
> @@ -4049,7 +4053,8 @@ static int bpf_perf_link_attach(const union bpf_att=
r *attr, struct bpf_prog *pro
>                 err =3D -ENOMEM;
>                 goto out_put_file;
>         }
> -       bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_li=
nk_lops, prog);
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_li=
nk_lops, prog,
> +                     attr->link_create.attach_type);
>         link->perf_file =3D perf_file;
>
>         err =3D bpf_link_prime(&link->link, &link_primer);
> @@ -4081,7 +4086,8 @@ static int bpf_perf_link_attach(const union bpf_att=
r *attr, struct bpf_prog *pro
>  #endif /* CONFIG_PERF_EVENTS */
>
>  static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> -                                 const char __user *user_tp_name, u64 co=
okie)
> +                                 const char __user *user_tp_name, u64 co=
okie,
> +                                 enum bpf_attach_type attach_type)
>  {
>         struct bpf_link_primer link_primer;
>         struct bpf_raw_tp_link *link;
> @@ -4104,7 +4110,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *=
prog,
>                         tp_name =3D prog->aux->attach_func_name;
>                         break;
>                 }
> -               return bpf_tracing_prog_attach(prog, 0, 0, 0);
> +               return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type=
);
>         case BPF_PROG_TYPE_RAW_TRACEPOINT:
>         case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
>                 if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1)=
 < 0)
> @@ -4127,7 +4133,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *=
prog,
>         }
>         bpf_link_init_sleepable(&link->link, BPF_LINK_TYPE_RAW_TRACEPOINT=
,
>                                 &bpf_raw_tp_link_lops, prog,
> -                               tracepoint_is_faultable(btp->tp));
> +                               tracepoint_is_faultable(btp->tp), attach_=
type);
>         link->btp =3D btp;
>         link->cookie =3D cookie;
>
> @@ -4168,7 +4174,7 @@ static int bpf_raw_tracepoint_open(const union bpf_=
attr *attr)
>
>         tp_name =3D u64_to_user_ptr(attr->raw_tracepoint.name);
>         cookie =3D attr->raw_tracepoint.cookie;
> -       fd =3D bpf_raw_tp_link_attach(prog, tp_name, cookie);
> +       fd =3D bpf_raw_tp_link_attach(prog, tp_name, cookie, prog->expect=
ed_attach_type);
>         if (fd < 0)
>                 bpf_prog_put(prog);
>         return fd;
> @@ -5536,7 +5542,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>                 ret =3D bpf_tracing_prog_attach(prog,
>                                               attr->link_create.target_fd=
,
>                                               attr->link_create.target_bt=
f_id,
> -                                             attr->link_create.tracing.c=
ookie);
> +                                             attr->link_create.tracing.c=
ookie,
> +                                             attr->link_create.attach_ty=
pe);
>                 break;
>         case BPF_PROG_TYPE_LSM:
>         case BPF_PROG_TYPE_TRACING:
> @@ -5545,7 +5552,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>                         goto out;
>                 }
>                 if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> -                       ret =3D bpf_raw_tp_link_attach(prog, NULL, attr->=
link_create.tracing.cookie);
> +                       ret =3D bpf_raw_tp_link_attach(prog, NULL, attr->=
link_create.tracing.cookie,
> +                                                    attr->link_create.at=
tach_type);
>                 else if (prog->expected_attach_type =3D=3D BPF_TRACE_ITER=
)
>                         ret =3D bpf_iter_link_attach(attr, uattr, prog);
>                 else if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP=
)
> @@ -5554,7 +5562,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>                         ret =3D bpf_tracing_prog_attach(prog,
>                                                       attr->link_create.t=
arget_fd,
>                                                       attr->link_create.t=
arget_btf_id,
> -                                                     attr->link_create.t=
racing.cookie);
> +                                                     attr->link_create.t=
racing.cookie,
> +                                                     attr->link_create.a=
ttach_type);
>                 break;
>         case BPF_PROG_TYPE_FLOW_DISSECTOR:
>         case BPF_PROG_TYPE_SK_LOOKUP:
> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> index 2e4885e7781..e6a14f408d9 100644
> --- a/kernel/bpf/tcx.c
> +++ b/kernel/bpf/tcx.c
> @@ -301,7 +301,8 @@ static int tcx_link_init(struct tcx_link *tcx,
>                          struct net_device *dev,
>                          struct bpf_prog *prog)
>  {
> -       bpf_link_init(&tcx->link, BPF_LINK_TYPE_TCX, &tcx_link_lops, prog=
);
> +       bpf_link_init(&tcx->link, BPF_LINK_TYPE_TCX, &tcx_link_lops, prog=
,
> +                     attr->link_create.attach_type);
>         tcx->location =3D attr->link_create.attach_type;
>         tcx->dev =3D dev;
>         return bpf_link_prime(&tcx->link, link_primer);
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index b1e358c16ee..0e364614c3a 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -674,7 +674,8 @@ static const struct bpf_link_ops bpf_shim_tramp_link_=
lops =3D {
>
>  static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_pr=
og *prog,
>                                                      bpf_func_t bpf_func,
> -                                                    int cgroup_atype)
> +                                                    int cgroup_atype,
> +                                                    enum bpf_attach_type=
 attach_type)
>  {
>         struct bpf_shim_tramp_link *shim_link =3D NULL;
>         struct bpf_prog *p;
> @@ -701,7 +702,7 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(=
const struct bpf_prog *prog
>         p->expected_attach_type =3D BPF_LSM_MAC;
>         bpf_prog_inc(p);
>         bpf_link_init(&shim_link->link.link, BPF_LINK_TYPE_UNSPEC,
> -                     &bpf_shim_tramp_link_lops, p);
> +                     &bpf_shim_tramp_link_lops, p, attach_type);
>         bpf_cgroup_atype_get(p->aux->attach_btf_id, cgroup_atype);
>
>         return shim_link;
> @@ -726,7 +727,8 @@ static struct bpf_shim_tramp_link *cgroup_shim_find(s=
truct bpf_trampoline *tr,
>  }
>
>  int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
> -                                   int cgroup_atype)
> +                                   int cgroup_atype,
> +                                   enum bpf_attach_type attach_type)
>  {
>         struct bpf_shim_tramp_link *shim_link =3D NULL;
>         struct bpf_attach_target_info tgt_info =3D {};
> @@ -763,7 +765,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *=
prog,
>
>         /* Allocate and install new shim. */
>
> -       shim_link =3D cgroup_shim_alloc(prog, bpf_func, cgroup_atype);
> +       shim_link =3D cgroup_shim_alloc(prog, bpf_func, cgroup_atype, att=
ach_type);
>         if (!shim_link) {
>                 err =3D -ENOMEM;
>                 goto err;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index e7f97a9a8bb..ffdde840abb 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2986,7 +2986,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         }
>
>         bpf_link_init(&link->link, BPF_LINK_TYPE_KPROBE_MULTI,
> -                     &bpf_kprobe_multi_link_lops, prog);
> +                     &bpf_kprobe_multi_link_lops, prog, attr->link_creat=
e.attach_type);
>
>         err =3D bpf_link_prime(&link->link, &link_primer);
>         if (err)
> @@ -3441,7 +3441,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         link->link.flags =3D flags;
>
>         bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> -                     &bpf_uprobe_multi_link_lops, prog);
> +                     &bpf_uprobe_multi_link_lops, prog, attr->link_creat=
e.attach_type);
>
>         for (i =3D 0; i < cnt; i++) {
>                 uprobes[i].uprobe =3D uprobe_register(d_real_inode(link->=
path.dentry),
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
> index f71f67c6896..812457819b5 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -171,7 +171,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
>         }
>         /* prog doesn't take the ownership of the reference from caller *=
/
>         bpf_prog_inc(prog);
> -       bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_link_lops, prog);
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_link_lops, prog,
> +                     prog->expected_attach_type);
>
>         op_idx =3D prog->expected_attach_type;
>         err =3D bpf_struct_ops_prepare_trampoline(tlinks, link,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index be97c440ecd..7969fddc94e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10364,7 +10364,8 @@ int bpf_xdp_link_attach(const union bpf_attr *att=
r, struct bpf_prog *prog)
>                 goto unlock;
>         }
>
> -       bpf_link_init(&link->link, BPF_LINK_TYPE_XDP, &bpf_xdp_link_lops,=
 prog);
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_XDP, &bpf_xdp_link_lops,=
 prog,
> +                     attr->link_create.attach_type);
>         link->dev =3D dev;
>         link->flags =3D attr->link_create.flags;
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 82a14f131d0..fbe9a33ddf1 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1866,7 +1866,8 @@ int sock_map_link_create(const union bpf_attr *attr=
, struct bpf_prog *prog)
>         }
>
>         attach_type =3D attr->link_create.attach_type;
> -       bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_m=
ap_link_ops, prog);
> +       bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_m=
ap_link_ops, prog,
> +                     attach_type);
>         sockmap_link->map =3D map;
>         sockmap_link->attach_type =3D attach_type;
>
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index 06b08484470..a054d3b216d 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -225,7 +225,8 @@ int bpf_nf_link_attach(const union bpf_attr *attr, st=
ruct bpf_prog *prog)
>         if (!link)
>                 return -ENOMEM;
>
> -       bpf_link_init(&link->link, BPF_LINK_TYPE_NETFILTER, &bpf_nf_link_=
lops, prog);
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_NETFILTER, &bpf_nf_link_=
lops, prog,
> +                     attr->link_create.attach_type);
>
>         link->hook_ops.hook =3D nf_hook_run_bpf;
>         link->hook_ops.hook_ops_type =3D NF_HOOK_OP_BPF;
> --
> 2.48.1
>


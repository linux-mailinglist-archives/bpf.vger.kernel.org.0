Return-Path: <bpf+bounces-65936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55259B2B5BB
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF3525071
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59461B4247;
	Tue, 19 Aug 2025 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgWftAXA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E13AC3B;
	Tue, 19 Aug 2025 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566007; cv=none; b=WFSujAmntg1n9AL9+V8mVpYEL3LBtAFnGW/0hoYj1HLfDUmzo0BLyDtumzGnIeFrtDFkILn/t2GXKk2Jeckzz3X477VcXubv+91xy+kwey7iF9+e+C1kOYanF8y8WkwBWCJqK3t/Dhl6CUOWJQnTcumnJHd1JYUQ2idZHEMSzQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566007; c=relaxed/simple;
	bh=hdOQqsasSh7KKyV0xjXFZbTglkh55+aQ+Ce3husZ6I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeM0Hpl1QSu3m0X6AUs7skSXlYF4o0TnDWsarw2q9sXcjul3TQ0Eyur6iHRuEaU2CCrEqeec4MgyU9TBW7EzbILNUB2mgsr3F3dlkgIH9zNmHlOes1Tp05yvlPXnTK4pzZwxj5tOqrzgtv9iV8iT8Euyvd2aOTbq3k+/hW1pzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgWftAXA; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71d603b60cbso38134077b3.1;
        Mon, 18 Aug 2025 18:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755566005; x=1756170805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dD4BWjNIESViuGlKjroiVDn6mSOfuxrlLXoxyS7+rjw=;
        b=mgWftAXAK8PQclm1owBNMYDgD/6IO0khVfPTBVltsFXiOvPz461gW1J+ClKLejpyiM
         2MT+eEmp+bMHDnq9zHHKL8C2OcDwMoH8J0ceeA/J7jQk3/OyskV6m+28eLpwz8b6NdiP
         dsni88Df9hb/pzKuqhJTDGKVBAUsjz+vVciOkZ/yM9FToVTiLr/T2ceIUnY4j/VPQNeT
         W1hBA5Am4hs4XL2JOIvTxfkGKdrz0m/+kTK1E0X4pyeI0n7E3McgYuKdrceBAWjRynuV
         ymhCscUgPqU5Gwmy/8idoUGbOpDTWICneQh2/KN+STsS0qcfu2+lkXiaL0t2Fz+1QElJ
         JzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755566005; x=1756170805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dD4BWjNIESViuGlKjroiVDn6mSOfuxrlLXoxyS7+rjw=;
        b=uv4d9c4supG3iMtoXSWr3lsz+tmi5TyENstFkiaRlNPQym+9lEawCQFI4eYazs3zzz
         NWuxsGojwgDbaRTfyQvSUNY08gmKMVK1jKzS4Jyg154oKF4UYfwUGqVDOW8ZsflVSZ5n
         j+fgBZ8MRlJxtL2L5LJxq+192ytPNspOrSHKFTbhHWUFwroV6RYHIbRqwuyfYXxGZa+q
         y3KZrJi5Lx7ZYa/nhqR0xdHwvDienHAy8v6YAgDFqkalwxfOd2eMZaV2VmjaPSxLASll
         B7xNWOyt61qbmsCTXBimlEqm9Ni9Wi1l87bh7gZ98SMIuFhS96vU3VqI2vvcbQl4lo4R
         UtSA==
X-Forwarded-Encrypted: i=1; AJvYcCU35i2QceE/d7NketHvceFFSQ4Jo3XBSyM/ceLeHLfs36rORdeErX6j4mKuM+FI1+gkyU+RZdHgW6CIVVtV@vger.kernel.org, AJvYcCVgvS0xKSEuovIJNmfT0SmJRVWiWRugvYEqsPhGl1HOnpnT3O5kWPqjH+lFbWA3o0P1WezFdZRyya+Hsl4P9XY1Fule@vger.kernel.org, AJvYcCX4+DmWRG0NskHB5WXMzPhKmH+nvlUcDyraKPEMGiL3c2GJ4rXpZzKjIoogAZkZAV9Jmhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx515L/WcLxAmPnEnFaVxiQA+43b/J4dqvJ9c7BzOFyx1nxKFam
	vkc1Fb7iz7mZKmrLGr8iybYxuAXZPFxlD2dy5O+R4m3Q5GBtfCN5zKM/EVkv3uuegLoV5cpf9Sg
	w7xCL172p8bWZ7bDxEk+XQ/nj5VSscp99PTwee2M=
X-Gm-Gg: ASbGncsoBJIQkzd2CGrLjYLp8/zJqS+QVHa5+1DDKBAJPUexnd3QD1RfsNqPyHlhxgD
	12XmpaGuKPr/jQ+OsLkHv2QSvSz+OO8xPs7wm0wz2vAZ2jiz3DWQi1A1H7zxn3ndbpAUWJjQlIh
	gyhc7DnJlarvGrzPJ+ERQ9StEIPGQh6OY7WM1zBVlAM0xUVqTHPiTEJN6cj9po2jQ7qB/t/w+eX
	8+gjb4=
X-Google-Smtp-Source: AGHT+IHe1NZO10mZpBh5zHiF0fdB4RQnjhSDCzgjhVWxvO+i7ovwuxfWG6loHdMNHsSSUYPCmiXIx3yvOamHxWBs2Q4=
X-Received: by 2002:a05:690c:34ca:b0:70e:2d3d:ace6 with SMTP id
 00721157ae682-71f9d51acf6mr10297447b3.15.1755566004581; Mon, 18 Aug 2025
 18:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817024607.296117-1-dongml2@chinatelecom.cn>
 <20250817024607.296117-2-dongml2@chinatelecom.cn> <aKMuENl9omxi6OwJ@krava>
In-Reply-To: <aKMuENl9omxi6OwJ@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 19 Aug 2025 09:13:13 +0800
X-Gm-Features: Ac12FXzedCQscV8F_WS_bGxIdxrnM2SNFKpGvF4Rw4VUd_trw8GrczRmTZNBXp8
Message-ID: <CADxym3a+nsh06V_fRtdj5bQaPzvRxdhTFF560ohwW8iCghSb-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] fprobe: use rhltable for fprobe_ip_table
To: Jiri Olsa <olsajiri@gmail.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	hca@linux.ibm.com, revest@chromium.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 9:43=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Aug 17, 2025 at 10:46:02AM +0800, Menglong Dong wrote:
>
> SNIP
>
> > +/* Node insertion and deletion requires the fprobe_mutex */
> > +static int insert_fprobe_node(struct fprobe_hlist_node *node)
> > +{
> >       lockdep_assert_held(&fprobe_mutex);
> >
> > -     next =3D find_first_fprobe_node(ip);
> > -     if (next) {
> > -             hlist_add_before_rcu(&node->hlist, &next->hlist);
> > -             return;
> > -     }
> > -     head =3D &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BIT=
S)];
> > -     hlist_add_head_rcu(&node->hlist, head);
> > +     return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht=
_params);
> >  }
> >
> >  /* Return true if there are synonims */
> > @@ -92,9 +92,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_n=
ode *node)
> >       /* Avoid double deleting */
> >       if (READ_ONCE(node->fp) !=3D NULL) {
> >               WRITE_ONCE(node->fp, NULL);
> > -             hlist_del_rcu(&node->hlist);
> > +             rhltable_remove(&fprobe_ip_table, &node->hlist,
> > +                             fprobe_rht_params);
> >       }
> > -     return !!find_first_fprobe_node(node->addr);
> > +     return !!rhltable_lookup(&fprobe_ip_table, &node->addr,
> > +                              fprobe_rht_params);
>
> I think rhltable_lookup needs rcu lock

Hi, this is the write side part, which is protected by fprobe_mutex.
Do we need to use rcu_read_lock() in the write side when accessing
the protected list?

>
> >  }
> >
> >  /* Check existence of the fprobe */
> > @@ -249,9 +251,10 @@ static inline int __fprobe_kprobe_handler(unsigned=
 long ip, unsigned long parent
> >  static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_=
ops *gops,
> >                       struct ftrace_regs *fregs)
> >  {
> > -     struct fprobe_hlist_node *node, *first;
> >       unsigned long *fgraph_data =3D NULL;
> >       unsigned long func =3D trace->func;
> > +     struct fprobe_hlist_node *node;
> > +     struct rhlist_head *head, *pos;
> >       unsigned long ret_ip;
> >       int reserved_words;
> >       struct fprobe *fp;
> > @@ -260,14 +263,11 @@ static int fprobe_entry(struct ftrace_graph_ent *=
trace, struct fgraph_ops *gops,
> >       if (WARN_ON_ONCE(!fregs))
> >               return 0;
> >
> > -     first =3D node =3D find_first_fprobe_node(func);
> > -     if (unlikely(!first))
> > -             return 0;
> > -
> > +     head =3D rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_para=
ms);

The whole function graphic handler is protected by preempt_disable,
which indicates rcu_read_lock. So we don't need to use rcu_read_lock()
here again:

https://lore.kernel.org/bpf/20250816235023.4dabfbc13a46a859de61cf4d@kernel.=
org/

Thanks!
Menglong Dong

>
> ditto
>
> jirka
>
>
> >       reserved_words =3D 0;
> > -     hlist_for_each_entry_from_rcu(node, hlist) {
> > +     rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >               if (node->addr !=3D func)
> > -                     break;
> > +                     continue;
> >               fp =3D READ_ONCE(node->fp);
> >               if (!fp || !fp->exit_handler)
> >                       continue;
> > @@ -278,13 +278,12 @@ static int fprobe_entry(struct ftrace_graph_ent *=
trace, struct fgraph_ops *gops,
> >               reserved_words +=3D
> >                       FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->ent=
ry_data_size);
> >       }
> > -     node =3D first;
> >       if (reserved_words) {
> >               fgraph_data =3D fgraph_reserve_data(gops->idx, reserved_w=
ords * sizeof(long));
> >               if (unlikely(!fgraph_data)) {
> > -                     hlist_for_each_entry_from_rcu(node, hlist) {
> > +                     rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >                               if (node->addr !=3D func)
> > -                                     break;
> > +                                     continue;
> >                               fp =3D READ_ONCE(node->fp);
> >                               if (fp && !fprobe_disabled(fp))
> >                                       fp->nmissed++;
> > @@ -299,12 +298,12 @@ static int fprobe_entry(struct ftrace_graph_ent *=
trace, struct fgraph_ops *gops,
> >        */
> >       ret_ip =3D ftrace_regs_get_return_address(fregs);
> >       used =3D 0;
> > -     hlist_for_each_entry_from_rcu(node, hlist) {
> > +     rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >               int data_size;
> >               void *data;
> >
> >               if (node->addr !=3D func)
> > -                     break;
> > +                     continue;
> >               fp =3D READ_ONCE(node->fp);
> >               if (!fp || fprobe_disabled(fp))
> >                       continue;
> > @@ -448,25 +447,21 @@ static int fprobe_addr_list_add(struct fprobe_add=
r_list *alist, unsigned long ad
> >       return 0;
> >  }
> >
> > -static void fprobe_remove_node_in_module(struct module *mod, struct hl=
ist_head *head,
> > -                                     struct fprobe_addr_list *alist)
> > +static void fprobe_remove_node_in_module(struct module *mod, struct fp=
robe_hlist_node *node,
> > +                                      struct fprobe_addr_list *alist)
> >  {
> > -     struct fprobe_hlist_node *node;
> >       int ret =3D 0;
> >
> > -     hlist_for_each_entry_rcu(node, head, hlist,
> > -                              lockdep_is_held(&fprobe_mutex)) {
> > -             if (!within_module(node->addr, mod))
> > -                     continue;
> > -             if (delete_fprobe_node(node))
> > -                     continue;
> > -             /*
> > -              * If failed to update alist, just continue to update hli=
st.
> > -              * Therefore, at list user handler will not hit anymore.
> > -              */
> > -             if (!ret)
> > -                     ret =3D fprobe_addr_list_add(alist, node->addr);
> > -     }
> > +     if (!within_module(node->addr, mod))
> > +             return;
> > +     if (delete_fprobe_node(node))
> > +             return;
> > +     /*
> > +      * If failed to update alist, just continue to update hlist.
> > +      * Therefore, at list user handler will not hit anymore.
> > +      */
> > +     if (!ret)
> > +             ret =3D fprobe_addr_list_add(alist, node->addr);
> >  }
> >
> >  /* Handle module unloading to manage fprobe_ip_table. */
> > @@ -474,8 +469,9 @@ static int fprobe_module_callback(struct notifier_b=
lock *nb,
> >                                 unsigned long val, void *data)
> >  {
> >       struct fprobe_addr_list alist =3D {.size =3D FPROBE_IPS_BATCH_INI=
T};
> > +     struct fprobe_hlist_node *node;
> > +     struct rhashtable_iter iter;
> >       struct module *mod =3D data;
> > -     int i;
> >
> >       if (val !=3D MODULE_STATE_GOING)
> >               return NOTIFY_DONE;
> > @@ -486,8 +482,16 @@ static int fprobe_module_callback(struct notifier_=
block *nb,
> >               return NOTIFY_DONE;
> >
> >       mutex_lock(&fprobe_mutex);
> > -     for (i =3D 0; i < FPROBE_IP_TABLE_SIZE; i++)
> > -             fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &a=
list);
> > +     rhltable_walk_enter(&fprobe_ip_table, &iter);
> > +     do {
> > +             rhashtable_walk_start(&iter);
> > +
> > +             while ((node =3D rhashtable_walk_next(&iter)) && !IS_ERR(=
node))
> > +                     fprobe_remove_node_in_module(mod, node, &alist);
> > +
> > +             rhashtable_walk_stop(&iter);
> > +     } while (node =3D=3D ERR_PTR(-EAGAIN));
> > +     rhashtable_walk_exit(&iter);
> >
> >       if (alist.index < alist.size && alist.index > 0)
> >               ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> > @@ -727,8 +731,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigne=
d long *addrs, int num)
> >       ret =3D fprobe_graph_add_ips(addrs, num);
> >       if (!ret) {
> >               add_fprobe_hash(fp);
> > -             for (i =3D 0; i < hlist_array->size; i++)
> > -                     insert_fprobe_node(&hlist_array->array[i]);
> > +             for (i =3D 0; i < hlist_array->size; i++) {
> > +                     ret =3D insert_fprobe_node(&hlist_array->array[i]=
);
> > +                     if (ret)
> > +                             break;
> > +             }
> > +             /* fallback on insert error */
> > +             if (ret) {
> > +                     for (i--; i >=3D 0; i--)
> > +                             delete_fprobe_node(&hlist_array->array[i]=
);
> > +             }
> >       }
> >       mutex_unlock(&fprobe_mutex);
> >
> > @@ -824,3 +836,10 @@ int unregister_fprobe(struct fprobe *fp)
> >       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_fprobe);
> > +
> > +static int __init fprobe_initcall(void)
> > +{
> > +     rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
> > +     return 0;
> > +}
> > +late_initcall(fprobe_initcall);
> > --
> > 2.50.1
> >
> >


Return-Path: <bpf+bounces-65958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06718B2B6EC
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 04:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DD1B6588F
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8867287519;
	Tue, 19 Aug 2025 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8hXo6ES"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944A4A35;
	Tue, 19 Aug 2025 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570396; cv=none; b=elqgJGLbc69AqP11xzd5gjsMIMVK7/SPN1ZpYYalSnQlYdAW95RxatBBik8v4RGY2EP9ojdIhNZOMhjqOPAMelv5iNM2g+/TxeB6XZAf1nwS/8nKQvyXhX4drlckNiAhfyCurdeGFVL1pUOmo95YxX+T+hpQ4BgJ44caHdA8dxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570396; c=relaxed/simple;
	bh=UH9/hGhuZ6OMy84FUB7SLpnXF+2APKONFC2CX7EJMa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBpoLjm3COHpAog5u3X8CyX2Wf197xP4HFVSD6P9Jj1gjv3WFkyR0/9R+LE2BEh8OFvL7pzTO/s6P7yF57hC5oeLRHK7j1xgx81XEFCz1c9yFXg9kF7MAhEBglzEIxejyJSP2DzgLvOTGbGCPguIqMC+jq+wDfCTX7XLLTw3/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8hXo6ES; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71d60504788so42421557b3.2;
        Mon, 18 Aug 2025 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755570393; x=1756175193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzVE8+zzk96opJ/55v/R+F/0KCH0XlnJSNuRh1m/0j4=;
        b=a8hXo6ESnK93sQU0Pq2YqsJQX99GArbCqBylPdtJvzJw4QSU1BphVCoHTqI+G9czEZ
         CDwE8v7n6nUBI04oerxBt+JQ6Kck9bGfVvPvJo0aROsR9v1pMHdPv11gs6WjRvE4Kvn/
         qU5NG1pQTo3uu/DSgB7h1YUlSdLxej9ziBx2zp8FQ2qD4fDyvIyyZ6LUzw7ti0mzn9Mk
         BpOtaIeRgg7JbJde8WbvbBNvfWI2BwB4c+god50Y9AZG5eJ6tDr0KYNQuRa+QhVz3lY2
         Hw+akLhJ6AXwviY46ePgeXEbNxEQyAGX66GKqlKmiDLiJfyMkT1VCP6sdgiZU3h6hluR
         /FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755570393; x=1756175193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzVE8+zzk96opJ/55v/R+F/0KCH0XlnJSNuRh1m/0j4=;
        b=cAz8e1qN7CKWesvTFjZHQ6RPR5pSbmfp6TXUGeiwaLUL9NCEjwKSp85zvTYb6tuzbG
         itVT2oNWTlvRd1gvEzHKx4bx9dIw4MGXCRUs4nFxfEl3UfbUh5OydRcEEOtJ6YF/KnsB
         3e2eKtbtQ2jjJr7V/+BIvZF3dTmQe/imzlx2tNuEru+dTqPMXUduPSdkYePVoIfsScwl
         Fys9C9Lfnqfp96fWJEamiAKQo8jlnsGELNKJNOLVr9Wq8uLSZfXtnmkUe75KThDH+jK7
         YD7EfgK0MYx23zcOw7oOzLvXGG9CnYlnhQ8yQAkSMN8LU6mr7/B97ODLFe5lTysGaiSO
         d8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGY6cXQVR5qeaVugSOpm5jYzVRlio/b9gQV+EinRWly7G93M0/3JCtY7Ik+8HgjbVZQNkHUmmevf3fTjLC@vger.kernel.org, AJvYcCVDmm5/aqTibi1Pn99xjqhiEYx+nTtq6dLYYBFXwcL5t4fG2/gvETZBd678ihLZJRCsItU=@vger.kernel.org, AJvYcCWY3zllImbbZcuXxIYHxRhaCra7sa/9Q2h82dNcssRXS1TY+UO9ro2YyRUDk5UkDzqJcaiHF8b7ajP7MjptMVs5bWKR@vger.kernel.org
X-Gm-Message-State: AOJu0YxIB+eRumoTzAelVQKePghXKefgBEnYTbAEm3eEjTq1QWVve4vZ
	KTqqL+2ZleVbZ1p3SM/Ke0qU6AhHWzNaS88f4Hsvl6eWQKj9oZPZ3q3j5mOVdNS5649ETXpg6Mw
	Xa0DvQWApz4znnYxAZdwLMikIMjl10YI=
X-Gm-Gg: ASbGncu+uN2mErcxVvttVaduxhGqLNMSSaHQnaoCl7x1QNFLpCTFwc66uM0wt9ZK7I7
	FmFpBIo9wu24EGvtIAjdcFhkUU4NcjmYUexCmz4uVEzPdETGehmLDFNK87RlT7HIa9Ua6OR/GDH
	YX12wlGOsuPEiMlZZJ6SWVQABXQwrhJAzYERGphzZqYpPNm7VVNlmy10s3Rl433rf1viHH/ETbA
	3C/LdY=
X-Google-Smtp-Source: AGHT+IGslcv87vi8WdVzMgua5GGm7oc5vrEQwtBASPJ/LykwiRMBsmhqzOG8KIR665jfE/AuhXd2nowLkQ2fyAF5CGU=
X-Received: by 2002:a05:690c:708f:b0:71a:3698:b8bf with SMTP id
 00721157ae682-71f9d56634emr13439277b3.13.1755570393460; Mon, 18 Aug 2025
 19:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817024607.296117-1-dongml2@chinatelecom.cn>
 <20250817024607.296117-2-dongml2@chinatelecom.cn> <aKMuENl9omxi6OwJ@krava> <20250819111111.40f443fd7faae8e92f93beaf@kernel.org>
In-Reply-To: <20250819111111.40f443fd7faae8e92f93beaf@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 19 Aug 2025 10:26:22 +0800
X-Gm-Features: Ac12FXzyI2upCyAbfpbjCODs5lYHm9giS0numHgZ1rZBjI-EanGTwDDAoKn4bro
Message-ID: <CADxym3bYjj0ecuce3HaOihks3AU5fEmOKvC3FNzbK=cpu6+RoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] fprobe: use rhltable for fprobe_ip_table
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	hca@linux.ibm.com, revest@chromium.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:11=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Mon, 18 Aug 2025 15:43:44 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
>
> > On Sun, Aug 17, 2025 at 10:46:02AM +0800, Menglong Dong wrote:
> >
> > SNIP
> >
> > > +/* Node insertion and deletion requires the fprobe_mutex */
> > > +static int insert_fprobe_node(struct fprobe_hlist_node *node)
> > > +{
> > >     lockdep_assert_held(&fprobe_mutex);
> > >
> > > -   next =3D find_first_fprobe_node(ip);
> > > -   if (next) {
> > > -           hlist_add_before_rcu(&node->hlist, &next->hlist);
> > > -           return;
> > > -   }
> > > -   head =3D &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BIT=
S)];
> > > -   hlist_add_head_rcu(&node->hlist, head);
> > > +   return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht=
_params);
> > >  }
> > >
> > >  /* Return true if there are synonims */
> > > @@ -92,9 +92,11 @@ static bool delete_fprobe_node(struct fprobe_hlist=
_node *node)
> > >     /* Avoid double deleting */
> > >     if (READ_ONCE(node->fp) !=3D NULL) {
> > >             WRITE_ONCE(node->fp, NULL);
> > > -           hlist_del_rcu(&node->hlist);
> > > +           rhltable_remove(&fprobe_ip_table, &node->hlist,
> > > +                           fprobe_rht_params);
> > >     }
> > > -   return !!find_first_fprobe_node(node->addr);
> > > +   return !!rhltable_lookup(&fprobe_ip_table, &node->addr,
> > > +                            fprobe_rht_params);
> >
> > I think rhltable_lookup needs rcu lock
>
> Good catch! Hmm, previously we guaranteed that the find_first_fprobe_node=
()
> must be called under rcu read locked or fprobe_mutex locked, so that the
> node list should not be changed. But according to the comment of
> rhltable_lookup(), we need to lock the rcu_read_lock() around that.

Hmm, I thought that we don't need the rcu_read_lock() when we hold
fprobe_mutex. It seems that the thing is not as simple as I thought.

I'll split this patch out and send a V6 with this modification.

Thanks!
Menglong Dong

>
> >
> > >  }
> > >
> > >  /* Check existence of the fprobe */
> > > @@ -249,9 +251,10 @@ static inline int __fprobe_kprobe_handler(unsign=
ed long ip, unsigned long parent
> > >  static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgrap=
h_ops *gops,
> > >                     struct ftrace_regs *fregs)
> > >  {
> > > -   struct fprobe_hlist_node *node, *first;
> > >     unsigned long *fgraph_data =3D NULL;
> > >     unsigned long func =3D trace->func;
> > > +   struct fprobe_hlist_node *node;
> > > +   struct rhlist_head *head, *pos;
> > >     unsigned long ret_ip;
> > >     int reserved_words;
> > >     struct fprobe *fp;
> > > @@ -260,14 +263,11 @@ static int fprobe_entry(struct ftrace_graph_ent=
 *trace, struct fgraph_ops *gops,
> > >     if (WARN_ON_ONCE(!fregs))
> > >             return 0;
> > >
> > > -   first =3D node =3D find_first_fprobe_node(func);
> > > -   if (unlikely(!first))
> > > -           return 0;
> > > -
> > > +   head =3D rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_para=
ms);
> >
> > ditto
>
> So this was pointed in the previous thread. In fprobe_entry(), the
> preempt is disabled already. Thus we don't need locking rcu.
>
> Thank you,
>
> >
> > jirka
> >
> >
> > >     reserved_words =3D 0;
> > > -   hlist_for_each_entry_from_rcu(node, hlist) {
> > > +   rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > >             if (node->addr !=3D func)
> > > -                   break;
> > > +                   continue;
> > >             fp =3D READ_ONCE(node->fp);
> > >             if (!fp || !fp->exit_handler)
> > >                     continue;
> > > @@ -278,13 +278,12 @@ static int fprobe_entry(struct ftrace_graph_ent=
 *trace, struct fgraph_ops *gops,
> > >             reserved_words +=3D
> > >                     FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->ent=
ry_data_size);
> > >     }
> > > -   node =3D first;
> > >     if (reserved_words) {
> > >             fgraph_data =3D fgraph_reserve_data(gops->idx, reserved_w=
ords * sizeof(long));
> > >             if (unlikely(!fgraph_data)) {
> > > -                   hlist_for_each_entry_from_rcu(node, hlist) {
> > > +                   rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > >                             if (node->addr !=3D func)
> > > -                                   break;
> > > +                                   continue;
> > >                             fp =3D READ_ONCE(node->fp);
> > >                             if (fp && !fprobe_disabled(fp))
> > >                                     fp->nmissed++;
> > > @@ -299,12 +298,12 @@ static int fprobe_entry(struct ftrace_graph_ent=
 *trace, struct fgraph_ops *gops,
> > >      */
> > >     ret_ip =3D ftrace_regs_get_return_address(fregs);
> > >     used =3D 0;
> > > -   hlist_for_each_entry_from_rcu(node, hlist) {
> > > +   rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > >             int data_size;
> > >             void *data;
> > >
> > >             if (node->addr !=3D func)
> > > -                   break;
> > > +                   continue;
> > >             fp =3D READ_ONCE(node->fp);
> > >             if (!fp || fprobe_disabled(fp))
> > >                     continue;
> > > @@ -448,25 +447,21 @@ static int fprobe_addr_list_add(struct fprobe_a=
ddr_list *alist, unsigned long ad
> > >     return 0;
> > >  }
> > >
> > > -static void fprobe_remove_node_in_module(struct module *mod, struct =
hlist_head *head,
> > > -                                   struct fprobe_addr_list *alist)
> > > +static void fprobe_remove_node_in_module(struct module *mod, struct =
fprobe_hlist_node *node,
> > > +                                    struct fprobe_addr_list *alist)
> > >  {
> > > -   struct fprobe_hlist_node *node;
> > >     int ret =3D 0;
> > >
> > > -   hlist_for_each_entry_rcu(node, head, hlist,
> > > -                            lockdep_is_held(&fprobe_mutex)) {
> > > -           if (!within_module(node->addr, mod))
> > > -                   continue;
> > > -           if (delete_fprobe_node(node))
> > > -                   continue;
> > > -           /*
> > > -            * If failed to update alist, just continue to update hli=
st.
> > > -            * Therefore, at list user handler will not hit anymore.
> > > -            */
> > > -           if (!ret)
> > > -                   ret =3D fprobe_addr_list_add(alist, node->addr);
> > > -   }
> > > +   if (!within_module(node->addr, mod))
> > > +           return;
> > > +   if (delete_fprobe_node(node))
> > > +           return;
> > > +   /*
> > > +    * If failed to update alist, just continue to update hlist.
> > > +    * Therefore, at list user handler will not hit anymore.
> > > +    */
> > > +   if (!ret)
> > > +           ret =3D fprobe_addr_list_add(alist, node->addr);
> > >  }
> > >
> > >  /* Handle module unloading to manage fprobe_ip_table. */
> > > @@ -474,8 +469,9 @@ static int fprobe_module_callback(struct notifier=
_block *nb,
> > >                               unsigned long val, void *data)
> > >  {
> > >     struct fprobe_addr_list alist =3D {.size =3D FPROBE_IPS_BATCH_INI=
T};
> > > +   struct fprobe_hlist_node *node;
> > > +   struct rhashtable_iter iter;
> > >     struct module *mod =3D data;
> > > -   int i;
> > >
> > >     if (val !=3D MODULE_STATE_GOING)
> > >             return NOTIFY_DONE;
> > > @@ -486,8 +482,16 @@ static int fprobe_module_callback(struct notifie=
r_block *nb,
> > >             return NOTIFY_DONE;
> > >
> > >     mutex_lock(&fprobe_mutex);
> > > -   for (i =3D 0; i < FPROBE_IP_TABLE_SIZE; i++)
> > > -           fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &a=
list);
> > > +   rhltable_walk_enter(&fprobe_ip_table, &iter);
> > > +   do {
> > > +           rhashtable_walk_start(&iter);
> > > +
> > > +           while ((node =3D rhashtable_walk_next(&iter)) && !IS_ERR(=
node))
> > > +                   fprobe_remove_node_in_module(mod, node, &alist);
> > > +
> > > +           rhashtable_walk_stop(&iter);
> > > +   } while (node =3D=3D ERR_PTR(-EAGAIN));
> > > +   rhashtable_walk_exit(&iter);
> > >
> > >     if (alist.index < alist.size && alist.index > 0)
> > >             ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> > > @@ -727,8 +731,16 @@ int register_fprobe_ips(struct fprobe *fp, unsig=
ned long *addrs, int num)
> > >     ret =3D fprobe_graph_add_ips(addrs, num);
> > >     if (!ret) {
> > >             add_fprobe_hash(fp);
> > > -           for (i =3D 0; i < hlist_array->size; i++)
> > > -                   insert_fprobe_node(&hlist_array->array[i]);
> > > +           for (i =3D 0; i < hlist_array->size; i++) {
> > > +                   ret =3D insert_fprobe_node(&hlist_array->array[i]=
);
> > > +                   if (ret)
> > > +                           break;
> > > +           }
> > > +           /* fallback on insert error */
> > > +           if (ret) {
> > > +                   for (i--; i >=3D 0; i--)
> > > +                           delete_fprobe_node(&hlist_array->array[i]=
);
> > > +           }
> > >     }
> > >     mutex_unlock(&fprobe_mutex);
> > >
> > > @@ -824,3 +836,10 @@ int unregister_fprobe(struct fprobe *fp)
> > >     return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(unregister_fprobe);
> > > +
> > > +static int __init fprobe_initcall(void)
> > > +{
> > > +   rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
> > > +   return 0;
> > > +}
> > > +late_initcall(fprobe_initcall);
> > > --
> > > 2.50.1
> > >
> > >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


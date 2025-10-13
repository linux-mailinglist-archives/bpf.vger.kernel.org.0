Return-Path: <bpf+bounces-70796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5CBD1157
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 03:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D519B4E9DE5
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916F82AE8E;
	Mon, 13 Oct 2025 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XV4Fj88C"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285621E087
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760318469; cv=none; b=XDy9FFzW9Wxq24SLqkzCTy4/0XgX/+WqcoOngaI7aukeQbMvgF0M/ykxDz421Xp2HBVmYuazcGuA4Rc39L2wDG6iljl4hhzQ/eSI/eWJFXnlUneY8UYYw1LrfEPuXKzbVnlAmqR3yOW241XKwhIOaMYSR4ipVfNsEV87PeuQJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760318469; c=relaxed/simple;
	bh=u73qErM8gG9rcmN+2xK2j3Afp4fY/KgmP4XQxXROrz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp84uVdCFKeshKxSWI2VA81Ed9/4Y9BMgmqOAenmgRPW3F98MO4aCm+cM6Sc9193ChOPflPXn18otML0M5bj5FRIZQQFqKJ11/0B9UlliJ5oJe+iNiHBe3XPJOuLCV3ROep1sKYFk7qaY9Mj81laRDZ15lks5SjXt9wFj0Nn4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XV4Fj88C; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760318454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GOTA7JJb9rPGd8nAb0miSTZ1zK684lf0RfbpiyY6Zc=;
	b=XV4Fj88CuejHfTEFsvb6vnVdWatnQlsyAf2jllYL1b+lYYqPcmKO8IPwkBXQRsmLwL50rP
	5toDvX0UWQOuNOGX5faM92PB75qhVRCXsOZy9zNA+EzKEUZPfit1VFHc13WG6Cid5nkaQU
	ZRyj0eeR7EIg0qlt1ryaKdsB6QC9zlE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: fprobe: optimization for entry only case
Date: Mon, 13 Oct 2025 09:20:42 +0800
Message-ID: <2802160.mvXUDI8C0e@7950hx>
In-Reply-To: <20251012130711.0ea063ac467cb5833a81bd54@kernel.org>
References:
 <20251010033847.31008-1-dongml2@chinatelecom.cn>
 <20251010033847.31008-2-dongml2@chinatelecom.cn>
 <20251012130711.0ea063ac467cb5833a81bd54@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/12 12:07, Masami Hiramatsu wrote:
> Hi Menglong,
>=20
> On Fri, 10 Oct 2025 11:38:46 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>=20
> > For now, fgraph is used for the fprobe, even if we need trace the entry
> > only. However, the performance of ftrace is better than fgraph, and we
> > can use ftrace_ops for this case.
> >=20
> > Then performance of kprobe-multi increases from 54M to 69M. Before this
> > commit:
> >=20
> >   $ ./benchs/run_bench_trigger.sh kprobe-multi
> >   kprobe-multi   :   54.663 =C2=B1 0.493M/s
> >=20
> > After this commit:
> >=20
> >   $ ./benchs/run_bench_trigger.sh kprobe-multi
> >   kprobe-multi   :   69.447 =C2=B1 0.143M/s
> >=20
> > Mitigation is disable during the bench testing above.
> >=20
>=20
> Thanks for updating!
>=20
> This looks good to me. Just a nit comment below;
>=20
> [...]
> > @@ -379,11 +380,82 @@ static void fprobe_return(struct ftrace_graph_ret=
 *trace,
> >  NOKPROBE_SYMBOL(fprobe_return);
> > =20
> >  static struct fgraph_ops fprobe_graph_ops =3D {
> > -	.entryfunc	=3D fprobe_entry,
> > +	.entryfunc	=3D fprobe_fgraph_entry,
> >  	.retfunc	=3D fprobe_return,
> >  };
> >  static int fprobe_graph_active;
> > =20
> > +/* ftrace_ops callback, this processes fprobes which have only entry_h=
andler. */
> > +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent=
_ip,
> > +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +{
> > +	struct fprobe_hlist_node *node;
> > +	struct rhlist_head *head, *pos;
> > +	struct fprobe *fp;
> > +	int bit;
> > +
> > +	bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > +	if (bit < 0)
> > +		return;
> > +
>=20
> nit: We'd better to explain why we need this here too;
>=20
> 	/*
> 	 * ftrace_test_recursion_trylock() disables preemption, but
> 	 * rhltable_lookup() checks whether rcu_read_lcok is held.
> 	 * So we take rcu_read_lock() here.
> 	 */

It's very nice! I'll send a V3 now.

Thanks!
Menglong Dong

>=20
> > +	rcu_read_lock();
> > +	head =3D rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
> > +
> > +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > +		if (node->addr !=3D ip)
> > +			break;
> > +		fp =3D READ_ONCE(node->fp);
> > +		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
> > +			continue;
> > +
> > +		if (fprobe_shared_with_kprobes(fp))
> > +			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
> > +		else
> > +			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
> > +	}
> > +	rcu_read_unlock();
> > +	ftrace_test_recursion_unlock(bit);
> > +}
> > +NOKPROBE_SYMBOL(fprobe_ftrace_entry);
>=20
> Thank you,
>=20
> > +
> > +static struct ftrace_ops fprobe_ftrace_ops =3D {
> > +	.func	=3D fprobe_ftrace_entry,
> > +	.flags	=3D FTRACE_OPS_FL_SAVE_REGS,
> > +};
> > +static int fprobe_ftrace_active;
> > +
> > +static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
> > +{
> > +	int ret;
> > +
> > +	lockdep_assert_held(&fprobe_mutex);
> > +
> > +	ret =3D ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 0, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!fprobe_ftrace_active) {
> > +		ret =3D register_ftrace_function(&fprobe_ftrace_ops);
> > +		if (ret) {
> > +			ftrace_free_filter(&fprobe_ftrace_ops);
> > +			return ret;
> > +		}
> > +	}
> > +	fprobe_ftrace_active++;
> > +	return 0;
> > +}
> > +
> > +static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
> > +{
> > +	lockdep_assert_held(&fprobe_mutex);
> > +
> > +	fprobe_ftrace_active--;
> > +	if (!fprobe_ftrace_active)
> > +		unregister_ftrace_function(&fprobe_ftrace_ops);
> > +	if (num)
> > +		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
> > +}
> > +
> >  /* Add @addrs to the ftrace filter and register fgraph if needed. */
> >  static int fprobe_graph_add_ips(unsigned long *addrs, int num)
> >  {
> > @@ -498,9 +570,12 @@ static int fprobe_module_callback(struct notifier_=
block *nb,
> >  	} while (node =3D=3D ERR_PTR(-EAGAIN));
> >  	rhashtable_walk_exit(&iter);
> > =20
> > -	if (alist.index > 0)
> > +	if (alist.index > 0) {
> >  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> >  				      alist.addrs, alist.index, 1, 0);
> > +		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> > +				      alist.addrs, alist.index, 1, 0);
> > +	}
> >  	mutex_unlock(&fprobe_mutex);
> > =20
> >  	kfree(alist.addrs);
> > @@ -733,7 +808,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigne=
d long *addrs, int num)
> >  	mutex_lock(&fprobe_mutex);
> > =20
> >  	hlist_array =3D fp->hlist_array;
> > -	ret =3D fprobe_graph_add_ips(addrs, num);
> > +	if (fp->exit_handler)
> > +		ret =3D fprobe_graph_add_ips(addrs, num);
> > +	else
> > +		ret =3D fprobe_ftrace_add_ips(addrs, num);
> > +
> >  	if (!ret) {
> >  		add_fprobe_hash(fp);
> >  		for (i =3D 0; i < hlist_array->size; i++) {
> > @@ -829,7 +908,10 @@ int unregister_fprobe(struct fprobe *fp)
> >  	}
> >  	del_fprobe_hash(fp);
> > =20
> > -	fprobe_graph_remove_ips(addrs, count);
> > +	if (fp->exit_handler)
> > +		fprobe_graph_remove_ips(addrs, count);
> > +	else
> > +		fprobe_ftrace_remove_ips(addrs, count);
> > =20
> >  	kfree_rcu(hlist_array, rcu);
> >  	fp->hlist_array =3D NULL;
>=20
>=20
>=20






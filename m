Return-Path: <bpf+bounces-69498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE7FB9802A
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 03:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01AF19C5217
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F691F8908;
	Wed, 24 Sep 2025 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H3B3cdKv"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822717BA6
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758677615; cv=none; b=Ui/zOwLBaTWSFhJzm5VQi2ctzH2jP7GkWzKIYNppiS78Nis1W2Y2Bz9Psk5oMhC/5bKGa928aVjpaIIKgMUysoupL4NvBCDhQreVlQ2sR/O0/QqmkOy8ewRewlSQg/E8ruqixkUGqLRfMyeQPIPpQTiA0bV7mMwpo9MYLeQ3baY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758677615; c=relaxed/simple;
	bh=Vj3xUyCFHtyTXr7KgSVRrGkymgpDPbT7OvsLsUslAPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJZsi3UO0anlw1zKMof9wJ4GJhjYq6aMzYFPzJF3q1ZG3/+2Bg35pQo7pN2CKqLuPBjdCTF6uUPIHA5AroY6JaJ66cqM6h/9FEwv1GmEqgoHwUrTb8pzensNBCvzb2aNsesbfyAlimbh96m9qZQl9vPpwqj8cIYx86CIAx+pU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H3B3cdKv; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758677602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Egwm0eZDG4seup0iJLZVoT51BkW2Sq+xzqgnbtZpCJk=;
	b=H3B3cdKvhm4NRHyCHo9X3JKpiOa0RkNxDHdyhxyK1YE81ahk/03pQsB/+5/7d+WS78Ckt2
	gSyYWVn2e+/XQ0zU1Rpw0LSLpRRm0QPQAjooG+UXDXPgOfxtystEID+wPDHkkGF+/GyKzh
	+Q2OBOxqfks+HJFDY4q6uEmQRgz1tuk=
From: menglong.dong@linux.dev
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Date: Wed, 24 Sep 2025 09:33:16 +0800
Message-ID: <5014869.GXAFRqVoOG@7940hx>
In-Reply-To: <20250924092314.4b790ff9fbdb7693717669c2@kernel.org>
References:
 <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <20250923092001.1087678-2-dongml2@chinatelecom.cn>
 <20250924092314.4b790ff9fbdb7693717669c2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/24 08:23 Masami Hiramatsu <mhiramat@kernel.org> write:
> Hi Menglong,
>=20
> Please add a cover letter if you make a series of patches.
>=20
> On Tue, 23 Sep 2025 17:20:01 +0800
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
>=20
> Hmm, indeed. If it is used only for entry, it can use ftrace.
>=20
> Also, please merge [1/2] and [2/2]. [1/2] is meaningless (and do
> nothing) without this change. Moreover, it changes the same file.
>=20
> You can split the patch if "that cleanup is meaningful independently"
> or "that changes different subsystem/component (thus you need an Ack
> from another maintainer)".

OK, I see now :)

>=20
> But basically looks good to me. Just have some nits.
>=20
> >=20
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 81 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 1785fba367c9..de4ae075548d 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_=
ent *trace, struct fgraph_ops
> >  				if (node->addr !=3D func)
> >  					continue;
> >  				fp =3D READ_ONCE(node->fp);
> > -				if (fp && !fprobe_disabled(fp))
> > +				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
> >  					fp->nmissed++;
> >  			}
> >  			return 0;
> > @@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_grap=
h_ent *trace, struct fgraph_ops
> >  		if (node->addr !=3D func)
> >  			continue;
> >  		fp =3D READ_ONCE(node->fp);
> > -		if (!fp || fprobe_disabled(fp))
> > +		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
> >  			continue;
> > =20
> >  		data_size =3D fp->entry_data_size;
> > -		if (data_size && fp->exit_handler)
> > +		if (data_size)
> >  			data =3D fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
> >  		else
> >  			data =3D NULL;
> > @@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_=
ent *trace, struct fgraph_ops
> >  			ret =3D __fprobe_handler(func, ret_ip, fp, fregs, data);
> > =20
> >  		/* If entry_handler returns !0, nmissed is not counted but skips exi=
t_handler. */
> > -		if (!ret && fp->exit_handler) {
> > +		if (!ret) {
> >  			int size_words =3D SIZE_IN_LONG(data_size);
> > =20
> >  			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
> > @@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops =3D {
> >  };
> >  static int fprobe_graph_active;
> > =20
>=20
> > +/* ftrace_ops backend (entry-only) */
>                  ^ callback ?

ACK

>=20
> Also, add similar comments on top of fprobe_fgraph_entry.=20
>=20
> /* fgraph_ops callback, this processes fprobes which have exit_handler. */

ACK

>=20
> > +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent=
_ip,
> > +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +{
> > +	struct fprobe_hlist_node *node;
> > +	struct rhlist_head *head, *pos;
> > +	struct fprobe *fp;
> > +
> > +	guard(rcu)();
> > +	head =3D rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
> > +
> > +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > +		if (node->addr !=3D ip)
> > +			break;
> > +		fp =3D READ_ONCE(node->fp);
> > +		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
> > +			continue;
> > +		/* entry-only path: no exit_handler nor per-call data */
> > +		if (fprobe_shared_with_kprobes(fp))
> > +			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
> > +		else
> > +			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
> > +	}
> > +}
> > +NOKPROBE_SYMBOL(fprobe_ftrace_entry);
>=20
> OK.
>=20
> > +
> > +static struct ftrace_ops fprobe_ftrace_ops =3D {
> > +	.func	=3D fprobe_ftrace_entry,
> > +	.flags	=3D FTRACE_OPS_FL_SAVE_REGS,
>=20
> [OT] I just wonder we can have FTRACE_OPS_FL_SAVE_FTRACE_REGS instead.

I'll give it a try.

Thanks!
Menglong Dong

>=20
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
> > @@ -500,9 +564,12 @@ static int fprobe_module_callback(struct notifier_=
block *nb,
> >  	} while (node =3D=3D ERR_PTR(-EAGAIN));
> >  	rhashtable_walk_exit(&iter);
> > =20
> > -	if (alist.index < alist.size && alist.index > 0)
> > +	if (alist.index < alist.size && alist.index > 0) {
>=20
> Oops, here is my bug. Let me fix it.
>=20
> Thank you,
>=20
> >  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> >  				      alist.addrs, alist.index, 1, 0);
> > +		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> > +				      alist.addrs, alist.index, 1, 0);
> > +	}
> >  	mutex_unlock(&fprobe_mutex);
> > =20
> >  	kfree(alist.addrs);
> > @@ -735,7 +802,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigne=
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
> > @@ -831,7 +902,10 @@ int unregister_fprobe(struct fprobe *fp)
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
> > --=20
> > 2.51.0
> >=20
>=20
>=20
> --=20
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
>=20






Return-Path: <bpf+bounces-69384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E621B959AC
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CA918A79A5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC53218CC;
	Tue, 23 Sep 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SIb+llHO"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251231A062
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626235; cv=none; b=k/xLtxm9QYQ8Xk7L+c2nWVeaTb2Jq4ezwOtaK7lZ+G5YrVEbYEZkWMZPXgbk9AH0XW1dW6hQ6mbLLS155a8UuskYnLcUdXgwehhJpp7KvN9meFZC4mQWM4D503wSXy3Y5ZW3wpzxiQ0+oTTD7my04jAISFw8pmD/1rDk86w/Gyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626235; c=relaxed/simple;
	bh=Rv8HtYZsLSsQFGe3aF2S/ijngcyADzjOD4RnPcIr3qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDSDH3RoFY7wZiFvzHGXXccnMcrhwXbEC07qLyq573zjy/2RsY9wsuT93FepJ3Eae1cePjes3Bg06S1gg6ETYjqgKrNIqJkSjiFPILowHEOa6yAQeaNuLRbyHkKZUGVTIIE2SixnBIU1W3Zlm4Se0rAcfmabSg7ovB3051piSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SIb+llHO; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758626220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4MD0fUNpfBKCFaKpq2fjYrurpzu0LXI7HROUZq34jiM=;
	b=SIb+llHOBStNHcvw5G1EgHVw/0IJSOLwv/idzSadh0c6Fx60++9QFYfoCHGUv9NxBysH35
	sc4PCz/7lpza5HyVHII8lQVKLev73JZ5cmUfvGmpG3SUzkeGYiRrlzKV0PcRWvszINQMHb
	z2nLUrPa7yEb4kCGLgDxaDK/El2F6xo=
From: menglong.dong@linux.dev
To: Jiri Olsa <olsajiri@gmail.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Date: Tue, 23 Sep 2025 19:16:55 +0800
Message-ID: <4681686.LvFx2qVVIh@7940hx>
In-Reply-To: <aNKAIsHQZySyrV4o@krava>
References:
 <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <20250923092001.1087678-2-dongml2@chinatelecom.cn> <aNKAIsHQZySyrV4o@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/23 19:10 Jiri Olsa <olsajiri@gmail.com> write:
> On Tue, Sep 23, 2025 at 05:20:01PM +0800, Menglong Dong wrote:
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
> > +/* ftrace_ops backend (entry-only) */
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
>=20
> hi,
> so this is based on yout previous patch, right?
>   fprobe: use rhltable for fprobe_ip_table
>=20
> would be better to mention that..  is there latest version of that somewh=
ere?

Yeah, this is based on that version. That patch is applied
to: https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/l=
og/?h=3Dprobes%2Ffor-next

And I do the testing on that branches.

Thanks!
Menglong Dong

>=20
> thanks,
> jirka
>=20
>=20






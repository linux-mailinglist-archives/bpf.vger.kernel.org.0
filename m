Return-Path: <bpf+bounces-77671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF0CEE0CA
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 10:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774C13005EB8
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE612D781E;
	Fri,  2 Jan 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MoXNPUF5"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBB1F875A
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767345722; cv=none; b=Bjm/zOutf9p03EB7x5nWNL18bo49dm/EsTRHUcV5OI85bxCJ8IGHkaualYT695J4iMK6TQg2zGOHS2I1Qcr55ENE4oTd/vExlVQoy3cU17X5JPD8jKwkAfZPO3aAWxHAImBFDuVW5D+htpZ7Lu4pVSuHGjd694Q31CrhpqZ2NCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767345722; c=relaxed/simple;
	bh=Tlz6EH7SI09A5u0/5P/I1p9cwEAsb7ThbIkxKKmKSzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAJqzGmKs1mauRim5WvkjQzobkYkKoRl4Dqbli3qjupaj9MKIjwD9XAHsL4BubiokHgud/B5rHfcZW9hXmTwgekOQFPpus/0JHgxJMxhZEm9DbMK5v8zQwSFjV6LPZ0p0jJpTAS7aZgQTuNQBCj4YVhbNaEaTK4Vkpm6saKNaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MoXNPUF5; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767345717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2OI3THUT6/W/oS0IEFqe8AXmi/TcvvNI69giCeU85Q=;
	b=MoXNPUF5T8zjeaG3N5fQ2W5vRXW7eL0W6djsBvHcklibKPsHY9Kbd2Z4mIg3kk4loUp5oG
	/j/0kWoj2GY9yyeVm2XfS3WnN3XtKVv1t5GTNd8e4QLlT4a/2xnXLFmN8LH0auChyP1Z0P
	dymQbgji7WgCzQNUhaZWv6R16yyoUvU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, davem@davemloft.net, dsahern@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 01/10] bpf: add fsession support
Date: Fri, 02 Jan 2026 17:21:42 +0800
Message-ID: <2251274.irdbgypaU6@7940hx>
In-Reply-To: <aVZ8LQXPhRqUz5dO@krava>
References:
 <20251224130735.201422-1-dongml2@chinatelecom.cn>
 <20251224130735.201422-2-dongml2@chinatelecom.cn> <aVZ8LQXPhRqUz5dO@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/1 21:52 Jiri Olsa <olsajiri@gmail.com> write:
> On Wed, Dec 24, 2025 at 09:07:26PM +0800, Menglong Dong wrote:
> 
> SNIP

Hi, Jiri. Happy New Year!

> 
> > +struct bpf_fsession_link {
> > +	struct bpf_tracing_link link;
> > +	struct bpf_tramp_link fexit;
> > +};
> > +
> >  struct bpf_raw_tp_link {
> >  	struct bpf_link link;
> >  	struct bpf_raw_event_map *btp;
> > @@ -2114,6 +2120,20 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
> >  
> >  #endif
> >  
> > +static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
> > +{
> > +	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
> > +	int cnt = 0;
> > +
> > +	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
> > +		if (fentries.links[i]->link.prog->expected_attach_type ==
> > +		    BPF_TRACE_FSESSION)
> 
> let's keep it on the single line ?

OK

> 
> > +			cnt++;
> > +	}
> > +
> > +	return cnt;
> > +}
> > +
[......]
> > @@ -3628,7 +3629,21 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
> >  	}
> >  
> > -	link = kzalloc(sizeof(*link), GFP_USER);
> > +	if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
> > +		struct bpf_fsession_link *fslink;
> > +
> > +		fslink = kzalloc(sizeof(*fslink), GFP_USER);
> > +		if (fslink) {
> > +			bpf_link_init(&fslink->fexit.link, BPF_LINK_TYPE_TRACING,
> > +				      &bpf_tracing_link_lops, prog, attach_type);
> 
> I don't think we need the extra exit struct bpf_link, we just need
> hlist_node hook for exit program, so this should perhaps be:
> 
> struct bpf_fsession_link {
> 	struct bpf_tracing_link link;
> 	struct hlist_node tramp_hlist;
> };

I think we can't do it this way according to how we manager
the bpf_link in trampoline, as you can see in
bpf_trampoline_get_progs() and the struct of bpf_tramp_links.

In bpf_trampoline_get_progs(), it will lookup all the bpf_link
in the trampoline. If we simply add the bpf_fsession_link->tramp_hlist,
the struct in the progs_hlist will be inconsistent.

> 
> 
> SNIP
> 
> > @@ -596,6 +598,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> >  {
> >  	enum bpf_tramp_prog_type kind;
> >  	struct bpf_tramp_link *link_exiting;
> > +	struct bpf_fsession_link *fslink;
> > +	struct hlist_head *prog_list;
> >  	int err = 0;
> >  	int cnt = 0, i;
> >  
> > @@ -621,24 +625,44 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> >  					  BPF_MOD_JUMP, NULL,
> >  					  link->link.prog->bpf_func);
> >  	}
> > +	if (kind == BPF_TRAMP_FSESSION) {
> > +		prog_list = &tr->progs_hlist[BPF_TRAMP_FENTRY];
> > +		cnt++;
> > +	} else {
> > +		prog_list = &tr->progs_hlist[kind];
> > +	}
> >  	if (cnt >= BPF_MAX_TRAMP_LINKS)
> >  		return -E2BIG;
> >  	if (!hlist_unhashed(&link->tramp_hlist))
> >  		/* prog already linked */
> >  		return -EBUSY;
> > -	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist) {
> > +	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
> >  		if (link_exiting->link.prog != link->link.prog)
> >  			continue;
> >  		/* prog already linked */
> >  		return -EBUSY;
> >  	}
> >  
> > -	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
> > -	tr->progs_cnt[kind]++;
> > +	hlist_add_head(&link->tramp_hlist, prog_list);
> > +	if (kind == BPF_TRAMP_FSESSION) {
> > +		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
> > +		fslink = container_of(link, struct bpf_fsession_link, link.link);
> > +		hlist_add_head(&fslink->fexit.tramp_hlist,
> > +			       &tr->progs_hlist[BPF_TRAMP_FEXIT]);
> > +		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
> > +	} else {
> > +		tr->progs_cnt[kind]++;
> > +	}
> >  	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> >  	if (err) {
> >  		hlist_del_init(&link->tramp_hlist);
> > -		tr->progs_cnt[kind]--;
> > +		if (kind == BPF_TRAMP_FSESSION) {
> > +			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
> > +			hlist_del_init(&fslink->fexit.tramp_hlist);
> > +			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
> > +		} else {
> > +			tr->progs_cnt[kind]--;
> > +		}
> >  	}
> >  	return err;
> 
> this seems confusing, how about we just add abolish bpf_fsession_link

It was more confusing in V1. I adopted Andrii's suggestion in
this version to make the logic here more clear. But it seems
still confusing :/

Maybe we need more document here to help the understanding.

> and add extra hlist_node hook to struct bpf_tramp_link .. we will waste
> 16 bytes for other cases, but the code seems less confusing to me
> 
> untested, so I might overlooked something..
> 
> jirka
> 
> 
> 
> ---
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4e7d72dfbcd4..7479664844ea 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1309,6 +1309,7 @@ enum bpf_tramp_prog_type {
>  	BPF_TRAMP_MODIFY_RETURN,
>  	BPF_TRAMP_MAX,
>  	BPF_TRAMP_REPLACE, /* more than MAX */
> +	BPF_TRAMP_FSESSION,
>  };
>  
>  struct bpf_tramp_image {
> @@ -1861,6 +1862,7 @@ struct bpf_link_ops {
>  struct bpf_tramp_link {
>  	struct bpf_link link;
>  	struct hlist_node tramp_hlist;
> +	struct hlist_node extra_hlist;
>  	u64 cookie;
>  };

In this way, it indeed can make the update of the hlist more clear. However,
I think that you missed the reading of the hlist as I mentioned above.
You can't add both the "tramp_hlist" and "extra_hlist" to the same hlist. If
so, how do we iterate the hlist? Do I miss something?

Thanks!
Menglong Dong

>  
[......]
>  void test_tracing_failure(void)
> 
> 
> 






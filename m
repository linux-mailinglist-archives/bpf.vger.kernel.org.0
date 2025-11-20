Return-Path: <bpf+bounces-75180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E3C7612C
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 20:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D52863524A3
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 19:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B93F35CB7B;
	Thu, 20 Nov 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="DQZPLole"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9927FD7D
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666613; cv=none; b=LvB/d4QVHUTN7bL0h8WWOEnUiGLOy9sY8XR0YNcnfSNAXwAQ2aDaT6Lj5KdoySgDtV5vJzcbETg1P3PEn1nQVc2Al1Iu5+9JFVz2ZY3BZ+asQ2uXp1n20UtIn7iTrX0lOfbL+2aRozIkAaxXFPFk1/PlVYxbv59n8UMqrJHvC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666613; c=relaxed/simple;
	bh=KvUtUzkuEicIFrygdRpMr9D+81VJ6KQ3y2b+DMkQhFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV9qfvIcVcZ43nKBQbdpFYvfwmXp6z3xBUdw+P8VipG+uzsIP4KLWwthkB1rO7DaPta+UhCJbTFQwQqZdSfRWNAvVI4Zf02YebjfJbKfUPwhldiWMpMpyqgdLqXi0QQglqWaCEXKhN6/6Ixf/5op25lpp2B4ZuPAsqU8kb0/ODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=DQZPLole; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2960771ec71so2187985ad.0
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 11:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763666611; x=1764271411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8MhwnoCi7MCRE1z5EUEpsstrAvdtSwgJTvQGH9kHI8=;
        b=DQZPLoleoGN5cya/zmamefVBFv/P1p33Kq9hvwdrZ3MeYjrrFMvLzIRjxM+jbvXSuO
         SEVpNFoh3bUkHDO0As9866UEmgIln8iANDDM96UrLCyi83XZImmj1WQKw8Nw4QLC8ZiA
         7ZBqk7LZKv4aqqucn3ZrnmEVQqfNd8X99Envj0vymats5ugYRjcPfb0TPqnOQ+LCrwo7
         r1DrEEhb211chuL0RDcWGvHYVouNbv2yZ80JAEmbG++tCaTB1xZU5QQavn2YC9450sd4
         FlTIe5pdYEFC6LMzE3u5PVXrNxY/OiImlABEAH8lxnzmmW87qx9BwZD/ZODvlbxG56uv
         ZgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763666611; x=1764271411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8MhwnoCi7MCRE1z5EUEpsstrAvdtSwgJTvQGH9kHI8=;
        b=K8j+fqELvhZU3KGKIGA/uK7U4+zF03AOo+/QNJWsYqlxMY4wmEZqptIkrqpAZ5deE0
         cHOsfS6xyeJa7RWOf65MwxirD8JozKnbTvDWUq8DLMj0xKbMuO/D0w2ftt3UFrt1Do3q
         BP8Rz5zAq/hWes7MBe5V5WGIOD5kb/qqAf92ktaiSCaC4B/THfVxxJQNMPky9Jn1dMbI
         iEhBFwyoPlwJTVK9wF9GkqjunglIqzaL8GtFfOLzzcrO4Q5wbstzilVvBbk3F0/IF/Pk
         0FCzY6oip2sCpgizepeEygPs+E3yiB4biIluW5yazI1do1Pvk0hKVcSPBbrNS7jz0nYH
         P5ng==
X-Gm-Message-State: AOJu0YzdbYsky2/iXTHqo4OMJ01GjYipU0hHioOAhBZnbrzdJq5qPdXc
	blhc2nn3MauAUN3SqCqb5+t3pcD43tbyR+l8It11kzNe3Qg/RS80J2CGLQEXk26BTVs=
X-Gm-Gg: ASbGncs4qR3Cq3tDDKmwxdmQV4+c/xjQee3g63x0TxSr1iRgPpDOP2szMyostvVW/cV
	2QrSmyLap6FSoXzEa5xFJoaldGxxYv7TcXhxRHdCLY7O4sL/n7vQJIAeMeZei8WaLswq8+cDyCL
	4+GLaf8DBh2F2dmGeUh3ef62kpAYBvYGleDsJQk9h72napTwlLzurVfgoEC4m2q+tCTtzfXkuRM
	YyfwCjVu5NV95cJ0FcDBYlJnZy8X34u4zJsvpjsJqWP0IYDaX+FmFpQ/UySdaN+KGXGm1jGWuC2
	YLDm+VgpewgacMrotoijLstn61C6CGwrEGuEJvcK4+brNmIgZv1+kPjq3n+WKqTCyVfJeuRmbaP
	MljiAIkE+3RToo+Nampk8XW/vsviVc1aMevP1TU4LUkb8DwPNb6ey+TDCwtPmapUqSTcamFYj
X-Google-Smtp-Source: AGHT+IE/mwElOYfVHTU7C/qAO/GFBjQzTy2DO6bb48PfZHOrE+QUNtwUoIfSS8L1DHZs0v1AkcJJBw==
X-Received: by 2002:a17:903:2acb:b0:266:914a:2e7a with SMTP id d9443c01a7336-29b5b11c5e9mr31171165ad.6.1763666611115;
        Thu, 20 Nov 2025 11:23:31 -0800 (PST)
Received: from t14 ([2001:5a8:47ec:d700:51d0:d4a0:ba29:b604])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107cc2sm34687195ad.16.2025.11.20.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:23:30 -0800 (PST)
Date: Thu, 20 Nov 2025 11:23:27 -0800
From: Jordan Rife <jordan@jrife.io>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, puranjay@kernel.org, iii@linux.ibm.com, 
	mingo@redhat.com, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH bpf-next 3/7] bpf: Enable BPF_LINK_UPDATE for
 fentry/fexit/fmod_ret links
Message-ID: <mpa6euqqnmqmc5ioqnkcji5k4fqtrqqi3tyus74jhhaxouxruj@qnl2ciik2p7e>
References: <20251118005305.27058-4-jordan@jrife.io>
 <47cb75777a482c283798d055c22c0a8c536abe74e9877bb8d01fbccaef840a2e@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47cb75777a482c283798d055c22c0a8c536abe74e9877bb8d01fbccaef840a2e@mail.kernel.org>

On Tue, Nov 18, 2025 at 01:19:33AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 23fcbcd26..7daf40cbd 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1215,6 +1215,8 @@ enum {
> >
> >  struct bpf_tramp_links {
> >  	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> > +	struct bpf_tramp_link *update_link;
> > +	struct bpf_prog *update_prog;
> >  	int nr_links;
> >  };
> 
> [ ... ]
> 
> > @@ -1840,6 +1843,13 @@ struct bpf_tramp_link {
> >  	u64 cookie;
> >  };
> >
> > +static inline struct bpf_prog *
> > +bpf_tramp_links_prog(struct bpf_tramp_links *tl, int i)
> > +{
> > +	return tl->links[i] == tl->update_link ? tl->update_prog :
> > +						 tl->links[i]->link.prog;
> > +}
> 
> This helper is added but the architecture-specific code in
> arch/x86/net/bpf_jit_comp.c, arch/arm64/net/bpf_jit_comp.c, and
> arch/s390/net/bpf_jit_comp.c continues to access tl->links[i]->link.prog
> directly. When __bpf_trampoline_update() passes tlinks with update_link
> and update_prog set, won't arch_prepare_bpf_trampoline() and
> arch_bpf_trampoline_size() use the old program instead of the new one?
> 
> For example, in arch/x86/net/bpf_jit_comp.c around line 2966:
>     struct bpf_prog *p = l->link.prog;
> 
> This should probably use bpf_tramp_links_prog() to get the correct
> program during updates. The same pattern appears in the other arch
> implementations.

This is done in follow up patches in this series.

> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 171440f37..486f945f6 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -232,7 +232,10 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
> >  }
> >
> >  static struct bpf_tramp_links *
> > -bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
> > +bpf_trampoline_get_progs(const struct bpf_trampoline *tr,
> > +			 struct bpf_tramp_link *update_link,
> > +			 struct bpf_prog *update_prog,
> > +			 int *total, bool *ip_arg)
> >  {
> >  	struct bpf_tramp_link *link;
> >  	struct bpf_tramp_links *tlinks;
> > @@ -252,6 +255,11 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
> >  		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
> >  			*ip_arg |= link->link.prog->call_get_func_ip;
> >  			*links++ = link;
> > +			if (link == update_link) {
> > +				*ip_arg |= update_prog->call_get_func_ip;
> > +				tlinks[kind].update_link = update_link;
> > +				tlinks[kind].update_prog = update_prog;
> > +			}
> >  		}
> >  	}
> >  	return tlinks;
> 
> [ ... ]
> 
> > @@ -397,7 +405,10 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
> >  	return ERR_PTR(err);
> >  }
> >
> > -static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
> > +static int __bpf_trampoline_update(struct bpf_trampoline *tr,
> > +				   struct bpf_tramp_link *update_link,
> > +				   struct bpf_prog *update_prog,
> > +				   bool lock_direct_mutex)
> >  {
> >  	struct bpf_tramp_image *im;
> >  	struct bpf_tramp_links *tlinks;
> > @@ -405,7 +416,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
> >  	bool ip_arg = false;
> >  	int err, total, size;
> >
> > -	tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
> > +	if (update_link && !bpf_trampoline_supports_update_prog())
> > +		return -ENOTSUPP;
> > +
> > +	tlinks = bpf_trampoline_get_progs(tr, update_link, update_prog,
> > +					  &total, &ip_arg);
> 
> [ ... ]
> 
> > @@ -503,6 +518,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
> >  	goto out;
> >  }
> >
> > +static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
> > +{
> > +	return __bpf_trampoline_update(tr, NULL, NULL, lock_direct_mutex);
> > +}
> > +
> >  static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
> >  {
> >  	switch (prog->expected_attach_type) {
> > @@ -626,7 +646,7 @@ static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
> >  		return 0;
> >  	}
> >
> > -	return -ENOTSUPP;
> > +	return __bpf_trampoline_update(tr, link, new_prog, true);
> >  }
> 
> [ ... ]
> 
> > @@ -1136,6 +1156,11 @@ arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image
> >  	return -ENOTSUPP;
> >  }
> >
> > +bool __weak bpf_trampoline_supports_update_prog(void)
> > +{
> > +	return false;
> > +}
> 
> The commit message says "For now, only x86, arm64, and s390 are
> implemented" but none of these architectures appear to be updated in
> this patch or in the visible preceding commits (627b0f207, b0184022d).
> Without overriding bpf_trampoline_supports_update_prog() to return true
> and updating the arch code to use bpf_tramp_links_prog(), the feature
> will always return -ENOTSUPP on all architectures. Was this patch meant
> to include the arch-specific implementations, or are they in a separate
> series?

The architecture-specific implementations for x86, arm64, and s390 are
in follow up patches in this series.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19450205468



Return-Path: <bpf+bounces-68912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204EB88121
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 08:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3F47B6D75
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 06:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56BC277C95;
	Fri, 19 Sep 2025 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOFEOp7g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF525A33A
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265160; cv=none; b=MP/PPPkErFoBH3GP+E02KVctPVRgjnJQgMjptWQUwjsEWLTLkH5pbZMyJZC8TeP7FTsf2c9N0c/EapakkXnzLouk5Ooxcg8yU9sMj2p+W+ANZud35GKUn66KMLwLD+NpxjmQc41KGeXFVFmfFvVlmCCAgWY/t5TaZLP3etmf/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265160; c=relaxed/simple;
	bh=wnxEozwp9Bdep39+GjvGOAZnBoHTXYEdsD/ceiqfLXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6FYeYMScSiU8Vviec5yLrcA+hxsVA92zLBKLKCGZIhdoBSJwyf2nUjKvI0uqtD+w+rcu7sQ3YYBKz3gozrXXdT0coigF3o8vnZXhT78XqHc8negDAdcUFarqW7CAgV0szaG9I9oIHjzUVKfUqoe9EXRKrDWpqbGanwYHIGcqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOFEOp7g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so16657705e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758265157; x=1758869957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2xeMqnFot671S/pDE72VnBUeGHxy+CYGfl6qJaAdas=;
        b=JOFEOp7gt2uy6brD2RiArH7lx8UUZlfryV39y07Doh0qd44a2wesjaJSc1b5DWPpX4
         iJ9EAWRZgt/VmsLHhKuhQEd7otnNdnnP/+2AjIA7hf6ly5QA3SfSO0TYJ5nSgGVpRsB/
         Hxy8HsG+aVu9j1zESzQ5woFXO9P9h/Azlqo0bROjYebgXp83xMibFBuI4q3rF+yJJWfm
         IaEI9gIA94z70qWQa6wfeH0iSARx16MLYboUfDo16nvgXDEFeKzkiyi3cjF9zFK8qBZb
         5rIw71fYYvXg5/nxwxGXJm8EWpqrl5L5reZGhB8g+FdQrxIxn2rn1SfJcKU4d/y9P1bL
         ceRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265157; x=1758869957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2xeMqnFot671S/pDE72VnBUeGHxy+CYGfl6qJaAdas=;
        b=mrR8htZGz4EKwlzwgPefX/fbw+/6QNUTvxirh3ZyDK398jnoNkfh064w9go+KADCFr
         UozQkiwyiwFd+qQMrqrQLdZvshKX21ZwHtc4rvjcJ+BWXZykeAQ6lgRy8zdbkYswBMH/
         5eiCtwE2E5L4IetuuoPv6f35xfphQszx4+9nDhLkS85hT6LJLRL0DMAQW3r6uejXwjPF
         3SMYqWYaMy/obiZ/vdorc5MDZFdxpQvRZWuUW9reGNEmB35mNNUKQBvUpDBIb6eCpyDR
         hkHeaJrzZ6Ak5TJWuUBzJ5JYFQoRkkxnmxr1Zwc0imj34jMboqC9KBdK9PQEOmQ6j6Ig
         C4fw==
X-Gm-Message-State: AOJu0YxmP9pq7yoyyyM0qeqb+zfaNcpxWNwLYEAvwCN35LotqlYmTSwE
	l7jUEJLh570AMNA4zzVVr01VN8w+lK9EBM5k8WB1zbJaloGT9PJAmYWw
X-Gm-Gg: ASbGncuUj1zSc22cJ1zR5aYZUpW02r312b3Mqv2C4rayWsDTc50YeVOXg9/LDYm1/YR
	MbyO8rwOKfhcQO04qD7fQP4trAdhtXG0z4/4N57IwT0yum+V7cU5WSvN7QeNYvC1bK4/4nNUDBw
	tNPwpQy5USaFzRCvGTQueFlw+Z4oxq7hCYQavpJRZK/ELRJ8PFNfad0lm3+Vu9oFrI25ZRmJW2a
	pkSHJr71UxtGh8z7ySkpCtg3Tt5Asx2iNSviFZFffouGG3mNNWk/DhCskEZ0I4SRIQSa3aFFEP9
	6riE97Jt6oRN52yaOSGMVOY7lHzpa11aUm9zP0GEBMAKQ7+yw6ejEAAkmrFYOhjzzS/IqtwdagG
	M0M3ZmU2cnzCG8o2b/kuau2gtWCwVMq96
X-Google-Smtp-Source: AGHT+IFeOyrhaQsM68kUMkBHtoUSbKNiK3ijMPiMdG4hpNFynfd3mFSDsf8pyqgyGH6AfJRNnbOlYw==
X-Received: by 2002:a05:600c:4743:b0:45b:7d24:beac with SMTP id 5b1f17b1804b1-467e6f36818mr17413215e9.10.1758265156752;
        Thu, 18 Sep 2025 23:59:16 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-460942b6c3csm65928605e9.1.2025.09.18.23.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 23:59:16 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:05:28 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with
 constants blinding
Message-ID: <aM0AuFAnqGJgI0Kf@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-6-a.s.protopopov@gmail.com>
 <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>

On 25/09/18 11:35PM, Eduard Zingerman wrote:
> On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a7ad4fe756da..5c1e4e37d1f8 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >  	struct bpf_insn *insn;
> >  	void *old_bpf_func;
> >  	int err, num_exentries;
> > +	int old_len, subprog_start_adjustment = 0;
> >  
> >  	if (env->subprog_cnt <= 1)
> >  		return 0;
> > @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >  		func[i]->aux->func_idx = i;
> >  		/* Below members will be freed only at prog->aux */
> >  		func[i]->aux->btf = prog->aux->btf;
> > -		func[i]->aux->subprog_start = subprog_start;
> > +		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
> >  		func[i]->aux->func_info = prog->aux->func_info;
> >  		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
> >  		func[i]->aux->poke_tab = prog->aux->poke_tab;
> > @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >  		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
> >  		if (!i)
> >  			func[i]->aux->exception_boundary = env->seen_exception;
> > +
> > +		/*
> > +		 * To properly pass the absolute subprog start to jit
> > +		 * all instruction adjustments should be accumulated
> > +		 */
> > +		old_len = func[i]->len;
> >  		func[i] = bpf_int_jit_compile(func[i]);
> > +		subprog_start_adjustment += func[i]->len - old_len;
> > +
> >  		if (!func[i]->jited) {
> >  			err = -ENOTSUPP;
> >  			goto out_free;
> 
> This change makes sense, however, would it be possible to move
> bpf_jit_blind_constants() out from jit to verifier.c:do_check,
> somewhere after do_misc_fixups?
> Looking at the source code, bpf_jit_blind_constants() is the first
> thing any bpf_int_jit_compile() does.
> Another alternative is to add adjust_subprog_starts() call to this
> function. Wdyt?

Yes, it makes total sense. Blinding was added to x86 jit initially and then
every other jit copy-pasted it.  I was considering to move blinding up some
time back (see https://lore.kernel.org/bpf/20250318143318.656785-1-aspsk@isovalent.com/),
but then I've decided to avoid this, as this requires to patch every JIT, and I
am not sure what is the way to test such a change (any hints?)


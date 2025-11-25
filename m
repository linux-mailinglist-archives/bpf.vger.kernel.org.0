Return-Path: <bpf+bounces-75488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 789DEC86810
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C39DA4E31EC
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302832BF21;
	Tue, 25 Nov 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="c0Y87SKi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21D32B9A6
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094287; cv=none; b=gJBEgz+yK8YT/1FZN0yuV6MQ6AsXekfLSBCpu3SuiC4nxgVSJPhdgeLjhle77ZtG8qxp3EKi6NB4k/WBuw1k/ZTAaY3d9eIzm3hzAyNU9jZWYBGiUBOTlx+vJ2BXqP4TsOKEQBURXjl1TXv4oSGNe6FLjNm+9e7L9eUia5lmGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094287; c=relaxed/simple;
	bh=U2rSoMWdIHahvPRPHVndSBa1Y9sUxsWxAxpVFF2VHB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP6NjwnAbhGh2QIelf74b37gc84ZRN8iwTfEHKl1Gv/TR/30E0WcDz/8XDtumMzhbGlRvLV1JIaKa0VUy4DIC7gCGUzU7lJxIrZGLdovit1rxYR2jbbLxv4UIfP5qaSbHFhTLIxN0i3aa0V5iwVuOLxRIYJTSlCPrSCP7og9qlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=c0Y87SKi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29800ac4ef3so11658935ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1764094285; x=1764699085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+AG7wRpqHMNfnJeCQpOQEh9m5Efqdn4nU5nA0/8ob0=;
        b=c0Y87SKizU1wwSZEHH1Uzp2nfx+DaszmRC2obXJd201VNGYVnwpIwqcrVFnfEROJ1m
         2vuLPETXNInWS1vnVlos8gQBhKzrde2cEOEgzjFNWtinIohsaUjrcs3jliwkLzjF/Mz/
         Uf+dLB2Bo7if0pC5ET69vmnImGXjX/SVfoBV8GhzN5oLa2/+1fyy7qR5uTOv8WVl/NiP
         nXCaWZZtB/KsUfmITrFYHqBPWIXgCzjFxtbzz7V4PloiERsWnxrpeq234pNqElaUIAc+
         8DyYv1FnIEyu25kfx5MVZ9efOazjOo/zW+BNS4KQBtr62va+7CSsdg94NmI70I6yJ/JK
         gHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094285; x=1764699085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+AG7wRpqHMNfnJeCQpOQEh9m5Efqdn4nU5nA0/8ob0=;
        b=EXU1zO+/wBU0HaRtnx+qf3OSTV47LCfxt2K1VDNRHdXINxUFK/ShSAeXfSySsiPIxo
         tNs21hzuyNZ/ZI2Ec9p3QYUkUXMzl+5xt2mwxaXEmyRPEI93zohIBy3AFVdh6strqn9q
         yRZ+qmm7bHd6ksi04WgvZvGYas8W0t7k1jATcki2EaabKp2170/n2OKsvCQeXF5aZYDy
         mGFl1RN7ZDXGXsnFsVp7w/GT7ddUQ10q1AkOamplBGaZYKpUtiYw9enmhxfIWdS7fQNV
         arwFSEEWdIZna+dgRmwNoEwpYbKQTA/VjC/jE7eLu7nirXoe4cWB9mgPwtt52iyqNaCY
         5HaQ==
X-Gm-Message-State: AOJu0YxrUtjEGvEAFx/Nkx+kvwxboBpz79myC/v8NxeNuy7k2Vvay4fG
	bg28lmVZeLEncfjmYdNJf7xGmEQittXN8gBw1s1S0PoRUNYQyAJWmwWwFS/xAJdI0aE=
X-Gm-Gg: ASbGncu4A6JwKyLv/Pv79FmNbwi93A31i+HMi2yiK2kwD3l2Axj42yYOyxXgtRO41SI
	Jd+SHS2EmKCpH2sfKzxsTNCvKaGmYamKphsXzJxe7UNpFYPimCm99C3u1WCFObrGNqXhtng7hpQ
	0rpKChgmpNGiWtNi2AmHcgnUqdp604VJ7aORv2FSzYrc6iwW839hhYOSMC/PK36bKhJRoGXg33Z
	EDFvuGXMbG7tz+YadcY9Q3dfAgclwhcBiCoMuAxVHqcBQ9KsGZqIDG7I3PSHdPwTJRZUHQGrekW
	gi8yHwtGIoovCpIAyBuglixyKuxEFhNY8/H9MbNjH5EmUQMrSw9Bu/xSuKg4i56IJ69IYA2HjtK
	5BRh0mJ9Qkh8JbMpiNiINbCRoEA7hZabEt9ha2XNayl2LrVW+1ytV9J/OSRMNKmz/L7pThHty
X-Google-Smtp-Source: AGHT+IEBGikt6OJ5HWjVqcKpTHFX0gDBgZQ5MqEUP1FjP7tMlbvmRvYkAvH4AF2C4YKp+tr7YiXW9w==
X-Received: by 2002:a17:902:ef08:b0:266:914a:2e7a with SMTP id d9443c01a7336-29b70255276mr91488805ad.6.1764094285502;
        Tue, 25 Nov 2025 10:11:25 -0800 (PST)
Received: from t14 ([2001:5a8:47ec:d700:7dee:b1a1:fd3f:6b76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2bf60csm173038775ad.101.2025.11.25.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:11:25 -0800 (PST)
Date: Tue, 25 Nov 2025 10:11:23 -0800
From: Jordan Rife <jordan@jrife.io>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH bpf-next 1/7] bpf: Set up update_prog scaffolding for
 bpf_tracing_link_lops
Message-ID: <mlzsxvgexxalfqxgszivdrg2vuiadtxfydg4p4bvfqpj2wqjep@v5tkqwnlfohy>
References: <20251118005305.27058-1-jordan@jrife.io>
 <20251118005305.27058-2-jordan@jrife.io>
 <aSCUrtsBrfS2iTkB@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSCUrtsBrfS2iTkB@krava>

On Fri, Nov 21, 2025 at 05:34:54PM +0100, Jiri Olsa wrote:
> On Mon, Nov 17, 2025 at 04:52:53PM -0800, Jordan Rife wrote:
> 
> SNIP
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index f62d61b6730a..b0da7c428a65 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -63,6 +63,8 @@ static DEFINE_IDR(map_idr);
> >  static DEFINE_SPINLOCK(map_idr_lock);
> >  static DEFINE_IDR(link_idr);
> >  static DEFINE_SPINLOCK(link_idr_lock);
> > +/* Synchronizes access to prog between link update operations. */
> > +static DEFINE_MUTEX(trace_link_mutex);
> >  
> >  int sysctl_unprivileged_bpf_disabled __read_mostly =
> >  	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
> > @@ -3562,11 +3564,77 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
> >  	return 0;
> >  }
> >  
> > +static int bpf_tracing_link_update_prog(struct bpf_link *link,
> > +					struct bpf_prog *new_prog,
> > +					struct bpf_prog *old_prog)
> > +{
> > +	struct bpf_tracing_link *tr_link =
> > +		container_of(link, struct bpf_tracing_link, link.link);
> > +	struct bpf_attach_target_info tgt_info = {0};
> > +	int err = 0;
> > +	u32 btf_id;
> > +
> > +	mutex_lock(&trace_link_mutex);
> 
> that seems too much, we could add link->mutex

This penalizes all links though. Scanning through some other link types
in the kernel, most that I see that support update_prog have opted for a
global mutex as opposed to a per-link mutex. To me, it seems better to
go with this since contention is low instead of making link structs
bigger?
 
> > +
> > +	if (old_prog && link->prog != old_prog) {
> > +		err = -EPERM;
> > +		goto out;
> > +	}
> > +	old_prog = link->prog;
> > +	if (old_prog->type != new_prog->type ||
> > +	    old_prog->expected_attach_type != new_prog->expected_attach_type) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	mutex_lock(&new_prog->aux->dst_mutex);
> > +
> > +	if (!new_prog->aux->dst_trampoline ||
> > +	    new_prog->aux->dst_trampoline->key != tr_link->trampoline->key) {
> 
> hum, would be easier (and still usefull) to allow just programs for the same function?

This behavior mirrors that of bpf_tracing_prog_attach below. I think
you'd lose some utility if you required dst_trampoline to match
trampoline here. A practical use case I can think of would be that you
might want to reuse the same program for several links or
detach/reattach the same program. In these scenarios, dst_trampoline
would have been cleared previously, so you'd need to do the
compatibility check again.
 
> > +		bpf_trampoline_unpack_key(tr_link->trampoline->key, NULL,
> > +					  &btf_id);
> > +		/* If there is no saved target, or the target associated with
> > +		 * this link is different from the destination specified at
> > +		 * load time, we need to check for compatibility.
> > +		 */
> > +		err = bpf_check_attach_target(NULL, new_prog, tr_link->tgt_prog,
> > +					      btf_id, &tgt_info);
> > +		if (err)
> > +			goto out_unlock;
> > +	}
> > +
> > +	err = bpf_trampoline_update_prog(&tr_link->link, new_prog,
> > +					 tr_link->trampoline);
> > +	if (err)
> > +		goto out_unlock;
> > +
> > +	/* Clear the trampoline, mod, and target prog from new_prog->aux to make
> > +	 * sure the original attach destination is not kept alive after a
> > +	 * program is (re-)attached to another target.
> > +	 */
> > +	if (new_prog->aux->dst_prog)
> > +		bpf_prog_put(new_prog->aux->dst_prog);
> > +	bpf_trampoline_put(new_prog->aux->dst_trampoline);
> 
> would it be possible just to take tr->mutex and unlink/link
> the programs, something like:
> 
>         mutex_lock(&tr->mutex);
> 
> 	__bpf_trampoline_unlink_prog(old_prog)
> 	__bpf_trampoline_link_prog(new_prog)
> 
>         mutex_unlock(&tr->mutex);

This is non-atomic though, so there would be some period between unlink
and link where the link target's trampoline doesn't have the program:

[old_prog]
[] <-
[new_prog]

Maybe it's not such a big deal for pure tracing stuff like fentry/fexit,
but it could create some weird and unexpected effects with freplace
links. Unfortunately, to guarantee atomicity, I think you have to push
the intent to actually update a specific program in a trampoline down a
layer (i.e. bpf_trampoline_update_prog).
  
> I might be missing something but this way we wouldn't need
> the arch chages in the following patches?

Alexei said he doesn't want to support update_prog for fentry/fexit;
dropping that from this series (patches 3-6) would remove arch-specific
stuff.

> jirka
> 
> 
> > +	module_put(new_prog->aux->mod);
> > +
> > +	new_prog->aux->dst_prog = NULL;
> > +	new_prog->aux->dst_trampoline = NULL;
> > +	new_prog->aux->mod = tgt_info.tgt_mod;
> > +	tgt_info.tgt_mod = NULL; /* Make module_put() below do nothing. */
> > +out_unlock:
> > +	mutex_unlock(&new_prog->aux->dst_mutex);
> > +out:
> > +	mutex_unlock(&trace_link_mutex);
> > +	module_put(tgt_info.tgt_mod);
> > +	return err;
> > +}
> > +
> >  static const struct bpf_link_ops bpf_tracing_link_lops = {
> >  	.release = bpf_tracing_link_release,
> >  	.dealloc = bpf_tracing_link_dealloc,
> >  	.show_fdinfo = bpf_tracing_link_show_fdinfo,
> >  	.fill_link_info = bpf_tracing_link_fill_link_info,
> > +	.update_prog = bpf_tracing_link_update_prog,
> >  };
> >  
> 
> SNIP

Thanks for taking a look!

Jordan


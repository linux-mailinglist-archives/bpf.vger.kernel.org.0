Return-Path: <bpf+bounces-75179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFA5C7613B
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 20:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D960E4E4F2F
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37C304BC8;
	Thu, 20 Nov 2025 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="IsZvqSNA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2430214B
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666601; cv=none; b=epzyAMg6atcLZGy2av917Xq6NcMHCBwr+SZvYhbgBSWwVSQyDZgDBRKQhv0RlXf+bjQW5qqRBjSXEnI+YJCNNpY0nPp2sbEqLPYiyFo6LfhAXM+L7omygvATPiyaMXIlx+Vh788u72qyZyBXaRXb0QGYGOaxV8yhMNkAnYtF2zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666601; c=relaxed/simple;
	bh=hPQ1Fe33RuAb47Iab6vNkYNQvZXNkuae4XRditaPdl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwPEG14q4wPomca+09aZb3BL3ClQMyjaGEsjB2Q+evzsJl6X27xOMfoITCRtKC3kuHQMRV9aThmCT3yenx2CIsmcWVprVbNH1vjmhE1bLLPMx+SKUOjfVjWJ305v0azP70YAnE8uWosCMh8aJ7fEguvFPd4rEVeADB9ek0xLLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=IsZvqSNA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-299e43c1adbso1608985ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 11:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763666599; x=1764271399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8QsP0PxfZWQK7EEkk/D6jF94UJEcsiLhTO6sey741I=;
        b=IsZvqSNArPfqukwy1BKknjL/aI1eIugYltjuvyH5GlXS2Ku9K0rpZEjI8n6xQRy5Lg
         S4/H4fuxixnffD7jqjW7bvO0X1okD+oz/+nJvNu4bYkrRfVQ4Clmd/AeD6CCXA2mxVA4
         DyDZkWyARKK5B0fWW7KcRsj5+9FlF9+rPysUZLLowWEgoKrcObThj8H4Uy2C44ZwntvM
         xeAksFXPvlPrfNsd4j9Hau9UM3KucB+YRDjBX0WUtd0v9VWrbjAF9T5ZGnyAFKOEfcOZ
         CkcGvmDQaqqKIgt0e+/cg18DTe6lqqxSG7Gcm8ERie8tpxNkQ7KybOrxXrwVijOP0rSJ
         tjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763666599; x=1764271399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8QsP0PxfZWQK7EEkk/D6jF94UJEcsiLhTO6sey741I=;
        b=H9OdZG2XKpvCtE3u6zD2AI5FXjkNrGBQOt/a1hXkudfscOslXbR7WEDmMKXfZRq5fS
         GKJL3pTyB4oaBJIqL3KuAZXdXffgFzbk4ZZliXU5kZshmo4yIgwU4q5jpCTT9MmStycP
         Emkd6kZBklPW3FbLyIS0DYcEzsgQgpcu25BGY4umVFiiCcV3+lrQaJ9AY/5OZZECMNYN
         ON8mFU4hvfG1BdtMFHc4JXOvmtKA+PKodPg+oaXi4mAAyWlcfkiSa1JBkw3BX3hcZMIB
         7Rv3cU4fZVmd/hKZOYfRC73L+yg2Eft2CnUcPUL2pjU+0356hwzp9/X15oyTUmSICd6U
         5tIw==
X-Gm-Message-State: AOJu0YxPTSB41kwnSjZ4M8JwubLm8xU15Dl22dBa0d4PJ9JH8pNoJ5+c
	jR/7+7e3fWOXZ9P1KB8FG59twe1PrqXIpzpRYLOul3mprZru6oRsYJ6ICARuqm/WtO4=
X-Gm-Gg: ASbGncuK+2y+5vb+cY1fbmYKn2jE4mwnLzmJz5Wh8DJSbbfm+TKyBmZ+SQn2PEOKV/0
	Ln4VJe4WJBw7g9Ufg/yfpkva57f/EeWU6ZgpKtn1LNVNQJ5jMfwIr+X4eVmGtV4P7di5AkLAFK6
	xmz86ugJrQozJoUXzfRiefwEn0sK79bhOT+N0REwELCq+GC8OXI3JFs0ssoKKTlZk1iuTmwAcNW
	4H2+UwsKQcB6zJ2dwoY1k/D8vcmnCDAIsRG1LMvjj6HUAftp2moROzVfTnWnYP503UQfShnO/nU
	2VzadPDEZRDa2lxbMOtabYMsniO15TEka35UypKFBqVBccA8TUWrTBZWlyuoqNMu3B6FBxxN1sq
	xuCDnT3Eb5sqBxx1PA3fDwUtk1TCskaYFvDYfTj4XjuyTQObnDcOzvi3+QjQwWKjAbSiAmEXB
X-Google-Smtp-Source: AGHT+IHTgAAGIpuLMfi3qOYAUFJkNfXklq8UcLL7eoIA/fJXTZdw0H4yCNcTl1RjJj1OExsn5zv8gg==
X-Received: by 2002:a17:902:cf0e:b0:258:a3a1:9aa5 with SMTP id d9443c01a7336-29b5ecb6362mr28916435ad.0.1763666599230;
        Thu, 20 Nov 2025 11:23:19 -0800 (PST)
Received: from t14 ([2001:5a8:47ec:d700:51d0:d4a0:ba29:b604])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm33489305ad.25.2025.11.20.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:23:18 -0800 (PST)
Date: Thu, 20 Nov 2025 11:23:14 -0800
From: Jordan Rife <jordan@jrife.io>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, puranjay@kernel.org, iii@linux.ibm.com, 
	mingo@redhat.com, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH bpf-next 1/7] bpf: Set up update_prog scaffolding for
 bpf_tracing_link_lops
Message-ID: <2wc6cxyfuw77dpd3tobt7w4tpdlon4zysjky4gpomj6w2tyusa@mnem7dwqzmip>
References: <20251118005305.27058-2-jordan@jrife.io>
 <ad3ea8d7ccb10a7972db01b58d2596b425d60718ec09450a1ed6d7839488af51@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3ea8d7ccb10a7972db01b58d2596b425d60718ec09450a1ed6d7839488af51@mail.kernel.org>

On Tue, Nov 18, 2025 at 01:27:45AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 09d5dc541..23fcbcd26 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index a2a441185..14dd8be7b 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 04104397c..d2fd02e10 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -607,6 +607,35 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> >  	return err;
> >  }
> >
> > +static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
> > +					struct bpf_prog *new_prog,
> > +					struct bpf_trampoline *tr)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +int bpf_trampoline_update_prog(struct bpf_tramp_link *link,
> > +			       struct bpf_prog *new_prog,
> > +			       struct bpf_trampoline *tr)
> > +{
> > +	struct bpf_prog *old_prog;
> > +	int err;
> > +
> > +	mutex_lock(&tr->mutex);
> > +	err = __bpf_trampoline_update_prog(link, new_prog, tr);
> > +	if (!err) {
> > +		/* If a program update was successful, switch the program
> > +		 * in the link before releasing tr->mutex; otherwise, another
> > +		 * operation could come along and update the trampoline with
> > +		 * the link still pointing at the old program.
> > +		 */
> > +		old_prog = xchg(&link->link.prog, new_prog);
> > +		bpf_prog_put(old_prog);
> > +	}
> > +	mutex_unlock(&tr->mutex);
> > +	return err;
> > +}
> > +
> 
> Can bpf_prog_put() be called while holding tr->mutex?
> 
> When bpf_prog_put()->__bpf_prog_put() drops the program's refcount to
> zero and we're not in IRQ context (which we aren't when holding a regular
> mutex), it directly calls bpf_prog_put_deferred(). This eventually calls
> bpf_trampoline_put(), which takes trampoline_mutex.

The only code path I see where this is true is where
bpf_prog_put_deferred may eventually lead to this line in
bpf_prog_free_deferred:

	if (aux->dst_trampoline)
		bpf_trampoline_put(aux->dst_trampoline);

In this case though aux->dst_trampoline would have been cleared in
bpf_tracing_link_update_prog or bpf_tracing_prog_attach so this code
path wouldn't run.

> The existing code in bpf_trampoline_link_cgroup_shim() carefully unlocks
> tr->mutex before calling bpf_trampoline_put() (see the comment "have to
> release tr while _not_ holding its mutex"). Additionally,
> bpf_trampoline_put() has WARN_ON_ONCE(mutex_is_locked(&tr->mutex)) to
> catch this pattern.
> 
> Should bpf_prog_put() be moved after mutex_unlock(&tr->mutex)?

I don't see how a deadlock could occur in this scenario, but I could
move it after mutex_unlock() to remove any doubt.
 
> >  static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
> >  					struct bpf_trampoline *tr,
> >  					struct bpf_prog *tgt_prog)
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19450205468



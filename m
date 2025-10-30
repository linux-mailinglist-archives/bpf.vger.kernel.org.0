Return-Path: <bpf+bounces-73065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93EC21CC1
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EF2422138
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0036CDFA;
	Thu, 30 Oct 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY4DSTxB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A133A02B
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849481; cv=none; b=b3ZZRXoKUp3ZsaNJLNxGmbpdI+zzIfpZkA4A1VGSHJ6lXfD3bCMdVo4MsaA0EeuikG1rNTdfE/nxI5pPAIA1+Fu2PA0SwJQNvnyq/67sP/uIyZbrqLHNYa5UCYfXUlYyxQLr5pdXPk6H125An2rBO5DaTR2aWu247zauQ6a3vBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849481; c=relaxed/simple;
	bh=TlrV1DnithshF+h4ADVjqUfqCPrrq1n4qZHi7Mikd8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4xrhcOJNQME8unZjjZSKNr6/joxWMWfCkc7GifFiOQZwAZDf/lyoG+sA68vbc6RYLvnyneXi26vtYsYUN7tVk3SrI1iR5J+my3kk8Su874wjgHrFGiCzNquBMJ7iKD7fEyJadnTVb5BlQEo49r0/JCqJGJ4yOZzSa0R3Hm5oOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY4DSTxB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78118e163e5so2152529b3a.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761849479; x=1762454279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=geHfP5DlVcwtHVtcc7C58k5v0O4j7Yun6i2OcvgG2TI=;
        b=lY4DSTxBv+uT5Gz06ahDl2m57hvaBEOoXvlVDbnBrYRdFUr6ghCK5bmZ/85J0badEk
         KSXdjRTf5r/RQZ+mkTBCBdIMMtD7l9lAysibups6Njd5Zw8tkPMyG7tS7XPKNfXUKpuu
         18vDh7rwe7WoOZl8H4qVTk6MTNAKO9XsppCoR0kgrJkFGP/kB/tEGXiXbOaoDbrsocAP
         3h9AD5pMlG+L8cbE2HaFD8lhJ+AhFUp8vzde5I71vJiEKmjY9Dvhwym6sK8TJ72RLCu+
         lyN3tLkOern5KbYHcrbkFhYpBNwGEsUzOyMvEuP6kib/0dSpjnV9pJBxDDephb7f7kE4
         XkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761849479; x=1762454279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geHfP5DlVcwtHVtcc7C58k5v0O4j7Yun6i2OcvgG2TI=;
        b=kR/bPahKztEfZ7m9I3ueuKEHFjr8O7JCkdKCQwmbRx5ZP8r8nFioJGJqb2dp7kvJoD
         XDTHMHIPgFAuZPCI+maHgkLYidmht+BzDDyl30fnHouMfwpmqWF1eYXj2hdoG4hgvK9X
         2yDOMX8lIj6zkq7lJAWUGjoXfx8BcsQyQygZ5ygd67vpykFbQip/aHPnne7khY8JGJIH
         Jw1orZZrHx8cI++hj1MljlBahUspmdcMCaVWP31wgD0M+NZxDqvZv9oW0OHHg3IgWJsP
         rS6EIUdxGArN8WnkR4Xvj4g0FKqab2taVrLbgfiaJOb3pr5efsCf5KO9gMFUvK2m6k+G
         iQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuibx8ApaDN0EM5aCt/d1OyM+im81J9SjRUbO3lZApbEqFhNZYwCSdyEtxUCcfpE78zUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWx8QxdkyZ7IQ6pXP7/S0jaE8taFe5iVuCS8UFKMHubrNVgtt
	HlAYAfwxJZVG0n0nlQdylrVDpgT+NJM9JaVICY5Em0hC4bVOZoweWRw8
X-Gm-Gg: ASbGncvmlTgqH5s2DoFHVEphI9m+4YDPzctEbk9pnmFxgOdbdssWsOzzuFz43vXbjS8
	uTtgbBVjvCftAUepl+Z32xysoGkfM/z6AQjd3/7wJbOdFQLp0RMO3O+ZArtIl8CaF11533Qwi2r
	Pdca9BfwU8N0w9uX3jC6kMqtzqz5/a3yAMc6kL670GLtklvpzWDeV4KfyxKOrAnE5IE7qYdeaS6
	pfrR0LUF7Pe1Q3w1HU0RTmCFh22mbiGSqvr7hFG8QkXaspqynO7SNDr7k9oCQtQuEJyjSNRh/vt
	8HH1Akjf+mz6rTLe2NZ7f7Vna6RYhpLshlxNB8T6VhCBibpGIS+Ffw0aZWOXUPxAR77dkEWip/h
	rhx+KLjDg22aksubdz515g5jvBP+xxz3mdzXk+5kwdo7U7cXhV68LFO1iJrDgTOPLAfrbtPgzMK
	w8VHhXNV+x
X-Google-Smtp-Source: AGHT+IHmC2/V/ZkMIcPjBdonhp4BifhpepDvNUFzZLcARo9bBPDRE8JHLCJcMWAZ0gF8aGgsFpEfCA==
X-Received: by 2002:a17:902:d4c3:b0:271:fa2d:534c with SMTP id d9443c01a7336-29519b9eed1mr9558365ad.22.1761849478577;
        Thu, 30 Oct 2025 11:37:58 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2950ed75b46sm14657215ad.101.2025.10.30.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:37:58 -0700 (PDT)
Message-ID: <d72a8a0313f2c7c7ce0c1d0bc9b49458b9bd59c7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Thu, 30 Oct 2025 11:37:55 -0700
In-Reply-To: <7b44aae0-b2d1-4398-8721-04c052aa2a77@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
	 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
	 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
	 <7b44aae0-b2d1-4398-8721-04c052aa2a77@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 11:24 -0700, Ihor Solodrai wrote:
> On 10/30/25 11:14 AM, Eduard Zingerman wrote:
> > On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
> > > On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
> > > > On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> > > >=20
> > > > Do we break compatibility with old pahole versions after this
> > > > patch-set? Old paholes won't synthesize the _impl kfuncs, so:
> > > > - binary compatibility between new-kernel/old-pahole + old-bpf
> > > > =C2=A0 will be broken, as there would be no _impl kfuncs;
> > > > - new-kernel/old-pahole + new-bpf won't work either, as kernel will
> > > > be
> > > > =C2=A0 unable to find non-_impl function names for existing kfuncs.
> > > >=20
> > > > [...]
> > >=20
> > > Point being, if we are going to break backwards compatibility the
> > > following things need an update:
> > > - Documentation/process/changes.rst
> > >   minimal pahole version has to be bumped
> > > - scripts/Makefile.btf
> > >   All the different flags and options for different pahole
> > >   versions can be dropped.
> > >=20
> > > ---
> > >=20
> > > On the other hand, I'm not sure this useful but relatively obscure
> > > feature grants such a compatibility break. Some time ago Ihor
> > > advocated for just having two functions in the kernel, so that BTF
> > > will be generated for both. And I think that someone suggested puttin=
g
> > > the fake function to a discard-able section.
> > > This way the whole thing can be done in kernel only.
> > > E.g. it will look like so:
> > >=20
> > >   __bpf_kfunc void btf_foo_impl(struct bpf_prog_aux p__implicit)
> > >   { /* real impl here */ }
> > >=20
> > >   __bpf_kfunc_proto void btf_foo(void) {}
> > >=20
> > > Assuming that __bpf_kfunc_proto hides all the necessary attributes.
> > > Not much boilerplate, and a tad easier to understand where second
> > > prototype comes from, no need to read pahole.
> >=20
> > Scheme discussed off-list for new functions with __implicit args:
> > - kernel source code:
> >=20
> >     __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
> > 	BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)
> >=20
> > - pahole:
> >   - renames foo to foo_impl
> >   - adds bpf-side definition for 'foo' w/o implicit args
> >   vmlinux btf:
> >=20
> >     __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
> >     void foo(void);
>=20
> I believe it's the other way around:
>      void foo_impl(struct bpf_prog_aux p__implicit);
>      __bpf_kfunc void foo(void);
>=20
> foo() is callable from BPF, but foo_impl() is not.
> But we still want foo_impl() in BTF so that the verifier can find the=20
> correct prototype.
>=20
> Andrii, please confirm.

Oops, yes, 'foo' gets __bpf_kfunc.

> > - resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
> >   id lists (no changes needed for this, follows from pahole changes);
> > - verifier.c:add_kfunc_call()
> >   - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
> >   - Replaces the id with id of 'foo_impl'.
> >=20
> > This will break the following scenario:
> > - new kfunc is added with __implicit arg
> > - kernel is built with old pahole
> > - vmlinux.h is generated for such kernel
> > - bpf program is compiled against such vmlinux.h
> > - attempt to run such program on a new kernel compiled with new pahole
> >   will fail.
>=20
> I think you meant "new kernel compiled with old pahole".

No, new kernel compiled with new pahole.
As it will have a different prototype for 'foo' compared to one
encoded in the old program binary 'btf'.

>=20
> >=20
> > Andrei and Alexei deemed this acceptable.


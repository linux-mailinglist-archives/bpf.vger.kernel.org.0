Return-Path: <bpf+bounces-73070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 892BDC22104
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 20:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16DA54F087F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B331352C;
	Thu, 30 Oct 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWf1tMZO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B432ABF7
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853687; cv=none; b=H8FJZ50dit+wIMpaW1sYw1WDW55H3UJ7jhEBDSQInjreVqQFYLz3LDfeIPnCqBLsno4q5ZT4xdlDNXY4zmZylAnqgGKmvpQuYiVsaS45ScJWk6SPcUyWlE6i+qlaNwzevhArnCt66bGSzILxCNSJ7gxtj6pZr/Roy0pGuzGL6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853687; c=relaxed/simple;
	bh=qEQI7ZbIZ4t/ARALZIWiZ8X1Xk3ehM4+qVFDWtuvJxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgvsLkttm3rUykVBvcz8u/ahL48JDGDQf75i23RenB2F+Qj7jDUhvUqQk2JDv1iBspVo4wfiXCv1AYN/jH315svrDNT6nlPfCIIJqmZ+fx9DLhVUIKg8Sa/GM3ieoXPXOkEKLzzItlCHErKuLXqSiG+13uzNtbqqFCb+XJZjdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWf1tMZO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1436620a91.2
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761853684; x=1762458484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pos/ZPV3ALEbGYqazMr9v4NUbg/udXqTwqImgvd1qXQ=;
        b=BWf1tMZOC9sOM14tSBB8ZuK/lOpPAR6c1CVWhh3UtbC7NA1ZXBnv4n9zeDkX7KDXDc
         +B3XgEAdcclpC1+IuLixKQ4XnAXUNNQIer8f/gynxF52l35npKX4I1NkOQzjbccaN2QG
         +W3hFjglRywjLOJuABmRb+AbI4DBxJPLV9F93qn9XlwwMNfTpqh8wPSKNTkvptY5AYks
         Eo86OeMVKr2g47SoF9Ahr/JQfI8dsyW3Gz3MOzYG6zLHyOSdXPCKQu/3euvUIcPKuiKi
         XqKySnTCPtlCX8vj16VnaVebE+HjodKHpusEY92OxdDRLwHaj/xrCBD9+xkcXWmL4rpS
         ATBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761853684; x=1762458484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pos/ZPV3ALEbGYqazMr9v4NUbg/udXqTwqImgvd1qXQ=;
        b=GYL94u+HhjPP1I4xdT6vDCGuSatCQAFFDpQI6yUkeR9Y1nn496bVhxYFBGt6C6sY88
         67qlCoJgmFKiJKu+f2jDkKOMRTKL66lkj7SVONiRJBaAjk/6unWXHD4ZOr7X6P8ij+IL
         WSnXzzIhT8xBWkyITzriUZbO5yIVNcfpv7uHiY9RfBDpghAvafDQXUbIEadZb/14hngX
         e2DGwCQ8v454SWOg/79LgA8GcLm22O5aXATejgOmW8XlwunRbArWKO0JJwHpprlWVXb8
         qw6BRYSj7vkiarRMf1ycBoCSmhYNVONMYXczBllQd37SfE1Ubl8GAZlyOWYN67KvcjoI
         x7wA==
X-Forwarded-Encrypted: i=1; AJvYcCU6/4Du8Mc/HrDdoRMntSSohTIS5rokIj1It3aKHU/CFCgUI1z8vxIXRMv5Z4I/wh8fN3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dt2YYRM3p8m0IJ2mW6MLcbp/Y1r3NT+1oBY3b7U8ReR+Cl4F
	7Rx/fXjeBlytfb2e0IdNAiFeuxkmVx/95wAa0xPu54FEM5mrNwArxzlkMtPVrpAqEbIyCuMvo+R
	BDzeBsou1Wma5yLAeUd7f2xr3BwqEh9I=
X-Gm-Gg: ASbGncuiyTIY1/VUe26fI6r94a/4K9b8MNwoxRgyZS4FFUyIrIUFhFrACd7xqus8KNV
	AtSOawy10h9quAIJkQA1qLpG5Nl/0m+QQqeSUxzW6ifM3oACB3VcroM+lo4lsqsPc+CAQxpt8g5
	eAzDY0J6ynhMSGV7/1pnZz3mbQ3oTaw96a9SPlFsqe1eSEPUb0vL2/yG0DyTo9nXqEfG75PnxtT
	d2yiK0zBjk9KzDmvV5h6u8jPhfJxvA22p/us723p/uT69fENQF3byC/5CHfLI41+l2XAOnAJIoA
	v9D7H3ihUv0=
X-Google-Smtp-Source: AGHT+IGIP+ZW+aCX5xajr2LHJ3JhqbFsUxxVJ2sX01aVoTYlQUXX4g1ncYv0CinbO7xGSjaLkKstrod45I8MsA6m394=
X-Received: by 2002:a17:90a:ec8e:b0:340:299f:e244 with SMTP id
 98e67ed59e1d1-34082fdaa13mr1465811a91.12.1761853684151; Thu, 30 Oct 2025
 12:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
 <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com> <710129ad-ebe6-4a92-a21f-3aa1f762fe74@linux.dev>
In-Reply-To: <710129ad-ebe6-4a92-a21f-3aa1f762fe74@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Oct 2025 12:47:49 -0700
X-Gm-Features: AWmQ_bkeqK2V3zcFHWaKwrQ2-iRcc888CUfDyPW2II74MhAJDWkD4yaqOnjaVQQ
Message-ID: <CAEf4Bza1cXRvw+v1CXmpWBF9ivnk+8-JWOUqRQJ2EE95j3i1Pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:46=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 10/30/25 11:26 AM, Alan Maguire wrote:
> > On 30/10/2025 18:14, Eduard Zingerman wrote:
> >> On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
> >>> On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
> >>>> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> >>>>
> >>>> [...]
> >>
> >> Scheme discussed off-list for new functions with __implicit args:
> >> - kernel source code:
> >>
> >>     __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
> >>      BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)
> >>
> >> - pahole:
> >>   - renames foo to foo_impl
> >>   - adds bpf-side definition for 'foo' w/o implicit args
> >>   vmlinux btf:
> >>
> >>     __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
> >>     void foo(void);
> >>
> >> - resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
> >>   id lists (no changes needed for this, follows from pahole changes);
> >> - verifier.c:add_kfunc_call()
> >>   - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
> >>   - Replaces the id with id of 'foo_impl'.
> >>
> >> This will break the following scenario:
> >> - new kfunc is added with __implicit arg
> >> - kernel is built with old pahole
> >> - vmlinux.h is generated for such kernel
> >> - bpf program is compiled against such vmlinux.h
> >> - attempt to run such program on a new kernel compiled with new pahole
> >>   will fail.
> >>
> >> Andrei and Alexei deemed this acceptable.
> >
> > Okay so bear with me as this is probably a massive over-simplification.
> > It seems like what we want here is a way to establish a relationship
> > between the BTF associated with the _impl function and the kfunc-visibl=
e
> > form (without the implicit arguments), right? Once we have that
> > relationship, it's sort of implicit which are the implicit arguments;
> > they're the ones the _impl variant has and the non-impl variant doesn't
> > have. So to me - and again I'm probably missing a lot - the key thing i=
s
> > to establish that relationship between kfunc and kfunc_impl. Couldn't w=
e
> > leverage the kernel build machinery around resolve_btf_ids to construct
> > these pairwise mappings of BTF ids? That way we keep pahole out of the
> > loop (aside from generating BTF for both variants as usual) and
> > compatibility issues aren't there as much because resolve_btfids travel=
s
> > with the kernel, no changes needed for pahole.
>
> We've had a couple of rounds of back and forth on this.
>
> The reasoning here is that going forward we want to make a kfunc with
> implicit arguments easy to define. That is:
>
>     __bpf_kfunc int bpf_kfunc(int arg, struct bpf_prog_aux *aux__impl) {}

I don't think we even need __impl suffix for argument name with
KF_IMPLICIT_ARGS, right?

>     BTF_ID_FLAGS(func, bpf_kfunc, KF_IMPLICIT_ARGS)
>
> That's it.
>
> In order to keep pahole out of the loop, it's necessary to have both
> interface and implementation declarations in the kernel. Something
> like this:
>
>     __bpf_kfunc_interface int bpf_kfunc(int arg) {}
>     __bpf_kfunc int bpf_kfunc_impl(int arg, struct bpf_prog_aux *aux__imp=
l) {}
>     BTF_ID_FLAGS(func, bpf_kfunc, KF_IMPLICIT_ARGS)
>
> Which shifts most of the burden of resolving KF_IMPLICIT_ARGS to the
> verifier. But then of course both variants will be callable from BPF,
> which is another thing we'd like to avoid.
>
> pahole provides an ability to modify BTF only, and make that
> bpf_kfunc_impl (almost) invisible to the user, which is great.
>
> The downside is that maintaining backwards compatibility between
> kernel, pahole and BPF binaries is difficult.
>

I think we should differentiate backwards compat for all existing
_impl kfuncs and BPF programs that used to work with them, and then,
separately, what happens going forward with newly added non-_impl
kfuncs with KF_IMPLICIT_ARGS and BPF programs that want to make use of
these _impl-less kfuncs.

For existing _impl kfuncs ("legacy" case), backwards compat is 100%
preserved, even if the kernel was built with an old pahole that
doesn't yet know about KF_IMPLICTI_ARGS. There will be BTF for both
_impl and _impl-less func_protos, all that will work. And BPF programs
are explicitly calling _impl kfuncs. So even if pahole didn't do
anything special for KF_IMPLICIT_ARGS, verifier should work fine, it
will find _impl BTF, etc.

For all new _impl-less kfunc definitions and/or BPF programs that
switch to _impl-less calls, yes, we will document and require that
kernel BTF has to be generated with a newer pahole. We can enforce
that in Kconfig, but it's a bit too strict/too soon as it's irrelevant
and unnecessary for the majority of BPF users that don't care about
_impl-less stuff.

Keep in mind, right now we have 4-5 such _impl special functions, but
going forward we will probably have lots. sched-ext is poised to use
that very extensively throughout a lot of its kfuncs, so requiring
these explicit _impl wrappers just to support older pahole with newer
kernels I think doesn't make sense in the grand scheme of things.
Getting the latest pahole released/packaged/used for kernel build for
distros shouldn't be a big deal at all. It's not really like upgrading
the compiler toolchain at all.

>
> >
> > I'm guessing the above is missing something though?
> >
> > Thanks!
> >
> > Alan
>


Return-Path: <bpf+bounces-58129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE9AB59D3
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 18:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CEB7AA557
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52D22BEC23;
	Tue, 13 May 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1uDScfc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF31CA81
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153663; cv=none; b=AwlwgmPvN8eSsPpHCHoTuCvPUDhPrAtMx4yDyUIQKepc6wUBDn6mbu3Y32xr3W0l7vhI6Dv9klKc0Rb9rPsy07I0SX00Dyr3b3F7a04xF91uu1LRu44uujyhSMmVSYKwK3nI10eeaKm8O+ncCD0DImJkdXEaMU6sGDkKDa5GuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153663; c=relaxed/simple;
	bh=0ApVc29GPVX31/FwVTXjrVRGmUPGKw6LsI7Uv9kHa9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ugrk8JncqJs/cgJtJ7lJBuVTadhO64FI1PDhG7T0DJCDJneM4+Lx8ReDmmpmtiicdpzFVy8bU2w6ZceUfF/dc6TCEEcHEQNWX5U2X07cnFiBzUb8IZags/Z6HfUHPlQgdBjD/o/AT2lv/xZ6kEGBlABDh1XQCmv/8lPCZhip3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1uDScfc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30ac24ede15so7553819a91.2
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747153661; x=1747758461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAjWk9228m/huB/VRDgnCE87OJly5VToH8AsaEvBNUo=;
        b=M1uDScfcy7ux/16d/N2/dOX0mILnbVEuCfKKs/14Qoe4CDilWlf/H2nJVnxJXo9QBC
         SRWqOapRUKEAHbtbSJXj1oErYs37HfqYNVsyJ+jz6128dsQC4IA0gHx2z6TMUVQf7dgg
         N66lrA6oX/QPvChjzE0mRhvhiWXFW21n5THOBXP90TX/vRs6xyqP6ilzL7V1EkBFPMa5
         SvLcBMyPa4DCuQv9kO41rccGWwksNb4T1jd58HO6mMhn6pNKdyKAkrCdjJd2t6a7H6GZ
         lapGtY7eYnY7DrkPSJRWYG8jpmzgBb3qqjPj7AJLnkZ31m1QiGbm82f0USvssNvfSACq
         foEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747153661; x=1747758461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAjWk9228m/huB/VRDgnCE87OJly5VToH8AsaEvBNUo=;
        b=MsN3GBo9GAfVPR5zzCGpdBvHwVrxKaURBpR6NaFdAALqPF1lqhnlsr7VhMeVgKchpT
         +FwVV1OGClKZG8O1n3L4Byd5JiotAevFc1ukSFWMWw/x68X3bCfVdX7R4KWcGmmvgp8d
         1RcadySyoaYO2GI97mRJpSqU8hkh2iILP5wrtiTWv3WcByvFciBwa5IWxvgEd/plbwNw
         5Qn90mOXHl5f8FdYflay7UL05/izXQbHiGmCFFnTUngukAY92jk2lkuKkBx6WAuW7iVe
         9Sbi2s7EJAun8XsOGg5XBp2zAPhdmcOquQl1BJgNNVd6PGJ+vPamTrmBAbVHflhrgKpa
         egJw==
X-Gm-Message-State: AOJu0YypjgqHyxKyMHgVGwNUh+K2WmLDMxtA0HDXt68+sUKIYKOETYoN
	TxrvkaQiKnzz0F+KCEMlvJjbkiCULWyZrd81lgsjwiLJCLhKtoP3O9IrPib3/n0vZGtKPD9UwqJ
	8AXsBZ18S49jYHQWNJx7PkCYuM3E=
X-Gm-Gg: ASbGncvSVbFCOm7JT02OVrnGuIy+9dEkfIz+xWoqpDjA/RTz1pOkcMBVI2zgkyFHXNR
	fjIXFtKLHfLmXMHZYrlt3Xvx3Fh9HjorrmymJKPuiDiBiCs6KOhSN+PVCq3gF4UXjlWehEOsliN
	N+tx7yrxMbIOsklNadbdnc8jo5UXhBCAkUVSJ4djuAMgJoeWA9
X-Google-Smtp-Source: AGHT+IFd+aECLdFKRq5qz0lSDCisd8KMe5U0JJpDD+yq7l8efFkq8BL2nn3nxsWKvd53bTl3JtvdfIjiCd6C3NbwxVk=
X-Received: by 2002:a17:90a:d647:b0:30c:540b:9b6 with SMTP id
 98e67ed59e1d1-30e2e419501mr493759a91.0.1747153660916; Tue, 13 May 2025
 09:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210246.3741193-1-memxor@gmail.com> <CAEf4BzYbWBJ_m553ju+azX_UxyWgsBx=nwev9vyy7m2DfeVVhA@mail.gmail.com>
 <CAP01T74d38juv24mL6-vz6VOqQWaAZW3cCJfQCwKZCp9GcoQ-Q@mail.gmail.com>
In-Reply-To: <CAP01T74d38juv24mL6-vz6VOqQWaAZW3cCJfQCwKZCp9GcoQ-Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 May 2025 09:27:28 -0700
X-Gm-Features: AX0GCFtqRJwye6RMPK7OqfioDcFeeI0Jg8RFnlBX75r9LKs9MfcQcIwqHHZvy94
Message-ID: <CAEf4BzbpFncpXPuX5ZeU4rmB+hSOCRkVBYAGn4-zEYV-GXav3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Add __aux tag to pass in prog->aux
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:53=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 12 May 2025 at 17:42, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Mon, May 12, 2025 at 2:02=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Instead of hardcoding the list of kfuncs that need prog->aux passed t=
o
> > > them with a combination of fixup_kfunc_call adjustment + __ign suffix=
,
> > > combine both in __aux suffix, which ignores the argument passed in, a=
nd
> > > fixes it up to the prog->aux. This allows kfuncs to have the prog->au=
x
> > > passed into them without having to touch the verifier.
> >
> > I have this wet dream that one day we'll make sure that all BPF
> > programs have bpf_run_ctx set up for them, across all program types,
> > and we'll just use that for these "BPF environment"-like things like
> > getting currently-running bpf_prog/bpf_prog_aux pointer.
> >
>
> For this particular patch, it's mostly refactoring. But I agree in
> general having bpf_run_ctx everywhere would be useful.
> Currently being able to rely on it in some cases and not in others is
> a bit annoying.

Yep, agreed.

>
> > Do you think it makes sense? One of the concerns for wiring
> > bpf_run_ctx for, say, XDP programs was perceived potential tiny perf
> > regression (but it's just current->bpf_ctx swap, so shouldn't be a big
> > deal at all, IMO) and just generally no immediate use case.
>
> I think the performance concern may be real. I can do some
> benchmarking with xdp-bench, but it's probably not the raw swaps that
> cost too much but potential cache miss on touching current. I am not
> sure how problematic that would be in terms of pps regression for
> small programs, but even if amortized it may end up regressing when
> done unconditionally.

Yep, cache line access is the expensive thing, not the swap itself, of
course. My hope is that current is frequently accessed enough and we
might get lucky with that cache line already being present. Or if XDP
calls are frequent enough, we'll just amortize the cost across
multiple packets, as you mentioned.

But yes, maybe a bit of benchmarking would give us a bit better idea, thank=
s!

>
> XDP is sort of an edge case though. I am not sure the concern on
> ns-scale effects holds for any other program type.

Sure, XDP is an extreme case, but if bpf_run_ctx is everywhere *but*
XDP, that still makes it a non-universal mechanism, and we'll have to
always remember that some run_ctx-related functionality doesn't work
on XDP. Maybe that's fine, I don't know, but it certainly would be
better to not have these exceptions.

>
> > So maybe
> > this bpf_prog_aux access is a good enough reason now, WDYT?
> >
> > >
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h |  1 +
> > >  kernel/bpf/helpers.c         |  4 ++--
> > >  kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
> > >  3 files changed, 30 insertions(+), 8 deletions(-)
> > >
> >
> > [...]


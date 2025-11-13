Return-Path: <bpf+bounces-74444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B2FC5A84F
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 00:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1F034EC815
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE42B325714;
	Thu, 13 Nov 2025 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wng6NT5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05231B4F09
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075802; cv=none; b=oN6qHUH8cl+CScX2nnmR8sAjtVfiIR5OU0B9AXCILUcAmKQ3d+dfYf3VkkJkSPhPCF76X0K8w38xMNUYm7xO+EPEg1dvEcwyv2WeeJErJGEia7juWiOkl7SXV4ajDzfMWf4kAwvPz8AAkb/yTXjmK3lfhhBIoHNjXiveyPblShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075802; c=relaxed/simple;
	bh=McCmxYZfWLDfhgEnrggYQ/xdUrzjC/fxfD6L8TrR9Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkNv4D1XluMAb88K5kKXNLz0mRsusV/Ls2XFjncqOpsNi8OVLKQoB82cB7qp4pW6AY9Wyw10ru/YeNeSUHXbTCHokFyWem9B8Bn9X3/Whdsj1RdVyEsXvfPQ+E5XiUReT7Bl7s3dC0Eliph2wWLc0Ly+amtJlG+Epl/0yXmfabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wng6NT5E; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso1179104137.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 15:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763075799; x=1763680599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqQPQK6CgRzkR9RuFhiK4Qtsp82rp73Cii/1+Cq+QKU=;
        b=Wng6NT5E/sLaBwbysyQUdkt07uMap+XMqAWzdGmVRmzsZnf/f9clmBBem3iwbxOOVh
         DpW/lZv7bUd0qNyWHDDvT+8OBEPkgqMYFH0NcqAhE4lLhcV0qQOhRRh359Ow+Sg8XY9H
         ydILuk25SR58IIJ3pv1Rm9fqbyWXiMSP4pM0nu1G4eseCLGEXlz4FjsSmu99+UPNmZN+
         OJZkOVx9rcquHMMPlf5W4WpPdoGVwJ34ACIYmZQeRS3FymBI0fBUKd06xRg8Y63fH+fQ
         PDJrZBQaG1M5sdHaJXTVzSU6LRrmXOWugYU/oOHSF7eZffXLHvcD8r32QOWNI7k/kD3/
         8srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763075799; x=1763680599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqQPQK6CgRzkR9RuFhiK4Qtsp82rp73Cii/1+Cq+QKU=;
        b=JvQ7DX+QnXPkFHhu4ZFg7OrVqSPA6I2yirKO5a9OOaoF6HS8+RpWMufZ4bn+wnHKSN
         5fETK0ONGPu232PCIaxagnV9qAXjL20LOjDLbdRHgLm6HEC+kZR1f1EICc5wHm6ve9Ud
         VC89YVQZaZRrRolINAfrl/2zK+thKDS4WvIqGqELSQtTLSQvcpv+U5dj02yBMy/SFvQF
         P3QK3JJ+7IaS7AVeYrI6CFjmLUaV9D9cmflTm8xnhkRAaOD+lH3SlCNyYj1NYMirkD9D
         RwW1ly3xipHWLQHuv7cr1KBebrZqHbhknrxTN6cvOPqaODhkz/EHxNWfjG4zD/UNdfFV
         Wbww==
X-Forwarded-Encrypted: i=1; AJvYcCUzMqzP5A98J1leZ3saCwe4WZs+Zh5eq7t3zXk9SSGwJBCW5ZFenTKtvl1Lvw6y+mpGIoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyENrBrd0R2yqBNGLlV1DNNiOm4yoa961vsRCtaaaeslivFh70e
	uYSwlim7VIdjKFI44f2FRQJep8LP9r9GwrgY0Mz4z+AqvPKnEoK3C3gWAmbm9zv1wgY9Ymc0q8P
	HZdL9JUml64x3z/8GBFhj6EZj7o1cRaA=
X-Gm-Gg: ASbGncuy2AfQRU1GzngWCm6M1IbBe3z52E4+eJJxdHL6QpqdBqn5lI29+g9Vtdb5rIY
	rfyNDvN0GbdNXPOksIFY+Dr1/rPXXh96xyYLmQZ2Q/z0Rd+bM0HsFX2SPno1YlgMCJZJn+6DtRk
	jAlY9XyoPzv0m6ZEESynXRuuWSig4QHWQ9l5yOpiV7IE7PJoXc3xHATKljxUPcfxlHLDciGVn/9
	vh2XzSynN6XkDGGsCMLEUclyUX78mCYxiux8smInwT7nP/qttytbLK37ym5aUbjXApvCGskcflb
	VVDxOhCv/P0OM//l3O8=
X-Google-Smtp-Source: AGHT+IGrjNBCpZ2faCu+X3mf/nESWB77gdEkVVxScKyRnzLzupttZvCjAw3pcVF7AzL4KM3w5jt9jjoWyqRG9NvHmM0=
X-Received: by 2002:a05:6102:424b:b0:5df:c4ec:661e with SMTP id
 ada2fe7eead31-5dfc5b90352mr675806137.43.1763075799545; Thu, 13 Nov 2025
 15:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107192328.2190680-1-harishankar.vishwanathan@gmail.com> <aRYSlGmmQM1kfF_b@mail.gmail.com>
In-Reply-To: <aRYSlGmmQM1kfF_b@mail.gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Thu, 13 Nov 2025 18:16:28 -0500
X-Gm-Features: AWmQ_bnomsckkm3lQseLl5NCiEq7wMhoLCNHP5F23FY9D88IjS8X5K3c_ZqDEqE
Message-ID: <CAM=Ch07axjOfx4Ar01gdx7CGi5A5+mzqmCu6DNVMEOjk4BJ_iw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] bpf, verifier: Detect empty intersection between
 tnum and ranges
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: ast@kernel.org, m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:17=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
>
> On Fri, Nov 07, 2025 at 02:23:27PM -0500, Harishankar Vishwanathan wrote:
> > This RFC introduces an algorithm called tnum_step that can be used to
> > detect when a tnum and the range have an empty intersection. This can
> > help the verifier avoid walking dead branches that lead to range
> > invariant violations. I am sending this as a patchset to keep the
> > motivation (this email) separate from the details of algorithm
> > (following email).
> >
> > Several fuzzing campaigns have reported programs that trigger "REG
> > INVARIANTS VIOLATION" errors in the verifier [1, 2, 3, 4]. These
> > invariant violations happen when the verifier refines register bounds i=
n
> > a branch that is actually dead. When reg_bounds_sync() attempts to
> > update the tnum and the range in such a dead branch, it can produce
> > inconsistent ranges, for example, a register state with umin > umax or
> > var_off values incompatible with the range bounds.
>
> I think an open question here is whether such patterns of tnum/ranges
> happen in practice, outside of syzkaller. We probably don't want to
> introduce additional logic for something that doesn't help "real"
> programs. I'm happy to check the impact on Cilium for example, but that
> would require a patch to actually start using the new tnum helper.
>

Fair point. But I wanted to highlight the completeness of this approach,
in addition to the soundness. The check:

    if (tmin > umax || tmax < umin || tnum_step(t, umin) > umax)

detects *all* possible cases of "no intersection" betweeen tnums and u64
ranges. If future updates to the regs_refine_cond_op() logic take the
tnum and ranges to any incompatible case, this check will detect them.

[...]
> > * Usage in the verifier and next steps
> >
> > The tnum_step() procedure is self-contained and can be incorporated
> > as-is.
> >
> > Regarding incorporating the range-tnum intersection test, as it
> > stands, if is_branch_taken() cannot determine that a branch is dead,
> > reg_set_min_max()->regs_refine_cond_op() are called to update the
> > register bounds.
> >
> > We can incorporate the range-tnum intersection test after the calls to
> > regs_refine_cond_op() or the calls to reg_bounds_sync(). If there is no
> > intersection between the ranges and the tnum, we are on a dead branch.
>
> Couldn't we incorporate such a test in is_branch_taken() today?

The idea behind suggesting the test in reg_set_min_max() and not
is_branch_taken() was that the empty intersection typically happens
after the call to reg_bounds_sync(), which updates the bounds so that
tnums and ranges become incompatible.

At this point however, the verifier has already forked new
bpf_verifier_states (via push_stack()). Once we detect an impossible
branch using the new check, we will need to clean up the states
corresponding to the impossible branch.

I was hoping for some comments on whether this approach is
feasible.

> >
> > Alternatively, the range-tnum intersection check could be incorporated
> > as part of Eduard's upcoming patchset, which is expected to rework the
> > logic in reg_set_min_max() and is_branch_taken().
> >
> > Looking forward to hearing any feedback and suggestions.
> >
> > [1] https://lore.kernel.org/bpf/aKWytdZ8mRegBE0H@mail.gmail.com/
> > [2] https://lore.kernel.org/bpf/75b3af3d315d60c1c5bfc8e3929ac69bb57d5ce=
a.1752099022.git.paul.chaignon@gmail.com/
> > [3] https://lore.kernel.org/bpf/CACkBjsZen6AA1jXqgmA=3DuoZZJt5bLu+7Hz3n=
x3BrvLAP=3DCqGuA@mail.gmail.com/T/#e6604e4092656b192cf617c98f9a00b16c67aad8=
7
> > [4] https://lore.kernel.org/bpf/aPJZs5h7ihqOb-e6@mail.gmail.com/
> > [5] https://lore.kernel.org/bpf/CAEf4BzY_f=3DiNKC2CVz-myfe_OERN9XWHiuNG=
6vng43-MXUAvSw@mail.gmail.com/
> >
> > Harishankar Vishwanathan (1):
> >   bpf, verifier: Introduce tnum_step to step through tnum's members
> >
> >  include/linux/tnum.h |  3 ++-
> >  kernel/bpf/tnum.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+), 1 deletion(-)
> >
> > --
> > 2.45.2
> >


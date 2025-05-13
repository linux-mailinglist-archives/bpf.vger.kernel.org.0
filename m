Return-Path: <bpf+bounces-58082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67359AB48FD
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98E117B75C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC6194094;
	Tue, 13 May 2025 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyU28srH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4441192D8A
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101195; cv=none; b=O7018wS82A/GEpxZpuQA3gDTTt3UKicjc+/3HNmraOZQt+c5fUrzWwZ48KNP9Mycgf5qv3uKVUKC2jXo+Z9u5yND9kuMO+Gq6SFuTBuqN0apLUDExUOGyuujqXA9RxeWttPJEeQEbtPDRE3He6KaBs/2/xTY7HxbNLekmRoEzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101195; c=relaxed/simple;
	bh=65oQs24oLmbIryml7QkXIZIGdoDQ/jmWe0MDQm/GbVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnhwtYUTuBXcW4Be2qVeg2xMXx96GE6bcrAOoOWdgvNm+ViRcV5yE/uNIfaouN0x1yzWlUm/Ljp+bz3UqgrkzN6++EB4xOTRp7+2Wlu9RXCPrhevxq+QVx4m3lrHndmkp4bWuwi6y4V83JI9JRGU6O+jw3rqfWs2Wfvyk3jI5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyU28srH; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso10520091a12.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747101192; x=1747705992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlpJxYWungbtGm8tVdU5aXYz5bJyU1bfYCNydkqBhuE=;
        b=KyU28srHafEh7EvOush37x41M6vlhKWCwmnkhzuLZjDk44+PN1Xk0wUdWzAmKc3JiE
         ZZ6obFAKzhk29aM/G29rVFFS/6aobYJxqeZd4HBBQVrsJyGv3a1ALVsym/vgs3rBcpEL
         JvqzoaJ1hd+bX1oFAO6ADSkLkdAMf+c/20+vHtiVLsIRH6pyz5MXeI5UUaz5HNGXTSHK
         SCrNVFa0iop8V2dcqyorJWWXDvuKMHC68dvBJtSi1bFuu64bonGJ8qXvWRAMtAD821Lm
         sYUip/kz1yMpQ8BvYk/eCuOww2NQz00T4h3quv3PafQwaOZhmaTj92kFX8EW0+JQA8xE
         7e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747101192; x=1747705992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlpJxYWungbtGm8tVdU5aXYz5bJyU1bfYCNydkqBhuE=;
        b=tjBmD7R1UO4ChQqHgIru0OVykz2H6aphHkmqk5+6aHR6yyFNCu12HW+Vk3BxsM5zTU
         BVxWAp+yTqm9aCBIAeQ1egx7HwTY2FWg8NvpNhoiC42ybKoxEk1JSe97ts1exf8ByWie
         LixNxE2itCGq7g93+Uxo2S7bwVsKqCCOOCN0zysgn63h9xvW51mmH9j6Ae1PYBryNoyX
         3NUVUgTRQ5t7p8XmApVR4N1p8P9Cdhz2llM0irWmTpjjpY8V1YmURuCAxzNJBKwEZuZt
         U3KuaxKepXvwH1FhFDkeNvnv5AAgk1irctIN8M9+ke3n9LE/PU6xxRqN+RovaBb/klGa
         sR/Q==
X-Gm-Message-State: AOJu0YwRCAM/wyW60jZPIU+IFx3V+s4FnfIFDPhXzvHfNxU8qn5cJJjh
	EiYt1ZdhyRRpepzLh2Extyes173jHkyN8xBLf6sArcjsnaBJUf+X3I//vmA8YnK3oTF/JiV1ssy
	24FNmuceHf1QuHOwHWWbAD5MeiVQ=
X-Gm-Gg: ASbGncvCd7BbMOabIEMmDJWSXWdOsdl+wobrwP924wtvFmH1LGhfnMypDpuYMt+UrHO
	k/eVrM9Sn6LINUlul5JBwoVM4/683y4zTkQm65aua2OeEE9z/rL6mDhi6v5jH3VnWPN1gc3dcDL
	ETDBO5dwP7f3D1LhMbD8xW9kgdD1lgc3I=
X-Google-Smtp-Source: AGHT+IHyFieogl3H+wekudEPGHSMLN12ZJK0rO54hwtMf6LtaP6mErUGtHRJnmdqvoKaulKL/iWk8OKBFO1Ic8IYND8=
X-Received: by 2002:a17:907:6ea3:b0:ad2:52fc:d33f with SMTP id
 a640c23a62f3a-ad252fce487mr676437266b.2.1747101191596; Mon, 12 May 2025
 18:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210246.3741193-1-memxor@gmail.com> <CAEf4BzYbWBJ_m553ju+azX_UxyWgsBx=nwev9vyy7m2DfeVVhA@mail.gmail.com>
In-Reply-To: <CAEf4BzYbWBJ_m553ju+azX_UxyWgsBx=nwev9vyy7m2DfeVVhA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 May 2025 21:52:35 -0400
X-Gm-Features: AX0GCFugEDNaYcFOakP01jFN1z9gwpQFADVo_9bH9UoHkQ6Ea4yB4Yz4LMPMVpE
Message-ID: <CAP01T74d38juv24mL6-vz6VOqQWaAZW3cCJfQCwKZCp9GcoQ-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Add __aux tag to pass in prog->aux
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 at 17:42, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Mon, May 12, 2025 at 2:02=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Instead of hardcoding the list of kfuncs that need prog->aux passed to
> > them with a combination of fixup_kfunc_call adjustment + __ign suffix,
> > combine both in __aux suffix, which ignores the argument passed in, and
> > fixes it up to the prog->aux. This allows kfuncs to have the prog->aux
> > passed into them without having to touch the verifier.
>
> I have this wet dream that one day we'll make sure that all BPF
> programs have bpf_run_ctx set up for them, across all program types,
> and we'll just use that for these "BPF environment"-like things like
> getting currently-running bpf_prog/bpf_prog_aux pointer.
>

For this particular patch, it's mostly refactoring. But I agree in
general having bpf_run_ctx everywhere would be useful.
Currently being able to rely on it in some cases and not in others is
a bit annoying.

> Do you think it makes sense? One of the concerns for wiring
> bpf_run_ctx for, say, XDP programs was perceived potential tiny perf
> regression (but it's just current->bpf_ctx swap, so shouldn't be a big
> deal at all, IMO) and just generally no immediate use case.

I think the performance concern may be real. I can do some
benchmarking with xdp-bench, but it's probably not the raw swaps that
cost too much but potential cache miss on touching current. I am not
sure how problematic that would be in terms of pps regression for
small programs, but even if amortized it may end up regressing when
done unconditionally.

XDP is sort of an edge case though. I am not sure the concern on
ns-scale effects holds for any other program type.

> So maybe
> this bpf_prog_aux access is a good enough reason now, WDYT?
>
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  1 +
> >  kernel/bpf/helpers.c         |  4 ++--
> >  kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
> >  3 files changed, 30 insertions(+), 8 deletions(-)
> >
>
> [...]


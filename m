Return-Path: <bpf+bounces-43062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2B9AECB5
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04620281C77
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE471F8196;
	Thu, 24 Oct 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/btwhjw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212B1BD504
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788854; cv=none; b=dfaL2GjruMmXkmhZiJYflPtN3m+a3u1o9ajlMydQxOddiRXWBvsVjMPzf9CLIhlw0vG2ppJcitkC97L0lB0Ns6hfLsb7PEZfnSVtBm2wqqmRri3IshDxhAt/VP6gSRMqF1R7PpIa1NXY6sZF3KTVnJvN5Fs6Nhq5t9GVYjDas14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788854; c=relaxed/simple;
	bh=A8ipLqjy/GiKGpduWRGWB5yVsKVZ79G7vl9TEE+RErs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDoD/OglrITjcIOYs2PACH49zRxz0GVe7S7h8QlT7T2N758rx9vxxPMulA+MqqHyNJ9qx/iFo1fwKbjNjzSqaQ0GGTBiJAqtCLXeYhaBE6paROoWM2EPRn4qcVd86k49pcD1lcTpKSdyjK44bOGvXATPgfFu6L5y+Ub77RN5D+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/btwhjw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71ec12160f6so818049b3a.3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788852; x=1730393652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8ipLqjy/GiKGpduWRGWB5yVsKVZ79G7vl9TEE+RErs=;
        b=C/btwhjwGM5jPupo1pH4tXwPAbezSzE5BezP+LB7sjgB4SrHpUtwIwqupDZPU2m9Pv
         MpolZH3yH5pmvNmzc/2G3OU+UuggUUzwUrcDDqOONCOlznmDyKIBE1Bs8WWbeNtoRJOU
         qsQREeY9wtE3EUa7ZoeNrMHllU6VQEdxVhEMMcb9pj9qESdCCuJKkstL0MjFKkD+VcbE
         bF5sg5KRTyedYV6Xhkd5IZhvndH2rV6qU8ajYDNLZVgwLq3hLM22gjioLpXPFA3dIDt6
         n/pqv3huODWDsOrbZgYws23XCa+7ylS8UbH37C7De08hvBLFe7A0VWl4FgJNLcpT0Qfn
         O9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788852; x=1730393652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8ipLqjy/GiKGpduWRGWB5yVsKVZ79G7vl9TEE+RErs=;
        b=unW8A8WzB3hlV7Uxax0RcR/YcG50oHTeafN09LR28f6eXT27xn/ZO2P0J/hH3nLl3i
         SCrZMyONkbhqKzD//eHYyBFdXM3H5HYrQhElwFTqlcfwkyczMlXyRGbBqCY4jKLayI9U
         j30Mqo2FXemAUZaacmpHTYYyamJ84fw2eYS485G/YxGvdfFo8pVHBjKbhx5cXmphPxVM
         df5biBGy1T2/IQ5ZUQHupZyzXzWJNFmqjVX/BJI/rGD6F5BZzDvOLYKWhOvhks8jqen9
         HPaXxrDfbo1+0V3u+J9YU4qxyV6Sjj9dOXvMvOnjzFnX2CDZUfz1X9+BqMkp0Q4zrCQL
         GZ9g==
X-Gm-Message-State: AOJu0YyRmPVSl3YkFhfyrzwsS//9ixwVz7aFMOfZLX9lrcoeEB2+d2cj
	95K6ZNiyn6ZqwKad57xiPVZkx5FFKIlVNmEk8aiBQySILzaG0Pfz85cexwzGYHnP92vYxm5DupW
	jtLWPwmxk67ORU/9M5EchKUCtbvfV7g==
X-Google-Smtp-Source: AGHT+IFDPNp6x5zwdMhJE+r5sEWG7YsfuA43+3NMKk1DYBzSOeAIo2Hs3wGHvMlfE2f3QbNsJeYetTsXIRbSmaM8Cy4=
X-Received: by 2002:a05:6a00:1394:b0:71e:722b:ae1d with SMTP id
 d2e1a72fcca58-72045fa47f1mr3152442b3a.25.1729788852042; Thu, 24 Oct 2024
 09:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com>
In-Reply-To: <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 09:53:59 -0700
Message-ID: <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
Subject: Re: Questions about the state of some BTF features
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 7:10=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> hey Andrii
>
> On 23/10/2024 01:08, Andrii Nakryiko wrote:
> > Hey Alan,
> >
> > There were a few BTF-related features you've been working on, and I
> > realized recently that I don't remember exactly where we ended up with
> > them and whether there is anything blocking those features. So instead
> > of going on a mailing list archeology trip, I decided to lazily ask
> > you directly :)
> >
> > Basically, at some point we were discussing and reviewing BTF
> > extensions to have a minimal description of BTF types sizes (fixed and
> > per-item length). What happened to it? Did we decide it's not
> > necessary, or is it still in the works?
>
> Yeah, it's still in the works; more on that below..
>
> >
> > Also, distilled BTF stuff. We landed libbpf-side API (and I believe
> > the kernel-side changes went in as well, right?), but I don't think we
> > enabled this functionality for kernel builds, is that right? What's
> > missing to have relocatable BTF inside kernel modules? Pahole changes?
> > Has that landed?
> >
>
> The pahole changes are in, and will be available in the imminent v1.28
> release. Distilled BTF will however only be generated for out-of-tree
> module builds, since it's not needed for kernels where vmlinux + module
> are built at the same time.

It's not, strictly speaking, needed, but it might be a good thing to
do this anyways to avoid unnecessary rebuilding of kernel modules
(always a good thing).

But at the very least we should enable it for bpf_testmod* in BPF
selftests. Can we start with that?

>
> Here's the set of BTF things I think we've discussed and folks have
> talked about wanting. I've tried to order them based upon dependencies,
> but in most cases a different ordering is possible.
>
> 1. Build vmlinux BTF as a module (support CONFIG_DEBUG_INFO_BTF=3Dm). Thi=
s
> one helps the embedded folks as modules can be on a separate partition,
> and a very large vmlinux is a problem in that environment apparently.
> Plus we can do module compression, and I did some measurements and
> vmlinux BTF shrinks from ~7Mb to ~1.5Mb when gzip-compressed. This is
> sort of a dependency for
>
> 2. all global variables in BTF. Stephen Brennan added support to pahole,
> but we haven't switched the feature on yet in Makefile.btf. Needs more
> testing and for some folks the growth in vmlinux BTF (~1.5Mb) may be an
> issue, hence a soft dependency on 1.
>
> 3. BTF header modifications to support kind layout. I've been waiting
> for the need for a new BTF kind to add this, but that's not strictly
> needed. But that brings us on to
>
> 4. Augmenting BTF representations to support site-specific info
> (including function addresses). We talked about this a bit with Yonghong
> at plumbers. Will probably require new kind(s) so 3 should likely be
> done first. May also need some special handling so as not to expose
> function addresses to unprivileged users.
>
> So I think 1 is possibly needed before 2, and I'm working on an RFC for
> 1 which I hope to get sent out next week (been a bit delayed working on
> the pahole release). 3 would need to be done before 4, or ideally any
> other series that introduced new BTF kinds.
>
> So that's the set of things I'm aware of - there may be other needs of
> course - but the order 1-4 was roughly how I was thinking we could
> attack it. 1 and 2 don't require core BTF changes, so are less
> disruptive. We'd got pretty far down the road with an earlier version of
> 3, so if anyone needed it sooner than I get to it, I'd be happy to help
> of course.

Thanks, Alan, for the list.

I think we should prioritize 3 (and 1, of course), as you said, any
BTF extension would be blocked on this (as far as I'm concerned at
least). I wouldn't delay until we actually add a new BTF kind to land
BTF header modifications, that would just delay future work
unnecessarily.

>
> Thanks!
>
> Alan
>


Return-Path: <bpf+bounces-41144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7B4993484
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 19:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C99A1C22D3A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943281DCB26;
	Mon,  7 Oct 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXIT/wKy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93A1E52D;
	Mon,  7 Oct 2024 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321175; cv=none; b=gjyMfsWtczODnG5ccuSOvPWqT6BLTR8Vy77eP8jQfgha2B14nADaO63bk1dlPzJLasQvw5tPVpQB+jGsi9tmqRXPYKpv7D3umeuKGw8h9ZPCkJzLb0bSPh7KL9QgDk0a8p90e57RegWlF5s0nyv0hotll+EqsLsD2TfBSxuoE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321175; c=relaxed/simple;
	bh=Tctq861wcxiFADq15gq6hiz7//eXlhRJD2xQsDs7GqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nsd8fKWY8nFnkyY1T2z5uLU1aRk4p6fWpawALrxoJBFGF5sN/YhxgaWFBwpTLtH1tSHb+wIVk2P1WM2fTQ1uEETZn+gqmMum5aBvzTyuvQkeCYLMOzBq7mh5HtJSpBhEw7xJgKFN+H5eJueFQm24+XHvAzDxvss77pGWYdEcX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXIT/wKy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e199b1d157so3410246a91.2;
        Mon, 07 Oct 2024 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728321173; x=1728925973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49OYZEbbAHqJMrfj14FRcDqF0q43D/92opKQUenn/jU=;
        b=GXIT/wKy7spWnjrvtTBOnV4PajLYDiXL9QMVx+EKe7b/Ivv2AeekwXz4ai8Q/phl7o
         tPeqgM3VDX11WMjUCBajOIlF04PKUPfLzrdmBEMDUV45ktRXrFtdyWWHd9DyBEnkch1X
         9UhHvGk3DNR36R7dydRH+CgNpH6t07IXarlFqEc8o7czDaUMZ07Ncbs02pclUzSqhBM/
         AbEEmvlO4ZSKj3Ag0AqOE27F6O2YVD1iaexeIcfsG40jIad12d4XrTAgwajkkBCbJhym
         dt6jpXOATwuyGmHCKyBvc52kxpXFbmobhiboRd7P+/VgOyuelMI8agbzk/lNWSpaSwdA
         FTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321173; x=1728925973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49OYZEbbAHqJMrfj14FRcDqF0q43D/92opKQUenn/jU=;
        b=pMz2sZJAyJcTR7WHQwC+nsIXFwwqeYxuzIgWC9SILUNItGvzLte2B0Yb65Qv9UEROB
         weaovEcpTBRp57XBObw+XJXrycl6IrJWJSiMwHX2c/ZYZNM2JraXdnZ6F1zuwKdOJode
         Yloljsv+QW14jIvq5UtEe295hxRJ+3p9Ijlk5BuL//R91oC6xZbHE0OvNBjPWqE9R2i/
         GHYpdElT87TggYXdK3bYoJvM2uJt6j23Jq/ta/nFcL2ol/zcLn9Gxn1Klg+x0czzoeTo
         XwKom8GHihOwrWWhLHBpHztxrZdckiUZDYahEQCpFqtWdev28S7oIN/rH2GroDDcUmCQ
         Kijg==
X-Forwarded-Encrypted: i=1; AJvYcCUTIlirzgS39hIX303bdihEiVaj+lticQlnLLtlmpetgmmlQ1EIqB+PMOUhxugaTA27xlc=@vger.kernel.org, AJvYcCUyQ6un3xxzymZaO4Q+EOB8iy1BIQ9q/FMwdWXTPPZDxDWeIoK/DC0pCMAZ+hL7sKnZ3qasFMWBRw==@vger.kernel.org, AJvYcCXChdJiqCl7KEjR5dprHzckzORPVxdGaBa8scQ9WxL0tjbQk2muixzv3AHuBNVtOOqlqRRRs/at9ldAI+opZh6q@vger.kernel.org
X-Gm-Message-State: AOJu0YzSl4ITP3WrxMRWy3hOZkveGKky/HVU7taIW95Q6ejvDQ3X1OTJ
	aoCjtMfiL+ttpsp1KPR7qTPnLmnkf3lLhvhT6x+xa9EVkr7XWkO/mZ7T3oYiK4yhyO2T2XHgc3y
	U39Ywa8BbepqG8QSxKQx6B1YWVBfV334b
X-Google-Smtp-Source: AGHT+IFR+h24xNRgptABlsdunr1DDVeA6Sc5VkqOkFrwRljZISaf4twRdq5INnWh9GMpPFjThhNFQUcG47Y/7hJmW2o=
X-Received: by 2002:a17:90b:3904:b0:2e0:cace:4ccb with SMTP id
 98e67ed59e1d1-2e1e636f773mr15204357a91.26.1728321172936; Mon, 07 Oct 2024
 10:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com> <ZwBXA6VCcyF-0aPb@x1>
In-Reply-To: <ZwBXA6VCcyF-0aPb@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Oct 2024 10:12:40 -0700
Message-ID: <CAEf4Bza3cnyef1VAcGkmP02dBMU_fp=52aS9LknOWhN855-PPQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 0/4] Emit global variables in BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:21=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Oct 04, 2024 at 10:26:24AM -0700, Stephen Brennan wrote:
> > Hi all,
> >
> > This is v4 of the series which adds global variables to pahole's genera=
ted BTF.
> >
> > Since v3:
> >
> > 1. Gathered Alan's Reviewed-by + Tested-by, and Jiri's Acked-by.
> > 2. Consistently start shndx loops at 1, and use size_t.
> > 3. Since patch 1 of v3 was already applied, I dropped it out of this se=
ries.
> >
> > v3: https://lore.kernel.org/dwarves/20241002235253.487251-1-stephen.s.b=
rennan@oracle.com/
> > v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-stephen.s.br=
ennan@oracle.com/
> > v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.b=
rennan@oracle.com/
> >
> > Thanks everyone for your review, tests, and consideration!
>
> Looks ok, I run the existing regression tests:
>
> acme@x1:~/git/pahole$ tests/tests
>   1: Validation of BTF encoding of functions; this may take some time: Ok
>   2: Pretty printing of files using DWARF type information: Ok
>   3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> /home/acme/git/pahole
> acme@x1:~/git/pahole$
>
> And now I'm building a kernel with clang + Thin LTO + Rust enabled in
> the kernel to test other fixes I have merged and doing that with your
> patch series.
>
> Its all in the next branch and will move to master later today or
> tomorrow when I finish the clang+LTO+Rust tests.

pahole-staging testing in libbpf CI started failing recently, can you
please double-check and see if this was caused by these changes? They
seem to be related to encoding BTF for per-CPU global variables, so
might be relevant ([0] for full run logs)

  #33      btf_dump:FAIL
  libbpf: extern (var ksym) 'bpf_prog_active': not found in kernel BTF
  libbpf: failed to load object 'kfunc_call_test_subprog'
  libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
  test_subprog:FAIL:skel unexpected error: -22
  #126/17  kfunc_call/subprog:FAIL
  test_subprog_lskel:FAIL:skel unexpected error: -2
  #126/18  kfunc_call/subprog_lskel:FAIL
  #126     kfunc_call:FAIL
  test_ksyms_module_lskel:FAIL:test_ksyms_module_lskel__open_and_load
unexpected error: -2
  #135/1   ksyms_module/lskel:FAIL
  libbpf: extern (var ksym) 'bpf_testmod_ksym_percpu': not found in kernel =
BTF
  libbpf: failed to load object 'test_ksyms_module'
  libbpf: failed to load BPF skeleton 'test_ksyms_module': -22
  test_ksyms_module_libbpf:FAIL:test_ksyms_module__open unexpected error: -=
22
  #135/2   ksyms_module/libbpf:FAIL


  [0] https://github.com/libbpf/libbpf/actions/runs/11204199648/job/3114229=
7399#step:4:12480

>
> - Arnaldo
>
> > Stephen
> >
> > Stephen Brennan (4):
> >   btf_encoder: stop indexing symbols for VARs
> >   btf_encoder: explicitly check addr/size for u32 overflow
> >   btf_encoder: allow encoding VARs from many sections
> >   pahole: add global_var BTF feature
> >
> >  btf_encoder.c      | 340 +++++++++++++++++++++------------------------
> >  btf_encoder.h      |   1 +
> >  dwarves.h          |   1 +
> >  man-pages/pahole.1 |   7 +-
> >  pahole.c           |   3 +-
> >  5 files changed, 167 insertions(+), 185 deletions(-)
> >
> > --
> > 2.43.5
>


Return-Path: <bpf+bounces-30470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF58CE056
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 06:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92564281C18
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 04:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76513612D;
	Fri, 24 May 2024 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezWtndyk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B91DDC5
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716524358; cv=none; b=CSCJTXVlnVgfiGcTTAWCsmEbnS5zNPIeZCfHeo3WA0DEpE3YoFgr5GAuS766yaziwB0VNDJt2i1SFnmwwv3+k0UL1uQVRvEiCC7c/1+sF/Zf4bbTqQBhHtp/nh4qXcAd/N1RmLsDVN7SESyBVwZvCUU5X92/VyExLoFqdCd9eZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716524358; c=relaxed/simple;
	bh=u0XNwZqLZZZ4WF1YybgQo1JQ39GsY66TqdxqmSviLOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgf0hPYnuT3pfdu7sYknJOVlI1WzF33Vfpg23pFV3jFpuoBOy7GhRFvxTlIVXqfFljq2DdW9fceU/ymHmX8VXP/26u1VVNBar2b2EFIZPAr8j23IYILIbi362WiCsL6+QnAqs7kwbBNF8H4qaCzBOpP67IoCiQ0X7nxHWOASUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezWtndyk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42108856c33so1602645e9.1
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 21:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716524355; x=1717129155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5ZjMxIBqM32EFjNKEjwXVF2c+jPDzyuXTYzZ2ndaGA=;
        b=ezWtndyk1oYq86aFIw3py1BBST8mQyY3NP5glAz1Y94lb1QqhkAVU1Cnuh12drlo0h
         WWW6xcV8ZZvNPFavnkJ3KcNW/GWufXK9pmCmcnZuaH+F7H2p3leMOfldyXpNoRps6lX8
         9siNzwh+ZSq7PWRtPVAkhLcrYO7C6mFzauBejD8WIdA4kKU5i9EwghqBwb6atfwSMdcl
         nEXXsGdqflO46ZcpctsJsAXTp77EI70ePsiLWL1T5XEWBWQSgI2CAXW6ESGWHcqwKJHJ
         5kWXs+bW4KzDnEJafYIlMn1Iw93eZNi7gmau7VZNrNw9ub7quIpFL31oQ/liLTgqgl3D
         xIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716524355; x=1717129155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5ZjMxIBqM32EFjNKEjwXVF2c+jPDzyuXTYzZ2ndaGA=;
        b=pSwm7MFOqmLeIzmVIPEvQpmZ1TviWmaBZCE5/z+sImzAmYkzF9DHGc6sDqBvvZdBeB
         AXCah3HILoqjaj/WDtTRmALAM+8No5aHV350UqmtE8xK31jQg9X1zYQr0NFCCW82+EJD
         MTTdZBLV7P8pqfXFcUrFw+qH75vaD/n2uvD/1wJ2SNZ0GZQ1GkHcAI6vpzqj+jOhvPZT
         vsN3wpoO8NnD2VEwyolsx0/onKLGny8D2s4FjiKHg45CCi9iW3lKcMupPVGNdkCvcKDQ
         jbn754qj7ndsd22WENAhdOog8yzIQiXJej/arrE7o+FhPCz8Lv+gYYspzlWDdAEbC0GB
         dK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9l/3igYl0iVhEs/r3XNAoM1FrfKksrmG0EUeCLD9Qwrtx9tyDaD7ZNDNidmrmGfMFNv/gxUMV0DfZ9p9kgrm68gPY
X-Gm-Message-State: AOJu0YwnzHbaVllg6xbQ5Pq/bmuMm307KQlt/tA0+z6NzuCsKn3jgL1i
	oiVabrR+IQ6l/oS54/XBxi0jufsmcKyTKoto5m8Rlk4Vpg+O+iP3mi7AolDCifzndNlwutSp0kB
	N9aUhrpyzOj4FJodURn3KEQtDCjo=
X-Google-Smtp-Source: AGHT+IEm2mGk3wVB0ttkNXDntP7+tzU9/BvgyuLXJRlG4Lij40BE1RaSglLgskaqMeuM3gxoIq2o6QM32DG5EHHAKss=
X-Received: by 2002:a5d:4142:0:b0:354:b641:ae8a with SMTP id
 ffacd0b85a97d-354f75a0d5cmr3286876f8f.30.1716524354754; Thu, 23 May 2024
 21:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
 <CAEf4BzaJyju+0r=PnaJyv4zYnUbiAfxtXk5oQqPrVGqN4F++fQ@mail.gmail.com> <CAADnVQLj3vHKNJqdrG=WwbRk2A+DCi+2tGyxj7XeSTqzJ1T=pw@mail.gmail.com>
In-Reply-To: <CAADnVQLj3vHKNJqdrG=WwbRk2A+DCi+2tGyxj7XeSTqzJ1T=pw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 May 2024 21:19:03 -0700
Message-ID: <CAADnVQK4PsnNQ6xBwYtkNb_K4TQiDW1=kP3k+WqDRs4hQ49nFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Relax precision marking in open coded iters
 and may_goto loop.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eddy Z <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:09=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 22, 2024 at 10:33=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, May 21, 2024 at 7:47=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Motivation for the patch
> > > ------------------------
> > > Open coded iterators and may_goto is a great mechanism to implement l=
oops,
> > > but counted loops are problematic. For example:
> > >   for (i =3D 0; i < 100 && can_loop; i++)
> > > is verified as a bounded loop, since i < 100 condition forces the ver=
ifier
> > > to mark 'i' as precise and loop states at different iterations are no=
t equivalent.
> > > That removes the benefit of open coded iterators and may_goto.
> > > The workaround is to do:
> > >   int zero =3D 0; /* global or volatile variable */
> > >   for (i =3D zero; i < 100 && can_loop; i++)
> > > to hide from the verifier the value of 'i'.
> > > It's unnatural and so far users didn't learn such odd programming pat=
tern.
> > >
> > > This patch aims to improve the verifier to support
> > >   for (i =3D 0; i < 100000 && can_loop; i++)
> > > as open coded iter loop (when 'i' doesn't need to be precise).
> > >
> > > Algorithm
> > > ---------
> > > First of all:
> > >    if (is_may_goto_insn_at(env, insn_idx)) {
> > > +          update_loop_entry(cur, &sl->state);
> > >            if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> > > -                  update_loop_entry(cur, &sl->state);
> > >
> > > This should be correct, since reaching the same insn should
> > > satisfy "if h1 in path" requirement of update_loop_entry() algorithm.
> > > It's too conservative to update loop_entry only on a state match.
> > >
> > > With that the get_loop_entry() can be used to gate is_branch_taken() =
logic.
> > > When 'if (i < 1000)' is done within open coded iterator or in a loop =
with may_goto
> > > don't invoke is_branch_taken() logic.
> > > When it's skipped don't do reg_bounds_sanity_check(), since it will s=
urely
> > > see range violations.
> > >
> > > Now, consider progs/iters_task_vma.c that has the following logic:
> > >     bpf_for_each(...) {
> > >        if (i > 1000)
> >
> > I'm wondering, maybe we should change rules around handling inequality
> > (>, >=3D, <, <=3D) comparisons for register(s) that have a constant val=
ue
> > (or maybe actually any value).
> >
> > My reasoning is the following. When we have something like this `if (i
> > > 1000)` condition, that means that for fallthrough branch whether i
> > is 0, or 1, or 2, or whatever doesn't really matter, because the code
> > presumably works for any value in [0, 999] range, right? So maybe in
> > addition to marking it precise and keeping i's range estimate the
> > same, we should extend this range according to inequality condition?
> >
> > That is, even if we know on first iteration that i is 0 (!precise),
> > when we simulate this conditional jump instruction, adjust i's range
> > to be [0, 999] (precise) in the fallthrough branch, and [1000,
> > U64_MAX] in the true branch?
> >
> > I.e., make conditional jumps into "range widening" instructions?
> >
> > Have you thought about this approach? Do you think it will work in
> > practice? I'm sure it can't be as simple, but still, worth
> > considering. Curious also to hear Eduard's opinion as well, he's dealt
> > with this a lot in the past.
>
> I looked into doing exactly that [0, 999] and [1000, max],
> then on the next iteration i+=3D1 insn will adjust it to
> [1, 1000], but the next i < 1000 will widen it back to
> [0, 999] and the state equivalence will be happy.
> But my excitement was short lived, since both gcc and llvm
> optimize the loop exit condition to !=3D
> and they do it in the middle end.
> Backends cannot influence this optimization.
> I don't think it's practical to undo it in the backend.
> So most of the loops written as:
> for (i =3D 0; i < 1000; i++)
> are compiled as
> for (i =3D 0; i !=3D 1000; i++)
> for x86, arm, bpf, etc.
>
> so if there is arr[i] inside the loop the verifier
> have to rely on bounded loop logic and check i=3D0, 1, 2, ... 999
> one by one, since nothing else inside the loop
> makes the array index bounded.

So I've decided to implement this idea anyway to see whether
it can be salvaged for some cases.
It turned out that it's not that bad. With extra heuristic
it's almost working. Stay tuned.


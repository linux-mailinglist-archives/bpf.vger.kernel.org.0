Return-Path: <bpf+bounces-36233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB094510E
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFD528802C
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DC11B4C30;
	Thu,  1 Aug 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK9DUUol"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04D14287;
	Thu,  1 Aug 2024 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530971; cv=none; b=DWaFFTlY2PoBtbbC5bRfZJcVI50bOkYA8V0TRsIzFgjBakaJHKxb37JpKJoq873cM7i4EpPZDynzIHeEOuuLMU4RUbDjAa/XFH+orjjnfx4MhT5H4HdirMUJ+nHdDO7Cmn/OHmDGwHkB1kU6cU78HsW8WeCi7Vh8hrND/bcxTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530971; c=relaxed/simple;
	bh=ZoLrijijgwFNxBejfTFFhWhAvCG7Dju+HPeEzW18op8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivJutUBG30tbVSoVdq0PqzKb5tBRTuy1vQSwU/nm1z8cXImtSctBvQgECE5LchtVkNdDz7GgPh1Kq+z+BB50d1wCOC5Eivghw+YcSMqqg7aQRNEDJAcZSnFjC3T1OmrIJRD3raZVHU6l31q683nWP8iYrw5CeZkaZCkauyFyLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK9DUUol; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb57e25387so5523558a91.3;
        Thu, 01 Aug 2024 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722530969; x=1723135769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoLrijijgwFNxBejfTFFhWhAvCG7Dju+HPeEzW18op8=;
        b=nK9DUUolpQlzHvsSRSJs6+s/plMz58gnQ+ubnhpbkr3Ck1u37dpC5K3+EoPyA9nABx
         L1/sTgq18uL7nnW9sGyueqB0/be2pbCFlgPpXyzS3s/CKnMKCKqpPU8x3Zae1bpvdocg
         H3HrkrUAxNyrR6KqPiBWVokOloIaVRY5YPiQn7VUKp/KyF39lHv4bfFxufB+bFe8g3bv
         FxttLWRoGXdUdw6TPyzdhBbiokgUH7SSrsEr/aOkWPj4h8o8dd9WDyNe5BWYofLNz576
         +a/vtfi8n7/5RiiTd8QR8Naw0Onr5uC4aORSyGGCIe2mxMW9PHJ8r5AXvS//cf81Qge7
         4zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722530969; x=1723135769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoLrijijgwFNxBejfTFFhWhAvCG7Dju+HPeEzW18op8=;
        b=Wq09CN2urPCINuIjdhoXYHL1KPU37Mk7qHL5tX84LW2ZFGoDizTcqEA+PYt5cy7/tl
         ITbU5dhJYZWZjOOL04anJz4yb4C4wIbELwIBTkC7P3K1/f7yn6ooOoxB+ulLrl9l0qDx
         BANFdDq4GYV2tRTnIUdijxwSclNWfLnjPjCziDh99JyDbnU8Al6iGBeIod03KxCLcblc
         wA9r3knfblHPlrqqZrRr2aYGwSLFfSWBse4tz1A4od/GT3UyGaYclKEa2uoyekaQAKH6
         1JCraIPfLaHip4ylZtz9Jz3Yuu1YVTZQ9fs06pkgLW/Vwwqyu9DOqii47GSETdln8b8C
         aK2w==
X-Forwarded-Encrypted: i=1; AJvYcCW4vQ1oIqwhW7Ij2UPjhLlZsNMu/TuyccD/HLeyFBoN+NetgL6Ha725vabeGtt8CtibiB1IyOgY2Kc/hiyy/8vWghK578yeu/adreM5r8oJtn04InxvMZXGVi1nFVt7VYkp/CsVOb+OwC6qm9dRwpz2uEmpaSRNUginP19/3SXjLOdm27uc
X-Gm-Message-State: AOJu0YzB8b0xf4E+njcuwzDKbaErH1XGjpgQvC2vtk0CskC/R4FSDfTR
	K8kkndg15Hv2D3xW/0tOz2LJjhNyqapMcaSRluNu6ZeAx22xddig01vXPH2aVJMdh1R/6/FBuTO
	nv70NR6lcyv7PqldVG5BH4aHQUdyEcA==
X-Google-Smtp-Source: AGHT+IGLbkaS8k7aaBPBkCKKRBC3XVr/aP3dM2O1zoIPQJxwY7EtTRyK8hlp6nXSD0YMaOxOIrup0VUr8AlMpdb4psw=
X-Received: by 2002:a17:90b:4a52:b0:2c9:7f3d:6aea with SMTP id
 98e67ed59e1d1-2cff9559addmr931744a91.32.1722530968961; Thu, 01 Aug 2024
 09:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-9-andrii@kernel.org>
 <20240801093505.GP33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240801093505.GP33588@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Aug 2024 09:49:16 -0700
Message-ID: <CAEf4BzZNbJMqxbH1Ge8q1AM_d6XcbG3dxTdkZs5H1eK-ABvVzQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] uprobes: switch to RCU Tasks Trace flavor for better performance
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:35=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Jul 31, 2024 at 02:42:56PM -0700, Andrii Nakryiko wrote:
> > This patch switches uprobes SRCU usage to RCU Tasks Trace flavor, which
> > is optimized for more lightweight and quick readers (at the expense of
> > slower writers, which for uprobes is a fine tradeof) and has better
> > performance and scalability with number of CPUs.
> >
> > Similarly to baseline vs SRCU, we've benchmarked SRCU-based
> > implementation vs RCU Tasks Trace implementation.
>
> Yes, this one can be the trace flavour, the other one for the retprobes
> must be SRCU because it crosses over into userspace. But you've not yet
> done that side.

Yep, working on it at the moment. I'm trying to avoid task_work but
keep main logic as unaware of parallel timer callback as possible.
Will post patches once I have everything figured out and tested.

And yes, I think I'll stick to SRCU for uretprobes parts, as you said.

>
> Anyway, I think I can make the SRCU read_{,un}lock() smp_mb()
> conditional, much like we have for percpu_rwsem and trace rcu, but I
> definitely don't have time to poke at that in the foreseeable future :(

Who knows, maybe we can convince Paul McKenney to help :) But
regardless, mmap_lock is going to be a much bigger win if we can avoid
it in the hot path, so let's see how far we can get with
TYPESAFE_BY_RCU approach that's being discussed.


Return-Path: <bpf+bounces-54915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824EBA75D7D
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 02:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F032167270
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 00:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9CB673;
	Mon, 31 Mar 2025 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxCmx0xe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A474431;
	Mon, 31 Mar 2025 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743381222; cv=none; b=aW64WM7IG7yRzgLhuXOSoVhiYsU7NZ1VqLKW0y/CEncnoiC6+eUXWc7uqEMEbTKjBaov2AUHSnWgH84otLOgBqlGNCh7GNWwqEFSL2BfCLogZwubeEHP4ZNF8E/VA6sZ4qCJ4X3eNm9ojvMf9p2oJvBNfvWvvtnPSPg5KG8ZcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743381222; c=relaxed/simple;
	bh=L8vYvjniuuHXtnrlVonbHiqLVeqTCECrkAOh7jtvTiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLN8CfaVARW6SLzl850/ZNTOX24GvOUF2AmkPrrDShyCWYWu+82MpCWl4Zi7gOYuCXSbYh5jgaVmuIyI2j2mwnhsXVe5BZLTdAtLQTyKqGmblCvTSxm2B1fkgji5r61+R8I3/UgUalY4iTVTHS3l3TQLAUHrxCR7Cwrmjky00s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxCmx0xe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3914a5def6bso2125885f8f.1;
        Sun, 30 Mar 2025 17:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743381219; x=1743986019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8vYvjniuuHXtnrlVonbHiqLVeqTCECrkAOh7jtvTiA=;
        b=jxCmx0xeywlIgD/ac4gka82NxgTzKSBtaDeNicK9/AR/QcJ+piqFqIf0czh+7911l2
         EQyDP4dEY5c/jAdQaSnsFmwrIixbY36Dsmw4Ii7Ne7YCwe2KUQ9fb509vT2WdQtaXIw8
         NvMetP04LRzUoGPV8IpnJ8vNKAC2nRkvphj5eT+iHpwj9PUphH6OJMo6Vx6gcQJ+Jyam
         6L1CVPnZ0bYA+gqlINBD0lsoMa8fi7oa4RyFiAHlg3uK1e6okDjaRXfA1gyQET5TOAGv
         +OdcL5DGMK7Q96IfzETM/yxrjmyMsO3BdnxqiYnPIEZtGC3aqqpiVvmNKeOhtruweYLG
         J4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743381219; x=1743986019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8vYvjniuuHXtnrlVonbHiqLVeqTCECrkAOh7jtvTiA=;
        b=WJJNRdvNY1MkV9Fmu6IVobAk/F1skunBFJQE8KOFvC41kXA4f1K/zUd8NOdABLgpAI
         PMOHNmT9QOxoLG7uI0MV8S9giEHbVGf2QewHTwl5GXLwFXb0+0z6QkVGRL3NaAxMiFLZ
         1dIPOwFn+7gL6BDhBHH4M6/u9ohRslTj6Qtn5cWnl5xm66eoPV+ujxKB7gE2TvduPLGG
         8Wy2rnmFHGP4IoLuh8KZ5T268lphvAPZ4mvmUhisPw00thCmp/W/7/zC6K6CZa0AusCO
         tEBHTBV2KuJmbSDv11i+O8SJVE80BVm72QbwFqlSpo0adB3Vsb+xL2Tz5B1ExpTq5ehU
         wJcg==
X-Forwarded-Encrypted: i=1; AJvYcCXz7yoTUqjO2Kh3QDkMiis7fGsRtFrBFapUjF6mfeoWR+EhFcz6BDyXI7VGkwydN5Xvz9QR6+hEGYRQK9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+/BkvQ3Kchzeh0Fe4ULWzz+ZGX82M9M1rq98hTVFKBLaKVXo
	QKTA/qov6vbMOhSiBigqRIZJ91kNPyhBrJ6jSSUU8EjVmeGyG1MHzfEe88G9VfiJHXmDePm8g67
	qT8nqaosjlOPMbbb35wRHjWuPisc=
X-Gm-Gg: ASbGncsp4LcSqFoyEbZXhEmejpXMRMu/G0KAZWTpbi8cRxITisqu7O4JnEG+742qOlV
	UDKJrydVkPwbbgC2OEclHZliGxxAhhICq5/K631qB47wMT3LEh6IB2ktYAbf+3pkA5qREz94yRj
	xbRQIlhP30zJ2ZmYrJfhj5Cdhv+CGeW8IkJrXMzpbLjg==
X-Google-Smtp-Source: AGHT+IEW82DydmHWVqGAX3xsLqsTlUpNFLFk4sTCjRjrhmVm2MYZgCOaa0nMvU/lgRqAUTY/Hsh6/N9G1ZRckDVe99w=
X-Received: by 2002:a05:6000:2a4:b0:391:23de:b1b4 with SMTP id
 ffacd0b85a97d-39c1211d57cmr5510100f8f.45.1743381218883; Sun, 30 Mar 2025
 17:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
 <CAADnVQJBHPbq6+TQhM2kmWNBTiPoB50_fnVcwC+yLOtpjUWujA@mail.gmail.com> <CAHk-=wgpYOGdQ+f62nbAB4xKLRbxnuJD+2uPBmRzSWCo5XkEGA@mail.gmail.com>
In-Reply-To: <CAHk-=wgpYOGdQ+f62nbAB4xKLRbxnuJD+2uPBmRzSWCo5XkEGA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 30 Mar 2025 17:33:27 -0700
X-Gm-Features: AQ5f1JpyJasy1EetBb0EPDXVvxj7a-WElI4Df5726-Ae6PTOOKnWWxxCvkucDjI
Message-ID: <CAADnVQKyLod8gNz-RR2=bs=vJJWiGhZ5GB4t68aNPNWndptr0w@mail.gmail.com>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 3:08=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 30 Mar 2025 at 14:30, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > But to avoid being finger pointed, I'll switch to checking alloc_flags
> > first. It does seem a better trade off to avoid cache bouncing because
> > of 2nd cmpxchg. Though when I wrote it this way I convinced myself and
> > others that it's faster to do trylock first to avoid branch mispredicti=
on.
>
> Yes, the really hot paths (ie core locking) do the "trylock -> read
> spinning" for that reason. Then for the normal case, _only_ the
> trylock is in the path, and that's the best of both worlds.
>
> And in practice, the "do two compare-and-exchange" operations actually
> does work fine, because the cacheline will generally be sticky enough
> that you don't actually get many extra cachline bouncing.

Right, but I also realized that in the contended case there is
an unnecessary irq save/restore pair.
Posted the fix:
https://lore.kernel.org/bpf/20250331002809.94758-1-alexei.starovoitov@gmail=
.com/

maybe apply directly?

I'll send the renaming fix once we converge on a good name.


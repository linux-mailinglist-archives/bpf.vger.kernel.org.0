Return-Path: <bpf+bounces-21925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ABA8540B3
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44342B2161F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30809623;
	Wed, 14 Feb 2024 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqNhayKW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F47F
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869383; cv=none; b=INnj67re1i0B9WALzm6e5nMlkGcN0mIVT3Bf/P3rLvfeg150j76VB14myN/JUc43VxITYUUVSTEyWIedzBKsaHQYBOs4rSu0zYtH2zB/EpYLmJbhKBRN6qLi7Prz1S1G4dxGbZWRJ7qK8CcqHwxMrziUiXhYgC95+zxvw+KOCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869383; c=relaxed/simple;
	bh=+5TaFy8ShyRfSb3zSSm6EqO3O3h5GcXX1NIxke+RuAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QowqxV3HaACr2Okh75YvLBeXPuvNGO364IVGn0qiMZCkPce29V/edj+u/8vEKP2hynPXGwSy0smg/eB7aGANpXAsNOVYgUMtuUfxWVeA3c3uTzN+bHErzQoPz3dBsDBdH3b/QX2dyMBXoBdP4jpvj0mdjODHq0GyxL9Kl9LXr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqNhayKW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2909a632e40so3033961a91.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707869381; x=1708474181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc+POPRYks5/J3TytxIqeVkOxSz7LgQaDDCDvOjAMPo=;
        b=QqNhayKWX8W/p4w316nRB5Lynm9MfmKv/A/gjOskH6koJukPa1ZigIC3t0jmNh/ShF
         BZcTjQ0WOY8WgaMsYuXsyj8ZGFPn5XjQ2nal4q5qgW10wnXl27NJHf/Pv/XWLUEq4AXQ
         OAfZkTl5vFxG1oo92+CIhyNvq9nijyiL/jsP8NJStTm+4LLDxybiAYpVNM6l7MMhBHli
         AUQABCsxoiiMw+dEAGevhY8F5LSZnDHCw4R6lZtXYNkXmeej0ddmLhk/fhNXwYnRH8XU
         kHficplOpIDBG+5FRgnWo/UxKB1JJ6k3w9wyJks0K+edYfcFRdYBEyI0cUpgVwP9OweT
         rRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869381; x=1708474181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sc+POPRYks5/J3TytxIqeVkOxSz7LgQaDDCDvOjAMPo=;
        b=d5byOzh73T8WpmgWo0QU50SK3ZoyOf/5BsCQQkOxLfLkWZcnVEAMY3rt/dMGMLyvL6
         uJwOwkmHVaL/jhHWpdFDfGDFXYGeBCm8DgtA3CAzUMwOk0OtVmbH79nWLAx+VsI/TY9n
         JmwHe3FHuLFABUMGjRR/ILWaOlf7aRKijbyC5kiKJr6i/bVwChNUK+z/GzHTWsPioPxN
         o4IoGCn2eG7veXRj+ff1rvGOeQqoGGhA6N3TX+xlY6CgJ+omDfzOUZUi33KQDl7xAlEJ
         BH74oWkgpE0I5dSgQIXhiJ+cV+IfM+NyaBggb5Kf5deeZzxoqfa+MOA/4PlVmktMk+Xe
         vz8w==
X-Forwarded-Encrypted: i=1; AJvYcCW17XzBOL7a63YxsgqxJGrvJ3RhDp/rFBCfbly4vFjl5W8ulFgQoCsS/cpCU9dZgsen000cx+FcDXL6L/aeBOKX3mJK
X-Gm-Message-State: AOJu0Yw/1KMR+8uiLTtf2gq5KSzbt9ZZHMYy5y3OQRZS075kQp4ip2gt
	K/psZVUqgyJCc0COHpmksw6KSaJgk+OiP7Y5vvmmqZ6YOM5DdTRHBX1+V5DVAxy2CPI6Sg+UYPA
	XIqiBYux8KnZTrf6zDZz4kM0zGzNw5Ik9
X-Google-Smtp-Source: AGHT+IE+7bYy9St15MqHari1f1GMjYtMZQSxQrmJBDuCNm9gYVDVpqgJpBYAw9MRFCzBMhmnSH0tx2TiJkX6J3OlKlM=
X-Received: by 2002:a17:90a:c90f:b0:296:111b:9f54 with SMTP id
 v15-20020a17090ac90f00b00296111b9f54mr1013278pjt.19.1707869381563; Tue, 13
 Feb 2024 16:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com> <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
In-Reply-To: <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 16:09:29 -0800
Message-ID: <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, memxor@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-02-13 at 15:17 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > So, at first I thought that having two maps is a bit of a hack.
> >
> > yep, that was my instinct as well
> >
> > > However, after trying to make it work with only one map I don't reall=
y
> > > like that either :)
> >
> > Can you elaborate? see my reply to Alexei, I wonder how did you think
> > about doing this?
>
> Relocations in the ELF file are against a new section: ".arena.1".
> This works nicely with logic in bpf_program__record_reloc().
> If single map is used, we effectively need to track two indexes for
> the map section:
> - one used for relocations against map variables themselves
>   (named "generic map reference relocation" in the function code);
> - one used for relocations against ".arena.1"
>   (named "global data map relocation" in the function code).
>
> This spooked me off:
> - either bpf_object__init_internal_map() would have a specialized
>   branch for arenas, as with current approach;
> - or bpf_program__record_reloc() would have a specialized branch for aren=
as,
>   as with one map approach.

Yes, relocations would know about .arena.1, but it's a pretty simple
check in a few places. We basically have arena *definition* sec_idx
(corresponding to SEC(".maps")) and arena *data* sec_idx. The latter
is what is recorded for global variables in .arena.1. We can remember
this arena data sec_idx in struct bpf_object once during ELF
processing, and then just special case it internally in a few places.

The "fake" bpf_map for __arena_internal is user-visible and requires
autocreate=3Dfalse tricks, etc. I feel like it's a worse tradeoff from a
user API perspective than a few extra ARENA-specific internal checks
(which we already have a few anyways, ARENA is not completely
transparent internally anyways).


>
> Additionally, skel generation logic currently assumes that mmapable
> bindings would be generated only for internal maps,
> but that is probably not a big deal.

yeah, it's not, we will have STRUCT_OPS maps handled special anyways
(Kui-Feng posted an RFC already), so ARENA won't be the only one
special case


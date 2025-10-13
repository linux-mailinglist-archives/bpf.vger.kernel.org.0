Return-Path: <bpf+bounces-70797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A748CBD1336
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 04:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2770F3A668F
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 02:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6627FD40;
	Mon, 13 Oct 2025 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lx1K1A9F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3802AD32
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321565; cv=none; b=A66OjQgyh0oYjvFpgbyQ4RX7pJJp6ztJ2W22Rmu5rhAk8WmXqYHIVVwgDBBRwGNpjdKHP1SzEQnosVPbPYI3kk4sxhNc5G5udDg0r7wD6R0iul6MtafiVRDdhX4iongiUadvqphTCtM2vaSJnNvu59tFuCKrf5lgXqHHQBB8zXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321565; c=relaxed/simple;
	bh=VZfdTOdgedZBuYAsHGuqCG7dPreRUBgR7A1n29pFkkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxC14T8pxasqcdzMjd+MclaYMyy1vOlwGERgSGHd7FRor++Xp3nH7LySaZp5qswnIs5Z6kugwtfdam5jpyzvQgzfd7+yjRL1BNHQmdHyC40hfJWCkGr2cBDuJGjSlipYoDeF3ktPjGpvk+hTQUQoZKcXe54W3qV9dMG/iswafn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Lx1K1A9F; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33067909400so2768056a91.2
        for <bpf@vger.kernel.org>; Sun, 12 Oct 2025 19:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760321563; x=1760926363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QVtgmRPffVrveMWw/xhEvB4D2pv6J+vbUKN7i5/8qI=;
        b=Lx1K1A9F/YQgE97dWV+RvBa/6Y5KNiX72ZxchbYVLGiy0WIErDQYj2KsUeei1hhdBz
         ydfQ1KZOlZz4/cBaoI7vgB6Qa5wmbsyguO+8y/4hkmUIVYY6Pumso/oXf4ncpqbDd89d
         W70PEZUYApUJcHKbVnpO986LZpWGWDIopIZRyBflfmsIdbe/vNujsp3lOU+htY1fPoIO
         fXSlv2o9xIVSzZ5XqXZClGCC+WZV12R/QF+05/H7GK4T+AjjelTAA6lR2Ijghy15NWrp
         IuqWfskPXlIwCejS2afcxR3jBx+F0PdnzZ+9s/EPEFM2HCSlu9y1+Qc+L6MLd3vRcrzz
         UUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760321563; x=1760926363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QVtgmRPffVrveMWw/xhEvB4D2pv6J+vbUKN7i5/8qI=;
        b=Kpue/Lieg2Y9GaoJpn69Y0RoKLhKKyCdY3mu0L48H9FMUopPXUWMtoUR+DtEyuWncX
         TNt2hKDZ5l8hwofk2SHUiAHHx8w/GeZQQZqVqNDSsaO9i15jsUJqsmguCC6YM9Z1ctL1
         +8xjFhF1o6DgoT6vK53kSDJbZH7RKB376IgrxWXhzl0EWTrxcI7yvXnK7MuNubq4YjnD
         TEKZpV2yj/PN6zfHWqjlu//hUByn961EUIkmmA3R5yZItEkfRCCGwRJiZrjx/55Nh+Y2
         heGS+kg6wS52urezjebrGC3laAj43GQdGeYf36KtfrcY1lxhwQvIxFWVazArgoSlS3wZ
         PIiw==
X-Forwarded-Encrypted: i=1; AJvYcCV627DI8L/oxBgjoSDNkaBWqVbHDd3RF9s76Of5ABbl2L+OuEVFlrePoToKl4APj4usHWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNhyqIw39nYKsSBiwnpQX+jirk3bozjgfZB2P4Y5IDayzvgkP
	XiIsIXzC6VstJLdNczDdTlRrPZ6QsNX9NzClXGyHSYzLNk4M4T23NLe0VSc5VexN6LvRzw0WFQ5
	lgm/ZZjI4F7XbwqVf+dT4Lhwwq8z5l/UCG6yv7bHv
X-Gm-Gg: ASbGncvntAATyzT/ukVv765kOVjyN1UJn8aLid2IM5OxUr7Txj70Oh0VZf9+Z3ex8Pd
	/kjITCkgDDDmjsiZ+ITRkyZL86UN6Vo6V4b9KpVdYl9EsTMf2kt1yf2velNPUKoA2ZtSCYSzvUv
	eZanWGQdPaXllCr4K/83E/x90hOD98Qi900e39opwXEma691rcFmgHkRiCK2fKAftWnSXF6Byz4
	dfqAkuNmO4Gq9HDvpSqAEiFSA==
X-Google-Smtp-Source: AGHT+IF/7dVxx+fWF4F3e0kqhOjgNsZbz0VE6Auc0DsC74H9CA31kPdNtr2DRAliP1k65VbG0X/QtMinwgZfnqQjA/E=
X-Received: by 2002:a17:90b:1b12:b0:32d:dffc:7ad6 with SMTP id
 98e67ed59e1d1-33b513a1f6cmr28160281a91.33.1760321563256; Sun, 12 Oct 2025
 19:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
 <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
 <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com>
 <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
 <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com> <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com>
In-Reply-To: <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Oct 2025 22:12:31 -0400
X-Gm-Features: AS18NWD9zfIn5tcHQ6Y_nLKIN3zk-5cLTWyK-kph3M8Yz9ldmfZRQl8D6QQtW4c
Message-ID: <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > It doesn't need to, once we check both the loader and the map, the
> > > integrity is verified and the loader can be trusted to run and
> > > relocate the map into the bpf program
> >
> > You should read KP's cover letter again and then research trusted
> > hash chains. Here is a quote from the first googled link:
> >
> > "A trusted hash chain is a cryptographic process used to verify the
> > integrity and authenticity of data by creating a sequence of hash
> > values, where each hash is linked to the next".
> >
> > In addition KP's algorithm was vetted by various security teams.
> > There is nothing novel here. It's a classic algorithm used
> > to verify integrity and that's what was implemented.
>
> Both KP and Blaise's patch sets are implementations of trusted hash
> chains.  The security argument isn't about whether the hash chain
> algorithm works, it's about where, in relation to the LSM hook, the
> hash chain verification completes.

Alexei, considering the discussion from the past few days, and the
responses to all of your objections, I'm not seeing a clear reason why
you are opposed to sending Blaise's patchset up to Linus.  What is
preventing you from sending Blaise's patch up to Linus?

--=20
paul-moore.com


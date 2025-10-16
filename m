Return-Path: <bpf+bounces-71163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85264BE5A0E
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 00:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1462519A6C58
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051302DE6F4;
	Thu, 16 Oct 2025 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAzl8d9i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC8207A38
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652064; cv=none; b=RwZyahyn81YuO6hypbzeSXD4/OIpY67fUPaPugHpTyg+CaZ9cRO7tO/gHE0/uxqMCUI1CK8sG8xlXGQDaUOlXSMAO9Ui413mn3VCK5pCww67x3ltAAVURY6Yp1cfd7Yv/AnVvfF8SkBdANdqmWdYw2EWsiRgLyUd1kQTQzx33UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652064; c=relaxed/simple;
	bh=xe+NhIdEtxHmjm8xKeTWO4uHKEZpiSROQTAIPoHNfLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnMcH0NZfYJKt1WYEOdsnXt3CrgBOT5Fjp68xx2VmZf6x9N4GbUl82IRHpGBhPBNfnMSkGc5i0lykUjwZAd4opDvkEQeaxgecGaCXr4HjB2hVWQKdFpiYwqotMq+Qy/19T1WTyxQ+o1mlaDr2eZVtpTqHAbApK7ahA6FWBsbeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAzl8d9i; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471076f819bso9808905e9.3
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760652061; x=1761256861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd1m5oh/C2ya5fQFeC4TaY27qKH8o+UGJB/7+qbAmZI=;
        b=CAzl8d9ijSTZT6yca5qFmjZ/CflinBT1zNNYI8WJ0DFV5PPFObRsDvPHGoUL1q8yPM
         9IMbu5hb1oIKhIRWjjFJHWmHsttphYow+oZ8/95+mmZi9zPgHTZfwgJ4avglc1vbZBe7
         1PtOL7aOdc3ShYneXOPlEbiCue8UGrEJFMYhc/OGr58MQLm6JGUAIQoXUcKQ9+uvL2Z7
         ydnXiRMmgwhRz1KA3bfP7qUgvtZtaqVP9M5lqxTXiq523xwLt+stJRNVlEBR4CeZ3QPi
         es9+24YO1nkjekXG559Ev5o+Ym6btqS/FUolB3p2MmDPl1+gvKas3jq+Dms12Tk4aMRy
         SF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760652061; x=1761256861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd1m5oh/C2ya5fQFeC4TaY27qKH8o+UGJB/7+qbAmZI=;
        b=G8OvAgUrf91u1aygeKhHjSyXv9T2FiXqXHMOfOntDG7DXoJ9IUjPEuGGCrh/GC3zK+
         Y3REcg2QI2sRqRWsV/bC2WzIBwBYyGqypcjMbrnOzT272dOfC/Jbyqe3qS5+SdZkYINy
         kazEJ0rvVllo29ZQ2W4hRbUr3FLUaNJ+1LEVSIu/ZR8NFYGhzWslfxQ6+1m6iGeNStqj
         YSQcaaBymx5TQ+cbvA+BXecid/Ym1Awfd+vG57Crj8sN66AQrQoHtH2reM+2Ji3AZI+R
         Li+H4Padtt/2zT/LZJG0YGo2Jrcx67egSYsbo3RM+vzCNF3zDg0W1eTjpAGpUaekO+vE
         IyXA==
X-Forwarded-Encrypted: i=1; AJvYcCVyQYaGsjBul6r0B564ZpBQE6yirJXv3R6VVdDvELOSw3tIqHZzahc/9zGA0OS0Il7EdRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmoUTPBfaOzUEIn+jv+c8yK9FG/568R9Xq72+71a3YzB9mu63
	fFh5cw5/7BZ6LC7Tb/vi8fnqkPZFID0xpdM5Q7MUmbLklYTqlAJsQDwBlYVRPpUB9oQukKJb7eg
	6o3BuUh0UiRUpdNuPU8ZmyAZ9PsNCVOk=
X-Gm-Gg: ASbGncs+YT+/IbToTKIP5BB/ytv//MFkyXzt9kENTBJfEWOn88+/OSyZA7KsH3fjKDz
	SHND60NdTbIC00WvICgr8eWpSnsDdsqFBPmou+O2T82OpkxOwl0F/KoW1OHGCrMIisdBWuYJFdG
	o1eGfTW6DV5Tp7t7Nqzbf9QNBW6TQP3xyWBSFVN72oG/qgIB7uKNEc9Wnk41dUQQaqCgfL97C24
	U3Le2ohnkQ7D0NSdD33ofFSWujVAQwUkwklj9qtS3V9ZBs4DV5KwpiPRu11VMYdI+5Gt16zO7fI
	CU/PVP66v812gTXqZN3sGZxMzIHd
X-Google-Smtp-Source: AGHT+IHbckAP3ar0ENCksvvYMo69hZUNmT2OQZntJCuLluBEpqZzCD99uKlti0PkUVTDNjC56Tqj5+4gtBrE/tA0m6w=
X-Received: by 2002:a05:6000:184d:b0:3e7:5f26:f1e8 with SMTP id
 ffacd0b85a97d-42704d9cfefmr1186928f8f.5.1760652060968; Thu, 16 Oct 2025
 15:01:00 -0700 (PDT)
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
 <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com>
 <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com>
 <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com> <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
In-Reply-To: <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Oct 2025 15:00:49 -0700
X-Gm-Features: AS18NWCHYVxF7GSfIutVNDKmCB7FqGua0rnVce6zETEX8aqYgOptdQU3tKPf6ho
Message-ID: <CAADnVQJw_B-T6=TauUdyMLOxcfMDZ1hdHUFVnk59NmeWDBnEtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 1:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Oct 12, 2025 at 10:12=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > > > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > >
> > > > > It doesn't need to, once we check both the loader and the map, th=
e
> > > > > integrity is verified and the loader can be trusted to run and
> > > > > relocate the map into the bpf program
> > > >
> > > > You should read KP's cover letter again and then research trusted
> > > > hash chains. Here is a quote from the first googled link:
> > > >
> > > > "A trusted hash chain is a cryptographic process used to verify the
> > > > integrity and authenticity of data by creating a sequence of hash
> > > > values, where each hash is linked to the next".
> > > >
> > > > In addition KP's algorithm was vetted by various security teams.
> > > > There is nothing novel here. It's a classic algorithm used
> > > > to verify integrity and that's what was implemented.
> > >
> > > Both KP and Blaise's patch sets are implementations of trusted hash
> > > chains.  The security argument isn't about whether the hash chain
> > > algorithm works, it's about where, in relation to the LSM hook, the
> > > hash chain verification completes.

Not true. Blaise's patch is a trusted hash chain denial.

> >
> > Alexei, considering the discussion from the past few days, and the
> > responses to all of your objections, I'm not seeing a clear reason why
> > you are opposed to sending Blaise's patchset up to Linus.  What is
> > preventing you from sending Blaise's patch up to Linus?
>
> With the merge window behind us, and the link tag discussion winding
> down ;) , I thought it might be worthwhile to bubble this thread back
> up to the top of everyone's inbox.

Please stop this spam. The reasons for rejection were explained
multiple times.


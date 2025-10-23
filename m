Return-Path: <bpf+bounces-71944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B66C02326
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7C543D7E
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466733C50F;
	Thu, 23 Oct 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNsvXrzh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EC633C520
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233996; cv=none; b=KiOVQT4qHLW5+JnjC+IIeDqHgBGPL265ylJT7Wo+QZnlImoQDMJfrg9wP4xPSkY3kIuS3euDg8lSggotS5wVeziKTN8Q8KPjuxnEIXqV6kG2y804uqH4RhLQatg9TOI3cSWaiX29OPA+n/AzFY3AFch4OJOWdSfDedvrQczPn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233996; c=relaxed/simple;
	bh=ti0UHhSYt96791PDFgTG8yi+uqI3jA7rIHdlbh71V+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9un+nBr0gM0Aldzs0RX26NxHroJogBl9mPCBUIhfD8xGtv524qa0ZYa1Ee9b/0zH/nwKwDPUE/uDpaM1wG7s/I3VZVK1TIATH5smRkBNbYlHjw42uqXdSskpk5hcsYDV4uwHDy8FqdnDP82V0xzZ+6O7Azmztj2XEyB3r3aRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNsvXrzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C447C116B1
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761233996;
	bh=ti0UHhSYt96791PDFgTG8yi+uqI3jA7rIHdlbh71V+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FNsvXrzh5xfHGR3EQTuQ7kbwSs3uDv8IdHlfNHXThcDE7PvZzhj2Wx5Gfy5jTnFty
	 mbySokzgyGhlj5idQe+1AyB6zUA2YglsJxvdpaitcC2PIGVp1XJdK4jAoXeAR8lWVJ
	 ZhfNCL3DflC11ycSKnki3Nlp/o6WMhQ/PxJgsYIHibUQdXHkwcXO2HRbnEb72O9Oa4
	 +GJaaCM23L98OlmN9qKTK+1Nep44kpB6gSp7TSoA/rjj6gA2IIsNCRdql9WCU28hYD
	 vZVwmEl6MAJgAJsbiPyif33DM1C3PGH/R4YfFshKbQyPRGpTmcm3uIBtR+lZEOFEKE
	 22KsdSdPiOsJg==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso896126f8f.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:39:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgr3m+kRFRxeICJvr/wsO0+RG9yd+BOTKmfaYlWJ1zDr5GrOJu1TgyQjdwU8JGTqtqPMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbz6qsqW7pR3pBG9vL618BVqdd/07Hm0uHHL8qY6VbSRrZHEV
	WFFF68BS73H5tRVNZ98iCnSH0hiJYA+jMpD7j6UZrPCKKs7O62NT078LtwnZlk/wOqYOJJRN2kF
	SmRiYhgA1NY7y4ZBDeff4sOdHT75yjAeAx/Ww6UfD
X-Google-Smtp-Source: AGHT+IGQVbYGp7O+yoxgyFGve+8RV7ljJ2coZFw7sdkM2H8nfHgfdLQMkpik8PV1ZmE0UDNJQeBwdH3xHYDfavUOd/0=
X-Received: by 2002:a05:6000:2303:b0:427:6c7:6703 with SMTP id
 ffacd0b85a97d-42706c76a60mr17469915f8f.63.1761233994937; Thu, 23 Oct 2025
 08:39:54 -0700 (PDT)
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
 <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
 <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
 <CAADnVQJw_B-T6=TauUdyMLOxcfMDZ1hdHUFVnk59NmeWDBnEtw@mail.gmail.com>
 <CAHC9VhSRiZacAy=JTKgWnBDbycey37JRVC61373HERTEUFmxEA@mail.gmail.com>
 <CAADnVQLRtfPrH6sffaPVyFP4Aib+e7uVVWLi7bb79d9TrHjHpQ@mail.gmail.com>
 <bc823ddbaf63e0e177eb46d1cc15076e4e2e689d.camel@HansenPartnership.com>
 <CAADnVQKcOS8iu0Nq5aYg+Lg_EAO8fFde0H3w8t0m_SXUy4iKAA@mail.gmail.com> <b21284e338846166804bd99bfc37186cf80f1b38.camel@HansenPartnership.com>
In-Reply-To: <b21284e338846166804bd99bfc37186cf80f1b38.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 23 Oct 2025 17:39:43 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4z4vzVEjtOmFHuC9tpDmWp0N-EH-xDK7Bs6YJ-x0W3Sw@mail.gmail.com>
X-Gm-Features: AWmQ_blPK84HlJK2wlWAn0y4h3BNe6SxxwJC-xtb75N9yB8CsQaGCGdK5kJkXQk
Message-ID: <CACYkzJ4z4vzVEjtOmFHuC9tpDmWp0N-EH-xDK7Bs6YJ-x0W3Sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:10=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2025-10-20 at 18:25 -0700, Alexei Starovoitov wrote:
> > On Mon, Oct 20, 2025 at 4:13=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> [...]
> > > The point, for me, is when doing integrity tests both patch sets
> > > produce identical results and correctly detect when integrity of a
> > > light skeleton is compromised (in mathematical terms that means
> > > they're functionally equivalent).  The only difference is that with
> > > Blaise's patch set verification completes before the LSM load hook
> > > is called and with KP's it completes after ... and the security
> > > problem with the latter case is that there's no LSM hook to collect
> > > the verification result.
> >
> > the security problem with KP's approach? wtf.
> > I'm going to add "depends on !microsoft" to kconfig bpf_syscall
> > and be done with it.
> > Don't use it since it's so insecure.
>
> Most Linux installations use LSMs to enforce and manage policies for
> system integrity (they don't all use the same set of LSMs, but that's
> not relevant to the argument).  So while Meta may not use LSMs for
> system integrity the fact that practically everyone else does makes not
> having a correctly functioning LSM hook for BPF signature verification
> a problem for a huge set of users that goes way beyond just Microsoft.
>

The core tenet of your claim is that  you need "LSM observability" but
without any description of a security policy
that cannot not be currently implemented. The responses I have
received are generic statements that the loader verification is
"unsafe"

If you really consider this unsafe, then you can deny loading programs
with relocations and re-enable them when / if we achieve stable
instruction buffers. To be honest, with this restriction of all
signature verification happening in the kernel you also need to deny
key real-world BPF use-cases like Cilium, bpftrace which generate eBPF
programs on the target host which also shows me how out of touch you
are with the eBPF eco-system and users.

- KP

> Regards,
>
> James
>


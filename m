Return-Path: <bpf+bounces-48571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D56A097B1
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 17:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4196C16B531
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75E212F98;
	Fri, 10 Jan 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="A1TQbOtx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D57211477
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527296; cv=none; b=sFa3XM0WRctc6xi4hIVdaGkrOEu9kKrnQ4qgNFxg/aNa3wBABOMz+Ot4lEI6ooZb59ppUkoSUgjowIbn3vJx70eRPr7CnFVjEp0CzcP6KugSBxOVn36wTd5AkkK3klMZXTgW9g58JzJRw5Xf68bDmAOsM7HMzvik8DNkbjXTiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527296; c=relaxed/simple;
	bh=cExron3nM5QwGWQtaP3AMzIvgqJzcTsePpFqLoZ0MJY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5iRJ6ckNlt6Va6yz9f+1dMsae8zkUo/yX8ymUEtaChrarnChcUXvkUyjpLRclpUDPxn7iigwJPJlGsuuSSWqHCItHcLLHQIcs6PDLO/GoSGDBTGtzGnLfPm+//PzwjPRDG5N5pLg1hW73Y+4Do3OdHVBFQ3xPbbR6u3ZjNm+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=A1TQbOtx; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1736527286; x=1736786486;
	bh=cExron3nM5QwGWQtaP3AMzIvgqJzcTsePpFqLoZ0MJY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=A1TQbOtxQGN7v8dFSqZRLvx84W2uDz03K23wp8rjUtElTTMvqGIIqClizzcer2yKL
	 WH8+77QsRWRaZ+LDDa8loUkGWruS1F5uDQLko4681U2jCo/zv+9hnqZngLZ02/rmCA
	 7JyG+wovFovU8ymZdriRLsPcdUowvFuOeEoXKA3BEquMCxsdd3SuKKfhfnv2weVdY4
	 qX6CWBJCAfMEyMMizcwRgSW+nZ3AnJ6HeDNJQ6i47ic7bD1sKKbEPVOviJGKxelhiD
	 bNBPo2thRaTVXcW7MpWBF39NKmDRaVx2uSIGsZfFYeFqmwS7ShrTUb10lAYT1oO/KM
	 mNTCW8ergvQUA==
Date: Fri, 10 Jan 2025 16:41:20 +0000
To: Dave Tucker <dave@dtucker.co.uk>
From: vadorovsky@protonmail.com
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Neal Gompa <neal@gompa.dev>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Matthias Maennich <maennich@google.com>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Eric Curtin <ecurtin@redhat.com>, Martin Reboredo <yakoyoku@gmail.com>, Alessandro Decina <alessandro.d@gmail.com>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
Message-ID: <OEhWEyNG4cqhFinY3nHBef8R8vM_Xwc9zmYfae9IrXJJXFDtH1YbEskmd2N5aFVaI8YNOYWfaiEZjFsRC80XUPfgcPYr0jR1hrBjnKHFY9Q=@protonmail.com>
In-Reply-To: <49AF84D3-3D47-4B35-B1A7-497045FD241F@dtucker.co.uk>
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com> <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com> <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com> <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com> <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com> <Z3_vhR_QMaK0Klly@x1> <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com> <Z3_5eGD_F1_ZxfqE@x1> <Z4BQG3rmYNDS5W0Z@x1> <49AF84D3-3D47-4B35-B1A7-497045FD241F@dtucker.co.uk>
Feedback-ID: 114064189:user:proton
X-Pm-Message-ID: 1c7f40e235306cf401e2a4ba7cc248f9e6a22cb5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, January 10th, 2025 at 5:22 PM, Dave Tucker <dave@dtucker.co.uk> =
wrote:

> > On 9 Jan 2025, at 22:39, Arnaldo Carvalho de Melo acme@kernel.org wrote=
:
> > And sure this will be refused by the kernel, lots of stuff that have
> > invalid names, probably need to turn those into void as well as a
> > continuation of this hack, then prune, maybe that is it, we'll see.
>=20
>=20
> Rather than voiding the names you can do something like this [0] to
> coerce them into a format that the kernel is happy with. We initally
> voided names but the resulting BTF was unusable since you couldn=E2=80=
=99t
> lookup types by name.

Regarding the names, I would recommend to do exactly what we're doing in bp=
f-linker[0], which is converting each character not supported by C to `_[he=
x_representation]_`. This way, we make sure that two different types can't =
produce the same names in BTF.

An another important fixup we do is ignoring data-carrying enums[1], I thin=
k pahole could that do for now as well. That said, I think a long-term solu=
tion would be teaching the kernel to accept them.

Cheers,
Michal

[0] https://github.com/aya-rs/bpf-linker/blob/v0.9.13/src/llvm/di.rs#L34-L6=
0
[1] https://github.com/aya-rs/bpf-linker/blob/v0.9.13/src/llvm/di.rs#L129-L=
132


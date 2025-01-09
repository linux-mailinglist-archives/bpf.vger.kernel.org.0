Return-Path: <bpf+bounces-48408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA66A07C59
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F72163E3F
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B03220688;
	Thu,  9 Jan 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOi88S40"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4FB21661D;
	Thu,  9 Jan 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437642; cv=none; b=ZgLoS0pI4/2/bLliAlnIXC6u2g32+wfDyd5doausF1Pk5kGkEhL1GxHlYnSiS94tzBD7DkkDo6l7H7bzS91EcXBz49LIQ9NoEbiT2TTNc4RHlWqHTBT+GlZvGVkySObb1AAeBiyTlocO1g1rkMbXn5P9XfW7GL0oPiR0M1Gd/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437642; c=relaxed/simple;
	bh=OdYsY23DztYQ8qnu3ZeIGC3I5nCXum3DWdKdO94r1tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL07TA69z32gIgsg/xfS4NQJChuUG0w+E1mMO1v9NbfvGduBRZlIwQThuY76lFhW2pEk8XjnirSCtOgDOFa4/ipHwSOVwcoRS7rHBgGQIgv4Ux/8Ayr6Ru9aSas1b0LHai1SE3LvO+tP4f+IWY9pAm1rFUSs4PILQDwDMMmNvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOi88S40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F5CC4CED2;
	Thu,  9 Jan 2025 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437640;
	bh=OdYsY23DztYQ8qnu3ZeIGC3I5nCXum3DWdKdO94r1tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOi88S401ShLIlrECFheixfByAlbXLdeV9XQ4tjw7rB6lsWuWzWCsH/A/9bJXtDrl
	 /fXe9rUFaNVJQtcsQYgl2rKjkCxsmQs7znttf/fgUB+AjVudDsjEM/UAlQyWOpUns6
	 z768vtr8pzCg2WL/8ekD3OEyXYZU+SSWrBXikOHwVblRwSXyuMfwmGOhnr3JruPx6g
	 cdGdR5L1qcoZKESkN5rXh0ONxH4NsMAaotse4wMXzyUeceH+zJt3jqXK5YopTLEeXJ
	 8sKbACwbci1m1gqGhLezeB1eOIBQHaXhl09zVXaUMHG0sQ1xnp2FrH3aHRSMCoVWbU
	 1Qlz6lIIZfsmQ==
Date: Thu, 9 Jan 2025 12:47:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Neal Gompa <neal@gompa.dev>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Matthias Maennich <maennich@google.com>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Curtin <ecurtin@redhat.com>,
	Martin Reboredo <yakoyoku@gmail.com>,
	Alessandro Decina <alessandro.d@gmail.com>,
	Michal Rostecki <vadorovsky@protonmail.com>,
	Dave Tucker <dave@dtucker.co.uk>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
Message-ID: <Z3_vhR_QMaK0Klly@x1>
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
 <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
 <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>

On Thu, Jan 09, 2025 at 09:55:34AM -0500, Tamir Duberstein wrote:
> > > > On Thu, Jan 9, 2025 at 12:35 AM Matthew Maurer <mmaurer@google.com> wrote:
> > > > > The kernel cannot currently self-parse BTF containing Rust debug
> > > > > information. pahole uses the language of the CU to determine whether to
> > > > > filter out debug information when generating the BTF.
 
> In bpf-linker[0] we implemented "sanitization" to allow Rust DI to
> produce functional BTF[1]. This is certainly outside the scope of this
> change but: could pahole adopt a similar strategy rather than
> employing such coarse heuristics?

I was thinking about it after reading this thread yesterday, i.e. we
could encode constructs from Rust that can be represented in BTF and
skip the ones that can't, pruning types that depend on non BTF
representable types, etc.

This way we wouldn't care what language it was written on, as long as we
can represent the types in BTF.

I'll try to do some experimentation with this idea.

- Arnaldo
 
> [0] https://github.com/aya-rs/bpf-linker
> [1] https://github.com/aya-rs/bpf-linker/blob/e4a9267b0fee69ecb2550058d3c8e5233f946ebe/src/llvm/di.rs


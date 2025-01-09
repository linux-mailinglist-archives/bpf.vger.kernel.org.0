Return-Path: <bpf+bounces-48416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6096A07DD1
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BC2169C96
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C09C222594;
	Thu,  9 Jan 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVectj09"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AC22257F;
	Thu,  9 Jan 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440627; cv=none; b=IdSUt695LtAMs4rNmQZACcYzKkS+aCSO/plQViqQOHu+FfG4rkYMEVhwjx3KZJc3g9EHobEXoVJxgoMEMmPyX3goNFHnVIuX1wyXUbiz1mYONTBpBsr95Mn4sN5+AoL9opMZQS62V4cLzFKeMk7BuHKSKqWgP5B5YeBImHEPb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440627; c=relaxed/simple;
	bh=l5izUIuRQcUPxRHG1mIm9Fin1WX3o2ecdRtHcN3CCS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3IzEZ4eqmcbmceCUa5jEQ6OsFA3oSC+DfigoJAmHLJyfxNidF65IoZRp1JnytFy+UWb9gJUGHSww3hxFodY54QBF/70vNTgtRSkfG0/uqZcGus7i2RjYREwz/rHPl5m9v3aREp9a9PRrIaofp5Dsl1lUXzxBEQg24/PLBpNJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVectj09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6662C4CED2;
	Thu,  9 Jan 2025 16:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440627;
	bh=l5izUIuRQcUPxRHG1mIm9Fin1WX3o2ecdRtHcN3CCS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVectj098uLXeVwFl2HjY8t67AUrSYl5ryAxte7+1JZCEMxswMhCm/DxA/rrz7sc2
	 z3l+33wsAaEx8XBjCVG46XU4eCo6jmOsmkuJGygguiNt4D35XNUIXkSN1JRqkgw8+s
	 3FElTFaC3Droec0PDNdGpG0BprSBZi1ePs6lXJnGts39aKE8x1NBFLPMe8V0Co0XB+
	 uq52m9aRN5+HhFiZmCb0BO4uUDma7q1co68/ZOuVj7RMcWz66VnM1ehQr6uB7rFp0e
	 Ye0ps++PdSeOjVtw2X9kLdGTyZJ3Vw9AVHiPUlTTerEO+8MxpwLp6LtCAoJFT7mmRd
	 tCsO4jvwh2t+w==
Date: Thu, 9 Jan 2025 13:37:04 -0300
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
Message-ID: <Z3_7MM30-wwY5ihQ@x1>
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
 <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
 <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>
 <Z3_vhR_QMaK0Klly@x1>
 <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com>
 <Z3_5eGD_F1_ZxfqE@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3_5eGD_F1_ZxfqE@x1>

On Thu, Jan 09, 2025 at 01:29:47PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 09, 2025 at 10:49:49AM -0500, Tamir Duberstein wrote:
> > On Thu, Jan 9, 2025 at 10:47 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
 
> > > I was thinking about it after reading this thread yesterday, i.e. we
> > > could encode constructs from Rust that can be represented in BTF and
> > > skip the ones that can't, pruning types that depend on non BTF
> > > representable types, etc.
  
> > Yep, this is what bpf-linker does, along with some other things[0]. I
> > highly recommend reading the code I linked to avoid re-discovering
> > these things.
 
> Sure, thanks for pointing it out and suggest I read it while
> experimenting with having the same concept in pahole, I'll try a quick
> hack and then look at it to see how close I got to what you guys came up
> with :-)

BTW, its "funny" how the DWARF loader can get things from Rust, golang,
fortran and end up with things like:

Rust:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=d744d859768d6951cacd146604891c108b39f6a1
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=c4eb1897d1f3841d291ee39dc969c4212750cf2c
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=2e8cd6a435d96335c4794794147019369b6a7b6a

FORTRAN:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=f5847773d94d4875e04e47de9b677098f34c6510

Go:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=31bc0d7410572f6e03e3ed9da7c8c6f0d8df23c8

Now its a matter of making the BTF encoder be more permissive and just
skip things it can't express in BTF.

:-)

- Arnaldo


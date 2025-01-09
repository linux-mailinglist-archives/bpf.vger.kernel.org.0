Return-Path: <bpf+bounces-48415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA58A07D80
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5291B3A82CA
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399E221DB5;
	Thu,  9 Jan 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQre/HJD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6221C9EE;
	Thu,  9 Jan 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440187; cv=none; b=PBrOu7bnmzruGLbZUbNkyjStGx69NuW2EtoQMn6G89S4os8U8MFhpeWhnQTUYPHNQNsvx+D5KOPos0iajGrxeHe0EozKlgtGJA2KQSChN+xaJMsI3dIFGJjDPYNG9VxzBNRaKgY0zqyLzQy9E2GF5XbLQ28I85n8PaiT6vC7ooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440187; c=relaxed/simple;
	bh=IZiMbZ1tsZq95UI3fefPXkeFejfBqOhhz0QnnBfP6xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYECdEt15ttcqL48JYS8bEzgvc7IlYEhwRF8o4Wesj5nVLCorrfEPkG1e4WLcybHzAlH7Oop7qaf+H8Zd6k+h8FQoKZfDWWcsZnC/JDwI5GTQV+FWajXO4iXWp4/JnEZl9DxG6WjmhfIkgEy/1Gcvdf/1z9RGtVYyPFBQxHtz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQre/HJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9432AC4CED3;
	Thu,  9 Jan 2025 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440187;
	bh=IZiMbZ1tsZq95UI3fefPXkeFejfBqOhhz0QnnBfP6xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQre/HJDSxPjRDWypWyEjmr8MKQik2ag9QBS/RgbXYSqtdZrDw1oqwS4gSWBzC9Fe
	 kNpznEzHTUDDsZOc0MyI9XbnKRzOwA++UZfIba4JwPUt9EZOh0PHccv9HEZJAE3tZ6
	 AhQCmKhsrndXUGeXSKqOYEz3fiyQ6tTpSgbKXsbqKP7NCepqKWAE5L3yN4kXJCecFo
	 n8845WcCp3f/fqFFVqdHkc0ycyGqmCFAKGE+SNUTLNuwazu9xtzx9NOxw3IFotNbSY
	 iqEuDNGzIkCAhnhVZPzMdYQLEAeIij8QholWtapjmfhugXzKHVeUzIrShdr575OYIk
	 hkIPzDE+8SZqA==
Date: Thu, 9 Jan 2025 13:29:44 -0300
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
Message-ID: <Z3_5eGD_F1_ZxfqE@x1>
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
 <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
 <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>
 <Z3_vhR_QMaK0Klly@x1>
 <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com>

On Thu, Jan 09, 2025 at 10:49:49AM -0500, Tamir Duberstein wrote:
> On Thu, Jan 9, 2025 at 10:47 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > I was thinking about it after reading this thread yesterday, i.e. we
> > could encode constructs from Rust that can be represented in BTF and
> > skip the ones that can't, pruning types that depend on non BTF
> > representable types, etc.
 
> Yep, this is what bpf-linker does, along with some other things[0]. I
> highly recommend reading the code I linked to avoid re-discovering
> these things.

Sure, thanks for pointing it out and suggest I read it while
experimenting with having the same concept in pahole, I'll try a quick
hack and then look at it to see how close I got to what you guys came up
with :-)

- Arnaldo
 
> [0] https://github.com/aya-rs/bpf-linker/commit/1007ec7fed03562eb7d08f3e7521094a7e698b95


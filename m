Return-Path: <bpf+bounces-48563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF3A09462
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A911883D37
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354EC2116F2;
	Fri, 10 Jan 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGnteLWB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F65211499;
	Fri, 10 Jan 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520881; cv=none; b=YA3a2hzk+xIy/1xsOHZur6zXGeaAvRyqF+nNkNaIDIlX9ONC1mUN2Y6PY5juMCHnjDe/YWamTGvXToAluWKcXhWrIOUVqMMeAMPGUMovTkJGgeftLQ7RbiQAjQF62vcSzD6vz1B025zBCXx9qvv+n10ctj9dL74uWPgFFJAvkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520881; c=relaxed/simple;
	bh=x+ph213te+LealQRYBUf4qmsmlwqAXq26ap/yM57+7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGSGV8ezZe8NHEe+IhSlyDG+Vc1fujy0uvOyAHXVhAP/oKJJ/4Q+wNkuAhpP6S4nSoqOwSKuZsJXMWobT+/LNNqE5UInrLSmKP8atw7LPrDjZvqGXRO8PoFeQBMNBpcDG4MAa/j4cDxKLh8jmEO6Wct1MN6EhvS7hr7LdJfzmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGnteLWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED68C4CEE5;
	Fri, 10 Jan 2025 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736520881;
	bh=x+ph213te+LealQRYBUf4qmsmlwqAXq26ap/yM57+7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGnteLWBTqJagtwicNH9Y8biSKUQPFlIy0tQGEzRa6yx4l2sbPu2S/zaZdWvrk2Fx
	 0suZaVaaOdaCY6yfCks/1Q6H9UkXHqqvF5DEcdah/nrMh49TIr0xCqN/odgOYY08Sk
	 dQ1kvLdkRT/CN6gtSv7Xvtr/49rOiCwWnfhxrhMXmMuyF+YtFomFGbXwl1WW/RiN6F
	 oPJzBKtknwGKbdqriG6Sjvwc4Zfj7Fa0jfrnCLgwrcXQl4l6OFS0gN9KoGR8o0YTxa
	 0aP2Ch9jU3BOciY2KLYnQLRKRPJLhbMvfQZtr5EEWnjWQU53tjsJV9LJRJEUfc+kqo
	 qON9pqHX/j2DQ==
Date: Fri, 10 Jan 2025 11:54:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
	Neal Gompa <neal@gompa.dev>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <Z4E0rZmHFU01umqx@x1>
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
 <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
 <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>
 <Z3_vhR_QMaK0Klly@x1>
 <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com>
 <Z3_5eGD_F1_ZxfqE@x1>
 <Z4BQG3rmYNDS5W0Z@x1>
 <CAGSQo039Kgxk4FfDn_wfD=Ha=UR2xxhSM0MrjzXNR9YeiuCTZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGSQo039Kgxk4FfDn_wfD=Ha=UR2xxhSM0MrjzXNR9YeiuCTZg@mail.gmail.com>

On Thu, Jan 09, 2025 at 02:41:50PM -0800, Matthew Maurer wrote:
> Doing a little more digging, I've also found that the latest version
> of `pahole` doesn't seem to conflict with LTO in my test builds - it
> seems to successfully filter out the Rust types. Version 1.25 was
> causing the errors that got reported to me and I was able to
> reproduce.

Right, I recall now that this multi-lang mixup of DWARF tags theory came
up in the past and IIRC were fixed by:

commit b98565e7b17ec24daeb0b17f8f403c263dfcbd36
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Oct 1 14:57:25 2024 -0300

    dwarf_loader: Honour --lang_exclude when merging LTO built CUs
    
    When building kernels with clang, thin-LTO, the Rust DWARF tags were
    being added, which causes confusion as there has not been a concerted
    effort to check if what is being generated is useful/valid.
    
    At least the Rust DWARF tags, when converted to BTF, were not causing
    crashes, which is a good signal.
    
    Fix it by passing a 'struct cu' with all fields zeroed except for the
    CU name and its language code. This is enough for the existing filter,
    in pahole (cu__filter) and will also allow us to, in verbose mode, show
    the CU names being filtered.
    
    Reported-by: Tom Stellard <tstellar@redhat.com>
    Cc: Alan Maguire <alan.maguire@oracle.com>
    Cc: Don Zickus <dzickus@redhat.com>
    Cc: Josh Stone <jistone@redhat.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

So there was a mixup, but not in the DWARF data, but in the way pahole
processes LTO built CUs, combining then into one to resolve inter CU tag
references, by not filtering the Rust CUs.

But as the message there mentions, it would be good to process tags that
are valid as BTF while "voiding", i.e. filtering the ones that are not,
I'll try to continue experimenting with it as reported in this thread,
this way we could stop using lang_exclude and have some degree of Rust
BTF support that could maybe be useful to some use cases, who knows.

- Arnaldo


Return-Path: <bpf+bounces-48409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E1A07C65
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D7C188C5DF
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2BA21D5B1;
	Thu,  9 Jan 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJYEzDXd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ACB14D6F9;
	Thu,  9 Jan 2025 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437830; cv=none; b=FepSqzbYFoHh0LPOLFyg1F9W5ezER9VcQNBCWysLJpsG5EnIXDrygOnphKnGfnBE9TbnWRs6MRm+QZd8D3i6+ZaGht0v0gYCazo9sNjXHEu3jN5JgYcij80hcfDnA8nrocRYGS+NeWgIb5vvQrfuXzENA4ELow52L1FOt6HF9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437830; c=relaxed/simple;
	bh=Ehi9a4Uylv/Rj5KQiKGMBxE57StjpnAgHmDUjKo73rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc+Wu37pOlavFhauFkPolv2hEUv9BABaNIMhD3wBwGNwndZocOzslirgHLagg3Q6wgDDeXlT2fFt3rXBVTtd3G4Pz7sElkcoJkgytdavWaHVAjOEVjv/FlJ65Fy95+YZUMNT2FPW1/XKriz5DlfgaMLFuRNRLbbn6vTL1XOO004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJYEzDXd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30225b2586cso19790741fa.0;
        Thu, 09 Jan 2025 07:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736437826; x=1737042626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ehi9a4Uylv/Rj5KQiKGMBxE57StjpnAgHmDUjKo73rY=;
        b=MJYEzDXdY0joSPebhdiQNnQhmCl5z+IuBig8aG0B0LY4sN/USTbbuB/ouvfWZZ3chb
         KBRRO5vAf7zcyDdEYUIy27lWuRMCo5GBCoc2D3N5mgrbZS1g2HUvnZEwhwmSjk8Z60y+
         V80q+Rxbzu7JCbj5H3RfoFHqrUNpdIL3mBeisi+qSPkBcFfDKc+atT1jBO7y+X9Q2qSx
         6zUWvZFrWb24qK5ie8f0iDSMS9zS9W6bVG08/CIhdyY6aW1bio9bk31dUViFkVz9Fsao
         xGU52hB2wGlUep1U0YMf7xoEejTCV/oL7W+XLBxgBmcKxdJ8GzefKcmGcij6BO902L38
         AI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437826; x=1737042626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ehi9a4Uylv/Rj5KQiKGMBxE57StjpnAgHmDUjKo73rY=;
        b=Iu3Ult7e6zFf5/tRbULjJ9QDsEPUQPrVw2CkFcwGBYk+Bi6Y825C+iSxBFJw9cDYpx
         RENQx/aNheMtiQTjASxVrGXMhE/toCUJT4Cycum9Ktx6bVCO5kgJ/f1GPC9d0DpoZRQi
         ogr9bMk5dWZ8EIsfjtlRTibRzChFAvYWXsJ3/gykHnv38jGt1M5T2oe8r5DWwOTfOw5P
         zcUKBdh5pXRwwtI3cAcBi28CX4TkQAzq3PahCx+2qHjjArMtWxmk5zFJd1vXqTCsGw1o
         L8s52eR8GM+hpLAtXZy8roulzlB8TXkK7gpsUwZISBx4JmWEBdi18VVdVsq6HTnhzcIW
         C+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUjZPt9uIQuK0gvOsy18xJL7okGr0/0KGB7D6uzV8qZ3qnzYRhAWZqpkHpQegVrxKAyxGCak3LYsiYt+fGP+RY=@vger.kernel.org, AJvYcCVRGS98KcuzK3JIhkjABh8GiEcpJAeb9Mk8xZqUufda1QFd+JzlyTefdY4N5Ds70vu+PBsvdFEWCehuSAVo@vger.kernel.org, AJvYcCXvXpe887lL2ScMF7wD+59gQjlcdPgAf2sOqodpxiBYPYSdgopFICeN6VahD6xKCLtaR9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoMnUk05HJDAieJOg4pXRqQhS9O5BO2rCbQn2t7hz2iJ4XLcDP
	6fYxccNPTIJi15CGCd9z5JKZDbce7afbLX9sflt6JVDUqYDgTIl+4G0Cc+TekTsijhM9C7h9l7T
	xxMBaXAqjc6PUKhWK1Z5h7GjckN8=
X-Gm-Gg: ASbGnct2wGIMvYmqZdU31+O1OungNmuRlAI9Jbnmj6Qj95qGKuLmLg9j8Er5U/hN4bb
	IQu29vzBrzxVy0m3E2VxiBsjHOo1JcLJyXKDAkIVURJQibQFfkGzFGA==
X-Google-Smtp-Source: AGHT+IFarG2d8/1jQ8Q0zyrkrOLsaozut5AvYC2nOG8QuBld+JIEwhKUaPAKITernxH0wcrSKwHc1lzi75tMfbs72zQ=
X-Received: by 2002:a05:651c:2115:b0:2ff:df01:2b4c with SMTP id
 38308e7fff4ca-305fedba370mr9070591fa.4.1736437825914; Thu, 09 Jan 2025
 07:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
 <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
 <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com> <Z3_vhR_QMaK0Klly@x1>
In-Reply-To: <Z3_vhR_QMaK0Klly@x1>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 9 Jan 2025 10:49:49 -0500
X-Gm-Features: AbW1kvYSSEdIIUxw8mhsL76J6igRsjJNlCMvVxjAVQ7lFupMXPeLlPzxUUY9cYE
Message-ID: <CAJ-ks9k23fKauY6JFt37OEewKPLhwdQaOFz19BKekqUoRhJCkA@mail.gmail.com>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Neal Gompa <neal@gompa.dev>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Matthew Maurer <mmaurer@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthias Maennich <maennich@google.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Curtin <ecurtin@redhat.com>, Martin Reboredo <yakoyoku@gmail.com>, 
	Alessandro Decina <alessandro.d@gmail.com>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Dave Tucker <dave@dtucker.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 10:47=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> I was thinking about it after reading this thread yesterday, i.e. we
> could encode constructs from Rust that can be represented in BTF and
> skip the ones that can't, pruning types that depend on non BTF
> representable types, etc.

Yep, this is what bpf-linker does, along with some other things[0]. I
highly recommend reading the code I linked to avoid re-discovering
these things.

[0] https://github.com/aya-rs/bpf-linker/commit/1007ec7fed03562eb7d08f3e752=
1094a7e698b95


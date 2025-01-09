Return-Path: <bpf+bounces-48400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A2A079D4
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABD8188B776
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DD21C160;
	Thu,  9 Jan 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExiDvwix"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3252040BF;
	Thu,  9 Jan 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434577; cv=none; b=DEWxsF7mCt1WakcQrFeLOwL8E+4tt1yzdpnWCaER4ujef/R3Mim3IHTfRFgjm9I/VM4O8pamfVUIygmU8nzMYwLNjgvZgmq4nJikb+WTI5/ZKkjnRxVQLYNiTx++b+2Y3hT+idUXCgwHmLkkAjtQ4KfMMXkJs1Ht96DXJpgWf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434577; c=relaxed/simple;
	bh=F2kZYPaSxz1k1jqB34UelVJ1sYnqiSDl58XS3bBd7+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APbvbBKEOhcnlcfWazqAgvywT3EXnHanAeXZwXhrnsh4kZoUb/dQKJ8qmz+cq+EfWNN2QBlpByYs5avuqtkpHA7HplvrECOXC7qZ4+ELiU/kyxnC7yfmoGUlWu1q9Oa43QN1xuV8sCsR2tqVbCkA9JDJqLadDORd4sVyQHofK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExiDvwix; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso11068521fa.2;
        Thu, 09 Jan 2025 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736434572; x=1737039372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2kZYPaSxz1k1jqB34UelVJ1sYnqiSDl58XS3bBd7+U=;
        b=ExiDvwixqYqOJ75dyWdq0lH692F0bXg6xl7I2g1001tdGhxRyO7UgAP3p3dBTw338y
         Q2k8k9pH8QzV9RLzSSKyjKTPoFFkagHotbWYqAfD8/d0MLKC9REe2XZCQOc5SRtRO34I
         Uhm8fmzlPABjn4Ql9tOcntkrgNJSEHa/jYu28eljI5820vpvm7LqbMYGG4KphQYFk3Te
         YDCWTEak1kXMLGPjB8H/I5nK2DwxIvWfyym+nQ6xLF3S3t8+irw8kK14sBILs6vfSTHw
         seKHMdCorVRKKNxavyXhJs/ibyVZiZOXhv4g6G//wdERC8KGLhR4AEnsqvKAUDsyB0vv
         M4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434572; x=1737039372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2kZYPaSxz1k1jqB34UelVJ1sYnqiSDl58XS3bBd7+U=;
        b=Wch2yWX3wMx5ZbktnStd3Pjw8ERxxydZ0/yxp2w+FiKcTSHuna7FA9IcZDECrZ3K8B
         4DYyifjA8IdUTe+6jBrwJdwuMPlqAr0E9c1KHBbpULNRWL2QIDoiElsoV1mzwgpvehUR
         HPCI/V55Scuu6mpcDXDYXrzd3cKgzjageKy6kq7g+PlYn4OS863gT9CIfsesvjleR7IS
         pWIqMM6K/oqfe/GTRZabHCnc3+S2Mt+140+HwsSWVtmK09Rtvg00jDF943yuyXo62hRA
         +ZeJw/MKLBSnEqD+TNDw2IAIcwFhAHc1iUs8JDw0Y9Y0xr3UjhIq/p59rBPPWny97ZTG
         1NrA==
X-Forwarded-Encrypted: i=1; AJvYcCV1PRdi7dcMI46q+CAdKMplOw+oT3yttV0nKFBcs9CNANwM+4T88upCSaRMQwNW+N5nT3iDilYqKTQCenQyEro=@vger.kernel.org, AJvYcCV4nFz/9yMnBAPpxUTjdwPtwg9gvm2OqicfKnl2HBkYzih79v3DaLlhQyEL5BtpouQKG1iq99LYvhyj33Qn@vger.kernel.org, AJvYcCVKgY3EVJm2IzCzuQLxJk3YzJMcC3vQIoslbI2BRZe+4+jm13BbJqo2Z0OIgxRBVWkJZZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkfZcGCLtY97hKvZ9N4i2Nx0cnP32VwzcnbSgWuhAGuqhaOEam
	ktBiC8xbXph6F9jbi02GQmYUqq8vsOUdlUdYu7frjvbhiwfYySKJEy7zqMrV6nUWLDAFzpt3ZAn
	T+bdEBkuWTulCo9SPYGB367FHPgM=
X-Gm-Gg: ASbGnctqAV3mYLIDsvbJ2Yw8LSOrrKtKiPVWBkG+QkFLjnp/PL1LmkCf1rnjH05z3Ut
	avIzoKoX2o1Zfwim3VEifvp6xN4jWRo7umo3OJKZSH4n6PXLvi08CIQ==
X-Google-Smtp-Source: AGHT+IHAhqflZHHOPXjXJVXWE5ewocyFnw7vSbWicOxyjTtnANn1rkidEQ9oIxvKMCP6lUEzVBp4Az7RUGhWWOZsGb0=
X-Received: by 2002:a05:651c:1545:b0:300:81c:5679 with SMTP id
 38308e7fff4ca-305f45e82f5mr19348331fa.31.1736434572294; Thu, 09 Jan 2025
 06:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
 <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com> <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
In-Reply-To: <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 9 Jan 2025 09:55:34 -0500
X-Gm-Features: AbW1kvYH9qAppQ2vJi8511WnV39epzb67rQzyKyYR3Ds8tf0WZVCq3Jq54yYwOI
Message-ID: <CAJ-ks9nYSssBsiJCQRkKoXwmAizeH1A91RzGvX6iTJAFJD2YrA@mail.gmail.com>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
To: Alice Ryhl <aliceryhl@google.com>
Cc: Neal Gompa <neal@gompa.dev>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Matthew Maurer <mmaurer@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

Cc: Alessandro Decina <alessandro.d@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>
Cc: Dave Tucker <dave@dtucker.co.uk>

> > > On Thu, Jan 9, 2025 at 12:35=E2=80=AFAM Matthew Maurer <mmaurer@googl=
e.com> wrote:
> > > >
> > > > The kernel cannot currently self-parse BTF containing Rust debug
> > > > information. pahole uses the language of the CU to determine whethe=
r to
> > > > filter out debug information when generating the BTF.

In bpf-linker[0] we implemented "sanitization" to allow Rust DI to
produce functional BTF[1]. This is certainly outside the scope of this
change but: could pahole adopt a similar strategy rather than
employing such coarse heuristics?

[0] https://github.com/aya-rs/bpf-linker
[1] https://github.com/aya-rs/bpf-linker/blob/e4a9267b0fee69ecb2550058d3c8e=
5233f946ebe/src/llvm/di.rs


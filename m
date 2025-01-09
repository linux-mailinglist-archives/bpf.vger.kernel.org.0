Return-Path: <bpf+bounces-48393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E61A078B6
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8339E1887B07
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08D21C168;
	Thu,  9 Jan 2025 14:10:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D9219A86;
	Thu,  9 Jan 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431855; cv=none; b=MUAS9iLGH4sn3DeLFMczW2yN/INMuRnSp52jA5f9bJXdycB7+a3htONfRyMeYeIjitOh7mn8WOiS0mwWK53lhQx/EFn3toNlt6o3BBnjUxY1a7PZJR0ZMK8zXeDdKJQWo7NLymGEvQYafy+iXPPEl5RSN6s6wxffDQ3+LsS7U/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431855; c=relaxed/simple;
	bh=hEJtlxk0cShj4W33jcYxmzhl4RoS+4ZzxPnTzu283mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDx/U5pqevl5AMREfyN0b7rR4Aol2/jzfKgIYM9kGnsJKVMWvvoAevPq6nthviDSy0TqIajlMkP41XOrevJyatQN42oo4AXOt2Bt32O5yNr07lPFvR81lj+XKIEBqlOYJrZrcvR8OXs1x9PRGmMBKJSqFzMK7HKbXiOQFnzKkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaeecbb7309so196874966b.0;
        Thu, 09 Jan 2025 06:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431851; x=1737036651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEJtlxk0cShj4W33jcYxmzhl4RoS+4ZzxPnTzu283mU=;
        b=AQ4ZI4qPapWDyyAqGMIcnbtuxxIQ0TB+i54D19WHLPch3yo98KisO37naLMHKtxhL0
         by1r1d+ysdPlFm/Q+qyxWjcoAFd2Qm7pfxlSorrqF16dj9yionVZgG6rZDXU30wcajds
         vYZMctWqfx2tb4e3okhvh5RKzGT3VL9EpRujVst996vMx+WfCWDHWlcBr68Xf2CuhfWV
         FatnLbCAIcRXhtVVqtFUef7w6nGsuIJU+eeny7tyHS4oOWqOuwY2damrEG52MJoZzRFd
         67LFB0kkRYm2lZVktIq4gi0IVqAOSkavCQ8b5frnG/mUjyiZrAEsyc7V+hmQFvwcOJcj
         NyGA==
X-Forwarded-Encrypted: i=1; AJvYcCUrkkdHn5z4Emd6I7749uDsCD79Bka5Mx8jMc5rIoqkfvnF6ppMQOKiybE0W2yVc9UpKdI=@vger.kernel.org, AJvYcCVerpNAymQPex4a8r2EmSautEfTnb3xzgpd1WAdyr9qiw9AFHESg99iSee4qWGAUb+LkeHgAsOWGjZ4qiwX@vger.kernel.org, AJvYcCW4QBMdivDHCI9Sy3n+otKOxqtbs5SpjFW0UkoeUVYZCpPguUvPiN9wiDkHDpErlvpGMXY0hgQAi4cdrk5Aic0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNFrUDZpwmlKI25cBBHXdZwRLXjsUvdD4RQ+oo/fhPA/ZpSmJ
	u+Kt6APAdkj55q5TwhTXl7GutnrZhz5scaR7OfyybmJo01r9nMGVI+m9xDsJGA4=
X-Gm-Gg: ASbGnctvXYKf+LIGM9OrLruQvcsEfjZD9Sl5skb3B7k8jDKZw8SNsMu4uotHCWyJPd2
	ELJ0NO7cySq+FhZKm4ZOVuwAyApTb7naNBXDLs6q5xLpHFl+fwJPzkgljkwLwiJkE4mk11nHrpP
	MPngAF/EcZImUuoZXmVwh8xdYjo035T0ck+h2oXxUXYqFIxV1R6EJgFyDqbxb+EMO/mvrWo7dL4
	6RrRWbuunCKMyI6tJ6wvVwjNx+29eWtjEyl5slyXOtT/uUzf2RmT3vcclGDn/7tz9EPOYq4473e
	ALWuoIU/Kv8=
X-Google-Smtp-Source: AGHT+IEul33jxi0Z8yy4+wvWWYioJq79gbGbThq+Tu3aTZJgWuepMWF1+NHABp0gyfBzxlmf0hcvyQ==
X-Received: by 2002:a17:907:971e:b0:aa6:18b6:310e with SMTP id a640c23a62f3a-ab2abc93dfbmr512744066b.38.1736431851244;
        Thu, 09 Jan 2025 06:10:51 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95647absm75000166b.118.2025.01.09.06.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 06:10:50 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaeecbb7309so196867566b.0;
        Thu, 09 Jan 2025 06:10:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUv1lpznWW5TCmwLtJ4dYsCIzHmU4aHKET8ZwCyb9HtZo4e2YHf2x/Nm5w3UX1uGheP57MwZUmgAP7lEZv4HWM=@vger.kernel.org, AJvYcCV4jCeBzlAhU6qRJeD/XfLLYsZBUp2QiwOm79uUBm6QSGx36iPa0Pa/Z/tTbgTA3E/vRfY=@vger.kernel.org, AJvYcCVztZ1bjz8caTT7BcqqtejXI0VSCw4opKNq3FHAVxUZVoZ2sDomQpM459SXFKzSuAhfdVtxdvaOZ4VGByG5@vger.kernel.org
X-Received: by 2002:a17:907:3f92:b0:aac:439:10ce with SMTP id
 a640c23a62f3a-ab2ab73e812mr542998066b.27.1736431850207; Thu, 09 Jan 2025
 06:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com> <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
In-Reply-To: <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 9 Jan 2025 09:10:12 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
X-Gm-Features: AbW1kvYKQVgwIEm3Rkr1-n2lgv6HpJpoRuMjqUsCsXCPawWuSZJztOcamHNPMWQ
Message-ID: <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthias Maennich <maennich@google.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Curtin <ecurtin@redhat.com>, Martin Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 8:17=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 9, 2025 at 12:35=E2=80=AFAM Matthew Maurer <mmaurer@google.co=
m> wrote:
> >
> > The kernel cannot currently self-parse BTF containing Rust debug
> > information. pahole uses the language of the CU to determine whether to
> > filter out debug information when generating the BTF. When LTO is
> > enabled, Rust code can cross CU boundaries, resulting in Rust debug
> > information in CUs labeled as C. This results in a system which cannot
> > parse its own BTF.
>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> as well as BPF/BTF, plus others that may be using or were involved
> with the right-hand side of the condition.
>

Do we have cases where something is a mix of C and Rust? I thought all
our Linux Rust code was self-contained?



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


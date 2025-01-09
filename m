Return-Path: <bpf+bounces-48395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EF6A078EA
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA33A17CC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736B219A93;
	Thu,  9 Jan 2025 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGOtzEFH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0766290F
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432151; cv=none; b=kFPLojEZ2FTlmN1x9FngO4YThVyfKc57SUFZ3x642Goe4szWmLfZVnqM7WGsU4BgrzcPUZCyMKBH5hBggtIFRbncWGgZqsRggUnb8jz3ht++OCECinK0CZzI2RXZtgWsiSH9RQ3OA/hMcFWvZTCqT33mCOzQkcGr41hcWF6/0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432151; c=relaxed/simple;
	bh=LLft1eUPbmzVzm9DxwwwdBGZbJXbwq1U0G7K6ODNWrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhMo7U59uEFR4RWVoq+/3fE3K2Yiz2TFnoBGEV4w34uY5f/sg9wJD1WiFpmvZV8toFZHVyAkmRJe82705f6GR081GzgpdT+zalP8Ya+D6Fk7pnZ6AuPVmVakP80HdXNqFCIwUlSYISsUM36WWxwG0ZBKcCh87zveXmjeTV/prJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGOtzEFH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3863703258fso1379442f8f.1
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 06:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736432148; x=1737036948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLft1eUPbmzVzm9DxwwwdBGZbJXbwq1U0G7K6ODNWrQ=;
        b=JGOtzEFHe+w+TawwTFR+NQYVJZF0goG9Q6R4KCWIpVHS+ngFat6OvmQAvyEe9FWHT8
         ZYxoEQ5KjeJ020jNRv3/ik4FaXzwqFaU7PVwf+XYuez91c7PG2SVaubAX5iOKLDfPYOa
         TLJhtjoyzRJr0EnEiUItK3+D9X7435oqutERmi4nKh7Ls4qSN49N4BlPF67DXEJbL2TB
         S5DmMtehycqvglzyPw5xJTPj4ROYOzhFFN/fxhNF10Q0eIS6kwnnyYufRc3WyilzLSiK
         XAUClSkYtCQIxSRDy2fU+a01mhpMP/+rGR7xL53LaObuMBDhrJDTpXZMXcczrD/QaPfD
         er3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432148; x=1737036948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLft1eUPbmzVzm9DxwwwdBGZbJXbwq1U0G7K6ODNWrQ=;
        b=PpEvUIbPXQDn5Qk4KzBfPz0UZJ7IxGdz/K8VR/w//fal6YAnN/Nt8lk5oHDG1HnDhs
         LQrkvuWRsnwW35lURt05yx69GfBOfWq9C1kUnDdmfbc5hCLqH8yu4cvpxArb8QhBo+9k
         YQtfw5syMrKgkHe9cLYo00WnXEBmKJgDVdd5B6xEPq4l6a28bsyDUtE2eEEHemAH7miT
         4sISLrTwWLkB+UkWHXMMQid3QgQNK+V7CcI0UspyMFSIUJBVWFxMIAc/M6lh4dI2Mu7b
         QRcbCvOcGCK8F4pzYVADVO55nB2gmCJ86Z2+yTsgvG3b219dKLLkA93Bk9XN9ubil9n2
         k1ww==
X-Forwarded-Encrypted: i=1; AJvYcCUyFLGivafF6SBrt1f6c7yPFJtekCNBGKsP+hddiLWS1JkaYAe1cxpQ5Y+IHVqJcykT55g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZyj+CA8Uri3WF8JurnTyBRFuzszCcS/vLAJpueQxpe0qIVaV
	8h77dntqROe8P/Sby/rOAel7rRvlovpptCDuErlxslB7FDejzxlASDMakZHfn6CtqK8Rb9AcT7d
	popsLGJ5+m/Firu8EYNrmTqoiHqPuTWfpG4fj
X-Gm-Gg: ASbGncv8U9/XKLub59ejlF4iJ/MP61bjK7HrMtJheJiUpgu4zo3RS6eflxhelAuaY6U
	DHhvSF8vaOUOdBL6rbM6kBU24cO6KgYVr+XH4Img=
X-Google-Smtp-Source: AGHT+IFlvOdJYB06EErB2NbD0FfUk2toPO1KUT52hGvwQmHpJni095lR9RWKiS81QHIv8GNvi0OmjU8gJFbOc1B9uQo=
X-Received: by 2002:a05:6000:4011:b0:386:3d27:b4f0 with SMTP id
 ffacd0b85a97d-38a8b0d324bmr2774359f8f.14.1736432148255; Thu, 09 Jan 2025
 06:15:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
 <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com> <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
In-Reply-To: <CAEg-Je8YdqYFMiUK7enjusTjMhRMWTbL837x7-qQbi4LkcRcLw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 9 Jan 2025 15:15:36 +0100
X-Gm-Features: AbW1kvays3uMKjjV7WuZh67aIxFcLbDxsI8XfGrCrA96aNCY5b-KWW2yqxX6JWA
Message-ID: <CAH5fLghtCure3EjN-hRx9PT=10_E+0MNbjFACT_v+P1StWELPQ@mail.gmail.com>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
To: Neal Gompa <neal@gompa.dev>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Matthew Maurer <mmaurer@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthias Maennich <maennich@google.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Curtin <ecurtin@redhat.com>, Martin Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 3:10=E2=80=AFPM Neal Gompa <neal@gompa.dev> wrote:
>
> On Thu, Jan 9, 2025 at 8:17=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Thu, Jan 9, 2025 at 12:35=E2=80=AFAM Matthew Maurer <mmaurer@google.=
com> wrote:
> > >
> > > The kernel cannot currently self-parse BTF containing Rust debug
> > > information. pahole uses the language of the CU to determine whether =
to
> > > filter out debug information when generating the BTF. When LTO is
> > > enabled, Rust code can cross CU boundaries, resulting in Rust debug
> > > information in CUs labeled as C. This results in a system which canno=
t
> > > parse its own BTF.
> >
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > as well as BPF/BTF, plus others that may be using or were involved
> > with the right-hand side of the condition.
> >
>
> Do we have cases where something is a mix of C and Rust? I thought all
> our Linux Rust code was self-contained?

If LTO is used, then any time that Rust calls C or C calls Rust,
optimizations could move Rust code into a C object file and cause this
boot failure. For example, vsprintf calls the Rust function
rust_fmt_argument when using the %pA format specifier.

Alice


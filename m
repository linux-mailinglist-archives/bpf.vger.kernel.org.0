Return-Path: <bpf+bounces-48388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E92BAA0770B
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89591188B7C9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802F218838;
	Thu,  9 Jan 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz6dG0II"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DCA19D087;
	Thu,  9 Jan 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428669; cv=none; b=VFBiUvqTwLDfw7qfpMprYvgAaGva1BZCAhTV2szBs7VX4UUyVBDoQDNRNMS5F5mwbg47PwdPW8O9iFsFxIIlbJEtdx+GP1POaa1OSzOAfnuywtSrqPY3rtPAOzs3kQe/JFCng0B7wYNrYgN9/su9daCc46IV6y3YqVwj8OACU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428669; c=relaxed/simple;
	bh=6hxu54rMoJydvP7eOpJ5bDn4UMBGR5k/muQ6/dpJmeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9nCzLF0CbxG6of4K+f6vROauJzIv/f8W+HV6g0s5xuIOCSOp/6ahS9fPhQ5+QvGMODxsjn29HrZiTLPmJmQ3HZG/29BrdxORziKz39AjaaUyoLexLPzRfWw8c9XZr5CZ95HmKAEJ7r9suA2GR6+9OrwkmaS7cgs65XWgDhfpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz6dG0II; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef05d0ef18so184046a91.0;
        Thu, 09 Jan 2025 05:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736428668; x=1737033468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hxu54rMoJydvP7eOpJ5bDn4UMBGR5k/muQ6/dpJmeo=;
        b=mz6dG0IIzztP6mIdu1PFmjWI/P5XIU1bVQ3Stz/C9nfg54EI6EncQItTg8Citfp+r+
         ipQ8wJ9cgKS23OqGpzwFEYEf6QM0j3H46qy9v77z55M3dZr0G/ep/nqhhzIsjLjnWy/0
         xP5tlKMlt6V/xZCWrzqA692dPGUbXKInbw0QsXv6qDAWRviSFLDFFbrH0nzFvIrA7pdU
         LyKXfqD5kom5TNvdujWWjEYwaSmvamJFXihrTLEaRRsR0yEUoM25tkbjfufVh06Ey8T7
         MXLJYz9Eonpa4E3oGiphaNGoXCtq1Yk1KOxgOFrJNLYt3ycup6lGKPSqBe8DOtaWxdBX
         CoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428668; x=1737033468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hxu54rMoJydvP7eOpJ5bDn4UMBGR5k/muQ6/dpJmeo=;
        b=veuTF1l1I7dV89c69z429piAeoWAyiaoU9NLqMRFMCURX0NnA2Yi6dNatqrDO8uQX3
         31P0BstBUTVZ3HhwfYBA3IfiyBBRnuQLKnw6VX35KXCOKUX4j6s77EaQeXUpRGDEVpZu
         4XUNvw0jkFr1gia/F/SZe/Rx422btNqRwcCXdkphO6VwuDMc/dA+labRkuTFllAFscQ1
         hPyd/Lt+ZsTw0k0qpkRzDVfcqgpQHMemOGcPqYpLl/Fz6bIwTq3+uyp6CylFq1DVwpWS
         Ku5lfB6FTOLf/ScnNDCs8e6vzmwtJLe000lPd1hwYhLjWiWNRN97BmpBBqkp1uzninx4
         DNEw==
X-Forwarded-Encrypted: i=1; AJvYcCU5vBsGsC587x4M7tsN+R2Ht0TozFIlUWyFLLlnfXfuz4b94nDr1MJOcNfNX9HqKBwUiUXVNySXnQI2s2S1@vger.kernel.org, AJvYcCUtB6Jbg7LQphPJfrOHiGy3YyzcA+OOPy1xSaUl/Znd/gACQrJK7daJGuGBePFCF99lFWoQR7ljU/uxNtrcjX0=@vger.kernel.org, AJvYcCWuV9pffG5Jb+PKPRvQoxGA41SGLkfODsykTP5GIwV1Noe1Hz+0S13NhrYnITFFoQxgNOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgpohOiOdVQ6FZwwLtu74iRbGOdj/jBd+s/+G1Wooqg7ORHJV
	wOHJ9JOsSC197uUuiFBlAkfGuiqTrCiXdATzpH9FMIdWsJKtSd3toVY2BGLZ5LJP7EAaYpLP/42
	dY1VgEBdP55yttk0cV4r3Oi59gqM=
X-Gm-Gg: ASbGncsiDbOtkxpysnNCeZC27kttfQy24k+Gz0BAB+CA7N0P4t0uH/eGAOHweAYcusj
	+icOjlnkF6ly08gleBjYqook4UM/nYSQz4QVA9A==
X-Google-Smtp-Source: AGHT+IHrnVRq5yqGfKs9BZ0KjoNCjkq6JCz9xVb+FTaytJ2+rI30Z37eMeRKFzbOqyqpVQOyXCRoQCUL52ZcSIOqEjo=
X-Received: by 2002:a17:90b:2c8c:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2f548f04e89mr3708553a91.2.1736428667702; Thu, 09 Jan 2025
 05:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
In-Reply-To: <20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 9 Jan 2025 14:17:35 +0100
X-Gm-Features: AbW1kvYf-xHDbBtPkhRDbaeDnsJgur8tHOEjdrqZomYxSX_i0nUbbuyb5_tMTtc
Message-ID: <CANiq72=XD3AfZp=jKNkKLs8PYCBuk2Jm6tbQB2QtbqkieAtm8Q@mail.gmail.com>
Subject: Re: [PATCH] rust: Disallow BTF generation with Rust + LTO
To: Matthew Maurer <mmaurer@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthias Maennich <maennich@google.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Curtin <ecurtin@redhat.com>, Martin Reboredo <yakoyoku@gmail.com>, Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 12:35=E2=80=AFAM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> The kernel cannot currently self-parse BTF containing Rust debug
> information. pahole uses the language of the CU to determine whether to
> filter out debug information when generating the BTF. When LTO is
> enabled, Rust code can cross CU boundaries, resulting in Rust debug
> information in CUs labeled as C. This results in a system which cannot
> parse its own BTF.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>

as well as BPF/BTF, plus others that may be using or were involved
with the right-hand side of the condition.

Thanks!

Cheers,
Miguel


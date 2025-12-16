Return-Path: <bpf+bounces-76731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AABCC4A4F
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E602F302BD18
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DE32ED4D;
	Tue, 16 Dec 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz3zpf4I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326632ED4A
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905801; cv=none; b=iy8zQoR7Ijn5S5TRG+uUQJZSoEGgHpamN/um/+hXI9htwKyiY6lR91m7Q53NhLZIgLtJ+MzAJCCIZqejjQy0/jBG5Ak/7rgcgqVpabiZ8Kl4357UX+w1I2qIvpayKDn1MLpm7bNtxQRPgABMXJhmu5tNYQlvlFffSfHPB1mSM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905801; c=relaxed/simple;
	bh=XXt6mnGqGRjbR2XWyOWXjnp7w6j/5peiZzZEWNdNprU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnTVO3y/Y8LrQX+bXoS1a9I3zQY5+pm8xLePOjZ5bhCxnvIXaovj1ivge0vzztXsLHYkaab06zaWyowyI14B+ogmdx4jckNdu+iitEhPkuGgkvpnJVjMTamm0Uy5LlKD+lbkY7o9fqB+7MM++zuwYVnllsbKAHLfTBDjFeMPYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz3zpf4I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso58628275e9.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765905796; x=1766510596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXt6mnGqGRjbR2XWyOWXjnp7w6j/5peiZzZEWNdNprU=;
        b=Sz3zpf4IhEonprgd8ycjvntrwfGFR826rQcvynu0y+9+HHaYHQ2H5Nn1DgL7I04mpt
         KMSsEo9MmGPhesA1e2Dw088II7lZiJLl3YI3BOcBElk+ZIUDgmgNVlkUhLvqF9XYNDFx
         esMBmerdLPhpEvmx0MlVhJn0jMDViliRRqk3J4ZBeQo1I6FUNxOr0LNfdYu8KLpDK72c
         zjXgGPxhvZpv2BAX0bEQ8fHZg0H4I/nqD4O2u/SmFpUU9vrugq4zmcdgBqN/j/oNoQJg
         CvKvIVn9Z3ZySvSKqjP0uIgaG1rFQnc3a+ZiqS/uCKrZEH0RXO8BZJmK8Mj38K33NHtK
         xbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765905796; x=1766510596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XXt6mnGqGRjbR2XWyOWXjnp7w6j/5peiZzZEWNdNprU=;
        b=w8Fs5INmvAjfhvEdlhdf6VCYpbR/SoTvkBJKWE8RdyKND0wZ0gryC5klzZzBDiq7+o
         /h81UF1VR8kKVZfE/LK/VsuPaD5zNFMrW7AVezk0N6D/IUyE8npGoUGK1D7RTNo+kRe4
         duBxeuhcIb6MSRcSY/JVyHM5SGWxMAgAcNpFD3qx2q/Qeec/BPhZizXeG+C2B00s9Y+0
         3SFUrwrDOBEffNecPh8GMvPkmfHrllNcyce4DS+AwRK6/i8eIbt5ZHIefvxM2Ux9DncE
         CA5MNRHTz1z4KlkMNUCz0cz/2I/7uY99ECtbgJ7zXykRnVxBve1Q+saJRTe/t2RRxOMJ
         Oxvg==
X-Forwarded-Encrypted: i=1; AJvYcCW5E7uAb+DvPSrGK2L7ZxUD4d1OVU6cFSIPUSw86RvZuF+a3S7sCfzTxs1rEBejE51GURY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjmU2fpFk5cW6ovgnDlcpHQcA50nQlSxB79qNt42OUUNV9Agu
	73dBhdC1yt5HeZs/UvtsfI5d+Ukdsv/cTaU+oFUdAiZZNSAKtxGadwhDTzOhuv1jQswBhh4nWif
	mL9qNMlxrJTd2Wwa4dB918dtuphNXV1w=
X-Gm-Gg: AY/fxX7Fgpo3Mv7kWHF683dCZI1uupdYJyELN0QPx4UgxjQRnfnhopvaYcjy9Pe059r
	/gVz+ilEAYrbdAVXzFkxcYcPYz+PFko8+kTc1GsXHGPqseL4ogbF1BEalWi8uKpu6DxXMyCao0M
	4brvkVhuz1pVdrSIRjErsUzE2k6gyAK3uAnWWi6KnbQ6lv0gpxYBz0cKMld5uPA2oWJBYQR7bc7
	WP/5sKlWgMZKdcPIUCaMmTrSDimuOgOKfhKirNoN51TR2Ko1Kb+aUfrsnnkzCS4/BZsT6ve+0vq
	meJydOZYQ7I=
X-Google-Smtp-Source: AGHT+IGzCwcecWiwfRim4rPrz8a6yuJzvwF5bXuJEDTL1Cb3Tknw6j8mnJEfx1PaGhAxy70ldq+bE3dk+w7C/y+p1iQ=
X-Received: by 2002:a05:600c:6994:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-47a8f904080mr140778135e9.17.1765905795586; Tue, 16 Dec 2025
 09:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO3QcbgU-wbyxgeYL87j6adrQP+-FhHXiXdsgKwvKGMzmzeVPA@mail.gmail.com>
In-Reply-To: <CAO3QcbgU-wbyxgeYL87j6adrQP+-FhHXiXdsgKwvKGMzmzeVPA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Dec 2025 09:23:04 -0800
X-Gm-Features: AQt7F2qbpJ3Zz-cLA8rirNmIk0aU8h4OkmkZa11FgM1qDSAWinPZ8VpmzcccQ5k
Message-ID: <CAADnVQJ7Q46VEO9wgZoQvLfuDLtQ2-+bcHOQrJdRmm7=tBU-=A@mail.gmail.com>
Subject: Re: [RFC] Rust implementation of BPF verifier
To: cb m <mcb2720838051@gmail.com>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, ojeda@kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:22=E2=80=AFAM cb m <mcb2720838051@gmail.com> wrot=
e:
>
> Subject: [RFC] Rust implementation of BPF verifier
>
> Dear Rust for Linux and BPF maintainers,
>
> I hope this email finds you well. I am writing to respectfully submit
> an RFC for a Rust implementation of the BPF verifier, and I would be
> very grateful for your feedback and guidance.

Nack.


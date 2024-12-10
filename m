Return-Path: <bpf+bounces-46537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EBA9EB950
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56A9167740
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AE2046AF;
	Tue, 10 Dec 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkhcJGlk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468AF8632B
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855380; cv=none; b=qUAKkRo5uldl2bRUQiYDR94P7u+aMVHKtqxjZKqBi1pMjBigazyu5yGyOrx2vQOLAKdfIgsRoUEsI+ktUvx+M2xG4ObWtAb9qjbyeseM+N3Ax6QqZnviwR101UzE6ERkKzvLpTGIw2B9SmgexZ78fCsyb7rbjGs20cHe5VODj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855380; c=relaxed/simple;
	bh=En6jNUcFhQPY0qXfuyToEgvYhHv3lJj+4krNn2lyoJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FF6pMCmS59uHsmn3/l5x3/k3KOPhGisrlppZ8ROdsOPW+w0yMoD3VDjfGqY3gNq0ZGj3a3hHqXI1w5ZA2hc/UZBjdoOJVjft/Qf0ik2ZBW7bQGqHZKMdHcS+acAOgu3fUDEX/gyCJnrnyCCRTPtrKZ17g3HCUDHRcWm8nPNyNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkhcJGlk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso4323638a91.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 10:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733855378; x=1734460178; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=En6jNUcFhQPY0qXfuyToEgvYhHv3lJj+4krNn2lyoJ4=;
        b=mkhcJGlkiEyYQDEiwMg9ulHCQ33eQ3SeUeVinf8ES4aj4S2FOQRyeSVhBOxOIOZJMW
         0PXip0dT4SI9fL0lz/oIDp5QWVL9kBTtKOrfRkZiBBuNePv/DsrjaApMseo+1Dnl2iLV
         kdR/LgoLpgFeALoqrYt7t9fzRrwIbTkzVyYyGRMjsu7S+YTrS5wwMbkalfmdOf5BR14+
         l6mFpiy7bTCfoT9Tblu1UcH+e1QiYzjzOytHFB0Xjiz1H4pu1wEeYVuhgGof7txFSNyU
         7p60i1xEkGgvE/1leTO/rMCvhkW8/cHv0mPm7C+Rou7lUi2v4dOEUMA+Eu9jLgd9woPa
         PfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855378; x=1734460178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=En6jNUcFhQPY0qXfuyToEgvYhHv3lJj+4krNn2lyoJ4=;
        b=XCs6q+51aeBvIJEHBUzNEymuMPlS/LBZG8aiKd1AoADlOAqC3gYthSOaLH5B6Yr18p
         S/5QRDzwKcpXU/n8xUIrloTy5yZ0K+bKTHl6uXVY2W0VWCEBfBc+3P3x8MLPOT80NNNq
         EEtFIBaYdpxpVjsjPBwFGxuyjCulKIFxT/ghR78iJj4AJ9kRoxRPSkyIXdvDTlRnXSgH
         +GY2lPpyPvVODtvru/VmrZ4I7JVaF3eVtH3CYD1dBgFAfJQKFiiIA5XLShXXCpPyAQgH
         MaiEw0dvzJ1Yocv5ePBb58t6gAEFlH5b1bJIEVyqEGQDg818U369uAhe49HD22F/06gI
         YLIw==
X-Gm-Message-State: AOJu0YwPu3M8Mp8fCOmYqB59ue5XfhO+IHpctxj6ACiDQTcoh8OJ0dUw
	oaso8E9YLKABYAse0yieH9G2b6SzF2E3uKHQRS3zrh+a7y5v2jhC
X-Gm-Gg: ASbGncva12aXDt3EsCTOkRiRnENl8X81snRDfFyv79ns1SBJwYEKt2XLR4JWLJN5xew
	ZiXWlrn85Fszwv0JYcXP5nu4mXj6fmUt9qxuLahxo5VfqaY2hRZhZTGgSOrY3VEjwS1IGohEBEm
	gkCwp4Jw3PtnHS8C/YpKRv4Lp4125EpxZVE6xSfcei3mS7AyOw6fQS9h1XKNJjBI9u8ygYQnQA4
	OB8ZG0PXCYm2420NIYogqnPMyWz/kVw/nn+J1d1B2xsZgwXY48=
X-Google-Smtp-Source: AGHT+IEPurwCAq+GF8naarjlDbMXEieLDuvlpXowLIgQvO0JUro19+bnNZIhGcJ015qxcLjw4wu7PQ==
X-Received: by 2002:a17:90b:51ce:b0:2ee:964e:67ce with SMTP id 98e67ed59e1d1-2f127f55021mr13320a91.3.1733855378376;
        Tue, 10 Dec 2024 10:29:38 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef270080d9sm12111902a91.17.2024.12.10.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:29:37 -0800 (PST)
Message-ID: <82110da58b8ee834798791039155074a9aaba7a0.camel@gmail.com>
Subject: Re: [PATCH bpf v2 7/8] bpf: consider that tail calls invalidate
 packet pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Nick Zavaritsky
	 <mejedi@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 10 Dec 2024 10:29:32 -0800
In-Reply-To: <CAADnVQKBmQrvnEYqqSpUL6xjmccBW9vnyzQKDktd3uvZUyY83A@mail.gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
	 <20241210041100.1898468-8-eddyz87@gmail.com>
	 <EC7AA65F-13D1-4CA2-A575-44DA02332A4E@gmail.com>
	 <CAADnVQKBmQrvnEYqqSpUL6xjmccBW9vnyzQKDktd3uvZUyY83A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 10:23 -0800, Alexei Starovoitov wrote:
> On Tue, Dec 10, 2024 at 2:35=E2=80=AFAM Nick Zavaritsky <mejedi@gmail.com=
> wrote:
> >=20
> >=20
> > > Tail-called programs could execute any of the helpers that invalidate
> > > packet pointers. Hence, conservatively assume that each tail call
> > > invalidates packet pointers.
> >=20
> > Tail calls look like a clear limitation of "auto-infer packet
> > invalidation effect" approach. Correct solution requires propagating
> > effects in the dynamic callee-caller graph, unlikely to ever happen.
> >=20
> > I'm curious if assuming that every call to a global sub program
> > invalidates packet pointers might be an option. Does it break too many
> > programs in the wild?
>=20
> It might. Assuming every global prog changes pkt data is too risky,
> also it would diverge global vs static verification even further,
> which is a bad user experience.

I assume that freplace and tail calls are used much less often than
global calls. If so, I think that some degree of inference, even with
limitations, would be convenient more often than not.

> > From an end-user perspective, the presented solution makes debugging
> > verifier errors harder. An error message doesn't tell which call
> > invalidated pointers. Whether verifier considers a particular sub
> > program as pointer-invalidating is not revealed. I foresee exciting
> > debugging sessions.
>=20
> There is such a risk.

I can do a v4 and add a line in the log each time the packet pointers
are invalidated. Such lines would be presented in verification failure
logs. (Can also print every register/stack slot where packet pointer
is invalidated, but this may be too verbose).

[...]



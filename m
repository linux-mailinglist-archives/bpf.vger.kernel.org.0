Return-Path: <bpf+bounces-64898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA74B184CB
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C507A2ED0
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C499270ED7;
	Fri,  1 Aug 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+4ZHJHK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AD1D7E37;
	Fri,  1 Aug 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061424; cv=none; b=ZUjSOvDFaE8RRXTdEq0FkQsRskZ0aJA4Q90vb0on7JstbEDwbI35LuuR9uNEi+wizo+x4L5WrcJmcWquUv3CUnq1y4QENBGCzmsUeOwz5Y+m912oDO+gR/TU6O1KcgjDnpsdLviL+Ds4itidKC1sjfheLrmAwivA43Avm1wXBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061424; c=relaxed/simple;
	bh=MsPgRvxsTeA8WXRTPFeQLzwhhk5sgNkvZmNvduGJY/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF49XclwDVzwqwLyh207hH2u+H4WgsvMTtqIbj7dbAbnfDZ4xJsLE5oaViZQMJRkHgZd2fFR7dpSqX9yjWpcvxHkL55gzCyOPtJj4ul5swELGzrs9Eb0T4twEWT8NZspuuo2SSvsKnKuoR37OJ2lNitTgmD+LAp/jwKmnvKjYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+4ZHJHK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae35f36da9dso363494366b.0;
        Fri, 01 Aug 2025 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754061421; x=1754666221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/x0ffNYo475efv7vKzA7UPyOtES3df4ghjY5sd6gc0=;
        b=R+4ZHJHKfYYHf9Ic3455x4RkqPQtqIeXjXWz8P+MnXF/SyuFrCCBk9rLqTlTGsEX2K
         vTr7YvXiUJqsrIQgL10WCt8ZVQVLgqj8yLSO3JcK21JF0MQyG2bOnj1SMvZgcOns2EW1
         X/lnNAVZqx8E5gOT/myEgsntByhSRUKN84+/HLx1ND3RsT8eSFJGMmIkGva0EguH+5JJ
         o4A4u+9s/Q10dOjDPh9XlqaaO/IpDGcM5gmQInvCPSWwnyGBrNX0ukKroljDp2pp9FRO
         Eca+YCwlwj1kjADk+xDFBT+Uh5CXwPADtoVue+ClJsjyplb5KmtpgyYt+bVAhznbaHiO
         tuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754061421; x=1754666221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/x0ffNYo475efv7vKzA7UPyOtES3df4ghjY5sd6gc0=;
        b=jNd4yQ8jysCu1T0rvCQvsHUwmbKHVPcRSbr/YEhXJowFcPUARi+xkcfGenh4aEQ1CF
         fEyMX3JFsgqVHFD4vUTRhkrZ5P7nlhvGCGinNQvabbxOV5x0elf/lpuw1mVAzUMvQ7Cq
         FuAyi3C9bq/6u7Mbl5WwvvTHiAjapN2qH4Rk8QgTx9o5KePYE74XDzvPj/q3sseEv4Gd
         +qlREFenDLbAN1y5yeT+zSIFnhkC/6KuyjCpDTcDnXB6MmGTRqNjlu3+i/x4BnlswBwp
         4bnlvs71Vw800QB1wWmqVGpBZ/agiS3yGFCnwACiHgguSk7TlsG0af1kyjNZsYWTjgbd
         hXlw==
X-Forwarded-Encrypted: i=1; AJvYcCVQM2q3qHNWaC7yaqxLz1Z0J5JN0bYEk9M/ayTfsbjIFRzNfGfgs4VDGXmUHw6CKlxV6x8=@vger.kernel.org, AJvYcCVR/mlqm7KzAiQNLMvpUBns5EGlag6gvHxX6TaLi93q3LFmHkTWbxyrTG3sBhybj95XatPW5BLrLm4Y2bzb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PO8/jIkoSTecHQE8bqkRrPRCfhQnxSs+o2NEzlz2lZYOuz8D
	U5cPdgkOlwc+X9QN5jS+YqjBumrUEPeGdUMEvjqsYksbpLZg4J3yfW5Tb3uytJFSJxvha2ezMGU
	8fvV64+tC9IL+wbBaONO3IyfO3t/zhvI=
X-Gm-Gg: ASbGncuC7ttzyNWBneCQ0M6W7jWII9TFohqc9giUFcIC6Bw7G71dsN8VA91IqXtRl5I
	8DNTQR5GVooKAKt75lkqqphO9laBfs96SGvHzxPjudD4YflnR/Wa2H/xyKxNmmKvOzBRVK0ozhE
	Ibq50A1Y+eFMD9bbJ5QDHhfjsXFygjYelKI4FP44ounUdnZ0hwIvlnsDXA+xcrRy/zXAi9Cbc9P
	7aDz6IZuZWTKDLa4EKKIz5mT93dw4J/9x3TuFBrOiT18FI=
X-Google-Smtp-Source: AGHT+IGFOniBjmATFa5PgurgWfkgChIIWQF4xndns27DvuDCapJKWzARsy+Zv8ucWc8WO2SKnbyOoOZEC871jCzRBbY=
X-Received: by 2002:a17:907:97c5:b0:ae3:67c7:54a6 with SMTP id
 a640c23a62f3a-af9401bb6b4mr15306166b.34.1754061420974; Fri, 01 Aug 2025
 08:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a74ec917c2e3bf4d756a5ce2745f0f0a2970805a.camel@gmail.com>
 <20250801114613.610070-1-fossdd@pwned.life> <DBR2SLKGO5OO.276GT83Y3D6DA@pwned.life>
In-Reply-To: <DBR2SLKGO5OO.276GT83Y3D6DA@pwned.life>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Aug 2025 08:16:48 -0700
X-Gm-Features: Ac12FXxqZjxWs6k4GSfDil-aZokpSz36tVU27Eqtg8mMKeKCtpe2poPJpM6wpzc
Message-ID: <CAADnVQKfTgPmuOcGHsQyLdCeVi9hucyQVkfZLeAxDrSbc8_Xmg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: avoid possible use of uninitialized mod_len
To: Achill Gilgenast <fossdd@pwned.life>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 5:05=E2=80=AFAM Achill Gilgenast <fossdd@pwned.life>=
 wrote:
>
> On Fri Aug 1, 2025 at 1:46 PM CEST, Achill Gilgenast wrote:
> > If not fn_name, mod_len does never get initialized which fails now with
> > gcc15 on Alpine Linux edge:
> >
> >       libbpf.c: In function 'find_kernel_btf_id.constprop':
> >       libbpf.c:10100:33: error: 'mod_len' may be used uninitialized [-W=
error=3Dmaybe-uninitialized]
> >       10100 |                 if (mod_name && strncmp(mod->name, mod_na=
me, mod_len) !=3D 0)
> >             |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> >       libbpf.c:10070:21: note: 'mod_len' was declared here
> >       10070 |         int ret, i, mod_len;
> >             |                     ^~~~~~~
> >
> > Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Link: https://lore.kernel.org/bpf/20250729094611.2065713-1-fossdd@pwned=
.life/
>
> Oops, the subject should've been v2. I forgot to pass -v2 to git
> send-email.

No. It was already applied.


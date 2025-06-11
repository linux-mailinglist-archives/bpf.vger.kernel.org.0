Return-Path: <bpf+bounces-60303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90028AD4A8E
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 07:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460F57ABF65
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D422540B;
	Wed, 11 Jun 2025 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrcLCP0n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7DA923
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749621035; cv=none; b=C7o0fugYV+CvplxVKKgngplxbzLZ6u9tKsLFWuCIr+r5+zhX0xt9gcgEgVRFe62XYaCP7ggkkID188kehtyQ7poCjdD95OIhpPKyUja2yIkJX3PPWdtJF7ZWjJ4/+gAuNZg/UgrdhPKyiTw0o4FFowL3uttpGso1chxp7efDyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749621035; c=relaxed/simple;
	bh=pC1uUYlb+eT2t6WXcpSu2bWFTmhbIJm3+IlAvZoLuFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqdVQsEJYkp7CBci/kwUJn9+LdDnk2MXF7KRuk70+c/jWCgGzxzSw8zu8s8GnPHTi+J3YEU8na1TtFHR7ZdpvraQLIAwz7YPHG+h/ikolE6t7sMoZTH1tSZgK5nHHA9Mi8gFYaQelu/UxhiTbiUipflSk4r9wR/+svI+J+N2fdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrcLCP0n; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d09b0a5050so379087785a.3
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749621033; x=1750225833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8nlqemYcPJDdVpVXnHpuHsbpt9784i+pHMTw9FYf5A=;
        b=VrcLCP0nQHrKjhz6nD0kAT1wV2vRjHCyGX+4tomwAmqAgY1K4D/xJNH+g4VFwoZBkQ
         hN+1LtSTZF4RXXfRgRmVSDTS+Yi1H4q2vdGGPEql6knlQmgKy9kchx94xkPwbrJhdVNT
         pphOMQXblTEsPjK8riE851yZ2wSi8A+UyFqyOTR+ZDeFqTYvKLrGK7u3E37ki1lzZ8OY
         0f5Jc11DaDeHmsybE4Sj7UKsBnN/XYA8RS194BKm6JmRXb0FYw7rZDdO9iHHVWlpn2Zy
         wgTVCB4mU2HVHYCYulyfyHS1AFNNfRJEZ/i19TIGwZOvtnC7NT4sv1Wf1eFARtth94Ui
         95+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749621033; x=1750225833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8nlqemYcPJDdVpVXnHpuHsbpt9784i+pHMTw9FYf5A=;
        b=oDmFrwmE5dG8nZTY9+Njb2seCReAUYLl7vUowgMSsFwMWZRXr7ZamrudjOLfBof19/
         UcWkr6lbIPeUn4G1DlwjLd8oszre/a0Tpzkau+3WW7SAQhhaNd710cS82CwCA0XOCPUm
         TZSw5eSoS49ENBpsnjc0BEKuPtYDfSZANlhTem2HcotX7oUyGiEgbUbUfuE5FG2pMTox
         22cQX1ZRDJV3RB0r+iWDA+c8bNEuD+vaASoKlOdaw9MORvegXFcNxzevG/sMp1UKg382
         ruOnBnI8Nasbc8zQ2igTe4L6RjLWAFuTMX37nrN5YnQGFJEt9u+EyhMlVtXtGSfxIg6P
         QncA==
X-Gm-Message-State: AOJu0YyGHgDy+EdHEl9HGPAtlF2O9NuLxLF39HwaXxIxQW3cifSd3ZAQ
	ikeYS0OJ+KxQEgbXoIf/JSM9piNJhqUccg6OhN9VcCV5sUIhW/3QzGZLG70a3aMh/laTekEL1Eb
	63yHwGFXaB92hH/4sSHuictpYOyBvqhE=
X-Gm-Gg: ASbGncv0L14uOsQW4A9pXRvfMZlvteeftSbilxKX46c/lkqzVgKovsAMiHlYsWjhaKC
	HuDPI4GcH5UqN4WI4gP6KmGr7Wx+gWLNewPQeE9/2JX9l86ykrmVVP31nq8uh7sW0XOVyW7ekUZ
	aKutFShWGlaPz1sEZHHhgibi9aeYCBz1hWjBM5oX+f1VVB
X-Google-Smtp-Source: AGHT+IFM24tdHGqwYx2U3wJOo9MOkMaIySH3gKPryKM6iLI6uz60D5dcdJlgv5mIskMESj+sa6WMrG2yd2loWGxz6uQ=
X-Received: by 2002:a05:620a:44c9:b0:7c9:5501:80d2 with SMTP id
 af79cd13be357-7d3a88215f6mr301764585a.15.1749621033170; Tue, 10 Jun 2025
 22:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215221.846484-1-eddyz87@gmail.com> <CALOAHbDPkbhun3KFXpwTuSKGzOx4PcUBhqDriofMgzwCXxR8_A@mail.gmail.com>
 <5381e905bb6f782493866a6cf8aa859f2b1e3170.camel@gmail.com>
In-Reply-To: <5381e905bb6f782493866a6cf8aa859f2b1e3170.camel@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 11 Jun 2025 13:49:56 +0800
X-Gm-Features: AX0GCFuJmCi2x7wIjSiMSJRIm78jeBK3VJzmE6COr25IMM0KjGcZ7k-7QAl5WC8
Message-ID: <CALOAHbD0818aNr2Er2N-Cd1vtNzk+SZiy4ObuECDRhq_KU70gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: more precise cpu_mitigations
 state detection
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 1:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-06-11 at 10:54 +0800, Yafang Shao wrote:
>
> [...]
>
> > > +       config =3D gzopen("/proc/config.gz", "rb");
> >
> > The /proc/config.gz file is not enabled in certain kernel releases.
> > Should we also check "/boot/config-$(uname -r)" as an alternative?
> >
>
> Oh, my... It's a zoo, on Fedora the config location is:
>
>   /usr/lib/modules/$(uname -r)/config
>
> Tbh, I was fixing a problem with tests execution in a specific
> environment. Adding a list of common locations for config is an
> option.

Another option could be aligning with libbpf's approach here [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/t=
ools/lib/bpf/libbpf.c#n2275

--=20
Regards
Yafang


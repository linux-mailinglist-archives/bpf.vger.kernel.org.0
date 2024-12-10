Return-Path: <bpf+bounces-46547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C49EB9BD
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA75282BBB
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF919884C;
	Tue, 10 Dec 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoUq90KP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF31A94D
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857257; cv=none; b=nYdBaBN9Pw7E6BJcKU9vythEMryufGLSNWFvkoLQp7VrjgOwHdJDfT4tAuQnQmL9QV86bDmwC9A2PBFdDFERPsPC92neATUNfDEa/M1/n3U6vPmzmzAZlc4LGm9i0uNJ1m4KM6t4Fdq4xo15KlzVWfojXK3ioAf6Ke3agQT+5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857257; c=relaxed/simple;
	bh=oVP7Z0c0tysDvgqDU9K0XGedcu5pnB5Q5fBiYqDjUQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO7i1wxVdqpY5YW58PVZ/QLyvKKYW9+5UOAcBnINLN3jUyd1H44T5wVOPqKuL2ky7qQcnz6iCXH1EyuZCkh1Y/gtRyjdMKF0qZjpfWOT0BAuJyBROsuYYBQiInO7ytHqy9H5GDfMXfQh1EgY7UO7ly+IhAo3tftihJuYA9VKg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoUq90KP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862f32a33eso1950134f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857254; x=1734462054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVP7Z0c0tysDvgqDU9K0XGedcu5pnB5Q5fBiYqDjUQo=;
        b=DoUq90KPzGxmObyCXqgpMcLMSXaSKHZB3Hc652rm74U3QE38pdnCM3gzLPXWqpLnzC
         pEgNOOszHjdngkXViLhajHM0GiRu2g6i2npFWuxUz/ZXGBGVVd7KZbQnqGLGglxkx0C8
         WlurVIm96uIy/Kgpo9of6IpRY2y9IEacAMDxG88wYeq1dmMw2IBR0rI9aJsuqf/R/4eW
         FsUycatVraEojx1W87zVRqdiSfzEowGcp9tT5DiJDQ+D67DzqFxnR4oPWqNxI46HoPnI
         /8BBTx+gmDvEDaKqVz1slbUEhS8WEURDJqxfs3wEc6a032fSpz46wyHNYtebDLx1CmYa
         pWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857254; x=1734462054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVP7Z0c0tysDvgqDU9K0XGedcu5pnB5Q5fBiYqDjUQo=;
        b=QqSjKZ9I7Fj3bXYx+QsXjRhVqbBVjVrLcBoxSHSHKJ53l0HpQHbvy3aunRYfKXM/72
         eKB3Sx9AaMbU9pTchfz/txKryJNStIPcT4/PDS4QDb8D8SHni7t+hongpwhvdP9QUnyI
         HG8OWi0HShqisEUiaZ4VTJMd69w9YaO3MRyEem+qJRehdKRQhR0w7oXxltFhRZX93mQF
         aWYommKo0fPua24TGFgMUwQj/970XDHEbHGJOERBUb7mxrrM0MP0Z98Twx1ExqD39qWD
         0Ohy9ktVWB+eadA+CIbB7MsPS/pxK8unCfTzMlEaPBadchXV5ymHLwfbmFu+vfkBXrOV
         ARZA==
X-Forwarded-Encrypted: i=1; AJvYcCXncy3hEMCAr3qH49XsiKmxZZ5jEKS8D4LK9O6ptWefMNHQmcaQLrC+Z+m7D4k5oH+KKJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZq1mUVw4IjPp9m+NSz7r9vs5hbrrcIj9Dg+536N/as2o0kW9v
	mD63Tmf9F9TIoxO+yR1SvXVSJANs2clvvJnV/TGaTGt+fK9dnG1Sht4vKdQxPeQ2hJwDNDf2h4u
	yDv4tDOY8v+K6p0hb83VAnfFlN6Y=
X-Gm-Gg: ASbGncvNiMDxPlmXb7wYxcIN/5x/jB/IBOlYH2NtsyT7ziuoJuH9Bh+q9asEM6t1EwU
	fwtv3JAP7ddPjvOm9rrajfqdgQmPlcFnF91kp5jGe6+1JARWetGU=
X-Google-Smtp-Source: AGHT+IHUFLZ10BqZwl7WLdFYCRjMoqM1nR+1/WN6HDAOF9yzVFi8KCWO/11xYkSClmiL0XUmqyFG0x8ZYvlpvxJj3jg=
X-Received: by 2002:a5d:6c68:0:b0:385:f677:8594 with SMTP id
 ffacd0b85a97d-3864cec5625mr140170f8f.43.1733857253979; Tue, 10 Dec 2024
 11:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210041100.1898468-1-eddyz87@gmail.com> <20241210041100.1898468-8-eddyz87@gmail.com>
 <EC7AA65F-13D1-4CA2-A575-44DA02332A4E@gmail.com> <CAADnVQKBmQrvnEYqqSpUL6xjmccBW9vnyzQKDktd3uvZUyY83A@mail.gmail.com>
 <82110da58b8ee834798791039155074a9aaba7a0.camel@gmail.com>
 <CAADnVQ+hsXZirUYJ6Dshn+K6XNJB7LC=cS5ZzHXiMQbot+SJ3w@mail.gmail.com> <7bc3b90bc810df379f9463ebc62210c3819725bd.camel@gmail.com>
In-Reply-To: <7bc3b90bc810df379f9463ebc62210c3819725bd.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 11:00:42 -0800
Message-ID: <CAADnVQJjJRYoMoGTLK5XHYmSy+zyeCcuOKqBNmaJbje1TqE+UA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 7/8] bpf: consider that tail calls invalidate
 packet pointers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:52=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2024-12-10 at 10:31 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > > > > From an end-user perspective, the presented solution makes debugg=
ing
> > > > > verifier errors harder. An error message doesn't tell which call
> > > > > invalidated pointers. Whether verifier considers a particular sub
> > > > > program as pointer-invalidating is not revealed. I foresee exciti=
ng
> > > > > debugging sessions.
> > > >
> > > > There is such a risk.
> > >
> > > I can do a v4 and add a line in the log each time the packet pointers
> > > are invalidated. Such lines would be presented in verification failur=
e
> > > logs. (Can also print every register/stack slot where packet pointer
> > > is invalidated, but this may be too verbose).
> >
> > This is something to consider for bpf-next.
> > For bpf we need a minimal fix. So I applied as-is.
>
> I must admit, I'm not familiar with the way bpf/bpf-next interact.
> Should I wait for certain merges to happen before posting a patch
> to bpf-next?

bpf tree is for fixes only.
We typically send PR every week.
Once it lands in Linus's tree we merge the fixes into bpf-next.
At that time follows up can be send targeting bpf-next.


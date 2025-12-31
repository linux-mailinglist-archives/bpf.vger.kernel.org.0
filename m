Return-Path: <bpf+bounces-77553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A8CEAFAD
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 02:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 792513007645
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6DD1C2324;
	Wed, 31 Dec 2025 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI5mqn5W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EADA41754
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767143501; cv=none; b=RdX7i8DQUVLxi7k1bdSR57Q07Omr6Ry8n9u22hgu9s2nI/NOmV1d9Ar1xKKa9mvHaI94n70BCYpXohhRK1EuC+qIOtONv6nfYFGUEBvpHXin5IjXL79sbbJ6fajkZn28Sy82gx2AQNIiEUb4uc0EioaEPthLJmJXs5wrqt5r4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767143501; c=relaxed/simple;
	bh=2e4Aq9Gqo2HEJHlBOPKJy9xP/fSe3n86ut5ZUNJdI7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W22f/bQl+xY4sTmtmwmF5Cl/HmBJqP13v5gBOwZ+7MMOeRUcRYnJ7jb0WQtkX2t2yWCvijB4rHYaevdRNXyTt9TauzxHO8zXwHBa4GBwyEL2S3Hdkpi52GnanQHcMTFvG4+gnM95WQhw86pKdzr7cB6b4dfqlpqMCwltO4DbtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI5mqn5W; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2e77f519so6163554f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767143498; x=1767748298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd/3/6d4XACZi+LH+qj+CcYlst0ZuEXZGvQkflYdQXg=;
        b=OI5mqn5W/KbUqAJ+X52A6Y5ynFanyycEzWk7lOUc64n4qImWpdcDhCWGNIKHQAQwmk
         xfBhVUqWvOlbRy7xtkrIzFkHlYaTPE8fsaQrY0dmO+gWkVxfEZpnc6zeTyvGQR3pBql3
         1S9d27Vb6e1qPptYvjsDHVLtQBgYcXYGK4kxSR3CJsPzIdQAXCcyKcsa7JPALQ1C5RIB
         ZyGQ4PFnTYqlpNL2KKmcgjPgwPieAXTAPtP32BnRyYMa/8+UC7wHtVf50/vZ5VPMksVe
         uAl+3FRNSxqB4Bf4j5TnKL548CNoTwgjpJJlYETPSSxybT3vWd2nrCy6tt6OjTWLSRGf
         7Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767143498; x=1767748298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fd/3/6d4XACZi+LH+qj+CcYlst0ZuEXZGvQkflYdQXg=;
        b=RUWg9yuJwyfl7sJTACzKJjR1Km4fKZzR5L2sTn8KrrEJofGU8AzWgTBjVxf9EkSbZ1
         2unVgV0vAE6EVwPzdLXpI1MI5RqAQnvuw5C4SpD/5mR+TXDFqlUwdCx1vHVHMuvzyyzN
         RCsf3Sm7G2qGXtf0Vg9k7SjbfEAjmMSY1XIXg4CbVVsTwAmSayhx4OtJ2vZ6EOM3wRjw
         YtBC09CwAqagmFMRpQYPWabOcCsookUM8MY7SeO+0EnR8ZD8s7Rae3J8bZBt9WO239ND
         oj0LkWOgZBypnIvlE6OkEfokF90TiNhkfL+RDL57LLa0AMcQjOoa0/D9VDfyuWU1FOdK
         +qww==
X-Forwarded-Encrypted: i=1; AJvYcCUh4xiP5xTOK1UNGm5U9T+GNCnMH5YB1UhlIhU401VQQ55zRUfC+P10j0qi/MTxxnDNrWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOcVZxGTc7xZRe0fubtifHoprXPx9xacD30OeAnZLJ67ayNwx
	oHq5+ZYdZ6p9PyjYV0uPgm6k43wCMR5ehl9WSYlOgOW1Lv9zqaREGXSfj2Zot+N0DUWpAH1AA4y
	YIX9+9vLPfVBG3UO4Zxxv/F0TEtgCwsE=
X-Gm-Gg: AY/fxX4T/OgZLBYfe94u+pHnDV+OYsnMH2qNF2BJKy7Nwz6WJ5eBbxNaidyr8i9ByM9
	L6J1zZgCx20BovQTeqseE86/Lu+7TyH0ngpnQyCQ8EWpCvvWxw/doTn8KW+VKAdJXu40Jndk3V9
	m7HitoLENRzz3K1UI3iJAkwdQC9Y9mFDmU3tLVgx7OnsbRsmahQl0ilSpjIh8ePjwqhSFlVENyH
	mMytioPDJseQ5Yq9kd4VhPzYuwtlHqf2tfjiOaIv2EmFB0mdaujxLEDjGoS/chUvBWJ+3e49AH6
	lt2sEA6Ytk7ctQlM7Q42hOoTKQuVzyO3adX4hj0=
X-Google-Smtp-Source: AGHT+IHTHcT+TiMhwT6EoniSm9+jquJWZZDxw0XsJW8Ta+O2yBOr9swIrk3e7GAhczMCzAizVhWknwkscDAydzsLZQw=
X-Received: by 2002:a05:6000:420a:b0:431:864:d492 with SMTP id
 ffacd0b85a97d-4324e50600dmr42192378f8f.36.1767143498404; Tue, 30 Dec 2025
 17:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222185813.150505-1-mahe.tardy@gmail.com> <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
 <aUprAOkSFgHyUMfB@gmail.com> <4eec6b7605d007c6f906bf9a4cd95f2423781b0a.camel@gmail.com>
 <CAADnVQLsJeSjwFVE=gcnVzh7HftDqZJM+xByr2cD6TRmTRGLsA@mail.gmail.com>
 <62ba00524aa7afd5e1f76a5a2f4c06899bf2dd64.camel@gmail.com>
 <CAADnVQLDfmLSuvXJFLHM=tOfViSvwPBUyGGZN8OhDP5dRy1_NQ@mail.gmail.com> <95c33c1d3dc961011ce91411ccb0682323d0f407.camel@gmail.com>
In-Reply-To: <95c33c1d3dc961011ce91411ccb0682323d0f407.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Dec 2025 17:11:27 -0800
X-Gm-Features: AQt7F2ozKMWuzO-hGzpTJedCtIj0DfINeAAzK73bOdI-A4fDPHUXStdyIPsPxzk
Message-ID: <CAADnVQLi_qYzqprvTNT+fHp2WgC5uPAHBKAN6Rr6sAhLvRqjoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers print
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mahe Tardy <mahe.tardy@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:44=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> >
> > that will make post processing easier, but print on every miss
> > will greatly increase log_level=3D2 size, right ?
>
> Here are some stats for pyperf180:
>
> | Experiment                                  | Log   | Log  |
> | Kind                                        | Lines | Size |
> |---------------------------------------------+-------+------|
> | Print cache hits, misses and diffing values | 626K  | 88M  |
> | Print cache misses and diffing values       | 618K  | 88M  |
> | Print cache misses                          | 618K  | 87M  |
> | Default level 2 log                         | 577K  | 85M  |

hmm. That's not that much.
Then I don't understand why you said:
"slows down log level 2 output significantly (~5 times)"

If the total output is roughly the same, how come it's 5 times slower??

> By "cache hit", "cache miss", "cache miss and diffing values" I mean
> printing lines like:
>
>   cache hit at (44677): loop=3D0
>   cache miss at (36030): frame=3D0, reg=3D7, spi=3D-1, loop=3D0
>   cache miss at (36030): frame=3D0, reg=3D7, spi=3D-1, loop=3D0 (cur: sca=
lar(id=3D3618)) vs (old: Pscalar(id=3D3258,umin=3D1))
>
> Didn't try printing message at each new state creation.
>
> > and whole new concept of state ids just to make a post processing
> > better. I'm not convinced it's worth doing.
>
> That might be true.
> But we do need some instrument to help debugging 1M instructions situatio=
n.


Return-Path: <bpf+bounces-40283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91279985555
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C34281631
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 08:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBD157487;
	Wed, 25 Sep 2024 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzH/hoWL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683415921D;
	Wed, 25 Sep 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252314; cv=none; b=Du6Sr3CUqfiQ/HVVJstpZskomqB/ppkin0Wh6uYBdeBxqZcK1OcZSYq7KrVTppu+KjHk6ANMYZIf/IOu+A4WPS5wkQnjVbzyxPgBKASvNhQYE/FKLpXgEFDGG+EGh70Mji2WVniBlSanKjM4Oa2YKoRC2266MiZbyYrL1rsvKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252314; c=relaxed/simple;
	bh=1Nk5zw78EsDZtTINVN7tnvRQ3dNjHON4s+1QiENmxCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g292NMZfDJqB5B6qRgfzEkXfc4W6+5H5eqsuy3teRy6CMP42JBybvs7gnsuUcekMB6/PuVGijIjGUx/Nsyd9zUdSLMQamF6/zSDSMnHNbe/NyrsCG/1gK25oIRyWK6AiXgkX9WZDCvcCHam0Se7brmXhCAcEluzizqYKypBJQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzH/hoWL; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75c0b78fbso65026661fa.1;
        Wed, 25 Sep 2024 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727252311; x=1727857111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Nk5zw78EsDZtTINVN7tnvRQ3dNjHON4s+1QiENmxCY=;
        b=ZzH/hoWLKdAOfTG2BO0mbR8C9StQXevObg687JzwjMzcUfnsgYKm9V8ZnzJa1rJEe/
         cA4hnY2wVGuI8b7zsbqR1uDbarMfObEszQ9d/Y3oSgReBkE0PBs8v9GyrUZLadcNLNDW
         XC+pKQrKExWVdkR3hbXBlkUn2kGvna1yvzIkGnss3HAKa6OAbFOq4Tgrz0L8kVxcl5rU
         BxsnQyTq9bDsla0tIhwowb3j+wbugIt3iJB5sDG+bxxK3Fnvu27kfVYcB/owfBVtRsWs
         CSFsTUYoo+gj5ooNyqI+N/veh+8skD4DloUxVwszeZMnl+RqyeZ89l92ePw1Ze6XBzJq
         P+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727252311; x=1727857111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Nk5zw78EsDZtTINVN7tnvRQ3dNjHON4s+1QiENmxCY=;
        b=ofq1r3KxKbtStjAJ4gq7N+1I8fRjes2XIFI+j8kSTbEyYxHzj1lT9oMow91sldAoAn
         9eiFsYYtFaNqsx+Y6ho8ndv1COYcGsMWzKtuDNdF3SxUvJNu6dqsIQ88ESeIx1kniBCB
         ejDudKobluqHUgpIShp+0nr2D3M9mOh1hsoEiV5qjWPds5hdWM4uI2Ej5J6EYaMVVlwm
         vBuL0Uf1L9S1mqFVtNQqf7M3P+3ojIEr1PwojLX++0KFHwISnsQDCVNjT4Cl1tAk+JGJ
         nPTcyCbeBQfD44YKurk5pbydj7FKxDOCQNNvqagOZJZb3UAYUgwgjn7mDAbkTjYvaIJ1
         c1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9AI3qRnI5qgWCN16YWw+fIyMlCsrW4+a3Bl4zohXE1V7NoUxp/eo3q/cEt6nsc2Tagl5ho+zHqg==@vger.kernel.org, AJvYcCVpjyIg3KG2c2qRWON8TT2dJQj/sxTtMxV9qmjr31aNsuaD1sPY52pf2OIA399lAtF9Z1o9Ox1Zk9WsiFUm@vger.kernel.org, AJvYcCWi6oORtXEYeapcUzhGaNae/3F/ps/CFPL8Es7MwUqn20IA21R7HnGSI09gq5JRawPLExk=@vger.kernel.org, AJvYcCXWBcNOSShwr941RlTTg0MVtpLhkfep/RSH1EYPYuq4ZGnKuJND6ZRXJdiwdK1PRZq2cSOFuxp+AtuIf/kh@vger.kernel.org
X-Gm-Message-State: AOJu0YxYW/zGNLMUUjgRyPfOCzhXAkQ+mDXIKPKq8e2+QxjK3uvmrqOD
	Z3J4Zfgu6GVidguCQ0YgGxkvu5B7TAbgnMsBQXPXM/gnCLJNkfowWh41nGZn/t+bXOx7EpfcLag
	1VqHmRrkvIlnkvdlkZqcpdlZaUK0=
X-Google-Smtp-Source: AGHT+IERKtPYc980lSJ1UEXpI+b66aNtrwATZPdGkwcCyH8NhpOU5uComuDPBZkuyJYi/sYF3vfJcZoUfsiZOy7Rjr8=
X-Received: by 2002:a2e:a58c:0:b0:2f7:4ea7:300c with SMTP id
 38308e7fff4ca-2f91600dae6mr11933971fa.27.1727252310822; Wed, 25 Sep 2024
 01:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820085950.200358-1-jirislaby@kernel.org> <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org> <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org> <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1> <CA+icZUVL13oPX8KybWirie5zH77qWuzG9-9yTNM7O1CxwhOp1w@mail.gmail.com>
In-Reply-To: <CA+icZUVL13oPX8KybWirie5zH77qWuzG9-9yTNM7O1CxwhOp1w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 25 Sep 2024 10:17:54 +0200
Message-ID: <CA+icZUUgk3fsmmWTx2ix0HAV=Wagy5AT341SFs2idaCyS2uvtA@mail.gmail.com>
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, msuchanek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:18=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> On Thu, Aug 22, 2024 at 5:24=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>
> > Please let me know if what is in the 'next' branch of:
> >
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> >
> > Works for you, that will be extra motivation to move it to the master
> > branch and cut 1.28.
>
> For pahole version 1.28 - Please, Go Go Go.
>
> -Sedat-
>
> pahole 1.27 segfaults when generating BTF for modules built with LTO #203=
2
> https://github.com/ClangBuiltLinux/linux/issues/2032

Hi Arnaldo,

Any news for pahole version 1.28 release?

Thanks.

Best regards,
-Sedat-


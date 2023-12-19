Return-Path: <bpf+bounces-18255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6A817F71
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 02:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74ED4283E26
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199371842;
	Tue, 19 Dec 2023 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5214tZR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B615B2;
	Tue, 19 Dec 2023 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3364c9ff8e1so2178773f8f.0;
        Mon, 18 Dec 2023 17:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702950523; x=1703555323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUcZ2m0ul+irlSs5Adt5yLn/zwfoJZvejEFHdvTtJCI=;
        b=F5214tZRojA6UGTArOI/8Z36mF9OOv+pAK6abPQuz3ysXTguR+qIX74QfM8kabBv2I
         gp75RkiAepkUs/CdlXhGbDGXF5uxpVeCkTwTsmGFW5XGhnX5PGIkBZICcsS0/QeH54gX
         SLMfL4pN1qBd4joiUlkcOUMSfyd1DHUkZRt7qJuoiPMTKGCXq3RWD+VS+sd0KFa1LaJc
         B6Rqa45UZRYxaggWHzfWJrFBOEDlNHja+cXwJALMqqrau0AsmqV+GTgZFaSy9X5Sz1QG
         1Pk6CAG5AeiJoFJkQDr/+6r4ZOvxQt6P9cQXojm0xReLmAJ90KVS5/pJjauLLVCmylc/
         El1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702950523; x=1703555323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUcZ2m0ul+irlSs5Adt5yLn/zwfoJZvejEFHdvTtJCI=;
        b=gOXNJXQR22FgSRPh1pvKNueThjdfB5W2syg2YV7jLL0wiirP6i1b0xtVrpSQCEOIpa
         DysfAv26pLn0kFPjHky0P4/H90ORhqZ61dAQYzWs2Oop2fMl22wKNqLO/mAMBn/2aH+a
         DWebYXhmHtNvkFUu3dexP6kHNErOpneGbRC08fDOAe1lcC4vW3f3x+Q84NhEfjyuJMDb
         bPtjyMHjuzzPBrgGcX4lGzV0byCTTv+RaHccmTTWuwIyznThEptES358kKw3fSeRysU6
         4irEyNZEUO400vrGgR2qexA35Mqd6VEbBoz3ELTnJAuJVBcW9OQswN/TXKvLKbEyQc01
         gmxg==
X-Gm-Message-State: AOJu0YzXaOBwE1LVjFAgfT6RPZSOh3mvxcG3S2Tq7StqO6DApS4G6VCF
	lIYdokDgtBXPueOj7YndScpUtcJffiyUqbTjK7E=
X-Google-Smtp-Source: AGHT+IGMkU3imH49yQotqeXkTVVTj0Z2hTUqWvzMExHo5kvWSxBGZIVXn+IWyRr3muJZUi5+bsBO51U0BTiTXWnzPzQ=
X-Received: by 2002:adf:a411:0:b0:333:1755:4638 with SMTP id
 d17-20020adfa411000000b0033317554638mr85357wra.11.1702950523229; Mon, 18 Dec
 2023 17:48:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com> <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
In-Reply-To: <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Dec 2023 17:48:32 -0800
Message-ID: <CAADnVQJfyfbpEVHnBy2DDGEJvUm8K25b9NHCzu08Uv96OS8NaA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 5:11=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> I literally see complete garbage like tghis:
>
>         ..
>         __u32 btf_token_fd;
>         ...
>         if (attr->btf_token_fd) {
>                 token =3D bpf_token_get_from_fd(attr->btf_token_fd);
>
> and this is all *new* code that makes that same bogus sh*t-for-brains
> mistake that was wrong the first time.

Point taken.
We can do s/__u32 token_fd/__u64 token/
and waste upper 32-bit as flags that indicate that lower 32-bit is an FD
or
are you ok with __u32 token that is 'fd + 1'.
zero - invalid
one - FD=3D=3D0
two - FD=3D=3D1
?

Naming is hard. 'token_handle' maybe?


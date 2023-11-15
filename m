Return-Path: <bpf+bounces-15080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105257EBAA0
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 01:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB102813CA
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB119D;
	Wed, 15 Nov 2023 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GiYsYDBn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5F625
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 00:36:45 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BCCD9
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 16:36:44 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5b383b4184fso73573067b3.1
        for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 16:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700008603; x=1700613403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIevNFu0KUbpOnxFdIZtIm8Qr94xdqJKRuJSXcWfDnI=;
        b=GiYsYDBnbZJcg3vR66S8+0BJxtZp9z/Slh4JphC6UIgACccPylHI0Cn2cJ0gWqpFGx
         OqFP+XcfjrMMj/CcBSsB7yVpskmHS8+9KBGJdCjK4EvZicUYiHlqSTaC+difjEmPyovO
         LFmsSmd5qYfCCk1xYvu56E7yrXpNptkzDql1OOWa82y4VolVQaTVTi0EUdY/Apx3HXno
         i6ig3IeAUhUAkZZzYdPowT+/QtDH7BNwH0z2+9Df3mwQ2DfNkGdcjf5u4+/gyFasCZhh
         KCxTF4c35O85Ljhf/aX8/7PwdADnWBR0KY+el7RINGmRbHisvxtuPX3B1ME+AWZqHS07
         rAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700008603; x=1700613403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIevNFu0KUbpOnxFdIZtIm8Qr94xdqJKRuJSXcWfDnI=;
        b=bAhPW7LG8v8Mtz+k+z5N8RDprSmhjukk4CrRAcvUcsUx1Y+T5KJwCoYwrILB0FU5hh
         35r5emTM6l04BKTR44nm5UhXwGqurO3vdrXCsYbPUgeerAagHplHbHBkk5zoN61aXZqk
         De2qadobBtG/Qodwz8nVnZDfi7tSFcRindrNvcr8f/Khuo+GOP+A/wK9djka0tTrmQsJ
         eDPrrviPPY+7g3my89sYmW9sYlRQc8IjgSPUnrAoClDj+NIKQqhQarJrt7dcYv21FPFq
         M9S5lHlhGNQaK3YNZ9B7NoWlPl8Oq7lmUIUJWH/keigNL3YvBU8hi+nktK/mLI+Lr0+H
         2ctg==
X-Gm-Message-State: AOJu0YxbeCCL+ZhzB2JQyMwqKx8zZQsGjLTYr2EtgvBW+Zo1LK5i3wym
	+xfsRtH8m3LvPQJkp2hglnNrS4U7YaMpqbCdWtlZ
X-Google-Smtp-Source: AGHT+IHE1hSQfo7fzHFpI5FuO+9eFgNwa7xnRAVut/1YkucrvGMMZKLpFYyO5r9YrEujw78LA4Gm1aFof4buCYXsFDk=
X-Received: by 2002:a25:da86:0:b0:d81:9612:46fe with SMTP id
 n128-20020a25da86000000b00d81961246femr10810780ybf.57.1700008603554; Tue, 14
 Nov 2023 16:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024161432.97029-2-paul@paul-moore.com> <a5650045-164f-4bff-b688-ddbc66dc95c4@canonical.com>
 <CAHC9VhR-5uK=D0r3zDDsHegjiEqEuhsBhBqLTZ7Xm2PPup64oA@mail.gmail.com>
 <CAGudoHEAes9Avq4EKqNCFwKd_AQPhQE4v6Z3LYCZasJqQXKtjA@mail.gmail.com>
 <20231114092903.GA590929@alecto.usersys.redhat.com> <CAGudoHEDXaPTN1icH64Ff9rOJPJmr6ek-nCUhWtzUb0JqbXDzw@mail.gmail.com>
 <CAHC9VhSjJ+ZgScF9f=8Fyovn15tKgaqFdV1qZxp=RWiuZSAdAA@mail.gmail.com> <CAGudoHFGT2QaMGLzePtY23AQk85Uy2uMKDV08n_ep6k-7EE0zQ@mail.gmail.com>
In-Reply-To: <CAGudoHFGT2QaMGLzePtY23AQk85Uy2uMKDV08n_ep6k-7EE0zQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Nov 2023 19:36:32 -0500
Message-ID: <CAHC9VhREsz5A5GvmYRmA9+ZUypjFtc72eJoMOSv_QmBxZMaLFw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: don't take task_lock() in audit_exe_compare()
 code path
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Artem Savkov <asavkov@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	audit@vger.kernel.org, Andreas Steinmetz <anstein99@googlemail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 5:32=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> On 11/14/23, Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Nov 14, 2023 at 5:33=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> >> On 11/14/23, Artem Savkov <asavkov@redhat.com> wrote:
> >> > On Tue, Oct 24, 2023 at 07:59:18PM +0200, Mateusz Guzik wrote:

...

> > I'm going to drop the WARN_ON_ONCE() since there is always a risk of
> > eBPF doing something odd and I don't want to have to keep revisiting
> > this each time to figure out what is at fault.
> >
> > Thanks for reporting this Artem, I'll put together a patch and run it
> > overnight, if everything looks good in the morning I'll post it for
> > review, comment, etc. before sending it up to Linus.
>
> SGTM. Hopefully we can put the matter to rest after that. ;)

I was still online when the test finished, so I've gone ahead and
posted the patch, lore link below:

https://lore.kernel.org/audit/20231115003113.433773-2-paul@paul-moore.com

--=20
paul-moore.com


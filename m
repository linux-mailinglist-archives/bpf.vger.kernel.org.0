Return-Path: <bpf+bounces-16835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23093806332
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 01:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3DA1F21736
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887D365;
	Wed,  6 Dec 2023 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyG/Fih2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CAC18F
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 16:09:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33318b866a0so201662f8f.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 16:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701821339; x=1702426139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U63cnjF4FfQSCR7WvcWQI1rKIKB/p93R/Gvh6D5MjLk=;
        b=iyG/Fih2C9QKtKFaC+cc2Jcp2ncrucS8IFVCG2ftKIxXqxcIxziaFaFxu29QLp/54E
         dl7NCAQNm0MrhB8otbefy2ZXuoqnk87qGXZdFDn3p3R6fCFprWMwr6iHyQHHqSfgep13
         Y7VFWrlBPVlOonlMDVfg8+B2JPckZQNpRtPfACyXqbSwWEKKUFblkJGuvK2ETenDln9V
         fBNK/slkQ0PHLUOpwKSOh2fJWlFcS3GZXaD5enxRkLA/PobvOj81bfa2J0rQbUBOW2yC
         xfBaaDXM8Cb4G+npr665a9aMtPyZDaXsmj7OgPUZ9erbhao17lNr+WH1oO2LnHqCfBE8
         W7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701821339; x=1702426139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U63cnjF4FfQSCR7WvcWQI1rKIKB/p93R/Gvh6D5MjLk=;
        b=sAoFtCyz40UWI6wmy6sVsZtXqC+ui7VAKv4y8QAnSwhCx2I4WoPfjJUlRXwTOXimmq
         W9CXH99NbOQX2UTbqJI3ej9mCxFV6JTZiiY0SUWyAXdSAKQivA4KAOIpgOdDHm7mt432
         FTU39bBsuR8+beW1pxvfTB9aV74NwZMwcfg56QicdBoCZOrgcBUWPTAbD1je7dk2tUWO
         YCdZrVfV6yMIX2SnaAvyABrO3zhe0X2aZbuWyoYzRVXRXitnqUI2sHyGm4OTDUiHnl1D
         I28/du6D18KWlofXjjp9JfekrTkt7Bb6jkCIuIJTPB0upRMJcETaK6A66kIdVvG0Fj58
         SJrg==
X-Gm-Message-State: AOJu0YyJIZRY0kJwlVfdj+LQtmNWvBB5WJxEDjT8XU31x18feLrYHgHI
	N70UcvQetMXJqjQrbEVaHE7v2tGCmvg/JbQiUpbjx6bi
X-Google-Smtp-Source: AGHT+IGR17k7jSAAL0C3/9c5+mVxMpxMH/RSzq0/8pUHnJyftI3MXKdjBtWGHlZJgi9DupMkwTPsar9RVNvFjMq9nTM=
X-Received: by 2002:a5d:510d:0:b0:333:3fc5:dced with SMTP id
 s13-20020a5d510d000000b003333fc5dcedmr3187169wrt.64.1701821338572; Tue, 05
 Dec 2023 16:08:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205193250.260862-1-andreimatei1@gmail.com> <e3787b1d4c2d7a6b02ca6561edad92fbc27cb6ba.camel@gmail.com>
In-Reply-To: <e3787b1d4c2d7a6b02ca6561edad92fbc27cb6ba.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Dec 2023 16:08:47 -0800
Message-ID: <CAADnVQKAT-bP7ozVxKqon5rOE25AuBjSHsU9Tx3v+Ar4nKaF5Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: fix verification of indirect var-off
 stack access
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2023-12-05 at 14:32 -0500, Andrei Matei wrote:
> > V2 to V3:
> >   - simplify checks for max_off (don't call
> >     check_stack_slot_within_bounds for it)
> >   - append a commit to protect against overflow in the addition of the
> >     register and the offset
> >
> > V1 to V2:
> >   - fix max_off calculation for access size =3D 0
> >
> > Andrei Matei (2):
> >   bpf: fix verification of indirect var-off stack access
> >   bpf: guard stack limits against 32bit overflow
> >
> >  kernel/bpf/verifier.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> >
>
> I think we also need a selftest, at-least for patch #1.

Also pls target bpf-next.
It's a fix, but it's getting non obvious.
We only push absolutely necessary fixes to bpf tree.
Everything non trivial goes via bpf-next to prove itself.


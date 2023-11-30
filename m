Return-Path: <bpf+bounces-16336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CCF7FFF8C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 00:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6581C20D53
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E8B59544;
	Thu, 30 Nov 2023 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEaXjOci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF010E2;
	Thu, 30 Nov 2023 15:38:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28655c04da3so220203a91.0;
        Thu, 30 Nov 2023 15:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701387480; x=1701992280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IaoZIB7Z7kQAK1/5zoXIXttzOJ/xPcGhLwSZ0xTRZY=;
        b=BEaXjOcir8ZMgw2KXLoeICZHiwXyN0GubHNHYcj1TBn++qT0KjgSTNyR7WU2/d4frx
         ipfkK3PrUScrG+GLN7Qqyl8UtvISyY3AKc+QfKzi8HDDzuxDlRhKAdHKTPYsVaBCD2Lz
         K7MY6Ykau4Q/8l9rpm0kRYKUVeIhI3pgO5bT4ZeHj7U4EPazr1SbGPupvJjj2+u0B2qB
         9NLppJX/XJUbdHZ4Sd2jixYJ8USZ7+Wz09+zemwe0wobYnSJyq9+x9J1FDHOyQf4hCea
         oKH7jOk2K2IrXklsbdZhamydtOYcbpbfR8LGXHvmgrxutDpNNW+kZGNso35/CPak3he6
         SLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387480; x=1701992280;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5IaoZIB7Z7kQAK1/5zoXIXttzOJ/xPcGhLwSZ0xTRZY=;
        b=QeKPgCk4bYlMvUQvuX6ngawqNqKlYocqBhf3qOicm78s5gT/TSm92C1n6r8XpG1L6i
         tq4pgsq1bAUt/XklEF+r72CsZe5f5s966eWRJ4MNynx6QxtlB/0Gd8oDrB7A9VndWHQc
         RfFpyF6XPVLaQXPSP/WksgtnCAhCqOSdkEKC69pYIP/jCtPCcHkvSQs4Ess2bUoTE06l
         awSlmhv2yrrMeiy3CROEVI3HDDtjpDvh3f8v5w8dqmBspYEe7LaCGryAvDyazY0ZU391
         zycGPhar8/PusKxQLuZnN0bUgLSfhrj5fsE3y9RlYnVOhfivMosip11eNqbYeogeFIDQ
         7Mog==
X-Gm-Message-State: AOJu0Yzo3cUz3FNnjcJwQoOrTYxgXEJdAAGBx/FDkVAobxmBDeLpwkm/
	UmFO/QY+gc/GF+CEypglebc=
X-Google-Smtp-Source: AGHT+IGUJWkE3B8drTvsngAfuobf0hVFiIb9B1cLRKXEUFc8S3RJx1iE8fPoCoRWErSjbw2vV1VrHQ==
X-Received: by 2002:a17:90a:2f63:b0:286:5127:d9ba with SMTP id s90-20020a17090a2f6300b002865127d9bamr2114909pjd.8.1701387480041;
        Thu, 30 Nov 2023 15:38:00 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:1053:7b0:e3cc:7b48])
        by smtp.gmail.com with ESMTPSA id bh20-20020a17090b049400b00274b035246esm2754417pjb.1.2023.11.30.15.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:37:59 -0800 (PST)
Date: Thu, 30 Nov 2023 15:37:58 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 jakub@cloudflare.com
Message-ID: <65691cd64d044_16b8e208a0@john.notmuch>
In-Reply-To: <CANn89iJUwnYGKW3mgCX8_9hFwwBeDXrbsk-XwOtsM2u0J7cyMw@mail.gmail.com>
References: <20231129234916.16128-1-daniel@iogearbox.net>
 <CANn89i+0UuXTYzBD1=zaWmvBKNtyriWQifOhQKF3Y7z4BWZhig@mail.gmail.com>
 <edef4d8b-8682-c23f-31c4-57546be97299@iogearbox.net>
 <6568b03cbceb7_1b8920827@john.notmuch>
 <CANn89iK9VrbRJsF2KoLfArv5Eu5d7Hyq-pSO4hmWuS_PNsM8dQ@mail.gmail.com>
 <CANn89iJUwnYGKW3mgCX8_9hFwwBeDXrbsk-XwOtsM2u0J7cyMw@mail.gmail.com>
Subject: Re: pull-request: bpf 2023-11-30
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Thu, Nov 30, 2023 at 5:04=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >
> =

> > Here is the repro:
> >
> > # See https://goo.gl/kgGztJ for information about syzkaller reproduce=
rs.
> > #{"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_fds":fal=
se}
> > r0 =3D socket(0x1, 0x1, 0x0)
> > r1 =3D bpf$MAP_CREATE(0x0, &(0x7f0000000200)=3D@base=3D{0xf, 0x4, 0x4=
, 0x12}, 0x48)
> > bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000140)=3D{r1, &(0x7f0000000000),
> > &(0x7f0000000100)=3D@tcp6=3Dr0}, 0x20)
> >
> > I will release the syzbot report, and send the patch, thanks.
> =

> Actually I will release the syzbot report, and let you work on a fix,
> perhaps as you pointed out we could be more restrictive.

Thanks, I think just fixing the null ptr deref is probably not enough bec=
ause
that socket could be connected() after that and then we get back to the o=
riginal
issue where we don't hold a ref on the peer sock. I'll just block adding =
non
established af_unix socks to the map and if someone wants to support unco=
nnected
sockets they can add support for it then.=


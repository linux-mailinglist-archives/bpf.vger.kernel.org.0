Return-Path: <bpf+bounces-29546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E66F8C2C09
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 23:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20621C21264
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232413CF93;
	Fri, 10 May 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5y9bjC9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F613C3D6;
	Fri, 10 May 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377499; cv=none; b=kCcQ9+lzoDYpdPcZodpvPfz6GssT1U4qqdqUZWYtfja4pJeWFggmW5vyGXhalzLJIMN9sR+uS8Vkzkp7oYQPphc7t4BRTTaEq9z9Ciqnd2heD6E3rtPPvFi4KaU3zCwhkbxKQkzntGW0ypDoXHSz+PviGx8PKpXVnyDTVG/Zxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377499; c=relaxed/simple;
	bh=P2fZ/qSb+YXFuhNoYHJziqgXayBgqusbgg6aK0y7hzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1B0fDXeCCvLnMsQ38jhMICzkAZk02+zBz2ZrLMYkAWH+x1SahDyT3WBzL7qLaPIs7YW0zKsYLQVFeU6fRAk7BQkJuS49BvWdLE0OYuLzrBW7SQdv3y3yN6DKCEZn6m/M0LcsRKj7Vm7/pVv8F8H2sWQT9iqqq8KKpttqiRqQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5y9bjC9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b239b5fedaso2045943a91.0;
        Fri, 10 May 2024 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715377497; x=1715982297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1eMvr1xvJithWCjNw1S/y3ySXyq+KX8ONsnaVCW8Sk=;
        b=e5y9bjC90qDCg8m8KwgLyTw8W1zz5dCax33nMnBx0vrxvKmpC4SZCO4Z0aoJFSlrDJ
         YBI+pgA8fhxEnFA9SptdyRsQhVBHCGAXAPz0DIXYwZxAD6u8NIdgm7swbV4x55w300Pd
         csp+n/2OKGvaYM09XYnTUYybARtDp0wzjlxhp6qQSfIAcbYg+wENI/wpVeBbVOcMbbft
         mGqkKbO1ipqr60xRh7W40/cEU5Pu3UQ/dwsIP51mV0fPau4z0fFNTKwdYEQDAggYLHwM
         yVICE51I4CZZ0x/erBiQOtevwWHq7RH2+iwHrMNwFaPd8labATKbUIHZE1rYz4QCeIb9
         WHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377497; x=1715982297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1eMvr1xvJithWCjNw1S/y3ySXyq+KX8ONsnaVCW8Sk=;
        b=uRvMnd8aDyIjbuxYwiRmq1dWXO/iBMVjGP7bWtWaZLXvA8cAj6u7hDulLhSn2hXGv4
         GGLODja+fUKNPyfhzfrFIySCoC+K0pS7TMVhViIqoUv1ODy3pMJxc+ByGK6nYx8q1oFT
         grINU1aVoRFBKAKPjGSrjDTRv65hwBFHHu72gF3Kk8tbFZm9yp45Y0GMjZe6qYvsDbzM
         aLNzM591B04xdF7vFCOtI14nKSAyT++G8rGTHeGq88P8IC/3JcMJoj+GUxvcfi9bsMAj
         G0+Fa97epF3y8O7GtycqEpxsfiDE/Y8OFObCJORZATz4ygqfitd8UC7AlUoXEA6QmipD
         46Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWVIs663ATVtoEqmA5baJcZVvNKDzNl8v6TkleU/OtVHJjxTUug3b9uRZFrn+XhKlxVNwsv0CWdEW/PcMe+9kLMlTy025IkMhgOkJOqCCJ+8GhRdyziPF710tcM/8G04dTa
X-Gm-Message-State: AOJu0YzYaaug4XoKKWgvNFatN4I4xh57qZa0bDXE8LL0jPPJ1JHExpoA
	72PSJFGPQhnRkaJ0/7zgC8k3qE9T0qosneL4fLHofN1eGaYcmaHieYSgxGJ3d/HHyU22VCT3N3S
	mvP+j42u06Wm24otDAEW45YSPfLU=
X-Google-Smtp-Source: AGHT+IFJ7nq/hlqu4ITdd/w3LtEh6lw6JROKbX9tTIbC9CWWpUSWqpB+S/LVQ8N2Imq+pDlyN7xzbg2a5GLQ2cqfrhU=
X-Received: by 2002:a17:90a:6286:b0:2b6:2089:e4ec with SMTP id
 98e67ed59e1d1-2b6cc780471mr3713303a91.22.1715377497470; Fri, 10 May 2024
 14:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135514.490467-1-alan.maguire@oracle.com>
 <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com>
 <339b9430-145f-402a-a93c-8440797c98a4@oracle.com> <CAEf4BzY_xwD+7b31VtS4SPh-p+ES4BUDV2um+QGcdD878Onn=Q@mail.gmail.com>
 <CAK7LNATyMpKGK=7SMawHeZFg7MBJa0i5xsvyc+=dOxw9g0RWGA@mail.gmail.com>
In-Reply-To: <CAK7LNATyMpKGK=7SMawHeZFg7MBJa0i5xsvyc+=dOxw9g0RWGA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 May 2024 14:44:45 -0700
Message-ID: <CAEf4BzZrAf9GberDcC+Q3iR375Y2gzpnvGBvihftmK2WWUS3qA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, jolsa@kernel.org, 
	acme@redhat.com, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:30=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, May 10, 2024 at 7:01=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, May 9, 2024 at 1:20=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> > >
> > > On 07/05/2024 17:48, Andrii Nakryiko wrote:
> > > > On Tue, May 7, 2024 at 6:55=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> > > >>
> > > >> The btf_features list can be used for pahole v1.26 and later -
> > > >> it is useful because if a feature is not yet implemented it will
> > > >> not exit with a failure message.  This will allow us to add featur=
e
> > > >> requests to the pahole options without having to check pahole vers=
ions
> > > >> in future; if the version of pahole supports the feature it will b=
e
> > > >> added.
> > > >>
> > > >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > >> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> > > >> ---
> > > >>  scripts/Makefile.btf | 15 +++++++++++++--
> > > >>  1 file changed, 13 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > > >> index 82377e470aed..2d6e5ed9081e 100644
> > > >> --- a/scripts/Makefile.btf
> > > >> +++ b/scripts/Makefile.btf
> > > >> @@ -3,6 +3,8 @@
> > > >>  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> > > >>  pahole-flags-y :=3D
> > > >>
> > > >> +ifeq ($(call test-le, $(pahole-ver), 125),y)
> > > >> +
> > > >>  # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> > > >>  ifeq ($(call test-le, $(pahole-ver), 121),y)
> > > >>  pahole-flags-$(call test-ge, $(pahole-ver), 118)       +=3D --ski=
p_encoding_btf_vars
> > > >> @@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121=
)     +=3D --btf_gen_floats
> > > >>
> > > >>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
> > > >>
> > > >> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lan=
g_exclude=3Drust
> > > >> +ifeq ($(pahole-ver), 125)
> > > >
> > > > it's a bit of a scope creep, but isn't it strange that we don't hav=
e
> > > > test-eq and have to work-around that with more verbose constructs?
> > >
> > > Looking at the history, I _think_ the concern that motivated the nume=
ric
> > > comparison constructs was the shell process fork required for numeric
> > > comparisons. In the equality case, ifeq would work for both strings a=
nd
> > > numeric values. Adding a test-eq (in a similar form to test-ge) would
> > > require a fallback to shell expansion for older Make without intcmp, =
and
> > > that would be slower than using ifeq, if less verbose.
> > >
> > > > Let's do a good service to the community and add test-eq (and maybe
> > > > test-ne while at it, don't know, up to Masahiro)?
> > > >
> > >
> > > Sure, I'm happy to do this if kbuild folks agree. I've cc'ed them; I
> > > neglected to do this in the original patch, apologies about that.
> > >
> >
> > Ok, let's see if Masahiro would like this improvement or not. For now
> > this patch gets us into a nicer place where there are legacy parts and
> > a better --btf_features setup completely separate, so I applied the
> > patch as is to bpf-next. If we decide to do test-eq, we can improve
> > this further separately. Thanks!
>
>
> That is a noise change.
> You did not need to modify the line in the first place.
>

Not sure which specific line you are referring to. But the idea here
is that starting from pahole 1.26 we want to stop to set those
"legacy" arguments (like --skip_encoding_btf_vars, --btf_gen_floats)
and *only* use more usable and forward-compatible --btf_features.

>
> The previous
>
>   pahole-flags-$(call test-ge, $(pahole-ver), 125)
>
> works as-is.
>
>
>
>
> --
> Best Regards
> Masahiro Yamada


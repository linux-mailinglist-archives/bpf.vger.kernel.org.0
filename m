Return-Path: <bpf+bounces-77714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E554CEF454
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 21:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845543091E6C
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D6B315D21;
	Fri,  2 Jan 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt1/Bdye"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9F31AF07
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384208; cv=none; b=r230rmuVCyF8tNqAvIuQKL/b68zdGRiw3j65bFmwIlcPwuscOFrIiaOKY8OHsHj7cwn+nmvXiPueMPvcm06F/BtIye1MHPtCUAbWO5GsLCLjO3zBz9PMdxxnjLtX+Y1YcXH+rXYtLySNwpwzp3eQzuxpO2YJ8srLzny+10+wSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384208; c=relaxed/simple;
	bh=utYT6Qt3B+Srzek1TJoeDcQ3QsbBprgnYIX3cbY9oxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeIO1LK7EV8xuWr2auU4KlsFW7UBqNXbexi/PIQy7ygCYJLTtgsBUTLg9/+X80zocTtfmiV631r0uYFxKctkgcPkpm2rmvQLtQPccX6PMCnG31XHWHavlPvSSHwB9Shgo+FGoHoaKJLEoY4SxskQqrKzx7CauwUn4VsgwzOibG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt1/Bdye; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so16623283a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 12:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767384205; x=1767989005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4WprRmNF2jxg1BsDfte9Xooq63YAqJ3MlQ1lr10+xs=;
        b=Rt1/BdyerbWDiCLme7ZQqaAHPf6rOoH2AtePfc5+JzYsW0nlfRLkqcOdxqTiMj/o1G
         2kvyvNXvrcfyAqAyVQl65p6pyes/haeUkS/xdOYUzWz5bGNmTyXaw9TJtyoqpEzD6TF8
         OG0FRDMM9DXa6rhIcbw7V2K+feoA2LjC40M4otylO8PkM9D6QvO71usQbPDFweeJEaf9
         RSWXwdKjSWXYFdev0A5QeJmqwIJSx3CsDOyKu6yMIFI4kSRNapx33kdHdSxDuSZOE3eb
         v1+D/pYA4c9pB69p6Ovv1zDkRWixS2kJzbsWNOat9rCJGTDZyBfK6h/k1o+ABffzscbo
         rAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767384205; x=1767989005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4WprRmNF2jxg1BsDfte9Xooq63YAqJ3MlQ1lr10+xs=;
        b=gVCvZ7UwtycS2L3TJ1aTlPeYP2B3LQgu3kO94ugjJjBkTSmaiy5wgThKRKneYVESOZ
         NZdWVN0y8o5dLlAKVR0rcWPOVB7Ng1K+ZouVeWV8bDO1UcoWtOHHsrq0rleifIEue30o
         IzAN7GtdTXER4C4BzMcLVLJdrX15uW92inTk9d4IZBYRqf7VS7T6Ouv7LGNZHTdmYdZH
         6JhykuHdAYbDEVPGTMWOq5nLdWj58f4bFJIt0WCFo+UqQsDuIdpjodE27/NdNsR2vxqq
         TdbEzjBuvD2bJhQAUwFXZlcKb3gytsFzEC4NE3P/aMKf1Mjn0k+ElRDjTmUa0c0z8TBf
         PP2A==
X-Gm-Message-State: AOJu0YzFZU2I2j843ucK2X0U1E1aQ1+VOYq7TWtarU4ki8OIo6UAmIe3
	3oPwR1G/bZmpI+wNEip8szG0hj3d1n2+BH79Ft4JAsl/jZ46/8AH2l9C9wilDGh/BHFKUqPB2T9
	Xtl5iqXTnel/62gHMwYy4iTAdAA/s/Rs=
X-Gm-Gg: AY/fxX7ZKxBbsHoAcfw652Vs/xTmnYFaJZvP5s4ZGBmQNAkm5TGX6W4V9BGqvyuGBlp
	CFfMm3yMCqSOSMR/P5AAEYBZWG6oGxY2jhijubQjlpss2c997w9lvSST4ZnECU8mBEpvg3UUA33
	4IG+xCtXXp5gozQZs7PMsG9g+Z1rwFNVPi+pRacOM7NoEHdBK2ul9rKa9Ea0+sdx3r4wc6lonmD
	1ljs0QIBTJ4qLtHY5qzl0TXwL7DGJF86XfaedotdFVmbyLgWe2kSo9Lv1Lig06WjSJWoVNpVjRK
	AWBPtvLujg==
X-Google-Smtp-Source: AGHT+IFp5exqTHgC7afk6ZVCT467XvUqQ1+XrBpwZZnS9DRITs7iFv33eep31jkvZ/aXCDxdemui/Dm+aX2YQHjpjUg=
X-Received: by 2002:aa7:dad6:0:b0:64b:8d7a:71cf with SMTP id
 4fb4d7f45d1cf-64b8ecb2eb3mr29679925a12.26.1767384204901; Fri, 02 Jan 2026
 12:03:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102181333.3033679-1-puranjay@kernel.org> <20260102181333.3033679-3-puranjay@kernel.org>
 <CAADnVQLzApPhFaLR-B-WpNvSz+_YBJTAYAaCs1o53yKHHA6PMw@mail.gmail.com>
In-Reply-To: <CAADnVQLzApPhFaLR-B-WpNvSz+_YBJTAYAaCs1o53yKHHA6PMw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 2 Jan 2026 20:03:10 +0000
X-Gm-Features: AQt7F2q8qGMHgo8ym4vSklKlSkWZ6EppDWgAm9Bjrek0OLZquLo6PBJC7annxrU
Message-ID: <CANk7y0jJgn67=kf-Ons8JcEn1Ek7hDB_RYNoBnRT_xt2dr0E3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: arena: Reintroduce memcg accounting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 7:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 2, 2026 at 10:13=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >                 left->rn_start =3D start;
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c77ab2e32659..12e44f433d72 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -618,7 +618,6 @@ int bpf_map_alloc_pages(const struct bpf_map *map, =
int nid,
> >         int ret =3D 0;
> >         struct mem_cgroup *memcg, *old_memcg;
> >
> > -       bpf_map_memcg_enter(map, &old_memcg, &memcg);
> >         for (i =3D 0; i < nr_pages; i++) {
> >                 pg =3D __bpf_alloc_page(nid);
> >
> > @@ -632,7 +631,6 @@ int bpf_map_alloc_pages(const struct bpf_map *map, =
int nid,
> >                 break;
> >         }
> >
> > -       bpf_map_memcg_exit(old_memcg, memcg);
> >         return ret;
>
> Sigh. See CI complains:
>
> ../kernel/bpf/syscall.c:619:21: warning: unused variable 'memcg'
> [-Wunused-variable]
>   619 |         struct mem_cgroup *memcg, *old_memcg;
>       |                            ^~~~~
> ../kernel/bpf/syscall.c:619:29: warning: unused variable 'old_memcg'
> [-Wunused-variable]
>   619 |         struct mem_cgroup *memcg, *old_memcg;
>       |                                    ^~~~~~~~~
> 2 warnings generated.
> New errors added
>
> pw-bot: cr

Sorry, sent v5 with fix.


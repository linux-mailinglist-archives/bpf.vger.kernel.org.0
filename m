Return-Path: <bpf+bounces-55828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5BA87059
	for <lists+bpf@lfdr.de>; Sun, 13 Apr 2025 03:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59631758CC
	for <lists+bpf@lfdr.de>; Sun, 13 Apr 2025 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D474059;
	Sun, 13 Apr 2025 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd45fcXh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C14438B;
	Sun, 13 Apr 2025 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744507803; cv=none; b=gBGf2ifQOirB7siLgbXP6jtE7sU5i3vF0MWemmdhgMcWggiZ/R3TwppVHV9ojkaQL1k+bpioyWxICFpytdNTI9yGsxwwQgTyWM4gULBJRfEMK3+WSqtG4P/xy+9w/cowP2L2kBv23Bt6sLHZQwY+9yFpcFQH05ZSN1oCHOjF5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744507803; c=relaxed/simple;
	bh=5fNOBcVjfYFLDZl5pf99fl0h33tY1w76IiR3dq4rbGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tl3gIOZZ4swOk9VINzQyl0EOJbkaJDhmkL1DBKfJarC9mOGgLqKjQyAHEeDsOaN+wK8syRE6QQe9B9g26wcJhw9cpUioVLjd3r9Xc9f+TQYU6VJxWHEbrD9MGu/+pBtwwD0NSwfFpEFbdrC/5r64CgVeozXl4p1G6LdeFtJJQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd45fcXh; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6feb229b716so32306717b3.3;
        Sat, 12 Apr 2025 18:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744507801; x=1745112601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDGOK2rvZtMRdI3871C6jFgU1x4ph9W3mi1bLdqpRSc=;
        b=Sd45fcXhSKGbY0oVtV6iACfDNNNeRzaRE+xo/d3lZ7BrGd19/sS6LO3W5j4yDEAdZC
         6dvg390ToJDAumzrs4BV84GYxLs4W/muux0u1rOs1O2doVBB54FmvX+ZAgVTsfBwg6GK
         l23XxnRlRwnfbUfJZx3PDeovdDAO4sxCf5P9M5EQA3YakbXdBjOjupJsNXizWly6zuti
         ZyYKslCRdaA6ofDz0B5KqBifwNswf5Hr4Y7Xhu/NalZLuTxfG4pSIzeqMFgyqWNZFyqv
         NRzh2r4evI9pkGq5VrHWOXeFc2N5KOH7D8qjtkscV5hNz2buDCBSX4yvdgmW3Ql6LfUd
         5iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744507801; x=1745112601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDGOK2rvZtMRdI3871C6jFgU1x4ph9W3mi1bLdqpRSc=;
        b=GeuA98fGtUoS/OjwynUl+R760kUvGwbxOMdlgpkPAaCx9qsbEj6ydSTyBVwfTW91GW
         4Ge66Ajm7+G5o4O5ZUCJRdhC/3+nmvXVcyH0HbhXcsjL3TNmNp0vOsu9LwESWjnrJi59
         lYDnQShaz7hfQay0oNO6ydaelLafb7Fi1wTV2kpLFnAbHyv5uY1mtAu5cVXLugE/zzjT
         OQ5ccpdCfbORVW3vw8Aa6OMczc2CTlz2mCmTnfrA0ZXTWSxbeYOFOJelTAatav/q5bGk
         14a1jZBQlRGlQNV3E7GskuJ9LnLsR7qBlYPHo7kB9yFwvBIUuNslG+ji0pFgrTyoai4R
         tj+A==
X-Forwarded-Encrypted: i=1; AJvYcCUSEeSpUGhJZbSzmwF21iO5unCG7TwrY26VSPSKRadc3XjOS4ocCTW8rWMK9uhmS59IQ9UV//UTGi18EFfO@vger.kernel.org, AJvYcCWa9aqXUdc/SqPeenXrPfxb1mfc1fZXTgTc4zL9UGpOKE1SUZVztAUYgJjPOIGIZFqDQgU=@vger.kernel.org, AJvYcCXkyjdRJp3+HdLRBOqhMMJHtyfSPB0or6oPrSDXREuMeE1vYnaxlvjhhabU3kNUM0ab4nP6g55Ynm1Aq5KNWom0bBoy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7TDLy6Q+v91/ALvtCUHGTdGCQ9tpzwG4NUNG2EzVbAqtwWkl
	KYpqLSjH6/ISCEprxmo2MnhvSuADHCBi2OR/aNL2dm+ixh5sGAkB7mS+Jvi8ie6AEjvf2+sO/Ch
	qWe6bo/XwYBhu7kUHu8TTzCrSwZM=
X-Gm-Gg: ASbGncu8jxV2dVYD3WyDKMPgxm+X5CCvpNY0prb50cQQkxxlBbPvXe0bzczU18TaM4A
	LmGAZtSOTxumqcjjDR8AwASF4AzIHIJexGtUDRIA+n5wIcP+iIVgZsEo/ySSKfCFykz73WTwGC2
	bSRmG9p5xN5dKaippe7+i4hw==
X-Google-Smtp-Source: AGHT+IGXxOte3NMOaVe/HO0xCxf0esswZS/+knV1xXymAlSzxRKLH1oK0PB3X5bFm3GPZClwZgzo99jac4upt0n+D4A=
X-Received: by 2002:a05:690c:6a0a:b0:6f7:ae31:fdf with SMTP id
 00721157ae682-705599c93a0mr133264767b3.12.1744507801003; Sat, 12 Apr 2025
 18:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412133348.92718-1-dongml2@chinatelecom.cn>
 <20250412100939.7f8dbbb7@batman.local.home> <CADxym3bAy4aV=UJU9ge0vw055C2DzC=zubjhOBSay_88CkW+hQ@mail.gmail.com>
 <CADxym3bAXpqC3awWBTm+zc4Wn348=7cYVCN_+em=b5qPimUTYQ@mail.gmail.com> <20250412104518.2b4598d3@batman.local.home>
In-Reply-To: <20250412104518.2b4598d3@batman.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 13 Apr 2025 09:32:01 +0800
X-Gm-Features: ATxdqUHA8BWvLt6A3aq8c30EViPQk7776ZFKMdg2rBc1AeXyB5SRGv8Hfl_bhlc
Message-ID: <CADxym3Zzqw3SNP8Ef7pvTJLzOvt+PUvKguaAB2qRiaWM3GN8aQ@mail.gmail.com>
Subject: Re: [PATCH bpf] ftrace: fix incorrect hash size in register_ftrace_direct()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 10:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Sat, 12 Apr 2025 22:36:56 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > > Yeah, this seems to make more sense. And I'll send a V2
> > > later.
> > >
> > > BTW, Should we still keep the "size =3D min(size, 32)" logic
> >
> > Oops, I mean "size =3D  max(size, 32); size =3D fls(size);" here :/
> >
> > > to avoid the hash bits being too small, just like the origin
> > > logic in "dup_hash"?
> > >
>
> If you have 5 functions, why do you need more that 5 buckets?
>
>         size =3D 5;
>         size =3D max(5, 32); // size =3D 32
>         size =3D fls(size); // size =3D 5
>         alloc_ftrace_hash(size);
>
>                 size =3D 1 << size; // size =3D 32
>                 hash->buckets =3D kcalloc(size, ...);
>
> Now you have 32 buckets for 5 functions. Why waste the memory?
>
> If you add more functions, the hash bucket size will get updated.

Yeah, I see. The hash bucket will be reallocated when we
add more functions to the direct_funtions, so it is not
necessary to make the budget size large here.

Thanks!
Menglong Dong

>
> -- Steve


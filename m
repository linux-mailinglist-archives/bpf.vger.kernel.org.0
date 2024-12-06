Return-Path: <bpf+bounces-46295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5769E77AF
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3FF16D169
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90384197A7C;
	Fri,  6 Dec 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj7Js3F9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB322068F
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507222; cv=none; b=Atp3/CSbeaGp9+3HDdynq2I/Pua26xB8dKJTQDKqALg5mZt8Nh5reNUzYbcBh4ZjqG+892FqU8u1Py0P/AgX8JC3tL04XuSXoGJg8dNEKqxu1KpH6IqClbTOmAvJk5P/GOSHvzJse3559dvDaeVIjfCfQ7zBMrC1O1lZmgGY10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507222; c=relaxed/simple;
	bh=1ItHI7nZhg5DcxFxAOxLJ81BjK9yCdQOZCkFcx4kCqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqv4OT02LV+R7MpwjruOXssf2/LIj6zTa9xbOfE7C4OehjuFQKRgtHymOTVPHXU3jwK1nqEt0JfHSDvNtNjTnJprmoMDl5e8QE+ITmEOq5Ue2269GWQTwQM0cWIoLtAjz0Zo3G+LENAmeyJkUq/1QttHgkRvDIDk26S7XYLYaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj7Js3F9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc93152edcso2054700a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733507220; x=1734112020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ItHI7nZhg5DcxFxAOxLJ81BjK9yCdQOZCkFcx4kCqk=;
        b=Pj7Js3F9sNkTePvQR6g6qCppKRv1zuTscybgH96OQxYf9WXzC6MgzEKc6vXiOmG98u
         tjZt3z9iRIngfOgkv8ADZaYSexDONyCEGUNSeqs2T92Rjax/VA4qcAqORNUazZE/Ft1b
         WovuYWkSZ7ynygUGOgoVhSxiXR2AumFSCplaCUsCr/b7W1ApuJ2XMb0x1B6Ss/Ji+LUw
         zeAqfv6a2QQBA8VAgubJsIqG31q0emzYL0XF2Mt0LAelhkzWA7GBHeFMtzqyPg+LBak1
         lNN/aLqio4lT9Cgrt7UbhPfY945IS6tME3jccXPBs4WE4zaUrxeauerALBeuZ8foAlPc
         tBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507220; x=1734112020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ItHI7nZhg5DcxFxAOxLJ81BjK9yCdQOZCkFcx4kCqk=;
        b=V2Q/WOFCywdeRs74UtfvRRZOYbvTdgu4+CzwLrc3sDhAdMi4nUSxmSAHuw+Q9RaZbB
         y0H+Ne4Jx47BZBgcUwMcGCOSNA/0mO5rvuRmTap7eDPhoFCianetxuFYlmYxPFYeUbGs
         LBUNjBCeKge99Kly1l/LIY41x2tMdbOnCbXym5raDEF8whG/q6KgAkKKuVxjGxsBxc8N
         BLJLqEFJ2LT+VGNipPU3FiFzB9Pl57gZHNI0Dy37q+AurmDX81dX4CTgqzP4WmT7GkPx
         Cf3w3p1DqxFvOdZL01tSGnBoY0/XTXnkwou1u7FUiE2F+4XWeQF4ODo6d2RApy5Gq2Na
         msXA==
X-Forwarded-Encrypted: i=1; AJvYcCVgWnO/pWcos1e6Jhivmu9Uj2W/yx3pxg/PXHbUOaN6BGw/QZKYy/ewNns3H3eUDEj4k2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJH0EgvTz+dbJpiP+gG27sLlNAkXtxp2F9XNTsaI8hXNJ0/Ws
	rivD8UlkGVkbmBSMfJrHFlNfUNcqJ3tSozBKobhCpFzMm0LNfb4F0+/0SL0XJm0M3IfgW2siCnS
	3hGJG7Z8rEpB4FPFdmMcEmUIwGZ0Yqw==
X-Gm-Gg: ASbGncuLuAwgoFd8FoQSe/v4aYpX7p7hFtoHi6KQ4KJxdLhs1PUCV6/TTMZ5ZT2Xqkg
	v0IJa4djRGvptFqkrZgshVEzHyo0AbxVuvlXZBwTa3WlTOsg=
X-Google-Smtp-Source: AGHT+IFzxoz33qjw1E8mXGjreC8+rge8edQHDQSZTXF1MZW6Wk1AeqXUWOjdkzwaPOuWE2MWpWRv+wariV/TMuJNSwQ=
X-Received: by 2002:a17:90b:4b82:b0:2ee:7c22:6e7c with SMTP id
 98e67ed59e1d1-2ef41c73dffmr13291226a91.13.1733507220038; Fri, 06 Dec 2024
 09:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <1f49e00de4e5a17740e4e04ddb77b60e5ff46526.camel@gmail.com>
 <CAEf4BzZ1239ec_J33jZj3Ji6-6W_PspVeKu05L6S729-_g6GMw@mail.gmail.com> <17abfd2c6dfc74fa4c1c2a45bf0c7b793963d5a1.camel@gmail.com>
In-Reply-To: <17abfd2c6dfc74fa4c1c2a45bf0c7b793963d5a1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 09:46:47 -0800
Message-ID: <CAEf4BzZJOxnm7z6QaxRr9PsfD_DTV5nSPP9TjiEMQxNMxzLFRA@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-12-06 at 08:08 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > The tags would be that generalizable side effect declaration approach,
> > so seems worth it to set a uniform approach.
> >
> > > Please take a look at the patch, the change for check_cfg() is 32 lin=
es.
> >
> > I did, actually. And I already explained what I don't like about it:
> > eagerness. check_cfg() is not the right place for this, if we want to
> > support dead code elimination and BPF CO-RE-based feature gating.
> > Which your patches clearly violate, so I don't like them, sorry.
> >
> > We made this eagerness mistake with global subprogs verification
> > previously, and had to switch it to lazy on-demand global subprog
> > validation. I think we should preserve this lazy approach going
> > forward.
>
> In this context tags have same detection power as current changes for che=
ck_cfg(),

You keep ignoring the eagerness issue. I can't decide whether you
think *it makes no difference* (I disagree, but whatever), or you *see
no difference* (in which case let me know and I can explain with some
simple example).

> it is not possible to remove tag using dead code elimination.

That's not the point of the tag to be dynamically adjustable. It's the
opposite. It's something that the user declares upfront, and this is
being enforced by the verifier (to prevent user errors, for example).
If the user wants to have a "dynamic tag", they can have two global
subprogs, one with and one without the tag, and pick which one should
be called through, e.g., .rodata feature flag variable. I.e., make
this decision outside of global subprog itself.

> So I really don't see any advantages in the context of this particular is=
sue.

See also my reply to Alexei, and keep in mind freplace scenario, as
one of the things your approach can't support.

>
> [...]
>


Return-Path: <bpf+bounces-27350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367348AC30B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 05:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398951C20A46
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 03:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2597AFBFC;
	Mon, 22 Apr 2024 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0g4WYsT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3F2579;
	Mon, 22 Apr 2024 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756737; cv=none; b=BP5WOifLEBN5V0LXsicizJi+d/jbqO31hdrSF2jAR8zRbtyb4WrL1ckmt+h5ZtSci2jkFVHJ7DVnFMfQRFJcifB/Y3lTHMkXRHnVzdujpNbOj5muAZBHSg+WHTpNANh5uquoV3TnUuWGVSXucrOJUUsthKag6VHy6Q3DSEcTyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756737; c=relaxed/simple;
	bh=8ZxelrFYDpIWsgv+hfq9Z0QBnO4jg4SnHI12pHxjFZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMYjilUqHQl/+89fCPM76CDrBdSL0VrO6Xza1/7UpYZdeCfMH9vQMb5fcXJKLFOeZBbdpjerZfs2Sa4TbCQhDMgtZ3vA9J/9dLvm+SqQu9iIGRp9l2OECI6M6Ewfu5AKBid62k4qzFW3CPW+czWkYLmg9YCgD73oVuysp8h4YNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0g4WYsT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2794150a12.1;
        Sun, 21 Apr 2024 20:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713756735; x=1714361535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/ZJL1pTmzEwFyLqE8i5v/vS2NbXGhujrhuWi0OmhOc=;
        b=N0g4WYsTdpDfXjuiDqQo/orzBSZ26QmyasdXvRn91F5Y5QiEZ1v1WYsfQ0ZFEj0E0M
         zUkTrlkUuhWCsxVUZx+cZh+AZb7mE9fXy97xJ8O32C/Emk7eAieKiLRXlJT9+XsheZzx
         yn74aSf8Z/J2lFzAp4/HEKf0g6igeXCR5NdJw86PJ4OXkm6I0pOxd1QwBuw2P+PR230T
         J9a/MnPTQ/JBD/A/LoDUYfiDmuDKbl4IIb3TTXkq9muCAF7R+Na/Zr3anNxgWka6tI1b
         P3Ics0ZNJCZYY2XWUZ/OrLsjW/4mdve03Vou7YbPbRRvVQ9jKBxfO/zDMisd+OSvdNOZ
         UJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713756735; x=1714361535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/ZJL1pTmzEwFyLqE8i5v/vS2NbXGhujrhuWi0OmhOc=;
        b=aUhmci8XZ/zDay8e6FjIyKThsxzZDaUhPwZWc3AtUxHZjqF+8+Y4Sh7qazQ/855vEH
         yOXjyLEy9tb8Z1f/N+LtWzdUZza3F8xDatVPkbNk8EcrAvRSX1X3GZOnZ5NmU7JD+LP0
         HJxfDpti5UxaXMH28swqve4JVmh10bp1xcPsCgkco3TlguUvL/N7biwdFAdtaEBe+yLU
         bnb0PDesrPUtmGqlEdx6RyWjSbZ9SYqJK8LNWPcC3cjMJaUp7PrOqoOK+73h0tXUgTGE
         Mi6wzBoaGbLjqLYOCJISqGnYWUBHFIZpX21jHPEdRXVs6dTwFuHmeI8x8Axkr1g+is3n
         21pA==
X-Forwarded-Encrypted: i=1; AJvYcCVBytpF5xSNM9qsRM/L+IMAsZ0PmhlCs3PpCnJCYYjqEfDqkJIxGwtETOjYVzCf/OVm8aeaoU0E4qrV6f7taDdxQX3REWRKH34UJ1QybWfnGeTDdg/0YPwQMMl2oWhg170A92b8EL5EpojfW5FkCa5c2b2BHwThreyFypozbmAUxaBpnEo9iUYf0jeFCLaYHSgfZ6O2
X-Gm-Message-State: AOJu0YzEI1gJwK0PaFikDs70iJiV2VxA+JO+iUbg9kxjPlX/JftvU5wG
	vrR1oeBQr9+jiufgnLmx3eTJkHax92G+MDLALah7B65C7To8orI4cxsSMd+MT98l7GXykaXzwm2
	alcSzs95hgxbDda3HBugEpTf38sQ=
X-Google-Smtp-Source: AGHT+IEPRvtxI6/g1huUDW70lpXzs8IjQOSCtUsfVTl265mSKB6kl1T3yNXxP4qPGJnDIw87Ykgbrpi4qjFfagWlu/c=
X-Received: by 2002:a05:6a21:191:b0:1a7:5fe0:1c99 with SMTP id
 le17-20020a056a21019100b001a75fe01c99mr10040642pzb.46.1713756735513; Sun, 21
 Apr 2024 20:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420104801.94701-1-usiegl00@gmail.com> <171374175513.12877.8993642908082014881@noble.neil.brown.name>
In-Reply-To: <171374175513.12877.8993642908082014881@noble.neil.brown.name>
From: Lex Siegel <usiegl00@gmail.com>
Date: Mon, 22 Apr 2024 12:32:04 +0900
Message-ID: <CAHCWhjScokCi7u_98-i6E_xHaSJnFGY6dnkv9-C5-yrpihVJFg@mail.gmail.com>
Subject: Re: [PATCH] xprtsock: Fix a loop in xs_tcp_setup_socket()
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Better still would be for kernel_connect() to return a more normal error
> code - not EPERM.  If that cannot be achieved, then I think it would be
> best for the sunrpc code to map EPERM to something else at the place
> where kernel_connect() is called - catch it early.

The question is whether a permission error, EPERM, should cause a retry or
return. Currently xs_tcp_setup_socket() is retrying. For the retry to clear=
,
the connect call will have to not return a permission error to halt the ret=
ry
attempts.

This is a default behavior because EPERM is not an explicit case of the swi=
tch
statement. Because bpf appropriately uses EPERM to show that the kernel_con=
nect
was not permitted, it highlights the return handling for this case is missi=
ng.
It is unlikely that retry was ever the intended result.

Upstream, the bpf that caused this is at:
https://github.com/cilium/cilium/blob/v1.15/bpf/bpf_sock.c#L336

This cilium bpf code has two return statuses, EPERM and ENXIO, that fall
through to the default case of retrying. Here, cilium expects both of these
statuses to indicate the connect failed. A retry is not the intended result=
.

Handling this case without a retry aligns this code with the udp behavior. =
This
precedence for passing EPERM back up the stack was set in 3dedbb5ca10ef.

I will amend my patch to include an explicit case for ENXIO as well, as thi=
s is
also in cilium's bpf and will cause the same bug to occur.


On Mon, Apr 22, 2024 at 8:22=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Sat, 20 Apr 2024, Lex Siegel wrote:
> > When using a bpf on kernel_connect(), the call can return -EPERM.
> > This causes xs_tcp_setup_socket() to loop forever, filling up the
> > syslog and causing the kernel to freeze up.
> >
> > Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> > ---
> >  net/sunrpc/xprtsock.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > index bb9b747d58a1..47b254806a08 100644
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -2446,6 +2446,8 @@ static void xs_tcp_setup_socket(struct work_struc=
t *work)
> >               /* Happens, for instance, if the user specified a link
> >                * local IPv6 address without a scope-id.
> >                */
> > +     case -EPERM:
> > +             /* Happens, for instance, if a bpf is preventing the conn=
ect */
>
> This will propagate -EPERM up into other layers which might not be ready
> to handle it.
> It might be safer to map EPERM to an error we would be more likely to
> expect  from the network system - such as ECONNREFUSED or ENETDOWN.
>
> Better still would be for kernel_connect() to return a more normal error
> code - not EPERM.  If that cannot be achieved, then I think it would be
> best for the sunrpc code to map EPERM to something else at the place
> where kernel_connect() is called - catch it early.
>
> NeilBrown
>
>
> >       case -ECONNREFUSED:
> >       case -ECONNRESET:
> >       case -ENETDOWN:
> > --
> > 2.39.3
> >
> >
>


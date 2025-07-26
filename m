Return-Path: <bpf+bounces-64424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB8B127F4
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 02:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472C4545411
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF853770B;
	Sat, 26 Jul 2025 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxw0B2wE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98628FD;
	Sat, 26 Jul 2025 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489380; cv=none; b=iIxSLeyLE14NBG/ntAW61YNleBrNRkk6rr7UlKeymhE2g3qD5Tdl9HW3puNaFC16XtR3JqTEqBG0DHqYX+xWacIcmKLRePssZNmgxNVZXIxF9iXRRehzGeSiJWvDyOK+YBrxJRBilXkW94kN8WHORt1SG+MII8CZWBE7s9iLAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489380; c=relaxed/simple;
	bh=59Vu4UzUC/JMMQqQH2RP8veIclAnDjH6tcSPWkXla5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psA+d+R2ok9uzEm2YZpkkAE/ofXuqPlMkwjrqNfmg3+GAyMLlYxtnanNc1wD1Qfmm8ScoQzxGzzyvSPVoUlua4s+qBVYN0ROwBm7gVWFWQX08plGuoOhNNcl3PLFKxoJT61rtxCEmttCX1MOqUfYA6ib32r1a8CjutNJTeVYdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxw0B2wE; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-87c09672708so54946939f.3;
        Fri, 25 Jul 2025 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753489377; x=1754094177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59Vu4UzUC/JMMQqQH2RP8veIclAnDjH6tcSPWkXla5A=;
        b=Fxw0B2wEi+Bx6azciiQ2yT0NlUnVNQIW3M0sg5VbQ5OcaO0X0JVp3dSgEhQBNOoiLR
         ToTPDO3ixIZsHSRAnauPesFyeOf9RyCLcoD3kDIYMocRukt8XpvINDhaiQfiHvA4+OoG
         wQk+1DiIWNk8XgiO7AifPTjV2BVB2o7TLaErNC+EkON5iQow6Ra47N6DQx2QwGZhbuu0
         WShYBOIhPLnUlMmZpIqB5y8jpTpC+K0dSx2vwlsws42C1CzPMSppBSoZP03JvC1OxLdG
         5GFEwgdJhpMcVlQG9WCSu4qRwwiJKygLxZ7jhFeFUG/Nuhqa6OncoZrlf59BnG2MG2Hp
         nugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753489377; x=1754094177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59Vu4UzUC/JMMQqQH2RP8veIclAnDjH6tcSPWkXla5A=;
        b=RVgY2lnqnZmKvzNuXFx0pQfGTUjkiRGybDP08d1TCNuTE4E1yVPuxHiibljwCcd/to
         PijmLRAccQbfv2zhkI9l/4KK5Abrk+taUOXFdyGjgYyPmpd/y1o39vxZAHlsqN/CRh6d
         bGuQKrKmFwt3tSUr5MdaOndMSrEX5mS3fZUG2ncKUW94o8itvs/QgOL8mdVHF8JMQRNf
         Xa2DsJ7vQtGX/Vwgvsft72dgfQBha7cumljyUh1vEHeggrL8DYNFz5qYmESPELfu503R
         ZBYEhknAsJp4yRDnQVI79p1MImSVtZFjoh06lTrcrZ/Om2P/DkvZ9trP4kSMjVetzWf7
         fR5w==
X-Forwarded-Encrypted: i=1; AJvYcCVLh1LBS4Fkn5kKyy8stjUhybYwGi6lxhsY0NPN08XsdPfiWLaqHdoBMAWa1Y3+HQoisyIpUV/b@vger.kernel.org, AJvYcCVymSM1gOe8aQlIgI0R0WRTlVXbQn4zCy1liyo45BuhHRrVo2rSxv1SF8XBns+q2LSoxSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5KZTRe9JtCVrD367QH7vdyjfkdtoay4rRXaVdvKXdJgrYIKIJ
	vQNEKgd1cXGkDsOfNNLCFeDzDKcvX6wE0m4jOVKbbvHByB4pxFcjS5EnVqqxQSvsY5N+5tlxkrB
	g8R4t/dre3c4I5iMWusrABfF6jv/v7dY=
X-Gm-Gg: ASbGnctTCeIjbKBNUZtCN+Gk/LdZfedVgdASvQay+Kv6eFbnFvgbm9uHOEVzPYE/vXu
	aYaktHRLCgaQOVB7QXktUib03cX1tSnrdB5XG7o/Z4Kxp6Rlg4aihkjldL2hxDNrtVPWMzSuMac
	t8YmFYDdmcGX+xEL2WfImSUJ/+OCJY9Kx6qCO8E2CPwy1vrs3RB0EmEX58mnhv3gqmC0L0j2oun
	/dPIaY=
X-Google-Smtp-Source: AGHT+IHB4NPlAjQxD6BkYXKrz60HqH1+D3z7Ld1KBDo+gdXSpJRVwQ6CWlgCZppX81Uw++0cNW5F5c2YfK9e28gzm+0=
X-Received: by 2002:a05:6e02:2681:b0:3dc:7f3b:acb1 with SMTP id
 e9e14a558f8ab-3e3c52c7ec8mr57210265ab.13.1753489377560; Fri, 25 Jul 2025
 17:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-3-kerneljasonxing@gmail.com> <6ecfc595-04a8-42f4-b86d-fdaec793d4db@intel.com>
 <CAL+tcoBTejWSmv6XTpFqvgy4Qk4c39-OJm8Vqcwraa0cAST=sw@mail.gmail.com>
 <aINjHQU7Uwz_ZThs@soc-5CG4396X81.clients.intel.com> <cae34d33-3e32-4c89-a775-df764d964c4d@intel.com>
In-Reply-To: <cae34d33-3e32-4c89-a775-df764d964c4d@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 26 Jul 2025 08:22:21 +0800
X-Gm-Features: Ac12FXxnz1RbcpICFx5PlD2qfV1XUE12aPb3sm84n5AESFoJenPD09RXgIli5V0
Message-ID: <CAL+tcoCCM2Yxy=rQHcLJmi9=Vm=4whCJbVH=EqU8hazL5XXA-A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] ixgbe: xsk: resolve the underflow of budget
 in ixgbe_xmit_zc
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 12:54=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@inte=
l.com> wrote:
>
>
>
> On 7/25/2025 3:57 AM, Larysa Zaremba wrote:
> > On Fri, Jul 25, 2025 at 07:18:11AM +0800, Jason Xing wrote:
> >> Hi Tony,
> >>
> >> On Fri, Jul 25, 2025 at 4:21=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@=
intel.com> wrote:
> >>>
> >>>
> >>>
> >>> On 7/20/2025 2:11 AM, Jason Xing wrote:
> >>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>
> >>>> Resolve the budget underflow which leads to returning true in ixgbe_=
xmit_zc
> >>>> even when the budget of descs are thoroughly consumed.
> >>>>
> >>>> Before this patch, when the budget is decreased to zero and finishes
> >>>> sending the last allowed desc in ixgbe_xmit_zc, it will always turn =
back
> >>>> and enter into the while() statement to see if it should keep proces=
sing
> >>>> packets, but in the meantime it unexpectedly decreases the value aga=
in to
> >>>> 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc r=
eturns
> >>>> true, showing 'we complete cleaning the budget'. That also means
> >>>> 'clean_complete =3D true' in ixgbe_poll.
> >>>>
> >>>> The true theory behind this is if that budget number of descs are co=
nsumed,
> >>>> it implies that we might have more descs to be done. So we should re=
turn
> >>>> false in ixgbe_xmit_zc to tell napi poll to find another chance to s=
tart
> >>>> polling to handle the rest of descs. On the contrary, returning true=
 here
> >>>> means job done and we know we finish all the possible descs this tim=
e and
> >>>> we don't intend to start a new napi poll.
> >>>>
> >>>> It is apparently against our expectations. Please also see how
> >>>> ixgbe_clean_tx_irq() handles the problem: it uses do..while() statem=
ent
> >>>> to make sure the budget can be decreased to zero at most and the und=
erflow
> >>>> never happens.
> >>>>
> >>>> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> >>>
> >>> Hi Jason,
> >>>
> >>> Seems like this one should be split off and go to iwl-net/net like th=
e
> >>> other similar ones [1]? Also, some of the updates made to the other
> >>> series apply here as well?
> >>
> >> The other three patches are built on top of this one. If without the
> >> patch, the whole series will be warned because of build failure. I was
> >> thinking we could backport this patch that will be backported to the
> >> net branch after the whole series goes into the net-next branch.
> >>
> >> Or you expect me to cook four patches without this one first so that
> >> you could easily cherry pick this one then without building conflict?
> >>
> >>>
> >>> Thanks,
> >>> Tony
> >>>
> >>> [1]
> >>> https://lore.kernel.org/netdev/20250723142327.85187-1-kerneljasonxing=
@gmail.com/
> >>
> >> Regarding this one, should I send a v4 version with the current patch
> >> included? And target [iwl-net/net] explicitly as well?
> >>
> >> I'm not sure if I follow you. Could you instruct me on how to proceed
> >> next in detail?
> >>
> >
> > What I usually do is send the fix as soon as I have it. While I prepare=
 and test
> > the series, the fix usually manages to get into the tree. Advise you do=
 the
> > same, given you have things to change in v2, but the fix can be resent =
almost
> > as it is now (just change the tree).
> >
> > Tony can have a different opinion though.
>
> I agree. Normally in these situations, send the fix first and after that
> one is
> applied, the other patches can be sent.
> This patch would've fit in nice with the other series, however, as that
> one is already in process and this one can standalone. I would send this
> fix by itself.

Got it. I will leave those two fixes as they are and send this one
targetting the right branch as soon as possible today.

Thanks,
Jason


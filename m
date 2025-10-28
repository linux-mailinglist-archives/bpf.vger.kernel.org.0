Return-Path: <bpf+bounces-72554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FEFC15624
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE981B25085
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355592857EA;
	Tue, 28 Oct 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aPgIESFU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739E1A9B46
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664709; cv=none; b=JS+f1wgg3AkOG+Rg4ddnL4t5wSQZeBogWCMqZaRtgP3+xUbn9j6AE6NaMwTaHcS4PXmcQE7OVkC04VWXYGt+cihx4GIpCkAQEQTrSem3fqMlmlnNHqoVnBI96UAg384IIwk5Ax1DxhBeXoOJpKfryU2D4nfg9syQFVGnOSOIDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664709; c=relaxed/simple;
	bh=F8e8WmGYtiSIz2ZPl4Tlwz5ZEbUBxeuWsXenRkSuRIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnPtND6mbrnlA1FLi8hUvTYQG77BAHf8KtrXmRcoCcq42p0sVKEpvXL1tYnWW0cFympZbVjXlo7M40SNVEbF2k9xMcHE0FM5bnlXW+f5883tbXK+0f7BqySiSUZy6azMGdcwriBU04dVBMa2S50+PODyWbUCviwC2cKNA61BzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aPgIESFU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-330b4739538so6185544a91.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761664707; x=1762269507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyP7cdj89rMrrTPrjzZN0zWB9L8ktToD2ZCaFwPw6WM=;
        b=aPgIESFULDDgUYkTMzXh1LVWLZXkfPhgmMC0b6JL04+T71TF8ZT5auySl1c1TC+gRs
         OG6oHowTlgk8T7SzC/oeFOM1D9jNW68FrgJXrPTnleZf6ZVe+TdjYW0OhjqvwGuDP5sX
         hQks2fRbRuaLcPDeBd45qRIzb/V8rtE9sIhZDgIGmTD6H77c90jLcU81CrBgc7o36j3X
         Pds5HTbNrwbtUJbsQ48AHX3o2I6ke98XuwTvrqFeEdQfZ/1mY29GoedIt/erHpRp1RaL
         CHfz08y6LpQ1OKI4g+ZdqzFYNmJF7FujXPmbMPdMrfibSFId4ofgfXcVWnWTCkBaUuPE
         A4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664707; x=1762269507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyP7cdj89rMrrTPrjzZN0zWB9L8ktToD2ZCaFwPw6WM=;
        b=a970fDSzjY1/iV8hAdho/A4dQLa4d3VJCgHYwJwe2iS1AjhBrVo5nUGJrsXr+0lBpg
         1+r6J6xXugFD9oQ8ABGgw/RJNpaznBz17Z/4JAasF9GZ3/90bJjcjOMsH/zQZBgNZLvw
         1rgzN3rQdaG68QufZmqKM13w96r0x0Ijn1Y32FbMbn49KtW3IKd3Ys5kv4bNvi2e20Ue
         C5jounBswEf70gvIJP+NrBcIzomldDxiodFMcoTTg35XWp0O1x14Dq6XoZGPLqNXYB44
         kEEm0T2fga9cL60nSMPCwRRs3BrdfH8O8zAtPt9+3wC8YQfSebGBHpHDdH3vUOMW1GT5
         9smA==
X-Forwarded-Encrypted: i=1; AJvYcCW1VLn6MgOhcYmdCJbwcFGgshXPhULvi6tk0Lhbzsuk3TVsG6YSrBai2333FZlixOhmUJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsUZeumuehDRr/N4t912t+v2rszuQtGUppA7fQ9ySEm+LMw1V
	ihd1QTCSJ5URJDzMEKyZu19k19P9IkcPPeE9pykcMIgScXMiWJaRy4SaZ1LNAdTg68ejXjqF4Lc
	ysBzeSt9jRsT+8DkRpHAyIW5O54tSZbKSH2mu7byn
X-Gm-Gg: ASbGnct8kWpz1HOLGqxY2GZMRH4UHgWMxj8uO3fdFIZlWKvPfvPS+wDO1H8r/Dxj1lI
	cuz5vCBvX54jlmLOedCx/0NzgWhI3tA/aFuyIrSrnjj0OyVHMuMDGi/G+5NjjV7ZuZH5ZjWcA3v
	TbUSmZt0FcfgP9tVsKTEx+DBQgekpzbRCpwZS9ZTmmHqtNZrCLSpGKLLqzXY0DtPC+LO9om8etN
	zQtDoiVIegZTDOP68eB49oXa2mBf4TRPRyUdU0slU1YH2DhqCKPaU581SO/r2c8UqClluU=
X-Google-Smtp-Source: AGHT+IGlNBZmXJK4qpsxQZzDRtVN03T2ZwyYcgh4TjwsGO4aVJnWhY7BZRGZ5o3S/2uKbp5fs3jAsBMy6IWDGwXqTfc=
X-Received: by 2002:a17:90b:5825:b0:33e:30b2:d20 with SMTP id
 98e67ed59e1d1-34027c0528dmr4786413a91.33.1761664707233; Tue, 28 Oct 2025
 08:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001022.1707437-1-song@kernel.org> <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
 <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
 <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com> <aQCE0WwGlOADI5xT@google.com>
In-Reply-To: <aQCE0WwGlOADI5xT@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 11:18:15 -0400
X-Gm-Features: AWmQ_bmm4t5z9CNEiMIeS2ttD9ySj8RRIc6jeSHuj0OZ3k34EbYuCM5QR53_mCE
Message-ID: <CAHC9VhRTN_PD9f4gNdwZFk2QjYZ3_Vc6Jfmircr2cS49CZ005A@mail.gmail.com>
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	casey@schaufler-ca.com, kpsingh@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.johansen@canonical.com, 
	eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:54=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
> On Mon, Oct 27, 2025 at 09:50:11PM -0400, Paul Moore wrote:
> > On Mon, Oct 27, 2025 at 6:45=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > > On Mon, Oct 27, 2025 at 2:14=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Fri, Oct 24, 2025 at 8:10=E2=80=AFPM Song Liu <song@kernel.org> =
wrote:
> > > > >
> > > > > lsm_prop_bpf is not used in any code. Remove it.
> > > > >
> > > > > Signed-off-by: Song Liu <song@kernel.org>
> > > > >
> > > > > ---
> > > > >
> > > > > Or did I miss any user of it?
> > > > > ---
> > > > >  include/linux/lsm/bpf.h  | 16 ----------------
> > > > >  include/linux/security.h |  2 --
> > > > >  2 files changed, 18 deletions(-)
> > > > >  delete mode 100644 include/linux/lsm/bpf.h
> > > >
> > > > You probably didn't miss any direct reference to lsm_prop_bpf, but =
the
> > > > data type you really should look for when deciding on this is
> > > > lsm_prop.  There are a number of LSM hooks that operate on a lsm_pr=
op
> > > > struct instead of secid tokens, and without a lsm_prop_bpf
> > > > struct/field in the lsm_prop struct a BPF LSM will be limited compa=
red
> > > > to other LSMs.  Perhaps that limitation is okay, but it is somethin=
g
> > >
> > > I think audit is the only user of lsm_prop (via audit_names and
> > > audit_context). For BPF based LSM or audit, I don't think we need
> > > specific lsm_prop. If anything is needed, we can implement it with
> > > task local storage or inode local storage.
> > >
> > > CC audit@ and Eric Paris for more comments on audit side.
> >
> > You might not want to wait on a comment from Eric :)
> >
> > > > that should be discussed; I see you've added KP to the To/CC line, =
I
> > > > would want to see an ACK from him before I merge anything removing
> > > > lsm_prop_bpf.
> > >
> > > Matt Bobrowski is the co-maintainer of BPF LSM. I think we are OK
> > > with his Reviewed-by?
> >
> > Good to know, I wasn't aware that Matt was also listed as a maintainer
> > for the BPF LSM.  In that case as long as there is an ACK, not just a
> > reviewed tag, I think that should be sufficient.
>
> ACK.
>
> > > > I haven't checked to see if the LSM hooks associated with a lsm_pro=
p
> > > > struct are currently allowed for a BPF LSM, but I would expect a pa=
tch
> > > > removing the lsm_prop_bpf struct/field to also disable those LSM ho=
oks
> > > > for BPF LSM use.
> > >
> > > I don't think we need to disable anything here. When lsm_prop was
> > > first introduced in [1], nothing was added to handle BPF.
> >
> > If the BPF LSM isn't going to maintain any state in the lsm_prop
> > struct, I'd rather see the associated LSM interfaces disabled from
> > being used in a BPF LSM just so we don't run into odd expectations in
> > the future.  Maybe they are already disabled, I haven't checked.
>
> Well, it doesn't ATM, but nothing goes to say that this will change in
> the future. Until then though, I have no objections around removing
> lsm_prop_bpf from lsm_prop as there's currently no infrastructure in
> place allowing a BPF LSM to properly harness lsm_prop/lsm_prop_bpf. By
> harness, I mean literaly using lsm_prop/lsm_prop_bpf as some form of
> context storage mechanism.
>
> As for the disablement of the associated interfaces, I don't feel like
> this warranted at this point? Doing so might break some out-of-tree
> BPF LSM implementations, specifically those that might be using these
> associated LSM interfaces purely for instrumentation purposes at this
> point?

Okay, let's leave things as-is for right now.  The lsm_prop struct is
an important part of those APIs, and if there is a need for those APIs
in a BPF LSM then we should preserve all of the API, including the
lsm_prop component.

--=20
paul-moore.com


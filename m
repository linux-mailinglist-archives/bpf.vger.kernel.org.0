Return-Path: <bpf+bounces-60412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE6AD637C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323731761F8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856B2F4334;
	Wed, 11 Jun 2025 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+G6FbXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF12F4321;
	Wed, 11 Jun 2025 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682531; cv=none; b=nU5cWKGOOY7HDMYleY5s30cJFtrtz2CyTKiMz2b5HmKoIsQybxr187Yuap+WMh2m3eV7D0zx8bHHDnxinoumXR4I5NZIxW/6uRaINf1q9WWDUhWB9WHWle8ASCtiZgpSjqnxExlExrxFUoc8kenNewmefuJlNyR73GmWvtLfk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682531; c=relaxed/simple;
	bh=nccQvK/L+S7kDvvhRybRTgunxsE9AaxIdgjTl9BZiiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gl5kyM85Dtg/Ad+gmlTOn9saFd/SQoL6ydou5foJ6yh+c8lzNwHA84/TEo94nmdUaWumwrBH6Lj08Q2mQ6e8CSVSIUGVrDIGdytD6av0+w9hEoWn/ZGlhT5lUmAmTA7KIQRuCe3OegyA9QISNXAiLHyKPCiKlwMK4xpQqhR7HCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+G6FbXQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so284782f8f.2;
        Wed, 11 Jun 2025 15:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749682528; x=1750287328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nccQvK/L+S7kDvvhRybRTgunxsE9AaxIdgjTl9BZiiw=;
        b=d+G6FbXQd1RLXzdCHdiqhMIgeNT23loKraG9gYThMAurq8kOlNqVRACWPIr1kGB/lw
         cKmQDhoQET2gNWVP72efgK2dAo3XfdbK7qthjt27aMIgsb7Pxb4P1X3Mi2v/pLJkUyij
         t4ot6A3chY2qR6cogY8jZC5fBlSEGocBxH7oFXvM7DA6Ba60yymfNXueT6IYA5OR2Mt6
         Mi0xERPwrPO2Wi6HQEySy3Rd6NtOgu5dFmhwe3+r7GMAXZKpeV1r1vH4/0YzKaJN5k8E
         IdrVI8RTYeDt/QCk0JqAAiollh8kSFzZ3Uq77+/7erNQSoahm22CMqJ6NoKSe1DxlHoy
         DWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682528; x=1750287328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nccQvK/L+S7kDvvhRybRTgunxsE9AaxIdgjTl9BZiiw=;
        b=NmB2PBxosxsltNJQ+J92cgsit+c1NEtaX6c05f9ziDLdje7xK4aD1dVAfJ26Yb0iJP
         9/hHa58GLByB0VWn0s+WD44fKqxHYr10lD85V8DVTIb7efpSm9mvFHrkyEvx4YKFxDyU
         i6LwpbR50N4Zw5vCvqgzWFkfvxMYaTw5G2Ee6PCeUSc5l/cBWOBENW0PGUzo24rNMano
         B0IJ8G3Yxb7AJr96T0IASZzH2i0sosHYCs7EM+ZK+LQ09iooRZoxbAyY2HTUom9OeAZc
         3rz42osbAGathtyLA4kzKRTirGsxa5W2qGPN+kJllBiqdJdOu/I2z9y/iJGBnVyQ5sBs
         edvA==
X-Forwarded-Encrypted: i=1; AJvYcCX+m+qx9qG/4gnENXlH8jyjKuVb00X84hy7Ldx7o79q14uF2kPiJyYyljOe6JJEpX7qtUIgMn+GHYjGHni95OXF4Xdtkfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbrlnNfF52L682bm2XD6LVcOKMey2iPInMnCrZSDZwCnamI1w
	Z3fNMBeNTj+/I+Wh4LxXoA84APoVSSy8Ce82YgTf83KGU/587hSKGzl5ZCRklvYeyrUaVQCX1eU
	DZptEC8T3TsOxTG6HUgvGquWtZBxqypkKGUDb
X-Gm-Gg: ASbGncsDuYEZhZGphakOCO2Bvv4nQuwpiYSdOengcoqq1GGyrSciIxffmAjD9jD0UjW
	2EVevQ2mnvL9v/EhzPUMVt14icDzGK0iOPmTkW+H2ZRYurjfVcyPcsfCNpk7ha4YvltwIq9jJ4E
	6OGdjyrkUkrnoFVWLLSK7VXli6/uTTYTdmDhNjmRs+Of40oBaGNhdhTUXfvjT98KfywCm9iYCS2
	rqpkwi0smw=
X-Google-Smtp-Source: AGHT+IHIvEBCFH1AoisinUJ0EhTt+lWssFDuYtd6BJm5ZnzsXxH/HByDKyvXh2NETEUlCJVuhcWvc7WY5USrYK0ZZZI=
X-Received: by 2002:a5d:588d:0:b0:3a5:2848:2e78 with SMTP id
 ffacd0b85a97d-3a56075a23emr899952f8f.28.1749682527822; Wed, 11 Jun 2025
 15:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-4-kpsingh@kernel.org>
 <CAADnVQLMff33qY+xY3Ztybbo38Wr9-bp_GPcoFna4EbtgTrWrg@mail.gmail.com> <CACYkzJ4v+n_6-dVSt9mgkhJPEa3r1q7YW5Zrh0c-j+gos_UOxw@mail.gmail.com>
In-Reply-To: <CACYkzJ4v+n_6-dVSt9mgkhJPEa3r1q7YW5Zrh0c-j+gos_UOxw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 15:55:16 -0700
X-Gm-Features: AX0GCFtCX7EshNJ8wOVAmZ3KKIGsOiv8vrmD73h3vJu4klnhWSpQz7sTdEDUeUk
Message-ID: <CAADnVQK5J2REAWXp_KrLThOp9n1=QA=ugxB2Mb7=JmXnSFxQYg@mail.gmail.com>
Subject: Re: [PATCH 03/12] bpf: Implement exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:44=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Mon, Jun 9, 2025 at 10:58=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > >
> > > Exclusive maps allow maps to only be accessed by a trusted loader
> > > program with a matching hash. This allows the trusted loader program
> > > to load the map and verify the integrity.
> > >
> > > Both maps of maps (array, hash) cannot be exclusive and exclusive map=
s
> > > cannot be added as inner maps. This is because one would need to
> > > guarantee the exclusivity of the inner maps and would require
> > > significant changes in the verifier.
> >
> > I was back and forth on it early, but after sleeping on it
> > I think we should think of exclusive maps as a generic concept and
> > not tied to trusted loader and prog signatures.
> > So any map type should be allowed to be exclusive and this patch
> > can handle it fine without adding more complexity.
> > In map-in-map case the outer map can be created exclusive
> > to a particular program, but inner maps don't have to be exclusive,
> > and it's fine. The lskel loader won't be using map-in-map anyway,
> > so no issues there.
>
> So the idea here is that if an outer map has exclusive access, only it
> can add inner maps. I think this is a valid combination as it would
> still retain exclusivity over the outer maps elements.

I don't follow.
What do you mean by "map can add inner maps ?"
The exclusivity is a contract between prog<->map.
It doesn't matter whether the map is outer or inner.
The prog cannot add an inner map.
Only the user space can and such inner maps are detached
from anything.
Technically we can come up with a requirement that inner maps
have to have the same prog sha as outer map.
This can be enforced by bpf_map_meta_equal() logic.
But that feels like overkill.
The user space can query prog's sha, create an inner map with
such prog sha and add it to outer map. So the additional check
in bpf_map_meta_equal() would be easy to bypass.
Since so, I would not add such artificial obstacle.
Let all types of maps have this exclusive feature.


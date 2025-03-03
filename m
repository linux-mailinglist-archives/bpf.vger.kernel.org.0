Return-Path: <bpf+bounces-53118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DEEA4CDD3
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AC63A9710
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F61F12ED;
	Mon,  3 Mar 2025 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq9Xlu9q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0C1C5D76
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039468; cv=none; b=NDh85AXMXhG2fhTPPoKTQImPhiTNM0n7LzyxKfE1CyfvjU5T7/BOLMQ0bEZEmtYU20/dwohcfswFX0fdx5bq88438BDYjhxJqxPj+TNUJAPl+oI/KnnzyPhfx4gfwikuLx46wqYh95vP2Tu+GmHeD8fWAD9Qgh7JjRFbUvBjsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039468; c=relaxed/simple;
	bh=+2hM59KtQDcQQzd4tvsaXEFtpeegyiTOZ1RiTupsDGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gjAznbmjzwwynceQKnyfpflrt0mtnPZs34mRHYM+fbp4LW4mem5PxJpoMxwPCInxXQ2DzMviM73Oy8X0TDtkToD7NaGR+CUuNAL4mo9v4ATxpPpdgYz9aldTYOGMvATWZfotyM0cdMZkWWi5IJ5z/ne+UI+zjxmASEvbdxLQMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq9Xlu9q; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fe96dd93b4so9007015a91.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 14:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039466; x=1741644266; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ja3aNq5Z4mil9G/g2FdYfXtAqABfgFQwkpFhQhe563s=;
        b=aq9Xlu9q7nAFl/Vo9vOP8IPP8Ulno6bn63/apew7Kdx7kORUBzepe3YrN0psQ0l0V/
         CBhxFMgj8CL+sshPhQY58WzwlDlyMDKY7qpoRUJhVwEdO2YDpTf4Ze0dgo4CCoqjPo+c
         utmKefnoUjrQYCH4zt/LKGQMoWQFKJ/VMC9umsbVuVd9y/V8lOiFfa/C7OX6OFgYLp82
         RFMKgjd6YMD90uecaeqtAh7uxdPVWBjQ7RapI2y7ZsNggwlvQgnIAzJ5WLl9cfMFtyP4
         OvNehCWSf/af5314X1euyhb8vCpYzNugbdeet+bN9LO8cCDYUxWYyFcpCCEp3vrThPfm
         SiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039466; x=1741644266;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ja3aNq5Z4mil9G/g2FdYfXtAqABfgFQwkpFhQhe563s=;
        b=imcLDjhEaNvOktT+1iiXB8r5eNGcXwjbGN70bLRU6WbefFzYMizfPyl9s9C9ajHW8r
         vcpUgzbuo2Sougd6r5umhN3Gu25pco/Ls40EHKUxV5E408sksfNyQeu4zihlHFpu6we/
         J5rDO0Z6esnHMElJh4R/D3duhmFiSseFfvvubRqWCCegA/cnd393kpXIkxjNpwJpIUYR
         mAKUGHF06soQCBsnK9nSjx4eRsHZQo4BdaO1wZNEkeCJUNC06SXoh3aVDLdE2p/P+9DN
         BcFwHeK3s/VvhYNEv5hafbSIYeiNMDuCFtmsTpYIbOiL5i2SDjhWpt8rg4GgJXXlVdon
         JN9w==
X-Gm-Message-State: AOJu0Yx5GFWzMTk5wMwTQDh9EXqfD6o2i5yjOx2XkeCzDScDl8f82emI
	hbOqNrQG1rbrsweCbSn9OzBPMM625aDs3+S7u81fwwiutrK2uzjo
X-Gm-Gg: ASbGncuXE30b/b65MQAFw5nbRsunRT0ne6PCmHNJyQluFqQR259cZMn8SU0N1tEnk18
	8sGgfjwNc7hAyfMeYHscwnCMMR59ZkIri8AwRPqiP2+IwkGzlDn0dd0WP/oKrdsPM8gGk1ft8aV
	70KlmE5iYu8cGAs4AM69SI5Vg/7TvTythfn4e8GXOPREs5bu2WPfpqz1r71w24B/n7bq9SCpyS/
	FaSUMoW15Kz03EZLkNZuAbmTa8SPFZUWG62wbZUXYCl1h9cnbQvcfS+tZ1b+jeql0McN3doSgNa
	BzFSNF6OV6YoqHSiOqvnTPMAa7fRLLl2xdsfyPSp9A==
X-Google-Smtp-Source: AGHT+IGMBU9XSoFyCHMUJNTQhkkD/GDZTMtd67Tc8/g6TnOc8mC10othcJj6snEHxGGgKdJvG6qgLA==
X-Received: by 2002:a17:90b:574b:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-2ff33b8aed3mr1384678a91.2.1741039465761;
        Mon, 03 Mar 2025 14:04:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe824b67a1sm11571508a91.0.2025.03.03.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:04:25 -0800 (PST)
Message-ID: <25f64bc2c9dbeb68a0ef21290323954e70e7366b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: split bpf object load into
 prepare/load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com, Mykyta
 Yatsenko <yatsenko@meta.com>
Date: Mon, 03 Mar 2025 14:04:21 -0800
In-Reply-To: <CAEf4Bzat3grecmd_PkmLpN9gAfkuGhmO4o4HmgZWE4sJ9BL+fw@mail.gmail.com>
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
	 <20250228175255.254009-3-mykyta.yatsenko5@gmail.com>
	 <5d7fb7202625b999cb77a1e010ba6f7099dbb561.camel@gmail.com>
	 <00e385df-7ffc-4fd9-aad8-60dddef300af@gmail.com>
	 <CAEf4Bzat3grecmd_PkmLpN9gAfkuGhmO4o4HmgZWE4sJ9BL+fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-03 at 13:38 -0800, Andrii Nakryiko wrote:
> On Sat, Mar 1, 2025 at 1:45=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >=20
> > On 01/03/2025 08:12, Eduard Zingerman wrote:
> > > On Fri, 2025-02-28 at 17:52 +0000, Mykyta Yatsenko wrote:
> > >=20
> > > [...]
> > >=20
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 9ced1ce2334c..dd2f64903c3b 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -4858,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_map=
 *map)
> > > >=20
> > > >   int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
> > > >   {
> > > > -    if (map->obj->state >=3D OBJ_LOADED)
> > > > +    if (map->obj->state >=3D OBJ_PREPARED)
> > > >              return libbpf_err(-EBUSY);
> > > I looked through logic in patches #1 and #2 and changes look correct.
> > > Running tests under valgrind does not show issues with this feature.
> > > The only ask from my side is to consider doing =3D=3D/!=3D comparison=
s in
> > > cases like above. E.g. it seems that `map->obj->state !=3D OBJ_OPENED=
`
> > > is a bit simpler to understand when reading condition above.
> > > Or maybe that's just me.
> > I'm not sure about this one.  >=3D or < checks for state relative to
> > operand more
> > flexibly,for example `map->obj->state >=3D OBJ_PREPARED` is read as
> > "is the object in at least PREPARED state". Perhaps, if we add more sta=
tes,
> > these >,< checks will not require any changes, while =3D=3D, !=3D may.
> > I guess this also depends on what we actually want to check here, is it=
 that
> > state at least PREPARED or the state is not initial OPENED.
> > Not a strong opinion, though, happy to flip code to =3D=3D, !=3D.
>=20
> Those steps are logically ordered, so >=3D and <=3D makes more sense. If
> we ever add one extra step somewhere in between existing steps, most
> checks will stay correct, while with equality a lot of them might need
> to be adjusted to multiple equalities.

As I said, for me personally it is easier to read "can set autocreate
only in OPENED state", compared to "can't set autocreate if state is
PREPARED of higher".
But whatever, I'm not a true C programmer anyway :)

[...]



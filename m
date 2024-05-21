Return-Path: <bpf+bounces-30168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B628CB5E4
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78B71C21A3F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099D149C5B;
	Tue, 21 May 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXcq/3Xk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3601865A
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716329747; cv=none; b=eBixhinVtwuGHHlJ2qyGKzyKXy4AzNTu/lOl1WQlHfTM1iGpE4f3TCToxjXOPI4bmfg3gWnM9ZS3kCzEqcIk11fDkDY8LZ3cH9PDxFle8gzUh5BHE9AN3NLocrSR6RTL8XvKyr50WuDe7024X089Q+2daNCplroXx4eSV2d7ToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716329747; c=relaxed/simple;
	bh=fxlYga4ST8dxervl5xPB5FTSzKNrZ/CjsAaOUwT+nU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=im8I/eM2jK3nS77edWps/6JQZ85CMPqNBtPwLoizPmEXwMYCcAqmI/mpNmbHJNIe+owBJwz9ZVE6SGHauAyW02mG8C6Zld9wcAUY4ITw1/s1a1YiZ0qxl/FkM7+x/rSJRNYDogRbEUkTdosTiFIkLi+tlDQuNf/n/GGsXhqSD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXcq/3Xk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed835f3c3cso5873505ad.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716329746; x=1716934546; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fxlYga4ST8dxervl5xPB5FTSzKNrZ/CjsAaOUwT+nU0=;
        b=kXcq/3Xk4SclE7LCUAnac/K85zxAAU0Czb0TWj9Gg5LAbb0DLgbkJcRTf/1y73s12a
         1Mad3BIt9dPGP8Tucbc26YpoLm3kapoFWAZCdnE97FxMVONqWYIoszt7CEtR30Pwnieh
         93Ww9YfH7FxtGYYKLf6vH6P4XZariXkp35yXS8okoDqGqzCHw+L9XUSCFydRKuBxj1g4
         eCnnhZMGdBooK/PoKv+X3a9slzzTLMhmo1yoSUVlJ0/33E1IvVnoMCpFjxvafOPolGnY
         v1ijp6cQtfNBZn9vrQy0HyqR3UMpVmf0wWqsWiSG2CwUjklizoNO62jAi2ykvfWs3lmu
         h5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716329746; x=1716934546;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxlYga4ST8dxervl5xPB5FTSzKNrZ/CjsAaOUwT+nU0=;
        b=bgm+Q3V4l3OSkng35+Tw540zj9dPMX9sb7Vd4w3ItRc+ZyuchWWtt67ZYtYq6ruMta
         YAqyIZ3A+jR5c868hxnmPeeCZL2W8Rb+bRZoVsgmDp8zFM8hb1b/nHeN+li26ubHP1Fa
         I5HTyscguquGA27SQvXyKNMIMe2O/eU0Tme4koZno740PxPBltgDgPw5VszKSYpLiVjq
         V5v+bL1Y5PgVwHqelf9NXFvbmje/OBGX0G9UzuF4PGV+DlJuwQyOZF5TGjLX9ywGXJ9E
         vf2Lb3eQ40XjgG1J6z5lkArJXa0qIm5VfnOEyG0F+AVnszzqooVJ/DzNJU5x1jEzyOc4
         +dng==
X-Forwarded-Encrypted: i=1; AJvYcCWBDYAnHbzX5MJR+00lAZwuGU7xlAJuq0+svmgGKDGrP5qcwCXL+4ECmOfxL2kKlPP5JvjnO30fVJfMbUkTrRWTny7i
X-Gm-Message-State: AOJu0YzVkQdf+Rua4oMUnCXk9+/XNoc7lw+YJnyRPNBrzd+K12G5mK7+
	xoS/IpN/JLEL0muJlfXfrXbnpsQ06CsN2lAiud0zva7SNyWFrRpy
X-Google-Smtp-Source: AGHT+IG7Ztt2BoBesedXJ5kUJfc64l4ooymg96zuvqGM/2c4/OAW7SYDO+Fj+WHRhdwVMx74Z37BXQ==
X-Received: by 2002:a17:903:230d:b0:1f2:f9bf:6cd0 with SMTP id d9443c01a7336-1f31c9e729bmr3235715ad.52.1716329745788;
        Tue, 21 May 2024 15:15:45 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fc5a015esm47323145ad.14.2024.05.21.15.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:15:45 -0700 (PDT)
Message-ID: <9cf02a374ab97ceaaed04a8d4148be93877555dd.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com, mykolal@fb.com,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, houtao1@huawei.com,
 bpf@vger.kernel.org,  masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Tue, 21 May 2024 15:15:44 -0700
In-Reply-To: <CAEf4BzbghAqpTSfWH_v10uK4ynXqG5Nm2e-_xTWFOF=bmLqd_Q@mail.gmail.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
	 <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
	 <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com>
	 <81bbbbad95244dd74801497414c2cdad88815f83.camel@gmail.com>
	 <CAEf4BzbdoXTeTSx-1Vu+sA6MKphQq91p1TwnSkK3Yv3msa7h9Q@mail.gmail.com>
	 <eda720142ac52a9bd9599f5444a2c2897255b5c4.camel@gmail.com>
	 <CAEf4BzbghAqpTSfWH_v10uK4ynXqG5Nm2e-_xTWFOF=bmLqd_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 15:01 -0700, Andrii Nakryiko wrote:
> On Tue, May 21, 2024 at 12:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Tue, 2024-05-21 at 11:54 -0700, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > I'm probably leaning towards not doing automatic relocations in
> > > btf__parse(), tbh. Distilled BTF is a rather special kernel-specific
> > > feature, if we need to teach resolve_btfids and bpftool to do
> > > something extra for that case (i.e., call another API for relocation,
> > > if necessary), then it's fine, doesn't seems like a problem.
> >=20
> > My point is that with current implementation it does not even make
> > sense to call btf__parse() for an ELF with distilled base,
> > because it would fail.
>=20
> True (unless application loaded .BTF.base as stand-alone BTF first,
> but it's pretty advanced scenario)

In this scenario .BTF.base would be relocated against .BTF.base,
which is useless but not a failure.
Maybe having the _opts() variant with additional degree of control
(e.g. whether to ignore .BTF.base) is interesting as well.
On the other hand, for such use-cases libbpf provides btf__parse()
that accepts raw binary input, and application can extract ELF
contents by itself.

[...]

> I see what you are saying about resolve_btfids needing the changes
> either way, and that's true. But instead of adding (unnecessary, IMO)
> -R argument, resolve_btfids should be able to detect .BTF.base section
> presence and infer that this is distilled BTF case, and thus proceed
> with ignoring `-B <vmlinux>` argument (we can even complain that `-B
> vmlinux` is specified if distilled BTF is used, not sure.

+1 for complaining about -B vmlinux when .BTF.base should be used.


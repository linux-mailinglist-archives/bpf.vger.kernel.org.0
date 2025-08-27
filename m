Return-Path: <bpf+bounces-66700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA61B38A18
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88317461E59
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B82E888A;
	Wed, 27 Aug 2025 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kolu0rhS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491F2DC323;
	Wed, 27 Aug 2025 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322003; cv=none; b=NY8b65ovfY4D7SW99WtuWFHepd+EYwn4T7OoMrJlkno+/0kM35tSfq1pMbAqrWXS1GJG1Av6TtpAhJZbU6SQ+d22vkwUzZ0c288tVhITqkDnNd+3qhRa8JkYaz+kmSWDcwSMwSHOTFA3aECTw/mhgKTHWuqZuYZ13ZEXTx6m71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322003; c=relaxed/simple;
	bh=HoHb9cBNZlNajJRdDNy4jdYaCrfjkC+H5Sh4n+Bigfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KsqTDDDCBLjCuZdwjOXKGwLpMkhXImbEakQMwurud9e6UmxYR+TJS05fBL0IMJBn8GczD3144SE18x92fDn0kVKbdM1IZHlxYoHKfLyaibFowiH5a/F4Fb5+WvVx7XMGzdfr82HXpzEhNqjSSnZG8IQYggO5BHykApi2nfGl++I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kolu0rhS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-246fc803b90so1818075ad.3;
        Wed, 27 Aug 2025 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756322001; x=1756926801; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c0kKHdDELmMaF/8pZgpwfb3E83vE0G448tXMk8cv3x4=;
        b=Kolu0rhSANAGpLXWCzFoY3gNC4OPM37zLUOAdZlRy8kYd5R5SxArwG1zbPKirarh9m
         QR0dgmcdD1hgPNrhwTds8oRpncUsKjFTldvGIna4ZWZjGC644zCH7AhRROFwidUAV4Vp
         ZoVmGJ+8KlxxClZJAW8F8z1xGvtdDDJ2bSDVMmsDyTtZsYw8UhcpAX92Kgz5gkf3/N9w
         qZb+fYidua5tA8FWX0XceanvG/BGEbr7NcVn/MF7ymbdo2HF++h0iS8zYPcKko2H4WHn
         8/wuvLvv6vcdQVhnZjEUeZrguXjgFb5c+iIaVKQR4oZZPHvH1XVbPT01z5G+BSwfDYuI
         V1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756322001; x=1756926801;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0kKHdDELmMaF/8pZgpwfb3E83vE0G448tXMk8cv3x4=;
        b=CLH93s1obnv2C84E/KBSFX86HRO/Gcgqpf3UlwLAJn7vDlxt23oYgRv60GrarcL30Z
         Q6CVxd0+m1fEzhzppkyt6vJxvvdXj9/EShSxKSHsakH60lzi/ahh03O0N+LqGtWzbIbZ
         vX53irSz+kxJObrjiu3NmNAmo9OybkzSzXIltG74OSgC8fwMw+X54TZ04b1e+fMpNUte
         2Z0fIQ5EgE+YrnfgFBTXb9ixd0Ujs82fvBaUT9eF+Mf4ZTUGXkIRgxySdAnvQbv93ffo
         Io9X5NuLozaUgIBkIgz3IXYzL0bFyFuCTIrHAC8OEQXahE4cpVoURT0AhYbBxy8gciRK
         O3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMDzhzoO48SGBFVDluSLi6JX4F0B+dTZHa6ZO9PmqMUdw3aaWgBfE9lbOggam6P2AlY1Y=@vger.kernel.org, AJvYcCWdsNPrszAq67jWAiHprfrYChd4R6IbaYQRVjPtkp9QQE2+4XmRqdUrRdeAacK3GtyMA2sQQxOdVm5pwaeX@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIjYdB5mqXXutvnTWN4a4i/yr73JlseLGfUrsRN9ZYUN9o9Ry
	4ZNxkavr8pNrV6DAa7Orhpvp7ECuU5Yw24xh/Ys6sa36s4hKId3Oxspm
X-Gm-Gg: ASbGncus3CFgiLC6cZcqAAl9s5GNyK83Rejq+x4p6l1Ca9TKvlixeA2Sq8KwjksptN1
	6fp72h+K2abssXAhj0u5fAuRCE03+H+6xQrL3ZnrdV7BjG7T2Xb6jAHO0V4rS4Y5QAwMlQIFJyG
	Wk3ZgZl0vibh70Knm3G3mjJDO667wDeKOUjXRIgNJGyjADRigeAT5c8kDswpGZVUMIiEXNUexxS
	tw4odkD3ah0zL1hCxzTFR0OFyUgrI7iiiz1IUGbRR6bmd0SiHQVMvpCb2MMchaalDZmLD2Xautg
	GqdSPO73ri3yUhfHEwNV/4jN/Cf8GH7gOzExUXKzd01rdUwR/r851pDAjbe71UaQy/GbTHC9SR1
	TGkdDo9wJqhtFiyj04CinnsDAMnE7Bqu4+HCsr+CLReEnv0hw
X-Google-Smtp-Source: AGHT+IFQ5T+6jmkbhsAVVVVKrLLctdT6LkXlQI+hHafbMFRZ2l6CRC9kKZp4XFN8arv4sP1QlXUlyQ==
X-Received: by 2002:a17:902:f606:b0:246:e8cc:8cea with SMTP id d9443c01a7336-246e8cc8eb9mr122556095ad.22.1756322000733;
        Wed, 27 Aug 2025 12:13:20 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6ed5:bfbc:8f3d:6d63? ([2620:10d:c090:500::4:16a5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248c97f2f96sm5590275ad.121.2025.08.27.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:13:20 -0700 (PDT)
Message-ID: <a7bcc333d54501d544821b5feeb82588d3bc06cb.camel@gmail.com>
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Andrea Righi
 <arighi@nvidia.com>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>,
 alan.maguire@oracle.com
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 27 Aug 2025 12:13:17 -0700
In-Reply-To: <a3dabb42-efb5-4aea-8bf8-b3d5ae26dfa1@linux.dev>
References: <20250822140553.46273-1-arighi@nvidia.com>
	 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
	 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
	 <a3dabb42-efb5-4aea-8bf8-b3d5ae26dfa1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-27 at 10:00 -0700, Yonghong Song wrote:
>=20
> On 8/26/25 10:02 PM, Eduard Zingerman wrote:
> > On Tue, 2025-08-26 at 13:17 -0700, Yonghong Song wrote:
> >=20
> > [...]
> >=20
> > > I tried with gcc14 and can reproduced the issue described in the abov=
e.
> > > I build the kernel like below with gcc14
> > >     make KCFLAGS=3D'-O3' -j
> > > and get the following build error
> > >     WARN: resolve_btfids: unresolved symbol bpf_strnchr
> > >     make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91=
: vmlinux] Error 255
> > >     make[2]: *** Deleting file 'vmlinux'
> > > Checking the symbol table:
> > >      22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_st=
rnchr.cons[...]
> > >     235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_st=
rnchr
> > > and the disasm code:
> > >     bpf_strnchr:
> > >       ...
> > >=20
> > >     bpf_strchr:
> > >       ...
> > >       bpf_strnchr.constprop.0
> > >       ...
> > >=20
> > > So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strn=
chr.
> > > For such case, pahole will skip func bpf_strnchr hence the above reso=
lve_btfids
> > > failure.
> > >=20
> > > The solution in this patch can indeed resolve this issue.
> > It looks like instead of adding __noclone there is an option to
> > improve pahole's filtering of ambiguous functions.
> > Abstractly, there is nothing wrong with having a clone of a global
> > function that has undergone additional optimizations. As long as the
> > original symbol exists, everything should be fine.
>=20
> Right. The generated code itself is totally fine. The problem is
> currently pahole will filter out bpf_strnchr since in the symbol table
> having both bpf_strnchr and bpf_strnchr.constprop.0. It there is
> no explicit dwarf-level signature in dwarf for bpf_strnchr.constprop.0.
> (For this particular .constprop.0 case, it is possible to derive the
>   signature. but it will be hard for other suffixes like .isra).
> The current pahole will have strip out suffixes so the function
> name is 'bpf_strnchr' which covers bpf_strnchr and bpf_strnchr.constprop.=
0.
> Since two underlying signature is different, the 'bpf_strnchr'
> will be filtered out.

Yes, I understand the mechanics. My question is: is it really
necessary for pahole to go through this process?

It sees two functions: 'bpf_strnchr', 'bpf_strnchr.constprop.0',
first global, second local, first with DWARF signature, second w/o
DWARF signature. So, why conflating the two?

For non-lto build the function being global guarantees signature
correctness, and below you confirm that it is the case for lto builds
as well. So, it looks like we are just loosing 'bpf_strnchr' for no
good reason.

> I am actually working to improve such cases in llvm to address
> like foo() and foo.<...>() functions and they will have their
> own respective functions. We will discuss with gcc folks
> about how to implement similar approaches in gcc.
>=20
> >=20
> > Since kfuncs are global, this should guarantee that the compiler does n=
ot
> > change their signature, correct? Does this also hold for LTO builds?
>=20
> Yes, the original signature will not changed. This holds for LTO build
> and global variables/functions will not be renamed.
>=20
> > If so, when pahole sees a set of symbols like [foo, foo.1, foo.2, ...],
>=20
> The compiler needs to emit the signature in dwarf for foo.1, foo.2, etc. =
and this
> is something I am working on.
>=20
> > with 'foo' being global and the rest local, then there is no real need
> > to filter out 'foo'.
>=20
> I think the current __noclone approach is okay as the full implementation
> for signature changes (foo, foo.1, ...) might takes a while for both llvm
> and gcc.
>=20
> >=20
> > Wdyt?
> >=20
> > [...]


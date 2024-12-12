Return-Path: <bpf+bounces-46752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBAF9EFFFF
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA9716270B
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEABD1DE88E;
	Thu, 12 Dec 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCqQ7wAz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AF1AF4C1;
	Thu, 12 Dec 2024 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045691; cv=none; b=VkR3u/+Fr5H0LwdTEE3HkLMeTvvQo11/RVKP8z5pOrypDwo4GN5XoYHmU3IPCWW2D77CQOadRFpy/HCS5ve2IFnQAhECMvDbBSKO2NrlC3IS4hSeckwoPtMx5UwKfggtD5Ag9SZgkzJIbxhMQ14M17RlPhv/oSNtMZCj1i8QPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045691; c=relaxed/simple;
	bh=db6IqzW/PCcT2RK54P7zun3hg9fEOqZrM4C7RbxNKUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOzQC+9cA7MhXIxDFFSwv1Pyx+XkkYV8Bk7QKZLnjXHSiZztZ2AMSCRRJ/3MSYSAjFd682dxzHGzPUR/yAU+S6BeAZcbJGCPMITdYIo2mdF5nSoEHehU60nYyuXheFc22KHgRyGVo+8wmBoxRBtF5srC8xrFw65nH/8wtQ9afoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCqQ7wAz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso1037966a12.2;
        Thu, 12 Dec 2024 15:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734045689; x=1734650489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BC8w9wKaHIvChqadSH7tYokfEB+l8VKfz7d+St7lNE=;
        b=DCqQ7wAzKZwP2GgRKSG7t88KVmb9U5oM5GjXIXW0ZnVEvXLtVzRgUVYQ/2+BrKMWFk
         BwkVmyTBd7XJ5j8CWUUyjkDgTLp5wDtpg5fZeBq6UfqhT/9tohLc+cmoLWlEnxecT81N
         5UYP488eJJssbl1j0b+qwZWOz76iAqMhtbiQnSaAIvpWcIcZUchaB9FKYM3QzEBCIPzw
         a9xNYKurGa2ieJiaSf4qousdSeD/VPd7okHAo4D+jn5ah0HYdkVCQj5qfTIch7oUbyWy
         UqvP8auU+Hs8mz5Ms46JvaM2zvv7wFSjoxEdlWeOvpWP0tcgg8EHlBOugdXuV9b6CmSN
         wqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734045689; x=1734650489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BC8w9wKaHIvChqadSH7tYokfEB+l8VKfz7d+St7lNE=;
        b=PrTx1LQtyKIWw7hJgEfO489PYnvg45adobtg6tkg0QZPb7qQ5Az1Bc89QmeUA7rH7Y
         Q4/KJ3A4dN7ZBH3QteEAZHW4TzypBltYI+z7E6NTo9oH3tltvzbv68KZaXuTsNago3gj
         w+0ZzbccBmfBAmYykmbDUrTm9VubGvhXb3iQXbl3WzXGBfCMRie4XZ3RJDx+ArPWqcU9
         bdXNNdGR/rocpkfsI4DygpT+5Wzz2v2ZnNp4/M4oTMqR61hEU4IoyKIHo8tSWekQiGUs
         MgtKmg4vRv5wrCIrUd1FhL2jzTfsY/eenLhQFFMN4cVgDoxyrZVX+V5lq0kRRl/9KBYR
         703A==
X-Forwarded-Encrypted: i=1; AJvYcCUkTybv/e8fQI6Gc9uyp6LRQQCZJf9RXaB46Mof9L7SHFbIzB94GzhWNrTGd1bfFc42yuo=@vger.kernel.org, AJvYcCWVIEpyefo5Gjwvqc+F7T5n7SxowQ/ydgwq6GUdw4C5CS/lVWErGJ+NKvqQgZTkqBSevYQkxfiVpaVDO8n5@vger.kernel.org, AJvYcCWyHibUTtVG+O1FzC7q55nge9/I4ir8xN+3J/+SePhOsa4Wep7nBnDL5pur6ov5Tfv7Ki6V0bqj3Quue3U5@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKeRxITFMOhrBZ9RndGVMxN9pefK9Pc81wQzU4FXe5jJYr9qM
	tEBngTt0zvgf6uOEbzM5lMQJFwmTAwdI26vTptGz67fyTzkicKXBNcHRlWUGkeHSNxu0hq0hwvq
	6M+HxHkZiKn5D1ItaczR5BGFehKaAZA==
X-Gm-Gg: ASbGncswcXJkRWe39HDcVyuMC9lFVYGkH4M4wOOlBiCHG8EbJA/FvjI5H0B+ISRFjOG
	oCuOi/LJsd4/7PuBwbTm3YdgLb9PrR/LuL7Jl+XzCs98lwv8xNxAzkA==
X-Google-Smtp-Source: AGHT+IEo6MtIgS5xWsBv1Xvm9+7tHm8aHsi/mIM20/aw4agI2/hGFvesafq00pK/HLE2eHwxEMg+4hBx5EM8qUtKa4g=
X-Received: by 2002:a17:90b:3891:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2f28fc67526mr1059111a91.12.1734045687301; Thu, 12 Dec 2024
 15:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net>
 <REDzg-0aL2-Qw7QvYCKTfsLGh6E6Iq8dgWJPo5a94ym2x5DiUkwdHA-naUtaDO7HJgvOr6zd201E5P_WAquOyOFIiUij6Bi183EyxPusDuo=@pm.me>
 <3b834807-9f20-4f04-b788-f45dfac5cb1f@t-8ch.de> <CAEf4BzZSB2nzhYag_LKACXXJLwqLLfddXMV9_JRGYi+Y48rC-w@mail.gmail.com>
 <acf36eab-f906-42f7-9299-1473c0451dd1@t-8ch.de> <CAEf4Bzaa+X4K3_NApFYHxWP1P7stnAvZH4to65D1600fie6H3w@mail.gmail.com>
 <29f9911f-38b0-4634-95d4-0a55ef0a61fa@t-8ch.de>
In-Reply-To: <29f9911f-38b0-4634-95d4-0a55ef0a61fa@t-8ch.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 15:21:14 -0800
Message-ID: <CAEf4BzZ+3_CoNDhpbiXORTw1VYkWDiy-QKp+cai_Mj05vEWsmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Kui-Feng Lee <kuifeng@fb.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:19=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-12-12 14:54:36-0800, Andrii Nakryiko wrote:
> > On Thu, Dec 12, 2024 at 1:07=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@we=
issschuh.net> wrote:
> > >
> > > Hi Andrii,
> > >
> > > On 2024-12-12 11:23:03-0800, Andrii Nakryiko wrote:
> > > > On Tue, Dec 10, 2024 at 10:24=E2=80=AFPM Thomas Wei=C3=9Fschuh <lin=
ux@weissschuh.net> wrote:
> > > > > On 2024-12-11 00:17:02+0000, Ihor Solodrai wrote:
> > > > > > On Tuesday, December 10th, 2024 at 3:23 PM, Thomas Wei=C3=9Fsch=
uh <linux@weissschuh.net> wrote:
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Pahole v1.27 added a new BTF generation feature to support
> > > > > > > reproducibility in the face of multithreading.
> > > > > > > Enable it if supported and reproducible builds are requested.
> > > > > > >
> > > > > > > As unknown --btf_features are ignored, avoid the test for the=
 pahole
> > > > > > > version to keep the line readable.
> > > > > > >
> > > > > > > Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF an=
d generate BTF with multithreading.")
> > > > > > > Fixes: 72d091846de9 ("kbuild: avoid too many execution of scr=
ipts/pahole-flags.sh")
> > > > > > > Link: https://lore.kernel.org/lkml/4154d202-5c72-493e-bf3f-bc=
e882a296c6@gentoo.org/
> > > > > > > Link: https://lore.kernel.org/lkml/20240322-pahole-reprodicib=
le-v1-1-3eaafb1842da@weissschuh.net/
> > > > > > > Signed-off-by: Thomas Wei=C3=9Fschuh linux@weissschuh.net
> > > > > > >
> > > > > > > ---
> > > > > > > scripts/Makefile.btf | 1 +
> > > > > > > 1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > > > > > > index c3cbeb13de503555adcf00029a0b328e74381f13..da23265bc8b3c=
f43c0a1c89fbc4f53815a290e13 100644
> > > > > > > --- a/scripts/Makefile.btf
> > > > > > > +++ b/scripts/Makefile.btf
> > > > > > > @@ -22,6 +22,7 @@ else
> > > > > > >
> > > > > > > # Switch to using --btf_features for v1.26 and later.
> > > > > > > pahole-flags-$(call test-ge, $(pahole-ver), 126) =3D -j$(JOBS=
) --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimize=
d_func,consistent_func,decl_tag_kfuncs
> > > > > > > +pahole-flags-$(if $(KBUILD_BUILD_TIMESTAMP),y) +=3D --btf_fe=
atures=3Dreproducible_build
> > > > > >
> > > > > > Hi Thomas,
> > > > > >
> > > > > > There are a couple of issues with reproducible_build flag which=
 I
> > > > > > think are worth mentioning here. I don't know all the reasons b=
ehind
> > > > > > adding this now, and it's optional too, so feel free to discard=
 my
> > > > > > comments.
> > > > > >
> > > > > > Currently with this flag, the BTF output is deterministic for a=
 given
> > > > > > order of DWARF compilation units. So the BTF will be the same f=
or the
> > > > > > same vmlinux binary. However, if the vmlinux is rebuilt due to =
an
> > > > > > incremental change in a source code, my understanding is that t=
here is
> > > > > > no guarantee that DWARF CUs will be in the same order in the bi=
nary.
> > > > >
> > > > > The goal behind reproducible builds is to produce bit-by-bit iden=
tial
> > > > > binaries. If the CUs are in a different order then that requireme=
nt
> > > > > would have been broken there already.
> > > >
> > > > I'm curious, how do we guarantee that we get bit-by-bit identical
> > > > DWARF? Do we enforce the order of linking of .o files into the fina=
l
> > > > vmlinux? Is this described anywhere?
> > >
> > > The CU order has to be fixed, otherwise the non-debugging parts of th=
e
> > > binary would not be reproducible either.
> > > For docs is Documentation/kbuild/reproducible-builds.rst, the linked
> > > reproducible-builds.org project has much more information.
> > >
> > > Also besides reproducible builds, lots of kernel components rely
> > > (accidentally or intentionally) on a stable initialization order, whi=
ch
> > > is also defined by linking order.
> > >
> > > From Documentation/kbuild/makefiles.rst:
> > >
> > >         Link order is significant, because certain functions
> > >         (module_init() / __initcall) will be called during boot in th=
e
> > >         order they appear. So keep in mind that changing the link
> > >         order may e.g. change the order in which your SCSI
> > >         controllers are detected, and thus your disks are renumbered.
> > >
> > > > > For an incremental build a full relink with *all* CUs is done, no=
t only
> > > > > the changed once, so the order should always be the same.
> > > >
> > > > The concern here is whether linker guarantees that CUs' DWARF data
> > > > will be appended in exactly the same order in such case?
> > >
> > > Otherwise it wouldn't be reproducible in general.
> > > The pahole developers specifically implemented
> > > --btf_features=3Dreproducible_build for use in the kernel; after I se=
nt
> > > a precursor patch to this one (also linked in the patch):
> > >
> > > https://lore.kernel.org/lkml/20240322-pahole-reprodicible-v1-1-3eaafb=
1842da@weissschuh.net/
> > >
> > > In general the kernel already supports reproducible builds.
> >
> > Great, thanks for all the info!
> >
> > I do agree with Ihor that KBUILD_BUILD_TIMESTAMP is a non-obvious and
> > surprising way to enable this behavior, but if that's what's used for
> > other aspects of kernel build I guess it's fine by me.
>
> Agreed. So far KBUILD_BUILD_TIMESTAMP is really only used for timestamp
> related configuration. While it's not a perfect fit, adding yet another
> switch that needs to be specified can't be the answer, either.
>
> Maybe the Kbuild maintainers have some preference?

Wouldn't KBUILD_REPRODUCIBLE_BUILD=3Dy be the logical thing to have for
all these things that affect exact reproducibility?

>
> > Ihor's work on making BTF generation more deterministic w.r.t. CU
> > order would automatically benefit --btf_features=3Dreproducible_build i=
n
> > the end and might make it unnecessary, but there is no need to block
> > on a completion of that work.
>
> Sounds good.
>
> [..]


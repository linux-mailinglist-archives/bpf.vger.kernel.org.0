Return-Path: <bpf+bounces-46749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E79EFF99
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CA418815CF
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D91DE4CA;
	Thu, 12 Dec 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxr0xRNb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1E1AD9ED;
	Thu, 12 Dec 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044090; cv=none; b=peWoHX+8gNubp+vXQuSk8R0Ssq3qUBBMC7ES5RFlDsY+2XS1OhwWang81xvHpIH/HQmdk3HUy2nPviqU3M86Ds6F6laPQUznKs7i3anTx9CkZejNokNAi0dND2O2HXCxVlZwFbd1SinonFEbKGAnNEVqn0hUk+qDdAaGHhcF8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044090; c=relaxed/simple;
	bh=0kU0jCir+mX6QNkTTrGeBLeQYe6BkWEG4iPtzpl8Pg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwqBS1gSGZnGtY4ZJsbyJocFCa122dDxnrwThdjP2lhf5A4Rx5hIDcsIAuBMMx0V9zFXGRx0xTGUckGAebymN1Y6Iv4UvY+7Mt4ndfzqwH0LlX1hN5ITPSx04xa14k9aknGMarQc1IyWeNsng5ebGWOs1mdumlFtOZ53fcD86w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uxr0xRNb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef748105deso821821a91.1;
        Thu, 12 Dec 2024 14:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734044088; x=1734648888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu3bsJq/+UKlAtZnBLQa/cSRZsPRbGmPSv5xNPM7oBg=;
        b=Uxr0xRNbc0UaJkkfsFY98wN7YwvVDwvZowsbXaVlpwChBF1Gd+QOzOerJkQ0w9sjl+
         KwlZIIwU4OKp2gz5CdGYCBJ8AWV/k647Ekj2GUUvdaaaBr4P8XMMRc7Jf5nB/GH1f+ky
         JL0E+w6gzKEWCTeGmUEAcCpDSWWSSKqnruaFLmwVSqYxKX7EoYSQrN7W5Iqcpo69iA4n
         jVOb6yZptnqZPnPkUktSJAU07az8cCCnzQ/Bs2tIt0+9xaWkAh+BD4G1yOR8pmp7+bfD
         DkJzfddvLOR+gZUfLaZDoyEmeobj0Ox25qP46DYG5ZuOQLxzh2szYYBD+viEszp1kB3p
         ZxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734044088; x=1734648888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu3bsJq/+UKlAtZnBLQa/cSRZsPRbGmPSv5xNPM7oBg=;
        b=Vbw+Wi8TswFXLVq5oBjO/CddFpB/sc3d3dnEeubTSRF4qv7gKtxaXNAkADSw9BLF/z
         qEKhFlSNL8gvaLf7wml4gx+LlUlM/UbJQDsyqOCCmP0OhUUDn1NIgE54bFCDcwnewE3G
         wjxTttOPgoqBXce4vQF5zzFVXm5JszPpxPL37EkJXl8TZQzDq8e0Ljqp98Cuvqe9ZuvT
         fCaH2Gq6o/ivRE6AgkSBnnhQZzQJelV0/UcRIia1DC0HVxK6doUVlFZDGYaHekeoWUr4
         tw4aTAlR8DKdQIOHWzqkldN7DdFN1WvGwBVIKm5wkdIPz16xhRjVG3uqe2qCfuW17hDK
         IbsA==
X-Forwarded-Encrypted: i=1; AJvYcCVsZKe/Igp+yfMj2pArzjmrP4MA8sysseTg2ieOhqyQH+/e30uZLVcHyjUUQwwutC0EKsX0M9/gIqapAN4t@vger.kernel.org, AJvYcCWt+7vkFGNvAMoBxTp8WK4HPVL5ttWi87swPDNnOmtqAlwxK1PNMLS48K4LfTwDq+KNBM4=@vger.kernel.org, AJvYcCWvrhYkxsjBKK3OnFs5Rmo4UJB9w7ympGhRS76zsDyjvUjzZed+k6KYZzb16Pq/QThPmrX/1dTkXzYu3I9o@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIew1qdWkUDkp38W32y7c26pR5rHaIe2EZIAX23iQBsP68z0w
	fkWH86NnYat4jWlPo+l/Mmj2jHnR0WYRm+DHBbmI5+IOll0Al5uvH4l0FgVfh3cgo8xXMdCSpmV
	AXsnhvBL9cZ0uIR9HshyqBxTV6og=
X-Gm-Gg: ASbGncsNwH45BlJORHrk31YKsYgRDKZ7d7MFbEArl8lySVNoE5toac96y2sfrjGxbkF
	o6RqnxHUZUbw1BuIH7+iECTPHVlODGyvd9LQKrRybRlpzY0Sfvc5NfQ==
X-Google-Smtp-Source: AGHT+IGMb7Wvy4MjNYmnltmynjKEniH11G2YbQUjYVL2QooFsF00VNLx1ayawENFY+lQ/kOZo8/ZVqC+EYOTVUT2ybQ=
X-Received: by 2002:a17:90b:2dc7:b0:2ee:b26c:10a3 with SMTP id
 98e67ed59e1d1-2f2901b81b3mr608339a91.36.1734044088186; Thu, 12 Dec 2024
 14:54:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net>
 <REDzg-0aL2-Qw7QvYCKTfsLGh6E6Iq8dgWJPo5a94ym2x5DiUkwdHA-naUtaDO7HJgvOr6zd201E5P_WAquOyOFIiUij6Bi183EyxPusDuo=@pm.me>
 <3b834807-9f20-4f04-b788-f45dfac5cb1f@t-8ch.de> <CAEf4BzZSB2nzhYag_LKACXXJLwqLLfddXMV9_JRGYi+Y48rC-w@mail.gmail.com>
 <acf36eab-f906-42f7-9299-1473c0451dd1@t-8ch.de>
In-Reply-To: <acf36eab-f906-42f7-9299-1473c0451dd1@t-8ch.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 14:54:36 -0800
Message-ID: <CAEf4Bzaa+X4K3_NApFYHxWP1P7stnAvZH4to65D1600fie6H3w@mail.gmail.com>
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

On Thu, Dec 12, 2024 at 1:07=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Hi Andrii,
>
> On 2024-12-12 11:23:03-0800, Andrii Nakryiko wrote:
> > On Tue, Dec 10, 2024 at 10:24=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@w=
eissschuh.net> wrote:
> > > On 2024-12-11 00:17:02+0000, Ihor Solodrai wrote:
> > > > On Tuesday, December 10th, 2024 at 3:23 PM, Thomas Wei=C3=9Fschuh <=
linux@weissschuh.net> wrote:
> > > >
> > > > >
> > > > >
> > > > > Pahole v1.27 added a new BTF generation feature to support
> > > > > reproducibility in the face of multithreading.
> > > > > Enable it if supported and reproducible builds are requested.
> > > > >
> > > > > As unknown --btf_features are ignored, avoid the test for the pah=
ole
> > > > > version to keep the line readable.
> > > > >
> > > > > Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and ge=
nerate BTF with multithreading.")
> > > > > Fixes: 72d091846de9 ("kbuild: avoid too many execution of scripts=
/pahole-flags.sh")
> > > > > Link: https://lore.kernel.org/lkml/4154d202-5c72-493e-bf3f-bce882=
a296c6@gentoo.org/
> > > > > Link: https://lore.kernel.org/lkml/20240322-pahole-reprodicible-v=
1-1-3eaafb1842da@weissschuh.net/
> > > > > Signed-off-by: Thomas Wei=C3=9Fschuh linux@weissschuh.net
> > > > >
> > > > > ---
> > > > > scripts/Makefile.btf | 1 +
> > > > > 1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > > > > index c3cbeb13de503555adcf00029a0b328e74381f13..da23265bc8b3cf43c=
0a1c89fbc4f53815a290e13 100644
> > > > > --- a/scripts/Makefile.btf
> > > > > +++ b/scripts/Makefile.btf
> > > > > @@ -22,6 +22,7 @@ else
> > > > >
> > > > > # Switch to using --btf_features for v1.26 and later.
> > > > > pahole-flags-$(call test-ge, $(pahole-ver), 126) =3D -j$(JOBS) --=
btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_fu=
nc,consistent_func,decl_tag_kfuncs
> > > > > +pahole-flags-$(if $(KBUILD_BUILD_TIMESTAMP),y) +=3D --btf_featur=
es=3Dreproducible_build
> > > >
> > > > Hi Thomas,
> > > >
> > > > There are a couple of issues with reproducible_build flag which I
> > > > think are worth mentioning here. I don't know all the reasons behin=
d
> > > > adding this now, and it's optional too, so feel free to discard my
> > > > comments.
> > > >
> > > > Currently with this flag, the BTF output is deterministic for a giv=
en
> > > > order of DWARF compilation units. So the BTF will be the same for t=
he
> > > > same vmlinux binary. However, if the vmlinux is rebuilt due to an
> > > > incremental change in a source code, my understanding is that there=
 is
> > > > no guarantee that DWARF CUs will be in the same order in the binary=
.
> > >
> > > The goal behind reproducible builds is to produce bit-by-bit idential
> > > binaries. If the CUs are in a different order then that requirement
> > > would have been broken there already.
> >
> > I'm curious, how do we guarantee that we get bit-by-bit identical
> > DWARF? Do we enforce the order of linking of .o files into the final
> > vmlinux? Is this described anywhere?
>
> The CU order has to be fixed, otherwise the non-debugging parts of the
> binary would not be reproducible either.
> For docs is Documentation/kbuild/reproducible-builds.rst, the linked
> reproducible-builds.org project has much more information.
>
> Also besides reproducible builds, lots of kernel components rely
> (accidentally or intentionally) on a stable initialization order, which
> is also defined by linking order.
>
> From Documentation/kbuild/makefiles.rst:
>
>         Link order is significant, because certain functions
>         (module_init() / __initcall) will be called during boot in the
>         order they appear. So keep in mind that changing the link
>         order may e.g. change the order in which your SCSI
>         controllers are detected, and thus your disks are renumbered.
>
> > > For an incremental build a full relink with *all* CUs is done, not on=
ly
> > > the changed once, so the order should always be the same.
> >
> > The concern here is whether linker guarantees that CUs' DWARF data
> > will be appended in exactly the same order in such case?
>
> Otherwise it wouldn't be reproducible in general.
> The pahole developers specifically implemented
> --btf_features=3Dreproducible_build for use in the kernel; after I sent
> a precursor patch to this one (also linked in the patch):
>
> https://lore.kernel.org/lkml/20240322-pahole-reprodicible-v1-1-3eaafb1842=
da@weissschuh.net/
>
> In general the kernel already supports reproducible builds.

Great, thanks for all the info!

I do agree with Ihor that KBUILD_BUILD_TIMESTAMP is a non-obvious and
surprising way to enable this behavior, but if that's what's used for
other aspects of kernel build I guess it's fine by me.

Ihor's work on making BTF generation more deterministic w.r.t. CU
order would automatically benefit --btf_features=3Dreproducible_build in
the end and might make it unnecessary, but there is no need to block
on a completion of that work.

>
> For my personal kernel builds only two incompatibilities/rough edges rema=
in:
>
> * (parallel) BTF generation, which is fixed with this patch
> * CONFIG_MODULE_SIG with non-precreated keys (which I am working on)
>
> > > > At the same time, reproducible_build slows down BTF generation by
> > > > 30-50%, maybe more depending on the kernel config.
> > >
> > > If a user explicitly requests reproducibility then they should get it=
,
> > > even if it is slower.
> > >
> > > > Hopefully these problems will be solved in upcoming pahole releases=
.
> > >
> > > I don't see it as big problem. This is used for release builds, not
> > > during development.
> > >
> > > > Question: why KBUILD_BUILD_TIMESTAMP flag? Isn't it more appropriat=
e
> > > > to use a separate flag for this particular feature?
> > >
> > > Adding an additional variable would need to be documented and would
> > > makes the feature harder to use. KBUILD_BUILD_TIMESTAMP already needs=
 to
> > > be set by the user if they are building for reproducibility.
> > >
> > > > > ifneq ($(KBUILD_EXTMOD),)
> > > > > module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --bt=
f_features=3Ddistilled_base
> > > > >
> > > > > ---
> > > > > base-commit: 7cb1b466315004af98f6ba6c2546bb713ca3c237
> > > > > change-id: 20241124-pahole-reproducible-2b879ac8bdab
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > Thomas Wei=C3=9Fschuh linux@weissschuh.net


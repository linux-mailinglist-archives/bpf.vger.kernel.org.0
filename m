Return-Path: <bpf+bounces-46729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A349E9EFC57
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5650728B6F7
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660A1198E9B;
	Thu, 12 Dec 2024 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlem61Ab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482D188713;
	Thu, 12 Dec 2024 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031397; cv=none; b=VI+mRcti6LUpjINZLnsSw9RXsHZEazhXHXzjDFrYW4N/9pYSrz6F0DDY120Msvfwn+XHMdkvMJy7NRswG0HXOfefwQuGukhbGBPwumsSvMzJwPli6df8V9Zqnv37HEFUogWut3DTlOjRyvtcwst8m1u1rT9NfDpnO1V+qlr+4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031397; c=relaxed/simple;
	bh=VXNk7/xtGwifRt8Bi6IlCKe86qIrMDXhOPvmXZScFbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I80Hx8azR24rJ8/TfN617ATf0tRdm9mHAJbTeWDUcHh/kC97od9Vnld60ut7tvzGOELxkLQA93ZlTXgNXFgGwh9fD/uGTXpWItvhER4SPOYdbsKfpyRkinIQFwjmbMxrAF/lbci8Pc9UMRrdtpOXtZnU4QffP0agCixJQchO+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlem61Ab; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so742424a12.0;
        Thu, 12 Dec 2024 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734031395; x=1734636195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXNk7/xtGwifRt8Bi6IlCKe86qIrMDXhOPvmXZScFbk=;
        b=Rlem61AbHj4QDjJavRnAJMD1ysLpNBeAKRqC8OQ+5MNfWWM0hzsZhhPTNg/6q1gI2g
         tMs0+BBVr3631wd+dmmi4QE73v+MRdhK5xZDigxGGGwbl425kKChmSgcoA+D8xSn2JOY
         ItU8NI+AeFekiorxjib3cRQpQzQxbXVpTxe4WqDVNgdAXR6tABUWwHGHK0iMjviRcKhV
         mHvdHBxuS1h+hdrNzrezgSWDLU3EnuO/GoRykC/xmyarRjowBOf2YzNXy7xhIVbTzbZE
         BUezJKsnl7MiMb9aP5FEk2LHTV33G3+U5l3P7oZ8zQ6fIxIIdkSJxPXMp4sE0d5F9QII
         JFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734031395; x=1734636195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXNk7/xtGwifRt8Bi6IlCKe86qIrMDXhOPvmXZScFbk=;
        b=S/Hl4Xf3cRxuoyUALsSRowZ73MfdjYL2t8qqY0/yH51pd7P7GD7/vkPJQ/O99u68ge
         i0wW4Y+0lG9BtMX5ykRc6KI/68z57JLzXwgnh+coLwwmij6PnxySNGZNBJxHyqh9z7D6
         tUC2JNaNZES3jAMyFJxqCr4Y8Fhsi+6Am7Qb+zUm4Uid+4TyWezRCo4+TBI47HI4Fs9x
         deTmfbsRUd8Kq0E0pJWy4SKMf+HKLEKoT1Pty73P/cC8zovQTytM4bvntbm49O37eah+
         OqcwVB5EEtZAU81+JKyu+8anPtHWqhq0f7V4ZHj3jMn1y/4/4MDEjiXaQ7g30Kp7Hxj/
         cHPg==
X-Forwarded-Encrypted: i=1; AJvYcCUTbDuqxYxJKSH4mbT9K5BB2/UZia4fwpzoKErlsvZ/ht35arkF9MnEZn0FYFX7Pg9mcmg=@vger.kernel.org, AJvYcCX8C9d7V05ePvUhkACRFjoZxqg+Qozn//1VufZ4OXNac9ve9YCyUsyx7Fi7/Mk8uYrOv8a88+rm4BgxnNuy@vger.kernel.org, AJvYcCXJDo6mzrbYZK/90NEh5VCFSYDL/HO/GmiRZHww8XjLU/FA6+KsjAJl5nrA5xY1P0z8InCOAFnvo8mtiiE7@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYVz6xbxuHAthH8B1MmLuOZdvYOojZ3mRS4S9D19ExAnXEqJv
	fRqWWeRLIDSKRuJvYGwZWX7Rybt+4jTer2C0ga5klYBReH8JbjQWquBY666I6+v8sxopMujI3cX
	bmyxvvMAop1mAAr0uShK0iP9HERM=
X-Gm-Gg: ASbGncsItBPao3ZhspMlFHX8O00BHliaRIAgIYObnyFFLtv376RBU4mH61nL9UA4Ppd
	UhTZHiKY+hvPABqizucQvkA76Sya4UjjdNMJBixBvdUntVuK1qUuGvg==
X-Google-Smtp-Source: AGHT+IHfOOGRR1BbJA47sbpkjDB745PepNneTmU6pDaTNZ2EHuyss1QTb/UEZrv8oCaKIVc3mswu9flC0Dt0inGGitw=
X-Received: by 2002:a17:90b:3eca:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2f139293c4amr7399194a91.13.1734031395444; Thu, 12 Dec 2024
 11:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net>
 <REDzg-0aL2-Qw7QvYCKTfsLGh6E6Iq8dgWJPo5a94ym2x5DiUkwdHA-naUtaDO7HJgvOr6zd201E5P_WAquOyOFIiUij6Bi183EyxPusDuo=@pm.me>
 <3b834807-9f20-4f04-b788-f45dfac5cb1f@t-8ch.de>
In-Reply-To: <3b834807-9f20-4f04-b788-f45dfac5cb1f@t-8ch.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 11:23:03 -0800
Message-ID: <CAEf4BzZSB2nzhYag_LKACXXJLwqLLfddXMV9_JRGYi+Y48rC-w@mail.gmail.com>
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

On Tue, Dec 10, 2024 at 10:24=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> Hi Ihor,
>
> On 2024-12-11 00:17:02+0000, Ihor Solodrai wrote:
> > On Tuesday, December 10th, 2024 at 3:23 PM, Thomas Wei=C3=9Fschuh <linu=
x@weissschuh.net> wrote:
> >
> > >
> > >
> > > Pahole v1.27 added a new BTF generation feature to support
> > > reproducibility in the face of multithreading.
> > > Enable it if supported and reproducible builds are requested.
> > >
> > > As unknown --btf_features are ignored, avoid the test for the pahole
> > > version to keep the line readable.
> > >
> > > Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and genera=
te BTF with multithreading.")
> > > Fixes: 72d091846de9 ("kbuild: avoid too many execution of scripts/pah=
ole-flags.sh")
> > > Link: https://lore.kernel.org/lkml/4154d202-5c72-493e-bf3f-bce882a296=
c6@gentoo.org/
> > > Link: https://lore.kernel.org/lkml/20240322-pahole-reprodicible-v1-1-=
3eaafb1842da@weissschuh.net/
> > > Signed-off-by: Thomas Wei=C3=9Fschuh linux@weissschuh.net
> > >
> > > ---
> > > scripts/Makefile.btf | 1 +
> > > 1 file changed, 1 insertion(+)
> > >
> > > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > > index c3cbeb13de503555adcf00029a0b328e74381f13..da23265bc8b3cf43c0a1c=
89fbc4f53815a290e13 100644
> > > --- a/scripts/Makefile.btf
> > > +++ b/scripts/Makefile.btf
> > > @@ -22,6 +22,7 @@ else
> > >
> > > # Switch to using --btf_features for v1.26 and later.
> > > pahole-flags-$(call test-ge, $(pahole-ver), 126) =3D -j$(JOBS) --btf_=
features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,c=
onsistent_func,decl_tag_kfuncs
> > > +pahole-flags-$(if $(KBUILD_BUILD_TIMESTAMP),y) +=3D --btf_features=
=3Dreproducible_build
> >
> > Hi Thomas,
> >
> > There are a couple of issues with reproducible_build flag which I
> > think are worth mentioning here. I don't know all the reasons behind
> > adding this now, and it's optional too, so feel free to discard my
> > comments.
> >
> > Currently with this flag, the BTF output is deterministic for a given
> > order of DWARF compilation units. So the BTF will be the same for the
> > same vmlinux binary. However, if the vmlinux is rebuilt due to an
> > incremental change in a source code, my understanding is that there is
> > no guarantee that DWARF CUs will be in the same order in the binary.
>
> The goal behind reproducible builds is to produce bit-by-bit idential
> binaries. If the CUs are in a different order then that requirement
> would have been broken there already.

I'm curious, how do we guarantee that we get bit-by-bit identical
DWARF? Do we enforce the order of linking of .o files into the final
vmlinux? Is this described anywhere?

>
> For an incremental build a full relink with *all* CUs is done, not only
> the changed once, so the order should always be the same.

The concern here is whether linker guarantees that CUs' DWARF data
will be appended in exactly the same order in such case?

>
> > At the same time, reproducible_build slows down BTF generation by
> > 30-50%, maybe more depending on the kernel config.
>
> If a user explicitly requests reproducibility then they should get it,
> even if it is slower.
>
> > Hopefully these problems will be solved in upcoming pahole releases.
>
> I don't see it as big problem. This is used for release builds, not
> during development.
>
> > Question: why KBUILD_BUILD_TIMESTAMP flag? Isn't it more appropriate
> > to use a separate flag for this particular feature?
>
> Adding an additional variable would need to be documented and would
> makes the feature harder to use. KBUILD_BUILD_TIMESTAMP already needs to
> be set by the user if they are building for reproducibility.
>
> > > ifneq ($(KBUILD_EXTMOD),)
> > > module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_fe=
atures=3Ddistilled_base
> > >
> > > ---
> > > base-commit: 7cb1b466315004af98f6ba6c2546bb713ca3c237
> > > change-id: 20241124-pahole-reproducible-2b879ac8bdab
> > >
> > > Best regards,
> > > --
> > > Thomas Wei=C3=9Fschuh linux@weissschuh.net
> > >
> > >
> >


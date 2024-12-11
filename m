Return-Path: <bpf+bounces-46594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD619EC4B8
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 07:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCBB188B7A2
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0F2451C0;
	Wed, 11 Dec 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Hj5YnUae"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC331C462D;
	Wed, 11 Dec 2024 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898289; cv=none; b=EPN4bkLh1PNTVTUifBmsZQsXojWu54owLfAuEv8SMHvr3pVZAIB4Kja92jfmUN/X2S91aY5b+455NFBCgNDtHQTsqUksXC+04NLYnaaCjOU+J6zFSMWXgOpI209b2j0ea+h2sD/Usw1JuVoFCEs1gQh1b7n5YYfQCuHnwCoMvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898289; c=relaxed/simple;
	bh=y7aZHwpgi27v8ZTlv7YlS3FJfZiEfiPR2Bpm7+DPGJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+5eMNwFiW6oDw4XrpcHDCLOr4DdUpyX2OeBNCZcWuFKhrbAeHsv89ZI+yFDdk3HRCdcwj/UPTxxKXJ5/h6eLi7GSJXtkUcnE6Jrpz1sKEXItdKEXL1gGdp2lSBnN0YG4zin3wddV4KiT37ryJub65nIwGGOZqME8ia65mt/T1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Hj5YnUae; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733898280;
	bh=y7aZHwpgi27v8ZTlv7YlS3FJfZiEfiPR2Bpm7+DPGJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hj5YnUaeQAs5jb6PfRT6vy2lo43gPnqlBH3DYu+Hr07ugu7fe47ya0s4kPR8GNWnf
	 BrA8qk/QLBD1RFKO9Evifp10s7ZtUYAWLVrbE1JDSUW2W7nR5eOMQMHXFI5UA4c+O7
	 m/UDbyxHeTGtFCZq0WpwFugz9bC5T1qKeZ/SW4ow=
Date: Wed, 11 Dec 2024 07:24:40 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Kui-Feng Lee <kuifeng@fb.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation
Message-ID: <3b834807-9f20-4f04-b788-f45dfac5cb1f@t-8ch.de>
References: <20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net>
 <REDzg-0aL2-Qw7QvYCKTfsLGh6E6Iq8dgWJPo5a94ym2x5DiUkwdHA-naUtaDO7HJgvOr6zd201E5P_WAquOyOFIiUij6Bi183EyxPusDuo=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <REDzg-0aL2-Qw7QvYCKTfsLGh6E6Iq8dgWJPo5a94ym2x5DiUkwdHA-naUtaDO7HJgvOr6zd201E5P_WAquOyOFIiUij6Bi183EyxPusDuo=@pm.me>

Hi Ihor,

On 2024-12-11 00:17:02+0000, Ihor Solodrai wrote:
> On Tuesday, December 10th, 2024 at 3:23 PM, Thomas Weißschuh <linux@weissschuh.net> wrote:
> 
> > 
> > 
> > Pahole v1.27 added a new BTF generation feature to support
> > reproducibility in the face of multithreading.
> > Enable it if supported and reproducible builds are requested.
> > 
> > As unknown --btf_features are ignored, avoid the test for the pahole
> > version to keep the line readable.
> > 
> > Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.")
> > Fixes: 72d091846de9 ("kbuild: avoid too many execution of scripts/pahole-flags.sh")
> > Link: https://lore.kernel.org/lkml/4154d202-5c72-493e-bf3f-bce882a296c6@gentoo.org/
> > Link: https://lore.kernel.org/lkml/20240322-pahole-reprodicible-v1-1-3eaafb1842da@weissschuh.net/
> > Signed-off-by: Thomas Weißschuh linux@weissschuh.net
> > 
> > ---
> > scripts/Makefile.btf | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index c3cbeb13de503555adcf00029a0b328e74381f13..da23265bc8b3cf43c0a1c89fbc4f53815a290e13 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -22,6 +22,7 @@ else
> > 
> > # Switch to using --btf_features for v1.26 and later.
> > pahole-flags-$(call test-ge, $(pahole-ver), 126) = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> > +pahole-flags-$(if $(KBUILD_BUILD_TIMESTAMP),y) += --btf_features=reproducible_build
> 
> Hi Thomas,
> 
> There are a couple of issues with reproducible_build flag which I
> think are worth mentioning here. I don't know all the reasons behind
> adding this now, and it's optional too, so feel free to discard my
> comments.
> 
> Currently with this flag, the BTF output is deterministic for a given
> order of DWARF compilation units. So the BTF will be the same for the
> same vmlinux binary. However, if the vmlinux is rebuilt due to an
> incremental change in a source code, my understanding is that there is
> no guarantee that DWARF CUs will be in the same order in the binary.

The goal behind reproducible builds is to produce bit-by-bit idential
binaries. If the CUs are in a different order then that requirement
would have been broken there already.

For an incremental build a full relink with *all* CUs is done, not only
the changed once, so the order should always be the same.

> At the same time, reproducible_build slows down BTF generation by
> 30-50%, maybe more depending on the kernel config.

If a user explicitly requests reproducibility then they should get it,
even if it is slower.

> Hopefully these problems will be solved in upcoming pahole releases.

I don't see it as big problem. This is used for release builds, not
during development.
 
> Question: why KBUILD_BUILD_TIMESTAMP flag? Isn't it more appropriate
> to use a separate flag for this particular feature?

Adding an additional variable would need to be documented and would
makes the feature harder to use. KBUILD_BUILD_TIMESTAMP already needs to
be set by the user if they are building for reproducibility.

> > ifneq ($(KBUILD_EXTMOD),)
> > module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
> > 
> > ---
> > base-commit: 7cb1b466315004af98f6ba6c2546bb713ca3c237
> > change-id: 20241124-pahole-reproducible-2b879ac8bdab
> > 
> > Best regards,
> > --
> > Thomas Weißschuh linux@weissschuh.net
> > 
> > 
> 


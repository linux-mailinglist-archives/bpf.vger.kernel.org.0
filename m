Return-Path: <bpf+bounces-46764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1689F0032
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3663118827AD
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115C1DED40;
	Thu, 12 Dec 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cniv/Rfo"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BE1B4154;
	Thu, 12 Dec 2024 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046291; cv=none; b=ZCdGP2+aKqIc/9PZQAxnsi6ajQCxObtVDzi3dZv/Shd63uYBYzkTmf0Y4s5RNs/ygIGFzO77LPnegn1ZQImzuTcz59mj5ZXebgZnjlx+Y+i9PLtyKkDh5CYuriB8UqZjyhUdP51DkpV10dCqzVxQQOK91ut0sJOpUFQhrhGJN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046291; c=relaxed/simple;
	bh=oOF4p4MHr1ZNzSbOMCjaFepd74L3QQpop/CuaAmcjL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6NaIcHcMGovp9DEfXaEYtmG5XhxP5beXJo0zi0/rykz0bffw4DXSjnDFm/eLE2j+wZqOATSJXpWKaveoP2NAm4WpluL+IKQNmjuAOj8waWXFvhjeEVysNyYrgK84zLoND21CF53iDvQvV4S+xk2PVl/k6oR6/x3lusnsey5Ilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cniv/Rfo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734046284;
	bh=oOF4p4MHr1ZNzSbOMCjaFepd74L3QQpop/CuaAmcjL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cniv/RfobymFfKRKjJzZYWL9xAJ04IDOIMY+9BpR62NsP6LEpLCOun7c4s2gATqnN
	 iB+nDFS0c7mGopuUptagNqO0/3Q0AYuw5HSf9w9tZ9y2M1/DX/6hfRtzAjvMdIZF70
	 uu6LglAcBeOJXjpwfrXVXmomwgDuj6yz2Bgmtmu4=
Date: Fri, 13 Dec 2024 00:31:23 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Kui-Feng Lee <kuifeng@fb.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation
Message-ID: <87305847-5741-4c4e-a806-c8f9bea2345d@t-8ch.de>
References: <20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net>
 <REDzg-0aL2-Qw7QvYCKTfsLGh6E6Iq8dgWJPo5a94ym2x5DiUkwdHA-naUtaDO7HJgvOr6zd201E5P_WAquOyOFIiUij6Bi183EyxPusDuo=@pm.me>
 <3b834807-9f20-4f04-b788-f45dfac5cb1f@t-8ch.de>
 <CAEf4BzZSB2nzhYag_LKACXXJLwqLLfddXMV9_JRGYi+Y48rC-w@mail.gmail.com>
 <acf36eab-f906-42f7-9299-1473c0451dd1@t-8ch.de>
 <CAEf4Bzaa+X4K3_NApFYHxWP1P7stnAvZH4to65D1600fie6H3w@mail.gmail.com>
 <29f9911f-38b0-4634-95d4-0a55ef0a61fa@t-8ch.de>
 <CAEf4BzZ+3_CoNDhpbiXORTw1VYkWDiy-QKp+cai_Mj05vEWsmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ+3_CoNDhpbiXORTw1VYkWDiy-QKp+cai_Mj05vEWsmg@mail.gmail.com>

On 2024-12-12 15:21:14-0800, Andrii Nakryiko wrote:
> On Thu, Dec 12, 2024 at 3:19 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > On 2024-12-12 14:54:36-0800, Andrii Nakryiko wrote:
> > > On Thu, Dec 12, 2024 at 1:07 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > >
> > > > Hi Andrii,
> > > >
> > > > On 2024-12-12 11:23:03-0800, Andrii Nakryiko wrote:
> > > > > On Tue, Dec 10, 2024 at 10:24 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > > > > On 2024-12-11 00:17:02+0000, Ihor Solodrai wrote:
> > > > > > > On Tuesday, December 10th, 2024 at 3:23 PM, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Pahole v1.27 added a new BTF generation feature to support
> > > > > > > > reproducibility in the face of multithreading.
> > > > > > > > Enable it if supported and reproducible builds are requested.
> > > > > > > >
> > > > > > > > As unknown --btf_features are ignored, avoid the test for the pahole
> > > > > > > > version to keep the line readable.
> > > > > > > >
> > > > > > > > Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.")
> > > > > > > > Fixes: 72d091846de9 ("kbuild: avoid too many execution of scripts/pahole-flags.sh")
> > > > > > > > Link: https://lore.kernel.org/lkml/4154d202-5c72-493e-bf3f-bce882a296c6@gentoo.org/
> > > > > > > > Link: https://lore.kernel.org/lkml/20240322-pahole-reprodicible-v1-1-3eaafb1842da@weissschuh.net/
> > > > > > > > Signed-off-by: Thomas Weißschuh linux@weissschuh.net
> > > > > > > >
> > > > > > > > ---
> > > > > > > > scripts/Makefile.btf | 1 +
> > > > > > > > 1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > > > > > > > index c3cbeb13de503555adcf00029a0b328e74381f13..da23265bc8b3cf43c0a1c89fbc4f53815a290e13 100644
> > > > > > > > --- a/scripts/Makefile.btf
> > > > > > > > +++ b/scripts/Makefile.btf
> > > > > > > > @@ -22,6 +22,7 @@ else
> > > > > > > >
> > > > > > > > # Switch to using --btf_features for v1.26 and later.
> > > > > > > > pahole-flags-$(call test-ge, $(pahole-ver), 126) = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> > > > > > > > +pahole-flags-$(if $(KBUILD_BUILD_TIMESTAMP),y) += --btf_features=reproducible_build
> > > > > > >
> > > > > > > Hi Thomas,
> > > > > > >
> > > > > > > There are a couple of issues with reproducible_build flag which I
> > > > > > > think are worth mentioning here. I don't know all the reasons behind
> > > > > > > adding this now, and it's optional too, so feel free to discard my
> > > > > > > comments.
> > > > > > >
> > > > > > > Currently with this flag, the BTF output is deterministic for a given
> > > > > > > order of DWARF compilation units. So the BTF will be the same for the
> > > > > > > same vmlinux binary. However, if the vmlinux is rebuilt due to an
> > > > > > > incremental change in a source code, my understanding is that there is
> > > > > > > no guarantee that DWARF CUs will be in the same order in the binary.
> > > > > >
> > > > > > The goal behind reproducible builds is to produce bit-by-bit idential
> > > > > > binaries. If the CUs are in a different order then that requirement
> > > > > > would have been broken there already.
> > > > >
> > > > > I'm curious, how do we guarantee that we get bit-by-bit identical
> > > > > DWARF? Do we enforce the order of linking of .o files into the final
> > > > > vmlinux? Is this described anywhere?
> > > >
> > > > The CU order has to be fixed, otherwise the non-debugging parts of the
> > > > binary would not be reproducible either.
> > > > For docs is Documentation/kbuild/reproducible-builds.rst, the linked
> > > > reproducible-builds.org project has much more information.
> > > >
> > > > Also besides reproducible builds, lots of kernel components rely
> > > > (accidentally or intentionally) on a stable initialization order, which
> > > > is also defined by linking order.
> > > >
> > > > From Documentation/kbuild/makefiles.rst:
> > > >
> > > >         Link order is significant, because certain functions
> > > >         (module_init() / __initcall) will be called during boot in the
> > > >         order they appear. So keep in mind that changing the link
> > > >         order may e.g. change the order in which your SCSI
> > > >         controllers are detected, and thus your disks are renumbered.
> > > >
> > > > > > For an incremental build a full relink with *all* CUs is done, not only
> > > > > > the changed once, so the order should always be the same.
> > > > >
> > > > > The concern here is whether linker guarantees that CUs' DWARF data
> > > > > will be appended in exactly the same order in such case?
> > > >
> > > > Otherwise it wouldn't be reproducible in general.
> > > > The pahole developers specifically implemented
> > > > --btf_features=reproducible_build for use in the kernel; after I sent
> > > > a precursor patch to this one (also linked in the patch):
> > > >
> > > > https://lore.kernel.org/lkml/20240322-pahole-reprodicible-v1-1-3eaafb1842da@weissschuh.net/
> > > >
> > > > In general the kernel already supports reproducible builds.
> > >
> > > Great, thanks for all the info!
> > >
> > > I do agree with Ihor that KBUILD_BUILD_TIMESTAMP is a non-obvious and
> > > surprising way to enable this behavior, but if that's what's used for
> > > other aspects of kernel build I guess it's fine by me.
> >
> > Agreed. So far KBUILD_BUILD_TIMESTAMP is really only used for timestamp
> > related configuration. While it's not a perfect fit, adding yet another
> > switch that needs to be specified can't be the answer, either.
> >
> > Maybe the Kbuild maintainers have some preference?
> 
> Wouldn't KBUILD_REPRODUCIBLE_BUILD=y be the logical thing to have for
> all these things that affect exact reproducibility?

The other settings aren't booleans:

KBUILD_BUILD_TIMESTAMP, KBUILD_BUILD_VERSION, KBUILD_BUILD_HOST,
KBUILD_BUILD_USER.

Out of these not all *need* to be used. They can already be implicitly
fixed by the general build environment.
That doesn't work for KBUILD_BUILD_TIMESTAMP, so I used it for the basic
boolean detection.

> > > Ihor's work on making BTF generation more deterministic w.r.t. CU
> > > order would automatically benefit --btf_features=reproducible_build in
> > > the end and might make it unnecessary, but there is no need to block
> > > on a completion of that work.
> >
> > Sounds good.
> >
> > [..]


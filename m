Return-Path: <bpf+bounces-36822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24294DACD
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 07:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325E0282D5C
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 05:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB8813BC0B;
	Sat, 10 Aug 2024 05:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bxt12D9J"
X-Original-To: bpf@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19543AB9;
	Sat, 10 Aug 2024 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266181; cv=none; b=XLnGXpibHQrQ+hxk56yk9MeCVdPS2TWaS/fydlQ6ouTiiBGTvgCBPLGRA7kHHzfioVicDxDWqztGlfx1bFvcS9rNTq63VGrwpijLZgFBNTBj4iAbB5NaOXNWZblZ4GeSmeN281moZmd5M2/7wADqEWP9EKWXIicdewQ8i1hmaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266181; c=relaxed/simple;
	bh=p90VjkHd2QSyI8gT0inSZQc3MjLbk9DQli2MMojVYxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRUWqkAwS7eiOf9xKhUqFqTNMofv7fDmHMK9d0YjE2nHBwu8TGM3WNrVak0Il+dqEXHKA170wdkBV3QefrQ4+nG2/bRvxlL1hEI0wF/g1W3YjfutcwYbluXh2SIaYzXbABPpGP5eDaQCR42HZexzUUwP00pprqfV/TLl9TACZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bxt12D9J; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=TKG+hP+MGaJcpG0oBhsja88fT5jqXMjmRyL9ouWt+d8=; b=bxt12D9Ji/p6jCn44E8utmb17D
	PyiIkjjSF9cp5+gxfeP15vQCP16pm/a1gXSakW2ZmrV/x5SAEbilaufYH2eWdE0YmvBaumJNLvryi
	5c8s0CW1h3gTlS9361X/YfHvj/UOtP2sVAFjpWrx8//s2gLyoHs3FgCgvPIzXlOGsRwpKlyZTVv7i
	xZJ8TQRysHxPfBEpunUDxYRz+/QoEC6VpkhQrghLTlKVXRJ1iOnTKCk4Bgy7H7icsytLHr0lnXZlA
	au0IbTK9x/hX8Wx/wVdlvYl7a7seMfFKHkXsW+3TSUp4NLs9MJLeNoXlcKDpjjv/TrKbEbtha4Ru4
	olpwOSDg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1sceFN-003iGQ-F4; Sat, 10 Aug 2024 05:02:33 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id F1440BE2DE0; Sat, 10 Aug 2024 07:02:31 +0200 (CEST)
Date: Sat, 10 Aug 2024 07:02:31 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Hardik Garg <hargar@linux.microsoft.com>,
	Akemi Yagi <toracat@elrepo.org>, bpf@vger.kernel.org,
	Sahil Siddiq <icegambit91@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tao Chen <chen.dylane@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
Message-ID: <Zrb0Z0MJDkSzFwDD@eldamar.lan>
References: <20240808091131.014292134@linuxfoundation.org>
 <ZrSe8gZ_GyFv1knq@eldamar.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZrSe8gZ_GyFv1knq@eldamar.lan>
X-Debian-User: carnil

Hi Greg,

[adding as well people involved in the original commit and the
backporting for 6.1.y branch]

On Thu, Aug 08, 2024 at 12:33:22PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
>=20
> On Thu, Aug 08, 2024 at 11:11:49AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.104 release.
> > There are 86 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
> > Anything received after that time might be too late.
>=20
> Sorry for bothering you again with it (see previous comment on
> 6.1.103, respectively 6.1.104-rc1): bpftool still would fail to
> compile:
>=20
> gcc -O2 -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initial=
izers -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -=
Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wno-sy=
stem-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-pro=
totypes -Wswitch-default -Wundef -Wwrite-strings -Wformat -Wno-type-limits =
-Wstrict-aliasing=3D3 -Wshadow -DPACKAGE=3D'"bpftool"' -D__EXPORTED_HEADERS=
__ -I. -I/home/build/linux-stable-rc/tools/bpf/bpftool/libbpf/include -I/ho=
me/build/linux-stable-rc/kernel/bpf/ -I/home/build/linux-stable-rc/tools/in=
clude -I/home/build/linux-stable-rc/tools/include/uapi -DUSE_LIBCAP -DBPFTO=
OL_WITHOUT_SKELETONS -c -MMD prog.c -o prog.o
> prog.c: In function =E2=80=98load_with_options=E2=80=99:
> prog.c:1710:23: warning: implicit declaration of function =E2=80=98create=
_and_mount_bpffs_dir=E2=80=99 [-Wimplicit-function-declaration]
>  1710 |                 err =3D create_and_mount_bpffs_dir(pinmaps);
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> gcc -O2 -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initial=
izers -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -=
Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wno-sy=
stem-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-pro=
totypes -Wswitch-default -Wundef -Wwrite-strings -Wformat -Wno-type-limits =
-Wstrict-aliasing=3D3 -Wshadow -DPACKAGE=3D'"bpftool"' -D__EXPORTED_HEADERS=
__ -I. -I/home/build/linux-stable-rc/tools/bpf/bpftool/libbpf/include -I/ho=
me/build/linux-stable-rc/kernel/bpf/ -I/home/build/linux-stable-rc/tools/in=
clude -I/home/build/linux-stable-rc/tools/include/uapi -DUSE_LIBCAP -DBPFTO=
OL_WITHOUT_SKELETONS  btf.o btf_dumper.o cfg.o cgroup.o common.o feature.o =
gen.o iter.o json_writer.o link.o main.o map.o map_perf_ring.o net.o netlin=
k_dumper.o perf.o pids.o prog.o struct_ops.o tracelog.o xlated_dumper.o dis=
asm.o /home/build/linux-stable-rc/tools/bpf/bpftool/libbpf/libbpf.a -lelf -=
lz -lcap -o bpftool
> /bin/ld: prog.o: in function `load_with_options':
> prog.c:(.text+0x2f98): undefined reference to `create_and_mount_bpffs_dir'
> /bin/ld: prog.c:(.text+0x2ff2): undefined reference to `create_and_mount_=
bpffs_dir'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:216: bpftool] Error 1
> make: *** [Makefile:113: bpftool] Error 2
>=20
> Reverting 65dd9cbafec2f6f7908cebcab0386f750fc352af fixes the issue. In
> fact 65dd9cbafec2f6f7908cebcab0386f750fc352af is the only commit
> adding call to create_and_mount_bpffs_dir:
>=20
> $ git grep create_and_mount_bpffs_dir
> tools/bpf/bpftool/prog.c:               err =3D create_and_mount_bpffs_di=
r(pinmaps);

Just one additional note, at least 478a535ae54a ("bpftool: Mount bpffs
on provided dir instead of parent dir") would be a reqisite where the
code was refactored introducing create_and_mount_bpffs_dir() (but
won't apply cleanly to 6.1.y). But are more requisites needed?

Should it be safest to just revert the breaking commit for the bpftool
build?

Regards,
Salvatore


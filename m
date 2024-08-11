Return-Path: <bpf+bounces-36844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8635D94E1CC
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B21DB20F4C
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C514AD1B;
	Sun, 11 Aug 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fau1z7AZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC5EAE9;
	Sun, 11 Aug 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723389827; cv=none; b=Rjq2XsCj+Awum5apm/AsmDNiZ/RZM2sy2CKgnrHQl1+znhwCyevC/2hDxB6EGTQClh/EVIaBNS7HoDh+jE31DKe1eEEde99UmHjxCyLu0i26N6qXuUnRv8EWpWKLuzTil26WwOIlq0x4x/9qhJG/YGcmnJb5UC5J2A1v31r80ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723389827; c=relaxed/simple;
	bh=57g39IjfXNOwZ61SWI0t7hwoHDPUjJeSMIaexpKjUV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrQONPEVHZwqm8NSc2iLXoP/wWRKUE4nsmCkyG8fhQZVru6feKlBsFdr5CXj1yI4WfpFnVUGOqA2nshRoO+6+0VjmT52FvP1s2eBL7+NWrzWaQsUfgWOGdX/R5MO7woLLn+b77ko6w+o/GcpBGR+ark360XYVF+MDsn5PMhERg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fau1z7AZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DF7C32786;
	Sun, 11 Aug 2024 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723389826;
	bh=57g39IjfXNOwZ61SWI0t7hwoHDPUjJeSMIaexpKjUV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fau1z7AZTE3tclQxwjXDE51JWtk0YTGz+s6n5qVQOdVjJsNixiJDsa9bsdvR3oGf+
	 8HG/7wPCu5LguQjWWK4FoOZ/uc5JaSTHQlH8wYA1nGbig8PYHjJ8EUZu848/ckJVxf
	 dZI1M/DZ3wqR8x9JRemFfgJy6ZR6zhXQ3ALxYTe4=
Date: Sun, 11 Aug 2024 17:23:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Hardik Garg <hargar@linux.microsoft.com>,
	Akemi Yagi <toracat@elrepo.org>, bpf@vger.kernel.org,
	Sahil Siddiq <icegambit91@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tao Chen <chen.dylane@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
Message-ID: <2024081120-unwary-atrocious-567c@gregkh>
References: <20240808091131.014292134@linuxfoundation.org>
 <ZrSe8gZ_GyFv1knq@eldamar.lan>
 <Zrb0Z0MJDkSzFwDD@eldamar.lan>
 <67bfcb8a-e00e-47b2-afe2-970a60e4a173@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <67bfcb8a-e00e-47b2-afe2-970a60e4a173@kernel.org>

On Sat, Aug 10, 2024 at 10:36:20PM +0100, Quentin Monnet wrote:
> 2024-08-10 07:02 UTC+0200 ~ Salvatore Bonaccorso <carnil@debian.org>
> > Hi Greg,
> >=20
> > [adding as well people involved in the original commit and the
> > backporting for 6.1.y branch]
> >=20
> > On Thu, Aug 08, 2024 at 12:33:22PM +0200, Salvatore Bonaccorso wrote:
> >> Hi Greg,
> >>
> >> On Thu, Aug 08, 2024 at 11:11:49AM +0200, Greg Kroah-Hartman wrote:
> >>> This is the start of the stable review cycle for the 6.1.104 release.
> >>> There are 86 patches in this series, all will be posted as a response
> >>> to this one.  If anyone has any issues with these being applied, plea=
se
> >>> let me know.
> >>>
> >>> Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
> >>> Anything received after that time might be too late.
> >>
> >> Sorry for bothering you again with it (see previous comment on
> >> 6.1.103, respectively 6.1.104-rc1): bpftool still would fail to
> >> compile:
> >>
> >> gcc -O2 -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-init=
ializers -Wbad-function-cast -Wdeclaration-after-statement -Wformat-securit=
y -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wno=
-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-=
prototypes -Wswitch-default -Wundef -Wwrite-strings -Wformat -Wno-type-limi=
ts -Wstrict-aliasing=3D3 -Wshadow -DPACKAGE=3D'"bpftool"' -D__EXPORTED_HEAD=
ERS__ -I. -I/home/build/linux-stable-rc/tools/bpf/bpftool/libbpf/include -I=
/home/build/linux-stable-rc/kernel/bpf/ -I/home/build/linux-stable-rc/tools=
/include -I/home/build/linux-stable-rc/tools/include/uapi -DUSE_LIBCAP -DBP=
FTOOL_WITHOUT_SKELETONS -c -MMD prog.c -o prog.o
> >> prog.c: In function =E2=80=98load_with_options=E2=80=99:
> >> prog.c:1710:23: warning: implicit declaration of function =E2=80=98cre=
ate_and_mount_bpffs_dir=E2=80=99 [-Wimplicit-function-declaration]
> >>  1710 |                 err =3D create_and_mount_bpffs_dir(pinmaps);
> >>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >> gcc -O2 -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-init=
ializers -Wbad-function-cast -Wdeclaration-after-statement -Wformat-securit=
y -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wno=
-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-=
prototypes -Wswitch-default -Wundef -Wwrite-strings -Wformat -Wno-type-limi=
ts -Wstrict-aliasing=3D3 -Wshadow -DPACKAGE=3D'"bpftool"' -D__EXPORTED_HEAD=
ERS__ -I. -I/home/build/linux-stable-rc/tools/bpf/bpftool/libbpf/include -I=
/home/build/linux-stable-rc/kernel/bpf/ -I/home/build/linux-stable-rc/tools=
/include -I/home/build/linux-stable-rc/tools/include/uapi -DUSE_LIBCAP -DBP=
FTOOL_WITHOUT_SKELETONS  btf.o btf_dumper.o cfg.o cgroup.o common.o feature=
=2Eo gen.o iter.o json_writer.o link.o main.o map.o map_perf_ring.o net.o n=
etlink_dumper.o perf.o pids.o prog.o struct_ops.o tracelog.o xlated_dumper.=
o disasm.o /home/build/linux-stable-rc/tools/bpf/bpftool/libbpf/libbpf.a -l=
elf -lz -lcap -o bpftool
> >> /bin/ld: prog.o: in function `load_with_options':
> >> prog.c:(.text+0x2f98): undefined reference to `create_and_mount_bpffs_=
dir'
> >> /bin/ld: prog.c:(.text+0x2ff2): undefined reference to `create_and_mou=
nt_bpffs_dir'
> >> collect2: error: ld returned 1 exit status
> >> make[1]: *** [Makefile:216: bpftool] Error 1
> >> make: *** [Makefile:113: bpftool] Error 2
> >>
> >> Reverting 65dd9cbafec2f6f7908cebcab0386f750fc352af fixes the issue. In
> >> fact 65dd9cbafec2f6f7908cebcab0386f750fc352af is the only commit
> >> adding call to create_and_mount_bpffs_dir:
> >>
> >> $ git grep create_and_mount_bpffs_dir
> >> tools/bpf/bpftool/prog.c:               err =3D create_and_mount_bpffs=
_dir(pinmaps);
> >=20
> > Just one additional note, at least 478a535ae54a ("bpftool: Mount bpffs
> > on provided dir instead of parent dir") would be a reqisite where the
> > code was refactored introducing create_and_mount_bpffs_dir() (but
> > won't apply cleanly to 6.1.y). But are more requisites needed?
> >=20
> > Should it be safest to just revert the breaking commit for the bpftool
> > build?
> >=20
> > Regards,
> > Salvatore
> >=20
>=20
> Hi,
>=20
> You should be able to fix the build by first cherry-picking commit
> 2a36c26fe3b8 ("bpftool: Support bpffs mountpoint as pin path for prog
> loadall"),

That commit does not apply cleanly :(

I'll just go revert the original here, that makes it simpler overall.

thanks,

greg k-h


Return-Path: <bpf+bounces-36840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2694DECB
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 23:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFD281B6F
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 21:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C813E023;
	Sat, 10 Aug 2024 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ots8z0Sz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87A3AC2B;
	Sat, 10 Aug 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723325789; cv=none; b=godDP7ZqVck/VfSbKcXQ34uHvNcR9uPjx4qTTe9vACQGoB6JXWVbxXA2DCgUf1WfQ1+vBDoSe9v3+twGyG4RQA9934r2IzeVVhNBZVshiZh6emeKi05XFmban1GuW4l5wsY9bVB8/mHkD3xdf4rc3qqr1vWpoS+c2LI2IbSRLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723325789; c=relaxed/simple;
	bh=NPD6oAZbb8VbzqFH1mXAxFDKJ+lEi3tTLo8Gzty3uMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMhrgKggHiqA6GILFfvR9hjmwDyVbgyHhoMyxzjmcKkGOHm9lzx8TwYIrAa1ZwVnDRycHF0PsdRit9Upk6u0/thje0DB8D7aIHhZISRsotrCiJowxubVlG72mxVRSs4dTfigPEKPGBK1RRCKhSrzUGt64Ugz/Svd2MGLy8SdEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ots8z0Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756CDC32781;
	Sat, 10 Aug 2024 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723325788;
	bh=NPD6oAZbb8VbzqFH1mXAxFDKJ+lEi3tTLo8Gzty3uMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ots8z0Szs02+YAQL1tzxe9vtfiocqFGUotcKEt2GSnYb9jrCImS/k9BSaUImvBaZy
	 H+MMBvH3RMWkNl88f7Bk5+WfJ2jJXR4rLbkXPw3rqQ96/Xl7DT+FvEBzlbAkL1zQmg
	 8H4xidNV9NbsRLJLM8lcsaK6a/93gjhGv+JCArGU+zHKpS12Vf/4H9dwO4ylWY4eFQ
	 IErETKTA0gHg5J1SIYBgzMA1p9B3ARGUvS7W3Bt9s0rWkZd/pygJVsujdaRAuHhTTz
	 34CU+I9wQFw89Id9tqOoe4iUlV9ArIwfbwiQFwxDdmEJn4D1dmZffu3+6GOKJvYdgK
	 491c9h9wh3bbQ==
Message-ID: <67bfcb8a-e00e-47b2-afe2-970a60e4a173@kernel.org>
Date: Sat, 10 Aug 2024 22:36:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
To: Salvatore Bonaccorso <carnil@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org,
 Hardik Garg <hargar@linux.microsoft.com>, Akemi Yagi <toracat@elrepo.org>,
 bpf@vger.kernel.org, Sahil Siddiq <icegambit91@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Tao Chen <chen.dylane@gmail.com>,
 Sasha Levin <sashal@kernel.org>
References: <20240808091131.014292134@linuxfoundation.org>
 <ZrSe8gZ_GyFv1knq@eldamar.lan> <Zrb0Z0MJDkSzFwDD@eldamar.lan>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <Zrb0Z0MJDkSzFwDD@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2024-08-10 07:02 UTC+0200 ~ Salvatore Bonaccorso <carnil@debian.org>
> Hi Greg,
>=20
> [adding as well people involved in the original commit and the
> backporting for 6.1.y branch]
>=20
> On Thu, Aug 08, 2024 at 12:33:22PM +0200, Salvatore Bonaccorso wrote:
>> Hi Greg,
>>
>> On Thu, Aug 08, 2024 at 11:11:49AM +0200, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.104 release.=

>>> There are 86 patches in this series, all will be posted as a response=

>>> to this one.  If anyone has any issues with these being applied, plea=
se
>>> let me know.
>>>
>>> Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
>>> Anything received after that time might be too late.
>>
>> Sorry for bothering you again with it (see previous comment on
>> 6.1.103, respectively 6.1.104-rc1): bpftool still would fail to
>> compile:
>>
>> gcc -O2 -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-init=
ializers -Wbad-function-cast -Wdeclaration-after-statement -Wformat-secur=
ity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes =
-Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Ws=
trict-prototypes -Wswitch-default -Wundef -Wwrite-strings -Wformat -Wno-t=
ype-limits -Wstrict-aliasing=3D3 -Wshadow -DPACKAGE=3D'"bpftool"' -D__EXP=
ORTED_HEADERS__ -I. -I/home/build/linux-stable-rc/tools/bpf/bpftool/libbp=
f/include -I/home/build/linux-stable-rc/kernel/bpf/ -I/home/build/linux-s=
table-rc/tools/include -I/home/build/linux-stable-rc/tools/include/uapi -=
DUSE_LIBCAP -DBPFTOOL_WITHOUT_SKELETONS -c -MMD prog.c -o prog.o
>> prog.c: In function =E2=80=98load_with_options=E2=80=99:
>> prog.c:1710:23: warning: implicit declaration of function =E2=80=98cre=
ate_and_mount_bpffs_dir=E2=80=99 [-Wimplicit-function-declaration]
>>  1710 |                 err =3D create_and_mount_bpffs_dir(pinmaps);
>>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> gcc -O2 -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-init=
ializers -Wbad-function-cast -Wdeclaration-after-statement -Wformat-secur=
ity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes =
-Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Ws=
trict-prototypes -Wswitch-default -Wundef -Wwrite-strings -Wformat -Wno-t=
ype-limits -Wstrict-aliasing=3D3 -Wshadow -DPACKAGE=3D'"bpftool"' -D__EXP=
ORTED_HEADERS__ -I. -I/home/build/linux-stable-rc/tools/bpf/bpftool/libbp=
f/include -I/home/build/linux-stable-rc/kernel/bpf/ -I/home/build/linux-s=
table-rc/tools/include -I/home/build/linux-stable-rc/tools/include/uapi -=
DUSE_LIBCAP -DBPFTOOL_WITHOUT_SKELETONS  btf.o btf_dumper.o cfg.o cgroup.=
o common.o feature.o gen.o iter.o json_writer.o link.o main.o map.o map_p=
erf_ring.o net.o netlink_dumper.o perf.o pids.o prog.o struct_ops.o trace=
log.o xlated_dumper.o disasm.o /home/build/linux-stable-rc/tools/bpf/bpft=
ool/libbpf/libbpf.a -lelf -lz -lcap -o bpftool
>> /bin/ld: prog.o: in function `load_with_options':
>> prog.c:(.text+0x2f98): undefined reference to `create_and_mount_bpffs_=
dir'
>> /bin/ld: prog.c:(.text+0x2ff2): undefined reference to `create_and_mou=
nt_bpffs_dir'
>> collect2: error: ld returned 1 exit status
>> make[1]: *** [Makefile:216: bpftool] Error 1
>> make: *** [Makefile:113: bpftool] Error 2
>>
>> Reverting 65dd9cbafec2f6f7908cebcab0386f750fc352af fixes the issue. In=

>> fact 65dd9cbafec2f6f7908cebcab0386f750fc352af is the only commit
>> adding call to create_and_mount_bpffs_dir:
>>
>> $ git grep create_and_mount_bpffs_dir
>> tools/bpf/bpftool/prog.c:               err =3D create_and_mount_bpffs=
_dir(pinmaps);
>=20
> Just one additional note, at least 478a535ae54a ("bpftool: Mount bpffs
> on provided dir instead of parent dir") would be a reqisite where the
> code was refactored introducing create_and_mount_bpffs_dir() (but
> won't apply cleanly to 6.1.y). But are more requisites needed?
>=20
> Should it be safest to just revert the breaking commit for the bpftool
> build?
>=20
> Regards,
> Salvatore
>=20

Hi,

You should be able to fix the build by first cherry-picking commit
2a36c26fe3b8 ("bpftool: Support bpffs mountpoint as pin path for prog
loadall"), and then commit 478a535ae54a ("bpftool: Mount bpffs on
provided dir instead of parent dir") as you figured. Both commits have a
minor conflict on tools/bpf/bpftool/struct_ops.c, which should be
addressed by discarding the relevant hunk (for both commit).

Alternatively, it's also fine to revert the breaking commit. It's a
quality of life improvement without which users may have to manually
mount the bpffs at the location they want to pin their maps when loading
multiple BPF programs with "bpftool prog loadall", in the unlikely event
they're not using /sys/kernel/bpf, prior to running the bpftool command.
It's not in use during the kernel build process or for the BPF
selftests, so not necessary on stable branches.

I hope this helps,
Quentin


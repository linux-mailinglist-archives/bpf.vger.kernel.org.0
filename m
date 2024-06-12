Return-Path: <bpf+bounces-31903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E190499F
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 05:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFDF285D9B
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 03:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC0179B7;
	Wed, 12 Jun 2024 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="Wdl0BT3q"
X-Original-To: bpf@vger.kernel.org
Received: from lf-2-36.ptr.blmpb.com (lf-2-36.ptr.blmpb.com [101.36.218.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E35208A8
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162687; cv=none; b=T0Jq5qXy9dE5ywJs+QnSb4SSHGhaVWGCBu2mI5x7qD7UoWmVtfuK5aZubhQER7Bfab8UQwJvgAD83GDVccZgOgS4Bg8vz1j6/5br6qKDd45cT/z+gKl8Qx8brO/fH9eBNsFqsO7KcKCwmJU0WKqumJhBANPeg0YkxitFSUDosZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162687; c=relaxed/simple;
	bh=kgp3NkghzOefzkOS2KGRWV5D4StUnIyV3p4BlRfFHw0=;
	h=Mime-Version:Content-Type:In-Reply-To:Cc:Date:Subject:Message-Id:
	 References:To:From; b=X7AIUsAAU0596FhZyDrpY0m0Q3fQ5Ceild0rFRHfZEceg2FUdwiDaOabp4mIpQpE7Ruv0f6zNcakmBEYjH5cg6jEEGOqraOZ2/vJpxowoV4z9zGfG1aOmS+m56WJ4bJWuUJM9hGhqwPMgjX5KhP0jRQ4EQN/GQYrd/hV5eyJIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=Wdl0BT3q; arc=none smtp.client-ip=101.36.218.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1718159948;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=2+Fz/PQ5wZ//fbujJB00EmLF+iGqzP4nPBqg4JDrJs8=;
 b=Wdl0BT3qKmKFd3DAP2XU/6UowjkRfUsbU3avAT4RcIxP8xk2r2XF1iNnj/Tp7Ax1M1P3qW
 gN77a9VP14pDEvXFztRYj6aiIe6nyAC8QCzaff+pvx8QXD1MeIisi/PLoQTPqFNNoeGNED
 TuPIIvhjxMZVM7fvLkFj/XO0dEKVDUQuMYPOjl/6DYAfHFPSG0ie+nKcg3EY9/E0LRpYo7
 anygXIycuZC/sjsQn71juf8c6WX1icBmPAQZmr23zpjg3QEJze4n6q5UifS9knMNia56Zm
 Neav7LSErQxhqfD5Y3n/Q8pRCVSmUEgzzO8jI2Q+m67hhDkInddyY6EOOx+TIQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <Zmfwhn6inA2m1ftm@kodidev-ubuntu>
Cc: "Mark Wielaard" <mjw@redhat.com>, "Hengqi Chen" <hengqi.chen@gmail.com>, 
	<bpf@vger.kernel.org>, <dwarves@vger.kernel.org>, 
	"Alexei Starovoitov" <ast@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Andrii Nakryiko" <andrii@kernel.org>
Date: Wed, 12 Jun 2024 10:39:02 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Lms-Return-Path: <lba+266690a4b+78e30c+vger.kernel.org+ying.huang@oss.cipunited.com>
X-Original-From: Ying Huang <ying.huang@oss.cipunited.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on mips64el
Message-Id: <9b6e3f83-07a6-47fe-a033-8b94e53c98f2@oss.cipunited.com>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu> <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com> <ZlmrQqQSJyNH7fVF@kodidev-ubuntu> <Zln1kZnu2Xxeyngj@x1> <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu> <Zl3Zp5r9m6X_i_J4@x1> <Zl4AHfG6Gg5Htdgc@x1> <20240603191833.GD4421@gnu.wildebeest.org> <Zl6OTJXw0LH6uWIN@kodidev-ubuntu> <Zmfwhn6inA2m1ftm@kodidev-ubuntu>
Received: from [192.168.8.113] ([171.15.156.97]) by smtp.feishu.cn with ESMTPS; Wed, 12 Jun 2024 10:39:06 +0800
To: "Tony Ambardar" <tony.ambardar@gmail.com>, 
	"Mark Wielaard" <mark@klomp.org>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>
From: "Ying Huang" <ying.huang@oss.cipunited.com>

Hi Tony,

Thanks for your fix about the conflict and test about the whole patch.

Now, there is currently one test case that has not been added, which is

tests/run-backtrace-core-mips.sh.
Thanks,
Ying
=E5=9C=A8 2024/6/11 14:36, Tony Ambardar =E5=86=99=E9=81=93:
> On Mon, Jun 03, 2024 at 08:47:24PM -0700, Tony Ambardar wrote:
>> Hi Mark,
>>
>> On Mon, Jun 03, 2024 at 09:18:33PM +0200, Mark Wielaard wrote:
>>> On Mon, Jun 03, 2024 at 02:40:45PM -0300, Arnaldo Carvalho de Melo wrot=
e:
>>>> Couldn't find a way to ask eu-readelf for more verbose output, where w=
e
>>>> could perhaps get some clue as to why it produces nothing while binuti=
ls
>>>> readelf manages to grok it, Mark, do you know some other way to ask
>>>> eu-readelf to produce more debug output?
>>>>
>>>> I'm unsure if the netdevsim.ko file was left in a semi encoded BTF sta=
te
>>>> that then made eu-readelf to not be able to process it while pahole,
>>>> that uses eltuils' libraries, was able to process the first two CUs fo=
r
>>>> a kernel module and all the CUs for the vmlinux file :-\
>>>>
>>>> Mark, the whole thread is available at:
>>>>
>>>> https://lore.kernel.org/all/Zl3Zp5r9m6X_i_J4@x1/T/#u
>>> I haven't looked at the vmlinux file. But for the .ko file the issue
>>> is that the elfutils MIPS backend isn't complete. Specifically MIPS
>>> relocations aren't recognized (and so cannot be applied). There are
>>> some pending patches which try to fix that:
>>>
>>> https://patchwork.sourceware.org/project/elfutils/list/?series=3D31601
>> Earlier in the thread, Hengqi Chen pointed out the latest elfutils backe=
nd
>> work for MIPS, and I locally rebuilt elfutils and then pahole from their
>> respective next/main branches. For elfutils, main (935ee131cf7c) include=
s
>>
>>   e259f126 Support Mips architecture
>>   f2acb069 stack: Fix stack unwind failure on mips
>>   db33cb0c backends: Add register_info, return_value_location, core_note=
 mips
>>
>> which partially applies the patchwork series but leaves out the support =
for
>> readelf, strip, and elflint.
>>
>> I believe this means the vmlinux and .ko files I shared are OK, or is th=
ere
>> more backend work needed for MIPS?
>>
>> The bits missing in eu-readelf would explain the blank output both Arnal=
do
>> and I see from "$ eu-readelf -winfo vmlinux". I tried rebuilding with th=
e
>> patchwork readelf patch locally but ran into merge conflicts.
>>
>> CCing Ying Huang for any more insight.
>>
>> Thanks,
>> Tony
> Hello all,
>
> A short update, starting with answering my own question.
>
> No, apparently the above commits *do not* complete the backend work. Ying
> Huang submitted additional related patches since March 5: [1][2]
>
>     strip: Adapt src/strip -o -f on mips
>     readelf: Adapt src/readelf -h/-S/-r/-w/-l/-d/-a on mips
>     elflint: adapt src/elflint --gnu src/nm on mips
>     test: Add mips in run-allregs.sh and run-readelf-mixed-corenote.sh
>
> Despite the titles, these patches do include core backend changes for MIP=
S.
> I resolved the various merge conflicts [3], rebuilt elfutils, and reteste=
d
> kernel builds to now find:
>
>   - pahole is able to read DWARF[45] info and create .BTF for modules
>   - resolve_btfids can successfully patch .BTF_ids in modules
>   - kernel successfully loads modules with BTF and kfuncs (tested 6.6 LTS=
)
>
> Huzzah!
>
>
> Ying:
>
> Thank you for developing these MIPS patches. In your view, are the MIPS
> changes now complete, or do you plan further updates that might improve o=
r
> impact parsing DWARF debug/reloc info in apps like pahole?
>
>
> Mark:
>
> Given that BTF usage on Linux/MIPS is basically broken without these
> patches, could I request some of your review time for them to be merged? =
If
> it's helpful, my branch [3] includes all patches with conflicts fixed, an=
d
> I also successfully ran the elfutils self-tests (including MIPS from Ying=
).
> Please feel free to add for these patches:
>
>     Tested-by: Tony Ambardar <Tony.Ambardar@gmail.com>
>
>
> Arnaldo:
>
> Your stepping through DWARF/reloc diagnostics earlier was helpful. Thanks=
!
> I reran your tests with the updated elfutils and latest pahole (pre-1.27)=
,
> and then found:
>
>   - everything that worked before, still works
>   - your observations from "btfdiff vmlinux" and 'struct dma_chan' persis=
t
>   - we now see expected output from "eu-readelf -winfo netdevsim.ko"
>
> Regarding pahole, DWARF parsing and BTF generation now works:
> (with no more die__process: error messages seen)
>
>     kodidev:~/linux$ pahole -F dwarf netdevsim.ko |wc -l
>     14504
>
> but strangely pahole still doesn't read its own generated BTF:
>
>     kodidev:~/linux$ pahole -F btf netdevsim.ko
>     libbpf: Invalid BTF string section
>     pahole: file 'netdevsim.ko' has no btf type information.
>
> Poking inside a little further:
>    =20
>     kodidev:~/linux$ ltrace -S pahole -F btf netdevsim.ko
>     [...]
>     argp_parse(0x563d47da42a0, 4, 0x7ffd5e552698, 0 <unfinished ...>
>     SYS_318(0x7fc385bf84d8, 8, 1, 0x7fc385ce9908)    =3D 8
>     SYS_brk(0)                                       =3D 0x563d47e37000
>     SYS_brk(0x563d47e58000)                          =3D 0x563d47e58000
>     <... argp_parse resumed> )                       =3D 0
>     dwarves__init(0x20000, 0, -4096, 213)            =3D 0
>     dwarves__resolve_cacheline_size(0x563d47da40c0, 0, 24, 213) =3D 64
>     cus__new(5, 0, 64, 213)                          =3D 0x563d47e372a0
>     memset(0x563d47da44c0, ' ', 127)                 =3D 0x563d47da44c0
>     strlen("/sys/kernel/btf/")                       =3D 16
>     strncmp("netdevsim.ko", "/sys/kernel/btf/", 16)  =3D 63
>     cus__load_files(0x563d47e372a0, 0x563d47da40c0, 0x7ffd5e5526b0,
>     0x563d47da40c0 <unfinished ...>
>     SYS_openat(0xffffff9c, 0x7ffd5e554603, 0x80000, 0) =3D 3
>     SYS_newfstatat(3, 0x7fc385baf44f, 0x7ffd5e552210, 4096) =3D 0
>     SYS_read(3, "\177ELF\002\001\001", 4096)         =3D 4096
>     SYS_close(3)                                     =3D 0
>     SYS_openat(0xffffff9c, 0x7ffd5e554603, 0x80000, 0) =3D 3
>     SYS_fcntl(3, 1, 0, 0x7fc3859de2f0)               =3D 1
>     SYS_newfstatat(3, 0x7fc385baf44f, 0x7ffd5e5521f0, 4096) =3D 0
>     SYS_pread(3, 0x7ffd5e5521f0, 64, 0)              =3D 64
>     SYS_pread(3, 0x563d47e3e470, 3520, 0x4f60c8)     =3D 3520
>     SYS_pread(3, 0x563d47e3f240, 525, 0x4f5eb8)      =3D 525
>     SYS_pread(3, 0x563d47e3f460, 0x45dd, 0x2b1fb6)   =3D 0x45dd
>     SYS_write(2, "libbpf: Invalid BTF string secti"..., 35libbpf: Invalid=
 BTF
>     string section
>     ) =3D 35
>     SYS_close(3)                                     =3D 0
>     <... cus__load_files resumed> )                  =3D 0xffffffff
>     access("netdevsim.ko", 4 <unfinished ...>
>     SYS_access("netdevsim.ko", 04)                   =3D 0
>     <... access resumed> )                           =3D 0
>     fprintf(0x7fc385bf26a0, "pahole: file '%s' has no %s type"...,
>     "netdevsim.ko", "btf" <unfinished ...>
>     SYS_write(2, "pahole: file 'netdevsim.ko' has "..., 57pahole: file
>     'netdevsim.ko' has no btf type information.
>     ) =3D 57
>     <... fprintf resumed> )                          =3D 57
>     SYS_exit_group(1 <no return ...>
>     +++ exited (status 1) +++
>
> Could you help investigate this further? Maybe a libbpf issue? For the
> record, I also tried building pahole with embedded libbpf 1.4.3 without
> any change. (side note: please make pahole --version also cover libbpf)
>
>
> Many thanks everyone for your help,
> Tony
>
> [1]: https://patchwork.sourceware.org/project/elfutils/list/?series=3D316=
01
> [2]: https://patchwork.sourceware.org/project/elfutils/list/?series=3D343=
10
> [3]:
> https://github.com/guidosarducci/elfutils/commits/main-fix-mips-support-r=
eloc/


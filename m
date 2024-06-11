Return-Path: <bpf+bounces-31837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4695903CEB
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E87B286725
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF9117C7D7;
	Tue, 11 Jun 2024 13:17:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AE24211;
	Tue, 11 Jun 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.234.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111839; cv=none; b=Soloz5apJNClxyAK4R3MgiqEk3f/SUCnDtV/aP+Jbd9RvgG/+s8SrnX3udMQ+97IofDs4UT8XAUiMxMN+kED6ZVmbFb0wLOcyXXgManbt8lIaG17lIOJsTzA/90u3KIBkQa4PBUBcX8TDUwEdK94HFKlPhvCU9lnCJr0BAq7ReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111839; c=relaxed/simple;
	bh=5+59LrSb7Ibb4x5W9jMwmIoeMLtYtBTLpbfJ3J7cwV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AO89JYoZb7o74bTDsjxlklNzvxuIrV+n8MVJfWgIjugNGBWG+3aDADheA3K53HbgAp/MID/OhEOt24ZlN75iQQwBeygsuX5l2LNh+Ypkq7SVCy9VZfOp6G46LCEZGQn5HeFNtm8SpSVdA1+YNsuFJHSQEvbWmku9iHfGa+016Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org; spf=pass smtp.mailfrom=klomp.org; arc=none smtp.client-ip=45.83.234.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: from r6.localdomain (82-217-174-174.cable.dynamic.v4.ziggo.nl [82.217.174.174])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by gnu.wildebeest.org (Postfix) with ESMTPSA id F3797302764B;
	Tue, 11 Jun 2024 15:07:29 +0200 (CEST)
Received: by r6.localdomain (Postfix, from userid 1000)
	id 769A63404B1; Tue, 11 Jun 2024 15:07:29 +0200 (CEST)
Message-ID: <45651efb5698e8247e5d056aed7ac522a04b1056.camel@klomp.org>
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on
 mips64el
From: Mark Wielaard <mark@klomp.org>
To: Tony Ambardar <tony.ambardar@gmail.com>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>, Ying Huang <ying.huang@oss.cipunited.com>
Cc: elfutils-devel@sourceware.org, Hengqi Chen <hengqi.chen@gmail.com>, 
 bpf@vger.kernel.org, dwarves@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Date: Tue, 11 Jun 2024 15:07:29 +0200
In-Reply-To: <Zmfwhn6inA2m1ftm@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
	 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
	 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu> <Zln1kZnu2Xxeyngj@x1>
	 <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu> <Zl3Zp5r9m6X_i_J4@x1>
	 <Zl4AHfG6Gg5Htdgc@x1> <20240603191833.GD4421@gnu.wildebeest.org>
	 <Zl6OTJXw0LH6uWIN@kodidev-ubuntu> <Zmfwhn6inA2m1ftm@kodidev-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Flag: NO

Hi,

Adding elfutils-devel to CC to keep everyone up to date on the state of
the patches.

On Mon, 2024-06-10 at 23:36 -0700, Tony Ambardar wrote:
> On Mon, Jun 03, 2024 at 08:47:24PM -0700, Tony Ambardar wrote:
> > On Mon, Jun 03, 2024 at 09:18:33PM +0200, Mark Wielaard wrote:
> > > On Mon, Jun 03, 2024 at 02:40:45PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > Couldn't find a way to ask eu-readelf for more verbose output, wher=
e we
> > > > could perhaps get some clue as to why it produces nothing while bin=
utils
> > > > readelf manages to grok it, Mark, do you know some other way to ask
> > > > eu-readelf to produce more debug output?
> > > >=20
> > > > I'm unsure if the netdevsim.ko file was left in a semi encoded BTF =
state
> > > > that then made eu-readelf to not be able to process it while pahole=
,
> > > > that uses eltuils' libraries, was able to process the first two CUs=
 for
> > > > a kernel module and all the CUs for the vmlinux file :-\
> > > >=20
> > > > Mark, the whole thread is available at:
> > > >=20
> > > > https://lore.kernel.org/all/Zl3Zp5r9m6X_i_J4@x1/T/#u
> > >=20
> > > I haven't looked at the vmlinux file. But for the .ko file the issue
> > > is that the elfutils MIPS backend isn't complete. Specifically MIPS
> > > relocations aren't recognized (and so cannot be applied). There are
> > > some pending patches which try to fix that:
> > >=20
> > > https://patchwork.sourceware.org/project/elfutils/list/?series=3D3160=
1
> >=20
> > Earlier in the thread, Hengqi Chen pointed out the latest elfutils back=
end
> > work for MIPS, and I locally rebuilt elfutils and then pahole from thei=
r
> > respective next/main branches. For elfutils, main (935ee131cf7c) includ=
es
> >=20
> >   e259f126 Support Mips architecture
> >   f2acb069 stack: Fix stack unwind failure on mips
> >   db33cb0c backends: Add register_info, return_value_location, core_not=
e mips
> >=20
> > which partially applies the patchwork series but leaves out the support=
 for
> > readelf, strip, and elflint.
> >=20
> > I believe this means the vmlinux and .ko files I shared are OK, or is t=
here
> > more backend work needed for MIPS?
> >=20
> > The bits missing in eu-readelf would explain the blank output both Arna=
ldo
> > and I see from "$ eu-readelf -winfo vmlinux". I tried rebuilding with t=
he
> > patchwork readelf patch locally but ran into merge conflicts.
>=20
> A short update, starting with answering my own question.
>=20
> No, apparently the above commits *do not* complete the backend work. Ying
> Huang submitted additional related patches since March 5: [1][2]
>=20
>     strip: Adapt src/strip -o -f on mips
>     readelf: Adapt src/readelf -h/-S/-r/-w/-l/-d/-a on mips
>     elflint: adapt src/elflint --gnu src/nm on mips
>     test: Add mips in run-allregs.sh and run-readelf-mixed-corenote.sh
>=20
> Despite the titles, these patches do include core backend changes for MIP=
S.
> I resolved the various merge conflicts [3], rebuilt elfutils, and reteste=
d
> kernel builds to now find:
>=20
>   - pahole is able to read DWARF[45] info and create .BTF for modules
>   - resolve_btfids can successfully patch .BTF_ids in modules
>   - kernel successfully loads modules with BTF and kfuncs (tested 6.6 LTS=
)
>=20
> Huzzah!
>=20
>=20
> Ying:
>=20
> Thank you for developing these MIPS patches. In your view, are the MIPS
> changes now complete, or do you plan further updates that might improve o=
r
> impact parsing DWARF debug/reloc info in apps like pahole?
>=20
>=20
> Mark:
>=20
> Given that BTF usage on Linux/MIPS is basically broken without these
> patches, could I request some of your review time for them to be merged? =
If
> it's helpful, my branch [3] includes all patches with conflicts fixed, an=
d
> I also successfully ran the elfutils self-tests (including MIPS from Ying=
).
> Please feel free to add for these patches:
>=20
>     Tested-by: Tony Ambardar <Tony.Ambardar@gmail.com>

Yes, I would very much like to integrate the rest of these patches. But
I keep running out of time. The main issues were that, as you noticed,
the patches mix backend and frontend tool changes a bit. I don't have
access to a MIPS system to test them on. There are a couple of
different MIPS abis (I believe all combinations of 32/64 bit and
big/little endianness), but people have only tested on mips64le (maybe
that is the only relevant one these days?) And finally the way MIPS
represents relocations is slightly different than any other ELF
architecture does. So we have to translate that somewhere to make the
standards functions work. I have to convince myself that doing that in
elf_getdata as the patches do is the right place.

> Many thanks everyone for your help,
> Tony
>=20
> [1]: https://patchwork.sourceware.org/project/elfutils/list/?series=3D316=
01
> [2]: https://patchwork.sourceware.org/project/elfutils/list/?series=3D343=
10
> [3]:
> https://github.com/guidosarducci/elfutils/commits/main-fix-mips-support-r=
eloc/



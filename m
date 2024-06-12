Return-Path: <bpf+bounces-31905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905D9049B7
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 05:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6DB285F09
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 03:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BD208C4;
	Wed, 12 Jun 2024 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="qK7fLO/E"
X-Original-To: bpf@vger.kernel.org
Received: from lf-1-17.ptr.blmpb.com (lf-1-17.ptr.blmpb.com [103.149.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED018E02
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718163835; cv=none; b=nHQUNWbuM+do5H0eLiSgHloHd8nulQQQXTpy9QFbBJaPYx9i0h1b1jb72tbdLUTDbezOFDbZ7A1g4aDo2OgkD+GEAJ0cds27RRe43kJyvVdjkz+fsCyI66qpv8E8zj8I2qOtVm29H19H3cQ46iqZlTuK25U4HlOsv36gjGVdq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718163835; c=relaxed/simple;
	bh=FwF1UaqgrhfczoyQT/y5NSk2yXrqzEmGBW4VPrvUML0=;
	h=References:In-Reply-To:Cc:Subject:Content-Type:From:To:Message-Id:
	 Mime-Version:Date; b=dSSs+GYECbTTPOWLSUyfu2HvUPi93iUw7z54x0mrrYzSjoAbsut6figpufZUJ4XWRAKEmavKKLBtugQzuCpH5hIX0+E+ilJmdOcSt+nEAC+sOmRf+Jbzlti643ft9LeWDMxt7lccJ0KYdgLPeofcvmu3iHupQ3zG0NEf4PqXe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=qK7fLO/E; arc=none smtp.client-ip=103.149.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1718163081;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=EVosu311fBMed9WBoPhL6812x0u8hWHXJfxE8L3RCug=;
 b=qK7fLO/EaMg4v1SjnX3+i8Lk5FL2LWac5oTZT9XQ6/DXWmbTIFlvg9bsvjXupPXeS9JHmS
 fp8/5IRB1D69ofhhA2/UG3BmXcfJIYINbhxhEXaJYITBizo2yo8apP9OOm31eB2c1v+V8K
 ntHNE4bhmExyDLxYJizSezYbVvv2gvG6QHdMtRrKklPrl/8lv2TqBT1ZNLOmmK9CklBEKg
 ZUF0UYTUDY8Ctd9AJIjUwNeRXbt1ud9PjnDtCfoWATPGpDFtKupYwFfEtkNNZrN4Xk4xZB
 baLucNU0wiWDCUODASUKEsoeeVnDV19AxkThfP0JDXnIW/+dsMY/faxsyTRi6Q==
Received: from [192.168.8.113] ([171.15.156.97]) by smtp.feishu.cn with ESMTPS; Wed, 12 Jun 2024 11:31:08 +0800
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu> <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com> <ZlmrQqQSJyNH7fVF@kodidev-ubuntu> <Zln1kZnu2Xxeyngj@x1> <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu> <Zl3Zp5r9m6X_i_J4@x1> <Zl4AHfG6Gg5Htdgc@x1> <20240603191833.GD4421@gnu.wildebeest.org> <Zl6OTJXw0LH6uWIN@kodidev-ubuntu> <Zmfwhn6inA2m1ftm@kodidev-ubuntu> <45651efb5698e8247e5d056aed7ac522a04b1056.camel@klomp.org>
X-Lms-Return-Path: <lba+26669167d+a03706+vger.kernel.org+ying.huang@oss.cipunited.com>
In-Reply-To: <45651efb5698e8247e5d056aed7ac522a04b1056.camel@klomp.org>
Content-Transfer-Encoding: quoted-printable
Cc: <elfutils-devel@sourceware.org>, "Hengqi Chen" <hengqi.chen@gmail.com>, 
	<bpf@vger.kernel.org>, <dwarves@vger.kernel.org>, 
	"Alexei Starovoitov" <ast@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on mips64el
Content-Type: text/plain; charset=UTF-8
X-Original-From: Ying Huang <ying.huang@oss.cipunited.com>
From: "Ying Huang" <ying.huang@oss.cipunited.com>
To: "Mark Wielaard" <mark@klomp.org>, 
	"Tony Ambardar" <tony.ambardar@gmail.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>
Message-Id: <541a70f7-6342-4369-8191-d6916c38d358@oss.cipunited.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Date: Wed, 12 Jun 2024 11:31:05 +0800

Hi Mark,

Regarding the current questions, I have a few points that needed to be expl=
ained.


=E5=9C=A8 2024/6/11 21:07, Mark Wielaard =E5=86=99=E9=81=93:
> Hi,
>
> Adding elfutils-devel to CC to keep everyone up to date on the state of
> the patches.
>
> On Mon, 2024-06-10 at 23:36 -0700, Tony Ambardar wrote:
>> On Mon, Jun 03, 2024 at 08:47:24PM -0700, Tony Ambardar wrote:
>>> On Mon, Jun 03, 2024 at 09:18:33PM +0200, Mark Wielaard wrote:
>>>> On Mon, Jun 03, 2024 at 02:40:45PM -0300, Arnaldo Carvalho de Melo wro=
te:
>>>>> Couldn't find a way to ask eu-readelf for more verbose output, where =
we
>>>>> could perhaps get some clue as to why it produces nothing while binut=
ils
>>>>> readelf manages to grok it, Mark, do you know some other way to ask
>>>>> eu-readelf to produce more debug output?
>>>>>
>>>>> I'm unsure if the netdevsim.ko file was left in a semi encoded BTF st=
ate
>>>>> that then made eu-readelf to not be able to process it while pahole,
>>>>> that uses eltuils' libraries, was able to process the first two CUs f=
or
>>>>> a kernel module and all the CUs for the vmlinux file :-\
>>>>>
>>>>> Mark, the whole thread is available at:
>>>>>
>>>>> https://lore.kernel.org/all/Zl3Zp5r9m6X_i_J4@x1/T/#u
>>>> I haven't looked at the vmlinux file. But for the .ko file the issue
>>>> is that the elfutils MIPS backend isn't complete. Specifically MIPS
>>>> relocations aren't recognized (and so cannot be applied). There are
>>>> some pending patches which try to fix that:
>>>>
>>>> https://patchwork.sourceware.org/project/elfutils/list/?series=3D31601
>>> Earlier in the thread, Hengqi Chen pointed out the latest elfutils back=
end
>>> work for MIPS, and I locally rebuilt elfutils and then pahole from thei=
r
>>> respective next/main branches. For elfutils, main (935ee131cf7c) includ=
es
>>>
>>>   e259f126 Support Mips architecture
>>>   f2acb069 stack: Fix stack unwind failure on mips
>>>   db33cb0c backends: Add register_info, return_value_location, core_not=
e mips
>>>
>>> which partially applies the patchwork series but leaves out the support=
 for
>>> readelf, strip, and elflint.
>>>
>>> I believe this means the vmlinux and .ko files I shared are OK, or is t=
here
>>> more backend work needed for MIPS?
>>>
>>> The bits missing in eu-readelf would explain the blank output both Arna=
ldo
>>> and I see from "$ eu-readelf -winfo vmlinux". I tried rebuilding with t=
he
>>> patchwork readelf patch locally but ran into merge conflicts.
>> A short update, starting with answering my own question.
>>
>> No, apparently the above commits *do not* complete the backend work. Yin=
g
>> Huang submitted additional related patches since March 5: [1][2]
>>
>>     strip: Adapt src/strip -o -f on mips
>>     readelf: Adapt src/readelf -h/-S/-r/-w/-l/-d/-a on mips
>>     elflint: adapt src/elflint --gnu src/nm on mips
>>     test: Add mips in run-allregs.sh and run-readelf-mixed-corenote.sh
>>
>> Despite the titles, these patches do include core backend changes for MI=
PS.
>> I resolved the various merge conflicts [3], rebuilt elfutils, and retest=
ed
>> kernel builds to now find:
>>
>>   - pahole is able to read DWARF[45] info and create .BTF for modules
>>   - resolve_btfids can successfully patch .BTF_ids in modules
>>   - kernel successfully loads modules with BTF and kfuncs (tested 6.6 LT=
S)
>>
>> Huzzah!
>>
>>
>> Ying:
>>
>> Thank you for developing these MIPS patches. In your view, are the MIPS
>> changes now complete, or do you plan further updates that might improve =
or
>> impact parsing DWARF debug/reloc info in apps like pahole?
>>
>>
>> Mark:
>>
>> Given that BTF usage on Linux/MIPS is basically broken without these
>> patches, could I request some of your review time for them to be merged?=
 If
>> it's helpful, my branch [3] includes all patches with conflicts fixed, a=
nd
>> I also successfully ran the elfutils self-tests (including MIPS from Yin=
g).
>> Please feel free to add for these patches:
>>
>>     Tested-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> Yes, I would very much like to integrate the rest of these patches. But
> I keep running out of time. The main issues were that, as you noticed,
> the patches mix backend and frontend tool changes a bit.=20

The reason about the mixture and title is that only by fixing the acquisiti=
on of relocation information can 'strip' and 'readelf -w' work normally.

Now it seems really confusing, so I want to do some changes based on your o=
pinions, change the titles or reorganize these patches to make them look mo=
re logical.

> I don't have
> access to a MIPS system to test them on. There are a couple of
> different MIPS abis (I believe all combinations of 32/64 bit and
> big/little endianness), but people have only tested on mips64le (maybe
> that is the only relevant one these days?)=20

I have tested other mips abi before, I will test it agagin and attach the r=
esults of 'make check' with and without patch.

And add a description of mips abi support in the commit message.

> And finally the way MIPS
> represents relocations is slightly different than any other ELF
> architecture does. So we have to translate that somewhere to make the
> standards functions work. I have to convince myself that doing that in
> elf_getdata as the patches do is the right place.


The controversial problem was the location of the code, the code was to cha=
nge the original relocation info to ensure mips can obtain the correct inde=
x value and symble index.

Or we did not modify the original data, we modify the way to obtain the ind=
ex value and symble index at funtion 'gelf_getrela' in file 'libelf/gelf_ge=
trela.c','libelf/gelf_getrel.c','libelf/gelf_update_rela.c','libelf/gelf_up=
date_rel.c'.

Where the function 'gelf_getrela' is called=EF=BC=8Cmodify the relocation i=
nfo that has been obtained .

What do you think of this?


Thanks,

Ying

>
>> Many thanks everyone for your help,
>> Tony
>>
>> [1]: https://patchwork.sourceware.org/project/elfutils/list/?series=3D31=
601
>> [2]: https://patchwork.sourceware.org/project/elfutils/list/?series=3D34=
310
>> [3]:
>> https://github.com/guidosarducci/elfutils/commits/main-fix-mips-support-=
reloc/


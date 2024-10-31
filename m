Return-Path: <bpf+bounces-43615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2283A9B70F2
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 01:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469241C20FD9
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254BED2FB;
	Thu, 31 Oct 2024 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="e+uxxr2I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECE8F5C
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333663; cv=none; b=Wq/0vPrqk4TjwSuu8LBDXTtz17HT79cM/Q4Py9eqAd9lz67pu9E3uRYBPoQmDqxcPYNAv8Nhk2cvrhzJnW3JY5NgI2amUBERSFvbYXYHF0Pu5mS4pVZRHgvhmcD4liy46sixbTYryYRB2eFol+UibN6mD4sIm+LlMyAs/zbjeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333663; c=relaxed/simple;
	bh=2G+/PxOqRUJhkzRglx+7lZUrBiGIfLkla1m59yTm5B0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm2W1NHcL7ImhTXKLxfTa+cKLRbz4DvMgupS0I/ow6tm/hOnkljqRNA3yMJlOEFmX5ZCr5LSxBiQuToFJ6jQrU66bfc3Z8fjkJe3vGVQGqAMmpwMf/4XgvVk+2vrFSwYxoV0cZOG+1PX67vX1Cmxd8sv2xbZV8r6/q5xrjHXWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=e+uxxr2I; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730333652; x=1730592852;
	bh=32ouCa2ux9150oTEUUeG8ZNMNSnhmi7Jg3GQZLYpgqs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e+uxxr2IqyhXESbCMlrHrd3soLmP2jpYNY7LHJskn772jiT+hZF4mlMQLmalWOVWM
	 UFH0VzA5mkfSNZtXbMphWbkFo8fLvK6VJyiBURSPFwXLZtH1hQopAsWIgRAj5MAK1M
	 SjPT5M+VzBNKp4NI4O/BBYe6pIgoR1mA5h1xBWM/OD+MHqZRi7Hjdyk7P9sRNBpoBU
	 9SgExR+S6nc3S5dCbGSqfqoUY3Oe+iV9ZoikeYzT9tr/J07bTDmWWVmBsw4Pd9Avfp
	 iXLC7kmNaDzoFlcseyNkI5cSaI0h14W6oX4ZW9BEOeZUYIhXgJ25M+zbhAo9H6bA5C
	 vajER+ffK5UbQ==
Date: Thu, 31 Oct 2024 00:14:09 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>, acme@kernel.org, andrii@kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH v3 dwarves 4/5] btf_encoder: store a list of elf_function per function name
Message-ID: <qZHen28Acr_pzq0oImrTEVB6xsUgeVkqBmQ43dpfluDRfqWYRfCQp9jTj1KCLtXqwXSQmSFObW4HNqKkWaPCsz2HeUKzzkfMtZ8MQJUkfgo=@pm.me>
In-Reply-To: <8678ce40-3ce2-4ece-985b-a40427386d57@oracle.com>
References: <20241016001025.857970-1-ihor.solodrai@pm.me> <20241016001025.857970-5-ihor.solodrai@pm.me> <8678ce40-3ce2-4ece-985b-a40427386d57@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 25fef072b000f043ef805adcc60754767713e252
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, October 21st, 2024 at 10:51 AM, Alan Maguire <alan.maguire@oracl=
e.com> wrote:

> hi Ihor
>=20
> On 16/10/2024 01:10, Ihor Solodrai wrote:
>=20
> > btf_encoder__save_func() accumulates observations of DWARF functions,
> > maintaining an elf_function per function name.
>=20
>=20
> I've been struggling with the latter few patches in this series, and I
> think that's in part due to the fact that you have to deal with some
> (what I think are) unnecessary complications in the existing code.
>=20
> It should be easier to share ELF representations, but the situation
> you've inherited is we mix immutable (ELF representation) and mutable
> (function state information saved) representations, leading to
> complications that require synchronization across threads.
>=20
> Stepping back, I think with a few simplifications, we can lay a better
> foundation for your work, and BTF encoding in general. Specifically if we
>=20
> - always save and later add functions; currently we only save if we want
> to avoid inconsistencies, but this means having to maintain two
> codepaths for function addition which is messy. It is simpler to
> always save and later see if we want to add functions.
> - fully separate ELF representation (immutable) from saved function
> represention (mutable). this will enable ELF sharing, and saved
> functions state can simply point back at the appropriate ELF function
> - For each encoder, we just save all function state representations in a
> simple list; no merging is done at this point
> - when adding saved functions, we combine lists from all encoders, merge
> findings on inconsistent representations where required, and add all
> functions without inconsistent representations.
>=20
> This will mean no concurrency issues, and we end up with a simpler
> representation which I think should make ELF sharing much easier. I've
> got a rough prototype of 3 prerequisite patches doing the above at
> https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:el=
f-prep
>=20
> The changes are contained in the last 3 patches there if you want to
> take a look.

Hi Alan.

Finally got time to try your changes.  Apologies for delay, was busy
with other things.

TL;DR Here is my patchset rebased on top of your commits:
* https://github.com/theihor/dwarves/pull/7

Please take a look, and let's sync on how do we plan to merge it
in. Your commits seem to have debug code in them, so maybe you'd want
to submit a clean version first.


I must say earlier Eduard pointed out (off-list) the problems that
you've described, but at the time I thought it would be too many
changes if I tried to address them.

It is indeed easier to move to a shared ELF functions table if all
function states are collected before merging them, mostly because the
need for thread synchronization disappears. I was able to effectively
delete patch 4/5 of the series.

One thing that bothered me is that now btf_encoder__add_saved_funcs()
does more work (compared to v3 of the patchset). This is of course due
to the fact that it is required to collect all function states from
all encoders and group them by name, while it was done "automatically"
when states were stored in elf_functions table. It's not good, because
this step is single-threaded.

However, I did some superficial measurements, and it appears
btf_encoder__add_saved_funcs() step takes ~2% of the time when
encoding vmlinux. So it's probably not worth complicating.

Regarding "global variables" fork of our discussion [1], I didn't get
any feedback from you or Arnaldo in response to suggested diff.
I included a more thought out version in the branch [2], please take=20
a look.


See below some perf stats: marginal speedup and slower RSS growth
with increasing number of threads.

WIP v4 branch [2]:

     Performance counter stats for '/home/theihor/dev/dwarves/build/pahole =
-J -j23 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,op=
timized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=3D/dev/n=
ull --lang_exclude=3Drust /home/theihor/git/kernel.org/bpf-next/kbuild-outp=
ut/.tmp_vmlinux1' (13 runs):

        83,054,827,477      cycles:u                                       =
                         ( +-  0.29% )

                3.9829 +- 0.0374 seconds time elapsed  ( +-  0.94% )

    -j2: =09Maximum resident set size (kbytes): 783296
    -j4: =09Maximum resident set size (kbytes): 866976
    -j8: =09Maximum resident set size (kbytes): 992740
    -j16: =09Maximum resident set size (kbytes): 1038788
    -j32: =09Maximum resident set size (kbytes): 1169284
    -j64: =09Maximum resident set size (kbytes): 1347232

dwarves/next [3]

     Performance counter stats for '/home/theihor/dev/dwarves/build/pahole =
-J -j23 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,op=
timized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=3D/dev/n=
ull --lang_exclude=3Drust /home/theihor/git/kernel.org/bpf-next/kbuild-outp=
ut/.tmp_vmlinux1' (13 runs):

        87,748,403,977      cycles:u                                       =
                         ( +-  0.23% )

                4.0570 +- 0.0240 seconds time elapsed  ( +-  0.59% )

    checking max rss
    -j2: =09Maximum resident set size (kbytes): 787256
    -j4: =09Maximum resident set size (kbytes): 884360
    -j8: =09Maximum resident set size (kbytes): 1018996
    -j16: =09Maximum resident set size (kbytes): 1083528
    -j32: =09Maximum resident set size (kbytes): 1279880
    -j64: =09Maximum resident set size (kbytes): 1634656


[1]: https://lore.kernel.org/dwarves/4G5AFfVer_N_eJCZYc22pQM9rXbHOV2CZ4uOmq=
h4gFd1K2mgnbIDIZUpynMNCdJ-CEyvsBr0-cPdUzgNnM05NPkPjRdqdAnCAp8DrvUc-Iw=3D@pm=
.me/
[2]: https://github.com/theihor/dwarves/pull/7
[3]: https://github.com/theihor/dwarves/commit/729fd9963df576a04f2ba371b033=
c5300ebf0a91

> [...]



Return-Path: <bpf+bounces-46935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1979F194D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9DD163C1A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073C1A8F75;
	Fri, 13 Dec 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="lUklpFUJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch [185.70.41.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB052114;
	Fri, 13 Dec 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.41.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129871; cv=none; b=EqUy0IA3tlYO/AAZ3eB+OYDCPcUvmULNtNxTVv19xwH7hBLLI7qq2ytBM46Zd1R9zx/7pOjXNHSHOcJLUJc9m4LYYHmnJSs/apl1B+lPLZ95Qsdvc5B8lnNGoxLuLPg84oEDx/C9nhY+uf+nUbvO1mT+9qYcH+tEsPOxCqIjpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129871; c=relaxed/simple;
	bh=RbczOgHsGXIER7X+jNi80wUCGUSXVPkI7ZuC8GIW4SE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pXRy4luiTl4IJDcmzlm5bob/t/T3r5ZB4BCZyOgELH/GXURj56rPk8O1msreZWkLRF2UoBKbcASr3AD+Qgo4NqxuPD3zlIn3ckQb25Pi94ytvZGiCG086662EsgSP2Dsm5kVknWhQHNgDOF476qUnqY9KpRObZE/kKNs1Uifujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=lUklpFUJ; arc=none smtp.client-ip=185.70.41.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734129408; x=1734388608;
	bh=mUNAOEoXBmfz7j1ty8fJxCmAtNy9S/BSE5lH8G5BHSA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=lUklpFUJ5//hCao5DBFoX8Pt3uLd2okeYjq3v38keY95QVN+YqsYKVEENfNKTCieu
	 uWjlFBb5BERm4yCmkxXY8y19J2zlfWnQubTJklnoUiXnt0PwnQMhR0Tjo2lT41qAci
	 FAkPaFdyNe/y0Y7KJ1v/PH1gC5f4YOeXy90I2KMIlcurF7IcW+xW0eFTtd3kuvt5yH
	 QznQALTLaf/BZEOxUnuGL8xSug68GEzSHlzi21d+C5C0eZjN7bePX+zG83bMqhO3jb
	 cfgqGJ+l4m0DmBqzRRzyllpQUwwhb1kCuItfO3M9u/S0DB67OqsaenkxDBRAQYOIqP
	 h4qxAeAlb7+rA==
Date: Fri, 13 Dec 2024 22:36:44 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2 00/10] pahole: shared ELF and faster reproducible BTF encoding
Message-ID: <20241213223641.564002-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: ca3db792d39a9621d0414aa669e7e0432e85243f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a v2 of the patchset aiming to speed up parallel BTF encoding
when reproducible_build flag is set (see link [1]).

In comparison to v1:
  * patch #2 adding section-relative addresses to elf_functions is
    removed as unrelated [2]
  * patch #9 [3] is replaced with patches #8, #9 and #10 (the biggest
    and most important in this series)

Patch #10 rewrites multithreading implementation to job/worker
model. See the details in the commit message.

The ./tests/tests pass with a vmlinux build on bpf-next.

I also confrimed that the reproducible bpftool dump of BTF produced
for vmlinux is identical between this patch series and pahole/next.

With this patch series, the performance of parallel BTF encoding is
comparable to non-reproducible runs on pahole/next. Depending on the
number of threads and allowed memory usage (indirectly controlled by
max_decoded_cus parameter of the queue in the dwarf_loader.c), it may
be a little slower or a little faster.

Note that the number of CPU cycles is significantly less, although the
wall-clock time is somewhat greater for -j24, as reported by perf.

See sample measurements below (host nproc=3D24).

This patch (always reproducible)

    -j1 mem 842020 Kb, time 6.31 sec
    -j3 mem 864604 Kb, time 2.90 sec
    -j6 mem 927760 Kb, time 2.21 sec
    -j12 mem 1026616 Kb, time 2.29 sec
    -j24 mem 1188448 Kb, time 2.36 sec
    -j48 mem 1462656 Kb, time 2.48 sec

     Performance counter stats for '/home/theihor/dev/dwarves/build/pahole =
-J -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,op=
timized_func,consistent_func,decl_tag_kfuncs,reproducible_build --btf_encod=
e_detached=3D/dev/null --lang_exclude=3Drust /home/theihor/git/kernel.org/b=
pf-next/kbuild-output/.tmp_vmlinux1' (13 runs):

        46,771,092,586      cycles:u                                       =
                         ( +-  0.17% )

               2.36785 +- 0.00503 seconds time elapsed  ( +-  0.21% )

pahole/next (1cb4202) non-reproducible

    -j1 mem 834004 Kb, time 6.25 sec
    -j3 mem 976480 Kb, time 3.21 sec
    -j6 mem 1081432 Kb, time 2.36 sec
    -j12 mem 1161252 Kb, time 2.07 sec
    -j24 mem 1303060 Kb, time 2.13 sec
    -j48 mem 1537800 Kb, time 2.39 sec

     Performance counter stats for '/home/theihor/dev/dwarves/build/pahole =
-J -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,op=
timized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=3D/dev/n=
ull --lang_exclude=3Drust /home/theihor/git/kernel.org/bpf-next/kbuild-outp=
ut/.tmp_vmlinux1' (13 runs):

        60,436,382,442      cycles:u                                       =
                         ( +-  0.22% )

                2.2024 +- 0.0151 seconds time elapsed  ( +-  0.68% )

pahole/next (1cb4202) reproducible

    -j1 mem 4745764 Kb, time 7.64 sec
    -j3 mem 4744556 Kb, time 3.95 sec
    -j6 mem 4744592 Kb, time 2.98 sec
    -j12 mem 4744680 Kb, time 2.99 sec
    -j24 mem 4745252 Kb, time 2.99 sec
    -j48 mem 4744520 Kb, time 2.98 sec

     Performance counter stats for '/home/theihor/dev/dwarves/build/pahole =
-J -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,op=
timized_func,consistent_func,decl_tag_kfuncs,reproducible_build --btf_encod=
e_detached=3D/dev/null --lang_exclude=3Drust /home/theihor/git/kernel.org/b=
pf-next/kbuild-output/.tmp_vmlinux1' (13 runs):

        38,155,725,721      cycles:u                                       =
                         ( +-  0.29% )

               3.00290 +- 0.00501 seconds time elapsed  ( +-  0.17% )

[1] https://lore.kernel.org/dwarves/20241128012341.4081072-1-ihor.solodrai@=
pm.me/
[2] https://lore.kernel.org/dwarves/20241128012341.4081072-3-ihor.solodrai@=
pm.me/
[3] https://lore.kernel.org/dwarves/20241128012341.4081072-10-ihor.solodrai=
@pm.me/

Alan Maguire (2):
  btf_encoder: simplify function encoding
  btf_encoder: separate elf function, saved function representations

Ihor Solodrai (8):
  dwarf_loader: introduce pre_load_module hook to conf_load
  btf_encoder: introduce elf_functions struct type
  btf_encoder: collect elf_functions in btf_encoder__pre_load_module
  btf_encoder: switch to shared elf_functions table
  btf_encoder: introduce btf_encoding_context
  btf_encoder: remove skip_encoding_inconsistent_proto
  dwarf_loader: introduce cu->id
  dwarf_loader: multithreading with a job/worker model

 btf_encoder.c               | 639 +++++++++++++++++++++---------------
 btf_encoder.h               |   8 +-
 btf_loader.c                |   2 +-
 ctf_loader.c                |   2 +-
 dwarf_loader.c              | 352 ++++++++++++++------
 dwarves.c                   |  44 ---
 dwarves.h                   |  21 +-
 pahole.c                    | 237 +++----------
 pdwtags.c                   |   3 +-
 pfunct.c                    |   3 +-
 tests/reproducible_build.sh |   5 +-
 11 files changed, 685 insertions(+), 631 deletions(-)

--=20
2.47.1




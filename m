Return-Path: <bpf+bounces-48158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B0A049E6
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6125E188802E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362F11F470D;
	Tue,  7 Jan 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ftdO8HlF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440918C937
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276956; cv=none; b=azQSE0j7YD/hEr3nrYN8/OGDawRRwTVcgrBdb7R2GmuvuTB8xo2IGbym9ksXjqtpvE/U978OJZ51D6wotN51HD5xdlcngcWAxG2nj5oR9PnFdQFIOInK5GS5rFGUQUslSt+leZ3JWJGsHSdrOeg2xuFkv4y8T9LXu3JsHIFUDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276956; c=relaxed/simple;
	bh=XGqkEQice0g6u8tcQ9wZDTZMyCKEF2x1Bc0g3O5OAQY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gOSVwgKKiwyUinSzojQrwg4WlyjfBM428UsY3nkLnUyvfwoWMWM3TxAgiuBqcacCNMuH0mSXmrQQUakTO9VLIIs4lP5eyYRUbpCsp/kQz8oBlRuV8ySwiDRsWvIEIyrqInHF5RZPrhtpTg3GVp6+25y0o/0ytHWrbFF7YDuy2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ftdO8HlF; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736276944; x=1736536144;
	bh=pNZVcCfSqUO6D9NAgq7M2v4i7ufWiCh1/Njrt0hH47E=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=ftdO8HlFe/MQSWabgJohygbU8NnfX9u3lAR/rADWd+2au4OWPtuYVse82q15u7CeV
	 chkmdouzs2wQBKRkK64r4BTy+utN5/TU6LbodIAjJ0kCDOCxJcOQWkv9UjdIPYtQmy
	 kl+sdKskgiwDUsHiKckQWgD7tpQkjZ9QI8JdOszkqP6K4cQkI7XTyzN618QocD10nv
	 WREenh5nU/JvNXXjj1HFmT4ofdl4Ohp3SQjgRn18EdBBEv8A3CRF4Y7eiw/QrH36RN
	 GW1zblx9urpmoR3LjiRRsguzJr/1PQLoTnR8AuAAO57JV7040tcr/+nDc2nIQTsy0y
	 /cgf5xKvI627Q==
Date: Tue, 07 Jan 2025 19:08:59 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 00/10] pahole: faster reproducible BTF encoding
Message-ID: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: a1199577f2d130a582a12468dd1652adb0e75265
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is v4 of the series aiming to speed up parallel reproducible BTF
encoding. This version mostly addresses feedback from Jiri Olsa on v3.

A notable adition is a patch 10/10, which changes func_states in
btf_encoder from a list to an array.

Testing:

    vmlinux=3D/home/theihor/kernels/bpf-next/kbuild-output/.tmp_vmlinux1 PA=
TH=3D$(realpath build):$PATH ./tests/tests
      1: Validation of BTF encoding of functions; this may take some time: =
Ok
      2: Default BTF on a system without BTF: Ok
      3: Flexible arrays accounting: pahole: type 'nft_pipapo_elem' not fou=
nd
    pahole: type 'tls_rec' not found
    pahole: type 'fuse_direntplus' not found
    pahole: type 'nft_rhash_elem' not found
    pahole: type 'nft_hash_elem' not found
    pahole: type 'nft_bitmap_elem' not found
    pahole: type 'ipt_standard' not found
    pahole: type 'nft_rule_dp_last' not found
    pahole: type 'ip6t_standard' not found
    pahole: type 'ipt_error' not found
    pahole: type 'ip6t_error' not found
    pahole: type 'nft_rbtree_elem' not found
    Ok
      4: Check that pfunct can print btf_decl_tags read from BTF: Ok
      5: Pretty printing of files using DWARF type information: Ok
      6: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok

The warnings about not found types are also present at pahole/next, so
not related to this patchset.


Performance check. This patchset (always reproducible):

     Performance counter stats for '/home/theihor/dev/dwarves/build/pahole =
-J -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,op=
timized_func,consistent_func,decl_tag_kfuncs,reproducible_build --btf_encod=
e_detached=3D/dev/null --lang_exclude=3Drust /home/theihor/kernels/bpf-next=
/kbuild-output/.tmp_vmlinux1' (13 runs):

              5,788.22 msec cpu-clock:u                      #    3.776 CPU=
s utilized               ( +-  0.17% )

               1.53288 +- 0.00334 seconds time elapsed  ( +-  0.22% )


pahole/next (d444eb6), parallel non-reproducible:

     Performance counter stats for '/home/theihor/dev/dwarves/build/pahole =
-J -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,op=
timized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=3D/dev/n=
ull --lang_exclude=3Drust /home/theihor/kernels/bpf-next/kbuild-output/.tmp=
_vmlinux1' (13 runs):

             10,462.38 msec cpu-clock:u                      #    6.678 CPU=
s utilized               ( +-  0.15% )

               1.56670 +- 0.00548 seconds time elapsed  ( +-  0.35% )


pahole/next (d444eb6), parallel reproducible:

     Performance counter stats for '/home/theihor/dev/dwarves/build/pahole =
-J -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,op=
timized_func,consistent_func,decl_tag_kfuncs,reproducible_build --btf_encod=
e_detached=3D/dev/null --lang_exclude=3Drust /home/theihor/kernels/bpf-next=
/kbuild-output/.tmp_vmlinux1' (13 runs):

              6,399.88 msec cpu-clock:u                      #    3.164 CPU=
s utilized               ( +-  0.22% )

               2.02269 +- 0.00359 seconds time elapsed  ( +-  0.18% )


v3: https://lore.kernel.org/dwarves/20241221012245.243845-1-ihor.solodrai@p=
m.me/
v2: https://lore.kernel.org/dwarves/20241213223641.564002-1-ihor.solodrai@p=
m.me/
v1: https://lore.kernel.org/dwarves/20241128012341.4081072-1-ihor.solodrai@=
pm.me/

Alan Maguire (2):
  btf_encoder: simplify function encoding
  btf_encoder: separate elf function, saved function representations

Ihor Solodrai (8):
  btf_encoder: free encoder->secinfo in btf_encoder__delete
  btf_encoder: introduce elf_functions struct type
  btf_encoder: introduce elf_functions_list
  btf_encoder: remove skip_encoding_inconsistent_proto
  dwarf_loader: introduce cu->id
  dwarf_loader: multithreading with a job/worker model
  btf_encoder: clean up global encoders list
  btf_encoder: switch func_states from a list to an array

 btf_encoder.c               | 662 +++++++++++++++++++-----------------
 btf_encoder.h               |   7 +-
 btf_loader.c                |   2 +-
 ctf_loader.c                |   2 +-
 dwarf_loader.c              | 335 ++++++++++++------
 dwarves.c                   |  44 ---
 dwarves.h                   |  21 +-
 pahole.c                    | 230 ++-----------
 pdwtags.c                   |   3 +-
 pfunct.c                    |   3 +-
 tests/reproducible_build.sh |   5 +-
 11 files changed, 624 insertions(+), 690 deletions(-)

--=20
2.47.1




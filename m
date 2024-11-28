Return-Path: <bpf+bounces-45779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490EE9DB0AD
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5581664A0
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FE31DDEA;
	Thu, 28 Nov 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qxP3KDex"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE6DDD9;
	Thu, 28 Nov 2024 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757040; cv=none; b=sDXFHu20LGubJdnewpFsbbTWFwjHqjHv3Cpki7skxmDRhZh++UOT5Fx6+p52T6fZ9zvnRVRRFk0wRvWaf8qAxdde+j3h7+E1zzf59+SlYyJuFfOL2y3ll5lCH6WBldG4tb35IAG3e5zmLVjg4bufil/RivwTcTcZhKpbZYx0gvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757040; c=relaxed/simple;
	bh=zLWzejo63QUNWiygCd/llN3slI6FPYyHryU6r7izp6k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ESQzEjxrPIyhClNGuRHxUsM4hH6dtnas98TeVeHG7v9OKjFXsS/LCEJ4VUnrv8AxDIDs5QAervsjaeUe0/lUOt/+vKJvOIKQIwZ0KDBJLWvUfOJ8lwjBFz0MBAj0pHpxzwTFTvQQFARzkm5S1PKnfhE5S2LkLGK7qJEJNE0WwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qxP3KDex; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757031; x=1733016231;
	bh=kfdmaAQHBnQWhxAihMNl3e35fN8kbJs6gkC0S3jHTdQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=qxP3KDexcUcnmpSDHFmiPjHwDgnoAn63r10zR0wFcqjXWZcaSjFA4YFbFtKgvVF8H
	 jjJruvKtyaNgPbFF7KPnNk6VdEwLsa6XPdb1NdWW7mNO5Xm9oyM8wBoKAu6TAjFras
	 3OjKWSsVAJnTtMbYmYOuGNYCLRiOTjct62yiob76ThrtSADsrtteTuPgQanLxnAAzy
	 BuonkTFmXG9n5k6Gfy9eoJUKB1qs78r//Cp1i+wb5lIVAqsLywIL1TrsZmDcMNEt4+
	 EUks5maZ3zXiEaEJqRVzCSjAcEYxNZMFUSYPCczu5qDERqYUTy986HOGg4hRJEPgl9
	 N6UuVTZBpsOSg==
Date: Thu, 28 Nov 2024 01:23:44 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 0/9] pahole: shared ELF and faster reproducible BTF encoding
Message-ID: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 698b05844297b78856dd0dbaa2c3ef844e22cf19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch series continues the work previously focused on sharing of
the ELF functions table between BTF encoders [1].

A recap:
* I've been looking into ways to improve the performance of
  reproducible (--btf_features=3Dreproducible_build) DWARF->BTF
  encoding in pahole [2].
* Originally, Eduard Zingerman suggested to me an approach of creating
  btf_encoder for each compilation unit, and then merging resulting
  BTFs in a particular order.
* This idea required significant changes in how BTF encoders access
  ELF information, which led to the "shared elf_functions" patch
  series [1].
* During review Alan Maguire (and Eduard too, off-list) pointed out
  [3] that shared elf_functions implementation can be simplified, if
  infividual function information is split into immutable (ELF part)
  and mutable (BTF encoding part). Alan also shared a draft of this
  change [4]. Three commits from that draft are included in this patch
  series unchanged.

At that point I had all the pre-requisites to try "btf_encoder per CU"
idea, and so I did [5]. Unfortunately, it turned out that this
approach significantly slows down the encoding, although it reduces
memory usage for parallel reproducible encoding.

Simple measurement script (courtesy of Eduard):

    #!/bin/bash
    for j in 1 4 16 64; do
        /usr/bin/time -f "jobs ${j}, mem %M Kb, time %e sec" \
                      ./build/pahole -J -j$j \
                             --btf_features=3Dencode_force,var,float,enum64=
,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,reproduci=
ble_build \
                             --btf_encode_detached=3D/dev/null \
                             --lang_exclude=3Drust \
                             $vmlinux > /dev/null
    done

Output for [5]:
    jobs 1, mem 1225652 Kb, time 10.37 sec
    jobs 4, mem 1242000 Kb, time 5.44 sec
    jobs 16, mem 1271692 Kb, time 4.33 sec
    jobs 64, mem 1410928 Kb, time 4.32 sec

Output for pahole/next (98d1f01):
    jobs 1, mem 3378104 Kb, time 8.76 sec
    jobs 4, mem 3378716 Kb, time 4.17 sec
    jobs 16, mem 3378144 Kb, time 4.03 sec
    jobs 64, mem 3378628 Kb, time 4.05 sec

The main reason for this, as far as I understand, is that each
individual encoder now needs to do more work. And on top of that,
there are more encoders to merge, which increases load on the
sequential part of a pahole run.

For example, mutable BTF maintains a string set to avoid string
duplication, but when an encoder is only concerned with a single CU
out of 2k+, this optimization becomes moot.

While disappointing, these observations prompted me to look closer on
how exacly is pahole spending the time when BTF encoding in parallel
[6]. I looked at the version with shared elf_functions table [7] on
the assumption that it will land eventually.

Here is a very rough high level breakdown (for vmlinux as input):
  * 81% multithreaded part
    * 64% loading DWARF
    * 17% encoding BTF
  * 20% sequential part
    * 14% BTF dedup
    *  6% BTF merge and everything else

The current encoding algorithm of each thread goes roughly like this:
    * each thread has it's own btf_encoder object
    * a thread reads a CU from DWARF and converts it into the internal
      representation (struct cu), this is what takes 60%+ of time
    * created CU is then passed to btf_encoder__encode_cu
    * when the encoding is complete, CU is deleted (this is important
      for reducing memory footprint)
    * when all CUs are processed, exit and proceed to single-threaded
      BTF merge and dedup

Overall, this is pretty fast. Except, when we need the resulting BTF
to be deterministic (aka reproducible).

Parallel reproducible encoding is implemented by enforcing the order
of CU processing between threads. How? Well, a thread is only allowed
to encode a CU in CU__LOADED state, and BTF encoding happens under a
lock. Which means that the 17% part in the breakdown above is not
actually multithreaded with reproducible_build flag.

To summarize the observations:
 * BTF encoding is actually a minor part of the multithreaded work
   (DWARF loading is about 4x bigger)
 * BTF encoding requires sequential post-processing (merge and dedup)
 * BTF processing in libbpf is kinda faster when it's one huge BTF
 * BTF encoding is sequential with reproducible_build anyway

So why try so hard making BTF encoding multithreaded?..

This led me to an idea: what if we leave BTF encoding part sequential,
but implement it in a way that does not stall DWARF loading? In other
words: let's have a single CU consumer and N-1 CU producers.

Producers are slower anyway, and we can also now get rid of the BTF
merge almost entirely (except for "add saved functions").

This is implemented by the last patch in this series, and the
measurements look promising (see the patch commit message).

Test results for this patch series:

  1: Validation of BTF encoding of functions; this may take some time: Ok
  2: Default BTF on a system without BTF: Ok
  3: Flexible arrays accounting: WARNING: still unsuported BTF_KIND_DECL_TA=
G(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kfunc)=
, ignoring
WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonly_ca=
st already with attribute (bpf_kfunc), ignoring
pahole: type 'nft_pipapo_elem' not found
pahole: type 'ip6t_standard' not found
pahole: type 'ip6t_error' not found
pahole: type 'nft_rbtree_elem' not found
pahole: type 'nft_rule_dp_last' not found
pahole: type 'nft_bitmap_elem' not found
pahole: type 'fuse_direntplus' not found
pahole: type 'ipt_standard' not found
pahole: type 'ipt_error' not found
pahole: type 'tls_rec' not found
pahole: type 'nft_rhash_elem' not found
pahole: type 'nft_hash_elem' not found
Ok
  4: Pretty printing of files using DWARF type information: Ok
  5: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok


[1]: https://lore.kernel.org/dwarves/20241016001025.857970-1-ihor.solodrai@=
pm.me/
[2]: https://github.com/theihor/dwarves/pull/3
[3]: https://lore.kernel.org/dwarves/8678ce40-3ce2-4ece-985b-a40427386d57@o=
racle.com/
[4]: https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves=
:elf-prep
[5]: https://github.com/theihor/dwarves/pull/8
[6]: https://gist.github.com/theihor/f000ce89427828e61fdaa567b332649b
[7]: https://github.com/theihor/dwarves/pull/8/commits/a7bc67d79d90f98776c6=
dc5fdaf9f088eb09909d


Alan Maguire (3):
  btf_encoder: simplify function encoding
  btf_encoder: store,use section-relative addresses in ELF function
    representation
  btf_encoder: separate elf function, saved function representations

Ihor Solodrai (6):
  dwarf_loader: introduce pre_load_module hook to conf_load
  btf_encoder: introduce elf_functions struct type
  btf_encoder: collect elf_functions in btf_encoder__pre_load_module
  btf_encoder: switch to shared elf_functions table
  btf_encoder: introduce btf_encoding_context
  pahole: faster reproducible BTF encoding

 btf_encoder.c  | 661 ++++++++++++++++++++++++++++++-------------------
 btf_encoder.h  |   6 +
 dwarf_loader.c |  18 +-
 dwarves.c      |  47 ++--
 dwarves.h      |  16 +-
 pahole.c       | 265 +++++++++-----------
 6 files changed, 567 insertions(+), 446 deletions(-)

--=20
2.47.0




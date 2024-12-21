Return-Path: <bpf+bounces-47493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8569F9DB1
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9921897824
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06FE2D613;
	Sat, 21 Dec 2024 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fDodERA8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDE55897;
	Sat, 21 Dec 2024 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744182; cv=none; b=hdP0maNGHFwl3t1ZGG1bmx7WoKdy7K8lDF7rWwROyNjn5Xz2et4lxbwCTZQKhrrls+8mvcElYQzUxe1b5km+V3gJTqYohHCCczk1TbOJD01fVjyPNZJ6/0zRnL05ZFogCmNpybgvtKKsPQUn7sgfqyJJ2HUQ4AsjcvqxLSo2jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744182; c=relaxed/simple;
	bh=strX28Kl+M1pCYCL2pMizSNqFf15nUfk2dB1DEeZarw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Bl7IcFbStW6S8lSg2ffTUzy2ai53P+eqIPbKaig562jcf1RZbxqwI0h5/1JS3wju5rP7J0EK3JGESjiaD02howjrxV0HmzTK/j4SGj3EBHDnnJ1R+G16GKmQixf/XBJ7S5bTJz0OWe4OAAWQXXNYFC6Dz8nOZVxJzdM3O0gJnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=fDodERA8; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734744173; x=1735003373;
	bh=gp9Fp+CqfbR81XrWsfdbGdX3vE8NVYUDzVMpsPxJndc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=fDodERA8I2NZ7S08AV1yHfILmb9geGjsNZWuw24mOwaYHybM0pv9wKvi9og+eay4+
	 siTK23J/qSz7VuHmXvOGcRomGdQOkqdhqiv3DRh2gPElTTjvU2A/Vx041pNMLuJEGd
	 B+g73IgpgXA1oZJI+/mMhmUHVOA9NzPNRTPxTeH1IgXJGqqt8thrWMbG+QTv9MMQ1K
	 lkD/HkSX2ht+SISx+okF4yt5pW+jbtJAu/+Slt0BA8PknzIHyzQiOVmxu+BDS9rqe/
	 LMO48uzGOMyG3/WH6hJTPFkl/wudVHm+7GHbmXpYKE/5p267N3QQa0mYAAp4e6iNF0
	 qjzh4x6QiIIpQ==
Date: Sat, 21 Dec 2024 01:22:49 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v3 0/8] pahole: faster reproducible BTF encoding
Message-ID: <20241221012245.243845-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5ba7a9ff6e9eff089bc35aecc479c5547fb58029
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a v3 of the patchset aiming to speed up parallel reproducible
BTF encoding.

In comparison to v2:
  - removed patch v2 03 adding pre_load_module hook
  - removed patch v2 05 making use of the hook
    - since we will have a single btf_encoder, there is no need to
      collect ELF tables before encoders are created
  - removed patch v2 07 adding btf_encoder_context
  - patch v3 04 is a rewritten patch v2 06
    - each btf_encoder now maintains it's own list of function
      tables per ELF
  - patch v3 07 is an updated patch v2 10
    - dwarf_loader multithreading is adjusted attempting to minimize
      blocking on locks
  - new patch v3 08 increases the cu->obstack chunk size
  - new patch v3 09 cleans up global list of encoders in btf_encoder.c

Testing:
  - ./tests/tests pass on vmlinux built from bpf-next
  - bpftool dump of reproducible BTF is identical to v1.28

Sample perf runs on 6.9 kernel with a production-like config, on a
machine with nproc=3D176:

This patchset:

    Performance counter stats for '/home/isolodrai/dwarves/build/pahole -J =
-j --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimiz=
ed_func,consistent_func,decl_tag_kfuncs --lang_exclude=3Drust --btf_encode_=
detached=3D/dev/null .tmp_vmlinux.btf' (13 runs):

         17,911.11 msec cpu-clock                        #    4.412 CPUs ut=
ilized               ( +-  0.46% )

            4.0600 +- 0.0116 seconds time elapsed  ( +-  0.29% )


pahole/next (v1.28):

    Performance counter stats for '/home/isolodrai/dwarves/build/pahole -J =
-j --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimiz=
ed_func,consistent_func,decl_tag_kfuncs --lang_exclude=3Drust --btf_encode_=
detached=3D/dev/null .tmp_vmlinux.btf' (13 runs):

         82,289.12 msec cpu-clock                        #   17.427 CPUs ut=
ilized               ( +-  0.54% )

            4.7219 +- 0.0270 seconds time elapsed  ( +-  0.57% )


v2: https://lore.kernel.org/dwarves/20241213223641.564002-1-ihor.solodrai@p=
m.me/
v1 RFC: https://lore.kernel.org/dwarves/20241128012341.4081072-1-ihor.solod=
rai@pm.me/

Alan Maguire (2):
  btf_encoder: simplify function encoding
  btf_encoder: separate elf function, saved function representations

Ihor Solodrai (6):
  btf_encoder: introduce elf_functions struct type
  btf_encoder: introduce elf_functions_list
  btf_encoder: remove skip_encoding_inconsistent_proto
  dwarf_loader: introduce cu->id
  dwarf_loader: multithreading with a job/worker model
  btf_encoder: clean up global encoders list

 btf_encoder.c               | 643 +++++++++++++++++++-----------------
 btf_encoder.h               |   7 +-
 btf_loader.c                |   2 +-
 ctf_loader.c                |   2 +-
 dwarf_loader.c              | 335 +++++++++++++------
 dwarves.c                   |  44 ---
 dwarves.h                   |  21 +-
 pahole.c                    | 230 ++-----------
 pdwtags.c                   |   3 +-
 pfunct.c                    |   3 +-
 tests/reproducible_build.sh |   5 +-
 11 files changed, 605 insertions(+), 690 deletions(-)

--=20
2.47.1




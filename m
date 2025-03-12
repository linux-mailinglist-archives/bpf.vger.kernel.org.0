Return-Path: <bpf+bounces-53876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE623A5D4DF
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 04:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD29F17611C
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669271D7998;
	Wed, 12 Mar 2025 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AxHIzS5J"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74534685;
	Wed, 12 Mar 2025 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741751578; cv=none; b=rG3mVsGXuPG+2swhAwDHwpaUZh5OGx6XLVcuoAhZ4R1xiBWT0y8B/+jfwh0wdxyFhi9/2dJ+9wT4vdfy1D9p8/uzma25Nvt8383a1d1/cdyilkx34VCh95NTyvlZH9hdyAX31yVrYR12kXK/K9sRpvne6cP4WF20qhuToQA0jJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741751578; c=relaxed/simple;
	bh=sLKqKjYLtwBaRwxi4pI2AP0lZkLdOBbifFarCNv34ug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JyX8cLOsb4wgutVjEwmnMAzTIxNYXzZiZY11F7GOAJEuhbhU1JvjfKRXa025iqAD3Tbmh/MTg6I/E/eLlppxSM88LG5eOodP/Ed93/iTe0EaaDUK66miAzfXCEib0Cklg0otBKYXWKrA3dy24Ue4sYdP0yp7Bb8+yWRYwXjF0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=AxHIzS5J; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1741751571;
	bh=csLI6VHnfoRTbr9Hhw1hlQTjIqbLO4KYY8VWFZt9+8w=;
	h=Date:From:To:Cc:Subject:From;
	b=AxHIzS5J2+9Jp8BHuQmJ852mWt5T25ssDBoOpK2hnU5Dry6iHvJI7WEUu1tESqRdg
	 J6Um/4FPtb9OXbJ0Sc9FPdVv06BJfR2RJNSB3I/gX8aQudFCUFEf69j3Ee4KrnEEPN
	 tNtGC5FL8hH67953uZ/S3ehEpxpKAVMiaUnYtxx1sS+Flqkn3XQXKbj7QJ6tyRmcPa
	 K7yTUPvNDGTe8tGi6ZTzCEpijCUBIJOaJbCkiXEbeqsJkl6Xnk8MEuI0nb249hyfDB
	 sYBrzWqefi35hyvRCXdC7QExcaQgvIGjLipfATuFGsUbFf2HvDL8Yq6DUbiPh7qU5+
	 1vxCsMEArvekg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZCGtV19Hfz4xCW;
	Wed, 12 Mar 2025 14:52:49 +1100 (AEDT)
Date: Wed, 12 Mar 2025 14:52:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20250312145247.380c2aa5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Agm1aDa=ntrjh5CZDTyBZLk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Agm1aDa=ntrjh5CZDTyBZLk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/asm-generic/percpu.h:7,
                 from arch/powerpc/include/asm/percpu.h:28,
                 from arch/powerpc/include/asm/smp.h:26,
                 from include/linux/smp.h:119,
                 from include/linux/lockdep.h:14,
                 from include/linux/radix-tree.h:14,
                 from include/linux/idr.h:15,
                 from include/linux/cgroup-defs.h:13,
                 from mm/memcontrol.c:28:
mm/memcontrol.c: In function 'memcg_hotplug_cpu_dead':
include/linux/percpu-defs.h:242:2: error: passing argument 1 of 'local_lock=
_acquire' from incompatible pointer type [-Wincompatible-pointer-types]
  242 | ({                                                                 =
     \
      | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
      |  |
      |  localtry_lock_t *
  243 |         __verify_pcpu_ptr(ptr);                                    =
     \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
  244 |         arch_raw_cpu_ptr(ptr);                                     =
     \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
  245 | })
      | ~~
include/linux/percpu-defs.h:254:27: note: in expansion of macro 'raw_cpu_pt=
r'
  254 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
include/linux/local_lock_internal.h:105:36: note: in expansion of macro 'th=
is_cpu_ptr'
  105 |                 local_lock_acquire(this_cpu_ptr(lock));         \
      |                                    ^~~~~~~~~~~~
include/linux/local_lock.h:31:9: note: in expansion of macro '__local_lock_=
irqsave'
   31 |         __local_lock_irqsave(lock, flags)
      |         ^~~~~~~~~~~~~~~~~~~~
mm/memcontrol.c:1960:9: note: in expansion of macro 'local_lock_irqsave'
 1960 |         local_lock_irqsave(&memcg_stock.stock_lock, flags);
      |         ^~~~~~~~~~~~~~~~~~
In file included from include/linux/local_lock.h:5,
                 from include/linux/mmzone.h:24,
                 from include/linux/gfp.h:7,
                 from include/linux/xarray.h:16,
                 from include/linux/radix-tree.h:21:
include/linux/local_lock_internal.h:59:53: note: expected 'local_lock_t *' =
but argument is of type 'localtry_lock_t *'
   59 | static inline void local_lock_acquire(local_lock_t *l) { }
      |                                       ~~~~~~~~~~~~~~^
include/linux/percpu-defs.h:242:2: error: passing argument 1 of 'local_lock=
_release' from incompatible pointer type [-Wincompatible-pointer-types]
  242 | ({                                                                 =
     \
      | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
      |  |
      |  localtry_lock_t *
  243 |         __verify_pcpu_ptr(ptr);                                    =
     \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
  244 |         arch_raw_cpu_ptr(ptr);                                     =
     \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
  245 | })
      | ~~
include/linux/percpu-defs.h:254:27: note: in expansion of macro 'raw_cpu_pt=
r'
  254 | #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
      |                           ^~~~~~~~~~~
include/linux/local_lock_internal.h:122:36: note: in expansion of macro 'th=
is_cpu_ptr'
  122 |                 local_lock_release(this_cpu_ptr(lock));         \
      |                                    ^~~~~~~~~~~~
include/linux/local_lock.h:52:9: note: in expansion of macro '__local_unloc=
k_irqrestore'
   52 |         __local_unlock_irqrestore(lock, flags)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
mm/memcontrol.c:1962:9: note: in expansion of macro 'local_unlock_irqrestor=
e'
 1962 |         local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
      |         ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/local_lock_internal.h:61:53: note: expected 'local_lock_t *' =
but argument is of type 'localtry_lock_t *'
   61 | static inline void local_lock_release(local_lock_t *l) { }
      |                                       ~~~~~~~~~~~~~~^

Caused by commits

  0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t")
  01d37228d331 ("memcg: Use trylock to access memcg stock_lock.")

interacting with commit

  885aa5fe7b1d ("memcg: drain obj stock on cpu hotplug teardown")

from the mm-hotfixes tree.

I applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 12 Mar 2025 14:18:03 +1100
Subject: [PATCH] fix up for "memcg: Use trylock to access memcg stock_lock"

interacting with "memcg: drain obj stock on cpu hotplug teardown" from
the mm-hotfixes tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f88b8dd8097..87544df4c3b8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1957,9 +1957,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	stock =3D &per_cpu(memcg_stock, cpu);
=20
 	/* drain_obj_stock requires stock_lock */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 	old =3D drain_obj_stock(stock);
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
=20
 	drain_stock(stock);
 	obj_cgroup_put(old);
--=20
2.45.2

--=20
Cheers,
Stephen Rothwell

--Sig_/Agm1aDa=ntrjh5CZDTyBZLk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfRBQ8ACgkQAVBC80lX
0Gwhjgf/SY1L6EY7sBqFhnP+flnrFZsbc+TyMvDrzfsz2JbnfFgufgdHuzR8+jcA
aE/25UdSpp2x6Qfbe3AWyt5mn/XeMoEermZsV2axGhViqfGhQ8MKOMzD5UYVRUIX
c2I4cY/mhJwdpDwy3SwLHuvvsKH61GRwxd7LIGgQGH8EdYbdhcfuInCu/owZgfGS
dcTfqXg93FuwUEOWJAUEq/sJKbPUZxPA1EUUsz8GM9v7CGeAYY9X1X45ejfvO9nA
pOq7ihS02sh/QbXbkatGZZF5b4s1VpxiV3LTCmqJqzYqRh1RPEdjOxodmXV58R2j
3/8LfPHpQzkSoWaeL+kZIvEGRSwjwA==
=KxSD
-----END PGP SIGNATURE-----

--Sig_/Agm1aDa=ntrjh5CZDTyBZLk--


Return-Path: <bpf+bounces-54357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B4A6832B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 03:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7586F19C79E2
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 02:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC024E4AA;
	Wed, 19 Mar 2025 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JdzJkkTE"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B04A0F;
	Wed, 19 Mar 2025 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742351598; cv=none; b=F+DiaLdeZ/ss+HY6zktsAgCbov6alDAs7xA5Dagj5L9OWnu3BwgNzXLEgr5bvNRnC1uI4NVA410zJlpJI3lvXjrXJqOEmM0xEGDu2Cnp8P6CFcfoR9s6MadHKgas8GfLijaWymOXt+NAXhIFQ6wyUYhA79A+qzWfxVIODd/AbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742351598; c=relaxed/simple;
	bh=6xL28zKwqqpaaQr96mvoCi/cHiNgZCp4DtV4hOlawxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=g4OUNEREObpY52jt1DNHy/M8rNzXghDR2FsN0qXXTrpxKAe1YgYLhTNDdnA+6O9oKDLIcN+xh36g01tN0L+KLkp2kzKmm0LT7jr25dw9rqzoJ5m34V1cENiKfCaeglj1xfpUjgrwOmAsZsa9tNMwRTZJTRuWy/HrhF5Wg6rPSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JdzJkkTE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1742351591;
	bh=rKs3jHDYafir4OmGXqHNXlXukWNzDtXkTOv1IbjF/rA=;
	h=Date:From:To:Cc:Subject:From;
	b=JdzJkkTER65/Vsm2h1n9ZFEsXDB8dvCYrScSh/NX2Ueb4pVCvwkemrdXY+A6Q8E4E
	 tcBth4Zjzk6IdvAA8e7JM1yovhe3mYvQPOeElcFJ+Vs4gW+/1j/2XzINnAWnTIs7sp
	 C+VlMQqI5237+aaWEScypKrdX9CbkixZh9+9ZqIg0nVDO5PC01f3rl0pKjcNvQ6QJu
	 GoRyfMSmVYosvbqnxVby+T5JPvqAKXB1LyL3SWphmPDSYi6YIiB0Jm1kyPSuYJbnKk
	 oFiz9nTqG3xZg782pPYJOHs0E4ZcC5DqOYwTLv5yskNGlYrBZvW/WnvVsjaScVEqaA
	 AO0JBUdUg4CRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZHXnM1pZkz4x21;
	Wed, 19 Mar 2025 13:33:10 +1100 (AEDT)
Date: Wed, 19 Mar 2025 13:33:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20250319133309.6fce6404@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4j/4fli8+U065xjQkm.vCz=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4j/4fli8+U065xjQkm.vCz=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/asm-generic/percpu.h:7,
                 from arch/x86/include/asm/percpu.h:630,
                 from arch/x86/include/asm/preempt.h:6,
                 from include/linux/preempt.h:79,
                 from include/linux/smp.h:116,
                 from kernel/locking/qspinlock.c:16:
kernel/locking/qspinlock.h: In function 'decode_tail':
include/linux/percpu-defs.h:219:45: error: initialization from pointer to n=
on-enclosed address space
  219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NU=
LL;    \
      |                                             ^
include/linux/percpu-defs.h:237:9: note: in expansion of macro '__verify_pc=
pu_ptr'
  237 |         __verify_pcpu_ptr(ptr);                                    =
     \
      |         ^~~~~~~~~~~~~~~~~
kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_cpu_ptr'
   67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
      |                ^~~~~~~~~~~
include/linux/percpu-defs.h:219:45: note: expected 'const __seg_gs void *' =
but pointer is of type 'struct mcs_spinlock *'
  219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NU=
LL;    \
      |                                             ^
include/linux/percpu-defs.h:237:9: note: in expansion of macro '__verify_pc=
pu_ptr'
  237 |         __verify_pcpu_ptr(ptr);                                    =
     \
      |         ^~~~~~~~~~~~~~~~~
kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_cpu_ptr'
   67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
      |                ^~~~~~~~~~~
kernel/locking/qspinlock.c: In function 'native_queued_spin_lock_slowpath':
kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'decode_tai=
l' from pointer to non-enclosed address space
  285 |                 prev =3D decode_tail(old, qnodes);
      |                                         ^~~~~~
In file included from kernel/locking/qspinlock.c:30:
kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' but argum=
ent is of type '__seg_gs struct qnode *'
   62 | static inline __pure struct mcs_spinlock *decode_tail(u32 tail, str=
uct qnode *qnodes)
      |                                                                 ~~~=
~~~~~~~~~~~^~~~~~
In file included from kernel/locking/qspinlock.c:401:
kernel/locking/qspinlock.c: In function '__pv_queued_spin_lock_slowpath':
kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'decode_tai=
l' from pointer to non-enclosed address space
  285 |                 prev =3D decode_tail(old, qnodes);
      |                                         ^~~~~~
kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' but argum=
ent is of type '__seg_gs struct qnode *'
   62 | static inline __pure struct mcs_spinlock *decode_tail(u32 tail, str=
uct qnode *qnodes)
      |                                                                 ~~~=
~~~~~~~~~~~^~~~~~

Caused by the resilient-queued-spin-lock branch of the bpf-next tree
interacting with the "Enable strict percpu address space checks" series
form the mm-stable tree.

I don't know why this happens, but reverting that branch inf the bpf-next
tree makes the failure go away, so I have done that for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/4j/4fli8+U065xjQkm.vCz=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfaLOUACgkQAVBC80lX
0GxA1Af8ClVgV4Tw7MRGpMw9u4BMEfuIRZMHArqVyDjMpZH+kqPVLcvr17FpQ5VG
y0TKdNRYPfRSraCkhl9p/Vl79IbyVDmO67c3yJW2XuzuL8+b4QS1UOcyG9Z5k/sG
z4I1ydwEj9forxebZMporvffFG16/wcHu63Uhv7JU0ZpNRTOWCyDev8qybUX/SC8
qNQX/3Tlf0RLwpp0IZk/DKNhJiDfDTqVpGXrGjFAsGahX2PjfFJjX/BF1UtrLFpr
w8lxwN61a+O0a/8BgRJ2tFQrKIK/Y8snhUr2Q1FqwQ6sKsZyFk1k6Oujjz2/dOGL
NcgN8V8EYTn3l/lkloycRKyvkQHBuQ==
=FYd3
-----END PGP SIGNATURE-----

--Sig_/4j/4fli8+U065xjQkm.vCz=--


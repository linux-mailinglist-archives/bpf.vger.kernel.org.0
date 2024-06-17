Return-Path: <bpf+bounces-32327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9D90B9D8
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EEAB2ED90
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CA019924B;
	Mon, 17 Jun 2024 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjAmXXD/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF5197553;
	Mon, 17 Jun 2024 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648166; cv=none; b=Iu8UbZB7IpaJHs+Palbep+hr4Q97/xIPKvg/vHWsXLKlPCo4U8NYOEfwWqGEG48K7sANg0XK2FEiwj3+fmruA0xtw7E4K+aMs7ja7eztnGpdbV/sab4Pd70IKhr05RlkC7to0d+AaHn3R+7pnhh1w6zsSOGHX9u0y5pYzhmZoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648166; c=relaxed/simple;
	bh=4U1a6i5Q7+rGsa8vK/Gbq10wKLL6onxJ2NJdNSHWNYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m3b8/EyaTODF8PEgy/Xdn66nqv6aGqr2eIB5v9jnrcsYMTJQUBdAxxv0Ntq3RLL8qg+XMymyYI3rZZ6mB16z5Q3njkye6Cofq1YHRc4aX8AA2CCu3pbzsJUZB8azR5SfK1libSlG+vVFkp0ijV9EvG8sWc26WwWBbo0Lu7K/p8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjAmXXD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6C1C2BD10;
	Mon, 17 Jun 2024 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718648165;
	bh=4U1a6i5Q7+rGsa8vK/Gbq10wKLL6onxJ2NJdNSHWNYI=;
	h=Date:From:To:Cc:Subject:From;
	b=BjAmXXD/m6pTnx8zCWKKsyaV0BhMKFjEHUBVTVf0VLpIqHCvBxzg/xFh0MOjQmKau
	 kFo4lt4vzd9h7tsveHUnqv9TI0lcmxizorcauGJtRRKV5V4f45J97eRHZSno/28BFr
	 lAQOiBU2k0MBoJqVVdIv+m4khfJSQp2ISTJPqsU3jHWkSCvpo1TOvvrLkdzSa/kq8D
	 QCuil24MI5qDdQy21gq3lJHQc0jfzTiS456NtEVXuhsaquqgyeLY1zajQoJwtWB0Tz
	 wAfCzQub0QH93gB0K2QlTSnyrsj6PJ6I+0d3Jqs1SVhDylkSkWOnRTEw7GPUM4nYAz
	 To2eemruUdJPw==
Date: Mon, 17 Jun 2024 19:15:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: Kui-Feng Lee <thinker.li@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	linux-input@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UnPUywumxpyP5nW/"
Content-Disposition: inline


--UnPUywumxpyP5nW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: error: initial=
ization of 'int (*)(void *, struct bpf_link *)' from incompatible pointer t=
ype 'int (*)(void *)' [-Werror=3Dincompatible-pointer-types]
  280 |         .reg =3D hid_bpf_reg,
      |                ^~~~~~~~~~~
/tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: note: (near in=
itialization for 'bpf_hid_bpf_ops.reg')
/tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: error: initial=
ization of 'void (*)(void *, struct bpf_link *)' from incompatible pointer =
type 'void (*)(void *)' [-Werror=3Dincompatible-pointer-types]
  281 |         .unreg =3D hid_bpf_unreg,
      |                  ^~~~~~~~~~~~~
/tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: note: (near in=
itialization for 'bpf_hid_bpf_ops.unreg')

Caused by commit

  73287fe228721b ("bpf: pass bpf_struct_ops_link to callbacks in bpf_struct=
_ops.")

interacting with commit

  ebc0d8093e8c97 ("HID: bpf: implement HID-BPF through bpf_struct_ops")

=66rom the HID tree.

I've fixed it up as below:

=46rom e8aeaba00440845f9bd8d6183ca5d7383a678cd3 Mon Sep 17 00:00:00 2001
=46rom: Mark Brown <broonie@kernel.org>
Date: Mon, 17 Jun 2024 19:02:27 +0100
Subject: [PATCH] HID: bpf: Fix up build

Fix up build error due to 73287fe228721b ("bpf: pass bpf_struct_ops_link to=
 callbacks in bpf_struct_ops.")

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf=
_struct_ops.c
index 5f200557ff12b..744318e7d936b 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -175,7 +175,7 @@ static int hid_bpf_ops_init_member(const struct btf_typ=
e *t,
 	return 0;
 }
=20
-static int hid_bpf_reg(void *kdata)
+static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 {
 	struct hid_bpf_ops *ops =3D kdata;
 	struct hid_device *hdev;
@@ -229,7 +229,7 @@ static int hid_bpf_reg(void *kdata)
 	return err;
 }
=20
-static void hid_bpf_unreg(void *kdata)
+static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
 {
 	struct hid_bpf_ops *ops =3D kdata;
 	struct hid_device *hdev;
--=20
2.39.2


--UnPUywumxpyP5nW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZwfV8ACgkQJNaLcl1U
h9DdVgf9GB5+FOWKqlMI0mTfGp4N8g1OR9Rc0cCIEAmkgy+UaWFfZE4IS4nXIdjY
3LvR8zXYUW7ZIGaRhxN4N1F1Vs+qMt6NUu243na1B9sjueQmRzCOxN/p4oVe8Sti
aU7dE6hzYqABx7qnEmIylObFfR4Tt8lksap1YIwQfXTnf5CCtp/khpI6GlCeXlEi
vVo10hxVMIHpKC1wjAswnT3x95TkkSiuo3r7HB4Gy1QWnSY56cqs0v6QgJOE6Hh1
vgnESlo48slqKZTt+YcfEUdRxM5JkYOihuZMIvAPDeLnkooM5feBq+CYX7dgzE+J
XlfHrGbGhwqvJPM3bncYZw9j7lFurg==
=BpgP
-----END PGP SIGNATURE-----

--UnPUywumxpyP5nW/--


Return-Path: <bpf+bounces-65321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D3B2026C
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 10:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112EB188C1CC
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B912DAFB0;
	Mon, 11 Aug 2025 08:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9F3594B
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902626; cv=none; b=cukq0gxxGW6ZB39C8aolhMAz02vr6VMRtJkkaStlnzWUaWyBIPGuaALyOUAzdb35hiUJ+QRuUp0X7aI9i/dLB0zfs6NZl3wLYJJk6m2xPkh0KaBOl9drfX5FnmRFUws3ifFRDFY/EloovDC/y3R39/6P4lLx/j/aFXvKpaKz/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902626; c=relaxed/simple;
	bh=MOqB9nlNY+I6liQLXCoJN1ex76exPlVxtM2YAOZ1hFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nasxj4ZA3RnGV3ddLS6GOY9ZK4733PYsdygxBUPf/LAinxjpE/GfBFs3f0zAFuCPso8gspqS5vE//opjb2zkW32ec8E6s0LLxy9lx5SK2RPXmQxh0KKnp6EV3yDbvVCwMy/6Z0qOFbtvK817Amt7EFZI9497nH8eE0dyzUENnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 813275F85E;
	Mon, 11 Aug 2025 10:50:27 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, KaFai Wan <mannkafai@gmail.com>
Cc: bpf@vger.kernel.org
Subject: When did CVE-2025-38280 actually become a problem?
Date: Mon, 11 Aug 2025 10:50:21 +0200
Message-ID: <5003841.GXAFRqVoOG@devpool92.emlix.com>
Organization: emlix GmbH
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1930467.tdWV9SEqCh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1930467.tdWV9SEqCh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
Cc: bpf@vger.kernel.org
Subject: When did CVE-2025-38280 actually become a problem?
Date: Mon, 11 Aug 2025 10:50:21 +0200
Message-ID: <5003841.GXAFRqVoOG@devpool92.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

Hi all,

I sent basically the same question to cve@kernel.org but they are out of=20
ideas. They assign the affected version numbers based on the "Fixes"=20
information initially. But I'm unsure if that one is actually correct here,=
=20
see below.

The fix is this commit:

> commit 86bc9c742426a16b52a10ef61f5b721aecca2344
> Author: KaFai Wan <mannkafai@gmail.com>
> Date:   Mon May 26 21:33:58 2025 +0800
>
>     bpf: Avoid __bpf_prog_ret0_warn when jit fails
>=20
[=E2=80=A6]
> Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to enable=
=20
jits")

And my questions were those:

=3D=3D=3D=3D=3D=3D=3D=3D=3D
I was staring a while on CVE-2025-38280, especially since the message state=
s:

> When creating bpf program, 'fp->jit_requested' depends on bpf_jit_enable.
> This issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is not set =
=E2=80=A6

But the commit that this was attributed to=20
(5124abda3060e2eab506fb14a27acadee3c3e396) added the warning to the code, b=
ut=20
the function is only reachable when CONFIG_BPF_JIT_ALWAYS_ON is set. This w=
as=20
the case until 6ebc5030e0c5a698f1dd9a6684cddf6ccaed64a0 moved it out of the=
=20
define. So is this even an issue before 6.15 after all? Since the fix got=20
backported I think it's more an issue to where the second commit got=20
backported? So in my eyes the 5.10 kernel I'm currently staring at isn't=20
affected at all.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Can anyone comment on this? If there is a conclusion I can relay that to th=
e=20
CVE folks to update the version ranges afterwards.

Regards,

Eike
=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner
--nextPart1930467.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iM8EAAEIADkWIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaJmuzRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQq+RR+17trfyLvQQAvangJYZL+xaY/iFN6CLs
Klqmjba4Yb7BUyaHiBSZI8qk1rPGEzBHu2ynkvFsPNfWVwBnvvELmxww4/hbGEaF
dYZ4XTOZYfU8CUVd5iey0641tetqxzMwxsWTePNbpK3nFRZ9jCYmnxaECZMjrHdj
O3HTaO5ek7vQTxqp5Lqjkis=
=8n9O
-----END PGP SIGNATURE-----

--nextPart1930467.tdWV9SEqCh--





Return-Path: <bpf+bounces-18752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4EA82085D
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 21:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324F21F2299B
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 20:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED4C2E9;
	Sat, 30 Dec 2023 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="t9apMdl9"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781CBE5D;
	Sat, 30 Dec 2023 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703966896; x=1704571696; i=markus.elfring@web.de;
	bh=rAdygzKsqo2awjxq9Z7K0OqKNlPxCRegPbkMKgPEzqA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=t9apMdl9JHUgfJkl67EqSzX4k1VZQa4CSAeNzR14gTH2CKJBT0LBvm/Cv4ehVUaF
	 rznikftrvSK3bYtsk/87aOgV7KmN6aW2L+fuBVyi9oj9sFpcBjQaDQUVz21/0P4Ci
	 nZvcT/CdWkfS6O7w0xx5ELH/NiALWkeUtminTScIMRNjUWYIaR9+0A0O97pTRuXTi
	 eGM99TEg0A4/tbZnUHfXTLumoIUzasWfVuoO/OkLCHsWNp+O/IpyeCjbFAcS9dLe7
	 Ot0tX2euN1YAWtndcN5Nj/OzNtarfODNsVQGi8Q+w98KqXoNu/f9dBwFP11JaMu3P
	 owbuV95QnS+YRWWy8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfon-1rnXNV2aKL-00TvHq; Sat, 30
 Dec 2023 21:08:16 +0100
Message-ID: <ed2f5323-390f-4c9d-919d-df43ba1cad2b@web.de>
Date: Sat, 30 Dec 2023 21:08:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_2/5=5D_bpf=3A_Move_an_assignment_for_the_variabl?=
 =?UTF-8?B?ZSDigJxzdF9tYXDigJ0gaW4gYnBmX3N0cnVjdF9vcHNfbGlua19jcmVhdGUoKQ==?=
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de>
In-Reply-To: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18qx8X9R9dIRWlO2/jLbUn6fKchkG9q9s5s9lZu63vS38Eo/5ev
 RnmbniKYVw/tMozG3vCSqLSGPjlaFDksCSEyEFK8nKfoIyBun8gZQBBNtpgbPJr6Wp3YViV
 n/AltZPgSrTzW3zwsNWLIEZy7Th93dxW2YnmsPbqFlw5ZWVV0+0eiGedZ7RXxjpv4Mrceyq
 dIy6B/+jmbxElD6HkJX8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i0un/BHbWps=;QKSAScUuoXyGC47nAxt4n0/zVM5
 wpBfYIQsN/kjWMzBtX+Ek+R15mw4eH8Lzju2aQ+ejfnuZqNMDZxPuc2RqwZe4Ov7cNb6WuQ2c
 Lu+Eogw6bSRQABNBrv/RkXVWtZTtPcXQEOmyn6SM8UK9qorbPJZ0CMw0ILegPwkhLq6tK/1pz
 mNCjRqv/aHhpWXzFiQYzf8hRjWxlQNpy7CnfG3fT+PTmN/tzyrb31W5TZ/4yHgMJhmB4oavlA
 2lNArTKwkfmfO0mGBeOj9XPi/8ApRYC2Z+9Qc/K5XG2xzxueKU5MSFq8M6fyfJaaUmSANJUXW
 R9t0qlVB/g+vAOrSok7rv7r94FAO26vrQttz53agoQW9vN3tK9Gk55cq3CKtvn2J7iSQi+YPN
 cLEoc7+t0Z9ZTcHE0nNwmcshOthzEq2Bt5PhABxjSV532O8yZO8EKxEymAHrAipbPVcCRFQZJ
 JpmUD2PnpI/RRQpDCORvCrepVECBSfT1gQhWGS0JaCAOEDlUpYb6ziYJj6E3hryx048Swz9Aj
 5T8vAb3BZGuxCN3QQrVw4TaZWc+6IWmdpJjF8iTqFIlNE2vCScb0KF2hYSU8ygNFL5SleIGx6
 008CdapbEA8tjCiJ/sF9xZWNB0JrMUgVM5l61wtOmEJi2UB/z7gSGRo48pSqVk6i47ccjnPxX
 i6iPqRaExLPU7R0RDS5K0ZKr8pLfAvAOtyjPlSPZDl1VjRAn6mlWSlfDMT2kBFgke5vOVvlYP
 JizTrINS7kElSNl/6eP+6g84nLKTTqjyLJ8tLXOvxR9d6TRhD5e9Wthjou87KkCLoq778nad/
 ZofMjzuEBHro5p/JLiDA3e8fU7LOsmLy/FIyNE5nHVX293+trIAyFfG0wphkn5EO+8nkhAH25
 xG6OmtE5mWbO9Nq9ZVO9pDLHjST4b1XPiJUqZvj65ThGwj7s69i8Yq62BsUyrHZkeC2FuIXmN
 x5010zC6Cb/rzRRyGeL71QRvjZ8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 30 Dec 2023 19:00:12 +0100

Move one assignment for the variable =E2=80=9Cst_map=E2=80=9D closer to th=
e place
where this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/bpf_struct_ops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index b49ea460d616..4133d65c2a28 100644
=2D-- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -898,8 +898,6 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (IS_ERR(map))
 		return PTR_ERR(map);

-	st_map =3D (struct bpf_struct_ops_map *)map;
-
 	if (!bpf_struct_ops_valid_to_reg(map)) {
 		err =3D -EINVAL;
 		goto put_map;
@@ -916,6 +914,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;

+	st_map =3D (struct bpf_struct_ops_map *)map;
 	err =3D st_map->st_ops->reg(st_map->kvalue.data);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
=2D-
2.43.0



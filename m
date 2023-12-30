Return-Path: <bpf+bounces-18751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E716D820859
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 21:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773971F229EA
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2CCC2E3;
	Sat, 30 Dec 2023 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fn3gQFbK"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40785BE68;
	Sat, 30 Dec 2023 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703966781; x=1704571581; i=markus.elfring@web.de;
	bh=D2US4ZEXMGNvCB3ybkBudZXkGlLbPNb81iXdW55uLKs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=fn3gQFbKxRl8mXMrDVsEWJx2c89ER+Ze0ltH72Ev/IMvYr6GsW5Rq68QP1sOcX/o
	 sBt65kduKqN8ItflfgT2s+aJSq2b07FlX/TNYcbguI1RgRjQ2tBSu+Gzg0wxZWipv
	 PPz/rv+bLwSy13jrOVgiNaUG4nd94NQnHyg+2Tn5MEViAC4lcisSKggmDwiq+dOXz
	 riHdtobzV5na9Id4yT2Iwf06qraQgLs1fCVFylsaumdSoDy0pvUBDJmniJ7BCiwgD
	 FnNPSqzGouviFjrD6xYNHr+tYGOPTklMrbgdtqD5YICb/efTAi25dba9hmbrXmAfa
	 t9jSwzq9bOAV2Yi7dA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZI5-1rmQse0L4T-00Ss84; Sat, 30
 Dec 2023 21:06:21 +0100
Message-ID: <2c4ef323-4ed7-4b43-8dfe-b55aeecaa3bf@web.de>
Date: Sat, 30 Dec 2023 21:06:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/5] bpf: Improve exception handling in
 bpf_struct_ops_link_create()
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
X-Provags-ID: V03:K1:QUFRAMK31tz+n4I7fbLISjWjYnW9MXfTu8MQzaa7dzNHG4lyZE9
 hPxewfn30rrz6QwVKBfATU6jer4OQYLjoEp378zCcClBtSZXKtjPzGiOZ/EDARroYPzqeCD
 fILh7XzcmKpu8WyrVUOgLnEUEa3y6Imf5a7fbxgAHjX3/SDQvv6xMWdsug5E/4Mm33z+Bz3
 t9mZsI5CijtdmA9xcFYvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:juW6K/s+4Cg=;f9KejanXXCgaKD/YMUAkjb+PKOh
 NZ1KABzA54jNWyTHEcMkbriJRgAfvb2Mu8Vm5g31J7ttikxn+VVDnVZHrfsVE2sb974NcyoPB
 1XZsJlrk/sm8lSg+7aCcqnQ+5ydNQB/qtTDOIK6PCs1rVqBbSbUWak8o8CI6fcqUcH5rnEnF6
 e/yI1VbyDK6CCCurwwr+1rShIAxhHvqdtdO+eI2XI1TQZJqIaXMNdzfetVyPdUG6okIQmIeAh
 T1NbB4EHV8/qgYgNnn63zUbY5E9v5BMg24b36wMSyAdsw/5qoMFpsUgtfkGhiFJ74b1gPP0h0
 7RWCHVN9mlO5JUwcvySwz4wxC8ccWtFE1Q3W4njASSruuxHb8SHNbez5MAXJbDrh3B84ayA2j
 PqrfEeAnI9jnTA7nr40QjSn+4XOFz0toulO4iJIEKAg/BxMKmDyJGhPtedl0WNVDC3fS7YH7y
 tW8PitrX+XZYNikB59EgFgg/YRI5GN7U5xC8Dm8lC2aR61up2A0d9scwbw+hGsPkoi0IVcoFS
 4AnY5WyGAL8v+qXvr/cPHbvDVkAdFlXOa3CXeQVmEeobOIo7gn8Wf8Bf0ZhGuIYJZkr72IIzZ
 rKknj9AO44Y3E3cnrSdr4EtOviVIF2/kJcucQeJmcQHMpTr/gfKnbBBepN01zDjttz7Clh4aZ
 3dzCV0CLCd7yegKbpRR1x3rjtXbNkLyb6F0NpF75mg+DIreeXuZLpq0Jjv6XJ7ZnoAq837TVS
 O7gFffOgxcxqsXv8d5/Y3rEAhuFxnH6W+7rDVXwWvzeNWaHtxmH6aJbVX6sq9Fe5cZZaoYNZJ
 fkYzMxU3iglc7D8PpIDVwA346seOePP1otkraudIPvggQ4V6L9i0B3PTpFLnxkYmLoP78BYZw
 MUrPaYzS62uCWzY2mqda6lY06EkatAZHuTDF8UJMXqtmD71UqKRu+QG69mzGJW4Wx4D41w+DF
 EGIBPw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 30 Dec 2023 18:50:45 +0100

The kfree() function was called in two cases by
the bpf_struct_ops_link_create() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus use another label.

* Reorder function calls at the end.

* Delete an initialisation (for the variable =E2=80=9Clink=E2=80=9D)
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/bpf_struct_ops.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 02068bd0e4d9..b49ea460d616 100644
=2D-- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -888,7 +888,7 @@ static const struct bpf_link_ops bpf_struct_ops_map_lo=
ps =3D {

 int bpf_struct_ops_link_create(union bpf_attr *attr)
 {
-	struct bpf_struct_ops_link *link =3D NULL;
+	struct bpf_struct_ops_link *link;
 	struct bpf_link_primer link_primer;
 	struct bpf_struct_ops_map *st_map;
 	struct bpf_map *map;
@@ -902,13 +902,13 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)

 	if (!bpf_struct_ops_valid_to_reg(map)) {
 		err =3D -EINVAL;
-		goto err_out;
+		goto put_map;
 	}

 	link =3D kzalloc(sizeof(*link), GFP_USER);
 	if (!link) {
 		err =3D -ENOMEM;
-		goto err_out;
+		goto put_map;
 	}
 	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map=
_lops, NULL);

@@ -927,7 +927,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);

 err_out:
-	bpf_map_put(map);
 	kfree(link);
+put_map:
+	bpf_map_put(map);
 	return err;
 }
=2D-
2.43.0



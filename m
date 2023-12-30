Return-Path: <bpf+bounces-18753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5AF820861
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 21:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7D61F22C95
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 20:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43098C2D0;
	Sat, 30 Dec 2023 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Udxj252e"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7499BE68;
	Sat, 30 Dec 2023 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703967021; x=1704571821; i=markus.elfring@web.de;
	bh=4EGdtn/m/ZrZmRoMNxzHS5SQcI8bELVK6JHcnpRyjtU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Udxj252ekX00qz62jI/RwQoCSKYD3xKScCO9Ws3j3K1qwYb+H+8WV2s3D22UEalw
	 74SOXcZf+MJS2TQRlnZbotcbNcqt63ZkxINz91eM17FvtIl3N/wB0W+ZSpqKTFXNk
	 +2jl85kHgymWUVcyjiIttjnkPZko6rS+ng9Vd9lF4qgjHzV3q4xnHXm/bQ2G36Ea1
	 EZHsHpKJbenkXnnKikGo9RbRtMRW4iItSeWOmPSDgcDgOBCGUGOoAHA+eiTvTRNm5
	 +2Ip49WJN40g0vmrmgjusIXvn6sU0l2usg3cnAs+zmdOw72xt6G7a4qbw8d17MYu+
	 3FVllP56s5KfPlRzAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1qqtDO2Pp9-00o5BS; Sat, 30
 Dec 2023 21:10:21 +0100
Message-ID: <02500028-e67a-4298-abb5-ff4fd66de044@web.de>
Date: Sat, 30 Dec 2023 21:10:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/5] bpf: Improve exception handling in bpf_core_apply()
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
X-Provags-ID: V03:K1:Jj/BVAH9nKTRpviGnzkgzmM2W0xH7P05KPv2jiu6fqetx/OXSEp
 ALiC5Rp54eVC+xnBvwgTjDoULtRrdQWpaymrbxq2nxo+hwv28pGNc/YFquDDFomaPMiMLtH
 8f5lcrR9IqJsIQgKfSZh2TyQihHe8/GwHyZ6rDNmr5b9YwEAltQG4y7ZimQlwaDEPPefdDY
 GtbL8uAxWRuS/uQm4wgzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:chwhZ8dfETk=;CrwEg3QAt7JxpYRcCuvDrbxBfpf
 lPiCQqRGohBNgMMVrYYWtu2mvZVdNhiFR3810Rm+8NcfiuFcb2PQ7SzxHrnnGiAMtQ4OUFi9D
 v0hYNgd3F+sgVkxqXWnOsrNhWEB6Cq8rq6aZW9RgtnhQLLACvC062LK5eN1hcEPjMR0HIewiV
 g3WD75Dg8zxLWwYZrW36dMqqaub6aI9waLTH5Ppj1kz3eFZhkVDEHPmR4j1+Rg4YXZzpkK8xE
 /nsEPtOtNg4GrRjcogLHOiWNMbs9KJNiC0Sma2KBoWXUPhqvEDkGI4fJI5boGj/0yJzCNydIh
 EsF4AJT4ARnUnS7lz/MXgYdjEdkLeCRq8vo/BjKKM2rqrXDd2G7bXkSO/KDDKmRQGpZyoog7F
 1tXxZRIDyEh37bCHtiLxegQh4THnI4s59aU4Gc6CD2yLYH6LbFe9x6OcFjfBQB7xQdrqdYWdr
 CU2Jdzz6Mb89ieSdgS5dDyrGsQkM5lxB7hL7oDz/KpKUs97W3qj66jHUV/XLfFyGMO5X+ZH0o
 qN7AWjodlPCk/gXBugt24LUJ6Z9RZFYlDQMq/uHAmbHqT7NWhUk0OPr3T8PUBx0j1BByTL5OQ
 ac1PchRLGJp0tcO8SnQjE1Yi4CHpvgof9pFhbruh+F7/hnFu40F3zDp27QSxMz+N6MowdAxeH
 jFLH2FHIJJ/SrypDLZzlT5R69JSgFNReu5qoYmiybtECDWjnXbkGf6/3+vnGzF6CVf1zn4D8s
 dULGIN/IXB4AY8kILRdI7oakBlzceTLtVJlspWkThxDD1Kxwg48RN7e6zxGgsZx31y9k9Fkdv
 pjCMfpUHJggnTC69TxNooT34leVXi10OtIFtm7ST+sGEiRRdwMWrxS8fDTHKod1yuaKZxkzyC
 uEdCo7FtGxmNsIi7RTJ0ZdH9Krlt6MV18oxFcnblAQT6XNJLsVffsEU6cnVy/qKiLpSZwfcSf
 9nby4g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 30 Dec 2023 19:28:25 +0100

The kfree() function was called in two cases by
the bpf_core_apply() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus use another label.

* Reorder function calls at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/btf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 51e8b4bee0c8..e8391025d408 100644
=2D-- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8322,13 +8322,13 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const=
 struct bpf_core_relo *relo,
 			bpf_log(ctx->log, "target candidate search failed for %d\n",
 				relo->type_id);
 			err =3D PTR_ERR(cc);
-			goto out;
+			goto unlock_mutex;
 		}
 		if (cc->cnt) {
 			cands.cands =3D kcalloc(cc->cnt, sizeof(*cands.cands), GFP_KERNEL);
 			if (!cands.cands) {
 				err =3D -ENOMEM;
-				goto out;
+				goto unlock_mutex;
 			}
 		}
 		for (i =3D 0; i < cc->cnt; i++) {
@@ -8355,13 +8355,15 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const=
 struct bpf_core_relo *relo,
 				  &targ_res);

 out:
-	kfree(specs);
 	if (need_cands) {
 		kfree(cands.cands);
+unlock_mutex:
 		mutex_unlock(&cand_cache_mutex);
 		if (ctx->log->level & BPF_LOG_LEVEL2)
 			print_cand_cache(ctx->log);
 	}
+
+	kfree(specs);
 	return err;
 }

=2D-
2.43.0



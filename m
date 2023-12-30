Return-Path: <bpf+bounces-18754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D7820868
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D239C1C21BB2
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868DDF9C4;
	Sat, 30 Dec 2023 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PKzhjnSI"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F8C8E0;
	Sat, 30 Dec 2023 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703967145; x=1704571945; i=markus.elfring@web.de;
	bh=K6NQxGj4hjvTJqhKo6zca8RxH2GLf14mMfJnmGs1PZ4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=PKzhjnSIfb5qnv45Iy5h8oQjavLuoskbDGK8zV+/1SCUw4NpUPo5pcK1EWtM3Hoq
	 fX8AHsUeQNSwrSV8zA2U4SGSm8b6RBhTbYhm8nOXP+Nc7wpd5vbmuOr9Ia8V+QZyS
	 GNghKMOMJjy9FRR/APcSw0yrpWXEauB7mN36tk3B07AR++xB/iIr/rX5gn75MfjYJ
	 sB+gJrV/m7GuV37ySnNU4QzOsMjvUGJvNVoL4EovIhc7lcLG0NX2NUWk3cgMhH5dq
	 3avfpC3um3UZOpbUd08zlCkWjaWo4TnVIdxFnFJaWNMx+n+vLsgEYhCIV3YB1QqNy
	 e8PcuSFOekyDSN/e7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBVh-1qhZWe0I9V-00emtj; Sat, 30
 Dec 2023 21:12:25 +0100
Message-ID: <996d5970-3295-493f-b144-99a0ff771576@web.de>
Date: Sat, 30 Dec 2023 21:12:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/5] bpf: Return directly after a failed
 bpf_map_kmalloc_node() in bpf_cgroup_storage_alloc()
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
X-Provags-ID: V03:K1:Bzd7uR+QKaeuLp/OaokKWTTVdIx1ZBWHfLlJFsxem5Z06wv8etG
 f3A528Ziitxub2/6Djz3VLqtG5s7YYTc71g6LoHzXsF2qQw99GBF/iB+pXJ9et/1V3Zu2HY
 OxA7outD4cGk/rO94yv7wfn7uywF7I7neFKN2plTMYR9GIIu/xIi2ENIOji9NxLuep7DLHv
 gWEdB/v9gQVUtxnDS9oTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h3eYr8fwcAM=;ke5sU6HYS0rZSEQXBHFFa/fgy1V
 cmawg2hCsSZ/DcNDXX6Gxgdt5bnRjCmATpmuj/J6gQrP3yFA8l1D+DWe9qLuqA8363Ue9N07u
 BAGPE5piSufMyUasFwTGEcibF4zVGMXI7J0rq71nU8tsniaJ3w4nhZWwSa/xXrXR4o7zz+ft2
 XO7E9XqAEVahNXNnwll5QHzTe6/faChZ+VwM00iHVEVwMR+lFxQgpaJpZrijFhi3SlP4iniRl
 3KI45dlUgfo4fyx/CxVyqYYdq2eze7FLf5+Lobkf7rO3dluUrJL05VZWknH79oJWNQqrd+qtl
 4iSLyaEb/9gnBSoRKMdYyWETe4H5/qsnWH8+ldW1e+/ykDpgJGQ7TIA3aKZKxka10CCbGgLie
 NNQPDcVH9DeyY5szX5k8W5jcoO3L00sPnR/TDJSEL1Hw/RQv0JD/vCs6E5Uicn0ekUPQdd4WI
 Lsu2OrzECb6drkUBewtbhP+JNMzg1zZlQEAcmNPbct7RNw3ApvgVvFZqRKPGVB+YKRYI+EfNm
 O8nDaa50Tnsw71MP6lHfsUzorp+Ve3bEU6DMc/q2HiGcwOmQxiJOSW8rTIu31t8GmP1+8TEoa
 aiuimsPn5wSSRedxOiO88AXIS3sdx7AeeEFBmLKTYJeKs6GPDyWYRLSqUSDQ1tlbv42TIW1xg
 YTqeyTVlHJWlrvrdEBIGT/aAmUPDcZOzY5N8ySk+1+ucfAdzsRB8EctrWzicIIdzskhDzB9h5
 F5/7SiPFFovNDhOCL4G1oI3oAqIviRAP2xC7BnsRCsLWnjMMQaJrrh4N4M3MKhnfCfzivKUH4
 bN6VgsArqPI0bLRvpsrKUVGgXs+cIoU6w3yJKXnubngoOWaolCeCtZWevKpI5/G8xkrqolQdb
 m7yx684r1ag62i/Ixg0+rEFkrfPq2XSiLCCVRcHfGiEmz5H3x4AH3s6FNq0iZPqmV+gkbhQXU
 RVmAUnF0OBshMw5rgmO29/IeonY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 30 Dec 2023 20:06:02 +0100

The kfree() function was called in one case by
the bpf_cgroup_storage_alloc() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Cbpf_map_kmalloc=
_node=E2=80=9D
failed at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index a04f505aefe9..e16a80c93cd7 100644
=2D-- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -514,7 +514,7 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(st=
ruct bpf_prog *prog,
 	storage =3D bpf_map_kmalloc_node(map, sizeof(struct bpf_cgroup_storage),
 				       gfp, map->numa_node);
 	if (!storage)
-		goto enomem;
+		return ERR_PTR(-ENOMEM);

 	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
 		storage->buf =3D bpf_map_kmalloc_node(map, size, gfp,
=2D-
2.43.0



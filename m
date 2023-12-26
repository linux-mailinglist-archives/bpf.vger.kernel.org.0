Return-Path: <bpf+bounces-18678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC5A81E906
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 19:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062DC1C215B1
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD46853E3B;
	Tue, 26 Dec 2023 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sXGNVCyp"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410453E39;
	Tue, 26 Dec 2023 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703615055; x=1704219855; i=markus.elfring@web.de;
	bh=f/Jl+Efb4DezWv7JjmB2u06F6X9iJ9wWuCDtqZqFeRI=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=sXGNVCypFGIAsK2RhOYeKeJcBXK67emWhsnUVXWiS516ZyuRkp7swYAV0uPfTp/s
	 rf4/PxzykXj5No3yhYFHysooCljMX1Yc7znaiaz4B0eAgQGlK7rj38hdFkIiuy56J
	 bmKQCEPGLwIO4O+mSGRvEaCkSvwqoLa3xO3uTI5l0VlB/glh8EFeN13xluHtoTXxy
	 w0BsIZ/+mkgffR2WBfCDQA076d+IgxOtivut6fSRkSwrnCXSyZj59Ff5aoctIPUyd
	 KMKrodkijx2nsde3PY5Kd9a2nEIEJ/zPTRCJZKpv45nmV4z4tZai4TPMTD38Gw4P+
	 Wbu/RU5+TVUEZBtUjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvslx-1r151E32WN-00sV6f; Tue, 26
 Dec 2023 19:24:15 +0100
Message-ID: <3203eb44-6e69-4bda-b585-426408cb75ee@web.de>
Date: Tue, 26 Dec 2023 19:24:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org, linux-input@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 David Vernet <void@manifault.com>, Jiri Kosina <jikos@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] HID: bpf: One function call less in
 call_hid_bpf_rdesc_fixup() after error detection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K8fF/UijAIywnS52YDqNMULxk3+NZg9vn/tgRlNElb24o0WwTPy
 VrprFxvBxar+Yk/bUyDiW3oFnHnY3d9QkFy4oTSTjHa+DVPlGrkiLHcX29RQV/JRckCY7tG
 tURb2Nx0wHr7uGfDz3PyL+uKqEFOyNqfdV4m/IyWF0bu/qPDYbW3StSulfsTU4PtarOzrSZ
 thlRopo4UMn+BP4/reC6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ACMj+myOfk8=;jpf3JzHWCKMdYEDE/lVe892U+x4
 +ohp9E/66yrl6WArelsmeCzCtQLU5fI+nQz7+zbw8Rh7E4VS27xlSmLkUV5qOh2xnr6qIfy4Q
 3dy+CqcHiggMWvfaECy2Z6m3vxQ9Bm0Mc5dyCpzFmkQzVujDTRaSu7DIVbCNe21prKltoKpXb
 tdocUzGGyrxAtCz8mFjQL3ZDccW8JMS8bw4ZkghMy4kpgCn2GkN2sjxSiwBbHV6nX0zRsZ0op
 QbnDeY5zK23XqNZovTNe+OHJudY1lRWl6kHVDBtaUM3xAOHHLd7O1v98JfVSfXaYXJzgG4/pK
 BDshva6Z4zkX+TQxn8Ft4yehcRikfPJ0NhDQW5K3HkxykkW6o09ES8fdGs/nKA5WNdgQalVG1
 rFtwmh18kyx720dpBmhBcKqdu71ptDhEPPfdOk8mLJhlvxOvVVBH1vMBqBdDcjUY6s8J7o0Nd
 RLXVJ+bKBzm35jVdHDvLMzCUAbVJRYz6kURg7LnIPXfyXsnwUOtujb+yPPbb+1oRa4KloCizJ
 XFX0IGTJn2hIoSJOUnw0XGX7Ztpt0femIsvtemDdevZ0cAmIX3BvW2m3tjUX0g3TqmdILQQ2u
 YFg6ecDBEb0LpRy+SY5iaXrE7GKrO41zkVDwI32FG0l5Q5yR6Y/ey/onqVUyjNDdR5kERT1jf
 kt5JmgkuFbGtQt61GghABhN220XPNDtW6WjNRsoRYaqWDYcXoeim83XjKVapCm2gRt9Xyjzdn
 KBngG0gisHHl3IVS6KTFtGXXJ+lAUGsqERTaHsanM0N5Ue0UWO3obSXYryiqe+6wUB0VTX+IU
 t6FCx2S7nGCeseWuES59HYJybPKMQJEJVuSreQn2CvV9mIHPrQTyiORK4uLp+U/UWU0aTahmB
 Lhv7kA4oulJjI6g0RQA0wVC0fEzAksp+9AltVkfGI0P/MnG5P8tWuMIuVCJn7swQbV4NwKM3R
 h08qWA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 19:13:25 +0100

The kfree() function was called in one case by the
call_hid_bpf_rdesc_fixup() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus adjust jump targets.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hid/bpf/hid_bpf_dispatch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_=
dispatch.c
index d9ef45fcaeab..c84fe55be5ed 100644
=2D-- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -118,17 +118,17 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev=
, u8 *rdesc, unsigned int *s

 	ctx_kern.data =3D kzalloc(ctx_kern.ctx.allocated_size, GFP_KERNEL);
 	if (!ctx_kern.data)
-		goto ignore_bpf;
+		goto dup_mem;

 	memcpy(ctx_kern.data, rdesc, min_t(unsigned int, *size, HID_MAX_DESCRIPT=
OR_SIZE));

 	ret =3D hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RDESC_FIXUP, &ctx_kern)=
;
 	if (ret < 0)
-		goto ignore_bpf;
+		goto free_data;

 	if (ret) {
 		if (ret > ctx_kern.ctx.allocated_size)
-			goto ignore_bpf;
+			goto free_data;

 		*size =3D ret;
 	}
@@ -137,8 +137,9 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, =
u8 *rdesc, unsigned int *s

 	return rdesc;

- ignore_bpf:
+free_data:
 	kfree(ctx_kern.data);
+dup_mem:
 	return kmemdup(rdesc, *size, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
=2D-
2.43.0



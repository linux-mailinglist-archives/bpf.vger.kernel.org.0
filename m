Return-Path: <bpf+bounces-58870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4491AC2C25
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9659E109A
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B12153D4;
	Fri, 23 May 2025 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="J4dEEVoU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15531214232
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748042756; cv=none; b=j/w6cOgagMr/Gcka/Pimat+7yubiZZ+1jJw/XY9tpT+PlxerS1cq95zXm8V9ukbhBAheBEauyYSHTQ06XnY5SACLXGRsoigGWeXrNzZIZtba/RWJqYNqHuLiu3AHhr4AxAOT6kGgp2l50MG2ZCYXEEXkd+f4KLpvqlv8VZb4Qic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748042756; c=relaxed/simple;
	bh=I1TMpIGfVZg9TVf8OQ/Z7fZUpLkDEiSZP23Kppgsh90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrzIbO/ZUUX7BS5SKMlQ30yYDNJ5Denj4fNMYeuX+uBxzWPCfp8j+UFLDgmqxkhlAjtxW0I3en2CLR5iGFrfstehxUTCsyWY6VYPNchC7BNjaS/pGFDV93qcPcfP0n1lqRI3amanYnSUoCAy+4U/7HoB5kfv2h3+K7nUDTiyCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=J4dEEVoU; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NJ263F016154
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 16:25:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=X2WPZ9e8gHldkA1qGFfNX/BQfmXyosLesW/XSBsPSuk=; b=
	J4dEEVoUZ95XDgcA4+sdKsTpztHZtH5GbA0Yb7UsIELDls5eF7KWN61VXxLX1oGq
	2sz1F79VS8jeljyRbAXIWbHt+M2fQF5jyxtfRSuY2T9l6NkrUaXONhVvKrehTLxY
	TJOCvL+otsOQhCm/Rd9vr9RqZKaZ0/ubbrafjoPCEsTrgPBGuugyWUO3fIQrMh1X
	h9U+PzGcIQFIN364feGiMU5LvSm1VbPK+9DemyJk2dxQvtFtuiqCZFOJs1PDU3IB
	JYgV4Vwu9nR3SFzzDLHMyGQ3NHOIrXtMh7u8IfoMSb2iTYgDepSInC1HCzIYPLCA
	RVGIcYjzC62hMlWGdaYKbg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46tjeexm8n-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 16:25:54 -0700 (PDT)
Received: from twshared11388.16.prn3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 23 May 2025 23:25:50 +0000
Received: by devvm14721.vll0.facebook.com (Postfix, from userid 669379)
	id E135E340760B; Fri, 23 May 2025 16:25:48 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add a test case with CONST_PTR_TO_MAP null check
Date: Fri, 23 May 2025 16:25:03 -0700
Message-ID: <20250523232503.1086319-2-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250523232503.1086319-1-isolodrai@meta.com>
References: <20250523232503.1086319-1-isolodrai@meta.com>
Reply-To: <ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WIqWnLADBGNR2Wz4IrjL220zyLLDmRKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDIxNSBTYWx0ZWRfX6GI8cPupb/OJ CDreblUls6wapbd41AfvirOdda6C0p8Tlb6kbsrUMNIuQl9gwog5uqnnykSsCeMWLfwN4utvCKU zc/IUG2wCdfZDyi/gxDXieuI4yhv/bJQ2OKN7rOfgB3bUziVZgCCX/pdzb7sFWtF/BHxRKU1zNC
 lJt4vMqG1NwEx0PLJbfoO+XwvZmMV4KP/8qflNWMe+riuzBS7+vMvozXWyCG6eJEC+hVTV5NPSk FzFxyo/4+zAnhhuIVZB6osEJYJhDHecaj0njpTmJhqoFs/2gv5U5mOlcF8AGxom8bF+vhj58eTv I2tP++knOLoUIcuJHb50m+whemUK2+MzBrpkibdcixec0OJh03gu9xTR+uQxQCk7bCfcNrVJAqj
 tbxsJYkldLyqTtsrU/gQG3R8agpyJTMKSuJZHPm7srjMP++IZfioxqTgyFunrTm31bKGlfal
X-Proofpoint-ORIG-GUID: WIqWnLADBGNR2Wz4IrjL220zyLLDmRKf
X-Authority-Analysis: v=2.4 cv=NqHRc9dJ c=1 sm=1 tr=0 ts=68310402 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=dt9VzEwgFbYA:10 a=VabnemYjAAAA:8 a=mcXsHRfn_Rt5YB-RwXMA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_07,2025-05-22_01,2025-03-28_01

The test requires the following to happen:
  * CONST_PTR_TO_MAP value is put on the stack
  * then this value is checked for null
  * the code in the null branch fails verification

I was able to achieve this by using a stack allocated array of maps,
populated with values from a global map.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../selftests/bpf/progs/verifier_map_in_map.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/to=
ols/testing/selftests/bpf/progs/verifier_map_in_map.c
index 7d088ba99ea5..52b3e1749e71 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -139,4 +139,28 @@ __naked void on_the_inner_map_pointer(void)
 	: __clobber_all);
 }
=20
+SEC("socket")
+int map_ptr_is_never_null(void *ctx)
+{
+	struct bpf_map *maps[2] =3D { 0 };
+	struct bpf_map *map =3D NULL;
+	int __attribute__((aligned(8))) key =3D 0;
+
+	for (key =3D 0; key < 2; key++) {
+		map =3D bpf_map_lookup_elem(&map_in_map, &key);
+		if (map)
+			maps[key] =3D map;
+		else
+			return 0;
+	}
+
+	/* After the loop every element of maps is CONST_PTR_TO_MAP so
+	 * the invalid branch should not be explored by the verifier.
+	 */
+	if (!maps[0])
+		asm volatile ("r10 =3D 0;");
+
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.47.1



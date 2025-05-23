Return-Path: <bpf+bounces-58869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33165AC2C24
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7C3168917
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 23:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B5213255;
	Fri, 23 May 2025 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="h04oUHzR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731D137E
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748042754; cv=none; b=SiVSczJ6QeI8opqt/gBgOjtm1CqJMs3ldl8gW65zQsuCxEmwF9P/2efhBf+YSS5+q6lv3/Oc/Hc3125zzChl9fd0YyXeATx4NpV87DdpSU1pDgyOWts1igmTefUYYf9MLUhPAcPd+tElabLGH/qx0Z4mmYZb43x/DUoJ66eT1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748042754; c=relaxed/simple;
	bh=JwIa/sAwz4RGIJGKKYd4JwtsnSJLBciOCXvUhpdnaxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M7gck5NOoj58RaGRxOaQARcvtgN5U6APCvl4lI4+Igb48teDEWhDyDy6rnin3CXxnWB/sfk63Uyj8Bhcmcf0Bvl4pPMjUmgZxuZvKE8nMUY5AYjRG+dr5uBEWnXQJYlmr9LuYqHfC5gKsoyL/WQApo3KIdykuzce0M15Dp88/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=h04oUHzR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NJ25lL024859
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 16:25:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=63Qs+1+o2
	JJVoTQznRKkaeG+/ltsEvHg1MJ6XtRHVKA=; b=h04oUHzRl4zv291KgaCldb4eE
	HgDMv+fZcNFaY6I5XUHrKb/Bpa2QHTU69jMv8O+GCTHAW7we3qCminLxp71tUfHj
	2rqqP5LBJkKGbjcpTU9NcSUlD4Eo0li43H0ydw0qyHTS2p58opkCWS9r92+keQTf
	scSE5B03A+W4n+H7ER6dy/THLwZiulGnJ/C6Ny39aD7bw5sQ67bMvUPyAcpHqrze
	dbbRRsfp5isWiAA5bg8DOijtZOFk1/fqJbpgkVyyeG/nDeQQO4zpJZFI4KKAcD/1
	/ltE4nLuY1W4ZTXn3kQ8+TS8VlX6jgZdPFWXsgxluNm9qkOY7itFLlQE+MEOA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46tjef6pn6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 16:25:51 -0700 (PDT)
Received: from twshared37834.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 23 May 2025 23:25:48 +0000
Received: by devvm14721.vll0.facebook.com (Postfix, from userid 669379)
	id 280DC3407603; Fri, 23 May 2025 16:25:46 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/2] bpf: make reg_not_null() true for CONST_PTR_TO_MAP
Date: Fri, 23 May 2025 16:25:02 -0700
Message-ID: <20250523232503.1086319-1-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDIxNSBTYWx0ZWRfX0mBusElqNvkq kmbPfTJlLKwk0nAtLi09ZnrfJ5O47rOqsHUqayj4bC2Az36a3t5S1EfJS0DMIOWhv32ZthIjAQa 9P5F3eHR3BPVDrolfZWMP+545VX+oACUuwm1bP/PQTLciu+Y5LwR7re6oIxM9cjc0UzV4jJowwp
 npjb2sVVd2gArqjs1ir/UHsoYWPoyKNelAi4nXDSLgITPcQ58xPbEIk9JhO2rN34rTltaWf6m85 9EwAj6i31pZAMP9zaHSjvFlIciosnG3sd5ncTnxNqZzrMNiqQHD2y1uxiPrB1f4hExMEGD8Es4u aE7lH6F1GU2VHUVcSkOljPSkTSBn7PUxFMaZVqZkPkpCYg3lZgN8M0EM4YX66wIyW8tUCbB1ESA
 y5dMDE0qfYlMHlvKiArJVTVssUyCRlsUOg1MYzp4hP/fFaieb4sTUKgnPM9MtyvpJCAH0jnS
X-Authority-Analysis: v=2.4 cv=D5lHKuRj c=1 sm=1 tr=0 ts=683103ff cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VabnemYjAAAA:8 a=Su1BPnBXl1j9F-hLI68A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: ffC3-EZ2rY2n5uNUtgycHx03sOjNh_QJ
X-Proofpoint-GUID: ffC3-EZ2rY2n5uNUtgycHx03sOjNh_QJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_07,2025-05-22_01,2025-03-28_01

When reg->type is CONST_PTR_TO_MAP, it can not be null. However the
verifier explores the branches under rX =3D=3D 0 in check_cond_jmp_op()
even if reg->type is CONST_PTR_TO_MAP, because it was not checked for
in reg_not_null().

Fix this by adding CONST_PTR_TO_MAP to the set of types that are
considered non nullable in reg_not_null().

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5807d2efc92..f5e23ec83ef7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -405,7 +405,8 @@ static bool reg_not_null(const struct bpf_reg_state *=
reg)
 		type =3D=3D PTR_TO_MAP_KEY ||
 		type =3D=3D PTR_TO_SOCK_COMMON ||
 		(type =3D=3D PTR_TO_BTF_ID && is_trusted_reg(reg)) ||
-		type =3D=3D PTR_TO_MEM;
+		type =3D=3D PTR_TO_MEM ||
+		type =3D=3D CONST_PTR_TO_MAP;
 }
=20
 static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg=
)
--=20
2.47.1



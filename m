Return-Path: <bpf+bounces-60080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649CAD25A1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E14A7A70A5
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252F921D5B4;
	Mon,  9 Jun 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WA8ycHeR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691C1B425C
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493856; cv=none; b=irV9uWzY00aNXXvANdLQepE4CYHJ8w1Lx7O8Ci7Qnb7BP+6UFdetAWHnPI5GSeXzzoWvhoD443QHgR7XRfLJO9ZXHJ3YG+TvmZT1lekEWyluFOzRufTVXMMe4H16OaR0yxqfZ3GftGFt/OrKFikGmrcI02+vF0jlMJmI86BK12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493856; c=relaxed/simple;
	bh=nGH9brEjf1TqCcRsgMkoxTNb0PDZ1JOHQd47Mohfr98=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BffnI3ccFgSnEjl+W5ESiWSKjOiuHcSfaDNSm+iQICEOnjQtbRfkV3tpn5fychs4LMWTmiZR8zOeDA/Z8rIPFjPasTl2hmubVRQGLvtWvGAzOT8uQFk7iJxVbFCrpvx8Bsov4huL+VFxat1hvtMRpvZm/MiWM7D0bgbO6CPoF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WA8ycHeR; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559HUr1r025857
	for <bpf@vger.kernel.org>; Mon, 9 Jun 2025 11:30:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=Gc5tleTuK
	e8jYXfoLcp4G9mtWZ4vTHrEtwmqB5zdKhQ=; b=WA8ycHeR9u3fvsmOQ35MXb32C
	MAhf5Sd2m/qSW9xJCrROTC2nrlQKliV92MGSllzN2hzPK74bJYXItzgTpNsbp/Id
	55CAj6pBYmVyx3uYSNE/kPzq5D8+DbGFBb02hIPD0uq9pQu6UTySLM3+OE6LByAB
	qc8XeZp0neMNdCacIU9UOaMhKnGQUSyUHzGW2Yg2azjiJNpo7kg1R55RmU83le+n
	XqgUcwNzqa1xu3cIttntHown71K4cKw94ZR+PhuYxZLiCpu0N0tZJI2eQa92uDQK
	YJSFKB7vHgl/3tuN40wyN5XJQ3KjBe/7nbMlSG9mp3nDnovSvMC2EqFha8vEg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 475qdtvxu7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 11:30:54 -0700 (PDT)
Received: from twshared15756.17.prn3.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 9 Jun 2025 18:30:52 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id CE63B94A1DD; Mon,  9 Jun 2025 11:30:43 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <yonghong.song@linux.dev>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v4 0/3] bpf: make reg_not_null() true for CONST_PTR_TO_MAP
Date: Mon, 9 Jun 2025 11:30:21 -0700
Message-ID: <20250609183024.359974-1-isolodrai@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0MCBTYWx0ZWRfXxSCGF70Hu1T/ a144UXcySEP+a1H7LrR5IYKgGSbPsjZOqi3PyIsQuO9/65Zd0aoeuP/HLWROGbd6Fg7yPbjqr4T PvLfd8aG6f95CiRdg2VvVkuYWFHlIpFp0oypwWy1GtuNyybvLwnPLldp0N3Brrp1f9jQ9O0o1AE
 nOXmD3lwZJYq3+OGUMqryW5VQpWJ+S70z03STj/Btg0Vb6az8ITwpjoRZy/NPuZzRa40oEwrwJu emeXw44x1xchJXDv4eBcxqI+IYUtWNxWTQFtjgM+bDfwUJP5c/UdSyFxW4Pf2TG0wbB5tVtmkAK fm6lWW/w05Djm/VlWYu1uoM3kz/iMKJpO1d2WlC2IbGNWECNdvw8SvX1k0/0LaORz1r2dFoy8U0
 uikqtQcwBVJ9gcns0SxkD85jrFuLLArEhi07lILS5kKLmsuJhjHpc4I/vwSztlmOn1FIZ7hK
X-Authority-Analysis: v=2.4 cv=U+KSDfru c=1 sm=1 tr=0 ts=6847285e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=qYyqmn8cqaj1eAp1U7MA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: dZ0zxTIkQLvMWylmq94vbT86SFXZUAvh
X-Proofpoint-ORIG-GUID: dZ0zxTIkQLvMWylmq94vbT86SFXZUAvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_07,2025-06-09_02,2025-03-28_01

Handle CONST_PTR_TO_MAP null checks in the BPF verifier. Add
appropriate test cases.

v3->v4: more test cases
v2->v3: change constant in unpriv test
v1->v2: add a test case with ringbufs

v3: https://lore.kernel.org/bpf/20250604222729.3351946-1-isolodrai@meta.c=
om/=20
v2: https://lore.kernel.org/bpf/20250604003759.1020745-1-isolodrai@meta.c=
om/
v1: https://lore.kernel.org/bpf/20250523232503.1086319-1-isolodrai@meta.c=
om/

Ihor Solodrai (3):
  bpf: make reg_not_null() true for CONST_PTR_TO_MAP
  selftests/bpf: add cmp_map_pointer_with_const test
  selftests/bpf: add test cases with CONST_PTR_TO_MAP null checks

 kernel/bpf/verifier.c                         |   3 +-
 .../selftests/bpf/progs/verifier_map_in_map.c | 118 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_unpriv.c     |  19 ++-
 3 files changed, 137 insertions(+), 3 deletions(-)

--=20
2.47.1



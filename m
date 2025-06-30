Return-Path: <bpf+bounces-61902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76232AEE96C
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927C13AD818
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5496225403;
	Mon, 30 Jun 2025 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NP2FOp9k"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F4223715
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751318505; cv=none; b=hRncR9/XppGY/zLCV71utrDBmG8XHD4J6t+k5gJtCz61pl5BrbWTmZ2h2JNNQVGgTMHmy8Q+ohNK+9ChAs7k2KCWkZFAdJUYNm+BN4xKUDhYZhyeYYogl1s3gHjm/PA+ubtHd7GYEZ1TwzHCGA8t7w7CmHlSPCDfvePqDFQp3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751318505; c=relaxed/simple;
	bh=LsSseFzA0KH2YwS13BLmKgnhwlKKutT4gYWp1uIJhcw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BUXnvyFDeje8wxMhVioNNGtv1A2vkAdLU5zdkyNstg+XXaPPsizzvzJ95ACvKFnmyQgyJuFfOxMmuYtTdAbe5vbuNlcoQAlSZgX4kgvSVUnhXM6vz9oAY9HXrDRBRZfc7SzJWyytXVn+YdIqEVky6unW108TMDFc4pkAkeR4U10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NP2FOp9k; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UI8CMi014643
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:21:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2025-q2; bh=M7foA45va
	9Q9Fz/t5eGluArs47aKT+2wErtu14/CvvI=; b=NP2FOp9k4wzcrZmFsm3oV3UQD
	30oH5HxwH8QLeT4zm6C+ajxr+A1wK8iD1tOPdWQu9m1i6bpeLIPUCjKm3r11Hpl8
	n9PjQiId3Vb9rSP+jfhLQzJmYvU/IsYAz2slkPPOAGI5U8CieDtn+fjESTT3s/v/
	CRsOVzqhuvg8wSdNg9XR0jAro8xrilSsQhgiIt/0+uPsoYykVzwVConJ1yv9ZvJu
	0DjXBAZWUSAWuHmFiGeoMOdi7moYmbOBpT0p/Hm9ImwRh+edq0wa/v0NvqhT0T5F
	BGBD42yHfaKUF6t0BYkrVkISwDjIadJ0mttEgXpLRREz5SX34DULOJSjzBRcA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47kxgy1st5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:21:42 -0700 (PDT)
Received: from twshared76339.05.prn6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 30 Jun 2025 21:21:40 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 0BD341B5FA36; Mon, 30 Jun 2025 14:21:22 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v3 0/2] bpf: add bpf_dynptr_memset() kfunc
Date: Mon, 30 Jun 2025 14:21:11 -0700
Message-ID: <20250630212113.573097-1-isolodrai@meta.com>
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
X-Authority-Analysis: v=2.4 cv=R9QDGcRX c=1 sm=1 tr=0 ts=6862ffe6 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=C6t8Gl62TNz2gn5n3h4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: iiwf_Py8PC18XCo6-zP1FiodDFhY2lq4
X-Proofpoint-ORIG-GUID: iiwf_Py8PC18XCo6-zP1FiodDFhY2lq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE3NSBTYWx0ZWRfX2tBs+tedLAMa 92iFPyuG8qqqMYtRStkSojO1WEbozSf2GbtOB2V8ceHehPydy+sZjMiM6Ef98otR9vZ8epGko+s 1ureGVZhKugKXzKEVTu3cAjmZOtBGkghv7xa5iLYF5teEqCMf9AnqaPeugOnjpEKEVOKnQ1IOAL
 RZlMsEwGxyDbyK5VwGW/zJc3x6gx8+KHCgYoJ6661Xypvifruf32NeNt1oNyAT8Bsh/jNzVwUh+ VDLo6Gp8w1yH6k2RHLTpXoU05TIPDGRNAfcd1s5kLwnXmtrI8G7a/md/KFt53XqIZcuRVltJmX7 +lsSYYqVsoYb2wurNcs9quJMYXodd5EkhRu4Us84jrFhMlmFb7Svgk8IlbCpMTkabB6Dk2VpuT2
 k3NBx27EUJVkhOYSXizqU64HOZ0C82mXYo9fhqkfawDE7zfG+spILzTrkbXhYKwNXm4qcHqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_05,2025-06-27_01,2025-03-28_01

Implement bpf_dynptr_memset() kfunc and add tests for it.

v2->v3:
  * nits and slow-path loop rewrite (Andrii)
  * simplify xdp chunks test (Mykyta)=20
v1->v2:
  * handle non-linear buffers with bpf_dynptr_write()
  * change function signature to include offset arg
  * add more test cases

v2: https://lore.kernel.org/bpf/20250624205240.1311453-1-isolodrai@meta.c=
om/
v1: https://lore.kernel.org/bpf/20250618223310.3684760-1-isolodrai@meta.c=
om/

Ihor Solodrai (2):
  bpf: add bpf_dynptr_memset() kfunc
  selftests/bpf: add test cases for bpf_dynptr_memset()

 kernel/bpf/helpers.c                          |  47 ++++++
 .../testing/selftests/bpf/prog_tests/dynptr.c |   8 +
 .../selftests/bpf/progs/dynptr_success.c      | 158 ++++++++++++++++++
 3 files changed, 213 insertions(+)

--=20
2.47.1



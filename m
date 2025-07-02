Return-Path: <bpf+bounces-62195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB3AF63B2
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 23:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D617B3E63
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6A23909C;
	Wed,  2 Jul 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZAOZapXH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9341E1308
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490206; cv=none; b=Yy1t6GFSLfZ/QopQBajM/6DyJPsLe60xYTJ4sTAUalzCqh5zb2uiQxkFOohVNG+WiVmQfvvj6X5ybJZ/RkPzKisbUIYjtTML29loWF+kw8x/auWMF8WPtJ/4OFDcf+SulT8GTSmQqWNpXTmUpEZA5NTY7bpUlHhmfcl+xITOm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490206; c=relaxed/simple;
	bh=nehDo2nkquKmgfWKjcRPbWFT4Dpbkt7CySlA7QGlbVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MRguwSL46leuAs7njuyFy1gDDeLerYqTUFhiYIbUw/fdG4fkgWDjlNlX5IIdUssJTICHxO6QKsHNvnVLV0tov9oceLdtfaI0HxBQMdx9+VlMlLjccl1N58c8DuoGvmzKrqdHgKmcqNXBbJIyuenBvwp3M3bIy6F1w6AHaMbR4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZAOZapXH; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562HxFNL029620
	for <bpf@vger.kernel.org>; Wed, 2 Jul 2025 14:03:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2025-q2; bh=c93RO8zuQ
	bx5Q+HPrImN9j3US0eW7TpTxAXNjPpBphs=; b=ZAOZapXHWWmzOtQlJ4odUAczD
	pHReseNcTqv+p6ly6SneyvvkxWGxolk1LzXGOR1CM3QqPrj96cDSwhPWNQnZaR82
	+BQWYxVisa/o3C4JublU93KD6yTJUiDk9/bKPjTvU+S72euNSBGP3Z+H/oSfNqRm
	Y3grMCbUx7CjSqGI5ZuJqOnhGfCS0HxSiSAxALBFp62Lw94iSPvYqS0kJ0UccmMr
	Xi9268SlHrLnqbIjtcgT73EmMKiKEZRMQG5ui76PlsRtsPKzhJCcURONISiRn+nM
	f41LM1Arxen2cRWGB2Z93+lh4/u6GVvgF/wafOncJW0FJWjbIAmNQbkAeVT4Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47myk15g7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 14:03:23 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 2 Jul 2025 21:03:22 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 7CF611D1F550; Wed,  2 Jul 2025 14:03:15 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v4 0/2] bpf: add bpf_dynptr_memset() kfunc
Date: Wed, 2 Jul 2025 14:03:07 -0700
Message-ID: <20250702210309.3115903-1-isolodrai@meta.com>
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
X-Proofpoint-GUID: TqCY0CUCLYQCNRjOXyb1qgQGfXPsdZUU
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=68659e9b cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=XsNOZp94AJsq1Sa8geUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: TqCY0CUCLYQCNRjOXyb1qgQGfXPsdZUU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE3NCBTYWx0ZWRfX008k8kSIp04f z29Upps1VrNWBpDN5qXFOy/3VWHRlP3sf5lvg1m3KhexICWEqmcS9fuAfPa33jHJlhvq0ikG/im ynzyT1JSgMnXu33YMsTQgnYz4O2IOsKdbCpsrjyjbQNZbFpOLlEEaj+m3kRt9jFQJBaYKCt/VyI
 MhnSfBZEniLUWS3cMIs9AheLOZ70IC8/KKQkSCFRMMeJY70q9yVSAVIOjD8svvhadOLHdC30uzR nAqHaOg1hvOTIGBcjVTjTtD3NadQG16EqGhIYAEiq4M0YqXVqdpRhYCqUdD9fj9ZbDKPnZepy42 TlicfFhGDQ5a1Cc7Y4CljOOvcJoArF/S3p/dxAHBB2nRlegHSsntCgRK/W0+x2nQJANyHBujsth
 /KDHBwmo7tlnKYFU8U90aH2jeV+FlbA3S6uG64T+r1b+2LR3rV723ciXyrFbkEoikE02dXtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01

Implement bpf_dynptr_memset() kfunc and add tests for it.

v3->v4:
  * do error checks after slice, nits
v2->v3:
  * nits and slow-path loop rewrite (Andrii)
  * simplify xdp chunks test (Mykyta)=20
v1->v2:
  * handle non-linear buffers with bpf_dynptr_write()
  * change function signature to include offset arg
  * add more test cases

v3: https://lore.kernel.org/bpf/20250630212113.573097-1-isolodrai@meta.co=
m/
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



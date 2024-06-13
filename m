Return-Path: <bpf+bounces-32128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A423E907DF3
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F61B22C09
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542613A3F7;
	Thu, 13 Jun 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nCzv+Vwd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4607604D
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313526; cv=none; b=SGq4AUswSyjkYa2NPsOOZD6i52RWotzK9v9qQRpTKQGMz2Zul0ooP6xUmiQU2yUcn5tJZ638BCqVUwKI8PYF6sMadLAeMf4ipYBjjToal20czZjjVAKKgv1BVGg/DoJC8xiqQNlRtppjRq/QQP+6geaN/hs0PSEvmheRW+CIkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313526; c=relaxed/simple;
	bh=WJEQWrD8y/YDG13UfibZPn9rcjRLIRl0oABTuVK8Sxo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JthT/bdnD4djGc1hxV+M5n1Re7t+sTxMnk8NOZGzYa8K7qaQ8U2gEbx6PTR4pcCXPRWs9J6ANcbCZ7LPh59PEX4Bl/9FKxtw+hCDwXzBazaxNhuXmqQyyJD5mqL5Z4wqqwJSbBxbK5AAXYqDpLwzvIyuUNDkgPhy2lgS1NmbaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nCzv+Vwd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45DJXJ7N001207;
	Thu, 13 Jun 2024 14:18:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=mOiBHROotYxwZcF+/ZFZagzgfiL3LDG6QUZS1w+kel0=;
 b=nCzv+VwdQB492HC9UxQ5WC0wG2v7TX2OMKYFnBpiiw+CFLQkon3whC1bCHjQ7o4Rax6S
 4R257YUmtJq8X7s4xCAzZQbT1kTgSXVGUvFAPJ0KKujtK88+I1KWRQFAsZoArseRAXSt
 R6YLbfi7MnU2cHJ6Tf6fFviAMXkNVl45QLxUnW7PWDFoOXgGOgRUeydA82cWhf1+NOXj
 fNKsWwZQQQsXHxEBh3vPlLL6nplZ8E6rIhhtUa/PceKOL1EoUWpKtFm5MCcoCvRwxinl
 sD1XCKP1bBQNeXE76qHPkcO3qX7l/loJqQgp7XOvWeYW6UYTr+v1vcvQX0CsmFkXZa+Z vA== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yr347av5k-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 Jun 2024 14:18:28 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 13 Jun 2024 21:18:25 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>
CC: <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>
Subject: [PATCH RESEND bpf-next v3 0/5] bpf: make trusted args nullable
Date: Thu, 13 Jun 2024 14:18:12 -0700
Message-ID: <20240613211817.1551967-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S2sGcG9UylW98KNmfCUy5bFkBXx5ZojC
X-Proofpoint-GUID: S2sGcG9UylW98KNmfCUy5bFkBXx5ZojC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01

Current verifier checks for the arg to be nullable after checking for
certain pointer types. It prevents programs to pass NULL to kfunc args
even if they are marked as nullable. This patchset adjusts verifier and
changes bpf crypto kfuncs to allow null for IV parameter which is
optional for some ciphers. Benchmark shows ~4% improvements when there
is no need to initialise 0-sized dynptr.

v3:
- add special selftest for nullable parameters
v2:
- adjust kdoc accordingly

Vadim Fedorenko (5):
  bpf: verifier: make kfuncs args nullalble
  bpf: crypto: make state and IV dynptr nullable
  selftests: bpf: crypto: use NULL instead of 0-sized dynptr
  selftests: bpf: crypto: adjust bench to use nullable IV
  selftests: bpf: add testmod kfunc for nullable params

 kernel/bpf/crypto.c                           | 26 +++++------
 kernel/bpf/verifier.c                         |  6 +--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  6 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
 .../bpf/prog_tests/kfunc_param_nullable.c     | 11 +++++
 .../selftests/bpf/progs/crypto_bench.c        | 10 ++---
 .../selftests/bpf/progs/crypto_sanity.c       | 16 ++-----
 .../bpf/progs/test_kfunc_param_nullable.c     | 43 +++++++++++++++++++
 8 files changed, 85 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_param_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c

-- 
2.43.0



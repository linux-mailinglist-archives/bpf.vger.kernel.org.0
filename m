Return-Path: <bpf+bounces-27004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79068A75D2
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 22:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96A01C2132A
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8043AC5;
	Tue, 16 Apr 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AaGCl/+Q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1911E4A8;
	Tue, 16 Apr 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300043; cv=none; b=pEQr/d2/kNtSb+dxBn6S3HhG4RSZujQQS1l0DjHQGYYtm+7JCnWKTZBNQso3JE+3+skPapPpKzq8zfkyw4n+PBE6xMqCUW7A3MfWyupwE9GWkl4/BuBN1Rj2QsRYY8S16jHrPdnTeacctOMF+Tv7aO4DUELnLKyOifH0USycf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300043; c=relaxed/simple;
	bh=O674CqzWSFOaB0vQbA6Cb22bmNbYUKOeepQebIF+//A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMITLEHrQJ0//wfZHWVbAFZBi9LP7j85BU1YGg8UBQNq4RT30mLK1qZFZ4PCNJfPKY5/J5oPHqeEjEQxjcVb9G2uLE0ct8Fj9sXBbCcm4Qos9SyGUHL9vQ3BZCOpmdjlAe6hILb2N9qsZp7dEeHYhaCJ/NvZWMIuYt8+S8T9moA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AaGCl/+Q; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 43GKe8nS002287;
	Tue, 16 Apr 2024 13:40:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=OeiQ2BzPe5Dd5xEzYR9R3xK/wC7UjNX3iPjiqMWK0SU=;
 b=AaGCl/+QFEiDScDOX2+EPJDXuBJHr04y/8SH9M63oGNwfnObEZIJuUD3iLhKwrHrY/7Y
 a2FA9/vaWUynP0d5l3mf4+6RdRxWwRXu/S+BVRZafwSUQqZ1dkhyZaCc5T/D+QWqfNek
 HZK41HrWvem5ImIq9KPq/GBoNvGEHPYyiK7gM0lTK72LMyimp30WMKxj6xr9MRQ3Qt3z
 sLBYX/bqiNq21eWMqJHRD99G7RJH75VPh0nVbq95jPt6S+ynFTVpS5p8Sffs4RuhqZKO
 Rx1wtMdkDnNblzyNYPRGbBa+AXYharneUaITwGPXc7GBTOwDguJkOloqlzvPJbv9z8Vb TQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3xha39yryg-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Apr 2024 13:40:23 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server id
 15.1.2507.35; Tue, 16 Apr 2024 13:40:18 -0700
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v9 0/4] BPF crypto API framework
Date: Tue, 16 Apr 2024 13:40:00 -0700
Message-ID: <20240416204004.3942393-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bMj70YFYtiBQEzKuRVIYC-Vxgh39bQX1
X-Proofpoint-GUID: bMj70YFYtiBQEzKuRVIYC-Vxgh39bQX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02

This series introduces crypto kfuncs to make BPF programs able to
utilize kernel crypto subsystem. Crypto operations made pluggable to
avoid extensive growth of kernel when it's not needed. Only skcipher is
added within this series, but it can be easily extended to other types
of operations. No hardware offload supported as it needs sleepable
context which is not available for TX or XDP programs. At the same time
crypto context initialization kfunc can only run in sleepable context,
that's why it should be run separately and store the result in the map.

Selftests show the common way to implement crypto actions in BPF
programs. Benchmark is also added to have a baseline.

Vadim Fedorenko (4):
  bpf: make common crypto API for TC/XDP programs
  bpf: crypto: add skcipher to bpf crypto
  selftests: bpf: crypto skcipher algo selftests
  selftests: bpf: crypto: add benchmark for crypto functions

 MAINTAINERS                                   |   8 +
 crypto/Makefile                               |   3 +
 crypto/bpf_crypto_skcipher.c                  |  82 ++++
 include/linux/bpf.h                           |   1 +
 include/linux/bpf_crypto.h                    |  24 ++
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/crypto.c                           | 377 ++++++++++++++++++
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/verifier.c                         |   1 +
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../selftests/bpf/benchs/bench_bpf_crypto.c   | 190 +++++++++
 tools/testing/selftests/bpf/config            |   5 +
 .../selftests/bpf/prog_tests/crypto_sanity.c  | 200 ++++++++++
 .../selftests/bpf/progs/crypto_basic.c        |  70 ++++
 .../selftests/bpf/progs/crypto_bench.c        | 111 ++++++
 .../selftests/bpf/progs/crypto_common.h       |  67 ++++
 .../selftests/bpf/progs/crypto_sanity.c       | 161 ++++++++
 .../selftests/bpf/progs/crypto_share.h        |  10 +
 19 files changed, 1322 insertions(+), 1 deletion(-)
 create mode 100644 crypto/bpf_crypto_skcipher.c
 create mode 100644 include/linux/bpf_crypto.h
 create mode 100644 kernel/bpf/crypto.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_share.h

-- 
2.43.0



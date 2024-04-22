Return-Path: <bpf+bounces-27484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1138AD855
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 01:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CBD2852BC
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 23:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E81C3E468;
	Mon, 22 Apr 2024 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WkaMrshx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC03D3A5;
	Mon, 22 Apr 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826245; cv=none; b=kOgdJVrb2pfYFljaHIVhsdl0oP+bd9JlhSoLwsvmJwR4oGdIOgdbSWZ/NFmRmfcHJjq4ppJd2/SeYc3TJtKocfsJxuA2SZq88/OgUNIv+etrXF7Deaa8t0EDGDuLkC2zW0iyt0TPyTDAVTG9FIVWY+0PRGIOWrRTjWqNaN0y07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826245; c=relaxed/simple;
	bh=DUMOW1vrHtmHaun9Jna8/l48KWmYzjUqd/GG0hSDeac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G01izgE6IzdhN44hnXn7Arsz1u3D240zPeubZcZgtOK349GYbCyJEnfOYONpw/jBSYshPaAWBTWwgsHl8OIQPEGiU0AODZNMYHTxO24/prnfV4keRQdikqC0CNNOHNFLv24sfsLsVtnREd0AT/0v4mbFxWu2rM5KPCtx6Xzf3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WkaMrshx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MKgpqJ017890;
	Mon, 22 Apr 2024 15:50:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=sxCnj8uVkTCLWrUMogvvVrBmQMrM8FNh8SH6NvLuXlA=;
 b=WkaMrshxmD/k5HjbH+i8uXQ3Axv4wXPVb1N4a6Oy2vAcXv/PkWy601qPDKAtfwluqQgP
 z19zi1e2WNNT9upmposHzsE5mS47hU1qUORWALi2e2m/ee1juyMmt5Vly9MlShNErV0o
 HByYOAMPnOE5agz2UN5Q9Fvpaiew+KDevRMCXy3KLIvmLEWhmwbluTJpEooqmVc1gSaL
 Ep/qSik/X0807DUYk7HvYmqMoPWbHIFTeRa3E7lbA+NzUYEGPqU9vIVI6hgCd+tlNJ+R
 kPYDEfWXi6evR5hkeiSKke2STj0FZX31rGJHb/9IJlkLqWV0K6Zs68m6+AuVxm84YS70 IA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xm9rpb7p1-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 22 Apr 2024 15:50:35 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 22 Apr 2024 22:50:31 +0000
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
Subject: [PATCH bpf-next v10 0/4] BPF crypto API framework
Date: Mon, 22 Apr 2024 15:50:20 -0700
Message-ID: <20240422225024.2847039-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AXxxfu64EjACAm1mI7yfFZlxxIPAmQ5c
X-Proofpoint-ORIG-GUID: AXxxfu64EjACAm1mI7yfFZlxxIPAmQ5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02

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
 kernel/bpf/crypto.c                           | 382 ++++++++++++++++++
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/verifier.c                         |   1 +
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../selftests/bpf/benchs/bench_bpf_crypto.c   | 185 +++++++++
 tools/testing/selftests/bpf/config            |   5 +
 .../selftests/bpf/prog_tests/crypto_sanity.c  | 197 +++++++++
 .../selftests/bpf/progs/crypto_basic.c        |  68 ++++
 .../selftests/bpf/progs/crypto_bench.c        | 109 +++++
 .../selftests/bpf/progs/crypto_common.h       |  66 +++
 .../selftests/bpf/progs/crypto_sanity.c       | 169 ++++++++
 18 files changed, 1312 insertions(+), 1 deletion(-)
 create mode 100644 crypto/bpf_crypto_skcipher.c
 create mode 100644 include/linux/bpf_crypto.h
 create mode 100644 kernel/bpf/crypto.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c

-- 
2.43.0


Return-Path: <bpf+bounces-29469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119678C24D9
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429271C21596
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FB5027F;
	Fri, 10 May 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="deAGzIgP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633892C853
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344124; cv=none; b=G+kHvSebZt5yfYXZ04EUBhEYkP8qIL+7hrBwsUD/SNWJLHpKT/sStbERz6IKwBexZ7HgiCzfSsb6z7IRCw08Ua2ejnSCZ5Sm6JEdPy1SeIgYkjRA4+Xh0woX3SVRz7Mk43jQN151dkdTO/Vu1ckb4Os4CWc2dzKB+ZKk1xcFi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344124; c=relaxed/simple;
	bh=q0XLU2FcePMqUXinyckdAcMWznhIDtUxLsPY12Redzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FKFD8G+3OocQVykrbAYTQh31cw0ilQMmssEOc+8IwSL0Q3PzPKSHsa01h9j/FAn9gaSgH8HyBk0Sf7riKiJYbk7c1HL2nkeQuOeRAAJ30N3/96+9Pkvbyj9WScgEy/TC3G+8l1LsmSv1sT0jSyx6+fjLXm9vNdIbw3dHWrgvH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=deAGzIgP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0QAPO021039;
	Fri, 10 May 2024 05:28:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=s2048-2021-q4;
 bh=Zi0DX4T/QBqQXPbzx/UgCNgALJTgLe37v2xLUtr+7OY=;
 b=deAGzIgPYnIxQOpET6yQeZPrQ/AMjgEh6ote7JhgaP/GFt4/ZFhbmNJLUhaUpHP3iHX3
 //sqezwT1rUnpI3VRIpFc7U+JsmM5bofdU86GWn9wtDTzEAVNvTA01YgQrcO+lsryDYB
 jQ3RyzPblcrq2703gU+tMadKmsv5x4Mwz3cTUVKuac+Uqd4kW+QR2RZbEo6Kxu5FfIkH
 cLS/k0qh40c86F9yZhhrYXuWCv3oOEy6ttHSdajsb17Jno9Quv79QtG6bxGUytszdmDv
 T/DIuMeHsYZ+yG9Thi3/lSCs5AFCnx8kZQwMx1c81mBX2rAxAYjWVKcvAH+ZK/NnuhlK 9Q== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pxayxy-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 May 2024 05:28:36 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server id
 15.1.2507.35; Fri, 10 May 2024 12:28:32 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 0/4] bpf: make trusted args nullable
Date: Fri, 10 May 2024 05:28:19 -0700
Message-ID: <20240510122823.1530682-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X-SBQb3dtC1A2zdFNWZlxVJ9e2zmocJ7
X-Proofpoint-ORIG-GUID: X-SBQb3dtC1A2zdFNWZlxVJ9e2zmocJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02

Current verifier checks for the arg to be nullable after checking for
certain pointer types. It prevents programs to pass NULL to kfunc args
even if they are marked as nullable. This patchset adjusts verifier and
changes bpf crypto kfuncs to allow null for IV parameter which is
optional for some ciphers. Benchmark shows ~4% improvements when there
is no need to initialise 0-sized dynptr.

v2:
- adjust kdoc accordingly

Vadim Fedorenko (4):
  bpf: verifier: make kfuncs args nullalble
  bpf: crypto: make state and IV dynptr nullable
  selftests: bpf: crypto: use NULL instead of 0-sized dynptr
  selftests: bpf: crypto: adjust bench to use nullable IV

 kernel/bpf/crypto.c                           | 26 +++++++++----------
 kernel/bpf/verifier.c                         |  6 ++---
 .../selftests/bpf/progs/crypto_bench.c        | 10 +++----
 .../selftests/bpf/progs/crypto_sanity.c       | 16 +++---------
 4 files changed, 24 insertions(+), 34 deletions(-)

-- 
2.43.0



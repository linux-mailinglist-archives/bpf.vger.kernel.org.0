Return-Path: <bpf+bounces-28380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C148B8EB9
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34821C214E6
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167317C9B;
	Wed,  1 May 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mVFS2axn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14AFBEA;
	Wed,  1 May 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582928; cv=none; b=gLVzKAX//LGG3zz0tVCNLCEEyMUbbG4RJ2fEb5mV3WIz3mH1FAw4yeQWQPMIhz8I0LQ+HEKy3me4dKjqX2Obje/X7nHgDWHEvva1tTk+Uz8uJR6QwWEyTQ0bTFR5lFJBBulmpxxL5OjePI5qZgkJuoRYQKQ2MYKgwv2/4HeJK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582928; c=relaxed/simple;
	bh=ybzwn+ydfIFK+DqICo0Legpr8uBh0C4IME5KILc5CxY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cbtgj/vRd7bmhCiT3TwXxCn31ne98zMsVLkET7zhocZAwf2J75W+Am4hZCZfDQlpRfdC6vajB0Aae0B6DTJnmN/SRpcnPWngSIYR3nWNinzQokhwmj1MD8xQ+kmbZlpUNA6JnGfsOdD/O3wBqYCL+XKepJcRr+RQvxxkOHjplpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mVFS2axn; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441G3SVd030744;
	Wed, 1 May 2024 10:01:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=udk0F/KA0u3ymt82al7pZ6iIYBODYjSafKhMsfUmCeg=;
 b=mVFS2axnHcM/GWx4hue24joAQUaeQgUZJLERqTmckQqTChddNotTqiGk1+JPkGRN791s
 O1Vl8bFf7KFEo3MFdwkRLnH33JV+a9bjRfPQOEPOZkzQr9GFN7vMfeQErLQ+EoOIUUqK
 6C3xZzPE1RSqnd1nRdvp8DVtIkhQ1cuSj5BqQG8jPsVEH8ad3Bskbz3eSnZPYOq5ofuq
 Uh9Cu6pBMwyz0mn4GkQcq1hyhG4Jj9S+7p4ayZETYVs5MKgQ7hkhmVBhFpdbZX2AuLuG
 NFVkxx38/rL1VxxRbvbOckwwhJEJ1g0S0FnFas/whUUP0edKq/MeBmkFaqEGOAWkiF2Y vw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xuqv18xud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 01 May 2024 10:01:53 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.35; Wed, 1 May 2024 17:01:52 +0000
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
        <linux-crypto@vger.kernel.org>, <bpf@vger.kernel.org>,
        kernel test robot
	<lkp@intel.com>
Subject: [PATCH bpf-next] bpf: crypto: fix build when CONFIG_CRYPTO=m
Date: Wed, 1 May 2024 10:01:30 -0700
Message-ID: <20240501170130.1682309-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain
X-Proofpoint-GUID: Llnlnv5e43kv2K0G7cdRIdhWpImmv_eA
X-Proofpoint-ORIG-GUID: Llnlnv5e43kv2K0G7cdRIdhWpImmv_eA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02

Crypto subsytem can be build as a module. In this case we still have to
build BPF crypto framework otherwise the build will fail.

Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405011634.4JK40epY-lkp@intel.com/
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 kernel/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 85786fd97d2a..7eb9ad3a3ae6 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
 obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
-ifeq ($(CONFIG_CRYPTO),y)
+ifneq ($(CONFIG_CRYPTO),)
 obj-$(CONFIG_BPF_SYSCALL) += crypto.o
 endif
 obj-$(CONFIG_BPF_PRELOAD) += preload/
-- 
2.43.0



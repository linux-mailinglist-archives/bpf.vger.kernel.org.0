Return-Path: <bpf+bounces-30694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C658D0A95
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8297E28177A
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335251649A8;
	Mon, 27 May 2024 19:01:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E2DDA9;
	Mon, 27 May 2024 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836460; cv=none; b=eqvzIcwDiJz0xtlVOQa93kiyPIrsST8ukI0XGjW/+S/xzdAWRPImSsQojKidZ5ehvgYy7Z9p6c1gOe7lxZEQCZmxM4dO1+pRtxw2stywG0FID/YgCL92AsvTSYZT48fantUkEadqGJzWGPLvlhDXg7FiUEGFbIgImUcRojyT4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836460; c=relaxed/simple;
	bh=c0wTFKp9XQXRgUFgtFgR9AuRbrYxnV5EJTEpQx/c25k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXY+bOM+fcbmjSZ+nTpcjKxwxNsCdfUeujQKNbIqGGcnWYJ0AvO+UNd4McGNwmkI8EHwhUhdjwzPUha4Q/EXnPYUMU8wO7h1KudVILUvwd9fH6+KSL5hHfrMqLoC1hmgK5+BYIwBDe0DiAfnQ8ACndFY7mbriX5wjWoqfKmj/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RIQb8T007199;
	Mon, 27 May 2024 12:00:24 -0700
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dmeta.com;_h=3Dc?=
 =?UTF-8?Q?c:content-transfer-encoding:content-type:date:from:in-reply-to:?=
 =?UTF-8?Q?message-id:mime-version:references:subject:to;_s=3Ds2048-2021-q?=
 =?UTF-8?Q?4;_bh=3D7geuP4fh0kfWIQEG10bAFf8y5oNk1kPaQirayNWOM44=3D;_b=3DPP/?=
 =?UTF-8?Q?8OkqGURhdvgDRtEzPLuATNDLoKjQCiuN0jBlXEOkW2gdyt1fh2C6yjcssjnADwn?=
 =?UTF-8?Q?1H_IULvEAgv4H8H/gOzJjc1XGyEr9t+zt9k1YSbjIbEfOHLD7z8t6cFNJ2rARa2?=
 =?UTF-8?Q?ozVfw+kd_w2iuOFxmx0TPVQD9XgNtCjYhesqxx7fcGLmuZ4hhAdh2EWxNHKm1ty?=
 =?UTF-8?Q?LJRpMSfosGhiu1_6mTZkq+JZ6rCaMny0LGiNWLK0pqc/gzL+HibYTH5MDi4GrHp?=
 =?UTF-8?Q?cw0CDMNPmW8npEdIy6nL_zi4+Owe8ET9xd6qAp93vmxGq7Zoo5gu6IWkQf3ASYk?=
 =?UTF-8?Q?xdziDv6dJg5OdI4AZJ3VQwEOlA_uA=3D=3D_?=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ybdr3234w-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 27 May 2024 12:00:24 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 27 May 2024 19:00:22 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next v3 2/2] selftests: bpf: validate CHECKSUM_COMPLETE option
Date: Mon, 27 May 2024 11:59:28 -0700
Message-ID: <20240527185928.1871649-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527185928.1871649-1-vadfed@meta.com>
References: <20240527185928.1871649-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N8rjF6Oi7ZTwtRAAQkoqWuYf5bPMlzjO
X-Proofpoint-ORIG-GUID: N8rjF6Oi7ZTwtRAAQkoqWuYf5bPMlzjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01

Adjust skb program test to run with checksum validation.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../selftests/bpf/prog_tests/test_skb_pkt_end.c       |  1 +
 tools/testing/selftests/bpf/progs/skb_pkt_end.c       | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c b/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c
index ae93411fd582..09ca13bdf6ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c
@@ -11,6 +11,7 @@ static int sanity_run(struct bpf_program *prog)
 		.data_in = &pkt_v4,
 		.data_size_in = sizeof(pkt_v4),
 		.repeat = 1,
+		.flags = BPF_F_TEST_SKB_CHECKSUM_COMPLETE,
 	);
 
 	prog_fd = bpf_program__fd(prog);
diff --git a/tools/testing/selftests/bpf/progs/skb_pkt_end.c b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
index db4abd2682fc..3bb4451524a1 100644
--- a/tools/testing/selftests/bpf/progs/skb_pkt_end.c
+++ b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
@@ -33,6 +33,8 @@ int main_prog(struct __sk_buff *skb)
 	struct iphdr *ip = NULL;
 	struct tcphdr *tcp;
 	__u8 proto = 0;
+	int urg_ptr;
+	u32 offset;
 
 	if (!(ip = get_iphdr(skb)))
 		goto out;
@@ -48,7 +50,14 @@ int main_prog(struct __sk_buff *skb)
 	if (!tcp)
 		goto out;
 
-	return tcp->urg_ptr;
+	urg_ptr = tcp->urg_ptr;
+
+	/* Checksum validation part */
+	proto++;
+	offset = sizeof(struct ethhdr) + offsetof(struct iphdr, protocol);
+	bpf_skb_store_bytes(skb, offset, &proto, sizeof(proto), BPF_F_RECOMPUTE_CSUM);
+
+	return urg_ptr;
 out:
 	return -1;
 }
-- 
2.43.0



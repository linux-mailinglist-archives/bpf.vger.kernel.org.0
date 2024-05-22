Return-Path: <bpf+bounces-30303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526B8CC39D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A2D1C21BB1
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03AB22331;
	Wed, 22 May 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="O0QK0w3o"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE031CAA6;
	Wed, 22 May 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389862; cv=none; b=Vw/gw4yLnHVcXic6fLegZuv7/8r1UqAy9RBNRQaQqtamTg+ghmf8pLUvtv9hPjAxK7/e1mONtXrfka56wECGvU3uo+r7bfT4vWYakxYDx/WxEFK6l+aia1ydA6XK5EVtSqGFeDgwEga9pFaGTtGUZL21YR85rkTDp0cKi8VEOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389862; c=relaxed/simple;
	bh=c0wTFKp9XQXRgUFgtFgR9AuRbrYxnV5EJTEpQx/c25k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL/hOqom1RmdCPqt2mK0zt9ANSBps/CLUbBxzkpMYG3sLw8mnU3u+gIZOYbhogQDS1Lt6b802j/DFJPzQO/5twOrG9m7EjYLgfs4k/gidiX0M3ZXZItqe368lRokUnAs7w2ghbNJR7fh/my8Ahbpt+2RtbxARp5yqmCe7XxdBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=O0QK0w3o; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 44MAY755003497;
	Wed, 22 May 2024 07:57:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=7geuP4fh0kfWIQEG10bAFf8y5oNk1kPaQirayNWOM44=;
 b=O0QK0w3o+Ig3wp6GJ/1sgGcuip5ZgyPIwlnTZg5dm9cNtHxihavvwh2irhJCCcQkV22b
 zFvVZtwZ8xCwPZu4p+YKJrjEMfVOA77zw9sGChPzdUeowHfFZOcdvxYjCmM2RKXhXSHL
 XATVZicemE5umRbcbbE+deRwk0y01Gxhq6Ho/QD0BHDUb0WJFBodUmoVDaCD/IgF5zkW
 Aorw2huRwN8M6oKFMgx1Y/7GL+9LJKmAtBXvHUKzhl3ju8TAhPQj4FrFn4BIybOUCR8u
 DlYtQFw2Eqf6/Bb7AkZZfJl+Wx3pmVYK4mrlf/9S7/50+Pd1DTq678Ue2cWVYozUKFRP 0A== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3y91bsnsv4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 May 2024 07:57:22 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 22 May 2024 14:57:20 +0000
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
Subject: [PATCH bpf-next 2/2] selftests: bpf: validate CHECKSUM_COMPLETE option
Date: Wed, 22 May 2024 07:57:11 -0700
Message-ID: <20240522145712.3523593-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522145712.3523593-1-vadfed@meta.com>
References: <20240522145712.3523593-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZajzN6Xf9ajorOp7XU6yo_d6Y70BqQc2
X-Proofpoint-ORIG-GUID: ZajzN6Xf9ajorOp7XU6yo_d6Y70BqQc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01

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



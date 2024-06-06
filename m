Return-Path: <bpf+bounces-31503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3029A8FF0DD
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75216B30E3C
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D6198A2F;
	Thu,  6 Jun 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Q33ogIek"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CE190484;
	Thu,  6 Jun 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685960; cv=none; b=atehGobmUYwHoQNP9o4jtrSnglspT/Ors0siwzz1XHeGfI5RsXz9BpGVzKqp8WimQWmLV4VrYf2wsMRi+bOTK7gZlxEeqwmAoKTKJxq3nPts7XeWopYkIAucK48JCKN8HUv1pMsyjbWpxh5cNCcE+QIRxHSg4mhgx40PLMALbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685960; c=relaxed/simple;
	bh=c0wTFKp9XQXRgUFgtFgR9AuRbrYxnV5EJTEpQx/c25k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlbgk0QSleMY1pttS7DqGY1ktLe5jlV62O3NTrOxdsKWx1AI9W/dX+UNxGdiWfvIA4nlauq1QW3gDiNeMP6NfMykYid6NBxEAc59mQG6x4LZyXA5q1TMf1CJoriB6YpufqLzqD3LJa+et2/5PN9oWJZx+d9G35EoOy7bzwVy1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Q33ogIek; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4566pTZp005391;
	Thu, 6 Jun 2024 07:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=7geuP4fh0kfWIQEG10bAFf8y5oNk1kPaQirayNWOM44=;
 b=Q33ogIek5OeKnI6bagw3YNzsl5S41/DsV+Dv15KQf0lm1HN71iEhBC++Lt5hqdWipcHG
 nGqRNOapLxSorn5xiERMgO9oxxUt5YrxKh6T2eJGXM4mORQQVUTi+a3IBp93yGWfaWXi
 0PxecDoEI5Nv/GMhvN+VYLLBbKpU513qJM8HfxCdkFxQZ4QtUDEf6PSMIKtlFCC0wt/W
 6t11wheJX87N8C7hoJDJUvJfPBSGugFkFPdgHFSIa+5s9JOVxszXCNiSNxM0wA+qGv0e
 s49i4WYMdxccFzL2KOofgU31cL9fwFDdK9e+HRrHcfAhuqiDXF1ioQ1mcolOG23FmEZQ sQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yk875tj41-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 06 Jun 2024 07:59:02 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 6 Jun 2024 14:58:59 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next v4 2/2] selftests: bpf: validate CHECKSUM_COMPLETE option
Date: Thu, 6 Jun 2024 07:58:51 -0700
Message-ID: <20240606145851.229116-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606145851.229116-1-vadfed@meta.com>
References: <20240606145851.229116-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CD0x0H452-U2i3iqtN4Vyoo80et3mgfA
X-Proofpoint-GUID: CD0x0H452-U2i3iqtN4Vyoo80et3mgfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01

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



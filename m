Return-Path: <bpf+bounces-30479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA798CE4AA
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDD01C2096F
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 11:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02CF85C7D;
	Fri, 24 May 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gSyW0ChT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355442078;
	Fri, 24 May 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548846; cv=none; b=heyrKxMDIEHm27jnvV1kwnYF+TtUpMwvsqnO8F/WnuHcdyauQccn1y7x/VJ+zqkifkKIrqgLmWB2nJYg+et2L/9vo9xyAS1iLhcKQciVcsw1TUl8tLEnpZx0bkt9rP28tzPcm07ixUrhE9TZtb2Tso+qRLWcePC9EzYaWG6WBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548846; c=relaxed/simple;
	bh=c0wTFKp9XQXRgUFgtFgR9AuRbrYxnV5EJTEpQx/c25k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUAmyIKn5LdP1+RaE8dYtP/BUx9a9uAs0/eJlPhstoyZ110TdwVWWF8OA1OXn36Y3hTnwUwdIfiA7oWVKat1fqe1aQ7acucMoMiC7J+zWqfKWHk4N5LwsSOr9RnvdSTJ6fhoojtx6weH+dh56uV3rC57u1ZypWQcj0sVWu36kBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gSyW0ChT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NLuDih024404;
	Fri, 24 May 2024 04:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=7geuP4fh0kfWIQEG10bAFf8y5oNk1kPaQirayNWOM44=;
 b=gSyW0ChTNZZ35+nDi3kwoUmzSNIAm95ciUh3TbCZg7Ee8HhXgBVcB7kNtRpKMzmes8wH
 Do62wydCh2US3wT7Lr53EuQUpwOKe+MXBjapYmDZX3EL2nAUE9emdlWWLpWD7ItvoECm
 ClaxWCGwRBw7M9qJ+mou6SP74QBBzWG220j/ZS+3AJH6bT7MvONddGthwRA4PyYW1A43
 ScuUJ4TDuTuoldKjLRtCJ/XdFY0rNqFVD25v0ZQ91TbkdkXMXQYkTLu/brJAKqQ+W9s8
 g4E3ePXQ9JLJzwhm6/OyCSqy3K2v/DppgybAm30pqu++yHUiv2KSnAPTmKAdWq+ZFYlT LQ== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y9xf4sf0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 May 2024 04:07:20 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Fri, 24 May 2024 11:07:16 +0000
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
Subject: [PATCH bpf-next v2 2/2] selftests: bpf: validate CHECKSUM_COMPLETE option
Date: Fri, 24 May 2024 04:06:59 -0700
Message-ID: <20240524110659.3612077-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524110659.3612077-1-vadfed@meta.com>
References: <20240524110659.3612077-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BQWtFhvrcmBDTI_P6unpYnXPktkhWNWs
X-Proofpoint-GUID: BQWtFhvrcmBDTI_P6unpYnXPktkhWNWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-23_01,2024-05-17_01

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



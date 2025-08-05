Return-Path: <bpf+bounces-65057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2816BB1B401
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6FF174EB1
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28865274B5B;
	Tue,  5 Aug 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pW4GvNIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402692749E5;
	Tue,  5 Aug 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399049; cv=none; b=iBjpv4Acw8yVpNmc7ir/2KIEQl6eAvgOcJmIoi1XmFMUZNj4wu0S1kCQKl3NTj+tv1AC8UaDpQqzFgl/juOFIm6zw+t04IAznjljxwEGBkDDnyJfC8dUxmLrwphuY03fNca9V+Z19hsLaWw5pZHoXbyIc21JOObB1oAOtYKQjrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399049; c=relaxed/simple;
	bh=qowIQFnkyUS+qUvfWHjIy9RCYD1yFAM+odJM6VCYDhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuCsviECmmb6VkLBhPkKjBhfyFYwLNml9YJb+V040HmJ3zEc+mJaOzu9nbvIiuqnscqdns9Y8FLWiA8fuAXPzDmT6MAJTzMp+Aw7vBIhoeiQz/8g1mzvik+kKCUwuzVt2CsixLn/4q8YFKqUJWvegxisHhEUKP0OUGtHZ5HLeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pW4GvNIQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5751TCO6026512;
	Tue, 5 Aug 2025 13:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nU7M5SlBmkDNtuaV9
	CsYc1B9MsKzHyuyhrX31Jev03s=; b=pW4GvNIQ4GSuEXekE4Sj55eibSWDwflDq
	3z0pQhAjJN1NDw8ZGlPpuB/kcPSH0TEOaomQifNqFSRtUbn9RL+RRSmnIFkr5gNq
	M5lmPh6En39eB2IUxLa8ej1pGY7IBvMGhQBITtgkoOwTRenf+bWG1LcLn4y9Su+a
	PlyoiUMB6D0wfUqOTVeQcvpia5jc84vzt3x/wAO3Sat9BlAqQYIOWqXPZkJi0cKg
	hFG2cso8chE/NJjyZzFI/3WmyBWXGgSapU96Wk6lMnY6XzocHbD5T2F4MW/WT4DK
	0dD8Vwxa8tsAmfeBnc/pjq9w2rjNLE/XwmuMpEbYtCQcLO8FcJPAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4aa2k85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575D3ske006493;
	Tue, 5 Aug 2025 13:03:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4aa2k82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575A6bFv004495;
	Tue, 5 Aug 2025 13:03:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2j7fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575D3osS50069940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 13:03:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301902004D;
	Tue,  5 Aug 2025 13:03:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23A9520040;
	Tue,  5 Aug 2025 13:03:49 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.141.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 13:03:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 1/2] libbpf: Add the ability to suppress perf event enablement
Date: Tue,  5 Aug 2025 14:54:04 +0200
Message-ID: <20250805130346.1225535-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805130346.1225535-1-iii@linux.ibm.com>
References: <20250805130346.1225535-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MhSFNhiVsLSK11Rjn3lbrUYxrrJs5w7d
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=6892013b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=5Tfx8qovrACkoZmbRlMA:9
X-Proofpoint-ORIG-GUID: TW7xbIt1y1u0HOPmQdlcuS-tZzJlO244
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MCBTYWx0ZWRfX1W7T1XxXpGvU
 XDolJo/df3zFzod2G0pUB+iZCySjXFm+njIKXw/RaFBSukDBXHkFmJt/i3mjmBIU52/Yehn8cvd
 7YcNsTJhAgcf4DuYVH+faP9stl462+22xFizdQZNaqmgpd+hyr6aRnrwQ+cMoqS0JanRWg9EVnG
 9GVa7p6louUJd8n88Q6qWRr4Qsghql9g6q2pAy/j+SrGt4zyHlaR5InziGCvGypy5zhShD5/+ao
 lpIXGNVBcEfxGsoZVQCH/+GCZkz7UsuvjQlfasE4WW+EPrGdtLhJYtztXQQe3zf4564N0ai+qsF
 o22PSx1LUdCvLVS8i3f2eHxvnfSb/DyvsvB2DmtmSWG98y3SfjN5S30WDuh+emB6REAvlFGjzLI
 BfpNmuPdIomNfKhe7/xIXEVyXaPWOEK5mIn+syy0UUB15fIZdVrDVOOmfVC/kNgwGjF3I4/h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=902
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050090

Automatically enabling a perf event after attaching a BPF prog to it is
not always desirable.

Add a new no_ioctl_enable field to struct bpf_perf_event_opts. While
introducing ioctl_enable instead would be nicer in that it would avoid
a double negation in the implementation, it would make
DECLARE_LIBBPF_OPTS() less efficient.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 13 ++++++++-----
 tools/lib/bpf/libbpf.h |  4 +++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fb4d92c5c339..414c566c4650 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10965,11 +10965,14 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 		}
 		link->link.fd = pfd;
 	}
-	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
-		err = -errno;
-		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
-			prog->name, pfd, errstr(err));
-		goto err_out;
+
+	if (!OPTS_GET(opts, no_ioctl_enable, false)) {
+		if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
+			err = -errno;
+			pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
+				prog->name, pfd, errstr(err));
+			goto err_out;
+		}
 	}
 
 	return &link->link;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..2d3cc436cdbf 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -499,9 +499,11 @@ struct bpf_perf_event_opts {
 	__u64 bpf_cookie;
 	/* don't use BPF link when attach BPF program */
 	bool force_ioctl_attach;
+	/* don't automatically enable the event */
+	bool no_ioctl_enable;
 	size_t :0;
 };
-#define bpf_perf_event_opts__last_field force_ioctl_attach
+#define bpf_perf_event_opts__last_field no_ioctl_enable
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
-- 
2.50.1



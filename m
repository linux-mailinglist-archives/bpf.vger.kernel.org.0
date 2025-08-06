Return-Path: <bpf+bounces-65138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E9B1C9B7
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC19722531
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D3229B208;
	Wed,  6 Aug 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jAFUi1El"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAC29995A;
	Wed,  6 Aug 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497481; cv=none; b=EbTtYi2BvzGHta7T4W0bk8blzbssmYdW1hhYNevm3jsYk3XnzFQGkkGipXxKb8rU5oIVeL/bPL39sbS/ak+sm/JgTaY02kikZr9D/FCf1vMs6daQ8PpkGg0CeV96u0zJnLANWsoPbAO7emKV0SAYdPAyvJ51w7gWJvMbZGnwjWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497481; c=relaxed/simple;
	bh=wrHBC7DPTFTYvCgjA4ViSlh3PQ/QmjDqOzfOcf6qOmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCIT3gq6dccsa4jfCbKyqIzHVqIPBaAnI6tVFQNc59ONhXvNJ0nFwFbPoJZ4WV6vcCpDOrZ1u59QJ8UIGZPDJy924nXjkzb8owrgwWiPUUXE7AIm8ppomYaXzv5qFDaUWxJdgY6dXlEMScQ8vFi71VV4MZ7z241ydgl+Qkuv7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jAFUi1El; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765pxOJ028220;
	Wed, 6 Aug 2025 16:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LuzFUY5FO5f7lNCS/
	9pRkIWQnkAOf0ECBJXueynYE5U=; b=jAFUi1ElE9hpUtBq5fXr/TCtngeYUz5aw
	AaxyrtAkzWNnrb5DN50u149fE+vkmES4u/u9RgUCkh48SVE3bJLeQloYyb5LzU31
	M+kRSz70v5KQWe3R8xTILKATxSlWGhJJQnE5C2PIij0yEhK4oK7ykNOttpWEp2rR
	Jb4iyV+Q5fd/6jcmZBQ3FjMz7vCsoTZTdbI/Ev3UVHOtGV9jHyM8h3+TY4VlQvBd
	ObyHSj2i9FrYd3X6loLbUPhllH4F+dQMo5r89CuTAipIRbqCSljxP8XNeACaQVm2
	8CRkOg0jYWNn7/jX8yU/RW/7fvLeytq8A288GAjv17NXOQHGJ7QSg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60wbhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:26 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576GOP4I031381;
	Wed, 6 Aug 2025 16:24:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60wbh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576GEr4D031314;
	Wed, 6 Aug 2025 16:24:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwncedf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576GOKRS59638180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 16:24:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C50C2004B;
	Wed,  6 Aug 2025 16:24:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8217820040;
	Wed,  6 Aug 2025 16:24:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.82.230])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 16:24:19 +0000 (GMT)
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v5 1/2] libbpf: Add the ability to suppress perf event enablement
Date: Wed,  6 Aug 2025 18:22:41 +0200
Message-ID: <20250806162417.19666-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806162417.19666-1-iii@linux.ibm.com>
References: <20250806162417.19666-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jd9zn_4A3A-oI33CPLuPmNrS4ixqyd6G
X-Proofpoint-ORIG-GUID: fSQ4Fdo9tm2DyGfqzlFe4QhBrwGZFXL2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5OSBTYWx0ZWRfXyOSgPbUqlYnF
 Q/A0mllTXRI1R29877N4fYLMfqX4qb4++VG6BF78rF4d/QGtWh4/RWTVeNyaTK99tY2YzQzdnJe
 omRaG3T0y7f7kr0JLeBd4isafhtWMWpsU6RDbyZqqe9hAVAdgjeVtC1xg6oYrEF0WERsOyHXDh6
 V8CkeVDJ6FMn6b9mvgcpD5yzP59hRcPeObjJR8AgYZbLwEbLpNQZ598UIboKxeEWMsM1qx37oP4
 uOJWbnWjnp3k/sbQg+GxOHVhocjJONIM8hCCMIJO3W8OjA4zj9QCdu3Lrs7uL79KDkB8bnixtWW
 USjTtPVH90SbgEZFwFwXYOprSgxDpctNc4pJf06Q+LEEFcMc/+fmbw4Xyp6i1inN53C+DedcPi2
 HdhwBwEJ/foLxou93OFVSsKPJQ1S0j8ZY2SeB4hEHxwgRvAbaXr2kPCjPHfBN5oh7Lv46fSL
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=689381ba cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TeCzLofx3L-FRdGKzo8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=996 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060099

Automatically enabling a perf event after attaching a BPF prog to it is
not always desirable.

Add a new "dont_enable" field to struct bpf_perf_event_opts. While
introducing "enable" instead would be nicer in that it would avoid
a double negation in the implementation, it would make
DECLARE_LIBBPF_OPTS() less efficient.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 13 ++++++++-----
 tools/lib/bpf/libbpf.h |  4 +++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fb4d92c5c339..8f5a81b672e1 100644
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
+	if (!OPTS_GET(opts, dont_enable, false)) {
+		if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
+			err = -errno;
+			pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
+				prog->name, pfd, errstr(err));
+			goto err_out;
+		}
 	}
 
 	return &link->link;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..455a957cb702 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -499,9 +499,11 @@ struct bpf_perf_event_opts {
 	__u64 bpf_cookie;
 	/* don't use BPF link when attach BPF program */
 	bool force_ioctl_attach;
+	/* don't automatically enable the event */
+	bool dont_enable;
 	size_t :0;
 };
-#define bpf_perf_event_opts__last_field force_ioctl_attach
+#define bpf_perf_event_opts__last_field dont_enable
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
-- 
2.50.1



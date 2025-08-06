Return-Path: <bpf+bounces-65120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C07B1C522
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81E2561F47
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B7728C039;
	Wed,  6 Aug 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V3eFX0KI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087328BAAF;
	Wed,  6 Aug 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480571; cv=none; b=uHHolk94Ek6mrd7nsrv7cpHkA3OF1FFTWA8skyb/T/67uuNEloCjAaWFp8Sm503FTbxaJfW/8ea0kDkFIFh/ywlScMmXfmY+3TiQGPH/uVOuBgr8EkZnwCbIRpXpyutK8U0Tf4puKoYzSdCwvVKs2Eg0DxfzW67mJRWiD8y4ugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480571; c=relaxed/simple;
	bh=MIa7VhkI/yh4gVKc0wQvVbeoKvozHlCYgPTBtwGcE5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsYLlPbZNdiyrx7qUlvdJhf7OR60PMBIpuS810NMZ+tFPbyB+kwUfZh5T8d/lx55gx41QCIvm4HTEaxv6jhHviwNlceGvqLUxtx532ze39gCtY0yc5RomvXK8X79/wNxjfmY9zU5rlUnQtI9L0mYF/CT0X6KXXZDNwtxULvbTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V3eFX0KI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576690sA028213;
	Wed, 6 Aug 2025 11:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZupdQg1vICiEqWP2f
	GJRDGqMQGt9XrZTyX7kfwpFfL8=; b=V3eFX0KI/RLszMjKsYnV54QfTTASiWUp5
	9FMRB9Z5J54hLzhPhqAQn4IvNI88pEybIywmo0k65EW/ZxpRgcBoDsVwcJHox2CF
	5/mF1svNmnmoRyx/FBxZk0h+EsByMUZzjxnrjkJnG2cjdJtmmI1wCJjLb4Pm1xNT
	YZyq4FSoLcW++dzoLVzLfaiqNUFa2OcBOVBnxsgXLG34mrbzf2L25eyl+QwiiVCj
	KBfTMBXncerLuQMl3teOy8AgNQW3DxeldqNLJMKJbGXrutZDpHOvlK+aAD231BtD
	oLsPe/EMhkAfCUdyjl2Rzaiepk2ssgM7qOHoAeA/Tgb2srftqjwaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60uwpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576Bgack014013;
	Wed, 6 Aug 2025 11:42:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60uwpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5767mMGH025946;
	Wed, 6 Aug 2025 11:42:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn3d7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576BgVC061211018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 11:42:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2DF420043;
	Wed,  6 Aug 2025 11:42:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17CBC20040;
	Wed,  6 Aug 2025 11:42:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.29.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 11:42:31 +0000 (GMT)
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
Subject: [PATCH v4 1/2] libbpf: Add the ability to suppress perf event enablement
Date: Wed,  6 Aug 2025 13:40:34 +0200
Message-ID: <20250806114227.14617-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806114227.14617-1-iii@linux.ibm.com>
References: <20250806114227.14617-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RjeSZbbjwwvN4eaYsdbq3rCoyu36mHDg
X-Proofpoint-ORIG-GUID: 4Q29_vahi6Xz3ZMX2B2MrAa5Xq1-mKvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA3MSBTYWx0ZWRfX15si+6XF8fVZ
 9fRWgbfiFD+3QAmQgF1o1tcMONzhIVqMxgQOAFqudKLcccII3heufS8KIR4AyY3F8hlbUXjly/j
 Lb/PzBt1pOmBCpUU4TdzhtwZVW16tae2uedXOsqPX4EWez/9k7a870VXLR6RxuPVcRiMGAsuYpJ
 SH0N6eWnEXyVe50a88Py+qnY7KOaIL0o99xg+6mlwODWd6azI2TkO9Fv66ca7USLZEutnHQ66rg
 iPNF6NMq8qikUX8Gr1fanPC64Ww+nNjwetptQWZryGii1WwfOxgBMnZAzFFVKNcOjUZtFQ/0QCC
 fWM1ncztNJJ6AoVCaMQSLtUb2Glcik6dkBmmol5WmU2+s6/PzSgewitEm3hn3rBpMOdqADKo40N
 r2LZU+mvo1Zo4i7G1xl/eI0jzx4Uu/zzkHmcP3ZMQSzdHikGhDlqnLbQfThoTC7SNQ3wB2US
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=68933fac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TeCzLofx3L-FRdGKzo8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=996 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060071

Automatically enabling a perf event after attaching a BPF prog to it is
not always desirable.

Add a new no_ioctl_enable field to struct bpf_perf_event_opts. While
introducing ioctl_enable instead would be nicer in that it would avoid
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



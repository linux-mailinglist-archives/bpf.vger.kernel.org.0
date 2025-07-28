Return-Path: <bpf+bounces-64529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733BB13D8B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726C81892E3E
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6426FD8F;
	Mon, 28 Jul 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XA0dmG5x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1B26FA5A;
	Mon, 28 Jul 2025 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713850; cv=none; b=LiEzpdZPBIOJ7ef1TO/siAVPcSpAjD1MRidmejzCh1RKLwLrrzaBCJpPVDakUoF7mfWW5MMbQNbLE/9He4p3VpoPuSi53d/PtbJoa075pTo02DfDotKbL6WY0y3C26P1z8/NRLVJHbn6uBGPHcbCAQdK2KsSbyUkA764+Ou7TzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713850; c=relaxed/simple;
	bh=l3mo07yATwpl5hsmvqlg9UkPIbuhr0w+45TBtv70anI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaPTPygWs2B/s6rPSq5dsZMi2LafAX2CIV2igVCTs4kWjPLuQ2SPFt42rI/1LvmCpeRzh4/Wj1KM+aEaR6GUulm+bpvodKpcg5cholf9G5qhNmG4PMxql/WSuipzYkmG99rznipQh+iU4v1eoYVMUxM0MCcTF/dPnWfG6FguXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XA0dmG5x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SBF8uC010780;
	Mon, 28 Jul 2025 14:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BUhHzdcqriY+FtkuT5oQ5Mq3h1O6i5PoljT4b3Jz7
	Vo=; b=XA0dmG5xVcfTWhmhwWqR3gCGE7q6RNMr+ifsB4v5whfW1KCGmjDpDYW2Q
	6KgiL0HuPt1UxEHgeGY0IAMxnGj03Q6KDdUEK7GqxlIVzJBJz/v+3SEL0L8yohK1
	3R71yelB3g4+cjrPgG6dPUrK+EPstCPzePEwGjEU1EJXdZWnrDqktGU7Fudzew/K
	VLQCled+QkTWZw3sOqG65AIMHV6TN7uf/JlStecJTSGauoy0g8qcm+yFadusaixr
	G1Nf86NPW37VJoXHzar/G9PsWIvefUmqBGHfsHyMtpdQciBMx3+aDRifkkytR1dy
	tyrJ2QSqOPy5hpEaypTRgTbFCO1OA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcfsmfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 14:44:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56SEL7tw002643;
	Mon, 28 Jul 2025 14:44:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcfsmfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 14:44:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDPOFn017977;
	Mon, 28 Jul 2025 14:43:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859btec6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 14:43:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56SEhuXV59507146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 14:43:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08B632004B;
	Mon, 28 Jul 2025 14:43:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6B9620043;
	Mon, 28 Jul 2025 14:43:55 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 14:43:55 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        andriin@fb.com, irogers@google.com, iii@linux.ibm.com,
        bpf@vger.kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH v2] perf/s390: Regression: Move uid filtering to BPF filters
Date: Mon, 28 Jul 2025 16:43:40 +0200
Message-ID: <20250728144340.711196-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwNSBTYWx0ZWRfX7fCDPFUKl7iL
 Qh2AbbCcnpjsrZpniR2jQGWYhEzMvCeiaE07OI7ZKj1yBJH7SQ10mroSxwuFE8xnvH75W+wBtnK
 xlICpUx+vJWJQ3CQiZvkdmT7nx3l1Y0CBzvZ4BAWSEYv6Aef6ZAeZT5D8461mrcbPLLSDvZf1j/
 FxfDoYhe3/WsdS7miL4rOPXxNQdLYO2N3KfLJeDHu6AmmeNFHb2R5MGhRvSkeQ1oyKefkX56Z2o
 Z1+2E+O8ZA++si885NdD2trUV5/P+BxIZcbLiR3aFcG6zI3kwnEcNYtE/2w2iavX6p+E/HQLEJd
 L0pOlFJsnIn56SVTp6giwcILPcEO4T0DyK08NI88gIQ5Z9CmpGt6I72CgMbAboJ/2JUgI+f8+Dj
 6q3UqlqNZdMq6bx5XIN0bhWpVckiljFpoQ0wE/yAF9ASRRoC3j4tb9F4Qr6NaCOwMgcROJrJ
X-Proofpoint-ORIG-GUID: pC6c3oE-G9k2PvqSURPRi3Suqehan00g
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=68878cb1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=FOH2dFAWAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=48xRky6O4oe52YPEhOMA:9
X-Proofpoint-GUID: 7-y4vGAAcM9tvlDMK6GEyxhhmY3-pwzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280105

V1 --> V2: Added Jiri Olsa's suggestion and introduced
           member bpf_perf_event_opts::no_ioctl_enable.

On linux-next
commit b4c658d4d63d61 ("perf target: Remove uid from target")
introduces a regression on s390. In fact the regression exists
on all platforms when the event supports auxiliary data gathering.

Command
   # ./perf record -u 0 -aB --synth=no -- ./perf test -w thloop
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.011 MB perf.data ]
   # ./perf report --stats | grep SAMPLE
   #

does not generate samples in the perf.data file.
On x86 command
  # sudo perf record -e intel_pt// -u 0 ls
is broken too.

Looking at the sequence of calls in 'perf record' reveals this
behavior:
1. The event 'cycles' is created and enabled:
   record__open()
   +-> evlist__apply_filters()
       +-> perf_bpf_filter__prepare()
	   +-> bpf_program.attach_perf_event()
	       +-> bpf_program.attach_perf_event_opts()
	           +-> __GI___ioctl(..., PERF_EVENT_IOC_ENABLE, ...)
   The event 'cycles' is enabled and active now. However the event's
   ring-buffer to store the samples generated by hardware is not
   allocated yet. This happens now after enabling the event:

2. The event's fd is mmap() to create the ring buffer:
   record__open()
   +-> record__mmap()
       +-> record__mmap_evlist()
	   +-> evlist__mmap_ex()
	       +-> perf_evlist__mmap_ops()
	           +-> mmap_per_cpu()
	               +-> mmap_per_evsel()
	                   +-> mmap__mmap()
	                       +-> perf_mmap__mmap()
	                           +-> mmap()

   This allocates the ring-buffer for the event 'cycles'.  With mmap()
   the kernel creates the ring buffer:

   perf_mmap(): kernel function to create the event's ring
   |            buffer to save the sampled data.
   |
   +-> ring_buffer_attach(): Allocates memory for ring buffer.
       |        The PMU has auxiliary data setup function. The
       |        has_aux(event) condition is true and the PMU's
       |        stop() is called to stop sampling. It is not
       |        restarted:
       |        if (has_aux(event))
       |                perf_event_stop(event, 0);
       |
       +-> cpumsf_pmu_stop():

   Hardware sampling is stopped. No samples are generated and saved
   anymore.

3. After the event 'cycles' has been mapped, the event is enabled a
   second time in:
   __cmd_record()
   +-> evlist__enable()
       +-> __evlist__enable()
	   +-> evsel__enable_cpu()
	       +-> perf_evsel__enable_cpu()
	           +-> perf_evsel__run_ioctl()
	               +-> perf_evsel__ioctl()
	                   +-> __GI___ioctl(., PERF_EVENT_IOC_ENABLE, .)
   The second
      ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
   is just a NOP in this case. The first invocation in (1.) sets the
   event::state to PERF_EVENT_STATE_ACTIVE. The kernel functions
   perf_ioctl()
   +-> _perf_ioctl()
       +-> _perf_event_enable()
           +-> __perf_event_enable() returns immediately because
	              event::state is already set to
		      PERF_EVENT_STATE_ACTIVE.

This happens on s390, because the event 'cycles' offers the possibility
to save auxilary data. The PMU call backs setup_aux() and
free_aux() are defined. Without both call back functions,
cpumsf_pmu_stop() is not invoked and sampling continues.

To remedy this, remove the first invocation of
   ioctl(..., PERF_EVENT_IOC_ENABLE, ...).
in step (1.) Create the event in step (1.) and enable it in step (3.)
after the ring buffer has been mapped.
Make the change backward compatible and introduce a new structure
member bpf_perf_event_opts::no_ioctl_enable. It defaults to false and only
bpf_program__attach_perf_event() sets it to true. This way only
perf tool invocation do not enable the sampling event.

Output after:
 # ./perf record -aB --synth=no -u 0 -- ./perf test -w thloop 2
 [ perf record: Woken up 3 times to write data ]
 [ perf record: Captured and wrote 0.876 MB perf.data ]
 # ./perf  report --stats | grep SAMPLE
              SAMPLE events:      16200  (99.5%)
              SAMPLE events:      16200
 #

The software event succeeded before and after the patch:
 # ./perf record -e cpu-clock -aB --synth=no -u 0 -- \
					  ./perf test -w thloop 2
 [ perf record: Woken up 7 times to write data ]
 [ perf record: Captured and wrote 2.870 MB perf.data ]
 # ./perf  report --stats | grep SAMPLE
              SAMPLE events:      53506  (99.8%)
              SAMPLE events:      53506
 #

Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF program to perf event")
To: Andrii Nakryiko <andriin@fb.com>
To: Ian Rogers <irogers@google.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/lib/bpf/libbpf.c | 19 +++++++++++++------
 tools/lib/bpf/libbpf.h |  3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067cb5776bd..8e0fb4391b54 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10911,6 +10911,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 	struct bpf_link_perf *link;
 	int prog_fd, link_fd = -1, err;
 	bool force_ioctl_attach;
+	bool no_ioctl_enable;
 
 	if (!OPTS_VALID(opts, bpf_perf_event_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -10965,11 +10966,14 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 		}
 		link->link.fd = pfd;
 	}
-	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
-		err = -errno;
-		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
-			prog->name, pfd, errstr(err));
-		goto err_out;
+	no_ioctl_enable = OPTS_GET(opts, no_ioctl_enable, false);
+	if (!no_ioctl_enable) {
+		if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
+			err = -errno;
+			pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
+				prog->name, pfd, errstr(err));
+			goto err_out;
+		}
 	}
 
 	return &link->link;
@@ -10982,7 +10986,10 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 
 struct bpf_link *bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd)
 {
-	return bpf_program__attach_perf_event_opts(prog, pfd, NULL);
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+
+	pe_opts.no_ioctl_enable = true;
+	return bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 }
 
 /*
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..4be2b7664031 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -499,9 +499,10 @@ struct bpf_perf_event_opts {
 	__u64 bpf_cookie;
 	/* don't use BPF link when attach BPF program */
 	bool force_ioctl_attach;
+	bool no_ioctl_enable;
 	size_t :0;
 };
-#define bpf_perf_event_opts__last_field force_ioctl_attach
+#define bpf_perf_event_opts__last_field no_ioctl_enable
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
-- 
2.50.1



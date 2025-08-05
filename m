Return-Path: <bpf+bounces-65058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8ADB1B408
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BBE624298
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108F275103;
	Tue,  5 Aug 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oo9jZTOL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6E274FE8;
	Tue,  5 Aug 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399053; cv=none; b=bD4J9z76XSVwnxR+Zw1dbt9kQ2CxT2rEwdN6+E7+h3XxcQH3Wi0GkOknLfAOrgXx9d1BQRoSuCZ6oJEHNZ4wWoWTU09pXwai0diP1/2U3VP+Ta1OdxeavLaq8MGzFsVqoIkoXM+ZTWbh4A98qi8w4SD5gwd5HEFdv4VPlb0YnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399053; c=relaxed/simple;
	bh=4TCs8T6rPdDw+WjORxD4LfXmreO/1Hdv3tZS6BINC8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhNqc6j56BpOid3D3nWDhflCTVCICkQO2Rkm793UQtGHmyuNWaJq7uU71MWVdvv8aRpNhJi4T5hP3bPvy2sAL4gucv1adjl9P8468Ohon4SsShukP3+hrAlljWEh8KlQ3Ouk+S/Mfv1iYTL2aVmv4Wky+sTwV/UX6HPZCa+jDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oo9jZTOL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5758wBSJ025323;
	Tue, 5 Aug 2025 13:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oznJXzdTR8cxpW1z6
	yoy8Ld2n5Rz+kPjepuZzrbEiKQ=; b=Oo9jZTOLyeTMA+EnWWmish8KWe3hXBkKa
	o88YzSO6crvxs2IOTBsHQmn0DoZCf1CVYibJVIihYeUbaIOchFqKflGz73U4YkNI
	1u5ZzA7+u8/OLHv86clZ74r2BNuyikOo9JhfHepc1Ys4W45XMOQ7bvqt9xO/iHiR
	vnUA/C80hSTbCPgnUY8ftLPxIEk0pVDy4B33hfxjIO851dikKtn0c2KY11GlX5/n
	+d/2xs33D8ZFnRNYXmk29hnskxpBpMCDFJ18lPanjvsGXxK4k2OiTn9t+xMxc4/Y
	g62zFP6+6F4sO3tTMHUkNB2eA5x+s0OmQa4RBi1ZpMdYph6FxXwWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t6wss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575D3tTc010205;
	Tue, 5 Aug 2025 13:03:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t6wsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575A6bFw004495;
	Tue, 5 Aug 2025 13:03:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2j7fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575D3pSI19202414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 13:03:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A9520043;
	Tue,  5 Aug 2025 13:03:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CEE420040;
	Tue,  5 Aug 2025 13:03:50 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.141.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 13:03:50 +0000 (GMT)
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
Subject: [PATCH v3 2/2] perf bpf-filter: Enable events manually
Date: Tue,  5 Aug 2025 14:54:05 +0200
Message-ID: <20250805130346.1225535-3-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5NCBTYWx0ZWRfX324SwytEouD1
 Fs1ajQyWChONgqYW8d4gmuGL+21nOHk2q+E7pptl07nXTzMuigLC2NHjcG10022p6h+/l0mIrwE
 oeITPgBWlVoSy9HSzyyvXZRlqS/X1oQopg84Z31LRC/obz7OIJfhEdwZH+CQkMZ3S2bXC7odCl2
 dYw6ddY5kZjutBQ1PUMw/ISfhUnbTfcbAtHYl5K9tqcJXEnctjCrqhUZcATSkUjDC8/5j0eSW4X
 il39bibvaAROVjYkYgCrTojHIp+L7FS0Zn/PZaK8nkFBovGekb3m4e6zKHl0TFBhiTmwdBkHI4x
 nNpQVLLs+dYALZKc80C/BzRA40hq63IIZ3Fg5bLn0bZVWkTxAqjjIxeZsBTNcfOBUHvC/1C+GLT
 jEZWdCU/lo6pjrACYnXpReg2ZdeO3+caCVcdtCaYCbw/L5BTuKVGrpE6VUVW2yA0g6LXM7Lc
X-Proofpoint-GUID: KL32_dLLaN2XvdAwN5Y8IBib0CB_nCmp
X-Proofpoint-ORIG-GUID: oTmD_Lxw1PKjGtEeRBBjLOGmESNl0GYT
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=6892013c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=vr62MNj9oYPwvujLfVgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050094

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
   allocated yet.

2. The event's fd is mmap()ed to create the ring buffer:

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

   This allocates the ring buffer for the event 'cycles'. With mmap()
   the kernel creates the ring buffer:

   perf_mmap(): kernel function to create the event's ring
   |            buffer to save the sampled data.
   |
   +-> ring_buffer_attach(): Allocates memory for ring buffer.
       |        The PMU has auxiliary data setup function. The
       |        has_aux(event) condition is true and the PMU's
       |        stop() is called to stop sampling. It is not
       |        restarted:
       |
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
           +-> __perf_event_enable()

   return immediately because event::state is already set to
   PERF_EVENT_STATE_ACTIVE.

This happens on s390, because the event 'cycles' offers the possibility
to save auxilary data. The PMU callbacks setup_aux() and free_aux() are
defined. Without both callback functions, cpumsf_pmu_stop() is not
invoked and sampling continues.

To remedy this, remove the first invocation of

   ioctl(..., PERF_EVENT_IOC_ENABLE, ...).

in step (1.) Create the event in step (1.) and enable it in step (3.)
after the ring buffer has been mapped.

Output after:

 # ./perf record -aB --synth=no -u 0 -- ./perf test -w thloop 2
 [ perf record: Woken up 3 times to write data ]
 [ perf record: Captured and wrote 0.876 MB perf.data ]
 # ./perf  report --stats | grep SAMPLE
              SAMPLE events:      16200  (99.5%)
              SAMPLE events:      16200
 #

The software event succeeded both before and after the patch:

 # ./perf record -e cpu-clock -aB --synth=no -u 0 -- \
					  ./perf test -w thloop 2
 [ perf record: Woken up 7 times to write data ]
 [ perf record: Captured and wrote 2.870 MB perf.data ]
 # ./perf  report --stats | grep SAMPLE
              SAMPLE events:      53506  (99.8%)
              SAMPLE events:      53506
 #

Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF program to perf event")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/util/bpf-filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index d0e013eeb0f7..d480ccaf3662 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -451,6 +451,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
+			    .no_ioctl_enable = true);
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
@@ -522,7 +524,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	prog = skel->progs.perf_sample_filter;
 	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
 		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
-			link = bpf_program__attach_perf_event(prog, FD(evsel, x, y));
+			link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
+								   &pe_opts);
 			if (IS_ERR(link)) {
 				pr_err("Failed to attach perf sample-filter program\n");
 				ret = PTR_ERR(link);
-- 
2.50.1



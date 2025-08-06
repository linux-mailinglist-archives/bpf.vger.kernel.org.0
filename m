Return-Path: <bpf+bounces-65139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088A1B1C9BB
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BDB563744
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3691F29B8EF;
	Wed,  6 Aug 2025 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W4Uo6lZB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0928D84F;
	Wed,  6 Aug 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497489; cv=none; b=iCivE+0UJxjwLY1XfNMpHrlzy9x7viiSQMXfUiPtD/frcxbPzioaCB66xnjhNNdyWl85S8bSseuq4aywG4Tr18fLoKdesh4D3u481cd4f2/6KgLRSrBWSi1KsWzF9Ui9NY539Ntd3XWL+79OIUAu/fzlbp8Ia7QOjVnvtpcpwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497489; c=relaxed/simple;
	bh=AIGTeJYxg5f5rTF9J6Yr1pP2uX496go7egdBTNpDEjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlQUCzccIQM15DK/KWMZ/vTi+YW3El4D3/CD1kxGFLYsuWF6TE0wL4gEPgnTDmSSSlsHGOr9EcbI7rf0/DN3G+gGwNy173MaW5YuO84rSchp51tcr5LtldbEgYDavl1BaQ9bzzDx/8h3r772dTajHYlMj2msj4FTGh8M/S4PKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W4Uo6lZB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768bbrC021591;
	Wed, 6 Aug 2025 16:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kCizlyGIBjEVHLJ2i
	2UgIfg7sJkeCUGZArvHbQj6wec=; b=W4Uo6lZBRysAlMf67cGiaCMB2v9e3xdw/
	/lggSWercPRTreKvdz85Cg+3T4hz+9ORvZlY75BkV7YymeB8qXXSV+2AbyD0npck
	yHlKg9BBX9gjpljpLGgkLW2Bn7VJ0737XjRShs0bj/htgfhBcMxziXSSVe+2ik6o
	3gecr79CXtKqKMr+lgEhqp4RKX6frYamlY2tYRCnU9WLB0+ZZKrLrRCgq4rkzEN7
	uyniBXruEEU5LjqQSgRanXQmHVaNjnu8zhpW6sZsdW8laZIP+r8c7pul9FOAETR8
	jJ2vnTSP/0Qx3xjWW0UuudiJWVL43sKQ66EZSKe+2C79byp8RWwGA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61w88k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576GLvqE002261;
	Wed, 6 Aug 2025 16:24:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61w88g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576GBH5u001574;
	Wed, 6 Aug 2025 16:24:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwqve6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576GOLW557278928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 16:24:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60D4420043;
	Wed,  6 Aug 2025 16:24:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8513320040;
	Wed,  6 Aug 2025 16:24:20 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.82.230])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 16:24:20 +0000 (GMT)
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
Subject: [PATCH v5 2/2] perf bpf-filter: Enable events manually
Date: Wed,  6 Aug 2025 18:22:42 +0200
Message-ID: <20250806162417.19666-3-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEwNCBTYWx0ZWRfXxLGVXQeYomt9
 SwL3jtabUNJOe/ljIYfDsZXZmTCFgYmKhVjdoVeYtOWaLrtMk0NiTI3TFllcQ65QgLgVIS8Mnh7
 GpUV+WRF+t4AqARlEyV3kyABjjH105nwuqYrr38vfJi1NOn+RTz0oo/wcEsNY1r2tA5SUZQSHlC
 2PXdGDOo8uj9Iyfp1xIoMxyrL4o/VXWVo6AmRVvIMp0vMHKhnIe/CF9/hlgKT3xrZY8OaDMjwV5
 XEGXCoiNiwfiWO2tRyYl+JzmPHR3Ja4+sj0rLtogB7Et8spL10bTPcSjOAoorcGZ0QNCmIURsFd
 W0D7OxmpBgtI1xfGq+baK0ox3rUUWWdRkFte8MxNQYmXSGY5szFa4SGIqefDH36KRwsshec5JBm
 /bCPDAGSSOaUMfttOUFuUcqfN63xs4X4zq8cKpcUF4CSk0aZewdcDCVW8kCQzf/HLQNpOo/T
X-Proofpoint-GUID: hq2uf5T_6virVCorf-Ibb9o70TlbXIvD
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=689381ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=w8wHeiwaHs5MaTQqMIoA:9
X-Proofpoint-ORIG-GUID: 4tC9DH22Wd4YCO5T7ateE6KZ2lIVmDdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060104

On s390, and, in general, on all platforms where the respective event
supports auxiliary data gathering, the command:

   # ./perf record -u 0 -aB --synth=no -- ./perf test -w thloop
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.011 MB perf.data ]
   # ./perf report --stats | grep SAMPLE
   #

does not generate samples in the perf.data file. On x86 the command:

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

Fixes: b4c658d4d63d61 ("perf target: Remove uid from target")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/util/bpf-filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index d0e013eeb0f7..a0b11f35395f 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -451,6 +451,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
+			    .dont_enable = true);
 
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



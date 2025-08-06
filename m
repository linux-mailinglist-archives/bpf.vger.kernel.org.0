Return-Path: <bpf+bounces-65121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE18B1C52B
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 13:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98A37A2172
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05228C5AB;
	Wed,  6 Aug 2025 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aSAq6H+T"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478D28C030;
	Wed,  6 Aug 2025 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480573; cv=none; b=BUhA2LGUnD2Sqye9+MZD4ZFxh37c4HUcUqvcK+dZ8znuT8GKbw5BBIySY70oCwcToSc9GQyJ4BwUJU4rcDns7Dx8CIOyG2s2KM8Y49fTyQHC5pd5JOAm7vh8uWcKtJtS6ysFyROkXsTlhpJQ7Vr+Ao+5X1iHO8T02t1ZCuO73ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480573; c=relaxed/simple;
	bh=AIGTeJYxg5f5rTF9J6Yr1pP2uX496go7egdBTNpDEjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPMRuQ8OwUDZNmCfdjUF0fNTsUBi5+7EworwF32hSId9ETT3N/QT7j3cuJbEvdAODeWpmJg6ZVAybcETX1sXAShIkah5lhyUYXipQ6Od7WRS2jTw8ZgLx3aY6fyKSW3zXom5O9C1zzARAibmi/sEDlXnFAw+Iu2HFqTJLJOTeFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aSAq6H+T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57692NVB018065;
	Wed, 6 Aug 2025 11:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kCizlyGIBjEVHLJ2i
	2UgIfg7sJkeCUGZArvHbQj6wec=; b=aSAq6H+TVYDtBlIgytuIv7xyS1MJ/AIuJ
	2Tm5zmjTP99oIw8o0iTj8gZGnKJ7+IkVb7me6Sh760ULzZlINNQ1wtKfIyzPVrQL
	xIkRRte/ZF/2ozBzLm6jiRbeGrsZThNfraSRrkgW7DWR/dy75XfF68GndAXdBzuM
	I542mDKYlKk7RMsYGwqCy2DF44j6D9Srl0mbqbrLcedGZVQF/Vo9J8XVp6QpmEMm
	HrOwxO5wk471iDm6rbOr/2QT3JpFdICkQ/b9ElLWAkJFjjQvJIfoIuXag3sgiXEf
	eLn052FK9KAix8QiWeRxNHHjrhU2zTjIZ4DWYqtCpNIfKaT6yDhlw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq633ukb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576BbGqG026883;
	Wed, 6 Aug 2025 11:42:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq633uk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57681YJN022687;
	Wed, 6 Aug 2025 11:42:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqbcsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576BgWk250659818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 11:42:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 836B420043;
	Wed,  6 Aug 2025 11:42:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D680F20040;
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
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 2/2] perf bpf-filter: Enable events manually
Date: Wed,  6 Aug 2025 13:40:35 +0200
Message-ID: <20250806114227.14617-3-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2OCBTYWx0ZWRfX1EZA0dnykXKF
 kxr+0U5eNc1nrJcoVH3WWb/Xfh6cPPnE/0KgSsscLVMJhnWAnYsMwOLtXZluIWm1udgfY6qbCQU
 qbT5T8zR7F9U1YtxJ8wDsHxOo0rW6Vh/CoaK/OPytFZ2shO3IZ8ANDeUnLzQ75yaqgHhEgpZN/0
 9GkzA4jZMk9JsviizY1zLBLmkac+eWp4l9dZphr1r4eVmIYPylXfLDzDHEjbJu/0ANdKn183Eeq
 A6JQsb2jOr3IzEeumWpdzPgauqiyjuEunEj587M9Ny+UOYizxGt4FReHLsrEDgU4g6pQYa4DHs2
 YV7toJSA/Yn8LM8ExokS+DjZ6sovj9la+tk3XXobmsJWl0Xuahexhy2shMG7t6FO64OUVzrBxho
 7/NX+aL5QBUlLbGuknBj1z+g7pjmawIN0ZNUEVUQIssTNhX3cIaDkQHHQhCz2JNfMnR5+pDg
X-Proofpoint-GUID: FgBIBnTGOEFzoYAjWcROHYtQV1Q3R7vG
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=68933fae cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=w8wHeiwaHs5MaTQqMIoA:9
X-Proofpoint-ORIG-GUID: J2WZsTn9MnauYsWfMsbgbFbpSmkH3uA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060068

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



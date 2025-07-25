Return-Path: <bpf+bounces-64336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51F7B11AE8
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C99AC1D20
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3C2D373F;
	Fri, 25 Jul 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q0wHufda"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9412D322C;
	Fri, 25 Jul 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436107; cv=none; b=JxiqcHm8zxZb0y422JrAyqEkkdsc2fqTS0qlxrCaGQaO+Ko1SSo8XszSN9d7noNmh+VBbl4TPKonFrUeOWSX5YAP4GA7sdhLesdAtA7D8LAtKgA7l2Kk8sqzuE2GX4GXyy90pLB5Ol4yM9uXX+xB6NUwKYgISiaTz4cCqngJv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436107; c=relaxed/simple;
	bh=xJFDqfihKhSVrbq66CEMQR4L+rbjVhnQMnLN6LQ2ZU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqEmY3WhAVpXmYglJGWiLnTPvgCvBrWMFNQj3PnLSq6wfAlYbww1vqliUCgDsj4EgTdENbKrmqf1ceYQJEy0HJiAVB4MGlEuy2UHHZ3EdHCt9J3XPu1aV/7M13T3j21iNblHWZB4LWDriJo5iB23lyK4t7WXL+BSKM1WzW18dDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q0wHufda; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OM9FoN023954;
	Fri, 25 Jul 2025 09:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5dBPYbVmCl7k/jVbj1N9uhGvhjb0Y/pJg2vGVLEW/
	ec=; b=q0wHufdag8Lfl5ggh/71T7SgtvB7GQLl6Ci/UTYt0Thry/RsF7CamnPVU
	iDS0ghKD6Aut6waO6Ph+ioU2xsu+Xos0+tAfDI0CieTrQblZREgl/OkWnfj/0Ugn
	C3JIqPvb+f42t16v5QliWk/NuJ/2fkFANjEHBkzffqMMUvj/23VnzdhOxHi1SFKD
	NRgeL1ruhaz+glubcshsZhfJlgHZKCt/sRi+p1BfiRNMRj1yZhE8WoqYJwOqvas9
	R4KX7acB7x2tP6MCrmfMr+Y2l4RK3mJDlxUPmX0bp5fi1pSSZnpPPo1MSd81N1Hf
	CFs2OCydzcRBZ3cYs+Bkj/WCnxs4w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcht87v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:35:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56P5V3WM024985;
	Fri, 25 Jul 2025 09:35:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2rmv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:35:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56P9Yv0A31982326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 09:34:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C19362004D;
	Fri, 25 Jul 2025 09:34:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91CB22004B;
	Fri, 25 Jul 2025 09:34:57 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Jul 2025 09:34:57 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        bpf@vger.kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] libbpf: eBPF fails on events with auxiliary data
Date: Fri, 25 Jul 2025 11:34:05 +0200
Message-ID: <20250725093405.3629253-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NyBTYWx0ZWRfX+ZENGg3ptU20
 mJ+2lhkM4SOyVbsL0g5gvB/k3MUtchsRh2/xOa4AQUDCo7N0bz4heh98c0kwesGKcYftbNZMA4S
 UzuCzziA78Ro8WYtj8q9jjwSHHMg0AtTr/r5Pd1x/2iU6IxKvlI/wzBGoS3qIb8b+7XHkInRHba
 jhTsD7wV9LKAPVMe3j45dO4b5ze7jgDtDqOxNRtZaaqNVrCp6ynjJpE0BEZpLvYbGw2WXxiSi8/
 D5gdspoymyUZo4z+ah6liMoue1G9r7B5V4ZcZqvkw6o1LPWwP5cM3zhvEQ0XV3iPWDRt3RZdcda
 dS8cfKRSXMvV4SJiO52XM3nwaKtShCWKnoj0IISFzJKp8qGKJcgZtgOSmEBQ7jgJy2EAdQESQHl
 NZ+CrTVneiEUoz5zlHdVwcArgZ8nLm0MoS0/7LstywNS9E0rcmOQf7jC19mv1SE3uQHDCHEA
X-Proofpoint-GUID: Dm9ofB6kYIjI7E2hbV3DEdJb_nQDepIs
X-Proofpoint-ORIG-GUID: Dm9ofB6kYIjI7E2hbV3DEdJb_nQDepIs
X-Authority-Analysis: v=2.4 cv=G+ccE8k5 c=1 sm=1 tr=0 ts=68834fc6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=FOH2dFAWAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=_RghCZ_K9Bj0KFtpOxAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250077

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

Output after:
 # ./perf record -aB --synth=no -u 0 -- ./perf test -w thloop 2
 [ perf record: Woken up 3 times to write data ]
 [ perf record: Captured and wrote 0.876 MB perf.data ]
 # ./perf  report --stats | grep SAMPLE
              SAMPLE events:      16200  (99.5%)
              SAMPLE events:      16200
 #

The software event succeeded before and after the patch:
 # ./perf record -e cpu-clock -aB --synth=no -u 0 -- ./perf test -w thloop 2
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
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 162ebd16a59f..5973412a1031 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10960,12 +10960,6 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 		}
 		link->link.fd = pfd;
 	}
-	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
-		err = -errno;
-		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
-			prog->name, pfd, errstr(err));
-		goto err_out;
-	}
 
 	return &link->link;
 err_out:
-- 
2.50.0



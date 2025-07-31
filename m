Return-Path: <bpf+bounces-64774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ACEB16DAD
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D37A2126
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C929DB96;
	Thu, 31 Jul 2025 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P2YVgJXH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604621B9DB;
	Thu, 31 Jul 2025 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951129; cv=none; b=ncYo/yghCnDb7+OQxLG4TnVgAgS6nWMpMrnlOpRiV6l7PiWFPGMDJToY/fy2gOH58TVlEkl4D/BySatA+dzCcifTjrMMk/8Zfz6EH9j4MkwbjfmTHDWb+qmwjFkRxmOQUpApBYI2Y9G7+9RuQbGANCKuhHiSAIUqaFO3TlWiRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951129; c=relaxed/simple;
	bh=JIwukRnZ/f7adGcpZcqXVb42B8C8i7207UVcDKDRLeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gahdsZJuX37aSKknu1eE7lAHkkWrIu3IkPTXtxh3GlwhfU8VsMCMVaB6FF1AsvTG+C3zGEPlO4y7ji0IPL1L/U+HpKN/eQOdD1cREZGsVD56RDfFUZzyWuFhEUUk0a9yEYB3/UCoSAw1oP9VEtw59PV7HBYJa6DcRLzUrPF6HFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P2YVgJXH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UM59aw008885;
	Thu, 31 Jul 2025 08:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LqmjbX
	NGo11g+WI/lHJax7XLF7QOX1UqmbNrXUldX0o=; b=P2YVgJXHRjrynIzj3Xhkgs
	ihRsi1sb92N/yugklPG2t+D8RDbx3mQPceSi8+tXLTAeuHw2OvSWSjg5A0yneM2c
	2Gc8/i69JD0oYcA6vppZF1TTlFMktKkfUWh55iV865T0jtJEsMbDAXZj15oNcutO
	yVaAeY5PX9FqMfVSjMnU0ux7NilJdLOAtl3I6WrWWQRvuEQuYxK0vwLPXUH/jlED
	lyceb9yY3xCuDNV7DbETF9W7+rZ2XV8TwLngez4xu/4OV6lXcTAnRBzMQN8P7ouk
	oa22P6cxmDIK/oQ+YlYSDPD+x2Qs5qNTtHVN264yvwxebgyetu8cWlKjisJZTfUw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcg9ktd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 08:38:34 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56V8asMY011443;
	Thu, 31 Jul 2025 08:38:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcg9kt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 08:38:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56V80hrd015956;
	Thu, 31 Jul 2025 08:38:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aumuj3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 08:38:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56V8cSMA57082170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 08:38:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E52920043;
	Thu, 31 Jul 2025 08:38:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB42820040;
	Thu, 31 Jul 2025 08:38:27 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 08:38:27 +0000 (GMT)
Message-ID: <6018b52aec24000a751165f816dbd4522be8d06d.camel@linux.ibm.com>
Subject: Re: [PATCH v2] perf/s390: Regression: Move uid filtering to BPF
 filters
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, andriin@fb.com,
        irogers@google.com, bpf@vger.kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com, Jiri Olsa <jolsa@redhat.com>
Date: Thu, 31 Jul 2025 10:38:27 +0200
In-Reply-To: <20250728144340.711196-1-tmricht@linux.ibm.com>
References: <20250728144340.711196-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA1NiBTYWx0ZWRfX8AP48oMAzBpJ
 4GNoCTFdtdwFBHATzov0Y5S9gS7dGI8ESuLYtadfsz4J0MkwMmWlY9wtvHl4rqHYitkn6BV/M/y
 ra4kuzeGOQ0rLOllD2Lq8hrxFs5vejn8sWVB310iHSYfu6nRtFD73SHKkM737M3Bjv21WBQy3or
 Oqo6d4J4i89Ah+FkEW+VddBZXV6DbJvmFAwNB6z7mXG2KxeYO11I4JP0RExO4O3Rt0LF7hfnPGr
 M39YuZ9Ah5By03CAKLtg/u4yJL3YeK37c5B9axTqKp7wkCQeg36SVpApgZ/91qqmBLyzrwR/U0k
 UBvW64zzVXGixspIjuZBPz47doTWpRkzH4LWDuHoJ5zUnSNxPGu+LnDWKL3JlM5hMoRi5Gqlk86
 Iqg5p7q5zIuYI7RGX9vscvdR9yO12TwaCZXFu3vJ7X/f9l4RtPkmhjYZUKtlPp+CHJRtLo8+
X-Proofpoint-ORIG-GUID: IqOkFLOW6M2YLECdffCu45miUb8ookcw
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688b2b8a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=FOH2dFAWAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=nZeSn0eIVX808PMqqNYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: f_0XGvQ_8mKbvkGJeHYuKaO_MppiIgOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310056

On Mon, 2025-07-28 at 16:43 +0200, Thomas Richter wrote:
> V1 --> V2: Added Jiri Olsa's suggestion and introduced
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 member bpf_p=
erf_event_opts::no_ioctl_enable.
>=20
> On linux-next
> commit b4c658d4d63d61 ("perf target: Remove uid from target")
> introduces a regression on s390. In fact the regression exists
> on all platforms when the event supports auxiliary data gathering.
>=20
> Command
> =C2=A0=C2=A0 # ./perf record -u 0 -aB --synth=3Dno -- ./perf test -w thlo=
op
> =C2=A0=C2=A0 [ perf record: Woken up 1 times to write data ]
> =C2=A0=C2=A0 [ perf record: Captured and wrote 0.011 MB perf.data ]
> =C2=A0=C2=A0 # ./perf report --stats | grep SAMPLE
> =C2=A0=C2=A0 #
>=20
> does not generate samples in the perf.data file.
> On x86 command
> =C2=A0 # sudo perf record -e intel_pt// -u 0 ls
> is broken too.
>=20
> Looking at the sequence of calls in 'perf record' reveals this
> behavior:
> 1. The event 'cycles' is created and enabled:
> =C2=A0=C2=A0 record__open()
> =C2=A0=C2=A0 +-> evlist__apply_filters()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> perf_bpf_filter__prepare()
> 	=C2=A0=C2=A0 +-> bpf_program.attach_perf_event()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> bpf_program.attach_perf_event_o=
pts()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> __GI___=
ioctl(..., PERF_EVENT_IOC_ENABLE, ...)
> =C2=A0=C2=A0 The event 'cycles' is enabled and active now. However the ev=
ent's
> =C2=A0=C2=A0 ring-buffer to store the samples generated by hardware is no=
t
> =C2=A0=C2=A0 allocated yet. This happens now after enabling the event:
>=20
> 2. The event's fd is mmap() to create the ring buffer:
> =C2=A0=C2=A0 record__open()
> =C2=A0=C2=A0 +-> record__mmap()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> record__mmap_evlist()
> 	=C2=A0=C2=A0 +-> evlist__mmap_ex()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> perf_evlist__mmap_ops()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> mmap_pe=
r_cpu()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 +-> mmap_per_evsel()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> mmap__mmap()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> perf_mmap_=
_mmap()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 +-> mmap()
>=20
> =C2=A0=C2=A0 This allocates the ring-buffer for the event 'cycles'.=C2=A0=
 With
> mmap()
> =C2=A0=C2=A0 the kernel creates the ring buffer:
>=20
> =C2=A0=C2=A0 perf_mmap(): kernel function to create the event's ring
> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 buffer to save the sampled data.
> =C2=A0=C2=A0 |
> =C2=A0=C2=A0 +-> ring_buffer_attach(): Allocates memory for ring buffer.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 The PMU has auxiliary data setup function. The
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 has_aux(event) condition is true and the PMU's
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 stop() is called to stop sampling. It is not
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 restarted:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (has_aux(event))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perf_event_stop(e=
vent, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> cpumsf_pmu_stop():
>=20
> =C2=A0=C2=A0 Hardware sampling is stopped. No samples are generated and s=
aved
> =C2=A0=C2=A0 anymore.
>=20
> 3. After the event 'cycles' has been mapped, the event is enabled a
> =C2=A0=C2=A0 second time in:
> =C2=A0=C2=A0 __cmd_record()
> =C2=A0=C2=A0 +-> evlist__enable()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> __evlist__enable()
> 	=C2=A0=C2=A0 +-> evsel__enable_cpu()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> perf_evsel__enable_cpu()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> perf_ev=
sel__run_ioctl()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 +-> perf_evsel__ioctl()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> __GI___ioctl(.,
> PERF_EVENT_IOC_ENABLE, .)
> =C2=A0=C2=A0 The second
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
> =C2=A0=C2=A0 is just a NOP in this case. The first invocation in (1.) set=
s the
> =C2=A0=C2=A0 event::state to PERF_EVENT_STATE_ACTIVE. The kernel function=
s
> =C2=A0=C2=A0 perf_ioctl()
> =C2=A0=C2=A0 +-> _perf_ioctl()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> _perf_event_enable()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-> __perf_e=
vent_enable() returns immediately because
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 event::state is already set to
> 		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERF_EVENT_STATE_ACTIVE.
>=20
> This happens on s390, because the event 'cycles' offers the
> possibility
> to save auxilary data. The PMU call backs setup_aux() and
> free_aux() are defined. Without both call back functions,
> cpumsf_pmu_stop() is not invoked and sampling continues.
>=20
> To remedy this, remove the first invocation of
> =C2=A0=C2=A0 ioctl(..., PERF_EVENT_IOC_ENABLE, ...).
> in step (1.) Create the event in step (1.) and enable it in step (3.)
> after the ring buffer has been mapped.
> Make the change backward compatible and introduce a new structure
> member bpf_perf_event_opts::no_ioctl_enable. It defaults to false and
> only
> bpf_program__attach_perf_event() sets it to true. This way only
> perf tool invocation do not enable the sampling event.
>=20
> Output after:
> =C2=A0# ./perf record -aB --synth=3Dno -u 0 -- ./perf test -w thloop 2
> =C2=A0[ perf record: Woken up 3 times to write data ]
> =C2=A0[ perf record: Captured and wrote 0.876 MB perf.data ]
> =C2=A0# ./perf=C2=A0 report --stats | grep SAMPLE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 SAMPLE events:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16200=C2=A0 (99.5%)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 SAMPLE events:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16200
> =C2=A0#
>=20
> The software event succeeded before and after the patch:
> =C2=A0# ./perf record -e cpu-clock -aB --synth=3Dno -u 0 -- \
> 					=C2=A0 ./perf test -w thloop 2
> =C2=A0[ perf record: Woken up 7 times to write data ]
> =C2=A0[ perf record: Captured and wrote 2.870 MB perf.data ]
> =C2=A0# ./perf=C2=A0 report --stats | grep SAMPLE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 SAMPLE events:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 53506=C2=A0 (99.8%)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 SAMPLE events:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 53506
> =C2=A0#
>=20
> Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF
> program to perf event")
> To: Andrii Nakryiko <andriin@fb.com>
> To: Ian Rogers <irogers@google.com>
> To: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Jiri Olsa <jolsa@redhat.com>
> ---
> =C2=A0tools/lib/bpf/libbpf.c | 19 +++++++++++++------
> =C2=A0tools/lib/bpf/libbpf.h |=C2=A0 3 ++-
> =C2=A02 files changed, 15 insertions(+), 7 deletions(-)

What do you think about rather calling the new field ioctl_enable?
So that we don't get double negations in the API users and
implementation - they are sometimes unnecessarily confusing.

I also think enablement should be the default in
bpf_program__attach_perf_event(), and perf should now call
bpf_program__attach_perf_event_opts() instead.

Based on your request in v1, I can offer to take over the patch and
send a v3 with the changes I suggested above.


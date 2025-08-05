Return-Path: <bpf+bounces-65061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E525B1B4F3
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89753BDCFE
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3A4274FF0;
	Tue,  5 Aug 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oAkINR46"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10EC8CE;
	Tue,  5 Aug 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400833; cv=none; b=DU7NYE7/ahZygckJopbzOnxVRKGlcSF3F0TE2OtD7yG1YLRwd1Fm4Fht+2A2wYiM2DzsHVaOipujia+kNKWeko7Plao7/zmiqjQSSOPKLipagQLpLzlFc6M4ZIwqEATZjXvz1wZaTRqMxOI+PsckGnz8UNc7Jgh9m+uEwL98zKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400833; c=relaxed/simple;
	bh=DEFJA60kumZI0YtSbx1qJXlNprOBiPmPzEw3oho+OCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cj3s7jJ4k04HmTY/b+qObvhScI9YYKrt1VrNg+biI9oCgjOM+X+ZYQCdg2WYBAhujfbSkTlHTxZEpXuuuFb3Go3U0UbXku9CsdbEAj/wgn5FBUhwhQFwywvRRRBZ2+5g4u6cPr/qC3zBHGoUzsbVJxDs526+TvfkrAEO/q83qmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oAkINR46; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754twbW000914;
	Tue, 5 Aug 2025 13:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p7L4Ik
	JD9FFc3zVVbfHWu61nAW81Sk3m8x2IHO+EuyI=; b=oAkINR468G3F9cWdtsppYt
	5Urbk9PQPZZaCUEPzgFJbUYBbWjXdJfG+YCQ/9z4/D9FDSMK43OSnK+E9VHN8dM0
	r1lfTq8M0kkzRLJYRCuv2aSSg0EkeXaXKp4xufpyk4K0IWywZtB1GWJvTArerbRy
	BROAaC0fTVIFdXmBIIcAqG0EzhlhsQ7+E+jtuRUY/ZrMRCkPo00N/aP26BJ/2rVJ
	p4I5Y308qsxC+uL+CpxdjHktBCRV3o+JUVCjMR2L76m93Dsmum0mHnr9xcc8UNNR
	yQL6cZ7IIaRFBWXGjOGC4LXaOXn/utHqpH2MUmW0HPjzUCiW6w+t3rnhAQlLNEpQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq2755-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:33:38 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575DUVNo005378;
	Tue, 5 Aug 2025 13:33:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq2753-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:33:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575D54pR009562;
	Tue, 5 Aug 2025 13:33:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489x0p2jy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:33:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575DXXLR51511586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 13:33:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28F0820040;
	Tue,  5 Aug 2025 13:33:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1ECE20043;
	Tue,  5 Aug 2025 13:33:32 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 13:33:32 +0000 (GMT)
Message-ID: <ad5dda3a-0398-45d3-8f10-ef0097604fee@linux.ibm.com>
Date: Tue, 5 Aug 2025 15:33:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] perf/s390: Regression: Move uid filtering to BPF
 filters
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250805130346.1225535-1-iii@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250805130346.1225535-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VzYPxEk3MH6z5mhoijh3zxHoZBxHj3A1
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=68920832 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=x4kxwI2lhZTCVj833_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lFywGRcWcmvqzRw6TgqJnpF-1_omxDDx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5OCBTYWx0ZWRfX/JUmhlJGaScL
 JmIS897DyYzSl5vniS0kcdEOvvfuXm/rNxL9WWj3zfsbIuUuAvrYi2sxdUgMnmJNpQ+wIltZaOc
 LpFxeGSm1LUsARqQ9a38rvITQnAFj94LS0kmJ3Pz+frmA+SuZV0n/U+eTchgCjT5wtDAl2g3md1
 EvQ8cDyjqcizOQntII/s0MKQ5cxv0TkQbzf1zJo1YvujEcnjtCRRjlmRVjg2ljO4g8Q6gkkcXtP
 MjTH5vNmUzeG1D+1SIHUyRK2iSuBwEDCKeCAIfNAexWJru4eq0onAE9puB14GAYmvlMjOvfttq0
 JhbVNH29ra7i3dCQPZ07cyYtOBi7jyDmvXrt0eeYiEk7+8OvJy+iZ5S74G9isYWG/JAfU5iy26E
 7e5As72B0pLwSzWnDo7y+Go8Z3nu2qIr/CfyTSUTiRlP/dCJYdKSVBIYd2zLZoGd4iZa101z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050098

On 8/5/25 14:54, Ilya Leoshkevich wrote:
> v2: https://lore.kernel.org/bpf/20250728144340.711196-1-tmricht@linux.ibm.com/
> v2 -> v3: Use no_ioctl_enable in perf.
> 
> v1: https://lore.kernel.org/bpf/20250725093405.3629253-1-tmricht@linux.ibm.com/
> v1 -> v2: Introduce no_ioctl_enable (Jiri).
> 
> Hi,
> 
> This series fixes a regression caused by moving UID filtering to BPF.
> The regression affects all events that support auxiliary data, most
> notably, "cycles" events on s390, but also PT events on Intel. The
> symptom is missing events when UID filtering is enabled.
> 
> Patch 1 introduces a new option for the
> bpf_program__attach_perf_event_opts() function.
> Ppatch 2 makes use of it in perf, and also contains a lot of technical

Typo Patch

> details of why exactly the prolblem is occurring.

Typo problem

> 
> Thanks to Thomas Richter for the investigation and the initial version
> of this fix, and to Jiri Olsa for suggestions.
> 
> Best regards,
> Ilya
> 
> Ilya Leoshkevich (2):
>   libbpf: Add the ability to suppress perf event enablement
>   perf bpf-filter: Enable events manually
> 
>  tools/lib/bpf/libbpf.c       | 13 ++++++++-----
>  tools/lib/bpf/libbpf.h       |  4 +++-
>  tools/perf/util/bpf-filter.c |  5 ++++-
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 

Thanks for taking over!!!
For the whole series

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


Return-Path: <bpf+bounces-65064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB0B1B630
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EC61885D2F
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1FF2750E3;
	Tue,  5 Aug 2025 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tLEmOiHv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09518E02A;
	Tue,  5 Aug 2025 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403302; cv=none; b=i2GxmbLn5iKGcfMgq3IW3KNJ9Jmfar1sVXl4sHHySy6kbl+kpnFhZCfagN4GCZ21Y0pud/R7jPri0BQ9hiPGF4Eebm/AemqNEGJmP17k4ZadtRgfbWFeaG3vlEcIPELGSR7/lT+vnGU1Xv3eRu9SJpxg13Gob+dOfyphhNmaorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403302; c=relaxed/simple;
	bh=ZIV4PrIkQ/sqAVYnUdz9sNeokuVLIqJgwZtBTJ+6u2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPdTr9yZuA8KMEMgQUEYvFqyDhAApOg+PnyMMO4kX/9chJ8jkHb4rQKCt6dYsvLAwcmHknByQjJWGF2YBnEbGJ92EGaG7n6u7mGakb6GPkrfwrgzU0ifZvyaN5nECxDWRtvhQ1FXwNJBxMwBqkqAcoKskghWEQnfWW8F8lpIaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tLEmOiHv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5757GWND028299;
	Tue, 5 Aug 2025 14:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZIV4PrIkQ/sqAVYnUdz9sNeokuVLIq
	JgwZtBTJ+6u2E=; b=tLEmOiHvPsVskpYSCnHSt+TXQ5WXurGiqV0e6dSbwyyuNb
	amNR10vkZhXy3murs6ef4za/v61NYuM9OhfBrGoApMD1Tr4PcCzYAQIQPqHcCKzG
	AO3jvHPDW7n9/8uTEGRzi2efKgFtzJF0Q86YJAwj7kp4rAy/tesIVgSRkE1oIGGV
	+8nVGKM+7oZ3M7TUKppnxOo5ZsUDunwMLv7xIBRDCCD8Ze2kU2mfV0GwbTs5YasM
	vInAYBeSX98YHkgnXTtwa2eLifwemdm8I/sLM1OO3VQL2U6ZWr1ObApcZmtPJh39
	vn94HRGVTpvDq011QgKWpmGKZy+imA2cXH34ZogQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3pvuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:14:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575Dsw25019312;
	Tue, 5 Aug 2025 14:14:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3pvuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:14:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575CqKKB009807;
	Tue, 5 Aug 2025 14:14:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 489w0tjvyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:14:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575EEevv62849528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 14:14:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1C072004B;
	Tue,  5 Aug 2025 14:14:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BE3220043;
	Tue,  5 Aug 2025 14:14:40 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Aug 2025 14:14:40 +0000 (GMT)
Date: Tue, 5 Aug 2025 16:14:39 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] perf bpf-filter: Enable events manually
Message-ID: <4a7fc5ab-682d-4fac-a547-9e4b1263dba7-agordeev@linux.ibm.com>
References: <20250805130346.1225535-1-iii@linux.ibm.com>
 <20250805130346.1225535-3-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805130346.1225535-3-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z+jsHGRA c=1 sm=1 tr=0 ts=689211d6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Olw93o9rWRkIKX_a7AgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: uFtZZxHY_PzmP0bHgZtI1Fs1Wakfnw5Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwMSBTYWx0ZWRfXwVRPg8prV1VK
 +6h1Xctu0hmzhFeel1c1SAb9gclq87zJo7YZBxggPijx+4tvv3fJyZDXboYCr9vnbM6zOVPIycD
 ouyyrKP5MJV8SvdJWrOWU0kklr+vAbaRumbiQiYbPryTqjbYOSRkgTtBNCWe2J4+U+B08mi3XJC
 wv9H+6rpiXqL+PQ9iYAO9Ax4jZAjOuE3ITtVE0swdnrz8BdJNSgtD+mOwVrr949XyBTrh5EWb2a
 JTSuXzNkkOufn/SBTAgiV/TsmBo5U1Hse1xPiB6jSsTnhBFkBoNAt1OHD8b7zugO2xOsfdSHet+
 qMpfprp8AlAUQi50ThpLfejOwrr0UA9qzG1t4M8gORL64kjMcpj8AoZMSFsDgf7AHT7EdGwmaid
 46UJPz6c80DZWfdSQIa/Btb/4U0wygXEVPfH+QoDDzXBtHPvuYmjY844L1zJnydSi2Owu6/J
X-Proofpoint-GUID: XncbsDdZayruZ7cNXMiyG4QoYoFpIUXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=673 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050101

On Tue, Aug 05, 2025 at 02:54:05PM +0200, Ilya Leoshkevich wrote:

Hi Thomas,

The below comments date to the initial version, so the question is
rather to you:

> On linux-next

This line is extra.

> commit b4c658d4d63d61 ("perf target: Remove uid from target")
> introduces a regression on s390. In fact the regression exists
> on all platforms when the event supports auxiliary data gathering.

So which commit it actually fixes: the above, the below or the both?

> Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF program to perf event")

Thanks!


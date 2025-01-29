Return-Path: <bpf+bounces-50027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF6A219B4
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 10:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8794161954
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594951A254C;
	Wed, 29 Jan 2025 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KX/KC8fy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D347179BC;
	Wed, 29 Jan 2025 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141961; cv=none; b=fpKb6k5zmHZWBXnW1Z/T4K7aevcjmuB1k7mQPIIJbSg82uNa3sJXxsJBLj22srjr5dr+C9ZwLpEUVf+wEf1UbwN5ICmXHuLpmemgQVf6//zOxncsvEcABBa/HSijLZfFGy34YbF9bBwMnHI4MqkgjkJbK4LHapuvf0qVZrhJjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141961; c=relaxed/simple;
	bh=PQYsm+GzkK6kUD5oeoS+NLlKkT28tPbOSCeqmXwi47o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWXUfogQo62JFrD4tKueYKf1yE0Pa/6fAZkrgkYjMO+zVwtg6ba7nTkWYweSJ/2LvOFERc4yH/iPvPMdfKadlvWAynqP8OVYHzjZPdDMZ9QqV4cpSj4pSoZdLEuLIPmCM4JCLzu7WFno9NcDGbOCkSptMWJ9HRd7rC9BDwIiu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KX/KC8fy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T3w7kj006778;
	Wed, 29 Jan 2025 09:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zoAY/evaQQL3pulfAyTs86eIy9YRZV
	37zJpdWCnIZcA=; b=KX/KC8fyfssf7Z9QjzqD7Mj3hODRMOHeiF2+K/I0wGvIdv
	PVG8atpHlCkIpBhenneoNjIDLJCcHFSa3KNDO1b66KEYavqwupMfAoV9jC4EZGgz
	2WnTsFCW45n8EjuSKJMB2lbiap8lq5+i2h92ZbaA1Bw0TAjUqG1pVzkkQow3DXKK
	y+r49qU0z3pPl+lx2iLFNNj1+2RfnHSJkNDKhH1R/RSOoc8tOuHvyDFq/qvYspTz
	NMtd+wECnlYxOCPyg3NsQJazEsuMVlyhjNvQVgz5NDy+YCIjDRXafZ+DCB7t89Yh
	DtZ2U34kzvF6HsyN8v0EwXLhwyZNCv8xmr8QCS8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44f1gym8d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:12:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50T8s2Mr019876;
	Wed, 29 Jan 2025 09:12:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44f1gym8cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:12:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50T912Jb019368;
	Wed, 29 Jan 2025 09:12:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9myubj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:12:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50T9CSVx59834766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 09:12:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08E6920112;
	Wed, 29 Jan 2025 09:12:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7841020111;
	Wed, 29 Jan 2025 09:12:27 +0000 (GMT)
Received: from osiris (unknown [9.171.25.198])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jan 2025 09:12:27 +0000 (GMT)
Date: Wed, 29 Jan 2025 10:12:26 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>,
        Jiri Olsa <olsajiri@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/2] tracing: s390: Fix fprobes on s390
Message-ID: <20250129091226.10055-A-hca@linux.ibm.com>
References: <173807816551.1854334.146350914633413330.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173807816551.1854334.146350914633413330.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FI5wFzmVOCck0xrl8n9QVw5Gw7f16kl9
X-Proofpoint-ORIG-GUID: phj-a_VUXJwFsShuwVJ0ZCxA1UFUMqW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=425 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290072

On Wed, Jan 29, 2025 at 12:29:25AM +0900, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here are fprobe and kprobe-multi fix patches for s390 which maybe broken
> when we introduced fprobes on fgraph series.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       s390: fgraph: Fix to remove ftrace_test_recursion_trylock()
>       s390: tracing: Define ftrace_get_symaddr() for s390
> 
> 
>  arch/s390/include/asm/ftrace.h |    1 +
>  arch/s390/kernel/ftrace.c      |    5 -----
>  2 files changed, 1 insertion(+), 5 deletions(-)

For both patches:
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>


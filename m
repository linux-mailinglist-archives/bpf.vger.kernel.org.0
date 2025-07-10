Return-Path: <bpf+bounces-62891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF03AFFBA6
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7D9564214
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F2728B4E0;
	Thu, 10 Jul 2025 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OQpV2k4v"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE84A0C;
	Thu, 10 Jul 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134670; cv=none; b=Wl05Mzjn7hOtbGxaLkCDU846dPdA1IxQvAmDmEaEZXZYjd4C/76M1D2OEEJcV5c67GFYMdhL/wB/Bqrb6nesRpwhfSHiuINyI0W02A15xfFsKQLmBal9C+jXMlnzDTCyldtXzL8Cvme4lddk9WirrNRyWAKaJgut6TFhf6Ud5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134670; c=relaxed/simple;
	bh=UoxQ3Giq6Y9Cub6dytdzX/dzwXpAKILzBrPogGC/vHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3YfBZZAr5oNrZm8aYlpFHvh565own6e0swa9zZrSDH+r69qydM5xyCPjS4MlrX/LsdAOZdeN3DkuaaKKsR9YeaDXu06OY3oq5gCv7P0lbEFhP5ulathmVrLDPX42AyXP5rMtoQgRqJPpR7tJmvTU0uTHjMczKeQaXqz9BAj9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OQpV2k4v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A49lk3032551;
	Thu, 10 Jul 2025 08:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ig5SFx
	LMcxNNKRukoXkYPgH/XFtzRcRvvW25mYHk6Pg=; b=OQpV2k4vtsgcTSWxVAwURE
	hlL97WxO1+KhVF9fcvDlXO16eknIAlASz/6Fc3xHDeJsjLVCqMHM1KCJYBsq4YeC
	GznOIcWka40opHCLZjzbWsvuPTHY0ejtuXYUgBZR3WfuMP75FWZKwOSVtOm9mD6X
	UCWhnQdzHcInvKxY3Nbjs7hkqZsEdw7GNf9XXy1KqCgaVde8WWCOnWCWd8hzSt8p
	SFHoRZtCiTrmNeikiqZq41E9JoMouissTAvRErLh+/6obPbMDjEn/i1WuqWOB0AE
	rHGI3eLnlveLg+O/zJDJbrFA5SHFhUir3jqDn8AhxqrFRHNU8KfTCbahKAWnC5gw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrakc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 08:03:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A5UHLn021522;
	Thu, 10 Jul 2025 08:03:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectvtyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 08:03:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A83MbV54723034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 08:03:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C2412004B;
	Thu, 10 Jul 2025 08:03:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6C4820040;
	Thu, 10 Jul 2025 08:03:21 +0000 (GMT)
Received: from [9.152.222.235] (unknown [9.152.222.235])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 08:03:21 +0000 (GMT)
Message-ID: <517825b1-ee74-4ffa-a182-d3f9abf99298@linux.ibm.com>
Date: Thu, 10 Jul 2025 10:03:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
To: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20250708021115.894007410@kernel.org>
 <20250708021159.386608979@kernel.org>
 <d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
 <20250708161124.23d775f4@gandalf.local.home>
 <a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
 <39cf3aab-7073-443b-8876-9de65f4c315e@efficios.com>
 <7250b957-2139-4c03-9566-a6ed9713584e@efficios.com>
 <20250709100601.3989235d@batman.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250709100601.3989235d@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686f73cf cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Zg_fgM-7fzLk7_7bOdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Irss1GOAyZA8o4Qh90smeF0D45qjNOXw
X-Proofpoint-GUID: Irss1GOAyZA8o4Qh90smeF0D45qjNOXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA2MSBTYWx0ZWRfXyClXCw1oiqON jFqX9kYVGEXy8P/vFYSHSl06W/dlmActh2DYRJLZmn6lhpv4tNur6TrHsLFRIMZ1zCLbDk/pYua CV+Or6F4HaIS8VFSxqikAZR3TArjQv8tUg8SNlzk8NotUHAo3rWFK/EjAeH0Yb+sVWqPj/Jjvjm
 7EsnZizKSGvjB9X1ixSqjFrITR1nGa0BFYo37HvBBmzuLEUlZZxs7EIzd8HSnq65dIzX++CQATm RQvdVSt+YuMG45vGB/SGR+/wDbBsNoIP6bm5OD0/MK7baeed9EjmsLvgNVnhIUF83/G9Y8dzQp/ j1U6z0R8nPWnZ2TGhsnA5/4YjFBhlyqEhvKP+yPgvdkYzZERp3Z1+aYADZ3F9TWODhYTglQT5jA
 M1r4ahKw/8cCtdG55wDRsyFIg6ApO5RKZVlV0LzkHO61SYOR/IOAgTM9cuxj4gJTyFW4lQfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=953
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100061

On 09.07.2025 16:06, Steven Rostedt wrote:
> But for now, until we have a use case that we are implementing, I want
> to keep this simple, otherwise it will never get done. I don't want to
> add features for hypothetical scenarios.

> Jens, is there something that the architecture code needs now? If so,
> then lets fix it, otherwise lets do it when there is something. This
> isn't user API, it can change in the future.

I am fine with your suggestion.  My s390 sframe support does not require
any changes in this regard.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/



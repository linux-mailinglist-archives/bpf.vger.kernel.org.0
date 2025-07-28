Return-Path: <bpf+bounces-64534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53803B13E63
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A328D177198
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34B271A84;
	Mon, 28 Jul 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DOWAuPOM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DEB270EA8;
	Mon, 28 Jul 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716624; cv=none; b=KwWRbcrjfFmI3g9gjXvDGNtROQ1eD+CuNObc7LLr4e71kQrV6kFHm0JWubl1tSoDb7vSw2CxBh9VT1sU6cNdDF1rkW9IHbLXxJBcxNSuIOVWNj4xPaB4QUFo5A0FwlKEZNy/kZTln0MObmSfvq8XQrA4shwWVn+Uaz1ph9bKVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716624; c=relaxed/simple;
	bh=VkaP8RJYaVAqoCKO4BcCLTGsDJ5m9AlMPtxi1310e3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOt/MfES8376xfApQ1ZWudvT1PtmQCNS/HGpujKw6VdEBvxlaBkxnKhsqe7dxarg61F8HFHgn6XCW+V4z6C+RiO6/vAbM9XqWSCuwa8wG0bi0G5hruZDHDdMQmv+vTlccEu25D12hEl5EUIYqOe64qr2Fx/DswWgtFkpziFKk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DOWAuPOM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S9XLZN011939;
	Mon, 28 Jul 2025 15:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SilKQp
	ImhNSS4CiOyf4st+Mp/LFTtQ0Rl5UKzOJiEUs=; b=DOWAuPOMnk1cD9MTQoexOz
	mqR3TmoC2UCpa8w+bWxzjIE/01XKmvixc6quyYfX5hAlI69UPTdEQEyx3mg5DafI
	0RPM41tn+tOAcoiJ4vwHBwZbub2ZLr5l4pWpvtnRrxe9yXuoAhrKYyCVyDT286iz
	MFdLidp+CVrfEeXjA1XTjVyTVq5a1OBIsdcSdqBMmWY0l+Klf0uJI6pfw/k/T8/z
	4PXD09UoZYp9z4F1uYzcj1Q86WrK8aUXaoo4uz/sKaR9vdUSIdo58hiWRyiIeChc
	bNesfTGP8zoF14+fdicy3xpwJP4b7UPhMkt2L7ocQQlt8y4atlWhtCONOS4YmqJA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemhvky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 15:29:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDgLTW017949;
	Mon, 28 Jul 2025 15:29:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859btehd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 15:29:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56SFTXCH40370484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 15:29:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EB6420043;
	Mon, 28 Jul 2025 15:29:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 610F42004E;
	Mon, 28 Jul 2025 15:29:32 +0000 (GMT)
Received: from [9.111.164.146] (unknown [9.111.164.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 15:29:32 +0000 (GMT)
Message-ID: <a47d0d23-8518-4146-b97a-bf18753bc483@linux.ibm.com>
Date: Mon, 28 Jul 2025 17:29:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 02/10] unwind_user/deferred: Add
 unwind_user_faultable()
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
References: <20250725185512.673587297@kernel.org>
 <20250725185739.399622407@kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250725185739.399622407@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IZGNr6x1cRlhLPn8r90kOmdFEzSgFX2k
X-Proofpoint-GUID: IZGNr6x1cRlhLPn8r90kOmdFEzSgFX2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExMSBTYWx0ZWRfX8XORDaXjFQ8x
 gcUXv44p4X7hS4w99a41wvuMB1UHvFH4bY6ziI4UxFjCmmZpr7jFe93aSjSawTVWvEwRN4D74+7
 iHDFv46BJ7ldPMDX+lxDD68DQdwkwqpE4WJYkQOH5XMfaDWVkjQnh0PNR8gn7VlM+67Z/rhwEm0
 +Ed+EljwEg6YE6Ytn8HF/vMSos1PWLIWLT4miLorIllqWiGr3y+rXISMGQ319gwkZiRnkfS5yNF
 Z7GrVRr6CUxyuNyHNpo4Lb0UjzncRqXb6AgEahpb6RwLHlqbDVm6bCPZMXxHxfsftVu0upS+qnQ
 LRQ000WcW1Lr11UbJCTJ1JiVPP8j+oTeDFHCYzNkAuuUqer+M1MNIgvgG3X8yj7ocM9+sQU4lcW
 OT8M/DRnjC8x+stTOWStPYWEguB4zN7PAC0xajYvtXxbg8n0WTgHukZ30avloyDTW28xWw2C
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=68879760 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=meVymXHHAAAA:8 a=m_9FHJPNDCkT60rRepgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280111

On 25.07.2025 20:55, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add a new API to retrieve a user space callstack called
> unwind_user_faultable(). The difference between this user space stack
> tracer from the current user space stack tracer is that this must be
> called from faultable context as it may use routines to access user space
> data that needs to be faulted in.
> 
> It can be safely called from entering or exiting a system call as the code
> can still be faulted in there.
> 
> This code is based on work by Josh Poimboeuf's deferred unwinding code:
> 
> Link: https://lore.kernel.org/all/6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Jens Remus <jremus@linux.ibm.com>

> ---
>  include/linux/sched.h                 |  5 +++
>  include/linux/unwind_deferred.h       | 24 +++++++++++
>  include/linux/unwind_deferred_types.h |  9 ++++
>  kernel/fork.c                         |  4 ++
>  kernel/unwind/Makefile                |  2 +-
>  kernel/unwind/deferred.c              | 60 +++++++++++++++++++++++++++
>  6 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/unwind_deferred.h
>  create mode 100644 include/linux/unwind_deferred_types.h
>  create mode 100644 kernel/unwind/deferred.c

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



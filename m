Return-Path: <bpf+bounces-54750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D0A7171F
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 14:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2E83B05D3
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0951E5218;
	Wed, 26 Mar 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gzS4bThc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799261A2398;
	Wed, 26 Mar 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994659; cv=none; b=EgDXrG9bvnVEspzm23Yk2DVrj5//eslFkcT0KBSV/yaTkeY3QtGsJas7eglEFgel38Hx5dGvG3txHrEucueSVCssmDhaDelC+BtkH1fd1ro1bT7S9HGkat06/9pEWzgxE/2BUVCk/ve6IQppOVxYlBL3QLXdoXL5k2WG3jDcHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994659; c=relaxed/simple;
	bh=pcGemtqeLCa12GaytPmSy1mLPmv3gaNtLKFT7C5Ws/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrT8KugtXqdAcQ8B9XpPHuROfRqJylgFSYsQtOPoBtYdS//L2pzNwIex/TIegkWfpukKfdhE5wpgooxkYxgZBjHLy1hsqMcqfBrlDKWEVZy0NOuw1bds3tDihFjcNrBmVHhQJ+H6Dueds0wOK1/R4JzCuQxwXt4Fd0v7GQupOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gzS4bThc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q44JdY028382;
	Wed, 26 Mar 2025 13:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nT38b4
	dlu+sSPzXtH+E32XelC14qGuu494AMIpez530=; b=gzS4bThcnKQgx9CkoTgww1
	nk5pqCPntkPoS1SzyEKytoGah0MERTIS/wG/UqnUFCgwTCvrbWe3DMdjmrCfbUUS
	Y2rMrlT+nVVI0r0YbrEO5WGPQbHU62Hmrj8MW39c2G5uMqSLt4sQF4dJxgNTJaJV
	FwuL9lutQaT9kJQziO6OPWHSVlQO1GzQdfhZ36Cw+I4roX3Q3udfO5S6daFN5IB2
	LO7/EhYInmQ8hgINZhcy/CJdI7ok237kbJ+TJR1tNQEED6YjsIaAz3AVTx6E/3xM
	1Zr72zTVRqpB/svU85WD4Yh13MG5ONRqeqFQMeYd5nIHU2SRQ8CWD/c4172SgvAQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx2ysu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 13:10:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q9lo3e025462;
	Wed, 26 Mar 2025 13:10:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x08k7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 13:10:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QDAhgV28115710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:10:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D34D758054;
	Wed, 26 Mar 2025 13:10:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33F9E5805C;
	Wed, 26 Mar 2025 13:10:41 +0000 (GMT)
Received: from [9.61.254.184] (unknown [9.61.254.184])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 13:10:40 +0000 (GMT)
Message-ID: <e41a7fc8-824d-4369-b581-1fa8600ae3ec@linux.ibm.com>
Date: Wed, 26 Mar 2025 18:40:39 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/build: Use SYSTEM_BPFTOOL for system bpftool
Content-Language: en-GB
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, John Kacur <jkacur@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>, Quentin Monnet <qmo@qmon.net>
References: <20250326004018.248357-1-tglozar@redhat.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250326004018.248357-1-tglozar@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dfFNw-joNW9YygyCJUJUZE8a20B8jpwe
X-Proofpoint-ORIG-GUID: dfFNw-joNW9YygyCJUJUZE8a20B8jpwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260079


On 26/03/25 6:10 am, Tomas Glozar wrote:
> The feature test for system bpftool uses BPFTOOL as the variable to set
> its path, defaulting to just "bpftool" if not set by the user.
>
> This conflicts with selftests and a few other utilities, which expect
> BPFTOOL to be set to the in-tree bpftool path by default. For example,
> bpftool selftests fail to build:
>
> $ make -C tools/testing/selftests/bpf/
> make: Entering directory '/home/tglozar/dev/linux/tools/testing/selftests/bpf'
>
> make: *** No rule to make target 'bpftool', needed by '/home/tglozar/dev/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h'.  Stop.
> make: Leaving directory '/home/tglozar/dev/linux/tools/testing/selftests/bpf'
>
> Fix the problem by renaming the variable used for system bpftool from
> BPFTOOL to SYSTEM_BPFTOOL, so that the new usage does not conflict with
> the existing one of BPFTOOL.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-kernel/5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com/
> Suggested-by: Quentin Monnet <qmo@qmon.net>
> Fixes: 8a635c3856dd ("tools/build: Add bpftool-skeletons feature test")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>   tools/build/feature/Makefile   | 2 +-
>   tools/scripts/Makefile.include | 2 +-
>   tools/tracing/rtla/Makefile    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 4f9c1d950f5d..b8b5fb183dd4 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -419,7 +419,7 @@ $(OUTPUT)test-libpfm4.bin:
>   	$(BUILD) -lpfm
>   
>   $(OUTPUT)test-bpftool-skeletons.bin:
> -	$(BPFTOOL) version | grep '^features:.*skeletons' \
> +	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
>   		> $(@:.bin=.make.output) 2>&1
>   ###############################
>   
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index 6268534309aa..5158250988ce 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -92,7 +92,7 @@ LLVM_OBJCOPY	?= llvm-objcopy
>   LLVM_STRIP	?= llvm-strip
>   
>   # Some tools require bpftool
> -BPFTOOL		?= bpftool
> +SYSTEM_BPFTOOL	?= bpftool
>   
>   ifeq ($(CC_NO_CLANG), 1)
>   EXTRA_WARNINGS += -Wstrict-aliasing=3
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 4cc3017dccaa..746ccf2f5808 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -72,7 +72,7 @@ src/timerlat.bpf.o: src/timerlat.bpf.c
>   	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
>   
>   src/timerlat.skel.h: src/timerlat.bpf.o
> -	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
> +	$(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
>   else
>   src/timerlat.skel.h:
>   	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h

Tested this patch by applying on linux-next20250326 and this patch fixes 
the reported issue.

Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



Return-Path: <bpf+bounces-79246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB0D31A93
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9A6C301F7C1
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C108F23BD06;
	Fri, 16 Jan 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cdQ3LQ1c"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144C7E792;
	Fri, 16 Jan 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569439; cv=none; b=jtWUTfy4/Y4d7UHC4XD87XT4Iorr8IXdUfqeqNrO8gqP3weQ+e7keNYjSZ6KNZ234DfaXcVf9g5tMMK1hEQhXEcz1Tgn8wvj+aeL1TCmrUEYCRbOvXfRLHY6SRgGDolHt5EZ4ZuLCAU8cpIJdHIyZAN7jIaP1MxlP6dbvbfstfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569439; c=relaxed/simple;
	bh=k8JVjZNI6JxzecXd07VKXa7I5vhk8BH3l5ykFuKfjr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7yGNkT2wM1FcI2Y4n4SZjC+7AT4vyJt6XbSOkv0Zj+ZWnnyJNqQ0nJ3D8yS52QnK/KqOdSv9hDsm/pT+rLlwaeKBnwd1mf1rrQxJs7ph34lrwQRYBjZqIxOufH74cPyzuZUhvKg6y+G+mHI9XDj+aJugF4xRyXZ3nV9aLdbJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cdQ3LQ1c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FMsnT6012398;
	Fri, 16 Jan 2026 13:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wicHw+
	iiRR0aK5wFjgUVyEVVUvGW66gYPeD2bQ4H7Jg=; b=cdQ3LQ1cRV1jXUzI7Mbd0b
	58F/j6XYKA8tpvhLBmhMoMaj/MvxMbaO6hCO8aBnjj+Vs3sqQshBtm7ODGVSOuRG
	zg2HdWZfXNMSYMAGxbejRisLZb77rVlvsBwRO4uqdZyIe68cGazXwluk18e/3c5m
	SDj0WBkPbHehwyG0eWuT6+7xM+OKGcLKMj+TvM4a3mTqP3hJrzcFxdvIQiL6ub2b
	hvZt/dUjO7xC2G4M+ACGuAIIqwtHpL9k/KzschbKROBlPnCa1KeGxCqZF9C/WPOV
	SFo197KZwmzqxrwummgjiTPJNUlIDOE066GCqtPPyek2fPzkhnH+zH7wzYkQNUMQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9emtux3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 13:15:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60GDEbYl024166;
	Fri, 16 Jan 2026 13:15:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9emtuwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 13:15:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60GAlBwh014333;
	Fri, 16 Jan 2026 13:15:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fypf5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 13:15:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60GDFNxo25428610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 13:15:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654D75804B;
	Fri, 16 Jan 2026 13:15:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D012858065;
	Fri, 16 Jan 2026 13:15:10 +0000 (GMT)
Received: from [9.87.133.90] (unknown [9.87.133.90])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Jan 2026 13:15:10 +0000 (GMT)
Message-ID: <cf1ec6d5-21e1-43fc-a694-b9e5a6258df1@linux.ibm.com>
Date: Fri, 16 Jan 2026 18:45:08 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kcsan, compiler_types: avoid duplicate type issues in BPF
 Type Format
To: Alan Maguire <alan.maguire@oracle.com>, kees@kernel.org, nathan@kernel.org,
        peterz@infradead.org, elver@google.com
Cc: ojeda@kernel.org, akpm@linux-foundation.org, ubizjak@gmail.com,
        Jason@zx2c4.com, Marc.Herbert@linux.intel.com, hca@linux.ibm.com,
        hpa@zytor.com, namjain@linux.microsoft.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com,
        yonghong.song@linux.dev, ast@kernel.org, jolsa@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org,
        bpf@vger.kernel.org
References: <20260116091730.324322-1-alan.maguire@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260116091730.324322-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KvJAGGWN c=1 sm=1 tr=0 ts=696a39ed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=qybCgKJUSUg-LXLXGl4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA4NiBTYWx0ZWRfX7zLNzgpEPT/6
 S98fx3ua9NOY5E/EAtUzCPfH39szhgejwZOn4PQ4wX/e7nab0Pb/CFb1wGS3u4+q+4C9femlOZK
 I3sfF87LyK6K2GfuxnC5VyJU4oV7dUuBRfKKOGWT3b5qPuH8iQYVsKaHRSu9MollJ2ggyl9B4iz
 qlI+CWTpDVziPxiPSHNBMZlNybcAGd/F+4IIkaGaUroi5qBivZZFRyPSd4eSEVQayW2TB+2FUpL
 zSlUeWjcLBVbOSvKCYcr1IWBGVNPjM76XE20NpNTse3T2l92CgwESS3DOxCHzXyT88G/z7gsVQK
 nAOfHlp2VOaC1XQNVZDd/dX5QQJdSRHqRox5qNTQe8/BN7KrqIU01JL6/CbdYhYK98OpCkuUykf
 whN+arH2YvEHrQ2WZABPrq8ljY1UUfZ2VoHmv++TAzBReOO9comy7AVRsLYW0qHXmNpQEhXIb/l
 K6Q0sZuqLIgpxZCFuPg==
X-Proofpoint-GUID: 13ZeElVtQNMtrQ2C35TMLZsmFnE4M2mx
X-Proofpoint-ORIG-GUID: PbprL9UwgJWbOtA5FCxegWfI2b6HkEgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_04,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601160086



On 1/16/26 2:47 PM, Alan Maguire wrote:
> Enabling KCSAN is causing a large number of duplicate types
> in BTF for core kernel structs like task_struct [1].
> This is due to the definition in include/linux/compiler_types.h
> 
> `#ifdef __SANITIZE_THREAD__
> ...
> `#define __data_racy volatile
> ..
> `#else
> ...
> `#define __data_racy
> ...
> `#endif
> 
> Because some objects in the kernel are compiled without
> KCSAN flags (KCSAN_SANITIZE) we sometimes get the empty
> __data_racy annotation for objects; as a result we get multiple
> conflicting representations of the associated structs in DWARF,
> and these lead to multiple instances of core kernel types in
> BTF since they cannot be deduplicated due to the additional
> modifier in some instances.
> 
> Moving the __data_racy definition under CONFIG_KCSAN
> avoids this problem, since the volatile modifier will
> be present for both KCSAN and KCSAN_SANITIZE objects
> in a CONFIG_KCSAN=y kernel.
> 
> Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/linux/compiler_types.h | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index d3318a3c2577..86111a189a87 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -303,6 +303,22 @@ struct ftrace_likely_data {
>  # define __no_kasan_or_inline __always_inline
>  #endif
>  
> +#ifdef CONFIG_KCSAN
> +/*
> + * Type qualifier to mark variables where all data-racy accesses should be
> + * ignored by KCSAN. Note, the implementation simply marks these variables as
> + * volatile, since KCSAN will treat such accesses as "marked".
> + *
> + * Defined here because defining __data_racy as volatile for KCSAN objects only
> + * causes problems in BPF Type Format (BTF) generation since struct members
> + * of core kernel data structs will be volatile in some objects and not in
> + * others.  Instead define it globally for KCSAN kernels.
> + */
> +# define __data_racy volatile
> +#else
> +# define __data_racy
> +#endif
> +
>  #ifdef __SANITIZE_THREAD__
>  /*
>   * Clang still emits instrumentation for __tsan_func_{entry,exit}() and builtin
> @@ -314,16 +330,9 @@ struct ftrace_likely_data {
>   * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
>   */
>  # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
> -/*
> - * Type qualifier to mark variables where all data-racy accesses should be
> - * ignored by KCSAN. Note, the implementation simply marks these variables as
> - * volatile, since KCSAN will treat such accesses as "marked".
> - */
> -# define __data_racy volatile
>  # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
>  #else
>  # define __no_kcsan
> -# define __data_racy
>  #endif
>  
>  #ifdef __SANITIZE_MEMORY__

Thanks Alan for working on this! I tested this change on my system and it works well.
So with that,

Tested-by: Nilay Shroff <nilay@linux.ibm.com>


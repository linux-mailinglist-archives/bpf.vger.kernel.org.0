Return-Path: <bpf+bounces-75223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E26C77903
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 07:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 315D234DE39
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 06:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750EF316918;
	Fri, 21 Nov 2025 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N67R4OXS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263736D4EC;
	Fri, 21 Nov 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706449; cv=none; b=rAKrhLFi6KcSSCcowBN6WJsqwcI3DHs9Inu5lUXSFiFS3at0tz6QvjlwsFMI8nik3SAXoXqE3VIyinpiFqX/jOyKEk2BO2KRrjcuzc4ieieyk/EtuDBzHRJAF9uRoZ4DZ/WtoONYw8KG8DVcWMadXZVsc0UkU+B49n3xLe/OtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706449; c=relaxed/simple;
	bh=qJ2nSRtu6ZKlc04KJ/xIxWpoWS/gxvHeS7RWzacIzgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHBjehJkM7t+EGcMxtR7v60MQ21GZYtcvhmXhxEsTWvJkaAc18WXJGf8MslR705hR5gPj15hnCGoKdpPobQx8JapYODQjoTPSQ1jGtsvLZtcKu4Smt7e+K/PYkiCQAK+9CctEMeAmrdJ3KlhjL5/oqGj9ut96e1yjzxaxF0TlUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N67R4OXS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKN2m0t029044;
	Fri, 21 Nov 2025 06:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f8Leuo
	bENvTWFFGXUrBpGnI/R/n1wTecEAvCQC1wuxY=; b=N67R4OXSWXUax/jLTC0NHZ
	fq93zGbEjTlrbc6k5Cxjrbqf1R4hfoW8UemGwOO/LeU/OgH4ymPj62zax2fC2Vbz
	pILU5712l0n6eTNzsWdW+m/sV4nQrt+fy2ygCAT0T5EJ3pzcF4dEPcQaiGzO4YwL
	tLtsBcGMNO3oQKYqfkWIlTWEf09p/KQ9dm/IXKAp3HVmfEyAhLMkTzpZggA6GZ1s
	gthzvPE9xFc4bSzSMUoqt7lRI299k06lvroAjXnrKeDBnl4xhhRfsiY8R15dyorX
	INC62hXQrQPW/6JDPIaqhmJVmYa7AWDlSFVesc8NHkhUgx3f6pTvsxl4R8Y5FNdQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1tdkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 06:26:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AL6QcDQ007289;
	Fri, 21 Nov 2025 06:26:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1tdkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 06:26:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL3kBoW005231;
	Fri, 21 Nov 2025 06:26:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bkjqtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 06:26:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AL6QZkJ43516246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 06:26:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450E820043;
	Fri, 21 Nov 2025 06:26:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8515820040;
	Fri, 21 Nov 2025 06:26:34 +0000 (GMT)
Received: from [9.111.16.202] (unknown [9.111.16.202])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 06:26:34 +0000 (GMT)
Message-ID: <947ef366-435d-4b05-b0b1-685e569d0a1e@linux.ibm.com>
Date: Fri, 21 Nov 2025 07:26:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] perf record: Add --call-graph fp,defer option for
 deferred callchains
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251120234804.156340-1-namhyung@kernel.org>
 <20251120234804.156340-4-namhyung@kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20251120234804.156340-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=6920061f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MGucU4rsRRrPEl4HSeQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DdontG2BWgp9fdEXp43uc2-XCLm970VD
X-Proofpoint-ORIG-GUID: Uh4AtN1LKgtJqEkg07QDvq90ML58U1VZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX7Y9jnqhzl7c6
 oGcuPtwZ2GmgessOB5Lb+/hK9v+i/6lgKy0zqm0V5R67NJpFGfCGn3JMLE+60qJ1V9CE4mjpEAC
 w3jdVKAUhz0b2f5ad2YY/DV7X8mIb9/iSEDSfFFk+wvO/dA+qXkQJgCss55VrVQdftwk/FdF8XC
 IbJkALqvntxsgpHXcJT7hBsKxMFBYheHzC6cG+yGYiXILCye8eZzEkhxQL1RhtxQh5eJDC3gxBs
 //oPZp3T+OpCz4DqHpossygQjTna8Puv/RBssBWHh5vVmW7DgI1EIJy6Crc7KozoQ8Qe7g++pss
 ijiaHsk+GVT+f6tVuOzDnETPN8k1GaK8UjE7MNZib5G9c/dvQFKYmXNv9x9X/Fr1zLLtzt1PXEi
 xkh/I4YPRgHCtlrKb8VfYVn2kQSGAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On 11/21/25 00:48, Namhyung Kim wrote:
> Add a new callchain record mode option for deferred callchains.  For now
> it only works with FP (frame-pointer) mode.
> 
> And add the missing feature detection logic to clear the flag on old
> kernels.
> 
>   $ perf record --call-graph fp,defer -vv true

Does this also works for dwarf format?
    # perf record --call-graph dwarf,defer ....
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


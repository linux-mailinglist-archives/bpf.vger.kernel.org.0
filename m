Return-Path: <bpf+bounces-76531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A6CB8BF2
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 12:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6386E3007644
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8CF31ED84;
	Fri, 12 Dec 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QDpmSdb5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F52E175F;
	Fri, 12 Dec 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765540138; cv=none; b=FH0I+7dSW+1jFKFuqCie9cNJmZfj9CVgWB9GxFVVDCALCPTCuf300tmhF645GQ7CBN19Qi4A8zqIJiUBiYhBwLow0Ngep60+t6NE/ap42NF/Y2FpUQwmoGb4dls3yjLyeJ9MMlPEn7YC4zYrEJn1B8P6yq14qP3vOlqA3K2MW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765540138; c=relaxed/simple;
	bh=vGha9HbpjGp/cH/IYCTr0FxLc78CrG/8a3xzs1m47RQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iDbq2EkiXR1C/mGOOKH+JHsE0npA/0tfYqohfeUohyDIGyQEaLcystCWWSWJYpgVfd2iToADMomGln5yjqFIUj0yhaZj24SA1g1CRGbH8IVabb/d+h+pBJhteZqVQ2m29ZKrfLDc9j8/okSdsqQ9ITi/iVr5g4eGLmgNx3dvmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QDpmSdb5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBMZONg030454;
	Fri, 12 Dec 2025 11:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xAIGE2
	3l17QlOR4DaxKQgOgjTbdnHlFC0JBDi794Y38=; b=QDpmSdb5mbICMFENbDdWu/
	+EsXuLl63m3CSjDYjBWp7BvIeK8Fviw91oTt1AcRCPkJrZqzM/BDwvv3DUMbN6ff
	KBikAGiAzBqUCkQdJXmyv9vpN3gytFdQ9AXt6OCwwHG6+3UiyIX9qu+nk7vmmclV
	P+zgrWK8NRy0x2+NuD9WUVw+Xxcy7iX29YWk/TcZ0E3N4GxuDbTVW4gin+pb3iPb
	1zsKUTyb/WolZY/BahafTd1esgLVcfFrEemyIYmiOe3rQrzeSxwP0Uus98uJcmvU
	8Xz8zTOPrbtspLc8PKMTfQV5g7prhO8a2CJ1PQaquo51MTBapwiowDIhX6IlnQfw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53v7vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 11:48:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCBcsg6027807;
	Fri, 12 Dec 2025 11:48:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53v7vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 11:48:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC9qsPO030235;
	Fri, 12 Dec 2025 11:48:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxtsks29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 11:48:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BCBmd1F26804508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 11:48:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92CBE20049;
	Fri, 12 Dec 2025 11:48:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9170020040;
	Fri, 12 Dec 2025 11:48:38 +0000 (GMT)
Received: from [9.111.169.84] (unknown [9.111.169.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Dec 2025 11:48:38 +0000 (GMT)
Message-ID: <6e5ff603-95ec-4b2c-b0b6-dd29ed2a2627@linux.ibm.com>
Date: Fri, 12 Dec 2025 12:48:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] perf tools: Merge deferred user callchains
From: Jens Remus <jremus@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251120234804.156340-1-namhyung@kernel.org>
 <20251120234804.156340-6-namhyung@kernel.org>
 <86593213-8a48-412a-a601-7992cc1660c6@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <86593213-8a48-412a-a601-7992cc1660c6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX2rxOQeUkXgkE
 E+AU88dWpRAkuR56WNmlYsnRi5X+piv0CjNrqrzO/p7Owf8u+UHycqV3219zdliCVcUMg5/YLpJ
 dlAECvGTHRRF1mNZfIam4Y3uwJ3VO3spPw5E35vZF6JV/dUo7XTcyzxZbayUpNdgLQi4rNonVPf
 h9WQmTAr/xFHf4xeFWHY80/+AqaLXpPCo3+OHlj3desB9EWfjKaI3dWUnOOITN3b2PRzLtNBChY
 d6Z/zfvqOO79rk1SNEXUsDYHDZYSLE4JfN+KTfFMS6CzCD2S/IrdUeR81CQ6ikSTv7LIuXeTmjI
 D/ve3NF7vSvMzIUg1pouPC+T7IgsQAxOgte5XSHJucw8XmtsUdZ+JD2ymds7wyVpPXH3AXKnsRS
 Pj3CHlJ2q5avT9eKK5hUa5EUzq485w==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693c011a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QXmydM6cz4rZj4SRXTYuIodOMNAr7ZVB
X-Proofpoint-GUID: 2e1CCpvsXAts6ZlqsLobqjEQzcUFQQl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Hello Namhyung,

sorry for the fuss!

On 12/12/2025 12:16 PM, Jens Remus wrote:

> On 11/21/2025 12:48 AM, Namhyung Kim wrote:
>> Save samples with deferred callchains in a separate list and deliver
>> them after merging the user callchains.  If users don't want to merge
>> they can set tool->merge_deferred_callchains to false to prevent the
>> behavior.
> 
>> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> 
>> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
>> +				     struct perf_sample *sample_callchain)
>> +{
>> +	u64 nr_orig = sample_orig->callchain->nr - 1;
>> +	u64 nr_deferred = sample_callchain->callchain->nr;
>> +	struct ip_callchain *callchain;
>> +
>> +	if (sample_orig->callchain->nr < 2) {
>> +		sample_orig->deferred_callchain = false;
>> +		return -EINVAL;
>> +	}
>> +
>> +	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
>> +	if (callchain == NULL) {
>> +		sample_orig->deferred_callchain = false;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	callchain->nr = nr_orig + nr_deferred;
>> +	/* copy original including PERF_CONTEXT_USER_DEFERRED (but the cookie) */
>> +	memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
>> +	/* copy deferred user callchains */
>> +	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
>> +	       nr_deferred * sizeof(u64));
>> +
>> +	sample_orig->callchain = callchain;
> 
> Hope you don't mind my naive question, as I don't have a clue about perf:
> 
> Doesn't the sample_orig->callchain storage need to be free'd prior to
> assigning the newly allocated one?  Or is that just part of a large
> block that got allocated in one piece?  How is then the one allocated
> here ever free'd?

Never mind, I found that it is getting free'd in
evlist__deliver_deferred_callchain().

> 
>> +	return 0;
>> +}
> Thanks and regards,
> Jens

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



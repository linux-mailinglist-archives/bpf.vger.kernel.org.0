Return-Path: <bpf+bounces-76530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF3DCB8B0E
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 12:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DABFB30A954E
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 11:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB131AF07;
	Fri, 12 Dec 2025 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b+2tjAAs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1423EA8E;
	Fri, 12 Dec 2025 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538190; cv=none; b=oXC981TW1E6MtPbMa2U6mKsMGopTACqj+fGhI+Wi9EPOQT4oPmGDzvEeb7rQncYC8KCZpl4ZK8XlsSHUyi6MtIlpA7oBKZ/cr6PPv2XHZxOzuBCOyqM60nakoAfQt5X13Tc6bpa2fUEWqqi+iXOxn6LyueUsNREWZwpiJ503O4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538190; c=relaxed/simple;
	bh=zHCoMwnvK3tt8QxZnIpROBuG06HytpusBqlcZMgAZFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzvvSQHsOusHTG3zV45Ai8UJy3cLJSgOSeXM9pZrW9VL3CgxU/BCWXMK7ejC0930N/xVH+DeiREUhfAPPKGhL5ncnBFTyuXG/G+a7DoqFVLB2PNrSS1T1PODWsMdqy7yMGAwRISQWOuD/20bba6OHd2t2T77hwiLQ5rebegYaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b+2tjAAs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC5mmts006746;
	Fri, 12 Dec 2025 11:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uXH1d4
	CpHyiVheZQ1eD5lAhhBV2oVsDUjDyBrgEPXw4=; b=b+2tjAAsoKqK2Pr2YwKrSF
	z7DgrFfVj+e2LHJLdL/MzOLJEgvV2ss+R24K7MAn21Rwy071Lu0+JBhIRAJgilC7
	WZyNBrb3N+jgBdFilkJ2GNcMjFbb1YaQSOVxXQpywiTyxyo607IiBwfwa8iOSAmO
	3KhJi/aHkSilvjp+eQhr+zgcU9U+VMdtNazb2BT53vn4jp+wDc2p9iJlTVlxnNL6
	P2eeXadhqnpRAIeGuKrnOkj0TMQXn3XRHS55orFP3MRQlYJBsrXAUi+ognLPXp9J
	mVtW5LETrQciFw3AOEkW6Mby4RwHyIeSCwHjwsmfkeNrkvHUC7pqQlIHEQ8IEESw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww4abn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 11:16:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCBCgJL025341;
	Fri, 12 Dec 2025 11:16:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww4abj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 11:16:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC7RPkx002031;
	Fri, 12 Dec 2025 11:16:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jubkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 11:16:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BCBG9OZ53477654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 11:16:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD70220049;
	Fri, 12 Dec 2025 11:16:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECC3720040;
	Fri, 12 Dec 2025 11:16:08 +0000 (GMT)
Received: from [9.111.169.84] (unknown [9.111.169.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Dec 2025 11:16:08 +0000 (GMT)
Message-ID: <86593213-8a48-412a-a601-7992cc1660c6@linux.ibm.com>
Date: Fri, 12 Dec 2025 12:16:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] perf tools: Merge deferred user callchains
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251120234804.156340-6-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1dprSS6siyKGLquuTwKMEAqCYktwVKx1
X-Proofpoint-ORIG-GUID: j3Km0c-RSV57gNbhkm-U2mbVZmvviopo
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693bf97d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX+HjoiKyM9Wc5
 dCCnLQFIANOvFLp4jtUHw9uVRFRypHrBxn3YzTHqbWLpwMf4MYk62/iAbsW2ZKqJmiN1umcyQBw
 MSkD407yp7Muw0ZWc0kP99XV5tyqbWt7kf8tJZr+GYTV5BC+mQk6ico+kA34MP0Ecr7om+5T4y+
 ZeerYmB8yNcQQ7nZ3sYddihjOI1GX7HbCMqXrPX/j1lgn8XYdRR75HVmkHr69WRP43eldXDjGIe
 cGcdV/mtrn7R5ClghJlTJcrclew4cC5WNs1RukvA3iJDo0H5YS/jpsj2qLj63ubeZvAhUzYXp73
 ShdT+EiFRv0OH+ZNeCC3i+w0Eeu2+44IdpGTg26SCf4Zz4pGbeoDAW4PwZpPpQGOXovim95fesu
 svvIxhsEt+wAIg86dNlMZSnNB6gavQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

Hello Namhyung!

On 11/21/2025 12:48 AM, Namhyung Kim wrote:
> Save samples with deferred callchains in a separate list and deliver
> them after merging the user callchains.  If users don't want to merge
> they can set tool->merge_deferred_callchains to false to prevent the
> behavior.

> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c

> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
> +				     struct perf_sample *sample_callchain)
> +{
> +	u64 nr_orig = sample_orig->callchain->nr - 1;
> +	u64 nr_deferred = sample_callchain->callchain->nr;
> +	struct ip_callchain *callchain;
> +
> +	if (sample_orig->callchain->nr < 2) {
> +		sample_orig->deferred_callchain = false;
> +		return -EINVAL;
> +	}
> +
> +	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
> +	if (callchain == NULL) {
> +		sample_orig->deferred_callchain = false;
> +		return -ENOMEM;
> +	}
> +
> +	callchain->nr = nr_orig + nr_deferred;
> +	/* copy original including PERF_CONTEXT_USER_DEFERRED (but the cookie) */
> +	memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
> +	/* copy deferred user callchains */
> +	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
> +	       nr_deferred * sizeof(u64));
> +
> +	sample_orig->callchain = callchain;

Hope you don't mind my naive question, as I don't have a clue about perf:

Doesn't the sample_orig->callchain storage need to be free'd prior to
assigning the newly allocated one?  Or is that just part of a large
block that got allocated in one piece?  How is then the one allocated
here ever free'd?

> +	return 0;
> +}
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/



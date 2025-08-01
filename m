Return-Path: <bpf+bounces-64902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794EB18537
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8665F1C8123F
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57127A917;
	Fri,  1 Aug 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ms6bNuvP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB671422DD;
	Fri,  1 Aug 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063228; cv=none; b=ui7f4/t/07chnIvPCRO21ctbmOWgaiKABQqQDWFVSc23orrtaMbhS/moarRK7XEkn62oDjWlkV7sb7PNA2OZuzpQXBUISlIi0sWLeV1OISLUfEg4ebV/9bQIwngOh8U1AyRGrYDxcGo5GCID3ISWp+58oZBgtyrJ8kk3zqw7lYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063228; c=relaxed/simple;
	bh=IZLE0uQ5DCz6jPq/q6fqEhZzNu7X7r+PRJ75Kyqp8Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEiz2GBp96VZzF0pzSDbqk8XEsLZxn08ZDFPd4+RI5f3S7ZUlUa/6sLjU9w3s6lCVpKOdfye94EIh6YJXPcJUWRKEV9xnSW8VienUeA/REzU+aArT1ZHOXtdAhQfuQlSHfFkSUGkJs9WUcHx/ZHB2nZpRNe1cGmNR1mok/jZY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ms6bNuvP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571CFYNJ022189;
	Fri, 1 Aug 2025 15:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h59C4O
	mJ3GTo2VYKRthh2qI8+QbWDWMyT568rgGhJS0=; b=ms6bNuvPEDr69E+TiXg18K
	dXWxi8h+L42Ie9HkUchk9lKMm+K8caaqd1VoNryg0bIYKKISHrRnl9VCSmStUZCa
	X8bQHkwmai4VSrziPTyL5kkdSERb85j1ebxoZDnfjy7nJoDwPGeLvjhxdpcdUQTM
	8EINndKpnuL3f/I/GHZ7lV8HaSZPUE+vVs4BQA7hxxvsVwkGoKxYPFdsbFM00nyQ
	hByjCVKXdh6BYwhLaKGDlUBuCV7efelAZOx7kChwW9kExyxkpv97jjlg7DiKgoWL
	uESqkmLcYIZ1sr1QFBmh63/Ubgn8ch6pP6v3/GGpW6xzNrg6/GtiqpI+lCX5ElWw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qen9k6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 15:46:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 571EVTXo016005;
	Fri, 1 Aug 2025 15:46:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aun1vmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 15:46:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571FkaTo54657366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 15:46:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49CF72004B;
	Fri,  1 Aug 2025 15:46:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09A9320043;
	Fri,  1 Aug 2025 15:46:34 +0000 (GMT)
Received: from [9.111.205.109] (unknown [9.111.205.109])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 15:46:33 +0000 (GMT)
Message-ID: <8b9a66b5-8b9f-410a-a072-7b9ba72ef7c3@linux.ibm.com>
Date: Fri, 1 Aug 2025 17:46:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 11/16] s390/unwind_user/sframe: Enable
 HAVE_UNWIND_USER_SFRAME
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
        Sam James <sam@gentoo.org>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-12-jremus@linux.ibm.com>
 <20250801125350.9905B20-hca@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250801125350.9905B20-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PMc1SC4fMrYhi_5iW0UoAeWPP3X40gNH
X-Proofpoint-GUID: PMc1SC4fMrYhi_5iW0UoAeWPP3X40gNH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEyMSBTYWx0ZWRfX3VR0bbPEi1/N
 h9ITlUVbxcHye9ysJmGbCsP+TmQNQIMg16yR/922jfcPwXmPFi+19NfIzmRt5Ox+5/8zgHwkIqZ
 IadH9XkRbhNqCiNSQnCjICrT7nhNEfaEgRE3doZwEau91e3Lhif42unwxkJDbkjZpt46TfAZhLf
 bAbg56Dft/albpJY0o5L1uFIeKGSE7wHzgmqeS+zKrgDb+h81zU8i90mDj4Bvla+bQhDf6+xHr8
 Ez06O/8DbvIietzNv09Tq4hPeWV6jOaTLjqztnM0Ks6IzRj0q3xBszjGluqiokwJOvCdMAOMZEl
 yCmu6eW7M69iaMNHPBpJaD64n8ZC+BkvUsforkekh1rVSeWWpbOdA1wNfCbUQdCajWSHBqMCluW
 mXEGBCz51tjRFgsUEaluwgeg91tjx+E1aMjJs72As5r4Qi0swKcB6XMoXdGO8dYhZIH6llFs
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=688ce162 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=XDj3Yx29t083uedsr5QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=596 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010121

On 8/1/2025 2:53 PM, Heiko Carstens wrote:
> On Thu, Jul 10, 2025 at 06:35:17PM +0200, Jens Remus wrote:

>> +static inline void __s390_get_dwarf_fpr(unsigned long *val, int regnum)
>> +{
>> +	switch (regnum) {
>> +	case 16:
>> +		fpu_std(0, (freg_t *)val);
>> +		break;
> 
> ...
> 
>> +static inline int s390_unwind_user_get_reg(unsigned long *val, int regnum)
>> +{
>> +	if (0 <= regnum && regnum <= 15) {
>> +		struct pt_regs *regs = task_pt_regs(current);
>> +		*val = regs->gprs[regnum];
>> +	} else if (16 <= regnum && regnum <= 31) {
>> +		__s390_get_dwarf_fpr(val, regnum);
> 
> This won't work with other potential in-kernel fpu users. User space fpr
> contents may have been written to the current task's fpu save area and fprs
> may have been clobbered by in-kernel users; so you need to get register
> contents from the correct location. See arch/s390/include/asm/fpu.h.

Thanks!  Will implement all the review feedback and send a RFC V2 once I
am back from vacation.  Will be away from keyboard for a few weeks.

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



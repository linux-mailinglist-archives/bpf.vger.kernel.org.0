Return-Path: <bpf+bounces-64768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6216CB16CD3
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAC15A3BB9
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0B29DB96;
	Thu, 31 Jul 2025 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FdYZzRwC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1014182B4;
	Thu, 31 Jul 2025 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947698; cv=none; b=KW5ciiboaYXKNAK52Z3ClD1CmcfX902HdQeNIxQ4J+nPFtfPcwdbyhHVgXKrnmFEKzYwbH3Tnr6l+tR9FLajtTm5aYDgxNpzpzH62jeABpgOKy0etUh1tE3YzlNuSoJWXrN5KtGrkgUOOfz1BkFNlpv1E0iqTvHniQ3eNEfIfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947698; c=relaxed/simple;
	bh=rmHklMKdHwm/APWb9JV7WCWtDT1/gnWJKsXeispVorw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f86R6Vna6PxLKIG2IXpqhaKEBFqGtEyRZ2iKExeUNy/FJA45RAO5kNeHBH7HQOitAb8/1b0Pc4Ib9iVZoCpc/ZhrAvlTnk3fbDFVxBpknzCQWFDKESyV9pMKMz0rSExLLr0PfL57Zv3LTwIJlJiMFj+m/WOfvbQqX2LSOHLCbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FdYZzRwC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ULIWRn015735;
	Thu, 31 Jul 2025 07:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LwJ5kh
	kD2PgFOpLaXNtrOOu3x0p2dvYHqpprfHEatqk=; b=FdYZzRwCZ7Cq+J3BQD8vh7
	pX+acg3RawGmIBGLZTAmo14RPuyiaRULYGSfo2ao/k7DbpW67+iY0F+k/K729cSO
	fCYwWFGyQwAySPqQIQncvh1xnqrcRm/KOENvzhL/J4n6TPOL+1XxBTxwdBahtgn6
	FgWlvEt/zbe6TNtZrDqtz3c8okaPaGYwZNBE9aoKAif6lbbuwSgEeji1XlZjrkmv
	T0CqaN9Ow1Yl851R3clU07VSw2FjzdqTxRvO53lP7SFm74RMfnhQEKUD7r7kIhQj
	7HvQXpV46u6nQISGHaOr94zwa5QCxc7/eIXhtVnTnoLJ2nM4Z74LGre4yc+9U4Pw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfr17tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 07:41:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56V7dpB8026189;
	Thu, 31 Jul 2025 07:41:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfr17th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 07:41:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56V71fZT018304;
	Thu, 31 Jul 2025 07:41:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abpbfc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 07:41:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56V7fS5f23069406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 07:41:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54E6E2004D;
	Thu, 31 Jul 2025 07:41:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 217BB2004B;
	Thu, 31 Jul 2025 07:41:28 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 07:41:28 +0000 (GMT)
Message-ID: <82a66615-801a-40cd-a21c-ec82ff43b5d7@linux.ibm.com>
Date: Thu, 31 Jul 2025 09:41:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: eBPF fails on events with auxiliary data
To: Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        bpf@vger.kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
References: <20250725093405.3629253-1-tmricht@linux.ibm.com>
 <aIOPa25nzPHEqr0n@krava>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aIOPa25nzPHEqr0n@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA0OSBTYWx0ZWRfX4pYwqzUpWYvC
 3wFg9hKJkh25Ixuv85vs3bzFXkmdloMN8zelvfLtCC/RuXspFGmhwZtfdIWcR3WcU9FekTy9NTS
 d/HLr3ZqfaydDIRBBIBUIh6VwDNbMzqdNLDUG/My6uzENq3wtE4iN9kDu0O+faTfWRPL62Ithk7
 U748MVnLIoeD9GnHQkUvWik2DWfcwUGU+lfS9A+dIhP4wwNXMEH1KrU1jbWmtQfWyrBlXk6TzEV
 E2J3JK19aWYC+74GaqKD2IZPyCox6p9zHzTvm3TKSn4vev2b6WvxofV4Kn2S0pMT/fMPAE6fI07
 5h/qU9mLgpbDtCLUtWnVMz+3DCHSAb6BlhUO/zIYz7pQpIn0J/KrTAewx7+U3docQmhpNzdtLtB
 jZwuDCRgdS2+lm0GNywhXXlOE4j7dUSHOhl524ySGRBdwyGqSnF7ANZsqDrgtMRbudP1Enj9
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=688b1e2e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RVNz8nRQakF0jqo7AOMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mwd1r9qpu6Ul4AoN6c2hLyfT0Wx9z5gX
X-Proofpoint-ORIG-GUID: YFxsJRDDPRYkMghc81ie9jQW5cKEQGEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310049

On 7/25/25 16:06, Jiri Olsa wrote:
> On Fri, Jul 25, 2025 at 11:34:05AM +0200, Thomas Richter wrote:
>> On linux-next
>> commit b4c658d4d63d61 ("perf target: Remove uid from target")
>> introduces a regression on s390. In fact the regression exists
>> on all platforms when the event supports auxiliary data gathering.
>>
>> Command
>>    # ./perf record -u 0 -aB --synth=no -- ./perf test -w thloop
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.011 MB perf.data ]
>>    # ./perf report --stats | grep SAMPLE
>>    #

....

>> -		goto err_out;
>> -	}
> 
> I think this might break existing users depending on this
> 
> could we instead add some 'enable' flag to bpf_perf_event_opts and perf
> would use bpf_program__attach_perf_event_opts function instead?
> 
> jirka
> 

Hi Jiri, Ilya and Ian,

Jiri recommended a more flexible approach and I submitted version 2
https://lore.kernel.org/all/20250728144340.711196-1-tmricht@linux.ibm.com

This version now also passed the eBPF ci-test suite.

I am blind on the eBPF topic and do not have enough knowledge to dig deeper into eBPF.
Please note that this is not an s390 specific issue. It happens on other platforms
when the event supports auxiliary data gathering, i. e. has_aux() returns true.

I would like to ask someone with more eBPF knowledge for some help to drive this further.
Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


Return-Path: <bpf+bounces-76519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA366CB837A
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 09:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C55C3044699
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25A30B519;
	Fri, 12 Dec 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P23uyrmW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9152BF3E2;
	Fri, 12 Dec 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527330; cv=none; b=WusaNdsZz5oxSAWhIQXsW4DcHoOIoRnH2bLd3TE72gZTvKKgBgGbAV5qE/vhK/yQvk+DapD73ja0DZN+ipCBmLxJKTRLK48tsh03TNShDUlLq+8syR6GLyf8BeUJPjfOIO57Sp/CMXtEAxHaKamyCkIVjSc1CIRoimEgtkOoAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527330; c=relaxed/simple;
	bh=oXzknb+soR7rjkQzIPzrrf05XHCYFSQmrZBkpLVRTkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7KBeCSegIDagr9WsZcH01Wqs8seRdUvCTdf2uAfIyjsD1v57dmVJaQWMBh/3lnX+KM29nBkztSH3/5gKpOBhSTL5zda9HeSDZWJRiz/31PpH2oGGJ2sJB/f7FdNuUqBqpitVNbrQ9+A6P1ui4BWW/5n2fo0UWKFwSCIFeNs7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P23uyrmW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBIqgk6010186;
	Fri, 12 Dec 2025 08:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/m1kpF
	nXyyLJYkHaebDolzH+98BuCZUPbfMxloz5vus=; b=P23uyrmWSVD5DkS2IMDktV
	V+/SkFgDRRZxDdFSaU0qS7Cqi/voKylxa//vCelL6Md1H7bxwxD3YJ84hhFtCni8
	kCnQFtZMIgh8Xcai4mVutxoByNbz+Axu2qXxeyP6Oc+YoV05QhJvWQZbibx03SVR
	G/YCmbhxErJdCrz36pr74KusvWVYBLs58lbyILq66owFCqmX6xhFhoO2IkD1WGpt
	hcabaz6VQdZEcloW1kHOa2fHlDcUrjKnfnpCp6GEugPWvEgniLUAOOt7q22O+gbf
	ITF0i4FZoc3qo76VrU8i59ZAU16BtYumg7L77Eut3JV8d7icvDnw0PefM7Q+kTvA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aytm95av6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 08:14:43 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC8Eg1T018009;
	Fri, 12 Dec 2025 08:14:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aytm95av3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 08:14:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC6bfiL012425;
	Fri, 12 Dec 2025 08:14:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0akatdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 08:14:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BC8EcDX47186184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 08:14:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CBD120049;
	Fri, 12 Dec 2025 08:14:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993EF20040;
	Fri, 12 Dec 2025 08:13:40 +0000 (GMT)
Received: from [9.111.169.84] (unknown [9.111.169.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Dec 2025 08:13:40 +0000 (GMT)
Message-ID: <81cf7e6a-702b-4021-a148-9d051d28e80c@linux.ibm.com>
Date: Fri, 12 Dec 2025 09:13:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 14/17] s390/unwind_user/sframe: Enable
 HAVE_UNWIND_USER_SFRAME
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
 <20251208171559.2029709-15-jremus@linux.ibm.com>
 <20251210151012.40732B79-hca@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251210151012.40732B79-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OEvpXfclAQ9iQ829_WXTZ7y3JxA1yP13
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA2MSBTYWx0ZWRfX7cwJ/2FTxbOK
 JGde00bzjEu9AlLbFNhQ6noZTmjVvTRBrYo4EsCH/SrF2Q00lVkRE35E9CyNnCnLKs4Pp/BHXeH
 fX57/LxEdTxrYs0lXUaFefsSbnFoffcoS6ZKQ0knYvSabcR2fFsN9Gl5tmoni+k8P/wC+tlPlG+
 kRu/0l1Tne1MoUmMaVSr+MvbRBBwC9nRzKrL1c6MlPQfQgE8V9XUsEPF0j0bGTG2Qt8O1LT363/
 QjRKgoqiE2zmZeipWxF0/UPvxc1nHBQKxNh1vzamLOsxEW7oW5vecRuMtA/Zri0B6PIBXXswhGf
 pliB88rrSlsqU7/VxV0Gv+epvbQUCCEIPqhrydZnZg4HfKgbFMpfHo5SLEHmCmEV6fKg1iCICNW
 F8qZpFLon4TeEz4sXcHqeuk+VU2bRA==
X-Proofpoint-GUID: KvxoyagGqrDnoujMKLzUDAEemsy768bn
X-Authority-Analysis: v=2.4 cv=F5xat6hN c=1 sm=1 tr=0 ts=693bcef3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jPGRhfdHIWHQ-jYqdAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512110061

Hello Heiko,

thank you for the feedback!

On 12/10/2025 4:10 PM, Heiko Carstens wrote:
> On Mon, Dec 08, 2025 at 06:15:56PM +0100, Jens Remus wrote:
>> +static inline int __s390_get_dwarf_fpr(unsigned long *val, int regnum)
>> +{
>> +	switch (regnum) {
>> +	case 16:
>> +		fpu_std(0, (freg_t *)val);
>> +		break;
>> +	case 17:
>> +		fpu_std(2, (freg_t *)val);
>> +		break;
>> +	case 18:
>> +		fpu_std(4, (freg_t *)val);
>> +		break;
>> +	case 19:
>> +		fpu_std(6, (freg_t *)val);
>> +		break;
>> +	case 20:
>> +		fpu_std(1, (freg_t *)val);
>> +		break;
> 
> IIRC, I mentioned this already last time. But it is not correct to access user
> space floating point register contents like this. Due to in-kernel fpu/vector
> register usage the user space register contents may have been saved away to
> the per-thread vxrs save area, and registers may have been used for in-kernel
> usage instead.
> Read: the above code could access lazy register contents of in-kernel usage.
> 
> Change the above to something like:
> 
> 	struct fpu *fpu = &current->thread.ufpu;
> 
> 	save_user_fpu_regs();
> 	switch (regnum) {
> 	case 16: return fpu->vxrs[0].high;
> 	case 17: return fpu->vxrs[2].high;
> 	case 18: return fpu->vxrs[4].high;
> 	case 19: return fpu->vxrs[6].high;
> 	case 20: return fpu->vxrs[1].high;
> 	...
> 
> save_user_fpu_regs() will write all user space fpu/vector register contents to
> the per-thread save area (if not already saved), and then it is possible to
> read contents from there.

Thanks!  I have changed the code accordingly.  Works fine.

> I'll see if I can provide something better for this use case, since this code
> needs to access only the first 16 registers; so no need to write contents of
> all registers to the save area.

Ok.

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



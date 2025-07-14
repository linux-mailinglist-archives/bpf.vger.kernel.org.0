Return-Path: <bpf+bounces-63189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC10B03F04
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC6F3BA30E
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9124A044;
	Mon, 14 Jul 2025 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HSAA6N3i"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD42441A0;
	Mon, 14 Jul 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497604; cv=none; b=QzMUOHtcp0SahLGi816epjygmQK8pEY7++evrWeeJs2L9/CBxkQazE0v5ZIdf/Zv+ikunlAAQj4CtWQSuQp0sVoMo2boOSQzfxpParB4CCx/aA9w1o8tq7aBJgm6M0J5LpmpO9HvrclLmHS7aa9RECd4s9D5R5E9GeCeKGqr9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497604; c=relaxed/simple;
	bh=Yk7o+6QKjO2xscEPPdtN+Wix7XgzMepfTG8R21PfXDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYWLugX7CAKDxOfIOOF/44UtmaEXxIha/tUcUCmrLfO5TzcT5tDSA3g0YNmDurJfkoiX1wsVNdfwyvRyE5GX+A0Teko76TJzBzMfyOjluvoY5dGqMzWyGX65KtHn4Ri5689kPWTwqhmN9ywJ/vmpS/LQvHd9OlATx29dGuMieuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HSAA6N3i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ECU9ns000345;
	Mon, 14 Jul 2025 12:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dmi3t6
	tQeygD99OL+wSK/MG41ey1/Qsgx6cZ4EEJJp0=; b=HSAA6N3iaC9khs3r7wAPmT
	DC9xXRagVCk+cnyU9Xh/NOCbsga74dnW7c6Hc9td/k8YK1HnARyfAW/zfLNDq6Aj
	O7ZrfJY4Dv2VcOoxzZ5Y4gtjAhXk3eG0FkqR3EAbkcqLjen1KCbfhDW6pPAvrx8a
	fENDULULW31D2Dj+f9TCUi4ZqOpwiBeT57cZrEPPrMAQLu1ju5zBXOOJg4HWZp5+
	u8mgCmeZFP0+34UYeYLNUQ2qnp1t/oR6NsJeIpjSjjr/njUpsiWLFaVhKj8aN9qM
	YXE7hk8deB1zaZxGyrkD755SNUTaf6p7ugZnTwX9kdGIkHFDNVqvO1h8KyzdZKTw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6se70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 12:52:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E8WYMI008150;
	Mon, 14 Jul 2025 12:52:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0e2h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 12:52:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ECqFQ735193566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 12:52:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CADE720043;
	Mon, 14 Jul 2025 12:52:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 865CE20040;
	Mon, 14 Jul 2025 12:52:14 +0000 (GMT)
Received: from [9.111.200.219] (unknown [9.111.200.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 12:52:14 +0000 (GMT)
Message-ID: <98eeabe4-4458-4440-86f1-fc7fa55dfbbd@linux.ibm.com>
Date: Mon, 14 Jul 2025 14:52:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/14] unwind_user: Add frame pointer support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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
        Sam James <sam@gentoo.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20250708012239.268642741@kernel.org>
 <20250708012357.982692711@kernel.org>
 <d3279556-9bb6-429d-a037-fe279c5e3c67@linux.ibm.com>
 <20250710112147.41585f6a@batman.local.home>
 <155f22cb-b986-4d22-a853-6de49a1c2e03@linux.ibm.com>
 <20250710130859.41f3d5d0@batman.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250710130859.41f3d5d0@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=6874fd84 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MiBTYWx0ZWRfX0GmA12MjXPl0 mBleebw0c2P9DZSyzdVI/rFwyNpnKJuNwnipHu0cbHFskKcidiy6ktJrwTumFiA1pla+/R9Kkg8 ExFHZVn7WB4+Ve7gAZZub7bJBNJLq/2RlsS1Xx8H/nb02b+0/+cIuqonSJJf/1+3OqFuVQHF8kg
 6DmWruXn4r8mxIm3n2rvEg64x0SYfhh48L5clhqbjjjJDNqjaW8bPJxidrfJKqEXLQalez1kBTE RHOZLgfa/I1ON24ruFHu88Bp8sPdxK3V6lM8I+MCuBWEW14hehWKJ9Fczb0Lq3PgVVbO4qNcXjk oBPCVzaPB3JwXG39TH2uHqsBCpsleaCU5ospb4AjU+ZqIVgWvN2AFJs9HAXm676t5Avv1N7gEh/
 09VYeV53/4d29g21i51TT+ddWkVB3qJblodQp0HbdZ+ErmqMYZr/uKkHSTFiahhXixBX50P/
X-Proofpoint-GUID: Oh6bCUxjZdZRr-S4SJxqEUAcMtwALGGj
X-Proofpoint-ORIG-GUID: Oh6bCUxjZdZRr-S4SJxqEUAcMtwALGGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140072

On 10.07.2025 19:08, Steven Rostedt wrote:
> On Thu, 10 Jul 2025 17:41:36 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:
> 
>> cfa + frame->ra_off could be aligned by chance.  So could
>> cfa + frame->fp_off be as well of course.
>>
>> On s390 the CFA must be aligned (as the SP must be aligned) and the
>> FP and RA offsets from CFA must be aligned, as pointer / 64-bit integers
>> (such as 64-bit register values) must be aligned as well.
>>
>> So the CFA (and/or offset), FP offset, and RA offset could be validated
>> individually.  Not sure if that would be over engineering though.
> 
> I wonder if we should just validate that cfa is aligned? Would that work?
> 
> I would think that ra_off and fp_off should be aligned as well and if
> cfa is aligned then it would still be aligned when adding those offsets.

Makes sense, if the base assumption is that the SFrame information is
valid and the primary intend is to check that the used CFA base register
(i.e. SP or FP) was aligned.

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



Return-Path: <bpf+bounces-58541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BA3ABD3FE
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3067C4A002B
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B5269CE4;
	Tue, 20 May 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cD9ilwKX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6780268FCD;
	Tue, 20 May 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735044; cv=none; b=F0kWhZdJFYbWYdaL/ivZKxNDrm1u+cJJsNMU5VyAOX6eQ4iYDxDaMXtbu4pD99cBQJHpdsDU5HVK61wQ69ZS/G0Gb1B0q2LabZx4pLtmMIml7ZdRd4TV+pDN9iFD1bder///yoYkwaC/MYhSgbyH/lW8Byla0hj1/NNqM0kXVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735044; c=relaxed/simple;
	bh=cGTbb8zYo4jNTEl4DG1sLHPnv7wBHL8GpAMkGHoXRPg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XuKl61meD7ixNncoJGSe+B4C+wdFY/iHUy2KG6XA/spPg2LsH8rfyl1RKGuk0GaK/XM/BPyYYUV8pWFDoK+htCV3GBTsWSnLNbe+5rrDy9z+JOCZLefNq45ZCkhXNAwHRbs9pntdeRHuZ6lUr1qpWWo9vEdl1n3NAM26QqE6dNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cD9ilwKX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6IRgR016899;
	Tue, 20 May 2025 09:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NitEnJ
	Uoeyoa+VaOs45abY8c8SLSUkKx4WtWVPdhmoQ=; b=cD9ilwKXywkGysfz18vIKh
	E1V9CJU/4nwoa/aMwhtyaTft7xXtE9Opv9Xh8cDZEmn0qvbgyIMEzcMl8EwQ+Ghm
	sL1vzGwTXXBmzxXSPywT3Ca0BKek+I/gMHGJKzX0bidScnO0DbrL6C7AN3NfSu2r
	Z39M/dBa4O0MpOr8hqQQgsY5BJ2NmBT772oMauYayNR+gPxWAENPuKGMR5akKea6
	33cT4K9XxJ8CxDlfO6MZsXsuyRJWVI2tmu/Drz45tBjtehQC6xx8UjltdwLc4nmx
	u2dNSAUPJzFY6mIQSmbaCtGqQdulmp1aDRNiYa8K2DudMCd+NEHnGpDxKR/9rA0A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbss0gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:57:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K87Gjw015958;
	Tue, 20 May 2025 09:57:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q7g2axfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:57:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54K9v2uu41091422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 09:57:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65A1058053;
	Tue, 20 May 2025 09:57:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD9F858043;
	Tue, 20 May 2025 09:57:01 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 May 2025 09:57:01 +0000 (GMT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 May 2025 10:57:01 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [bug?] s390: kernel panic on specification exception: 0006
In-Reply-To: <20250520094705.7932Bc3-hca@linux.ibm.com>
References: <4f3768be36e0298be4ceebd4fdd3e96dd4fbdc04@linux.dev>
 <20250520094705.7932Bc3-hca@linux.ibm.com>
Message-ID: <c2436d8ae2cb94b6f029e8f0291e22be@linux.ibm.com>
X-Sender: iii@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3OSBTYWx0ZWRfX+wg1TM7zN/T5 tw7aLRmqWd8sucPaWMgXHvXaUDC+FzuSfpjscKeei33raYG3Un8T9Qvye7pk9KuEEEnuDV7ZX4Z uKtJwhGGjpqh/RBF+s26CpbZyxR2F8+4pd8LfE6dnqa97N6uBumGaKZHJhjk2Km5wxwJY1XT+jc
 kfiiklRcX390a0x6tWQY0Yp0F0CCWbS/3iJn2EVF247/y5wnp6UYxYr1QLHDwGmXzGjpRfWa8uB VhktVF3TH9ZsvbKEC0r528HVWNt1ZHyJgbOyVGRvPcPEhOTc/7Dy/sKIpt9tMkiOQhnjLDlMDwz 5r2AJ26QgbHUR15W+JjsM5jw9jHJl0Rn2GYLp6lHbhgIaNzk2FSpjray+ZOD6sqjnAqf7vFT5hD
 UrDoE+t0wQuec/WZf8tYO6QmzUKeO6aKSt8POWGcuTNoT7+RsVWFgge0iWUTeXzdU7xqGiw4
X-Proofpoint-ORIG-GUID: oX9Kwx6vNtn619nhthTwPsGAJ4Hh2yng
X-Proofpoint-GUID: oX9Kwx6vNtn619nhthTwPsGAJ4Hh2yng
X-Authority-Analysis: v=2.4 cv=DsxW+H/+ c=1 sm=1 tr=0 ts=682c51f0 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=O6du97unDwFHqXYQvgYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200079

On 2025-05-20 10:47, Heiko Carstens wrote:
> [full quote, and adding Ilya]
> 
> On Thu, May 15, 2025 at 07:04:20PM +0000, Ihor Solodrai wrote:
>> Hi everyone.
>> 
>> Stumbled on the following while testing unrelated changes to BPF CI 
>> scripts:
>> 
>>     #353     select_reuseport:OK
>>     specification exception: 0006 ilc:2 [#1]SMP
>>     Modules linked in: bpf_testmod(OE) [last unloaded: 
>> bpf_test_modorder_x(OE)]
>>     CPU: 0 UID: 0 PID: 108 Comm: new_name Tainted: G           OE      
>>  6.15.0-rc4-g169491540638-dirty #1 NONE
>>     Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>     Hardware name: IBM 8561 LT1 400 (KVM/Linux)
>>     Krnl PSW : 0404e00180000000 000001e43ac595e4 
>> (hrtimer_interrupt+0x4/0x2a0)
>>                R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 
>> EA:3
>>     Krnl GPRS: 7fffffffffffffff 000001e43ac595e0 00000000fff8f200 
>> 000001e43c52a0c0
>>                00000164c50740d8 0000000000000000 0000000000000000 
>> 0000000000000000
>>                0000000000000000 0000000000000000 000001643afabe00 
>> 0000000000000000
>>                000003ff9fbadf98 000001e43b747550 000001e43ab12774 
>> 00000000fffdfe68
>>     Krnl Code:#000001e43ac595e0: 67756573		mxd	%f7,1395(%r5,%r6)
>>               >000001e43ac595e4: 743d696e		unknown
>>                000001e43ac595e8: 73303031		unknown
>>                000001e43ac595ec: 61652c64		unknown
>>                000001e43ac595f0: 65627567		unknown
>>                000001e43ac595f4: 2d74		ddr	%f7,%f4
>>                000001e43ac595f6: 68726561		ld	%f7,1377(%r2,%r6)
>>                000001e43ac595fa: 64733d6f		unknown
>>     Call Trace:
>>      [<000001e43ac595e4>] hrtimer_interrupt+0x4/0x2a0
>>      [<000001e43ab128ca>] do_irq_async+0x5a/0x78
>>      [<000001e43b65f694>] do_ext_irq+0xac/0x168
>>      [<000001e43b66ae90>] ext_int_handler+0xc8/0xf8
>>     Last Breaking-Event-Address:
>>      [<000001e43ab08a9e>] clock_comparator_work+0x2e/0x30
>>     Kernel panic - not syncing: Fatal exception in interrupt
>> 
>> This is on the current tip of bpf-next (9325d53fe9ad).
>> 
>> Job: 
>> https://github.com/kernel-patches/vmtest/actions/runs/15051985809/job/42309244372
>> You can download full logs from there.
>> 
>> It only happened once so far, didn't repeat on restart.
> 
> Looks like the text section, which contains the hrtimer_interrupt
> function, got corrupted, and an ASCII string was written there.
> The hexdump above with the corrupted code translates to the following
> ASCII text: "guest=ins001ae,debug-threads=o".
> 
> Does that ring a bell?

This looks like a part of the following QEMU config:

static QemuOptsList qemu_name_opts = {
     .name = "name",
     .implied_opt_name = "guest",
     .merge_lists = true,
     .head = QTAILQ_HEAD_INITIALIZER(qemu_name_opts.head),
     .desc = {
         {
             .name = "guest",
             .type = QEMU_OPT_STRING,
             .help = "Sets the name of the guest.\n"
                     "This name will be displayed in the SDL window 
caption.\n"
                     "The name will also be used for the VNC server",
         }, {
             .name = "process",
             .type = QEMU_OPT_STRING,
             .help = "Sets the name of the QEMU process, as shown in top 
etc",
         }, {
             .name = "debug-threads",
             .type = QEMU_OPT_BOOL,
             .help = "When enabled, name the individual threads; defaults 
off.\n"
                     "NOTE: The thread names are for debugging and not 
a\n"
                     "stable API.",
         },
         { /* End of list */ }
     },
};

Can it be that the hypervisor has corrupted guest memory?
But I'm not sure what exactly in the CI software stack can specify these 
values.
I checked vmtest, and it doesn't seem to use debug-threads.


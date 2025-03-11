Return-Path: <bpf+bounces-53854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4108A5CDC8
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 19:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E74B3A555A
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D131262D1B;
	Tue, 11 Mar 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tCYlv2qs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957A78F5D
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717328; cv=none; b=fEhCgQtk3syIRgoc+ykwjCdeVKdKrk/lEtrkRrMzHOfkxki1SuSc9FI4DtzVDHr6pgRaeqFHrv0GzS/sogsjJPFNF5j04tVxqczyJRbGvzCRrmkNJghA0wL7/6asWCQG6HK2ohkRA/9QqEIKdz+5P5wmr+3DXUUNgELwy/JKRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717328; c=relaxed/simple;
	bh=XtwLOWUPqClcg9RHRqlsJGXMqVtcJbLYqzn8ctYTOGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La2lUh51ActF0CtIQd+wRB8aodNcbUzTbKZ3Cx4FjsU3JxGh97AnnHGLOvQ2Gf97sHde5jSa8i0EfygrS8MRT+UqUIMOL4EGj18yt6CmPUmHUF40OZ0VRut8bbfEI5rSNWgwyU3gZ6Jdm+mBfZdpMwNEJw31Tf8PZfYQqBpdViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tCYlv2qs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCSgJL029343;
	Tue, 11 Mar 2025 18:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RX8nJ8
	yzU85wl/nOAPc76CDZxqQZhMQgaSaY1DpIVEM=; b=tCYlv2qsxa4+MK4nbeMbA+
	LV7sFHw7SbLsgK/AGjbGCOyJmeW5wKSpovJPY5E36ZCJPD522LVMal1XNo3sbSRz
	GJOGCrOJVTPoNi2QKOPCiWPLdQstTtXebgKj0RFNeTUbGzj3S04oIk01EzDEoyHV
	4lKwUfFh4Muar76i6AeGUb04baTz7Zv9g7HS2gkiOtJq+5SSPMKnJD9oLhXNsZlu
	mas92sqsdC5mfeXf76Eq7qk5JKMRR36PvtSfjDkaJdD6R59u22eM97i+LrxaXE7B
	ragpFbb7LscJMh9tkKSnnekE9r2G5QrHBBN1fAF1kHaWHzxuKt6gChbgpp0BvFLA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45an7bj13u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 18:21:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52BIBvmJ015149;
	Tue, 11 Mar 2025 18:21:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45an7bj13r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 18:21:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGjOLh022294;
	Tue, 11 Mar 2025 18:21:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917ndpm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 18:21:48 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BILmT33212020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 18:21:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EE035805A;
	Tue, 11 Mar 2025 18:21:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5422A58051;
	Tue, 11 Mar 2025 18:21:45 +0000 (GMT)
Received: from [9.61.250.110] (unknown [9.61.250.110])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 18:21:44 +0000 (GMT)
Message-ID: <714157d1-dd6a-4ed9-8177-b8cf1bdee0f6@linux.ibm.com>
Date: Tue, 11 Mar 2025 23:51:43 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix arena_spin_lock
 compilation on PowerPC
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com,
        kernel-team@meta.com
References: <20250311154244.3775505-1-memxor@gmail.com>
 <CAP01T7622-6+e4K_O+AH978Jbp=M8HBe5ho2H4yS4FoTJ8=COQ@mail.gmail.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <CAP01T7622-6+e4K_O+AH978Jbp=M8HBe5ho2H4yS4FoTJ8=COQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0V-qdygJbxkeuiuq0l3PXWSncvx-VtNc
X-Proofpoint-ORIG-GUID: dJBGG4Rg4eP4SoIiXA6yCW37ilgNp0jp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=981 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110111

On 11/03/25 9:13 pm, Kumar Kartikeya Dwivedi wrote:
> On Tue, 11 Mar 2025 at 16:42, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> Venkat reported a compilation error for BPF selftests on PowerPC [0].
>> The crux of the error is the following message:
>>    In file included from progs/arena_spin_lock.c:7:
>>    /root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:122:8:
>>    error: member reference base type '__attribute__((address_space(1)))
>>    u32' (aka '__attribute__((address_space(1))) unsigned int') is not a
>>    structure or union
>>       122 |         old = atomic_read(&lock->val);
>>
>> This is because PowerPC overrides the qspinlock type changing the
>> lock->val member's type from atomic_t to u32.
>>
>> To remedy this, import the asm-generic version in the arena spin lock
>> header, name it __qspinlock (since it's aliased to arena_spinlock_t, the
>> actual name hardly matters), and adjust the selftest to not depend on
>> the type in vmlinux.h.
>>
>>    [0]: https://lore.kernel.org/bpf/7bc80a3b-d708-4735-aa3b-6a8c21720f9d@linux.ibm.com
>>
>> Fixes: 0201027a026c ("selftests/bpf: Introduce arena spin lock")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---

Built the kernel by applying this patch on bpf-next. And selftests/bpf 
compiles successfully.

Please add below tag.


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

> Venkat, please help test, as CI and I don't have access to a PowerPC machine.
>
> Thanks!


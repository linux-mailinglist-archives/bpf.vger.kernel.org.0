Return-Path: <bpf+bounces-21730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE652851020
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 10:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05194B24392
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942D17BBE;
	Mon, 12 Feb 2024 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CftQgliC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD318036
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731788; cv=none; b=kyjTvBofA/fH5FjTfAHMQaVejc66taLf6tqTdsc/SmHmYqnpES0PR4M91KaSbjk/3KyMmstcCWRQa21iTC/APBSUSbz7FrLWsr7kzOVb9IIMPznDYrTkgrk1lUAVZFzcTPTZCw6eL5giRe7I6PUupn+YRkydj8NLnCgtbye/8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731788; c=relaxed/simple;
	bh=Dd60W4fxWDcL544prohR7tV/5ECUIo9GhI/zfymynBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I38D+Y8VwJtYYXuM4VvuaFIjm7cU16nn2uKUMIkN3tiaf+uvHxaTRmcqpOxTdg4HCRrRpyObWjVqrSqmikdlV/Q/G16Wxk5SAfUlfFWBipeRT1UlXNPncZDfi5URDvUbKfFT3txk5S4gzRg/Cx7m6WrpKswB7Zro2cOV8DvTNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CftQgliC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41C9MKLd015384;
	Mon, 12 Feb 2024 09:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6RuoqWkWsu7mbcgXY59WmyCpZ08XFv8vJ0SO6FNNUZg=;
 b=CftQgliCwSHyyO+jlaMioYKNmMoO8WLF4/x7nccGj5WHj3n8eGtk+fEo9INz1hdfK208
 w7JZASapkYx+mouYHxRBGJKHNOf7jURsYWGjsrvqq7sLjnm/L+2vkagZkOMoQCBl0CWg
 dqvBZiW1dKwZJ3Fupl+5z0sJcDfMX/v5nzqCuNgJ3QgpueoQmWzhVAhOjH147SNpLgBp
 qcc99XOGNMwFdjr6Rs0jz8X7TPkDwxcHj3PZucDIl67xvjBMvrkONioOIdSwuvpFpizV
 4TfM18tWU7Stf/9+BJF8fXbhlzm+de7b30bmNA1HcZTvw1XKxWSIfgs5zehV4Tx6d7fw DA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7gmvgu8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:56:12 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41C9NHSF017333;
	Mon, 12 Feb 2024 09:56:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7gmvgu81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:56:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41C9gOT6004329;
	Mon, 12 Feb 2024 09:56:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kuyyyyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 09:56:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41C9u7HG9634420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 09:56:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CB9A20040;
	Mon, 12 Feb 2024 09:56:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DFA020043;
	Mon, 12 Feb 2024 09:56:06 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 09:56:06 +0000 (GMT)
Message-ID: <7efb192b-4eb5-4e25-a52f-54add200de1a@linux.ibm.com>
Date: Mon, 12 Feb 2024 15:26:05 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix warning for bpf_cpumask in verifier
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, void@manifault.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20240208100115.602172-1-hbathini@linux.ibm.com>
 <ZcUx0QdwW4FEDjTl@google.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <ZcUx0QdwW4FEDjTl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xY5wM-1nn3a1k8MHjUa7-GBwjRIEXX7m
X-Proofpoint-GUID: M7lEc8XDe160BK07Yh0TZm0LR84lZt8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=650 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120074



On 09/02/24 1:26 am, Stanislav Fomichev wrote:
> On 02/08, Hari Bathini wrote:
>> Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
>> warning:
>>
>>    "WARN: resolve_btfids: unresolved symbol bpf_cpumask"
>>
>> Fix it by adding the appropriate #ifdef.
> 
> Can you explain a bit more on why CONFIG_BPF_JIT is appropriate here?
> kernel/bpf/cpumask.c seems to be gated by CONFIG_BPF_SYSCALL.
> So presumably all those symbols should be still compiled in with !CONFIG_BPF_JIT?

Actually, CONFIG_BPF_JIT is the precondition for cpumask.c
where bpf_cpumask structure is defined.

   ifeq ($(CONFIG_BPF_JIT),y)
   obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
   obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
   obj-${CONFIG_BPF_LSM} += bpf_lsm.o
   endif

Thanks
Hari


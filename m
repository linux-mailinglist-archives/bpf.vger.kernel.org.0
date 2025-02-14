Return-Path: <bpf+bounces-51561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BFA35CB8
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 12:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74E8163465
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 11:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E1263F24;
	Fri, 14 Feb 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RGP9w4U+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCD02627ED;
	Fri, 14 Feb 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533109; cv=none; b=MjQTwYuOHrF12nSVuN003QhGrTK69PkUOePZbmLH27QtXaxVcdzLgLQ4X+L0kkIHani1p9qAtuosVNInvjtPGR9EVINFbE2/X/rMLHIFVQ4W5aCZ4Fmx5SLrqalT6uDgTmezMovFr4tKe5zeXFfww+0ngsVm7mfhwHSxeuTOXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533109; c=relaxed/simple;
	bh=axjpTlBaTB65KoKMcSUqVEvIfoPI6+kg3Zqp+w526GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sA4VkJ4T18XSRqkrGSSMSKuPT9RdspL07ID4vHf7A8RMOSLqLXGnS6CCkjPtkt9yjQoffck69Kt2aTpRdy2/GKbngyfztnuj49StaPOGN2iU0rsY84ywA+qbEN31Lo3ZnmC49lhA8UpeOB/T/SEvNmiGDF/OFBwPUrz7piaCuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RGP9w4U+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E7X0J7026192;
	Fri, 14 Feb 2025 11:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3eTs1b
	vQQ4j5ganAy8MfHzI0BRej/Nh6C064fqKQEq4=; b=RGP9w4U+X6GN7/YBs2beci
	ykT309osIAOwIHbnzXLB1TqFH/mW83D0P3JxVUwtfG/f0Y9K0vk2Vkq0c5Gyrbkm
	GQOiI6tDK5ahhaRbgsECEkx2dQqOP75RU8gMOfrdVyFks2hCh4b83OWoLF41tY6E
	IlgqUaGxUV4rqYeVa4kXoxy1aMgiCuUnTnuG+lBu/9yOvRoeBo6M7SSRXprqJ5kx
	uSaKmFNtFHZWiIlJvd07+dlAaBIkAZ4AJ6+mGJKKaKhzzGPGmkR9Pv6AL9qu4i5x
	HCaCThCQ+Q9rMpCbyr+O1gPhb48rSxMPbTjrZJCoungiH9fHuYyNADMtr/T24p0w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hps2g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 11:38:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EBPOo8007419;
	Fri, 14 Feb 2025 11:38:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hps2g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 11:38:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAbteE028236;
	Fri, 14 Feb 2025 11:38:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyug2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 11:38:00 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EBbxkc26477082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 11:37:59 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81FB75805C;
	Fri, 14 Feb 2025 11:37:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ED4958051;
	Fri, 14 Feb 2025 11:37:56 +0000 (GMT)
Received: from [9.171.83.250] (unknown [9.171.83.250])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 11:37:56 +0000 (GMT)
Message-ID: <2ae65126-73a3-4c18-bef5-d4067c727cf5@linux.ibm.com>
Date: Fri, 14 Feb 2025 12:37:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 0/6] net/smc: Introduce smc_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>, jaka@linux.ibm.com
Cc: kgraul@linux.ibm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, pabeni@redhat.com,
        song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
        edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
 <20250214092209.GA88970@j66a10360.sqa.eu95>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20250214092209.GA88970@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T0nuF2-fKIt4RzydPK9izWtAdhID9j5L
X-Proofpoint-GUID: ZJmRc09rl_T5BlAX_cYVv9QYvJ1aqxHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=885 mlxscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140084



On 14.02.25 10:22, D. Wythe wrote:
> On Thu, Jan 23, 2025 at 09:59:36AM +0800, D. Wythe wrote:
>> This patch aims to introduce BPF injection capabilities for SMC and
>> includes a self-test to ensure code stability.
>>
>> Since the SMC protocol isn't ideal for every situation, especially
>> short-lived ones, most applications can't guarantee the absence of
>> such scenarios. Consequently, applications may need specific strategies
>> to decide whether to use SMC. For example, an application might limit SMC
>> usage to certain IP addresses or ports.
>>
>> To maintain the principle of transparent replacement, we want applications
>> to remain unaffected even if they need specific SMC strategies. In other
>> words, they should not require recompilation of their code.
>>
>> Additionally, we need to ensure the scalability of strategy implementation.
>> While using socket options or sysctl might be straightforward, it could
>> complicate future expansions.
>>
>> Fortunately, BPF addresses these concerns effectively. Users can write
>> their own strategies in eBPF to determine whether to use SMC, and they can
>> easily modify those strategies in the future.
> 
> Hi smc folks, @Wenjia @Ian
> 
> Is there any feedback regarding this patches ? This series of code has
> gone through multiple rounds of community reviews. However, the parts
> related to SMC, including the new sysctl and ops name, really needs
> your input and acknowledgment.
> 
> Additionally, this series includes a bug fix for SMC, which is easily
> reproducible in the BPF CI tests.
> 
> Thanks,
> D. Wythe
> 
Hi D.Wythe,

Thanks for the reminder! I have a few higher-priority tasks to handle 
first, but I’ll get back to you as soon as I can—hopefully next week.

Thanks,
Wenjia


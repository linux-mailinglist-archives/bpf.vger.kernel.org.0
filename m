Return-Path: <bpf+bounces-78039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D80CFBD16
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 04:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008C53080F7D
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 03:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965922571A5;
	Wed,  7 Jan 2026 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ejseCAVR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C5253F05;
	Wed,  7 Jan 2026 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767755544; cv=none; b=SwAD6btt1oWfpdC+mXBga3GsVyyF1Kh9P6Sr0CWoJ+Y8xH17d+FnIB/5zn9+JHzhM6J1YySKzrBH5gJF9sM9YeGKhT+cUuoDA9KgjxwosSDDuXsoj7OyRyg8g7vjnHDjh3DO2u1nvbf2+JlNKKCzAk7JDrUDXHlhZLC/3IWWvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767755544; c=relaxed/simple;
	bh=JYOqfthzhUxIP0pnp/OnH+7tJ0S/qbPL9pzqvc+swSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GG4f9ArBiGewD7eLhC5SHydYpBKnCOCgnym5OhcgZDEBQodXIK29OhSF5hRPryu5qkMM2qgUN3OrztgL4TtkIUiqL7ZfeYItZ6zuaRudIpEhlmuUw8TUlhvkxkH+X2OScBJ34G6+I/khEiWAKWFIJPiq53Xds2LRxskstFTwqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ejseCAVR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606HKf4c018509;
	Wed, 7 Jan 2026 03:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3pdEtf
	5PGuiqs9+a/E85cEteIo2F6atXr/LDASHbo+I=; b=ejseCAVRngkEh/zQcGbAVm
	HxF4BH3etAL9V56hT3cw/DXdlB4ZBQoZWg14v92L+nfK/TEmXOPHJRPNov689vMO
	CYVem2aP72CWtaITmBXOy7UsNdSxZLobs7A56cDUXG+3RQIsz9aT2beUl58UNTCD
	rBFKR8FJWMeHI/AgedJK3QwlzbvoQKTA3nmqDF2Ww5gBQqdSP1oV84SYB7HGffCo
	PcGHfmDXQvZUFUM+dBC6LtQifGFe2LUS5N7ygYNUvC1v5p+7MYokY6JgAHQGuWgw
	vc0YCOZps3aFmpMe6bDCsykvUm0IpFZm88nI/PCk5oWeAp6nMJMHKKPEDdWBmxWQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu66s9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 03:11:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60735nAC011705;
	Wed, 7 Jan 2026 03:11:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu66s9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 03:11:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60738ece005206;
	Wed, 7 Jan 2026 03:11:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexk6us5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 03:11:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6073BDA58454670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 03:11:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 360755826C;
	Wed,  7 Jan 2026 03:11:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D1B958263;
	Wed,  7 Jan 2026 03:11:22 +0000 (GMT)
Received: from [9.109.209.83] (unknown [9.109.209.83])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 03:11:22 +0000 (GMT)
Message-ID: <6419f23b-01bb-4ccd-89a9-2a606bc984eb@linux.ibm.com>
Date: Wed, 7 Jan 2026 08:41:16 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/2] powerpc64/bpf: Inline helper in powerpc
 JIT
To: Hari Bathini <hbathini@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sachinpb@linux.ibm.com,
        venkat88@linux.ibm.com, andrii@kernel.org, eddyz87@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, christophe.leroy@csgroup.eu, naveen@kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1765343385.git.skb99@linux.ibm.com>
 <CAEf4BzbiyJwSoaSRDtSRetze-yST-NQX83FyECSmRex9szx0NQ@mail.gmail.com>
 <aca5ed6d-8d39-4968-aef2-d5ab6c8cfb60@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <aca5ed6d-8d39-4968-aef2-d5ab6c8cfb60@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695dcee6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Z0ByAkKCtCMuyWjYBMoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gX-3G8r6ILoIAHtb1Ncg7n4IG0NJ5FS6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyMSBTYWx0ZWRfXwTH1qfpW6GPY
 UqlcFcquFTX9rVoZ6S5imz/IeJ0enxiG5VxSxU4ZTHyte8Fb+d2fKKsXXNrBcg1HKV2shxNjU0E
 qpDVoF53QA1bePRzDw0OlEzwru01F0/Yrf3L0StxtXVP0rzRINDAjP4IxV0ALtRRjCiQ2lNQBXn
 9L8DdtHiYEUJ/aKF/aqlnKqh2oC/nvgPF72nGIHzXwm+WP+B0Z+PPpilmMZqbM/wzd48B1xuEoA
 SwodtZgnm0mDwdlDmrOkSUcJCSpg+Rd5T6qJeRBsAK7oWKdsdqSvta+2VCatuGPoELRG7DY10Gr
 tmcThxdHd+d+v5jCBMCpuNAgkBI68N1Odl6B2SRPGcDtu3cRc9emq1OQsfsDShBMBsHIukqoIdY
 VVRNUlBLRRHs7DXVj3ebwxmjtHJC6PFXbo4BOFV8oOYQtOe9qGA/DgCfV2tax32dhav3z3oCioh
 oCx875ShypZW43ZvLHg==
X-Proofpoint-GUID: uOONuWptlDBKye8tgyCDCEf4NVW109OR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070021


On 12/17/25 10:43 AM, Hari Bathini wrote:
>
>
> On 16/12/25 11:46 pm, Andrii Nakryiko wrote:
>> On Tue, Dec 9, 2025 at 10:51 PM Saket Kumar Bhaskar 
>> <skb99@linux.ibm.com> wrote:
>>>
>>> This series add support for internal only per-CPU instructions,
>>> inlines the bpf_get_smp_processor_id() and bpf_get_current_task()
>>> helper calls for powerpc BPF JIT.
>>>
>>
>> This is marked for bpf-next tree, but I think this should actually go
>> through ppc64-specific tree, is that right?
>
> Yeah.
> Maddy, can you pick it via powerpc tree?

Yep, will pull this via powerpc tree.
Maddy


>
> - Hari


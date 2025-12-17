Return-Path: <bpf+bounces-76819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2532BCC603D
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C83703012EFE
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 05:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4C261B9C;
	Wed, 17 Dec 2025 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ivTvT2gD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE83A1E8C;
	Wed, 17 Dec 2025 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948444; cv=none; b=nKo2mzEmBLutf2a/Lci5wrIJBB6/prRzXbwdFfTvs3Obh00KLYBVOxGu790ppX8WBSUrbBUj/4V5G73yuPbDDJbXWv3jmnAKC/sd0T11b4LOjmiUaVqLuLE5Vdkhj50r9sr798gjBGSqv88lJKqZm6Hlk2PoZi7lxjUBtfpXMCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948444; c=relaxed/simple;
	bh=BLXKKEXbuxKT17JQ5C+/Low4dNgIA7h9H58HlfrcsHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReidtFeQbIMYLyYrXhgBwnzUnTdZnlqbaDkGKWFzhiG2zxgmQHSl/c0QD6mg5U1LxZk1mp4BBogPWlYDc3HFQIFMBK4AO83BpWeTa5/b/C3Nn1bt9MSmT+hJWdVhPQdlo6fOFB5FOdFQIz5yL0Px8qZvIA01pKcYxiRfg0jdeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ivTvT2gD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGIfqkH012199;
	Wed, 17 Dec 2025 05:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A4WDSM
	Z1C3SaU7AOGVp5yj7ltERnkRNiYPqSRB35fng=; b=ivTvT2gD7+yXz+Zf8nQiYV
	ox4sJpBOJSsqr9iqLv7e3biC/ygEiCLnirCqwIV9Tr1ClrkhUo5j+cIRB17iVF6O
	kMqwAEY61YtcdbCBcNcmMcwu/dOGRkoMf68jDm/0gFKGL7//HkKhQnmWlf8XSR5m
	OfgYSfWNaU970Rr8sdE7jY16unoNwExOzogJimf0ESZL9gDJwNXBz7DjsGuPGQxp
	RR9DG1dMHl7mg1oc+RKZ99HW+pP2Z0C/CSYEiSQM097kwIHe7uhtokuFXCHZUVB7
	v27OYYbvjRrzT9a68Eg/j+kK7LJm2kVaW6MdOKwS75BNxrwxcBrBCC9yMXzRPRmQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvb282-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:13:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BH5Al56017182;
	Wed, 17 Dec 2025 05:13:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvb27y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:13:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH1DeHZ026753;
	Wed, 17 Dec 2025 05:13:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsgsbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:13:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BH5DNUq55247274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 05:13:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34F6F20043;
	Wed, 17 Dec 2025 05:13:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BE1620040;
	Wed, 17 Dec 2025 05:13:19 +0000 (GMT)
Received: from [9.109.222.214] (unknown [9.109.222.214])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 05:13:19 +0000 (GMT)
Message-ID: <aca5ed6d-8d39-4968-aef2-d5ab6c8cfb60@linux.ibm.com>
Date: Wed, 17 Dec 2025 10:43:18 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/2] powerpc64/bpf: Inline helper in powerpc
 JIT
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sachinpb@linux.ibm.com,
        venkat88@linux.ibm.com, andrii@kernel.org, eddyz87@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, christophe.leroy@csgroup.eu, naveen@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1765343385.git.skb99@linux.ibm.com>
 <CAEf4BzbiyJwSoaSRDtSRetze-yST-NQX83FyECSmRex9szx0NQ@mail.gmail.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAEf4BzbiyJwSoaSRDtSRetze-yST-NQX83FyECSmRex9szx0NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX4RvWgSemv5lB
 pQRx301Z4RvzN1dMa/TrSYZZbVLKLj1PbYeFm5KydyopzmunVaUmxvSDTJw0JtwZ/Dayqc6oNee
 h5F5qIlOGoRs78gljeNUeD4c9REAR0N4XBRzSrfJopjaVQxPquWf2I92vBMdZOzx+dx9C4+Ybby
 1LaI1iwxgyDI9EMEVKtDn8FpnHrY9J4rMpd+ptJ/xkmZbAKGtsVGAjOg64MWobc3uycY3Sn+oOx
 OKdwAjcZhjzdnXk8MzYVLNHJhrD7jMNRsmcNGVarg/15cwga7fxTAe7QA3tEMv+a8GQYhrAgCan
 LGweJeb3TTzqTlC6m9DRaSty3IV/cgwGhCZDHsFLvQuuO5i2moYdZmSdOchvGeTq801pf7ZDbMq
 AuBe0EWdZ42WG9+oqROpmfKtwZfcPw==
X-Proofpoint-ORIG-GUID: 6WpgZuMtsvuhqxth8Cqbgu9sRG6J5xtW
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=69423bf8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=KN6hZ7hgYJA-1HVgs7wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bLkxCxGXIlSNBlcq817jJKV-Oy5h1Sd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023



On 16/12/25 11:46 pm, Andrii Nakryiko wrote:
> On Tue, Dec 9, 2025 at 10:51 PM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
>>
>> This series add support for internal only per-CPU instructions,
>> inlines the bpf_get_smp_processor_id() and bpf_get_current_task()
>> helper calls for powerpc BPF JIT.
>>
> 
> This is marked for bpf-next tree, but I think this should actually go
> through ppc64-specific tree, is that right?

Yeah.
Maddy, can you pick it via powerpc tree?

- Hari


Return-Path: <bpf+bounces-65323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C87B20343
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 11:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E2F1662A6
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF62DE71A;
	Mon, 11 Aug 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HoeJ03P8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015B2DE6EA;
	Mon, 11 Aug 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904325; cv=none; b=TnC2JV6gVgHy0MT0kiGTAlZRPCQfiTirWD+sNFd6Uzzyzf60Z2va5vSwBvdkUNTc9x1dxZM3roBDKkT8Dp2wup5W4yuM0al4ByTidCLXPoa6Mms0mTwuIpEqwqu1iqZ7UAJ0JxTB5uCXMrMkVMSMx6h1n9wl+TT8lQOnLt1mx3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904325; c=relaxed/simple;
	bh=lWtl+L7pWB/ulDbxs60HArk76e5ZiDbUJoN+I5NpWjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPFrvHPKzaTO30+pC9tTDNQHsxM4/xR2bcriwDG3NfarM6dHC4vzuagKZ8l4t6Xqc/83tNVXX7v/4CCOy1XjVrb2m7Pd5vKXDpDM5WuRgw/rI9AgzwbcdJlCZex3ki0wbllGhCV2YTYa9uA1HtOqTw8JyuJsyf4F2rnyTTmy1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HoeJ03P8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57AJpKDB029406;
	Mon, 11 Aug 2025 09:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nBod5i
	xELVIKNb+CTdPVWWnjYnpuicSAFr5e0+Tswvw=; b=HoeJ03P8IoHBXlHcUnWdSr
	Uv87ziiUILXUOFiNHMwr5Ot54yZ2+RYp5Yu8gnEF+AfnQj/v2nkB4s7cf782lwWf
	j9iFiZd+/Mm9+1W0FiC+V1F7QG8CIt+Rhhekm+sCEe029NEvnAJEJn/khLoPFMu9
	sTkaQuGn37Gj5n7z9t3ZjXISJgH/6QCew9IeOdjEYrkyGsutNti3/4Nb06qjKqF2
	BV5HsgaBPjhUwH1GirqTNREJcOynZ2Gi2kllpKbrVcCLq/KrxKjpAB/Ipj3ifuv8
	hM2jzzuhDmnYSd72/1oMlfxgaAF0OSThkEr71ALnEer1n6BSX802PsTxBh0W0Ujg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9vt76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:24:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57B9MHAi004456;
	Mon, 11 Aug 2025 09:24:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9vt74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:24:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57B98D27010656;
	Mon, 11 Aug 2025 09:24:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnudd7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:24:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57B9OphO52887852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 09:24:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC3F020043;
	Mon, 11 Aug 2025 09:24:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98A0620040;
	Mon, 11 Aug 2025 09:24:50 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 09:24:50 +0000 (GMT)
Message-ID: <14ec76a2-e80e-44a8-a775-ebd4668959c4@linux.ibm.com>
Date: Mon, 11 Aug 2025 11:24:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/5] net/smc: fix UAF on smcsk after
 smc_listen_out()
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
        sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        Mahanta.Jambigi@ibm.com, Sidraya.Jayagond@ibm.com,
        wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        jaka@linux.ibm.com
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
 <20250731084240.86550-3-alibuda@linux.alibaba.com>
 <174ccf57-6e7c-4dab-8743-33989829de01@linux.ibm.com>
 <20250811015452.GB19346@j66a10360.sqa.eu95>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250811015452.GB19346@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=6899b6e8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=RdrFP3df893paWRMMkAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kspH_iWLfHuDQMYyBY6nEisN5QjgiFIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2MiBTYWx0ZWRfX7hl4qGc+4f97
 0gMUFZUVcB05sCVzkfhBIRkjBT54FVcY4aKKuPsW/G0DEsXm8ub5FnyHx+PJFBWcCTskdkmkncR
 PpMPbeNKtbpO7xgzDIdShMwLnzyJP8Ryz9LQRpo/M3GsAUd6F4YsLnDhbSEOlq52MBsMRDJu11g
 bEvvvehEbdM6JRClmMiMKuJj1TWAxsafbpL+Yqk2jf/Qny6/Szvfulmb7H7P6tCl63OmpGp9vGm
 r44I20cgRdZzcTRrWEYkzqR5B/yP82NmEmK4cyZLyAihHFnAp6UvMVjC3Hy9HmXFAPR8w7a1nnE
 o7c4CvkoNFWMjA+qTkFn3Y8HVsqH8RKMjYVfc3/yfJ4In+hGCVR4gsyXiiw02GgDWp2lGCvikJJ
 k7cFfkn2b+BDR95Tlor1CccuzqLz84sV1Iov7W9AGjOsH1ZjFVuwV4BOC+4d27DxeyEJabee
X-Proofpoint-GUID: aPsa-QizwhW6HZKV5RzAJ6nky6wU5Q3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=698 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110062



On 11.08.25 03:54, D. Wythe wrote:
> On Thu, Jul 31, 2025 at 02:57:31PM +0200, Alexandra Winter wrote:
>>
>>
>> On 31.07.25 10:42, D. Wythe wrote:
>>> BPF CI testing report a UAF issue:
>>>
>> [..]
>>
>> As this is a problem fix, you could send it directly to 'net'
>> instead of including it to this series.
>>
> 
> Hi Alexandra,
> 
> Yes, it should be sent to net. But the problem is that if I don't carry
> this patch, the BPF CI test will always crash. Maybe I should send a
> copy to both net and bpf-next? Do you have any suggestions?
> 
> Best wishes,
> D. Wythe

I do not have any experience with bpf-next. But typically patches
to 'net' are taken after one or two days, if there are no issues.
I'd assume they are then picked to net-next and bpf-next(?) almost instantly.
Then you would not need it in your bpf series anymore.

Sending a patch to two different mailing lists in parallel sounds like
a bad idea to me.




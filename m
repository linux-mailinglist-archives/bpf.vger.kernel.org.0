Return-Path: <bpf+bounces-53825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E925A5C364
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAEE16BB64
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E325B692;
	Tue, 11 Mar 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gcEVavJK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29292253F13;
	Tue, 11 Mar 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702352; cv=none; b=p17cYpLyFbF5gzJsuT5uAKv3MRBUfMseDU+0GpIO/MLB6JbgJKfwXBY3uuISC2H78ITc4+I4hBSzBgCz4JVsT8QhGKnjzSpaiNntjd1xH1YlSQ5rQF4gdAnaL+egmGyfXESdNAAPELrX5UEeyHVW/4KGXb/9qsHBsVaem0RYG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702352; c=relaxed/simple;
	bh=6OvbwuzOWKYXpLAf1Dy2SXJ1sbx6q35dy6gQZJhEhRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLA5Rul/R0kBBg9Qi6D2QeeU997Ijc4uvTebTqqMNnxLFPqNpUPSXmbRuRrczhvTwg0fWFuPhv3Cp5cCOdJD2Pf7S1XIuomZxC+3cRjyhsacNZKifLs4EUcvp82xej6kovPBWuWqQq343TVhavZrLYnyG30zSGCAaKXVNa8OcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gcEVavJK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9ekm2004460;
	Tue, 11 Mar 2025 14:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IQAsIs
	PVOeO7xHxkLefhX6FU940USDwYv1EuiLuMx8c=; b=gcEVavJKZohuC5u1TPOweT
	izEyvrrRLdB/4LDaf8mFzD1v1BGBekdd7i0QP69xYR3PMSw+05DwerW57nsJw3JK
	GNh+fmw4KdnBjBmx0LAmpx2GYm65+13MUMdyUc3BTSVLBmWno+B6ydWGtytOeAsJ
	j4pA+7fHEZEGrCsIwEkVwPTS8hKwMqjH3l3NcRmnQvOmIzWXeaLRZw9EGW838I43
	2RIHrB6+XdWg1UAIjOLgcYWn8krF3eL+k6nmbipeMDYTBULBw7HztFsKAC9jqmVE
	Q9lqlwHhA7OjNaUTpXh+PYAGuQ8rABaH4XI+QkyWZYbBFvazufyOrJYFeZrwz/dQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qvchy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:12:23 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52BE9wf9010167;
	Tue, 11 Mar 2025 14:12:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qvchu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:12:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDJo4C022294;
	Tue, 11 Mar 2025 14:12:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917ncj8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:12:22 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BECKXQ19595818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:12:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B11775805F;
	Tue, 11 Mar 2025 14:12:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26F6958053;
	Tue, 11 Mar 2025 14:12:18 +0000 (GMT)
Received: from [9.204.204.161] (unknown [9.204.204.161])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 14:12:17 +0000 (GMT)
Message-ID: <7e47814f-37de-417d-a84b-de21147e372f@linux.ibm.com>
Date: Tue, 11 Mar 2025 19:42:16 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next] selftests/bpf fails to compile
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <7bc80a3b-d708-4735-aa3b-6a8c21720f9d@linux.ibm.com>
 <CAADnVQLUxTjYuvwyO0CMS5=e0YqmP525+EDfJX-=dH55g8XTXg@mail.gmail.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <CAADnVQLUxTjYuvwyO0CMS5=e0YqmP525+EDfJX-=dH55g8XTXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jo8lA2tCn4PNfblyIMeFbTqWoNTGWH_w
X-Proofpoint-ORIG-GUID: o-iuy06kM4PdEdJaaIKWNsMwvN_XcyvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=709 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110089


On 10/03/25 2:15 pm, Alexei Starovoitov wrote:
> On Mon, Mar 10, 2025 at 8:32 AM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
>> Greetings!!!
>>
>> selftests/bpf fails to compile with below error on bpf-next repo with
>> commit head: f28214603dc6c09b3b5e67b1ebd5ca83ad943ce3
>>
>> Repo link:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
>>
>> Reverting below commit resolves the issue.
>>
>> Commit ID: 48b3be8d7f82bea6affe6b9f11ee67380b55ede8
> ...
>
>> If you happen to fix the issue, please add below tag.
>>
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Not quite. The issue is likely that your llvm is too old.
> Please upgrade.


Thanks for the feedback.

I did try the compilation on fedora41, with linux-mainline kernel and 
/sefltests/bpf compiled successfully. But on the same set-up 
/selftests/bpf failed to compile on bpf-next kernel.


OS: Fedora Linux 41 (Server Edition)
LLVM: llvm-19.1.7-3.fc41.ppc64le

gcc version 14.2.1 20250110 (Red Hat 14.2.1-7) (GCC)

Passing repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
Failing repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/

Regards,

Venkat.

>


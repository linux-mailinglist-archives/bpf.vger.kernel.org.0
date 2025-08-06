Return-Path: <bpf+bounces-65112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F63B1C358
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 11:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FA3174564
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31CC28A3EF;
	Wed,  6 Aug 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fjqQ76cf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D22E370A;
	Wed,  6 Aug 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472586; cv=none; b=byMSZvjAIFD7KirLFux5owMsixv9SaWvVCgXqV1orpEhCr3LYjnyY3ftE1Uy+TiCQG1iGu3nG6fVcDySzSLxP/zjfQriBtu/LSbLf6/hmmxzBEvOC6qWV0yHodX3Pzpe5r+4YfT0UVZoVAo4Hq3WEJMt5rvaYBFIUYNzwONCQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472586; c=relaxed/simple;
	bh=ES0F2THCOf5A+FV6j3r4XDV+ugLcrg5Fj4j2x6zvoVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYVXZF72Hni4UtBqPxNtbhrw/c02tNAYcWZ26HmeVycW2gojy1h34msFe3D93l14Rt+uaqkNY4jQ8WZ3x3UagC9AKo9diYhgecsnV/0G/cQA7tyW5HbKXpQRknl2dRxVTyYOIc5Q0eRU8rd9GBkBCj+RiZkY9+FNcUVjIurFMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fjqQ76cf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766tFcu019444;
	Wed, 6 Aug 2025 09:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B1T9N3
	DRA/VCZIWhWg7LmWynZ3xyLENJ07dyfWBpZFU=; b=fjqQ76cf2x2t4NVcP8fgzr
	LaFBEfj+UCr8zHPImEuVsbHeOalOMu7aLBkm6TUNQc72ofXUewOMuhoZpohnvs5n
	blW8Y59qJ7dCaz8L9JV/B9Wp6GQoTjETd8edxIPnYoo/6y78owXPHvq/Hkqr+0Rv
	+LnW63jcH7yYToeHn0HUkyWF+7jiczBzFK+cnnRcJqHGPvhFQMYjKBAh4JY0tREc
	i1k0UdKdYrXY9P8cIzjQnBbZnJRH3DnlQz3cf5/FmVEk3XmkckAic5WNoGDfgHSX
	A44dxVr/6XizSN0aNtD13z8c/CJYL4SOPGYXrIykeOq1IAZGz+iVHnsCOD1dCZFg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26trn1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 09:29:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5769SaT4007367;
	Wed, 6 Aug 2025 09:29:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26trn1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 09:29:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5767vKZK020600;
	Wed, 6 Aug 2025 09:29:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwmty5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 09:29:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5769TPs950069950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 09:29:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 554962004B;
	Wed,  6 Aug 2025 09:29:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D41F20049;
	Wed,  6 Aug 2025 09:29:25 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 09:29:25 +0000 (GMT)
Message-ID: <1094385e-6f86-453f-a48e-fa284dcae385@linux.ibm.com>
Date: Wed, 6 Aug 2025 11:29:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] perf bpf-filter: Enable events manually
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20250805130346.1225535-1-iii@linux.ibm.com>
 <20250805130346.1225535-3-iii@linux.ibm.com>
 <4a7fc5ab-682d-4fac-a547-9e4b1263dba7-agordeev@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <4a7fc5ab-682d-4fac-a547-9e4b1263dba7-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kp9R7gzU3Zi2X7pQoZH8W3IiFwi5wq4p
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6893207b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=G2SI-qYk9hsPBJNDFb0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ByIXSOgnBIEuNgtdSnszCEELpYo7LbV2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA1NyBTYWx0ZWRfX9KfYdHqR9GDI
 Y2nmdZvmxcwpHVRRulqqUvZ/FZDuaJdIwkz0Y49tMESj0+S4foX1OPBQODR/GBsGCZiZWOV83Jg
 4MHJtU0tnHYnzRRqTJxPTRZN+NjejH5JlO9TvxoSeHdc6/WUj8mVU4OgiY0TY4dHbytC31VHenu
 bYuRTzMeoeEDlHNUrDA4hkTZhGd39n5xvGIjh/ZGyzl04OEiQCaPQrKRTyuWo17nLwvgCtOYF0N
 sEHjrwGYun/eXu5tzHekJbAV/DBJcI5YBrrYPqdMVS0+8GH9BjY8kdR3yIfi1v5OyJPkb9WJoRy
 FEMzme1beyqrWepAiCHI5tZ1QpcRJYMegIKnaw8U+b1R3CdW0cle3VuL+zbG/9q9uOplNJFgC9x
 9U2fWXqD1febnrQrbnHXJe87s6Mcmf51xTteJ7roawXuUuJ1AYu83JtOdAuwAnedbXSFWubo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060057

On 8/5/25 16:14, Alexander Gordeev wrote:
> On Tue, Aug 05, 2025 at 02:54:05PM +0200, Ilya Leoshkevich wrote:
> 
> Hi Thomas,
> 
> The below comments date to the initial version, so the question is
> rather to you:
> 
>> On linux-next
> 
> This line is extra.

I just wanted to let readers know which repo to look at.

> 
>> commit b4c658d4d63d61 ("perf target: Remove uid from target")
>> introduces a regression on s390. In fact the regression exists
>> on all platforms when the event supports auxiliary data gathering.
> 
> So which commit it actually fixes: the above, the below or the both?
> 
>> Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF program to perf event")
> 
> Thanks!
> 

Good question!  Pick what you like... :-)

The issue in question originates from a patch set of 10 patches.
The patch set rebuilds event sample with filtering and migrates
from perf tool's selective process picking to more generic eBPF
filtering using eBPF programs hooked to perf events.

To be precise, the issue Ilya's  patch fixes is this:
Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF program to perf event")

However the issue (perf failure) does *NOT* show up until this patch is applied:
commit b4c658d4d63d61 ("perf target: Remove uid from target")

There are some patches in between the two (when you look at the complete patch set),
but they do not affect the result.

Hope that helps.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


Return-Path: <bpf+bounces-75682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A08AAC90F18
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 07:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53D2A4E6E3D
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 06:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E832D5926;
	Fri, 28 Nov 2025 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YVpucs6x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0A2D3ED2;
	Fri, 28 Nov 2025 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764311245; cv=none; b=nVZTMb/kVJBgRBR2jTDnAF7EKXoyimEm51JVmtVR+IiS2Pdqs5rTsb2IAAujk3SpSi9jpyHH7mPlTInNlwuU7yYxGg7hGylr1c1skv6rJRNDE6JFZeskhHTP3FpsMBHrINFUpS9W2+tle6g1GQa+dq/KiYJEeZcXnj7F/cYXPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764311245; c=relaxed/simple;
	bh=aggvr88xXdemp691MmwM3WjDvjYxmVZArKmDb3ErPbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgtyIMAHrOzXSN0qjEa+t0i5Xc5Z3/VwatX3/VNngJ2zhOkYgPYmcU7oAy8X8fcQ+UAwkqIe4U5X9WIoaIm0/Cf/tCHxJGY9k9PJ/EPSX5F8p3O9vGTxCG+TEUVMr+/M7fOll2PnZMz22CWVqxBZnCo4avsCg965UlgcfvI3Y5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YVpucs6x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS6Egwb024341;
	Fri, 28 Nov 2025 06:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/nVNds
	U8yIG76653XuRsx3j2nJNqhB/jnt1wQ5iajQc=; b=YVpucs6xTBk0VFsr+FIN+t
	NNwQ/UnXBSe97nxMjTHG6CX0PqbNF/2eVGfuAV4AqT85QrfZTYMKzeq7oQH3EdOt
	TXui61YHAKNHTuZzbgoyCHGGC0O+gmJseLKqRaUgZdzrInsHtpFm7+UwyElyNdb5
	qAzyKfm+14JucFNgKDZoC9KKfYRCCaU+XRmPifjpQurHkNpVhMqJOH8lLqEZUWVT
	WsOt//9KM/DXivQ0jfvuS2KdrVcELQWZFz7/VbYokOp8cGB+RGMoVI8OlELyvUNs
	7LSWAW+RC7Ws+jWRdCHP6roPt1wrvRnDNorJNRweUh0H8kmZHYJEyiMuurwP8MHA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pjd49w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 06:27:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AS6RHfd025422;
	Fri, 28 Nov 2025 06:27:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pjd49r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 06:27:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS45oZS016409;
	Fri, 28 Nov 2025 06:27:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0kkgvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 06:27:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AS6RF3P25101042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 06:27:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC6245806C;
	Fri, 28 Nov 2025 06:27:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 069F05806E;
	Fri, 28 Nov 2025 06:27:14 +0000 (GMT)
Received: from [9.61.122.162] (unknown [9.61.122.162])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Nov 2025 06:27:13 +0000 (GMT)
Message-ID: <65e3ff98-4490-413e-a075-c1df8e7b2bd1@linux.ibm.com>
Date: Fri, 28 Nov 2025 11:57:12 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel build failure when CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN
 are enabled
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com>
 <aSgz3h0Ywa6i3gKT@krava> <214308ce-763c-47a8-8719-70564b3ef49c@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <214308ce-763c-47a8-8719-70564b3ef49c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX0ha8Dx+aFTmN
 StBRslKUzwegFjS0TGd2+z7Wwdzu5DQMMPns2Gt5B2upug9nT2nerkY6xvmgTEhliaVxjAQMn3P
 9+o16xrvanhxIGHT0O6gyUuxUD0V46+LirnobLAJfaHym5TZwWPYhp7agwA8S5BMIc8EHc7oU3O
 wZRigbjis0OQ/RLInWRtLoaRtpCQ93ue0dYz+SJKFlqbBP5z5g3EEqigxUKPoOP/6UEoAQDV2pB
 RBnx+5Th3IiOE6e8LgEnp4zKPYcFk4g0ukeD8PxhVj04aAOrrUohjW0tfeCX6cX9h7DaJpuzRDE
 kXPqJkmpARzpLt6rKYcqgStnbwpt35saAI5f7xdw0ShpvQz3R8c15YYhJ5xXQM38iZ11BIVl9ca
 RTIfyWk0wERztHIKOiOMQEZetHVz7Q==
X-Proofpoint-ORIG-GUID: 06pki4VTKN8faDxOKPugZVl8dRkLeJ98
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=692940c6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=2P-_1YrwpTGgQw7qTdIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h7dUo5TFhy0wFr0dJ9cssKQkQzqiSdWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016


Hi Alan,

On 11/27/25 9:06 PM, Alan Maguire wrote:
> On 27/11/2025 11:19, Jiri Olsa wrote:
>> On Wed, Nov 26, 2025 at 03:59:28PM +0530, Nilay Shroff wrote:
>>> Hi,
>>>
>>> I am encountering the following build failures when compiling the kernel source checked out
>>> from the for-6.19/block branch [1]:
>>>
>>>   KSYMS   .tmp_vmlinux2.kallsyms.S
>>>   AS      .tmp_vmlinux2.kallsyms.o
>>>   LD      vmlinux.unstripped
>>>   BTFIDS  vmlinux.unstripped
>>> WARN: multiple IDs found for 'task_struct': 110, 3046 - using 110
>>> WARN: multiple IDs found for 'module': 170, 3055 - using 170
>>> WARN: multiple IDs found for 'file': 697, 3130 - using 697
>>> WARN: multiple IDs found for 'vm_area_struct': 714, 3140 - using 714
>>> WARN: multiple IDs found for 'seq_file': 1060, 3167 - using 1060
>>> WARN: multiple IDs found for 'cgroup': 2355, 3304 - using 2355
>>> WARN: multiple IDs found for 'inode': 553, 3339 - using 553
>>> WARN: multiple IDs found for 'path': 586, 3369 - using 586
>>> WARN: multiple IDs found for 'bpf_prog': 2565, 3640 - using 2565
>>> WARN: multiple IDs found for 'bpf_map': 2657, 3837 - using 2657
>>> WARN: multiple IDs found for 'bpf_link': 2849, 3965 - using 2849
>>> [...]
>>> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>>> make[2]: *** Deleting file 'vmlinux.unstripped'
>>> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
>>> make: *** [Makefile:248: __sub-make] Error 2
>>>
>>>
>>> The build failure appears after commit 42adb2d4ef24 (“fs: Add the __data_racy annotation
>>> to backing_dev_info.ra_pages”) and commit 935a20d1bebf (“block: Remove queue freezing
>>> from several sysfs store callbacks”). However, the root cause does not seem to be specific
>>
>> yep, looks like __data_racy macro that adds 'volatile' to struct member is causing
>> the mismatch during deduplication
>>
>> when you enable KCSAN some objects may opt out from it (via KCSAN_SANITIZE := n or
>> such) and they will be compiled without __SANITIZE_THREAD__ macro defined which means
>> __data_racy will be empty .. and we will get 2 versions of 'struct backing_dev_info'
>> which cascades up to the task_struct and others
>>
>> not sure what's the best solution in here.. could we ignore volatile for
>> the field in the struct during deduplication? 
>>
> 
> Yeah, it seems like a slightly looser form of equivalence matching might be needed.
> The following libbpf change ignores modifiers in type equivalence comparison and 
> resolves the issue for me. It might be too big a hammer though, what do folks think?
> 
> From 160fb6610d75d3cdc38a9729cc17875a302a7189 Mon Sep 17 00:00:00 2001
> From: Alan Maguire <alan.maguire@oracle.com>
> Date: Thu, 27 Nov 2025 15:22:04 +0000
> Subject: [RFC bpf-next] libbpf: BTF dedup should ignore modifiers in type
>  equivalence checks
> 
> We see identical type problems in [1] as a result of an occasionally
> applied volatile modifier to kernel data structures. Such things can
> result from different header include patterns, explicit Makefile
> rules etc.  As a result consider types with modifiers (const, volatile,
> restrict, type tag) as equivalent for dedup equivalence testing purposes.
> 
> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
> 
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index e5003885bda8..384194a6cdae 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4678,12 +4678,10 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>  	cand_kind = btf_kind(cand_type);
>  	canon_kind = btf_kind(canon_type);
>  
> -	if (cand_type->name_off != canon_type->name_off)
> -		return 0;
> -
>  	/* FWD <--> STRUCT/UNION equivalence check, if enabled */
> -	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
> -	    && cand_kind != canon_kind) {
> +	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD) &&
> +	    cand_type->name_off == canon_type->name_off &&
> +	    cand_kind != canon_kind) {
>  		__u16 real_kind;
>  		__u16 fwd_kind;
>  
> @@ -4700,7 +4698,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>  		return fwd_kind == real_kind;
>  	}
>  
> -	if (cand_kind != canon_kind)
> +	/*
> +	 * Types are considered equivalent if modifiers (const, volatile,
> +	 * restrict, type tag) are present for one but not the other.
> +	 */
> +	if (cand_kind != canon_kind) {
> +		__u32 next_cand_id = cand_id;
> +		__u32 next_canon_id = canon_id;
> +
> +		if (btf_is_mod(cand_type))
> +			next_cand_id = cand_type->type;
> +		if (btf_is_mod(canon_type))
> +			next_canon_id = canon_type->type;
> +		if (cand_id == next_cand_id && canon_id == next_canon_id)
> +			return 0;
> +		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
> +	}
> +
> +	if (cand_type->name_off != canon_type->name_off)
>  		return 0;
>  
>  	switch (cand_kind) {

Thanks for your patch! I just applied it on my tree and rebuild the 
tree. However I am still seeing the same compilation warnings. I am
using the latest for-6.19/block branch[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-6.19/block 

Thanks,
--Nilay



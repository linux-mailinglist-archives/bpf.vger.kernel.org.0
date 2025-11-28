Return-Path: <bpf+bounces-75693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F3C917FA
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 10:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C91CD34BD18
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7092C305E2D;
	Fri, 28 Nov 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eP238gG8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00A306492;
	Fri, 28 Nov 2025 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323111; cv=none; b=BV9c+n4RyeR7z06LI7yCP5yY/diWTORWsw7I09zDw09CdCYNfuWFVQkQo4yYa/WKQ6MqmY4Xu1UGKFBriVCU7zAbuhSbxmOdLMW+DciR6ksTaLaPDHUWKqPPOa/77VeWf9L/SQXQdSZb5fJiDgte6wE9gE824boOVsea0Eg7/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323111; c=relaxed/simple;
	bh=rmK8MaU5xKNSTc66rTBPZdQu7x0Q8BXPYZSWB0SO3y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+zRtNV4OmuwYDfijjEn3d3oYN7wcBhziL0ndo+E4pQUPnnK3eOAtNhcVdVwUXRD+GEHJOzp+ML6P1UpE9MYVQn5v7hRMEH2Z0q37iJ8A7G+H151J42WjXH9u19PlfmIYIz/dwheCTYgCsqd2F9dSxN68dKZ7STh5hqNoJj54/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eP238gG8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS8cpJe010989;
	Fri, 28 Nov 2025 09:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i9qSgL
	FEn1PJ7UTShfcratoUnA+Vt+3cE0k52U7ryOs=; b=eP238gG8QfljIikL5X2EM1
	x4j4STJasfcHQjyzlMg3xFuCOqbcnNRZ+tB57O246NPjCNa7HYKCvqfynZmH6KEV
	7IA6vp8zlNWyDy6R0+yNHH+iDRcooR1fbc3C2WDeAEfdzOUtcZp1AXRHP83N1h+T
	DQNLtUo3nZXeBalE5yL4vVmKqUMk4cPBh25uZspiRG5hKYstJy03ZMQKam3JYot5
	5bhlBZfVRAqcHhUcI7RGDRKdFVgbjG5eLLbbewdXCKDzaGP27Pw3assxJPKscHvR
	Et/6XL3WwmMx2LerEaRgU5MdDOzQMmLHa/bTBv9TJPMoaTLtw75THIqWVI+nDV7Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9wqwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:45:03 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AS9j3Kv011108;
	Fri, 28 Nov 2025 09:45:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9wqwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:45:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS7uvUk000831;
	Fri, 28 Nov 2025 09:45:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvycdbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:45:01 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AS9j1Qp43909482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 09:45:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D87458059;
	Fri, 28 Nov 2025 09:45:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1EB05805B;
	Fri, 28 Nov 2025 09:44:59 +0000 (GMT)
Received: from [9.61.122.162] (unknown [9.61.122.162])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Nov 2025 09:44:59 +0000 (GMT)
Message-ID: <6e326cbf-2f19-4619-aa27-3e8b72835b03@linux.ibm.com>
Date: Fri, 28 Nov 2025 15:14:58 +0530
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
 <65e3ff98-4490-413e-a075-c1df8e7b2bd1@linux.ibm.com>
 <a9643691-f456-4414-a13f-a50abf1ac8b4@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a9643691-f456-4414-a13f-a50abf1ac8b4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX2yKjykrERnki
 mVVQt8xsKIZf54p9Oib6pbqhLEGabHJB05gjCiUQc4M8pSrMWOOpKJyM7w0JEiEAPHZofcaM9Xh
 AfoeZprpNES+jWWI2AuoL/UgjsESpGrUQUygpzKuJO/iLOGH+NRXIte87z4Yx7HSVR2VeumOAzL
 Sn54xydFxWV2BILT3ABRDaZnEoTRcQg5NUJ2yWJKlau05m5W5GdTCRMkaBn8GrwWC1excXphBs9
 NhgqYe/8KZrN3FIHQeUAHooXQ9bkrz+EKDxdTZx0JCnKTyposFI4W6K4/HoFsVzuOx6zNseNvUC
 YbFCEYMXob8QVXZvK80OscDKWaZhVoIwAl+gxq6eodcW+TsYpvX4IWKD30MNl/yiSmfXFdVCwiS
 fJ2R335AmUwgz7DR+WLwVUGttjvsKw==
X-Proofpoint-ORIG-GUID: 9Rq8V7FFGK70suPbJD_o94mjVVVXmVbB
X-Proofpoint-GUID: iCy5q_o9XRVzPKsK7RnagxGLw1XwhPX2
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=69296f1f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=UoiQlHMdomGLu2Lrzl0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021



On 11/28/25 1:23 PM, Alan Maguire wrote:
> On 28/11/2025 06:27, Nilay Shroff wrote:
>>
>> Hi Alan,
>>
>> On 11/27/25 9:06 PM, Alan Maguire wrote:
>>> On 27/11/2025 11:19, Jiri Olsa wrote:
>>>> On Wed, Nov 26, 2025 at 03:59:28PM +0530, Nilay Shroff wrote:
>>>>> Hi,
>>>>>
>>>>> I am encountering the following build failures when compiling the kernel source checked out
>>>>> from the for-6.19/block branch [1]:
>>>>>
>>>>>   KSYMS   .tmp_vmlinux2.kallsyms.S
>>>>>   AS      .tmp_vmlinux2.kallsyms.o
>>>>>   LD      vmlinux.unstripped
>>>>>   BTFIDS  vmlinux.unstripped
>>>>> WARN: multiple IDs found for 'task_struct': 110, 3046 - using 110
>>>>> WARN: multiple IDs found for 'module': 170, 3055 - using 170
>>>>> WARN: multiple IDs found for 'file': 697, 3130 - using 697
>>>>> WARN: multiple IDs found for 'vm_area_struct': 714, 3140 - using 714
>>>>> WARN: multiple IDs found for 'seq_file': 1060, 3167 - using 1060
>>>>> WARN: multiple IDs found for 'cgroup': 2355, 3304 - using 2355
>>>>> WARN: multiple IDs found for 'inode': 553, 3339 - using 553
>>>>> WARN: multiple IDs found for 'path': 586, 3369 - using 586
>>>>> WARN: multiple IDs found for 'bpf_prog': 2565, 3640 - using 2565
>>>>> WARN: multiple IDs found for 'bpf_map': 2657, 3837 - using 2657
>>>>> WARN: multiple IDs found for 'bpf_link': 2849, 3965 - using 2849
>>>>> [...]
>>>>> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>>>>> make[2]: *** Deleting file 'vmlinux.unstripped'
>>>>> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
>>>>> make: *** [Makefile:248: __sub-make] Error 2
>>>>>
>>>>>
>>>>> The build failure appears after commit 42adb2d4ef24 (“fs: Add the __data_racy annotation
>>>>> to backing_dev_info.ra_pages”) and commit 935a20d1bebf (“block: Remove queue freezing
>>>>> from several sysfs store callbacks”). However, the root cause does not seem to be specific
>>>>
>>>> yep, looks like __data_racy macro that adds 'volatile' to struct member is causing
>>>> the mismatch during deduplication
>>>>
>>>> when you enable KCSAN some objects may opt out from it (via KCSAN_SANITIZE := n or
>>>> such) and they will be compiled without __SANITIZE_THREAD__ macro defined which means
>>>> __data_racy will be empty .. and we will get 2 versions of 'struct backing_dev_info'
>>>> which cascades up to the task_struct and others
>>>>
>>>> not sure what's the best solution in here.. could we ignore volatile for
>>>> the field in the struct during deduplication? 
>>>>
>>>
>>> Yeah, it seems like a slightly looser form of equivalence matching might be needed.
>>> The following libbpf change ignores modifiers in type equivalence comparison and 
>>> resolves the issue for me. It might be too big a hammer though, what do folks think?
>>>
>>> From 160fb6610d75d3cdc38a9729cc17875a302a7189 Mon Sep 17 00:00:00 2001
>>> From: Alan Maguire <alan.maguire@oracle.com>
>>> Date: Thu, 27 Nov 2025 15:22:04 +0000
>>> Subject: [RFC bpf-next] libbpf: BTF dedup should ignore modifiers in type
>>>  equivalence checks
>>>
>>> We see identical type problems in [1] as a result of an occasionally
>>> applied volatile modifier to kernel data structures. Such things can
>>> result from different header include patterns, explicit Makefile
>>> rules etc.  As a result consider types with modifiers (const, volatile,
>>> restrict, type tag) as equivalent for dedup equivalence testing purposes.
>>>
>>> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
>>>
>>> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>>  tools/lib/bpf/btf.c | 27 +++++++++++++++++++++------
>>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index e5003885bda8..384194a6cdae 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
>>> @@ -4678,12 +4678,10 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>>  	cand_kind = btf_kind(cand_type);
>>>  	canon_kind = btf_kind(canon_type);
>>>  
>>> -	if (cand_type->name_off != canon_type->name_off)
>>> -		return 0;
>>> -
>>>  	/* FWD <--> STRUCT/UNION equivalence check, if enabled */
>>> -	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
>>> -	    && cand_kind != canon_kind) {
>>> +	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD) &&
>>> +	    cand_type->name_off == canon_type->name_off &&
>>> +	    cand_kind != canon_kind) {
>>>  		__u16 real_kind;
>>>  		__u16 fwd_kind;
>>>  
>>> @@ -4700,7 +4698,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>>  		return fwd_kind == real_kind;
>>>  	}
>>>  
>>> -	if (cand_kind != canon_kind)
>>> +	/*
>>> +	 * Types are considered equivalent if modifiers (const, volatile,
>>> +	 * restrict, type tag) are present for one but not the other.
>>> +	 */
>>> +	if (cand_kind != canon_kind) {
>>> +		__u32 next_cand_id = cand_id;
>>> +		__u32 next_canon_id = canon_id;
>>> +
>>> +		if (btf_is_mod(cand_type))
>>> +			next_cand_id = cand_type->type;
>>> +		if (btf_is_mod(canon_type))
>>> +			next_canon_id = canon_type->type;
>>> +		if (cand_id == next_cand_id && canon_id == next_canon_id)
>>> +			return 0;
>>> +		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
>>> +	}
>>> +
>>> +	if (cand_type->name_off != canon_type->name_off)
>>>  		return 0;
>>>  
>>>  	switch (cand_kind) {
>>
>> Thanks for your patch! I just applied it on my tree and rebuild the 
>> tree. However I am still seeing the same compilation warnings. I am
>> using the latest for-6.19/block branch[1].
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-6.19/block 
>>
> 
> hi Nilay,
> 
> The tricky part with testing this is ensure that pahole is using the updated libbpf 
> rather than just the kernel itself. Did you  "make install" the modified libbpf and 
> ensure that pahole was using it by building pahole with the cmake option 
> -DLIBBPF_EMBEDDED=OFF ? That's the easiest way to ensure the change makes it into pahole; 
> you can check shared library usage using  "ldd /usr/local/bin/pahole". The other option 
> is to apply the change to the embedded libbpf in the lib/bpf directory in pahole.
> 
> I tested the for-6.19/block branch with your config before and after making the
> above change and applying it to pahole and things woorked. If that's doable from your
> side that would be great. Thanks!
> 
Thanks Alan! And obviously I didn't updated pahole using patched libbpf. Now I have 
just updated pahole which uses the your patched libbpf. With this change, I confirmed
that your patch fixes this compilation warnings for me. 

# which pahole
/usr/local/bin/pahole

# ldd /usr/local/bin/pahole | grep libbpf
	libbpf.so.1 => /usr/local/lib64/libbpf.so.1 (0x00007fffa2fc0000)

With this test, please feel free to add,

Acked-by: Nilay Shroff<nilay@linux.ibm.com>



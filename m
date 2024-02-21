Return-Path: <bpf+bounces-22354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6293485CD34
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9841F237C0
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64E21FBF;
	Wed, 21 Feb 2024 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="eKfkw5/k"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6917D5
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477373; cv=none; b=l+MVfU6sZWwf5q5edw5JO/Ahl8EZ/W12+GATbEQ5i8+FJhBCorhrW9XFwb78CwaTf1Sdl1NmY176h+qb21weIiG4TFL4TLv2rb5PM6tEtVWLjUv1o8DABZTIRHAvEVD2vlNQwPYazLA22GSpfSbZnoOWVSsJAPNlh8Xjc5MAQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477373; c=relaxed/simple;
	bh=vteEZjMOkKUDtcMuJwOAhkGa3c3ls+5EIIo7zsBpvns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I158qrsKLA/JDHW8JTagcP+nE8GPcXNhffv2mS9vslL0RYmRhdpZPOHqUA8zqBzYJQ2o9gR35YU92s/N3tlA3B3Pz0B9HCV/GdlCJKA/KZrbl6d2MMW7e/m/GEGySEGwoXgokE1c/Xg6XDMLRrX01ngOWS3TUwZbFcp1S2jjTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=eKfkw5/k; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L0gg2I027336;
	Wed, 21 Feb 2024 01:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=weASN+FemywF0dmsGN2wuTMcsedQ2suLr4JofulVrJo=; b=eKfkw5/kn6Gs
	S3nG6xVkq+yOH6GnYSCvZmCJNmlB7auzZipxR5b2k+IWeBLjRFJUwSqaFeikFO8u
	UyMnWYiR/4RiW+EwwNsptzul/Mra9pMimptR3li+jGlyFtV7nUK+vjNMs8DdTD7H
	YayyfYjZXIGz5AI0mjcEf/QdKGaTBULuX4mSIVPx6nV3xhuwBa+WAKmRxMtlYd7p
	mHD5WplLYizQII4GOcqMUKLM/SyqatXre9EFopjapm0UFRU4yLqdtyhE/E73PEMO
	M2eHyqpcwk3sKtshuI4166OUvapv3y9nxZYT4xBKd0rot2zd/tarOEwFWlc3vzds
	ZOJS6Xlqow==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3wd21t8kqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 01:02:30 +0000 (GMT)
Received: from [10.82.58.119] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 21 Feb
 2024 01:02:28 +0000
Message-ID: <5293d90d-7bed-40e6-9f53-7524a9877fd5@crowdstrike.com>
Date: Tue, 20 Feb 2024 17:02:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Memory corruption in out_batch parameter of batch lookup APIs
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <1f98a10d-9fd7-4a0c-baa8-be31c1e78fa8@crowdstrike.com>
 <0aa59bdf-b443-4a56-bdec-368c958c9629@linux.dev>
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <0aa59bdf-b443-4a56-bdec-368c958c9629@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: 04WPEXCH12.crowdstrike.sys (10.100.11.116) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: 2VwKC-jBt7D0D5stseHBlZlMG1ZTZq6V
X-Proofpoint-GUID: 2VwKC-jBt7D0D5stseHBlZlMG1ZTZq6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=658 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210006

On 2/19/24 17:22, Yonghong Song wrote:
>
> On 2/16/24 4:24 PM, Martin Kelly wrote:
>> Hi, I noticed there's a subtlety to to the batch APIs 
>> (bpf_map_lookup_batch and bpf_map_lookup_and_delete_batch) that can 
>> lead to bugs if callers are not careful, and I'm wondering about the 
>> best way to document or address it.
>>
>> Specifically, the size of the data pointed to by in_batch/out_batch 
>> is not clear, and if it's too small, the caller can see memory/stack 
>> corruption. The function documentation isn't super clear about this, 
>> calling in_batch "address of the first element in batch to read", so 
>> a caller might reasonably assume that a pointer size is fine. 
>> However, the right size actually depends on the map type.
>>
>> For hash and array maps, out_batch will be u32 (as the parameter is 
>> used as an index). But for LPM trie, it will be the size of the key 
>> (in the case of LPM trie, I think that's 260 bytes). If a caller 
>> passes a pointer to memory smaller the key size, the kernel will 
>> overwrite past that memory and corrupt the stack (or wherever 
>> out_batch points). This is because of the copy_to_user(uobatch, 
>> prev_key, map->key_size) at the end of generic_map_lookup_batch.
>>
>> It seems to me that we could add documentation to these functions 
>> indicating that out_batch should be able to hold at least one key to 
>> be safe. This is simple but overly strict (at the moment) for all map 
>> types other than LPM trie. However, if we specifically call out LPM 
>> trie as needing key-sized width while other map types need 4 bytes, 
>> then this documentation could easily become out-of-date as new map 
>> types are added.
>>
>> We could alternatively add a statement like "out_batch should 
>> generally point to memory large enough to hold a single key, but for 
>> some map implementations a smaller type is possible". This gives more 
>> information but might be too vague for many API users, and it means 
>> future kernels could be tied to this implementation to avoid breaking 
>> users.
>>
>> Any thoughts/preferences on how best to handle this? I'm happy to 
>> send a patch clarifying the documentation, but I'd like to get a 
>> general consensus on the best way to proceed first.
>
> For in_batch/out_batch, the only exception is hashmap which has 
> in_batch/out_batch memory size to be 32.
> For all other supported maps, in_batch/out_batch memory size should be 
> equal to their corresponding key size.
> Maybe you can clarify this in include/uapi/linux/bpf.h?
>
> We can update the documentation later if there are any exceptions to 
> the above rule.
That sounds reasonable; I sent a patch for this. Thanks!
>
>>
>> Thanks,
>>
>> Martin
>>


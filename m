Return-Path: <bpf+bounces-22196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B145C858C08
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 01:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BFF2833AE
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 00:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715EF4C8F;
	Sat, 17 Feb 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KQ/Sdues"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117C4C91
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131115; cv=none; b=COFrD0ZGIZVD1mS6fYcA/vdyOI1OC57GrwutjbcTsLRTmValMXRXe/9V7b1YvJBNEdMDKOVk1pH+q5GN02j8REnKlY8YGyrCWsIyh3nFgf22UQm2e0Xu7Iehfu5iTsoCSaXCmks0hpSRLw2pNoZFE1thu+bITTKAS+Gr8ZQUTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131115; c=relaxed/simple;
	bh=YGlOqnv0UTpqTRqQpulA3pm4qa8rnyr4nv9KbfiLYTI=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=PYA057736BgSeHC7lt7dZi1m/PKFKdEBFzTxSRq0hJWzEmjKfemvRjXLs1iT+jsrnXizOBxjpqCRdG4NsddLrRXEFP0GvAWXHW1EzJW69shbSrytae+nOMG8rKX8HJHu5i8p3gJ5E9n+PtjeXd9GAuRCQUTc62vv5f1f7p/Ytw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KQ/Sdues; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GMITlX004236;
	Sat, 17 Feb 2024 00:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:to:cc:from:subject:content-type
	:content-transfer-encoding; s=default; bh=gPLDkcVy/8DeTfrk1oQa2M
	VhXgrqJ20n4xtBbEN4fGw=; b=KQ/SduesDlGDHZrq59QTm64gC2mf696oTtS644
	m96TvmTDXpurAFs/0g72adrnRxpsHM8uHwkKBRzT3dgvjUz9IUKNTerps60RhXIm
	qHXFnVWS34RShEsB+qGBbmpoT9DjeCvgo75HDW5bHJ3E5Lzn5/ZC1rIWFM3EMj65
	u6zGZq/nXZh1QCLTsuzN2ThgjBReW9X9wXBQZedJ9gV+fMSNWJZpl3/EfOQ7FGK6
	hd+WNdPWuDzYAgzytDUQQuBjYQO1zX+j5ayYIkbYdlMFRJOI+hMrPUzCfPr8XEV9
	0pN3bjxNExk3HmJy/VtBvsrS/sopp76gHo+5GaXY12qMrSJg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3wagcqg5sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:24:51 +0000 (GMT)
Received: from [10.82.58.117] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Sat, 17 Feb
 2024 00:24:50 +0000
Message-ID: <1f98a10d-9fd7-4a0c-baa8-be31c1e78fa8@crowdstrike.com>
Date: Fri, 16 Feb 2024 16:24:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song
	<yonghong.song@linux.dev>
From: Martin Kelly <martin.kelly@crowdstrike.com>
Subject: Memory corruption in out_batch parameter of batch lookup APIs
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: 04WPEXCH12.crowdstrike.sys (10.100.11.116) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: JjwHLh3VKoYf93RD4MDD-9yCZDqSAirB
X-Proofpoint-ORIG-GUID: JjwHLh3VKoYf93RD4MDD-9yCZDqSAirB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1011 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=262 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402170000

Hi, I noticed there's a subtlety to to the batch APIs 
(bpf_map_lookup_batch and bpf_map_lookup_and_delete_batch) that can lead 
to bugs if callers are not careful, and I'm wondering about the best way 
to document or address it.

Specifically, the size of the data pointed to by in_batch/out_batch is 
not clear, and if it's too small, the caller can see memory/stack 
corruption. The function documentation isn't super clear about this, 
calling in_batch "address of the first element in batch to read", so a 
caller might reasonably assume that a pointer size is fine. However, the 
right size actually depends on the map type.

For hash and array maps, out_batch will be u32 (as the parameter is used 
as an index). But for LPM trie, it will be the size of the key (in the 
case of LPM trie, I think that's 260 bytes). If a caller passes a 
pointer to memory smaller the key size, the kernel will overwrite past 
that memory and corrupt the stack (or wherever out_batch points). This 
is because of the copy_to_user(uobatch, prev_key, map->key_size) at the 
end of generic_map_lookup_batch.

It seems to me that we could add documentation to these functions 
indicating that out_batch should be able to hold at least one key to be 
safe. This is simple but overly strict (at the moment) for all map types 
other than LPM trie. However, if we specifically call out LPM trie as 
needing key-sized width while other map types need 4 bytes, then this 
documentation could easily become out-of-date as new map types are added.

We could alternatively add a statement like "out_batch should generally 
point to memory large enough to hold a single key, but for some map 
implementations a smaller type is possible". This gives more information 
but might be too vague for many API users, and it means future kernels 
could be tied to this implementation to avoid breaking users.

Any thoughts/preferences on how best to handle this? I'm happy to send a 
patch clarifying the documentation, but I'd like to get a general 
consensus on the best way to proceed first.

Thanks,

Martin



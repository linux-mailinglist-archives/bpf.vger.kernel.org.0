Return-Path: <bpf+bounces-72305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E48C0CE7C
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ECC19A316D
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B322F3C1A;
	Mon, 27 Oct 2025 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rTOPVYaH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9E481B1;
	Mon, 27 Oct 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560102; cv=none; b=pNzGz+/xOEF2ehdxhcNOaCzvfGzx86iy7VXXVV5dk6VM3X/T57V2ilFKg3Q5Wj3Oj6MT5Nwwc6h2GDa/ujIfgQ71Kng4jbQtF2QTGvOqYg/RO730jCYslDa+1P3WH2PBfH3G0R+AQtqXi0sK5aL4kIk7HCAkDy7N+5qaZh6kK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560102; c=relaxed/simple;
	bh=YxD/X+Zkz5NAxSDIV78g1kUEZbNuMcFdoxtofLlVpWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUkW3EElp6vb4xkIhxnbw1ryCyh8iGWfHBInGGBhs6NH0QSx5eU0pU6EsYYtOijz/XOvYJ/k9X+zCuQLGJcoPFfdyMCEpbe5k61/Ls0q+Uutl0nWknfBRSzOJvqzH4cHf0XK0u0iu370Cglmb7AbRrvWilkelPLF6gXyDZD2Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rTOPVYaH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QJEFTd026055;
	Mon, 27 Oct 2025 10:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rWBDg1fyrFQM4Iw+1y1rcnG/tHO8KV
	uI29ViOAB18wo=; b=rTOPVYaHMCmt307F50YAOucrUvwc0JUpLCAyNMYL8xUr2r
	rnNQ1UIDkCMcABGQXNVg6k5qPHn40SxaNxdGP3B4IAn0uRMYmxdfBJUHH0ri1YWh
	q7bKpuqPYQLH2mPDSUj0DiLQjy1kZUGuKgvkxonlYQsG3uyjM/a/PFqMQ7XDe2C9
	i8huDCOUdaqWYidaic+sd9FLfdpYyCv9VNTbd3KI5HORwkXiS0BVSJOicN1GdouG
	I3Y3u1n08wDYkUnMI+BLngDGBN04lxxXrt7xL9tddrVzU/oQs6dwnsTQskqK7J7f
	Rv4gWLgMm5D2SHZEE4xuwQrQ1fu4fBof3EVIRBgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p98x6qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 10:14:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RA67s2004845;
	Mon, 27 Oct 2025 10:14:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p98x6qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 10:14:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R7eV70030460;
	Mon, 27 Oct 2025 10:14:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a1acjmxgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 10:14:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RAEraG59638056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 10:14:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A13020043;
	Mon, 27 Oct 2025 10:14:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDA320040;
	Mon, 27 Oct 2025 10:14:53 +0000 (GMT)
Received: from osiris (unknown [9.111.14.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Oct 2025 10:14:52 +0000 (GMT)
Date: Mon, 27 Oct 2025 11:14:51 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Fix memory leak in add_marker() when kvrealloc
 fails
Message-ID: <20251027101451.14551A49-hca@linux.ibm.com>
References: <20251026091351.36275-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026091351.36275-1-linmq006@gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=68ff4623 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=jc1liYX81a5ejJq0xPAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: nqp_ljURjxT5ZWM6dC13yGjre5M5eLG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX9xedVJW1l3eK
 pJxCjmXAlXe18IdzuCBgVrB/y+gQuw2Tjm6OLlSRNCoRqhIBSIN7iPDI+rraP7LIQ4TZOvVNYU9
 D6WaCRBGslLeUPz1TBH7KYoGPYkREZaN59RAcIVozYlmDO0XDvLg8wrD+dSlkkQQ9v5DWX62Tus
 rr1aKCd6IBNWS5NQ+Xfo05KER8TiA3s3fno2lKwjysfljaDEjz744ynHo1gN8rsjgQNQNx030ug
 5ih1Di/y1uFBT/zMzhu+FKhEoBxhpssS6sEmTac7rfWeuhlYUGBasuqZR7YWlj8rijA2alkA+yl
 6pEvarZQnRVzUQ5SRsr+pz0ucfqoIPMdb7rmnuUFqQFxTFcXNi5o+JmHTLiTr7WuVrb8yAQavYh
 rykhvSVJhoxv16WkEZzTkiX/fH3zNQ==
X-Proofpoint-ORIG-GUID: xxSUkK-B4XJutQ9f-DCOJClNhNQBOaok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019

On Sun, Oct 26, 2025 at 05:13:51PM +0800, Miaoqian Lin wrote:
> When kvrealloc() fails, the original markers memory is leaked
> because the function directly assigns the NULL to the markers pointer,
> losing the reference to the original memory.
> 
> As a result, the kvfree() in pt_dump_init() ends up freeing NULL instead
> of the previously allocated memory.
> 
> Fix this by using a temporary variable to store kvrealloc()'s return
> value and only update the markers pointer on success.
> 
> Found via static anlaysis and this is similar to commit 42378a9ca553
> ("bpf, verifier: Fix memory leak in array reallocation for stack state")
> 
> Fixes: d0e7915d2ad3 ("s390/mm/ptdump: Generate address marker array dynamically")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  arch/s390/mm/dump_pagetables.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
> index 9af2aae0a515..0f2e0c93a1e0 100644
> --- a/arch/s390/mm/dump_pagetables.c
> +++ b/arch/s390/mm/dump_pagetables.c
> @@ -291,16 +291,19 @@ static int ptdump_cmp(const void *a, const void *b)
>  
>  static int add_marker(unsigned long start, unsigned long end, const char *name)
>  {
> +	struct addr_marker *new_markers;
>  	size_t oldsize, newsize;
>  
>  	oldsize = markers_cnt * sizeof(*markers);
>  	newsize = oldsize + 2 * sizeof(*markers);
>  	if (!oldsize)
> -		markers = kvmalloc(newsize, GFP_KERNEL);
> +		new_markers = kvmalloc(newsize, GFP_KERNEL);
>  	else
> -		markers = kvrealloc(markers, newsize, GFP_KERNEL);
> -	if (!markers)
> +		new_markers = kvrealloc(markers, newsize, GFP_KERNEL);
> +	if (!new_markers)
>  		goto error;
> +
> +	markers = new_markers;

This is not better to the situation before. If the allocation fails,
markers_cnt will be set to zero, but the old valid markers pointer will stay,
which means that the next call to add_marker() will allocate a new area via
kvmalloc() instead of kvrealloc(), and thus leaking the old area too.

add_marker() needs to changes to return in a manner that both marker and
marker_cnt correlate with each other. And I guess it is also easily possible
to get rid of the two different allocation paths.

Care to send a new version?


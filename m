Return-Path: <bpf+bounces-72345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F85C0EF5E
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 16:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30FB189C7DD
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B713F30B512;
	Mon, 27 Oct 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hp/F1YYs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02030B51C;
	Mon, 27 Oct 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578871; cv=none; b=jwyxjCDsv8q1oXEdHDLtlI79QVIhX5y06+9GsFiTcpGD/irhRqooqdddJnGehTVnCSejEVXWMTucv5yU460vUU0YJDsKCsbGaNDfaIbrijbBg7SKsH7ZzQGfJvUFH+I+munjWIo1pxKqu017EpDHqymYAiITAih82R9kr0kGfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578871; c=relaxed/simple;
	bh=pC9WNtnSdSWvIcqNoa/8q9bz1yev4yl3OAHJhURI6mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drwuG6cab25y4KVJe+u30s1FjHIjeK/KPCDYYCso5x/uDQovT+Nnve2EG4ZlaD4WYbHwlFncphxVBFnh37HjObBzYIZgCTO+sRnlFC9PzXZUWLoobWBjCskcfW1F6QMT8XtiJMY4MZxgg4lWg12/5u9lAbO/oh9ngEARQ5U70RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hp/F1YYs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCE9hR012355;
	Mon, 27 Oct 2025 15:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0hnTkGhW0Qu058vS20Ne+nFknI24pW
	Wq3ScsTj/z+C0=; b=hp/F1YYs2aaOJyUE342YIMD6X+5E1AMCDSf5lJmmIJiG3s
	wz+QtEduGVhjAjcLj1DB5Hh20i/BOmXr0RxS1BpoPzwMeJpLvrWI0KVl9kUkmvBQ
	cANa+hh7bPRdC++7eKUcMtwAJmCstMOJdEWQLw1NB8TyGRg7lWKUJofgdufSplIy
	2IYypNcRYDbNUg7eE4VoFlLK5OqwmA/Pf1RqLNBN63dfjheRdKHZ7z5jpyAGQyEH
	3YIkrFMRwpupUo3yKCqCku3Ju1oOgFwP+N1lKUBGyjzTgvZzdNBp0QxfCZS8y30Q
	mYbyoKpXj1ZLKjHqeB4mlTiarNKCWx4lRg1TY/8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81qgst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 15:27:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RFKpAs028083;
	Mon, 27 Oct 2025 15:27:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81qgss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 15:27:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCJu1e009455;
	Mon, 27 Oct 2025 15:27:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3hx1f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 15:27:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RFRhga58393030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 15:27:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE3E20040;
	Mon, 27 Oct 2025 15:27:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1332F20049;
	Mon, 27 Oct 2025 15:27:43 +0000 (GMT)
Received: from osiris (unknown [9.111.14.160])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Oct 2025 15:27:42 +0000 (GMT)
Date: Mon, 27 Oct 2025 16:27:41 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] s390/mm: Fix memory leak in add_marker() when
 kvrealloc fails
Message-ID: <20251027152741.14551Cb6-hca@linux.ibm.com>
References: <20251027150838.59571-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027150838.59571-1-linmq006@gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=68ff8f74 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=-osUowgCyyGCssfuuIAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3bfZjd2b8lXVWE895fk64jtP7NO2KNgJ
X-Proofpoint-GUID: 93eD7qV39UhLruIR2aycUZm5zOSMRVHt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX4EftPELcSSqI
 IhJ97fNiRA3d09vl7aon1ewDS6RABH7IF1Ge0CphRCx5JRANBYufNAez7phsDjqzn4QoU0Enf31
 UtOmv20r9+7U1fUZV5uDR5uZj6VZX1uLzT3waN3l9MSnY61DTQE37af29f+kPlKDCl+KVELfIZd
 2VjJUaRVmBIyW4w/2blg3YyNpOr1erULdap99fyvsxTPjDHo7xwNDIne/5S/umItXYampdJntNZ
 NzypgHBN4RVSAnFcHvUhlIASxQcI5UoojNbpXKbp5SmB4OyWX7JZHIp+lNUIwQ0BXrgGNFOxgjv
 jZmhyyED8jTa1jZHZTpwrVwyHfY7eN+sCVstXm+v1jnhR/q0L6SAN9kp/a/X7tOsO/i2aIlLjik
 ZGQCLUo6UFqYcMtqSvWHzQI95439ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

On Mon, Oct 27, 2025 at 11:08:38PM +0800, Miaoqian Lin wrote:
> The function has a memory leak when kvrealloc() fails.
> The function directly assigns NULL to the markers pointer, losing the
> reference to the previously allocated memory. This causes kvfree() in
> pt_dump_init() to free NULL instead of the leaked memory.
> 
> Fix by:
> 1. Using kvrealloc() uniformly for all allocations
> 2. Using a temporary variable to preserve the original pointer until
>    allocation succeeds
> 3. Removing the error path that sets markers_cnt=0 to keep
>    consistency between markers and markers_cnt
> 
> Found via static analysis and this is similar to commit 42378a9ca553
> ("bpf, verifier: Fix memory leak in array reallocation for stack state")
> 
> Fixes: d0e7915d2ad3 ("s390/mm/ptdump: Generate address marker array dynamically")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - update the fixing logic to prevent memory leak in v1
> v1 link: https://lore.kernel.org/all/20251026091351.36275-1-linmq006@gmail.com/
> ---
>  arch/s390/mm/dump_pagetables.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

Applied, thanks!


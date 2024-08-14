Return-Path: <bpf+bounces-37199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C695218F
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 19:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D41B2267B
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC471BD002;
	Wed, 14 Aug 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o67juqC5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0625566A;
	Wed, 14 Aug 2024 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658019; cv=none; b=clL83cz+9jDltnQzNdJuVaX0HwJsiC2BCS9YLE7yANxWvEfkYDxdxpUnUezQH6eeVBWKNo7l0YinFpLTJ0wqRdoprXlyj4yfH4pm6FYG38lfxoxvBWkpeTwTvVtvxxCv666AGfLiVA0vBYER+L3mig9dPjx1dm4pUKxt6+UNGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658019; c=relaxed/simple;
	bh=2ybLVtCV1/kO2hv/JMHjvOYI0ECqeYuEkrijvApHlr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=do9sC7u5xzi4AiYkjydNHPNS+2FBqITq5WMy0PGvxJ+M5pxDEP4ylk4FyD0/hbCRFrMkNo0T1SBXtlYdoOJOjfYlbQKeJJH6A73Ee5hh8j0tXDWAG04ZrLKm9vu2gqWq8fjFYvNxpn1Vt5qiA3kxZ5qbgllV+4Tsq6Quw2Ch+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o67juqC5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ECdsgF012235;
	Wed, 14 Aug 2024 17:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=VJGhFyFauLQ99Y9vG/DkccTFoaI
	OYdrDqdQSPndjCaA=; b=o67juqC5Wu81t+NGqniYuG4sklS/1Ut/zOwAcIRSMjl
	mmC6ghVcTY813t/+7ZF5nZ7RBE3qI03efZgvX+NE7YCWZ59ymCriQy8F2t3KX7p5
	oiYKwfxkfGPPSkxmHH9XT4zYcDrXcZ1H1JeDUgMjMFATIvUJHSgNv9AVXca1apYF
	kubvdWCNzBFghLXvYjCwKB23To5+iaDjWtQnfg4UrCkqvVqWN4y4np7Ud2+M8nRu
	4xGr7gcJzbFN0+HOEUe+b6Rx5X8aqhRRVC+Ne/+c0J61qjKr/nd/SeIQ6EQPcPCW
	MX7lXGfb+Ecw6I9EbHj1CpOcfj7HnnyFmNRwj/BItcg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410vs9herw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:53:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47EHrOOq008854;
	Wed, 14 Aug 2024 17:53:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410vs9heru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:53:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47EGCj2G011537;
	Wed, 14 Aug 2024 17:53:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhuav1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:53:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47EHrJoC39977282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 17:53:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A18C420040;
	Wed, 14 Aug 2024 17:53:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 236262004D;
	Wed, 14 Aug 2024 17:53:19 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.11.33])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Aug 2024 17:53:19 +0000 (GMT)
Date: Wed, 14 Aug 2024 19:53:17 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Brian Norris <briannorris@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        bpf@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] tools build: Provide consistent build options for fixdep
Message-ID: <ZrzvDb+gitYx3KLL@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240814173021.3726785-1-agordeev@linux.ibm.com>
 <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M5hUmiOR8tV2v40q9ra5WstkLcjCDFSU
X-Proofpoint-GUID: jwIB9OdDaO_KFx0sJnzaoCfWG6JKfIjY
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_13,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 mlxlogscore=278 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140120

On Wed, Aug 14, 2024 at 10:35:00AM -0700, Brian Norris wrote:

Hi Brian,

> FWIW, I already fielded some reports about this, and proposed a very
> similar (but not identical) fix:
> 
> https://lore.kernel.org/lkml/20240814030436.2022155-1-briannorris@chromium.org/
> 
> Frankly, I wasn't sure about HOSTxxFLAGS vs KBUILD_HOSTxxFLAGS -- and
> that's the difference between yours and mine. If yours works, that
> looks like the cleaner solution. So:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> Either way, it might be good to also include some of these tags if
> this is committed:
> 
> Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info/
> Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")

Ah, I missed the issue was reported already - I would include these tags otherwise.

@Thorsten, would it be possible to test this fix?

Thanks!

> Brian


Return-Path: <bpf+bounces-72316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED519C0D9E1
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75199424875
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0F230EF63;
	Mon, 27 Oct 2025 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="So6ofpc6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D467302175;
	Mon, 27 Oct 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568271; cv=none; b=pUxfVlzuPZ8g+aZEhtTM0EX+QTUsIV2tdIOWuWCdTbMldHjIUaWCSistkfBFiB0IDEDUy7OuRj1HXqnCT4DIqEhnlPHRxPV2qpjOhxLWAclpbywGhwD7+B0SxC9WU/aExoFkz9caVk0I4gXNMS8W9jeG9FpID1Qh9NyXo4lPwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568271; c=relaxed/simple;
	bh=N1qUqzb6sWCHSENbFH0IY+Nh8541jhVc/Kc40tZkvVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKeFld2E53SzpcsIyMHWOXm0bnXnn+uLSgxLhFYEvwHGSrFKneJ7ghMXTm4dF5LTmDPws8r1Z03EWAg5PjYBAeZVha+oWHFGalUuLsCDok7AXbuaMKQx0f/DsD5DViS+sBzsq3n1cjGnWyyYo84LONHhjJVmEjM3vHcK8e3tGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=So6ofpc6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QNNL3u029083;
	Mon, 27 Oct 2025 12:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8XrKnD
	wj4oNyu1HUMAaa68ADo18BeSPNHlFHuvEDgkk=; b=So6ofpc6fu6D8JBj73LK5h
	5a+8+qc7OoKsAzsM184SwyqzUOyYXL8POaaexIavMIE/kV9ziw+ZcEkOeLEBgmrt
	HmbVaWTJsO8ir0JgwXfKQec8ix5JxmlS+0X7IVhIpdo58MHjZzQbGRMIYOKF0uS+
	Zlk6PKqEd5HbHX+bNOnAbSfWO6534gX3uXypxDMlAoWJ3PUxYUs9q6tb0fXCKVuu
	vFn0L/WFxkYZCcPW17LvkUNzlPbgv1YcRuEBG0JMjniiOMBIec4ZLa5MbLUlxcZs
	gsub8XW7qSjPaTJQw6HKGbbdddesCq+2OpHkb7ZZwRR8enyvEeFsGgKrrQVljwMA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p71xkpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 12:31:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RCV6Id006693;
	Mon, 27 Oct 2025 12:31:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p71xkpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 12:31:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RBbLBI030075;
	Mon, 27 Oct 2025 12:31:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a19vmdgp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 12:31:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RCV2xs48890148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:31:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C71420043;
	Mon, 27 Oct 2025 12:31:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85BD420040;
	Mon, 27 Oct 2025 12:31:01 +0000 (GMT)
Received: from osiris (unknown [9.111.14.160])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Oct 2025 12:31:01 +0000 (GMT)
Date: Mon, 27 Oct 2025 13:31:00 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: =?utf-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Fix memory leak in add_marker() when kvrealloc
 fails
Message-ID: <20251027123100.14551Baf-hca@linux.ibm.com>
References: <20251026091351.36275-1-linmq006@gmail.com>
 <20251027101451.14551A49-hca@linux.ibm.com>
 <CAH-r-ZG8vP=6qH42ew26BMBL9dRB3OtLUeFmMmKXzp1tnKvkxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-r-ZG8vP=6qH42ew26BMBL9dRB3OtLUeFmMmKXzp1tnKvkxQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VO-zx9XU0hA8UAYqFYmJ7uqt13i-1Wci
X-Proofpoint-ORIG-GUID: iLDS38quJOu7SdOkRh7_13uqWHOe7lMG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX5sfy4dx9ueyl
 xpDb3igovQBb9hgiYDY62WoOFO6AT5N+09zXbZ8SIWdaN2vbXVbDNPS+qM4kJvB/AUjg8gxshNk
 JAPGM4J8hqzeEEYGCUgyTw+TaNCuhbHFOmvEkkUZf3Pi9aKBQM+hxCDyJNQH/z4OFSZe+K0KRGp
 u89l6DQoEEI1LqDIyZfx1+KLGBMFNrJcaWZdPrf9x4ojO1ZlrfJepML5VjnF7UfxiVoOkbmGCpM
 vt3qMopt1k+EeNoowd5KTIq3zAFM2RtC3FqO/3dGNxVCaoCRo5rqlcm8VbDWkCeRWR0zHG2Oedl
 z67y7YM8oN0jCwFeEIoAKviU9N8hVMFLdLSRzat3je64PyPQDjvQVRV2tTLI0x25ZTP+pvACe5I
 ogRM3X5PEGJ7ivTg7WZCGYiWIg6MRQ==
X-Authority-Analysis: v=2.4 cv=G/gR0tk5 c=1 sm=1 tr=0 ts=68ff660b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_FfYkpI_G82BVqFellkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

On Mon, Oct 27, 2025 at 07:53:25PM +0800, 林妙倩 wrote:
> > Care to send a new version?
> 
> I'm not sure if I can make it right.
> Do you think this way can fix the leak correctly? Thanks.
> 
> ```diff
> static int add_marker(unsigned long start, unsigned long end, const char *name)
>  {
> -       size_t oldsize, newsize;
> -
> -       oldsize = markers_cnt * sizeof(*markers);
> -       newsize = oldsize + 2 * sizeof(*markers);
> -       if (!oldsize)
> -               markers = kvmalloc(newsize, GFP_KERNEL);
> -       else
> -               markers = kvrealloc(markers, newsize, GFP_KERNEL);
> -       if (!markers)
> -               goto error;
> +       struct addr_marker *new_markers;
> +       size_t newsize;
> +
> +       newsize = (markers_cnt + 2) * sizeof(*markers);
> +       new_markers = kvrealloc(markers, newsize, GFP_KERNEL);
> +       if (!new_markers)
> +               return -ENOMEM;
> +
> +       markers = new_markers;
>         markers[markers_cnt].is_start = 1;
>         markers[markers_cnt].start_address = start;
>         markers[markers_cnt].size = end - start;
> @@ -312,9 +311,6 @@ static int add_marker(unsigned long start,
> unsigned long end, const char *name)
>         markers[markers_cnt].name = name;
>         markers_cnt++;
>         return 0;
> -error:
> -       markers_cnt = 0;
> -       return -ENOMEM;
>  }

Not exactly what I had in mind, but this looks good too.
Could you send a proper second version of your patch, please?

Thanks!


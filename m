Return-Path: <bpf+bounces-57849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F2AB1307
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B984A1BC6225
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB628FFF0;
	Fri,  9 May 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DvAaN53H"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DC2343AB;
	Fri,  9 May 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792612; cv=none; b=K5jnRdrQhLwiaUgfDo7xkpmumhraipKKmDp0+il98u3aYSQmTf3Q3N+o9VL0eBuix4C/5Qa9D/9gxQ1cXnVOsyia9ZLwKppSIyEha7wdm/x5uCKgTZM7GFvwl01Kp40SahMle5Nzh7wcs3bn58sTs0O4+gCkK2l49df90/pKD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792612; c=relaxed/simple;
	bh=SOI76tgCUJ+Y11Q+7lolXSJLZXVccVKHAsH+Rzp5Fmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo4zIAcNE9tTy5GQOIz2GLYFh4On8vJFhwlb2PFHreEWjudu9rfvwd/BwcuWg6Ck6a3MJITiZCe1HOAkyzdCPxE2a/lxgtq5/NS2C1pqk6VgYeM+aQ/v4rGsMY30GayLIG6k5b/jEN6q8j4QtaUzUXfwpfnlZazGkQVBLTakQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DvAaN53H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AeqmE004095;
	Fri, 9 May 2025 12:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xexgts
	bf4P9VHYi9XNPZsQvdz/8xdMsfQwZ/VbOuKtc=; b=DvAaN53H292fAkTvqGr3fV
	ecLZ0J3XazXXC8WMqPfbuXa6LwK88/BVpIeCXLVdWg5CGHt8FIPkZJ2KLF5gYgrR
	K7rx8Q+ONKutk2WmFb18Vzhi3AacUYPo4dBouM9GVqerJC3cmp4Kog8BN0heBxLt
	ep2ZpI4w5ccoTzGfDVf5uy7Wgtf0oZ1nZkWj86QbIDwHY168zWt6yaKxOGYwEZuJ
	07JKMA6mZiRbZfTgBeHpd3yz5UReWdJPsq87SmTLn9PJIku37JQ9xI+7Nc1H2xFp
	U9BIxl0ZrDwnur9xJ3ydUBbb/rJRxqBLanbnq1OEjEy0V6OgL4hrWBtJETVTlfBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46hg5sgba9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:10:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5498Hw80004235;
	Fri, 9 May 2025 12:10:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2fvev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:10:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549CA5QA27984552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 12:10:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A2EE20177;
	Fri,  9 May 2025 12:10:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 586ED20175;
	Fri,  9 May 2025 12:10:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.107.211])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 May 2025 12:10:03 +0000 (GMT)
Date: Fri, 9 May 2025 17:40:00 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [linux-next] selftests/bpf fails to build
Message-ID: <aB3wmPosqkyNL749@linux.ibm.com>
References: <e915da49-2b9a-4c4c-a34f-877f378129f6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e915da49-2b9a-4c4c-a34f-877f378129f6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Em6hpMnRa8qdkjwAjzKbdYktNcGTY6o5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExOCBTYWx0ZWRfX0K4MPA0LLCcf MpPCeQCkDKphxF0p/Q4kiK8hhqrSpXO+4Jo3wWoG30CxSzk0WSIuQbNsX8105Ekpj4t30Gt2S+7 05yLhRQZcURDRalwNnnZlnSgddKEJ4XbFsyH7LUs+prOmgonuaXGhw/h/xiDRKqwAktxfIqmM62
 XomM0cXXWa8WNsI52ME1W/yIOSsToSz4MjURiEmLVSAj0rb8rV5xKGxSYYseRH/G/heVrYAHzX0 nIGKspz2Ea9sHdQnA5D+oYamsWT+0HQ0TRc6TktsnSJVH4Sz6sgkkdqvh8hGSilhRYYyZSEItSD nQaHleMRgV9DFzE126j/ESDUT6VqyzPb4QHaM8nK6jO3iOChOkaZEaYfyx6OFOc3UoCrN6ZltPP
 T4ulmIIn+IQ8ozr8TmYKCwHdellS1dNB4QgdnMi6SdU7+g25+PjAt+JpeNce3SMMKa5aFnTO
X-Proofpoint-ORIG-GUID: Em6hpMnRa8qdkjwAjzKbdYktNcGTY6o5
X-Authority-Analysis: v=2.4 cv=NrjRc9dJ c=1 sm=1 tr=0 ts=681df0a1 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=A-zPWIDjgNZkkrHnjKoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=729 malwarescore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090118

On Fri, May 09, 2025 at 05:32:51PM +0530, Venkat Rao Bagalkote wrote:
> Hello,
> 
> 
> I am observing selftests/bpf fails to build on the next-20250508 kernel.
> 
> 
> Errors:
> 
> 
>  GEN
> /root/linux-next/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
> bpf_testmod.c:494:17: error: initialization of 'ssize_t (*)(struct file *,
> struct kobject *, const struct bin_attribute *, char *, loff_t,  size_t)'
> {aka 'long int (*)(struct file *, struct kobject *, const struct
> bin_attribute *, char *, long long int,  long unsigned int)'} from
> incompatible pointer type 'ssize_t (*)(struct file *, struct kobject *,
> struct bin_attribute *, char *, loff_t, size_t)' {aka 'long int (*)(struct
> file *, struct kobject *, struct bin_attribute *, char *, long long int, 
> long unsigned int)'} [-Wincompatible-pointer-types]
>   494 |         .read = bpf_testmod_test_read,
>       |                 ^~~~~~~~~~~~~~~~~~~~~
> bpf_testmod.c:494:17: note: (near initialization for
> 'bin_attr_bpf_testmod_file.read')
> bpf_testmod.c:495:18: error: initialization of 'ssize_t (*)(struct file *,
> struct kobject *, const struct bin_attribute *, char *, loff_t,  size_t)'
> {aka 'long int (*)(struct file *, struct kobject *, const struct
> bin_attribute *, char *, long long int,  long unsigned int)'} from
> incompatible pointer type 'ssize_t (*)(struct file *, struct kobject *,
> struct bin_attribute *, char *, loff_t, size_t)' {aka 'long int (*)(struct
> file *, struct kobject *, struct bin_attribute *, char *, long long int, 
> long unsigned int)'} [-Wincompatible-pointer-types]
>   495 |         .write = bpf_testmod_test_write,
>       |                  ^~~~~~~~~~~~~~~~~~~~~~
> bpf_testmod.c:495:18: note: (near initialization for
> 'bin_attr_bpf_testmod_file.write')
> make[4]: *** [/root/linux-next/scripts/Makefile.build:203: bpf_testmod.o]
> Error 1
> make[3]: *** [/root/linux-next/Makefile:2009: .] Error 2
> make[2]: *** [Makefile:248: __sub-make] Error 2
> make[1]: *** [Makefile:18: all] Error 2
> make: *** [Makefile:282: test_kmods/bpf_testmod.ko] Error 2
> make: *** Waiting for unfinished jobs...
> 
> 
> If you happen to fix this, please add below tag.
> 
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> 
> 
> Regards,
> 
> Venkat.
> 
Hi Venkat, thanks for reporting this. This is due to Commit 
97d06802d10a ("sysfs: constify bin_attribute argument of bin_attribute::read/write()")
that changed the required type for struct bin_attribute to const struct bin_attribute.

Will send out a patch to fix this, shortly.

Thanks,
Saket


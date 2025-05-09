Return-Path: <bpf+bounces-57852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28FAB13B7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC07A23AF9
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1F291176;
	Fri,  9 May 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J8q8Vb3D"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FD291157;
	Fri,  9 May 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794720; cv=none; b=UBsfHQGWnPd+zF7eI0Gk+MSqjHMHmYn8QtQzoAdf4a3lZyu7tR9Wv6OBGFiDT3C9RphliMVfu2nze15Mnx36BqnIcbP/NLPgKNuVDGhX4/sB+CKYpmTiVvj5WGtRAAQJ9+r7kuObaBNLbyJz9NyuybviR25AKapqbrWZE7QHuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794720; c=relaxed/simple;
	bh=BKBlIPRSeUyGxnT8243TNn9ON4PZ2d/rVn9Qpr+/YTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEpj6Ghbnytv0plRaoak6Dum4B0XWrNqc5ZV8u1fwYHa6gh5Xl800PbQ0lUdZ0Rujvgt78S8MXokZNFKIQjs8QJB4Vtc8pG8vvIaRZ3bHwH/4oFRAqRr7X9I4xP132RsR41cbZJd1m1FupOqVhaqgEPPHssYrbXXk4wYZH40dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J8q8Vb3D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494BviB017154;
	Fri, 9 May 2025 12:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xP9Vs2
	7fdO3qCwq3XfEIE0V2SkGM89IPn3wz9QVdXEI=; b=J8q8Vb3D5AQDZYygntj/gZ
	FSBf1uzOTTmqRjISzQ4/+lQxpC7ecTpzwnGK22RgZR7ZVKpVPPNzpyWgf/aRX99E
	m/YIJ5y+TY2axu0UogY38YsQZNEWcafXRMqQ66k9A1FBgEpzOqWsirRx9bjq2tGi
	FgV8DmYB9NrYrgHioKglMqL5aIqWwjuZ+XZMB5HpVI1OZe60DXo4jpanE5douoMw
	5U68LEcLR0S4HRKbQMxBX614I3536YQscP/CbSZjoBiFlI5kIOPzHEE2AT1nxVK+
	b+V9FnZBBzZs+go5v8iDjBY8XNlcpCS/aoGuCVT3X7zFEXhcRbkPST75OuzNtsOw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h46kutq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:45:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549AkYOh013765;
	Fri, 9 May 2025 12:45:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062tyxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:45:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549CjD1N54133126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 12:45:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 457112008C;
	Fri,  9 May 2025 12:45:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 605472008B;
	Fri,  9 May 2025 12:45:11 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.107.211])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 May 2025 12:45:11 +0000 (GMT)
Date: Fri, 9 May 2025 18:15:08 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [linux-next][selftests/bpf] Kernel ABI header at
 'tools/include/uapi/linux/if_xdp.h'
Message-ID: <aB341KkxXB+gu3IV@linux.ibm.com>
References: <c2bc466d-dff2-4d0d-a797-9af7f676c065@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2bc466d-dff2-4d0d-a797-9af7f676c065@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LaM86ifi c=1 sm=1 tr=0 ts=681df8de cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=6tX_wsqJ8x3pxrqpp-wA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEyMyBTYWx0ZWRfX81B0S1uOUU60 IMgosEkj7L4zjh6/vBOnluXnhveb4o4sC78XL/zJ+bqB/pBGm/T47WMkmLhP/JnLqOwHyjO4ISN 4jcJxx0Ft3WtbgckGPplvKSDpgfIcbFMC3P5tvD5mJkFmK9YuYLCnlwzuxU2x5FJ8X5CHFJ/+Z7
 /pc9G+zVG3qjnpnTRPO1IKa/5aPu0zih2PKv1O0Q7cC3Ez26eVk9SwvCQt0kyXuzYxm2FIZQqSj wtQirTupWJ7IB0tcDosBdTbUH7BNAw3oKl94Jby0tdItk7TTjZJ73JTmq7qhg5prbBwQRoapNn8 tyS6xTd4lyGq6wry+71tWvw5gLlwxUH8IMhZRLfUokvczDGJXsm7EUFEeOAOQCtreaS61d3GOgJ
 0URVECPmKRAaSm1iPwS80EpbuCik9v/VQtbdO6CLqyUJ7MWVWZLHt2uC9BEBtheYP31kLdRB
X-Proofpoint-ORIG-GUID: gzCnkb2gXhegTp_tdTnth2Z8poKHT3q7
X-Proofpoint-GUID: gzCnkb2gXhegTp_tdTnth2Z8poKHT3q7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_05,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090123

On Fri, May 09, 2025 at 05:38:12PM +0530, Venkat Rao Bagalkote wrote:
> Hello,
> 
> 
> I am observing build warnings. while compiling selftests/bpf on
> the next-20250508 repo.
> 
> 
> Warnings:
> 
> 
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h'
> differs from latest version at 'include/uapi/linux/if_xdp.h'
> 
> 
> Auto-detecting system features:
> ...                                    llvm: [ on  ]
> 
>   MKDIR    libbpf
>   TEST-HDR [test_progs] tests.h
>   MKDIR    bpftool
>   MKDIR    include
>   MKDIR    no_alu32
>   MKDIR    cpuv4
>   TEST-HDR [test_maps] tests.h
>   MKDIR    resolve_btfids
>   LIB      liburandom_read.so
>   SIGN-FILE sign-file
>   BINARY   uprobe_multi
>   MKDIR
>   GEN /root/linux-next/tools/testing/selftests/bpf/bpf-helpers.rst
>   GEN /root/linux-next/tools/testing/selftests/bpf/bpf-syscall.rst
>   GEN /root/linux-next/tools/testing/selftests/bpf/tools/build/libbpf/bpf_helper_defs.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/btf.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_legacy.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_tracing.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_endian.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/skel_internal.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_version.h
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/usdt.bpf.h
>   GEN /root/linux-next/tools/testing/selftests/bpf/bpf-syscall.2
>   GEN /root/linux-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.pc
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h'
> differs from latest version at 'include/uapi/linux/if_xdp.h'
>   INSTALL /root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h
>   INSTALL libbpf_headers
>   BINARY   urandom_read
>   CC      /root/linux-next/tools/test
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
Thanks for reporting it Venkat. I have sent the potential fix to https://lore.kernel.org/all/20250509123802.695574-1-skb99@linux.ibm.com/

Thanks,
Saket


Return-Path: <bpf+bounces-74403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C509C577FC
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D52194E3A10
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85016350283;
	Thu, 13 Nov 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E0+2eENc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68943147;
	Thu, 13 Nov 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038596; cv=none; b=Gxle2huMNKNJARUVkqzg14v9xdgKrbCJPaxMZb9cp40Kvf7gjPMhzodV1K7RGEQdk5smZqHhH6bfdFQhOMHOivfCYupV3/GSIbdoU/keERoYnjIgTsujjXor/vmH/MFyuOPPIIREobnGgtfMl93DGATAB0bttx8GEXOZD/OKvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038596; c=relaxed/simple;
	bh=6iLaX1uwSWP549WWhCDwf6ekwCC7AoPgs8LfdQdyzSQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FoG+EE3+Kt4Zb9BTrZi53T49HRGe102ipjh6i+QWa+932x4spKODGjt3XDZiOb8tFuGtuxtDu7/SsBW5dHZodMHQBRuAN0U2LfwgBUlaeuRajE9OUd6PRrZAZQJKtsr1ohbtDWBGcHmbbK2L8pC1QsF+4bXqp/cbBqx6rGKrLQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E0+2eENc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9HjjF011435;
	Thu, 13 Nov 2025 12:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=3X8CCaLW76Ahvp3eD38iFDDlBtSA
	wPU/aluCflQI3EQ=; b=E0+2eENcmsjH2FFhGiwbE+38MoAC6Sm8u7IIqpRrNPo/
	fWifVSBzJYU3CH4A1mCKPSridMHI2FnQaNta//zDPIhzWFENsJE8HZ+QTwRzCW9e
	Lr+cSgppjiCcZ3gRTDM8+ioIMY1tZLm7QUe5G0/9SSDMSlMLCvCp6gvtMubqYfFp
	48DPS8GKs1JFWgvNxI2VGbmvkcPgL7eEFbT/UUEtwiFTOSmZvMdiDG3yp2QatTFe
	wzMRPWgENQuY3q/8V9KkOz8TNuPcpXngW8hBF4M3LyY/nx88F4D8aYWjuu+xRURZ
	SIKMBd3qOOgZvjNOXxJVNkudCiU0BgIhhn+o2mr5xg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk5abm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 12:56:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9FF2L011738;
	Thu, 13 Nov 2025 12:56:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1nh1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 12:56:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADCuVIs32965302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 12:56:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C74858056;
	Thu, 13 Nov 2025 12:56:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 093BC5803F;
	Thu, 13 Nov 2025 12:56:30 +0000 (GMT)
Received: from [9.61.246.65] (unknown [9.61.246.65])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 12:56:29 +0000 (GMT)
Message-ID: <42b38c7b-78c7-4cbd-9082-3039a0d9afb7@linux.ibm.com>
Date: Thu, 13 Nov 2025 18:26:28 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [next-20251111]selftest/bpf fails to compile
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: San7gDwFfP_vObxAF7_VMefektj--79R
X-Proofpoint-ORIG-GUID: San7gDwFfP_vObxAF7_VMefektj--79R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfXzd+B2ZHu/RSd
 EHzwvN15doyM6c/zNehDzFAt+h8bgoW1RfA7nMphlxpmjQUCHb1RHxdQmEdKLqmsZkhTgrr87zd
 iCtWv0lnIfoqJ+zOWwAM/cVe3/7lxhP2vpO6ZsPl+Z3JW2toFsozNMaPLDgvH6zdcJao0PI1PsR
 fnxmx2mT/y9Jcy8h7DJZRwOCpXeg6aVFx8a7hkhmOhn6OVKBJtEKNgZugtIzfOAET0mk+YM9MDo
 T39gUtRBfUWMXPEnm/fQyhGmrEWaYqlhRGFSdShrO2FX7VM8/0qn/RfSus2g2MIjaOWOJvAFR0S
 xGCSuKHgJWRkOARrQOdNTw/GPAW0PhN3Bbyzc0RnQviGK38BOxQ57gR1ZZ51J5zH3H2nC8j4ObU
 coN7DwbuP/GnnFDbvLjxmMtVhCoO4g==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=6915d581 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jgwLNZEmTTdDHIAjbjMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

Greetings!!!


IBM CI has reported sefltests/bpf fails to compile with below error.


Error:

/home/upstreamci/linux/tools/testing/selftests/bpf/tools/build/runqslower/vmlinux.h:64131:3: 
warning: declaration does not declare anything [-Wmissing-declarations]
  64131 |                 struct ns_tree;
        |                 ^~~~~~~~~~~~~~
   CLNG-BPF [test_progs] bpf_iter_sockmap.bpf.o
   CLNG-BPF [test_progs] bpf_iter_netlink.bpf.o
   CLNG-BPF [test_progs] bpf_iter_setsockopt_unix.bpf.o
In file included from progs/arena_list.c:4:
/home/upstreamci/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h:64131:3: 
error: declaration does not declare anything 
[-Werror,-Wmissing-declarations]
  64131 |                 struct ns_tree;
        |                 ^~~~~~~~~~~~~~
In file included from progs/async_stack_depth.c:2:
/home/upstreamci/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h:64131:3: 
error: declaration does not declare anything 
[-Werror,-Wmissing-declarations]
  64131 |                 struct ns_tree;
        |                 ^~~~~~~~~~~~~~
In file included from   CLNG-BPF [test_progs] bpf_iter_task_btf.bpf.o
   CLNG-BPF [test_progs] bpf_iter_task_file.bpf.o
progs/arena_htab.c:4:


clang -v
clang version 20.1.8 (Fedora 20.1.8-4.fc42)
Target: ppc64le-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/ppc64le-redhat-linux-gnu-clang.cfg
System configuration file directory: /etc/clang/
Found candidate GCC installation: 
/usr/bin/../lib/gcc/ppc64le-redhat-linux/15
Selected GCC installation: /usr/bin/../lib/gcc/ppc64le-redhat-linux/15
Candidate multilib: .;@m64
Selected multilib: .;@m64



If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.




Return-Path: <bpf+bounces-57847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0CAB12DD
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80E33B182A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21688227E93;
	Fri,  9 May 2025 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ABgFU3Cr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B21A2C3A;
	Fri,  9 May 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792179; cv=none; b=Shzw/f3Jm4q4YxtulBxyk7d3auPTw1nFWXldC+Edao86UL+ti1dN4nihJiY/PZyVFXx0Z/DzFNldYaHWhpcqDEddrDm8t2V8qC/rAw2wc18whFItQiD6aFrrKIMDAmIvMOFO3akoQ3tpUiIRZyK5jyzcrk6I4MYloQenWam55Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792179; c=relaxed/simple;
	bh=TEjmLWYYwV/nTVrOiRCpk9gnNwUvCnNzr8AjJV9NE8E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Lfo5RAUYK2Hn6n9EXUvUbc/tVxChpJrpnk/owAHIKEpfRy4wgefdfuPUDySexPIsHVPqQu2wgkI/6zQOn/8j7rKJZVxw1My3gxBFk6t+FIKsK1reIv90EcabFxjZ7YF0rWHEq595IBy1Mka1OVh2QeslfcBBfdW8racWjKJCQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ABgFU3Cr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494BvfK017154;
	Fri, 9 May 2025 12:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=P9sZGyUfNx0YjqIwOq1Bz2LWCsXR
	UXKcoVXW3xyy7yo=; b=ABgFU3CrAjohi8vud+SVr9RDiwFEqV4zIMI8fPa40xMH
	XnNXbtS+l9+wI1r4seCP4/FTlrI+sRy/DprNec8ZzNyEirmhh5Zo1IDOQ4D814os
	kJfLEBF90ZgconhcIHKJRF9yHpxM1GCmO5DNQ5aq2ulhSQscNPhQ5XKAtn+XKS2R
	2ew+wGLfZow9D6Y82WXTg/SWoB1mm6RWpl0pja44UIJhK8wyRF3Vzk9w04hx/YR2
	hDtkHsafg5Oh/WOwamSheRwu5Tig9luEfmlsKDm9I78HQzH8dwaK+veRKqVX1vek
	MlsH05lLY7WFXxioyuNyXNS890ZfbXBHEKZfrs2uoQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h46kunn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:02:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549BSQdw025813;
	Fri, 9 May 2025 12:02:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv0bbau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:02:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549C2sgO31064616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 12:02:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A86558056;
	Fri,  9 May 2025 12:02:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD3C558052;
	Fri,  9 May 2025 12:02:52 +0000 (GMT)
Received: from [9.61.252.85] (unknown [9.61.252.85])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 12:02:52 +0000 (GMT)
Message-ID: <e915da49-2b9a-4c4c-a34f-877f378129f6@linux.ibm.com>
Date: Fri, 9 May 2025 17:32:51 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next] selftests/bpf fails to build
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LaM86ifi c=1 sm=1 tr=0 ts=681deef1 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=hYazVKBAQXenT-wLadAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExMiBTYWx0ZWRfX0o+1leHYRIXO A1zyQ3hHXYrQsXbVXByG6FDLwKSmmvnvFH5ottcbpe4AYrj8gKHSRfHc0iYQS0s7xy00irbLucK lRhEG4vX3jn1C1BrNs/uJzVr/bqqJUTFgv9e3VuPgKKSqB/ctA7Q/nAsC1FmNrp/H/yZdD9nuVE
 r4C2bNlNnal5VqxP+h9juoJZszE5pXWP2Z0lXDC1L8/pwuUbaJ0XULkIzb1Lse8GeBiUUw7DCnd eNXr2/G4k2GFEbnnviwDx3ORdS0e2m3DiW7z8cjvT2bbpoK4youhrTQzv0A5jazZChdF6Fg/WCc GMSCr4/BskOcGiewCZbCMkKwYtVRQAQV7xvra9/IUaFXi9+XR3ZIbk2hp5kX8eZ6rsV9GuruCf/
 jX5z0b6xhCGLhbQSKmpqZbFnf9haw0x5RaW2dlfEbcoYxDIb16LXsfg65Do9zRJUbRIZB7F2
X-Proofpoint-ORIG-GUID: x4ZB-YWuU63WvHuILBRZip-YGHjdk0cp
X-Proofpoint-GUID: x4ZB-YWuU63WvHuILBRZip-YGHjdk0cp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 mlxlogscore=799 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090112

Hello,


I am observing selftests/bpf fails to build on the next-20250508 kernel.


Errors:


  GEN 
/root/linux-next/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
bpf_testmod.c:494:17: error: initialization of 'ssize_t (*)(struct file 
*, struct kobject *, const struct bin_attribute *, char *, loff_t,  
size_t)' {aka 'long int (*)(struct file *, struct kobject *, const 
struct bin_attribute *, char *, long long int,  long unsigned int)'} 
from incompatible pointer type 'ssize_t (*)(struct file *, struct 
kobject *, struct bin_attribute *, char *, loff_t, size_t)' {aka 'long 
int (*)(struct file *, struct kobject *, struct bin_attribute *, char *, 
long long int,  long unsigned int)'} [-Wincompatible-pointer-types]
   494 |         .read = bpf_testmod_test_read,
       |                 ^~~~~~~~~~~~~~~~~~~~~
bpf_testmod.c:494:17: note: (near initialization for 
'bin_attr_bpf_testmod_file.read')
bpf_testmod.c:495:18: error: initialization of 'ssize_t (*)(struct file 
*, struct kobject *, const struct bin_attribute *, char *, loff_t,  
size_t)' {aka 'long int (*)(struct file *, struct kobject *, const 
struct bin_attribute *, char *, long long int,  long unsigned int)'} 
from incompatible pointer type 'ssize_t (*)(struct file *, struct 
kobject *, struct bin_attribute *, char *, loff_t, size_t)' {aka 'long 
int (*)(struct file *, struct kobject *, struct bin_attribute *, char *, 
long long int,  long unsigned int)'} [-Wincompatible-pointer-types]
   495 |         .write = bpf_testmod_test_write,
       |                  ^~~~~~~~~~~~~~~~~~~~~~
bpf_testmod.c:495:18: note: (near initialization for 
'bin_attr_bpf_testmod_file.write')
make[4]: *** [/root/linux-next/scripts/Makefile.build:203: 
bpf_testmod.o] Error 1
make[3]: *** [/root/linux-next/Makefile:2009: .] Error 2
make[2]: *** [Makefile:248: __sub-make] Error 2
make[1]: *** [Makefile:18: all] Error 2
make: *** [Makefile:282: test_kmods/bpf_testmod.ko] Error 2
make: *** Waiting for unfinished jobs...


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.



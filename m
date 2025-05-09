Return-Path: <bpf+bounces-57848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93821AB1300
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 14:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01AB1BC5FDF
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8228FFE8;
	Fri,  9 May 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y6SJqc18"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41027A925;
	Fri,  9 May 2025 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792502; cv=none; b=jM64MyjUPsCUOKB8pkxkv9ueCicVgjyv91XmN4h5r+LsfmhLKG3rvFFGe+u7f/CVYSuE3+Vqp91sg1jGZcnh63+3OSoBAPmSnPUoBQIoOBSyYFfJhA5Yxxxa07hzywSrNT9zItYg3DIm5tYTJxj+uEmowSl/Q4f4oCiOIvsQ0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792502; c=relaxed/simple;
	bh=XDXYs3tpmXcTVXsAwUXBNou7v9/YfzjWXgmLvdWwH4M=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LISN7SsZAkemUeR4J29NIXB7QgruPzkcyXAAuR4leXTM0rcInW3neBpsBd92ZTpVh06eWpX9j1mBzqcpbhDuJmyLLdb7CerZGzpEn83xk3rkdbonOSNBfFGrRB8Ih2LW494e+tj48ykYbKkyEoITgpFlqbam3pWr3v+kNeCewiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y6SJqc18; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494BvNp017165;
	Fri, 9 May 2025 12:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=c883UBxizdTfua8u8my4JC5U11lm
	EVico9hdCOvsaWo=; b=Y6SJqc18tlEebS9GlT1pcxlQXHYY6xRhZg9vOSDNxYPq
	pNHYyLRCxNarxuQhXjUbItcYb646E4sUZFrgnSPtIsVg7DLkIbGYfwh1UBrRUlFN
	E522Ie6XwQhmF65DANJ/rmvFHZJb0UfV36ryHmjUy8AzUHUugk6/M2j7fbUepfgC
	tw+3vHRzKxYQdb9igRXn9fiw/jmeTn956nOSWGwU3A0sNKWT7X6zkwywWjRFp5jK
	ypiuV+mkbz/0iyoy8ogEBdhz2xofahSpx6+Te50FuK6N1XEDEcrLtMwHH/IrQ+WS
	Rq1T6hBbfAHStgf2mUmkfzNfpIyHFQ14ol1z+laxJA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h46kupd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:08:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549C4akS001272;
	Fri, 9 May 2025 12:08:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftud1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:08:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549C8H0I3342998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 12:08:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7DA58056;
	Fri,  9 May 2025 12:08:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ADDF58052;
	Fri,  9 May 2025 12:08:14 +0000 (GMT)
Received: from [9.61.252.85] (unknown [9.61.252.85])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 12:08:13 +0000 (GMT)
Message-ID: <c2bc466d-dff2-4d0d-a797-9af7f676c065@linux.ibm.com>
Date: Fri, 9 May 2025 17:38:12 +0530
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
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next][selftests/bpf] Kernel ABI header at
 'tools/include/uapi/linux/if_xdp.h'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LaM86ifi c=1 sm=1 tr=0 ts=681df033 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=3cz_BhZPYtxhozc1ksEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExOCBTYWx0ZWRfXwYLq7L+VwG/O K6ONbNfzdsDsqBtEscEucjKdeCO1FUVnLvIeODa2fahvoyRbu/6GEyN/WEmZR7TOAZgvkF4mAvm IECR83iItxgsrPAr2uvZ7vl1mJ0uLBllzhgPhhiJMa4DkX1vz/ddledeQbEdSkkmWoYSkBqkeUD
 3cd/lMJ89qdPxYtK1DntEoxmX+rutFLyJ7xNLC/AOVSRe/2FQ4XWIh2nnCCH8WGF7K5T5582tzm aapvT4o8pPQBoLdhy486oQ2ILe8E/KcrmBYusXoOptkpQoaUiNMk+cwfqXHg2BQDWCtTs7pKuSX 7nOd8aEcHLL3/HBw8bB+arCFOM+XUlCzUt2PMp0pqsFCd/m6W7H8mjLnUQ3QmTf6f/vWYnqnFR5
 Mjuq6ZOoIM2KNEXPDd0ky+nua7lombDCFxSjyv/Bf2ZA0aI8JtjFL1AdOJP0bD5Vh7Rw08g7
X-Proofpoint-ORIG-GUID: wuVywluifaG7J_6u-fsAaX4NblOulGZW
X-Proofpoint-GUID: wuVywluifaG7J_6u-fsAaX4NblOulGZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090118

Hello,


I am observing build warnings. while compiling selftests/bpf on the 
next-20250508 repo.


Warnings:


Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' 
differs from latest version at 'include/uapi/linux/if_xdp.h'


Auto-detecting system features:
...                                    llvm: [ on  ]

   MKDIR    libbpf
   TEST-HDR [test_progs] tests.h
   MKDIR    bpftool
   MKDIR    include
   MKDIR    no_alu32
   MKDIR    cpuv4
   TEST-HDR [test_maps] tests.h
   MKDIR    resolve_btfids
   LIB      liburandom_read.so
   SIGN-FILE sign-file
   BINARY   uprobe_multi
   MKDIR
   GEN /root/linux-next/tools/testing/selftests/bpf/bpf-helpers.rst
   GEN /root/linux-next/tools/testing/selftests/bpf/bpf-syscall.rst
   GEN 
/root/linux-next/tools/testing/selftests/bpf/tools/build/libbpf/bpf_helper_defs.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/btf.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_legacy.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_tracing.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_endian.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/skel_internal.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_version.h
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/usdt.bpf.h
   GEN /root/linux-next/tools/testing/selftests/bpf/bpf-syscall.2
   GEN 
/root/linux-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.pc
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' 
differs from latest version at 'include/uapi/linux/if_xdp.h'
   INSTALL 
/root/linux-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h
   INSTALL libbpf_headers
   BINARY   urandom_read
   CC      /root/linux-next/tools/test


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.



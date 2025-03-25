Return-Path: <bpf+bounces-54628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F10CA6EDBE
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 11:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26957A1965
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4403025484F;
	Tue, 25 Mar 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MBpKnnhe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768F19EED3;
	Tue, 25 Mar 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898744; cv=none; b=c1Gp0SiVi5i7m5DWvMs11age4w5mc044z5Bpt9WSlLKZO9/TbQsj7ThOpxjzXO4xNG37ym1Lb9nOZ/1BkfubpSo3Qi/GsX2Hxi5Fx1anYI+7vNOLN7N9XVQnJPGoErsCc72lV1SjZshH2BW5qMW4XEGOPs5d2sCFjCv53zlkc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898744; c=relaxed/simple;
	bh=oUvc43xr6WPKRjpfGnFSErNnrJe4V3FbQA2sD2OzZUo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hm5tp+DaT7ldULN4F3qujkJD9qC/hvQ9pX33PFAeiVVW2Znmwx1glGWO1EE+70lve1VvlcD+POpYuMpGfeVKfABov1B537n/5vEVmdgupMFxUNKgEcId1k1wl5aO86Y7Pj1kMlETqmECvupljN81/vT8/YLSBek6DftVR6hkHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MBpKnnhe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P8rFDM011900;
	Tue, 25 Mar 2025 10:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=TDu0Ny0Fcmjl+OCepVqwkzhE+JS6
	jvmII5BtRtgp3Xw=; b=MBpKnnheWBepOp1W3NkAWcv+9Gb1k630RvhptHs0nJNd
	1UJJXSc8yRGxr8XxX7CN59FL/oEAn+uI9A9zim3LeC8TfbI+vQ7+OCBhoD76uAxU
	OCKZMjYzNbrW96JTv68qn2FcmuWp+Y3zsLQS5PNVBRphJeUn2f9cZyb/bhKSdkn0
	g2G3+XNlNqu89PqAlokJuNhFY6sHrjlTcklqsmIOf2RTboe9vxF9RGHQqKOZdazC
	uSO5eJ6aAm1WI/PXQu5LfVk2x7dCxt2y0Rj8aNLkVOUCqMb/mUr9xpGjEkxrsjeQ
	XeeHxim5ceqLyRNtedDX3gSs+ASU+2BprMyJsRi0Ww==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejptytp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 10:32:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P7lM8M030330;
	Tue, 25 Mar 2025 10:32:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htb351-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 10:32:14 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PAWD2j11076112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 10:32:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7B3F58058;
	Tue, 25 Mar 2025 10:32:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2058558059;
	Tue, 25 Mar 2025 10:32:10 +0000 (GMT)
Received: from [9.61.251.51] (unknown [9.61.251.51])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 10:32:09 +0000 (GMT)
Message-ID: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
Date: Tue, 25 Mar 2025 16:02:08 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com,
        williams@redhat.com, tglozar@redhat.com, rostedt@goodmis.org
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next-20250324]/tool/bpf/bpftool fails to complie on
 linux-next-20250324
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: upORWBvozE1TM21JUSyh-tiHSH1YQ4xZ
X-Proofpoint-GUID: upORWBvozE1TM21JUSyh-tiHSH1YQ4xZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=802 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250072

Greetings!!!


bpftool fails to complie on linux-next-20250324 repo.


Error:

make: *** No rule to make target 'bpftool', needed by 
'/home/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h'. Stop.
make: *** Waiting for unfinished jobs.....


Git bisect points to commit: 8a635c3856ddb74ed3fe7c856b271cdfeb65f293 as 
first bad commit.

Bisect log:

git bisect start
# status: waiting for both good and bad commits
# good: [4701f33a10702d5fc577c32434eb62adde0a1ae1] Linux 6.14-rc7
git bisect good 4701f33a10702d5fc577c32434eb62adde0a1ae1
# status: waiting for bad commit, 1 good commit known
# bad: [882a18c2c14fc79adb30fe57a9758283aa20efaa] Add linux-next 
specific files for 20250324
git bisect bad 882a18c2c14fc79adb30fe57a9758283aa20efaa
# good: [36ad536dbad8e29a1fdb7a8760a9c4fcb0dcf7cb] Merge branch 
'for-next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good 36ad536dbad8e29a1fdb7a8760a9c4fcb0dcf7cb
# good: [96c123361d8e32f6012aa449eed27147979af27e] Merge branch 'next' 
of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
git bisect good 96c123361d8e32f6012aa449eed27147979af27e
# bad: [b9fc57d1f74797e7b25c779671c03192a81feb1a] Merge branch 
'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect bad b9fc57d1f74797e7b25c779671c03192a81feb1a
# good: [1da0a3d00734bf365f53480a7ffb4361fd61e6d5] Merge branch 'master' 
of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good 1da0a3d00734bf365f53480a7ffb4361fd61e6d5
# bad: [4541ffab99f8b7ddadb367c73f28ea1fe70f2f97] Merge branch 'next' of 
git://git.kernel.org/pub/scm/virt/kvm/kvm.git
git bisect bad 4541ffab99f8b7ddadb367c73f28ea1fe70f2f97
# good: [361da275e5ce98bbab5f6990d02eb9709742d703] Merge branch 
'kvm-nvmx-and-vm-teardown' into HEAD
git bisect good 361da275e5ce98bbab5f6990d02eb9709742d703
# bad: [28b4c36e59ccfd4e38eaf804b292b3c5b2287900] Merge branch 
'for-next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
git bisect bad 28b4c36e59ccfd4e38eaf804b292b3c5b2287900
# good: [2ec5357274fdbe8d48d13d33a1b0e367bcadb85a] Merge sorttable/for-next
git bisect good 2ec5357274fdbe8d48d13d33a1b0e367bcadb85a
# good: [af1a78613133542583c9a9875c824678a3c3a145] Merge branch 
'edac-drivers' into edac-for-next
git bisect good af1a78613133542583c9a9875c824678a3c3a145
# good: [2325ccf7b99fa8e1e95c3ce8a205e170d244b062] Merge branch 
'edac-for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
git bisect good 2325ccf7b99fa8e1e95c3ce8a205e170d244b062
# bad: [18923806b1291102cad3a6b713006c7e7f563534] rtla/timerlat_top: 
Move divisor to update
git bisect bad 18923806b1291102cad3a6b713006c7e7f563534
# bad: [9dc3766ed07c95c9a77fa98dcbc83dcb7f49df3d] rtla: Add optional 
dependency on BPF tooling
git bisect bad 9dc3766ed07c95c9a77fa98dcbc83dcb7f49df3d
# bad: [8a635c3856ddb74ed3fe7c856b271cdfeb65f293] tools/build: Add 
bpftool-skeletons feature test
git bisect bad 8a635c3856ddb74ed3fe7c856b271cdfeb65f293
# good: [6fa5e3a87cd7838453be66c3a69c2236a1680504] rtla/timerlat: Unify 
params struct
git bisect good 6fa5e3a87cd7838453be66c3a69c2236a1680504
# first bad commit: [8a635c3856ddb74ed3fe7c856b271cdfeb65f293] 
tools/build: Add bpftool-skeletons feature test


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



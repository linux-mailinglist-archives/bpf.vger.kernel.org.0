Return-Path: <bpf+bounces-55627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001C9A837FC
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 06:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044C67B07F7
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 04:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149B1E9B3C;
	Thu, 10 Apr 2025 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WrQDrWVr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3012CD88;
	Thu, 10 Apr 2025 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260475; cv=none; b=I/n6gvYt5gTTxCJrkGLPdmISN6y7V/Hl7t8x/KBKMc2L+koDm1BCKgdX6BBKznWvrnBq7rQVKPfQgCtRmvHDuu7pLo/UDH0jORCuqg94c8o69PjxUGAxWiEqglOOPF6cYm0qCTF9z6Yy5Tq9ijvChMZ9bxuMK9aEsvzW2AaWLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260475; c=relaxed/simple;
	bh=ImpVjHXgjrZBpvshjtWDmi2q0RXPOYfpdTHRT5wuOTI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=QwkyZ0F1qSfoEGe9VR1ClChXy2xUx0TTA3McqqpZfpTSLVd3fzJcgrg3oY4hlR8QxXYx9lfzPyRGhc4C5l9Hx+PzteEjoMA9S7tM2tilPYk7Hqel6nKDjd/RZqpyohqXxgzlJMJ2ocesSezds2AO7CExJsJmN+q9vLZn7AzECzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WrQDrWVr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539MLChH027048;
	Thu, 10 Apr 2025 04:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=E6khEIo9Gu4bRuixWVrZTg4TzKRp
	7UnmB0k/uIt0hs0=; b=WrQDrWVrGZwjZc99yN3LVjCXXlnaN0j+AhdYCft0I3ou
	IbkucdLDia0zMCzN4vMYwFZWqz3rwoQ0CwAKDq0z2pAdyHi9XnER+VUz2LmHL5T8
	icTY0zteDUnCaJ66MbzHBZdtIxxb39X3pxyUKo07gmqT+S7iMJ41w9VPtFMUI7SV
	x2sECNOJp/jnHEPGTA3gXDezYYqapMJZbK3FXICKCzQsNQ1JDhj7lTePal2uggZP
	QRFPEqNyzYf2fsRGvV7gVJ3HjtKj8Npn0VtVlkjsHSHecnC+FU8pfQPjMy8oZEPE
	q0Vp9om6Dvt5UInsTpJdOk/OmE/a+FmQOozy5Z+hzQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq4f0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 04:47:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A39X7T025525;
	Thu, 10 Apr 2025 04:47:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbm3ycw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 04:47:52 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53A4lobO28377752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 04:47:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D1E458059;
	Thu, 10 Apr 2025 04:47:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A92458058;
	Thu, 10 Apr 2025 04:47:48 +0000 (GMT)
Received: from [9.61.249.145] (unknown [9.61.249.145])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 04:47:48 +0000 (GMT)
Message-ID: <c9816983-7162-47e6-8758-2daaa8c8ccc3@linux.ibm.com>
Date: Thu, 10 Apr 2025 10:17:46 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, linux-next@vger.kernel.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, venkat88@linux.ibm.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline]Kernel Warnings at kernel/bpf/syscall.c:3374
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DiwYmELMyof3CbpNYGG05OLulFIkVDyY
X-Proofpoint-ORIG-GUID: DiwYmELMyof3CbpNYGG05OLulFIkVDyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=904 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504100032

Hello!!


I am observing below kernel warnings on IBM Power9 server, while running 
bpf selftest on mainline kernel.

This issue never seen before good commit[1], and seen intermetently 
after bad commit[2], and this is not reproducible everytime.

So likely issue got introduced b/w these two commits.

[1]GoodCommit: 7f2ff7b6261742ed52aa973ccdf99151b7cc3a50
[2]Bad Commit: 08733088b566b58283f0f12fb73f5db6a9a9de30


Traces:


[34208.591723] ------------[ cut here ]------------
[34208.591738] WARNING: CPU: 9 PID: 375502 at kernel/bpf/syscall.c:3374 
bpf_tracing_link_release+0x90/0xa0
[34208.591750] Modules linked in: bpf_testmod(OE) 8021q(E) garp(E) 
mrp(E) vrf(E) tun(E) rpadlpar_io(E) rpaphp(E) vfat(E) fat(E) isofs(E) 
ext4(E) crc16(E) mbcache(E) jbd2(E) nft_masq(E) veth(E) bridge(E) stp(E) 
llc(E) overlay(E) bonding(E) nft_fib_inet(E) nft_fib_ipv4(E) 
nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) 
nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) rfkill(E) 
ip_set(E) mlx5_ib(E) ib_uverbs(E) ib_core(E) mlx5_core(E) mlxfw(E) 
psample(E) tls(E) ibmveth(E) pseries_rng(E) sg(E) vmx_crypto(E) drm(E) 
fuse(E) dm_mod(E) drm_panel_orientation_quirks(E) xfs(E) lpfc(E) 
nvmet_fc(E) nvmet(E) sr_mod(E) sd_mod(E) cdrom(E) nvme_fc(E) 
nvme_fabrics(E) ibmvscsi(E) nvme_core(E) scsi_transport_srp(E) 
scsi_transport_fc(E) [last unloaded: bpf_test_modorder_x(OE)]
[34208.591838] CPU: 9 UID: 0 PID: 375502 Comm: test_progs-no_a Tainted: 
G        W  OE       6.15.0-rc1-ga24588245776 #1 VOLUNTARY
[34208.591848] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[34208.591852] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[34208.591857] NIP:  c00000000049c830 LR: c00000000049c7cc CTR: 
0000000000000070
[34208.591863] REGS: c00000000eb07a60 TRAP: 0700   Tainted: G        W  
OE        (6.15.0-rc1-ga24588245776)
[34208.591869] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
84002482  XER: 00000000
[34208.591882] CFAR: c00000000049c7d4 IRQMASK: 0
[34208.591882] GPR00: c00000000049c7cc c00000000eb07d00 c000000001da8100 
fffffffffffffff2
[34208.591882] GPR04: 0000000000014ed8 c00000103965d480 c0000003415ca800 
c0000000b247c900
[34208.591882] GPR08: 0000000000000000 0000000000000000 c0000000b247c900 
0000000000002000
[34208.591882] GPR12: c00000000eb078a8 c000000017ff5300 0000000000000000 
0000000000000000
[34208.591882] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[34208.591882] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[34208.591882] GPR24: 0000000000000000 0000000000000000 0000000000000000 
c0000003893d6780
[34208.591882] GPR28: c00000000369a6a0 0000000000000fa4 c00000000135d988 
c0000000c224bf00
[34208.591945] NIP [c00000000049c830] bpf_tracing_link_release+0x90/0xa0
[34208.591953] LR [c00000000049c7cc] bpf_tracing_link_release+0x2c/0xa0
[34208.591960] Call Trace:
[34208.591963] [c00000000eb07d00] [c00000000049c7cc] 
bpf_tracing_link_release+0x2c/0xa0 (unreliable)
[34208.591973] [c00000000eb07d30] [c00000000049c614] 
bpf_link_free+0x94/0x160
[34208.591981] [c00000000eb07d70] [c00000000049c780] 
bpf_link_release+0x50/0x70
[34208.591989] [c00000000eb07d90] [c0000000006ee75c] __fput+0x11c/0x3c0
[34208.591997] [c00000000eb07de0] [c0000000006e46bc] sys_close+0x4c/0xa0
[34208.592003] [c00000000eb07e10] [c0000000000325a4] 
system_call_exception+0x114/0x300
[34208.592012] [c00000000eb07e50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[34208.592020] --- interrupt: 3000 at 0x7fff9c40d8a4
[34208.592030] NIP:  00007fff9c40d8a4 LR: 00007fff9c40d8a4 CTR: 
0000000000000000
[34208.592035] REGS: c00000000eb07e80 TRAP: 3000   Tainted: G        W  
OE        (6.15.0-rc1-ga24588245776)
[34208.592041] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002886  XER: 00000000
[34208.592057] IRQMASK: 0
[34208.592057] GPR00: 0000000000000006 00007fffcce2d650 00007fff9c527100 
0000000000000066
[34208.592057] GPR04: 0000000000000000 0000000000000007 0000000000000004 
00007fff9ce5efc0
[34208.592057] GPR08: 00007fff9ce57908 0000000000000000 0000000000000000 
0000000000000000
[34208.592057] GPR12: 0000000000000000 00007fff9ce5efc0 0000000000000000 
0000000000000000
[34208.592057] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[34208.592057] GPR20: 0000000000000000 0000000000000000 0000000000000000 
00007fff9ce4f470
[34208.592057] GPR24: 0000000010610b6c 00007fff9ce50000 00007fffcce2e098 
0000000000000001
[34208.592057] GPR28: 00007fffcce2e250 00007fffcce2e088 0000000000000000 
0000000000000066
[34208.592118] NIP [00007fff9c40d8a4] 0x7fff9c40d8a4
[34208.592122] LR [00007fff9c40d8a4] 0x7fff9c40d8a4
[34208.592127] --- interrupt: 3000
[34208.592130] Code: 4bfffc28 60000000 60000000 60000000 38210030 
e8010010 ebe1fff8 7c0803a6 4e800020 60000000 60000000 60000000 
<0fe00000> 4bffffa4 60000000 60000000
[34208.592152] ---[ end trace 0000000000000000 ]---


If you happen to fix this issue, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



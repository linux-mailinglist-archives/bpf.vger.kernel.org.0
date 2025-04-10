Return-Path: <bpf+bounces-55628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247CA83805
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 06:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3304317E184
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 04:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62071F153E;
	Thu, 10 Apr 2025 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jCaulmfZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB533F6;
	Thu, 10 Apr 2025 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260682; cv=none; b=Hf1XbFS880by/CfDnxvJYenxImJo0a0u/gLsj1I/Uft0Nz4tRjGmscZTn9o2VLJYeDlqjpnhD2k7k8Ce+G3V3wy3HbLWRu01R4fAEOafd8TpujUqJSeeObqzx2xy2wkHr5XYrJSBe2k/WLdT3u/PjyRldHqixeE1PeKs2Y6jKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260682; c=relaxed/simple;
	bh=PC9EXhe8ZVuduQJq69exAB2rYhGl50SGulzgRDZVhME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I0WE6bJJTrdR0Q4MDk6T5UikEDsjGX8jRVIREcnZx5IXQZJDfYdIdGqSOOxKOmQDDjQJp2b2YX5rFB6fh6giFTpRLnK90TqQzjjJ82vh+dFuNPQ7xqcs6MY3V1ykE6EHU3rPpWHp24a8mXcKn9T2eM/NY9M7XhTqvKH/ltQ2pSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jCaulmfZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539MLChb027048;
	Thu, 10 Apr 2025 04:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=njyM77
	t/t2FHJ/+tup28jrS0jo+WSZKAYYA3LMxt7gs=; b=jCaulmfZfvUhq5xgFcMAnR
	B7lvZYBJfdbTjXKdzIC9t+U4PDo0T7oJk9zWpBJnsomzZ0DKOS7rcgzi3Z8BkXki
	6T8pjhWdiiYZd2KJJ2uxUAZZYxPR2G0s+n1zz4+VhWr3yBScNZrXI871Flfl5nnX
	Kx83yC/QAuimb8XLhvE5yyVKg4eHeb/d7qux7gEyD4ZS57gpdWcELIeJ4L930gGt
	8xph9JgNcxn8PqABEz+0OefFVMK8KhDZgblXUrgsNysogX9gZYF3eI3X10qeIbHz
	WnRTBgp0r1VG0lPQeAs2SfhhiiDK8L9hCOPbW6sgJBgK8jUEoAuqF0LEyMSfresw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq4ffv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 04:51:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A38IUm013932;
	Thu, 10 Apr 2025 04:51:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunv0h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 04:51:17 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53A4pG8419268126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 04:51:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F8C58059;
	Thu, 10 Apr 2025 04:51:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69A8258058;
	Thu, 10 Apr 2025 04:51:13 +0000 (GMT)
Received: from [9.61.249.145] (unknown [9.61.249.145])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 04:51:13 +0000 (GMT)
Message-ID: <d79d19b3-8dc5-4d2c-900e-a273ce317e24@linux.ibm.com>
Date: Thu, 10 Apr 2025 10:21:12 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline]Kernel Warnings at kernel/bpf/syscall.c:3374
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-next@vger.kernel.org
References: <c9816983-7162-47e6-8758-2daaa8c8ccc3@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <c9816983-7162-47e6-8758-2daaa8c8ccc3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7Y67UAI6k2Km9_zIY-g42CxIXc8_JUKs
X-Proofpoint-ORIG-GUID: 7Y67UAI6k2Km9_zIY-g42CxIXc8_JUKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504100032

+ LKML, netdev

On 10/04/25 10:17 am, Venkat Rao Bagalkote wrote:
> Hello!!
>
>
> I am observing below kernel warnings on IBM Power9 server, while 
> running bpf selftest on mainline kernel.
>
> This issue never seen before good commit[1], and seen intermetently 
> after bad commit[2], and this is not reproducible everytime.
>
> So likely issue got introduced b/w these two commits.
>
> [1]GoodCommit: 7f2ff7b6261742ed52aa973ccdf99151b7cc3a50
> [2]Bad Commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
>
>
> Traces:
>
>
> [34208.591723] ------------[ cut here ]------------
> [34208.591738] WARNING: CPU: 9 PID: 375502 at 
> kernel/bpf/syscall.c:3374 bpf_tracing_link_release+0x90/0xa0
> [34208.591750] Modules linked in: bpf_testmod(OE) 8021q(E) garp(E) 
> mrp(E) vrf(E) tun(E) rpadlpar_io(E) rpaphp(E) vfat(E) fat(E) isofs(E) 
> ext4(E) crc16(E) mbcache(E) jbd2(E) nft_masq(E) veth(E) bridge(E) 
> stp(E) llc(E) overlay(E) bonding(E) nft_fib_inet(E) nft_fib_ipv4(E) 
> nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) 
> nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) rfkill(E) 
> ip_set(E) mlx5_ib(E) ib_uverbs(E) ib_core(E) mlx5_core(E) mlxfw(E) 
> psample(E) tls(E) ibmveth(E) pseries_rng(E) sg(E) vmx_crypto(E) drm(E) 
> fuse(E) dm_mod(E) drm_panel_orientation_quirks(E) xfs(E) lpfc(E) 
> nvmet_fc(E) nvmet(E) sr_mod(E) sd_mod(E) cdrom(E) nvme_fc(E) 
> nvme_fabrics(E) ibmvscsi(E) nvme_core(E) scsi_transport_srp(E) 
> scsi_transport_fc(E) [last unloaded: bpf_test_modorder_x(OE)]
> [34208.591838] CPU: 9 UID: 0 PID: 375502 Comm: test_progs-no_a 
> Tainted: G        W  OE       6.15.0-rc1-ga24588245776 #1 VOLUNTARY
> [34208.591848] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [34208.591852] Hardware name: IBM,8375-42A POWER9 (architected) 
> 0x4e0202 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
> [34208.591857] NIP:  c00000000049c830 LR: c00000000049c7cc CTR: 
> 0000000000000070
> [34208.591863] REGS: c00000000eb07a60 TRAP: 0700   Tainted: G        
> W  OE        (6.15.0-rc1-ga24588245776)
> [34208.591869] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 84002482  XER: 00000000
> [34208.591882] CFAR: c00000000049c7d4 IRQMASK: 0
> [34208.591882] GPR00: c00000000049c7cc c00000000eb07d00 
> c000000001da8100 fffffffffffffff2
> [34208.591882] GPR04: 0000000000014ed8 c00000103965d480 
> c0000003415ca800 c0000000b247c900
> [34208.591882] GPR08: 0000000000000000 0000000000000000 
> c0000000b247c900 0000000000002000
> [34208.591882] GPR12: c00000000eb078a8 c000000017ff5300 
> 0000000000000000 0000000000000000
> [34208.591882] GPR16: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [34208.591882] GPR20: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [34208.591882] GPR24: 0000000000000000 0000000000000000 
> 0000000000000000 c0000003893d6780
> [34208.591882] GPR28: c00000000369a6a0 0000000000000fa4 
> c00000000135d988 c0000000c224bf00
> [34208.591945] NIP [c00000000049c830] bpf_tracing_link_release+0x90/0xa0
> [34208.591953] LR [c00000000049c7cc] bpf_tracing_link_release+0x2c/0xa0
> [34208.591960] Call Trace:
> [34208.591963] [c00000000eb07d00] [c00000000049c7cc] 
> bpf_tracing_link_release+0x2c/0xa0 (unreliable)
> [34208.591973] [c00000000eb07d30] [c00000000049c614] 
> bpf_link_free+0x94/0x160
> [34208.591981] [c00000000eb07d70] [c00000000049c780] 
> bpf_link_release+0x50/0x70
> [34208.591989] [c00000000eb07d90] [c0000000006ee75c] __fput+0x11c/0x3c0
> [34208.591997] [c00000000eb07de0] [c0000000006e46bc] sys_close+0x4c/0xa0
> [34208.592003] [c00000000eb07e10] [c0000000000325a4] 
> system_call_exception+0x114/0x300
> [34208.592012] [c00000000eb07e50] [c00000000000d05c] 
> system_call_vectored_common+0x15c/0x2ec
> [34208.592020] --- interrupt: 3000 at 0x7fff9c40d8a4
> [34208.592030] NIP:  00007fff9c40d8a4 LR: 00007fff9c40d8a4 CTR: 
> 0000000000000000
> [34208.592035] REGS: c00000000eb07e80 TRAP: 3000   Tainted: G        
> W  OE        (6.15.0-rc1-ga24588245776)
> [34208.592041] MSR:  800000000280f033 
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002886  XER: 00000000
> [34208.592057] IRQMASK: 0
> [34208.592057] GPR00: 0000000000000006 00007fffcce2d650 
> 00007fff9c527100 0000000000000066
> [34208.592057] GPR04: 0000000000000000 0000000000000007 
> 0000000000000004 00007fff9ce5efc0
> [34208.592057] GPR08: 00007fff9ce57908 0000000000000000 
> 0000000000000000 0000000000000000
> [34208.592057] GPR12: 0000000000000000 00007fff9ce5efc0 
> 0000000000000000 0000000000000000
> [34208.592057] GPR16: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [34208.592057] GPR20: 0000000000000000 0000000000000000 
> 0000000000000000 00007fff9ce4f470
> [34208.592057] GPR24: 0000000010610b6c 00007fff9ce50000 
> 00007fffcce2e098 0000000000000001
> [34208.592057] GPR28: 00007fffcce2e250 00007fffcce2e088 
> 0000000000000000 0000000000000066
> [34208.592118] NIP [00007fff9c40d8a4] 0x7fff9c40d8a4
> [34208.592122] LR [00007fff9c40d8a4] 0x7fff9c40d8a4
> [34208.592127] --- interrupt: 3000
> [34208.592130] Code: 4bfffc28 60000000 60000000 60000000 38210030 
> e8010010 ebe1fff8 7c0803a6 4e800020 60000000 60000000 60000000 
> <0fe00000> 4bffffa4 60000000 60000000
> [34208.592152] ---[ end trace 0000000000000000 ]---
>
>
> If you happen to fix this issue, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.
>


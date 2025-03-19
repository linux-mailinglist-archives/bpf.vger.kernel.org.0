Return-Path: <bpf+bounces-54362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A7A685D5
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 08:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A57422722
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B424EAB7;
	Wed, 19 Mar 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oga8dRIi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C281DE880;
	Wed, 19 Mar 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369778; cv=none; b=rc0PcdK+vjDaWzMbY2Cxj/9RBhLEFq6EVyAxT3gIgsv/P4AK70WBkwWxgMSbNSu+Mb5GBGXFV1OK0h4BXUIRKYVDYgGfHTKq9n/2mCz+QQKpyp6UxqH8FwxsUDgijWJOzzHdkz9c+/yD7DpPuAHrIxCQ4mu4qarjsV9Nn0ej8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369778; c=relaxed/simple;
	bh=IhnqxCNcdBlmXOOsuqLw7xc9Vm4wgewG9CsnJuCWQ20=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vBzTtZVMVI/ayk6lSztqR3IhMPWXXcu+3gdmxlQgPdRbpQMQrL54RqSujqeow5+Q3BrqpWTKpEc40Hbdn226/NX13jxmcmceYJWGmCuP6rMiM191zoR7soHE1Q58KdUxmhzXjUjAWKdlMWLTSlQhxccSE+LwnIuEKHh249+L9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oga8dRIi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IMDZ8X027985;
	Wed, 19 Mar 2025 07:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=76de43
	0e8ggFt6mL3KzOH5GE5t0O75BKBl/wsGZ/Ojw=; b=Oga8dRIiEj97Dk6kXTndDV
	t47EATtV1qxphLalJCGq+s9QIH2H/gKjI+18WTEBpimlyw/RacEd7TG/GUU00tRO
	GVNgZ3oGok6u5/z6EfYfmOutV21G3GT/RKKDEwUUuDl1l3x92R3HQjoARJz84pdx
	VncPtrthpmA5lQwJCENhgrhHevf/aHa50JGpG6HiSNmK7NvVknOXweEOGXzwDzGa
	PLrc5DVMhSuFQ3ZppKyWrgX1Kuir9MfP6chhCJP3b/nLGOhsqf4wXjL5LNOLzCfm
	Dl2Xv+E5gdSvvpjGG4cETVGKY4fG3VV5hk5+3UeVuntYCxTMT9FnzRYlOg3GVPJw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fa8pcbav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 07:36:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52J7DP9P023195;
	Wed, 19 Mar 2025 07:36:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3kr4ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 07:36:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52J7aBCs41615696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 07:36:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F4B720040;
	Wed, 19 Mar 2025 07:36:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAAD220049;
	Wed, 19 Mar 2025 07:36:09 +0000 (GMT)
Received: from [9.203.115.62] (unknown [9.203.115.62])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 07:36:09 +0000 (GMT)
Message-ID: <73047120-e683-4142-b4e4-2422fc41f58d@linux.ibm.com>
Date: Wed, 19 Mar 2025 13:06:08 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [main-line]warning at arch/powerpc/net/bpf_jit_comp.c:961
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QZeiulx1mTi9Y2C3Brw6jh7GAc9J0pgB
X-Proofpoint-ORIG-GUID: QZeiulx1mTi9Y2C3Brw6jh7GAc9J0pgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_02,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190050

Hi Venkat,

Thanks for reporting this.
I am having a hard time reproducing this. Please share the
kernel build config..

On 17/03/25 6:21 pm, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> I am observing below warnings on linux-mainline kernel, while running 
> bpf-sefltests.
> 
> These warnings are intermitent, reproduces roughly 6 out of 10 times.
> 
> 
> Repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 
> Tests:
> 
> ./test_progs
> 
> 
> Attached is the log file of summary of tests.
> 
> 
> Traces:
> 
> [  978.200120] ------------[ cut here ]------------
> [  978.200133] WARNING: CPU: 11 PID: 45522 at arch/powerpc/net/ 
> bpf_jit_comp.c:961 __arch_prepare_bpf_trampoline.isra.0+0xdc8/0xfe0
> [  978.200144] Modules linked in: tun(E) bpf_testmod(OE) veth(E) 
> bonding(E) tls(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) 
> nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) 
> nft_reject(E) nft_ct(E) rfkill(E) nft_chain_nat(E) sunrpc(E) ibmveth(E) 
> pseries_rng(E) vmx_crypto(E) drm(E) dm_multipath(E) dm_mod(E) fuse(E) 
> drm_panel_orientation_quirks(E) zram(E) xfs(E) sd_mod(E) ibmvscsi(E) 
> scsi_transport_srp(E) [last unloaded: bpf_test_modorder_x(OE)]
> [  978.200194] CPU: 11 UID: 0 PID: 45522 Comm: test_progs Tainted: 
> G           OE      6.14.0-rc7-auto #4
> [  978.200202] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  978.200205] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
> 0xf000005 of:IBM,FW950.A0 (VL950_144) hv:phyp pSeries
> [  978.200210] NIP:  c0000000001e3658 LR: c0000000001e34b0 CTR: 
> 0000000000000006
> [  978.200216] REGS: c00000001c057570 TRAP: 0700   Tainted: G OE       
> (6.14.0-rc7-auto)
> [  978.200221] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 44844442  XER: 20040169
> [  978.200234] CFAR: c0000000001e34e8 IRQMASK: 0
> [  978.200234] GPR00: c0000000001e34b0 c00000001c057810 c000000001d68100 
> 0000000000000000
> [  978.200234] GPR04: c00800000025d640 c00000001c05786c 0000000000000160 
> 0000000000000164
> [  978.200234] GPR08: c000000157b8c164 c000000157b8c16c 000000000000016c 
> 0000000000004000
> [  978.200234] GPR12: 0000000000000001 c00000001ec82b00 0000000000000078 
> 0000000038210110
> [  978.200234] GPR16: 00000000000000a8 00000000eb210098 0000000060638000 
> 00000000e86100c0
> [  978.200234] GPR20: 00000000eb4100a0 0000000000000004 000000002c230000 
> 0000000060000000
> [  978.200234] GPR24: fffffffffffff000 c000000005834428 c00800000025d640 
> 0000000000000001
> [  978.200234] GPR28: c000000157b89c00 000000000000026c 0000000000000003 
> c000000157b8c000
> [  978.200294] NIP [c0000000001e3658] 
> __arch_prepare_bpf_trampoline.isra.0+0xdc8/0xfe0
> [  978.200301] LR [c0000000001e34b0] 
> __arch_prepare_bpf_trampoline.isra.0+0xc20/0xfe0
> [  978.200308] Call Trace:
> [  978.200310] [c00000001c057810] [c0000000001e34b0] 
> __arch_prepare_bpf_trampoline.isra.0+0xc20/0xfe0 (unreliable)
> [  978.200319] [c00000001c057950] [c0000000001e4974] 
> arch_prepare_bpf_trampoline+0x94/0x130
> [  978.200327] [c00000001c0579b0] [c0000000005001ac] 
> bpf_trampoline_update+0x23c/0x660
> [  978.200334] [c00000001c057a90] [c0000000005006dc] 
> __bpf_trampoline_link_prog+0x10c/0x360
> [  978.200341] [c00000001c057ad0] [c000000000500c28] 
> bpf_trampoline_link_cgroup_shim+0x268/0x370
> [  978.200348] [c00000001c057b80] [c00000000053254c] 
> __cgroup_bpf_attach+0x4ec/0x760
> [  978.200355] [c00000001c057c60] [c000000000533dd4] 
> cgroup_bpf_prog_attach+0xa4/0x310
> [  978.200362] [c00000001c057cb0] [c00000000049d1b8] 
> bpf_prog_attach+0x2a8/0x2e0
> [  978.200370] [c00000001c057d00] [c0000000004a7278] __sys_bpf+0x428/0xd20
> [  978.200375] [c00000001c057df0] [c0000000004a7b9c] sys_bpf+0x2c/0x40
> [  978.200381] [c00000001c057e10] [c000000000033078] 
> system_call_exception+0x128/0x310
> [  978.200388] [c00000001c057e50] [c00000000000d05c] 
> system_call_vectored_common+0x15c/0x2ec
> [  978.200396] --- interrupt: 3000 at 0x7fff98ba9f40
> [  978.200405] NIP:  00007fff98ba9f40 LR: 00007fff98ba9f40 CTR: 
> 0000000000000000
> [  978.200410] REGS: c00000001c057e80 TRAP: 3000   Tainted: G OE       
> (6.14.0-rc7-auto)
> [  978.200415] MSR:  800000000280f033 
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002848  XER: 00000000
> [  978.200431] IRQMASK: 0
> [  978.200431] GPR00: 0000000000000169 00007fffde891b10 00007fff98cb6d00 
> 0000000000000008
> [  978.200431] GPR04: 00007fffde891bf8 0000000000000020 0000000000000001 
> 0000000000000008
> [  978.200431] GPR08: 0000000000000008 0000000000000000 0000000000000000 
> 0000000000000000
> [  978.200431] GPR12: 0000000000000000 00007fff995fe9e0 0000000000000000 
> 0000000000000000
> [  978.200431] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [  978.200431] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 00007fff995ef438
> [  978.200431] GPR24: 00000000105ed2f4 00007fff995f0000 00007fffde892998 
> 0000000000000001
> [  978.200431] GPR28: 00007fffde892aa8 00007fffde892988 0000000000000001 
> 00007fffde891b40
> [  978.200487] NIP [00007fff98ba9f40] 0x7fff98ba9f40
> [  978.200491] LR [00007fff98ba9f40] 0x7fff98ba9f40
> [  978.200495] --- interrupt: 3000
> [  978.200498] Code: 7d5f412e 81210060 39290001 792a1788 3ba90040 
> 91210060 7d3f5214 57bd103a e9010030 3908ff00 7c294040 4081fae0 
> <0fe00000> 3ba0fff2 4bfffad4 8281003c
> [  978.200519] ---[ end trace 0000000000000000 ]---
> 
> If you happen to fix this, please add below tag.
> 
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> 
> Regards,
> 
> Venkat.



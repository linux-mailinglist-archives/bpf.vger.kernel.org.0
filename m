Return-Path: <bpf+bounces-37749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157E95A3E1
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 19:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F271F2141F
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9295C1B253C;
	Wed, 21 Aug 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EGhO3JLe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B61B2EC3;
	Wed, 21 Aug 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261329; cv=none; b=QbfaKvAr9wx3pH9sYFK0+pDerXlY58n1TG9JOQwmqthlCdVE4KBxBom5xKEXwdr4N1qXgXw77kgNQUcnTFbL3DyEm4KRYeAGGn9wtwBQuVGeDe+Z1R9fDj1cQ1BmhT2ygCjjTnydm2mLHVEhcZixIJpK9RWXYeu2SzUBZntu89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261329; c=relaxed/simple;
	bh=Z7g1eI6kWpYxVzw2wuDMPDkp3Qz3MZT1Ft32e+OF5jM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYq/GaoBZBazuNyxOjqNQK47OuBrmRlu1qgv6+wqrSTZ7uL23Xhy8DpCBHGh50wOP22kPtuq1918j08U4+xCVW6w9dZuAoK0SpCaRld0iWWBKZjtch9+Aj4fpWWPnnqlFH5RPpVCpvrawwUoopy5SaowWpM322NaCEjQY0Qp9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EGhO3JLe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LGjc4I005315;
	Wed, 21 Aug 2024 17:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	hZoM3/ewS3bSCW82HY7HpWQ1BVcMTDt9uP/JDDoStK8=; b=EGhO3JLehBdhtdRr
	mSvZAznJ0JMIiZoxKgIIHeLBo209AqAQemVXMjepOvym1xu9qeFS+Ax8P+EQXPe7
	2G7FrnV/T8K2oqpiqc42cByy4hPwDGs1yU8SHLbSNUyLpKIV/UI251YmF1ot0PgH
	q822s2jhWtKeAUUSf2bPetzN/c7SCa8D0APeqsXDEW4smDhgHY48wo4hm0uvN2SB
	DnZ1dGaHo01HP9dDxbWyxSKj58z/qRsuyIbZF5JqdA4sZiDo5ykTMBya4HPXhInu
	Cy8T4vz/XWezAjjC9j5cMY07iC1ZD9/CZ+NFnZhjIDiB6c6/dx/Ag+HujCnoV0aT
	5tcS4Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5uxs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:28:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47LHSZCF013665;
	Wed, 21 Aug 2024 17:28:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5uxrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:28:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47LGj7fA002244;
	Wed, 21 Aug 2024 17:28:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0s02r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:28:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47LHSUum55050522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:28:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8589920043;
	Wed, 21 Aug 2024 17:28:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28D1820040;
	Wed, 21 Aug 2024 17:28:30 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 17:28:30 +0000 (GMT)
Message-ID: <aa8fe2731224ffdb6d64a014e3e02740c50010cd.camel@linux.ibm.com>
Subject: Re: Problem testing with S390x under QEMU on x86_64
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexei Starovoitov
	 <ast@kernel.org>
Date: Wed, 21 Aug 2024 19:28:29 +0200
In-Reply-To: <ZsU3GdK5t6KEOr0g@kodidev-ubuntu>
References: <ZsEcsaa3juxxQBUf@kodidev-ubuntu>
	 <180f4c27ebfb954d6b0fd2303c9fb7d5f21dae04.camel@linux.ibm.com>
	 <ZsU3GdK5t6KEOr0g@kodidev-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ynu1xobkTL6GOEen_jrS_DW_RcAEpxex
X-Proofpoint-GUID: Bzn5ENgkkz5CX9Sw2Sb7eLzV9i3PABMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=984 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210124

On Tue, 2024-08-20 at 17:38 -0700, Tony Ambardar wrote:


[...]

> I used the command line:
> =C2=A0=C2=A0=C2=A0 ./test_progs -d
> get_stack_raw_tp,stacktrace_build_id,verifier_iterating_callbacks,tai
> lcalls
>=20
> which includes the current DENYLIST.s390x as well as 'tailcalls',
> which
> is also excluded by the kernel-patches/bpf s390x CI. I note the CI
> excludes several more tests that seem to work. Any idea why that is?
>=20
> For reference, the issue with 'tailcalls/tailcall_hierarchy_count' is
> an
> RCU stall and kernel hang:
>=20
> root@(none):/usr/libexec/kselftests-bpf# ./test_progs -v --debug -n
> 332/19
> bpf_testmod.ko is already unloaded.
> Loading bpf_testmod.ko...
> Successfully loaded bpf_testmod.ko.
> test_tailcall_hierarchy_count:PASS:load obj 0 nsec
> test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
> test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
> test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
> test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
> test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
> test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0
> nsec
> test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
> test_tailcall_hierarchy_count:PASS:attach_trace 0 nsec
> rcu: INFO: rcu_sched self-detected stall on CPU
> rcu:=C2=A0=C2=A0=C2=A0 0-....: (1 GPs behind) idle=3D4eb4/1/0x40000000000=
00000
> softirq=3D527/528 fqs=3D1050
> rcu:=C2=A0=C2=A0=C2=A0 (t=3D2100 jiffies g=3D-379 q=3D20 ncpus=3D2)
> CPU: 0 UID: 0 PID: 84 Comm: test_progs Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 6.10.0-12706-g853081e84612-dirty #111
> Tainted: [O]=3DOOT_MODULE
> Hardware name: QEMU 8561 QEMU (KVM/Linux)
> Krnl PSW : 0704f00180000000 000003ffe00f8fca
> (lock_release+0xf2/0x190)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R:0 T:1 IO:1=
 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0
> EA:3
> Krnl GPRS: 00000000b298dd12 0000000000000000 000002f23fd767c8
> 000003ffe1848800
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000000000=
0001 0000037fe034edbc 0000037fe034fd74
> 0000000000000001
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0700037fe034=
edc8 000003ffe0249e48 000003ffe1848800
> 000003ffe19ba7c8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ff9f7a=
7f90 0000037fe034ef00 000003ffe00f8f96
> 0000037fe034ed78
> Krnl Code: 000003ffe00f8fbe: a7820300=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 tmhh=C2=A0=C2=A0=C2=A0 %r8,768
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffe00f=
8fc2: a7840004=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
brc=C2=A0=C2=A0=C2=A0=C2=A0
> 8,000003ffe00f8fca
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #000003ffe00f8fc6:=
 ad03f0a0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stosm=
=C2=A0=C2=A0 160(%r15),3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >000003ffe00f8fca:=
 eb8ff0a80004=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lmg=C2=A0=C2=A0=C2=A0=C2=
=A0
> %r8,%r15,168(%r15)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffe00f=
8fd0: 07fe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bcr=C2=A0=C2=A0=C2=A0=C2=A0 15,%r14
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffe00f=
8fd2: c0e500011057=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brasl=C2=A0=C2=A0
> %r14,000003ffe011b080
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffe00f=
8fd8: ec26ffa6007e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cij=C2=A0=C2=A0=C2=
=A0=C2=A0
> %r2,0,6,000003ffe00f8f24
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffe00f=
8fde: c01000b78b96=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 larl=C2=A0=C2=A0=C2=
=A0
> %r1,000003ffe17ea70a
> Call Trace:
> =C2=A0[<000003ffe00f8fca>] lock_release+0xf2/0x190
> ([<000003ffe00f8f96>] lock_release+0xbe/0x190)
> =C2=A0[<000003ffe0249ea4>] __bpf_prog_exit_recur+0x5c/0x68
> =C2=A0[<000003ff6001e0b0>] bpf_trampoline_73014444060+0xb0/0xd2
> =C2=A0[<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
> =C2=A0[<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
> =C2=A0[<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
> =C2=A0[<000003ff60024d2a>] bpf_prog_eb7edc599e93dcc8_entry+0x72/0xc8
> =C2=A0[<000003ff60024d2a>] bpf_prog_eb7edc599e93dcc8_entry+0x72/0xc8
> =C2=A0[<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
> =C2=A0[<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
> =C2=A0[<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
> =C2=A0[<000003ffe084ecee>] bpf_test_run+0x216/0x3a8
> =C2=A0[<000003ffe084f9cc>] bpf_prog_test_run_skb+0x21c/0x630
> =C2=A0[<000003ffe0202ad2>] __sys_bpf+0x7ea/0xbb0
> =C2=A0[<000003ffe0203114>] __s390x_sys_bpf+0x44/0

Thanks for the detailed analysis! I will need to port

commit 116e04ba1459fc08f80cf27b8c9f9f188be0fcb2
Author: Leon Hwang <hffilwlqm@gmail.com>
Date:   Sun Jul 14 20:39:00 2024 +0800

    bpf, x64: Fix tailcall hierarchy

to s390x to fix this.

> Another curiosity is with 'uprobe_multi_test/attach_uprobe_fails',
> which usually succeeds but generates an inode warning in
> kernel/events/uprobes.c: (with cross-compiled and native test_progs)
>=20
> #416=C2=A0=C2=A0=C2=A0=C2=A0 uprobe_autoattach:OK
> ref_ctr_offset mismatch. inode: 0x73c7 offset: 0x3c9b78
> ref_ctr_offset(old): 0x464d7be ref_ctr_offset(new): 0x464d7bc
> #417/1=C2=A0=C2=A0 uprobe_multi_test/skel_api:OK
> #417/2=C2=A0=C2=A0 uprobe_multi_test/attach_api_pattern:OK
> #417/3=C2=A0=C2=A0 uprobe_multi_test/attach_api_syms:OK
> #417/4=C2=A0=C2=A0 uprobe_multi_test/link_api:OK
> #417/5=C2=A0=C2=A0 uprobe_multi_test/bench_uprobe:OK
> #417/6=C2=A0=C2=A0 uprobe_multi_test/bench_usdt:OK
> #417/7=C2=A0=C2=A0 uprobe_multi_test/attach_api_fails:OK
> #417/8=C2=A0=C2=A0 uprobe_multi_test/attach_uprobe_fails:OK
> #417/9=C2=A0=C2=A0 uprobe_multi_test/consumers:OK
> #417=C2=A0=C2=A0=C2=A0=C2=A0 uprobe_multi_test:OK
>=20
> but occasionally I see this kernel fault:
>=20
> #416=C2=A0=C2=A0=C2=A0=C2=A0 uprobe_autoattach:OK
> User process fault: interruption code 0001 ilc:1 in
> test_progs[3c9ba2,2aa3b580000+cc5000]
> CPU: 0 UID: 0 PID: 165 Comm: new_name Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 6.10.0-12707-g8189b8007d01 #114
> Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> Hardware name: QEMU 8561 QEMU (KVM/Linux)
> User PSW : 0705000180000000 000002aa3b949ba2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R:0 T:1 IO:1=
 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:0 PM:0 RI:0
> EA:3
> User GPRS: cccccccccccccccd 0000000000000000 000003ffbe080000
> 0000000000000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffbeb7=
4828 0000000000000006 0000000000000000
> 000002aa3c245928
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffbeb2=
cbc0 000003ffbeb2d020 0000000000000003
> 000003ffdb379f20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffbeb2=
cf98 0000000000000000 000002aa3b94a400
> 000003ffdb379f20
> User Code:>000002aa3b949ba2: 0000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 illegal
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000002aa3b94=
9ba4: 0700=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bcr=C2=A0=C2=A0=C2=A0=C2=A0 0,%r0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000002aa3b94=
9ba6: b3cd00b0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
lgdr=C2=A0=C2=A0=C2=A0 %r11,%f0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000002aa3b94=
9baa: 07fe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bcr=C2=A0=C2=A0=C2=A0=C2=A0 15,%r14
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000002aa3b94=
9bac: 0707=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bcr=C2=A0=C2=A0=C2=A0=C2=A0 0,%r7
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000002aa3b94=
9bae: 0707=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bcr=C2=A0=C2=A0=C2=A0=C2=A0 0,%r7
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000002aa3b94=
9bb0: ebbff0580024=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stmg=C2=A0=C2=A0=C2=
=A0
> %r11,%r15,88(%r15)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000002aa3b94=
9bb6: e3f0ff48ff71=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lay=C2=A0=C2=A0=C2=
=A0=C2=A0 %r15,-
> 184(%r15)
> Last Breaking-Event-Address:
> =C2=A0[<000002aa3b94a3fa>] test_progs[3ca3fa,2aa3b580000+cc5000]
>=20
>=20
> Have you seen this fault before? Is the inode warning expected by the
> test?

Yes, this is caused by:

/* attach fail due to wrong ref_ctr_offs on one of the uprobes */
attach_uprobe_fail_refctr(skel);

The fault is a user fault, not a kernel fault. I could not reproduce it
on a real s390x machine. This may be an emulation problem, since
apparently the kernel does not recognize that "0000 illegal" is an
uprobe. Quite some time ago I fixed a similar issue in this area,
perhaps it's a new flavour. I will investigate.

[...]

Best regards,
Ilya


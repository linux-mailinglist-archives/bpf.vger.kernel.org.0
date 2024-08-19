Return-Path: <bpf+bounces-37486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B517956693
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 11:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283F01F23376
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73415C149;
	Mon, 19 Aug 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GoG9PRqZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85535155391;
	Mon, 19 Aug 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058951; cv=none; b=N9fWeKrXN4iROvvzP+OezyA5VTOH+9n+urzvzlH+0qX/U4Re0j2eL0OTHLHJB6tz7DnJuFq8a/4l+CF/nBKYixd09+3sY/1hcljixuSr+bD3wiaG0NF5atvkfSNJRtXnufZo+iN0O51dPuIoLRut20muJ3MG6+mL95J182ICZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058951; c=relaxed/simple;
	bh=D8JC0hF9CDlprbe5m0WIVx6dDeOXX96EK3mSyHjfl4o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7RoPyUi2W3M2c22rVkjvao6FNL6w4ymq3U0uGFA14S3h5PgSbHGg0VOk+qteZOUYxUGdJuquC3ANwqDwrJfRtvBa/bYZ5qx8txR0u/wcz5Ar9u9Ncow9kTjzD8n8AkLeNsAOXgdRiZ/hhwV0i7177ypH1cnzgeSVFJSTOE4mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GoG9PRqZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J8n8Tr006927;
	Mon, 19 Aug 2024 09:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	D8JC0hF9CDlprbe5m0WIVx6dDeOXX96EK3mSyHjfl4o=; b=GoG9PRqZLZQhFXIG
	u1ByXCv6XnpT4wN/p5KpQVc8cDu9a3kb9ax0HEA62NRVdHjBLvXl9Iz16KT2mVD+
	LmFnSeK6R5wOh4lqySPEl3je4XpMeD30lz0vOyE35Z5IEMAy1o2ZTBkDHB/uE8jf
	V0Cl2rDUp+tarf1T28jXjkU0Pt/N7+BJzLOtnf2RJlEZ0cQAwPkTGSnlqp0kuXMf
	YFji50lVc0Oq8QxObfZUoqobFw4lqSH/S+pW8p48Q0seapTOQcybqXi43aUjONLX
	IR3758IiU0GNw06qc6S7zN6A/d+1AUYnVwvjNNM8sNkJcrzsE0SU/qdZ6gXSCaGw
	eYavbA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412m9yyywj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 09:15:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47J9A7U9026324;
	Mon, 19 Aug 2024 09:15:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412m9yyywe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 09:15:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47J7lcK2002201;
	Mon, 19 Aug 2024 09:15:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0djdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 09:15:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47J9Ffuw49873340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 09:15:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859B120040;
	Mon, 19 Aug 2024 09:15:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43CE52004D;
	Mon, 19 Aug 2024 09:15:41 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 09:15:41 +0000 (GMT)
Message-ID: <180f4c27ebfb954d6b0fd2303c9fb7d5f21dae04.camel@linux.ibm.com>
Subject: Re: Problem testing with S390x under QEMU on x86_64
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Mon, 19 Aug 2024 11:15:40 +0200
In-Reply-To: <ZsEcsaa3juxxQBUf@kodidev-ubuntu>
References: <ZsEcsaa3juxxQBUf@kodidev-ubuntu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3fh4af20AjJ-MNCCAdo0OkhdCuYZlu6Y
X-Proofpoint-ORIG-GUID: bTSFG-UnxyjzghILDJTOAhU-RkguqYm_
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_07,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190063

On Sat, 2024-08-17 at 14:57 -0700, Tony Ambardar wrote:
> Hello all,
>=20
> I'd appreciate some help from the BPF and s390x communities...
>=20
> Some background: I'm finalizing a patch series enabling full cross-
> endian
> support for libbpf and selftests/bpf, and testing with mips64 so far.
> This
> arch makes switching the build byte-order trivial and has been very
> handy
> for A/B testing, but lacks some basic support (bpf2bpf call, kfuncs,
> etc.)
> making for poor selftests coverage.
>=20
> To finish testing I thought (optimistically?) to cross-build kernel
> and
> bpf selftests from x86_64 to s390x. That configuration might also be
> used
> later on bpf-ci for regression testing endian support and sharing the
> load
> of s390x builds.
>=20
> Locally, the build succeeds but when running it under QEMU I see
> kernel
> crashes trying to load any modules (e.g. prng or bpf_testmod).
>=20
>=20
> The build/test setup uses Ubuntu and gcc:=20
>=20
> kodidev:~/linux$ lsb_release -d
> Description:=C2=A0=C2=A0=C2=A0 Ubuntu 22.04.4 LTS
>=20
> kodidev:~/linux$ s390x-linux-gnu-gcc --version
> s390x-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> Copyright (C) 2021 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.=C2=A0 There
> is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
>=20
>=20
> The code targets bpf/master, and I've researched QEMU/s390x usage
> details
> online but mainly follow https://docs.kernel.org/bpf/s390.html. For
> rootfs
> I take the same s390x image used by the kernel-patches bpf-ci.
>=20
>=20
> The kernel .config used is attached, and the QEMU command-line is
> below:
>=20
> qemu-system-s390x -cpu max,zpci=3Don -smp 2 -nographic -m 1G \
> -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
> -device virtio-rng-ccw,rng=3Drng0 \
> -device virtio-net-ccw,netdev=3Deth0 \
> -netdev user,id=3Deth0,hostfwd=3Dtcp::2224-:22 \
> -serial mon:stdio \
> -nodefaults \
> -kernel bzImage-s390x \
> -drive file=3Droot-s390x-glibc.qcow2,if=3Dvirtio,format=3Dqcow2=C2=A0=C2=
=A0 \
> -append "rootwait root=3D/dev/vda rw net.ifnames=3D0 biosdevname=3D0
> console=3DttyS1"
>=20
>=20
> After successfully booting, the crashes are easily reproduced:
>=20
> root@(none):/# uname -a
> Linux (none) 6.10.0-12706-g853081e84612-dirty #111 SMP Sat Aug 17
> 00:49:23
> PDT 2024 s390x GNU/Linux
>=20
> # modprobe prng
> Unable to handle kernel pointer dereference in virtual kernel address
> space
> Failing address: 000003fee0011000 TEID: 000003fee0011803
> Fault in home space mode while using kernel ASCE.
> AS:0000000001dac007 R3:0000000000000024
> Oops: 003b ilc:1 [#1] SMP
> Modules linked in: prng(+)
> CPU: 1 UID: 0 PID: 81 Comm: modprobe Not tainted 6.10.0-12691-
> g52e8c345c9f0 #106
> Hardware name: QEMU 3906 QEMU (KVM/Linux)
> Krnl PSW : 0704d00180000000 000003fee0011ea0 (0x3fee0011ea0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R:0 T:1 IO:1=
 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0
> EA:3
> Krnl GPRS: 000002f2820db180 000003ffe1ca49a8 0000000000000000
> 000003ff6000f498
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000000000=
0000 0000000000000a22 0000000000000000
> 0000000000000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffe181=
11e0 000002f2806a48e8 000003ff6000f498
> 0000000000000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ff8eaa=
cfa8 000002aa0bbafa00 000003ff6000f4be
> 0000037fe0c33b58
> Krnl Code: Bad PSW.
> Call Trace:
> =C2=A0[<000003fee0011ea0>] 0x3fee0011ea0
> =C2=A0[<000003ffe0000b24>] do_one_initcall+0x64/0x258
> =C2=A0[<000003ffe01566e8>] do_init_module+0x78/0x258
> =C2=A0[<000003ffe0158160>] init_module_from_file+0x88/0xa8
> =C2=A0[<000003ffe01582e8>] idempotent_init_module+0x168/0x230
> =C2=A0[<000003ffe0158430>] __s390x_sys_finit_module+0x80/0xb8
> =C2=A0[<000003ffe0b6f58a>] __do_syscall+0x232/0x2b0
> =C2=A0[<000003ffe0b81b90>] system_call+0x70/0x98
> INFO: lockdep is turned off.
> Last Breaking-Event-Address:
> =C2=A0[<000003ff6000f4b8>]
> cpu_feature_match_S390_CPU_FEATURE_MSA_init+0x20/0xb68 [prng]
> Kernel panic - not syncing: Fatal exception: panic_on_oops
>=20
>=20
> and also:
>=20
> # ./test_progs -a xdpwall
> bpf_testmod: loading out-of-tree module taints kernel.
> Unable to handle kernel pointer dereference in virtual kernel address
> space
> Failing address: 000003fee0293000 TEID: 000003fee0293803
> Fault in home space mode while using kernel ASCE.
> AS:0000000001dac007 R3:0000000000000024
> Oops: 003b ilc:1 [#1] SMP
> Modules linked in: bpf_testmod(O+)
> CPU: 2 UID: 0 PID: 91 Comm: test_progs Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 6.10.0-12691-g52e8c345c9f0 #106
> Tainted: [O]=3DOOT_MODULE
> Hardware name: QEMU 3906 QEMU (KVM/Linux)
> Krnl PSW : 0704d00180000000 000003fee0293998 (0x3fee0293998)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R:0 T:1 IO:1=
 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0
> EA:3
> Krnl GPRS: 000002f20374e760 0001677600016805 0000000000000000
> 000003ff6000e288
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000000000=
0000 000000000000007a 0000000000000000
> 0000000000000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffe181=
11e0 000002f204c6d2e8 000003ff6000ab90
> 0000000000000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000003ffb73a=
cfa8 0000000000000000 000003ff6000abce
> 0000037fe0803b50
> Krnl Code: Bad PSW.
> Call Trace:
> =C2=A0[<000003fee0293998>] 0x3fee0293998
> =C2=A0[<000003ffe0000b24>] do_one_initcall+0x64/0x258
> =C2=A0[<000003ffe01566e8>] do_init_module+0x78/0x258
> =C2=A0[<000003ffe0158160>] init_module_from_file+0x88/0xa8
> =C2=A0[<000003ffe01582e8>] idempotent_init_module+0x168/0x230
> =C2=A0[<000003ffe0158430>] __s390x_sys_finit_module+0x80/0xb8
> =C2=A0[<000003ffe0b6f58a>] __do_syscall+0x232/0x2b0
> =C2=A0[<000003ffe0b81b90>] system_call+0x70/0x98
> INFO: lockdep is turned off.
> Last Breaking-Event-Address:
> =C2=A0[<000003ff6000abc8>] bpf_testmod_init+0x38/0x160 [bpf_testmod]
> Kernel panic - not syncing: Fatal exception: panic_on_oops
>=20
>=20
> Has anyone encountered this before, or is able to reproduce?
> Could someone share a "known good" kernel .config working in the
> past?
>=20
> I'd be grateful for any advice or helpful suggestions.
>=20
> Thanks,
> Tony

Hi,

I assume you are using the distro qemu v6.2?
Could you please try v9.1.0-rc2?
It contains quite a few emulation bugfixes.

Best regards,
Ilya


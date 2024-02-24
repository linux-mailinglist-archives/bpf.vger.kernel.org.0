Return-Path: <bpf+bounces-22640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9C862485
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 12:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 665A0B21132
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53F2562F;
	Sat, 24 Feb 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q2/cwbUM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F725613;
	Sat, 24 Feb 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774282; cv=none; b=swoORKjHE6xZ2FInpHzCmKKbcFB1vPj5X2+pdPuSv3+n++Wunl/cmJepFuzafHdv3BZ23wT/RJz5XpWYejv1sjk3zixWa86d59y7fIg9EhEDuVOVvlPyGlPFa0lq77fOmUulHRZss632ZZQgkK/KrMIdqazi4sU7BHaYep+8W/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774282; c=relaxed/simple;
	bh=eT1oujDLLZyNNJM9ggs3AbQKg5j5Wa2LN/QLyDtFJZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KbpTyiH6v6zCdf1E4czBrSWTSQmEMrf6RLimW23qGxDKOj1VlHgEbhaf17ijVnLTk9Svf2wpbzPJc/dQvpj+EQHHnspY1hFS1yazSv5gVBgHNVMFkQJlZwOxKy9XV0JHYXIvoAnBXrGd0xUUswBt6H1xs524BTQOGIKWtrETcDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q2/cwbUM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41O9bbVW021414;
	Sat, 24 Feb 2024 11:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=lrYyuXTTF73x4XmSUZOwh6NvK1aFzf0Q8h1TXqclq9U=;
 b=q2/cwbUME6K2ZNDczjKwx1ChJbC+go4lo8QgxCMNr5oCi1wNUYUUWsPBtlXfhxgTEn65
 Vgsh6aPknyoXN8dmxviuGaOBZz1NjiZUCwr9K9FOiYHpTlbEpT/G/tGVQFZ4OaTEtSyj
 tcACOhxzwI5PPreV6RIJ6zKXVFwKP763uGJfIEJtiXf+L/6Vj1LBPEqPH7rkCVK+0rGs
 IgmVEwNHzCKXJ1Ifs8uZe5uLHhRNjeYlCCt75Y+ptnx7dndV1L06w7suiox4/lV960CR
 Q4BKPgZWT9Na1FMpt6UzlmzedCXNtpcakURHyGrJ6dfqtRptoBFZ1ot6uP2LTWbiM/ds gg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wfdyy146k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 11:31:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41O8K4PU024339;
	Sat, 24 Feb 2024 11:31:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mn3vyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 11:31:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41OBV7kf44040782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 11:31:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BDA820040;
	Sat, 24 Feb 2024 11:31:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F68F2004B;
	Sat, 24 Feb 2024 11:31:07 +0000 (GMT)
Received: from heavy (unknown [9.171.81.52])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 24 Feb 2024 11:31:07 +0000 (GMT)
Date: Sat, 24 Feb 2024 12:31:05 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: Help needed for a BPF kernel issue with S390
Message-ID: <wvd5gzde5ejc2rzsbrtwqyof56uw5ea3rxntfrxtkdabzcuwt6@w7iczzhmay2i>
References: <c2d90fe3-9d8a-4f64-8136-126cf556d08f@csgroup.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2d90fe3-9d8a-4f64-8136-126cf556d08f@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S-jk3ImMSmtaftbyqaVmJpqtGdltVoPK
X-Proofpoint-ORIG-GUID: S-jk3ImMSmtaftbyqaVmJpqtGdltVoPK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=429 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240096

On Sat, Feb 24, 2024 at 08:07:09AM +0000, Christophe Leroy wrote:
> Hello,
> 
> I'm seeking your help with an issue reported by BPF CI tests on a core 
> BPF patch I provided to improve security in link with 
> https://github.com/KSPP/linux/issues/7
> 
> I submitted patch 
> https://patchwork.kernel.org/project/netdevbpf/patch/135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu/
> 
> As you can see in the checks list, I get "bpf/vmtest-bpf-next-VM_Test-14 
> 	fail 	Logs for s390x-gcc / test (test_progs, false, 360) / test_progs 
> on s390x with gcc "
> 
> The output is the one below.
> 
> Could you help me understand and fix the issue on S390 ?
> 
> Thanks
> Christophe
> 
> Output:
> 
> ...
>    #262     reg_bounds_rand_ranges_u64_u64:OK
>    #263     resolve_btfids:OK
>    Caught signal #11!
>    Stack trace:
>    ./test_progs(crash_handler+0x40)[0x2aa090c5ca8]
>    linux-vdso64.so.1(__kernel_sigreturn+0x0)[0x3ffc78ce488]
>    ./test_progs(ring_buffer__poll+0xc6)[0x2aa0912bbe6]
>    ./test_progs(+0x283490)[0x2aa08f83490]
>    /lib/s390x-linux-gnu/libpthread.so.0(+0x7e66)[0x3ffb8c07e66]
>    /lib/s390x-linux-gnu/libc.so.6(+0xfcd46)[0x3ffb8afcd46]
>    [0x0]
> 
>    test_progs[116] is installing a program with bpf_probe_write_user 
> helper that may corrupt user memory!
> 
>    User process fault: interruption code 003b ilc:2 in 
> test_progs[2aa08d00000+b1f000]
> 
>    Failing address: 0000000000000000 TEID: 0000000000000800
> 
>    Fault in primary space mode while using user ASCE.
> 
>    AS:0000000081b381cf R1:0000000081b2c00f R2:0000000081bf400b 
> R3:0000000000000024
> 
>    CPU: 0 PID: 804 Comm: new_name Tainted: G           OE 
> 6.8.0-rc1-g690b912d8bb7-dirty #215
> 
>    Hardware name: IBM 8561 LT1 400 (KVM/Linux)
> 
>    User PSW : 0705000180000000 000002aa0912bbe6
> 
>               R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:0 PM:0 RI:0 EA:3
> 
>    User GPRS: 0000000000000000 0000000000000000 0000000000000000 
> 000002aa0dbcf5c0
> 
>               ffffffff00000000 0000000000002710 000003ffb6d00900 
> 000003ffc7877ad7
> 
>               000003ffb6d001e0 000003ffc7877ad6 000003ffc7877ad8 
> 000003ffb6cffe50
> 
>               000003ffb8e26f88 000003ffb6d00900 000002aa0912bb88 
> 000003ffb6cffe50
> 
>    User Code: 000002aa0912bbd6: e310b0b40014	lgf	%r1,180(%r11)
>               000002aa0912bbdc: eb110004000d	sllg	%r1,%r1,4
>              #000002aa0912bbe2: b9080012		agr	%r1,%r2
>              >000002aa0912bbe6: 58101008		l	%r1,8(%r1)
>               000002aa0912bbea: 5010b0bc		st	%r1,188(%r11)
>               000002aa0912bbee: e310b0a80004	lg	%r1,168(%r11)
>               000002aa0912bbf4: e32010080004	lg	%r2,8(%r1)
>               000002aa0912bbfa: e310b0bc0016	llgf	%r1,188(%r11)
> 
>    Last Breaking-Event-Address:
> 
>     [<0000000000000001>] test_progs[2aa08d00000+b1f000]
>    ./ci/vmtest/vmtest_selftests.sh: line 69:   116 Segmentation fault 
>    ./${selftest} ${args} ${DENYLIST:+-d"$DENYLIST"} 
> ${ALLOWLIST:+-a"$ALLOWLIST"} --json-summary "${json_file}"
> bash: line 5: cd: /tmp/work/bpf/bpf: No such file or directory

Hi,

I think this is an intermittent failure that has nothing to do with
your patch. I could not reproduce it after a few hundred iterations of
the ringbuf test.

However, I have taken a look at the code and I think I know what is
happening here. The test starts poll_thread(), and later calls only
pthread_tryjoin_np(). When a test machine is overloaded, the thread
startup may be arbitrarily delayed, and it looks as if in this case
it's really started only after ring_buffer__free().

So I would suggest replacing the final pthread_tryjoin_np() with
pthread_join().

Best regards,
Ilya


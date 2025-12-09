Return-Path: <bpf+bounces-76342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9305BCAF1DB
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 08:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 363463023576
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8572848A2;
	Tue,  9 Dec 2025 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lwetXCQP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A627603C
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264804; cv=none; b=XL+UiqbSbSnCnSgyOt3kf0o5yCe4Jjyxptj9y2xzNaKOMH226Dif8iGPzgTMluVhwgcMen+LSXHD6lpdq90rAn00Mf5OWLX+hQElD1UBA6KRflRHXYu5E4SSp3+vXYxLbM8ruKmEzQAxBZSL94aV7XSUrX8kVE9nma7Z6lxi1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264804; c=relaxed/simple;
	bh=cC961yCL+20Byf1RUxfTuMKrBPnHNDFCgo286ymhrZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j6AWbBVVkljl1UUvYz7uPv4F3qjrOnCs92OKRw5r1wYn5xC5zp78RW1yEMFAUsMxdHVMv+Grn+YuU+O8nVmaZy48mSpSSS6VidVctz7l3CuMST8Y2RlTEgdyOPv/xp2IEH/ZobTw8yrdonLZZTDgLTVFolInIWrCPHYP2bTt2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lwetXCQP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B91N625027737;
	Tue, 9 Dec 2025 07:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=1iobDRsXWoR2bC2aCOlwtIeAchMw
	if40qOWPeiqwjUI=; b=lwetXCQPV8+r33MjtXBUb74Yx79Py/GXfu5ZhI2Gh0YF
	aj9Mj01GL1R4WQCsrlTr74DHVq6Din6RvuiR3giL2oF9abqWO8Q/y7nWiOyJBd/v
	4ru4tOBHrEPY5HnJ5mLZuU24vLnLO6Pe63TGh8xpaSlHpRgIkmWo/L1vD1YvbrN4
	cVvrJs5qpsrY1Xt/Lvhx6riWQ4TXUoE7yL9K7rROWuZoKslG+JIe6GEIioKLDlTh
	FVUxv0dX0soh0d6smLh3MmsgjlTNxNIJ4KRHkLSivj32Ihqica2xoNwzUgvNZ7h+
	CECRNi7ef4JtoZq2lhJA/tP54aj2CzdjiIv6ifuiwA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvk91t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 07:19:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B97E8uq025418;
	Tue, 9 Dec 2025 07:19:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvk91p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 07:19:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B946656026813;
	Tue, 9 Dec 2025 07:19:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h11c5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 07:19:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B97Jiqq25625046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 07:19:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7ED220043;
	Tue,  9 Dec 2025 07:19:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1692420040;
	Tue,  9 Dec 2025 07:19:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.32.152])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Dec 2025 07:19:42 +0000 (GMT)
Date: Tue, 9 Dec 2025 12:49:40 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        puranjay@kernel.org, puranjay12@gmail.com, hbathini@linux.ibm.com
Subject: [BUG] poweprc64/bpf: bpf arena broken after kmalloc_nolock() change
Message-ID: <aTfNjDu1Lbc-LPtO@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IMW_AxiLaElSknwMf5Qn7-t_7sFdllYQ
X-Proofpoint-ORIG-GUID: 3LpXnZl-zbgPAlJMQmOTRoBAUlN64l3a
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6937cd93 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SkRyruUFou6qKIdcof0A:9 a=_dHSWcl8iwo7eW4n:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX4lKzZt0QuaPN
 Dg95Wwo9UaIwGtYbf2AOBzg62N6u12HBPN7MFe+n2zRDWHyx87ebhYRqLI/RxYaRuBLwGgeRMKZ
 9Rnpgd4HS8TMbYXsEdvoONCUIZDcCpupMLyvcMk+SpWUyUxTH74Woqawp9SJzXYKLUCxSCDPGv7
 pmg1LJBsjKXVHvVB472H8sO/gtqetkguBTdoWZn42AKNOO0gaEQmgqUq33oklcckgZPkZH3YEtp
 fmoJ/nx2eRkKvLFwOdKsGRPA5M/87+4m+3ER+4ooU0BAR7N52FNat9OyNdDDqrntNK+nSYDuY65
 Po1nOVrZS3wen77VlhhB2rPkj5WwR5QeK6SYO1n3SW5DiwI5KgmBri6RsUgylrY4jMUdT+CErMk
 WzsdukyjUROaNQgtS5S+Jh44jOc0ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

Hi,

On powerpc, bpf arena support was enabled by:
  a2485d06cad3 ("powerpc64/bpf: Implement bpf_addr_space_cast instruction")
and the status of selftests was:

# ./test_progs -t arena
#3/1     arena_atomics/add:OK
#3/2     arena_atomics/sub:OK
#3/3     arena_atomics/and:OK
#3/4     arena_atomics/or:OK
#3/5     arena_atomics/xor:OK
#3/6     arena_atomics/cmpxchg:OK
#3/7     arena_atomics/xchg:OK
#3/8     arena_atomics/uaf:OK
#3/9     arena_atomics/load_acquire:SKIP
#3/10    arena_atomics/store_release:SKIP
#3       arena_atomics:OK (SKIP: 2/10)
#4/1     arena_htab/arena_htab_llvm:OK
#4/2     arena_htab/arena_htab_asm:OK
#4       arena_htab:OK
#5/1     arena_list/arena_list_1:OK
#5/2     arena_list/arena_list_1000:OK
#5       arena_list:OK
#6/1     arena_spin_lock/arena_spin_lock_1:SKIP
#6/2     arena_spin_lock/arena_spin_lock_1000:SKIP
#6/3     arena_spin_lock/arena_spin_lock_50000:SKIP
#6       arena_spin_lock:SKIP
#7/1     arena_strsearch/arena_strsearch:OK
#7       arena_strsearch:OK
#417     stream_arena_fault_address:SKIP
tester_init:pass:tester_log_buf 0 nsec
process_subtest:pass:obj_open_mem 0 nsec
process_subtest:pass:specs_alloc 0 nsec
#504/1   verifier_arena/basic_alloc1:OK
#504/2   verifier_arena/basic_alloc2:OK
#504/3   verifier_arena/basic_alloc3:OK
#504/4   verifier_arena/basic_reserve1:OK
#504/5   verifier_arena/basic_reserve2:OK
#504/6   verifier_arena/reserve_twice:OK
run_subtest:pass:obj_open_mem 0 nsec
run_subtest:pass:unexpected_load_failure 0 nsec
do_prog_test_run:pass:bpf_prog_test_run 0 nsec
run_subtest:fail:1299 Unexpected retval: 4 != 0
#504/7   verifier_arena/reserve_invalid_region:FAIL
#504/8   verifier_arena/iter_maps1:OK
#504/9   verifier_arena/iter_maps2:OK
#504/10  verifier_arena/iter_maps3:OK
#504     verifier_arena:FAIL
#505/1   verifier_arena_large/big_alloc1:OK
#505/2   verifier_arena_large/access_reserved:OK
#505/3   verifier_arena_large/request_partially_reserved:OK
#505/4   verifier_arena_large/free_reserved:OK
#505/5   verifier_arena_large/big_alloc2:OK
#505     verifier_arena_large:OK

All error logs:
tester_init:pass:tester_log_buf 0 nsec
process_subtest:pass:obj_open_mem 0 nsec
process_subtest:pass:specs_alloc 0 nsec
run_subtest:pass:obj_open_mem 0 nsec
run_subtest:pass:unexpected_load_failure 0 nsec
do_prog_test_run:pass:bpf_prog_test_run 0 nsec
run_subtest:fail:1299 Unexpected retval: 4 != 0
#504/7   verifier_arena/reserve_invalid_region:FAIL
#504     verifier_arena:FAIL
Summary: 7/27 PASSED, 6 SKIPPED, 1 FAILED


After commit f8c67d8550ee("bpf: Use kmalloc_nolock() in range tree") all
arena related selftests are failing for powerpc:

All error logs:
test_arena_atomics:pass:arena atomics skeleton open 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_atomics': -ENOMEM
test_arena_atomics:fail:arena atomics skeleton load unexpected error: -12 (errno 12)
#3       arena_atomics:FAIL
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_htab': -ENOMEM
test_arena_htab_llvm:fail:arena_htab__open_and_load unexpected error: -12
#4/1     arena_htab/arena_htab_llvm:FAIL
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_htab_asm': -ENOMEM
test_arena_htab_asm:fail:arena_htab_asm__open_and_load unexpected error: -12
#4/2     arena_htab/arena_htab_asm:FAIL
#4       arena_htab:FAIL
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_list': -ENOMEM
test_arena_list_add_del:fail:arena_list__open_and_load unexpected error: -12
#5/1     arena_list/arena_list_1:FAIL
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_list': -ENOMEM
test_arena_list_add_del:fail:arena_list__open_and_load unexpected error: -12
#5/2     arena_list/arena_list_1000:FAIL
#5       arena_list:FAIL
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_spin_lock': -ENOMEM
test_arena_spin_lock_size:fail:arena_spin_lock__open_and_load unexpected error: -12
#6/1     arena_spin_lock/arena_spin_lock_1:FAIL
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_spin_lock': -ENOMEM
test_arena_spin_lock_size:fail:arena_spin_lock__open_and_load unexpected error: -12
#6/2     arena_spin_lock/arena_spin_lock_1000:FAIL
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_spin_lock': -ENOMEM
test_arena_spin_lock_size:fail:arena_spin_lock__open_and_load unexpected error: -12
#6/3     arena_spin_lock/arena_spin_lock_50000:FAIL
#6       arena_spin_lock:FAIL
libbpf: map 'arena': failed to create: -ENOMEM
libbpf: failed to load BPF skeleton 'arena_strsearch': -ENOMEM
test_arena_str:fail:arena_strsearch__open_and_load unexpected error: -12
#7/1     arena_strsearch/arena_strsearch:FAIL
#7       arena_strsearch:FAIL
tester_init:pass:tester_log_buf 0 nsec
process_subtest:pass:obj_open_mem 0 nsec
process_subtest:pass:specs_alloc 0 nsec
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#504/1   verifier_arena/basic_alloc1:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#504/2   verifier_arena/basic_alloc2:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#504/3   verifier_arena/basic_alloc3:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#504/4   verifier_arena/basic_reserve1:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#504/5   verifier_arena/basic_reserve2:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#504/6   verifier_arena/reserve_twice:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#504/7   verifier_arena/reserve_invalid_region:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#504/8   verifier_arena/iter_maps1:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:pass:unexpected_load_success 0 nsec
validate_msgs:fail:920 expect_msg
VERIFIER LOG:
=============
=============
EXPECTED   SUBSTR: 'expected pointer to STRUCT bpf_map'
#504/9   verifier_arena/iter_maps2:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:pass:unexpected_load_success 0 nsec
validate_msgs:fail:920 expect_msg
VERIFIER LOG:
=============
=============
EXPECTED   SUBSTR: 'untrusted_ptr_bpf_map'
#504/10  verifier_arena/iter_maps3:FAIL
#504     verifier_arena:FAIL
tester_init:pass:tester_log_buf 0 nsec
process_subtest:pass:obj_open_mem 0 nsec
process_subtest:pass:specs_alloc 0 nsec
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#505/1   verifier_arena_large/big_alloc1:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#505/2   verifier_arena_large/access_reserved:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#505/3   verifier_arena_large/request_partially_reserved:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
=============
=============
#505/4   verifier_arena_large/free_reserved:FAIL
run_subtest:pass:obj_open_mem 0 nsec
libbpf: map 'arena': failed to create: -ENOMEM
run_subtest:fail:unexpected_load_failure unexpected error: -12 (errno 12)
VERIFIER LOG:
=============
=============
#505/5   verifier_arena_large/big_alloc2:FAIL
#505     verifier_arena_large:FAIL
Summary: 1/0 PASSED, 1 SKIPPED, 7 FAILED

This is because powerpc currently does not support 128-bit cmpxchg and
in-turn kmalloc_nolock() but new range tree implementation unconditionally
uses kmalloc_nolock().

Can use of kmalloc_nolock() be avoided for now or made conditional on
availability of arch support for it? I’m ready to implement a patch 
aligned with your preferred course of action.

Thanks,
Saket


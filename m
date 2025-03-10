Return-Path: <bpf+bounces-53712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D1A58CF2
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 08:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32A2188C457
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 07:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE81207A06;
	Mon, 10 Mar 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n2vvaeV1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23B17BA5;
	Mon, 10 Mar 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591924; cv=none; b=A08AqSOSmv+0GWLYrkYciW+FtP2Gc3soMpjaf6JRJRXsCdGh2QHeT+Qwqcyd+xJ2rZohQ9qbw16puamUT1oYho+okMj51FDFrFHgyYk9PnOneUBYLHaCeuilFWNJc+uk+bjYEMZ06F6De7CqUDVuSGZ4Fj58MncmMNFBcZipxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591924; c=relaxed/simple;
	bh=rKsTO5LX47N0+ZZyAveJWZ55BWBDvvRdlTC6FQa6dnk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=S4InB5dFfI90ZreamrnGzE1cVQLJUV8B36RGBmq/7+HG2iCox4OvwvboYWuhGfnQ1y4etU+hIvKWU+elycxLYzVmonlkFkTsT9uliSuHhh2X3hpwl4zMosnqks7gHLVsc0rH80iJixDJrdQKBTv+IAnHvkQDrYicNt0uOqokUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n2vvaeV1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529LFX1T026003;
	Mon, 10 Mar 2025 07:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=uZxD9vKXfhIO75YxNDUEG9t741O9
	MbHpkNRh0TDPByw=; b=n2vvaeV19ytY+VGFTXa7RQrOHEspHyDktDBv+qRza0Yi
	jBcHbpU1pEb4u3Ea4Eu/IB8h40m5AvN8dcldC0wkw85nvaLmuDWIXu0dwxRMO3ZX
	I6lD3W8FRrhBuYtqrLTaiJCKDBtRf4L1DJq9e154D2rRBJ5AC/2NWUEzYwzY6f9z
	ToY3EVdT7VH5aZS31SY3dxsFzusbwCPq9gj6/EX+qtdYV2jjILHB856IHIBr+WNl
	ALNn2Vn0qSi+VvM3LZ3c8wGhGLTUQDrh5bi1kl+Xa8ySfcIoUrreAwF0bvV6s8pK
	S9ul3PgpaLfaLzvTjLRAq0DN9Yy814ZTSYubj8VASw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459cdnjv1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:31:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52A7Vbqp006037;
	Mon, 10 Mar 2025 07:31:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459cdnjv1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:31:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52A46qdu013990;
	Mon, 10 Mar 2025 07:31:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1n0kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:31:50 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52A7Vnu531392414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 07:31:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 795915805E;
	Mon, 10 Mar 2025 07:31:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D0A58060;
	Mon, 10 Mar 2025 07:31:47 +0000 (GMT)
Received: from [9.61.254.32] (unknown [9.61.254.32])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Mar 2025 07:31:46 +0000 (GMT)
Message-ID: <7bc80a3b-d708-4735-aa3b-6a8c21720f9d@linux.ibm.com>
Date: Mon, 10 Mar 2025 13:01:45 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>, ast@kernel.org,
        memxor@gmail.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [bpf-next] selftests/bpf fails to compile
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jo3-rS4YfojS6bY2T7XFAWHVLUtJdrhn
X-Proofpoint-ORIG-GUID: RvtFME1iZ08Je-BohEbWF9OPFIAdHB7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=687
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100057

Greetings!!!

selftests/bpf fails to compile with below error on bpf-next repo with 
commit head: f28214603dc6c09b3b5e67b1ebd5ca83ad943ce3

Repo link: 
https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/

Reverting below commit resolves the issue.

Commit ID: 48b3be8d7f82bea6affe6b9f11ee67380b55ede8


Errors:

make

   CLNG-BPF [test_progs] arena_spin_lock.bpf.o
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:122:8: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   122 |         old = atomic_read(&lock->val);
       |               ^~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:126:37: note: 
expanded from macro 'atomic_read'
   126 | #define atomic_read(p) READ_ONCE((p)->counter)
       |                        ~~~~~~~~~~~~~^~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:43:41: note: 
expanded from macro 'READ_ONCE'
    43 | #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
       |                                         ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:122:8: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   122 |         old = atomic_read(&lock->val);
       |               ^~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:126:37: note: 
expanded from macro 'atomic_read'
   126 | #define atomic_read(p) READ_ONCE((p)->counter)
       |                        ~~~~~~~~~~~~~^~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:43:48: note: 
expanded from macro 'READ_ONCE'
    43 | #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
       |                                                ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:134:12: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   134 |         } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, 
new));
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:135:26: note: 
expanded from macro 'atomic_try_cmpxchg_relaxed'
   135 |         try_cmpxchg_relaxed(&(p)->counter, pold, new)
       |         ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:58:55: note: 
expanded from macro 'try_cmpxchg_relaxed'
    58 | #define try_cmpxchg_relaxed(p, pold, new) try_cmpxchg(p, pold, new)
       | ~~~~~~~~~~~~^~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:21: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       |                 ~~~~~~~~~~~~~~~~~~^~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:31:19: note: 
expanded from macro '__unqual_typeof'
    31 |         typeof(_Generic((x),                            \
       |                          ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:134:12: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   134 |         } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, 
new));
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:135:26: note: 
expanded from macro 'atomic_try_cmpxchg_relaxed'
   135 |         try_cmpxchg_relaxed(&(p)->counter, pold, new)
       |         ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:58:55: note: 
expanded from macro 'try_cmpxchg_relaxed'
    58 | #define try_cmpxchg_relaxed(p, pold, new) try_cmpxchg(p, pold, new)
       | ~~~~~~~~~~~~^~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:21: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       |                 ~~~~~~~~~~~~~~~~~~^~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:38:20: note: 
expanded from macro '__unqual_typeof'
    38 |                 default: (typeof(x))0))
       |                                  ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:134:12: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   134 |         } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, 
new));
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:135:26: note: 
expanded from macro 'atomic_try_cmpxchg_relaxed'
   135 |         try_cmpxchg_relaxed(&(p)->counter, pold, new)
       |         ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:58:55: note: 
expanded from macro 'try_cmpxchg_relaxed'
    58 | #define try_cmpxchg_relaxed(p, pold, new) try_cmpxchg(p, pold, new)
       | ~~~~~~~~~~~~^~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:39: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       | ~~~~~~~~^~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:47:59: note: 
expanded from macro 'cmpxchg'
    47 | #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), 
old, new)
       | ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:150:19: 
error: no member named 'pending' in 'struct qspinlock'
   150 |         WRITE_ONCE(lock->pending, 0);
       |                    ~~~~  ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:45:48: note: 
expanded from macro 'WRITE_ONCE'
    45 | #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
       |                                                ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:150:19: 
error: no member named 'pending' in 'struct qspinlock'
   150 |         WRITE_ONCE(lock->pending, 0);
       |                    ~~~~  ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:45:55: note: 
expanded from macro 'WRITE_ONCE'
    45 | #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
       |                                                       ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:163:19: 
error: no member named 'locked_pending' in 'struct qspinlock'
   163 |         WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
       |                    ~~~~  ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:45:48: note: 
expanded from macro 'WRITE_ONCE'
    45 | #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
       |                                                ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:163:19: 
error: no member named 'locked_pending' in 'struct qspinlock'
   163 |         WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
       |                    ~~~~  ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:45:55: note: 
expanded from macro 'WRITE_ONCE'
    45 | #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
       |                                                       ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:182:8: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   182 |         old = atomic_read(&lock->val);
       |               ^~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:126:37: note: 
expanded from macro 'atomic_read'
   126 | #define atomic_read(p) READ_ONCE((p)->counter)
       |                        ~~~~~~~~~~~~~^~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:43:41: note: 
expanded from macro 'READ_ONCE'
    43 | #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
       |                                         ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:182:8: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   182 |         old = atomic_read(&lock->val);
       |               ^~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:126:37: note: 
expanded from macro 'atomic_read'
   126 | #define atomic_read(p) READ_ONCE((p)->counter)
       |                        ~~~~~~~~~~~~~^~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:43:48: note: 
expanded from macro 'READ_ONCE'
    43 | #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
       |                                                ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:190:12: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   190 |         } while (!atomic_try_cmpxchg_acquire(&lock->val, &old, 
new));
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:138:26: note: 
expanded from macro 'atomic_try_cmpxchg_acquire'
   138 |         try_cmpxchg_acquire(&(p)->counter, pold, new)
       |         ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:60:55: note: 
expanded from macro 'try_cmpxchg_acquire'
    60 | #define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
       | ~~~~~~~~~~~~^~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:21: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       |                 ~~~~~~~~~~~~~~~~~~^~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:31:19: note: 
expanded from macro '__unqual_typeof'
    31 |         typeof(_Generic((x),                            \
       |                          ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:190:12: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   190 |         } while (!atomic_try_cmpxchg_acquire(&lock->val, &old, 
new));
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:138:26: note: 
expanded from macro 'atomic_try_cmpxchg_acquire'
   138 |         try_cmpxchg_acquire(&(p)->counter, pold, new)
       |         ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:60:55: note: 
expanded from macro 'try_cmpxchg_acquire'
    60 | #define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
       | ~~~~~~~~~~~~^~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:21: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       |                 ~~~~~~~~~~~~~~~~~~^~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:38:20: note: 
expanded from macro '__unqual_typeof'
    38 |                 default: (typeof(x))0))
       |                                  ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:190:12: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   190 |         } while (!atomic_try_cmpxchg_acquire(&lock->val, &old, 
new));
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:138:26: note: 
expanded from macro 'atomic_try_cmpxchg_acquire'
   138 |         try_cmpxchg_acquire(&(p)->counter, pold, new)
       |         ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:60:55: note: 
expanded from macro 'try_cmpxchg_acquire'
    60 | #define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
       | ~~~~~~~~~~~~^~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:39: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       | ~~~~~~~~^~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:47:59: note: 
expanded from macro 'cmpxchg'
    47 | #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), 
old, new)
       | ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:205:12: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   205 |         int val = atomic_read(&lock->val);
       |                   ^~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:126:37: note: 
expanded from macro 'atomic_read'
   126 | #define atomic_read(p) READ_ONCE((p)->counter)
       |                        ~~~~~~~~~~~~~^~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:43:41: note: 
expanded from macro 'READ_ONCE'
    43 | #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
       |                                         ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:205:12: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   205 |         int val = atomic_read(&lock->val);
       |                   ^~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:126:37: note: 
expanded from macro 'atomic_read'
   126 | #define atomic_read(p) READ_ONCE((p)->counter)
       |                        ~~~~~~~~~~~~~^~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:43:48: note: 
expanded from macro 'READ_ONCE'
    43 | #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
       |                                                ^
In file included from progs/arena_spin_lock.c:7:
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:210:16: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   210 |         return likely(atomic_try_cmpxchg_acquire(&lock->val, 
&val, _Q_LOCKED_VAL));
       | ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:138:26: note: 
expanded from macro 'atomic_try_cmpxchg_acquire'
   138 |         try_cmpxchg_acquire(&(p)->counter, pold, new)
       |                                 ^ ~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:60:55: note: 
expanded from macro 'try_cmpxchg_acquire'
    60 | #define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
       |                                                       ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:21: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       |                                   ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:31:19: note: 
expanded from macro '__unqual_typeof'
    31 |         typeof(_Generic((x),                            \
       |                          ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:77:39: 
note: expanded from macro 'likely'
    77 | #define likely(x) __builtin_expect(!!(x), 1)
       |                                       ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:210:16: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   210 |         return likely(atomic_try_cmpxchg_acquire(&lock->val, 
&val, _Q_LOCKED_VAL));
       | ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:138:26: note: 
expanded from macro 'atomic_try_cmpxchg_acquire'
   138 |         try_cmpxchg_acquire(&(p)->counter, pold, new)
       |                                 ^ ~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:60:55: note: 
expanded from macro 'try_cmpxchg_acquire'
    60 | #define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
       |                                                       ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:21: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       |                                   ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:38:20: note: 
expanded from macro '__unqual_typeof'
    38 |                 default: (typeof(x))0))
       |                                  ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:77:39: 
note: expanded from macro 'likely'
    77 | #define likely(x) __builtin_expect(!!(x), 1)
       |                                       ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:210:16: 
error: member reference base type '__attribute__((address_space(1))) 
u32' (aka '__attribute__((address_space(1))) unsigned int') is not a 
structure or union
   210 |         return likely(atomic_try_cmpxchg_acquire(&lock->val, 
&val, _Q_LOCKED_VAL));
       | ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:138:26: note: 
expanded from macro 'atomic_try_cmpxchg_acquire'
   138 |         try_cmpxchg_acquire(&(p)->counter, pold, new)
       |                                 ^ ~~~~~~~
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:60:55: note: 
expanded from macro 'try_cmpxchg_acquire'
    60 | #define try_cmpxchg_acquire(p, pold, new) try_cmpxchg(p, pold, new)
       |                                                       ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:52:39: note: 
expanded from macro 'try_cmpxchg'
    52 |                 __unqual_typeof(*(p)) __r = cmpxchg(p, __o, new); \
       |                                                     ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_atomic.h:47:59: note: 
expanded from macro 'cmpxchg'
    47 | #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), 
old, new)
       | ^
/root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:77:39: 
note: expanded from macro 'likely'
    77 | #define likely(x) __builtin_expect(!!(x), 1)
       |                                       ^
fatal error: too many errors emitted, stopping now [-ferror-limit=]
20 errors generated.
make: *** [Makefile:731: 
/root/bpf-next/tools/testing/selftests/bpf/arena_spin_lock.bpf.o] Error 1


If you happen to fix the issue, please add below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



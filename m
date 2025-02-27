Return-Path: <bpf+bounces-52724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3CCA47B9F
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 12:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053941892F48
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207A22FF30;
	Thu, 27 Feb 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QC2IN5rY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44C22FAE1;
	Thu, 27 Feb 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654732; cv=none; b=tL2Pln2jiBiJKGy9jNcJ/67DEPNDr67qfqM4xNrIfsJI8daH7IyN4xa3rGzUEn8bGKhJB/oL+dp2k/cwjJSPv/yihuMiyyGcD5DiZaXZdQKzBKw778/F9Xn34Jrn3iu38Z2+5+33DMdx4vwZjlpHuOYXSekjmA8G8h18R20rJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654732; c=relaxed/simple;
	bh=BAp6IZkgiyRD/RzyQXKxlsI0RKC6IU3pJOvuO9xE6Gk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Sm5aNK8J+DUfwmy/yZQL3wopzAywtq2gNFJ0+grQkaX0+scA6kVYTnpbbN/djhL6/NUJPlr1ntYDNwSzZHGnhahfcsAB5tGiasG+JmVmiqJY0H6DIpCuzFEC/sHupdhbQXZ8tV5ZVbkXWBdJjo1EmuSU7fbID3IHRJQGL7GzQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QC2IN5rY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R9VR8O014508;
	Thu, 27 Feb 2025 11:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VBvqaX
	UQxcsvpwV2aX/7sxnJGxIeXk+ZIcUf4CT2b9Y=; b=QC2IN5rYDDWFE2ABCxRtcT
	lFMnnHt/aIvwCyrOIz6oK2aHc/ktvSAQTyFS+39vqRypN8ohXp/kXsauhGhZC+hI
	Evddbqs4+0a43bltlrgbf1OwzI07GgAxlrw1o/fUsyPy/nvB4Bfzl+tqn9cKpWbu
	uyRUBcoOO1YV2CiMrwp25avbOmnVLnJP3NtRgkNmb2LFNJfbHpsmr2YL7BNJ0FRQ
	juy2MjVe2TdsjoSh89m20XMQbzx0yt2B7qF264cMiFonhs/KctASCg9rXQjuFrwV
	DQ707TUtl/MBaFI9EFmq35oAT/a1SqbRivnRU/2ZEudNB2paFuqhc4xqiaxyoBJg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452c3a2wp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:11:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51RBBpnR013432;
	Thu, 27 Feb 2025 11:11:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452c3a2wnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:11:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAjVR7002570;
	Thu, 27 Feb 2025 11:11:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jyxhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:11:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51RBBmVw17695162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:11:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4767E20043;
	Thu, 27 Feb 2025 11:11:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D1E920040;
	Thu, 27 Feb 2025 11:11:42 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.240.191])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Feb 2025 11:11:41 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v8 0/4] Tracing contention lock owner call stack
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20250227003359.732948-1-ctshao@google.com>
Date: Thu, 27 Feb 2025 16:41:28 +0530
Cc: "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, nick.forrington@arm.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB79B75A-896E-42B6-B206-314BA137E257@linux.ibm.com>
References: <20250227003359.732948-1-ctshao@google.com>
To: Chun-Tse Shao <ctshao@google.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p3SUz25bm8BfibT94Qp1_itJ50ZotSFB
X-Proofpoint-ORIG-GUID: xiDBKbydrwc80UQK6-AB1YvcbBUicya8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270083



> On 27 Feb 2025, at 5:58=E2=80=AFAM, Chun-Tse Shao <ctshao@google.com> =
wrote:
>=20
> For perf lock contention, the current owner tracking (-o option) only
> works with per-thread mode (-t option). Enabling call stack mode for
> owner can be useful for diagnosing why a system running slow in
> lock contention.
>=20
> Example output:
>  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex -E16 perf =
bench sched pipe
>   ...
>   contended   total wait     max wait     avg wait         type   =
caller
>=20
>         171      1.55 ms     20.26 us      9.06 us        mutex   =
pipe_read+0x57
>                          0xffffffffac6318e7  pipe_read+0x57
>                          0xffffffffac623862  vfs_read+0x332
>                          0xffffffffac62434b  ksys_read+0xbb
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>          36    193.71 us     15.27 us      5.38 us        mutex   =
pipe_write+0x50
>                          0xffffffffac631ee0  pipe_write+0x50
>                          0xffffffffac6241db  vfs_write+0x3bb
>                          0xffffffffac6244ab  ksys_write+0xbb
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>           4     51.22 us     16.47 us     12.80 us        mutex   =
do_epoll_wait+0x24d
>                          0xffffffffac691f0d  do_epoll_wait+0x24d
>                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
>                          0xffffffffac693ba5  =
__x64_sys_epoll_pwait+0x95
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>           2     20.88 us     11.95 us     10.44 us        mutex   =
do_epoll_wait+0x24d
>                          0xffffffffac691f0d  do_epoll_wait+0x24d
>                          0xffffffffac693943  __x64_sys_epoll_wait+0x73
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>           1      7.33 us      7.33 us      7.33 us        mutex   =
do_epoll_ctl+0x6c1
>                          0xffffffffac692e01  do_epoll_ctl+0x6c1
>                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>           1      6.64 us      6.64 us      6.64 us        mutex   =
do_epoll_ctl+0x3d4
>                          0xffffffffac692b14  do_epoll_ctl+0x3d4
>                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>=20
>  =3D=3D=3D owner stack trace =3D=3D=3D
>=20
>           3     31.24 us     15.27 us     10.41 us        mutex   =
pipe_read+0x348
>                          0xffffffffac631bd8  pipe_read+0x348
>                          0xffffffffac623862  vfs_read+0x332
>                          0xffffffffac62434b  ksys_read+0xbb
>                          0xfffffffface604b2  do_syscall_64+0x82
>                          0xffffffffad00012f  =
entry_SYSCALL_64_after_hwframe+0x76
>  ...
>=20
> v8:
>  Fix compilation error found by Athira Rajeev and Namhyung Kim.

Tested with v8 and compiles fine, thanks for addressing the issue.

Tested-by: Athira Rajeev <atrajeev@linux.ibm.com>

>=20
> v7: lore.kernel.org/20250224184742.4144931-1-ctshao@google.com
>  Remove duplicate contention records.
>=20
> v6: lore.kernel.org/20250219214400.3317548-1-ctshao@google.com
>  Free allocated memory in error patch.
>  Add description in man page.
>=20
> v5: lore.kernel.org/20250212222859.2086080-1-ctshao@google.com
>  Move duplicated code into function.
>  Remove code to retrieve undesired callstack at the end of =
`contention_end()`.
>  Other minor fix based on Namhyung's review.
>=20
> v4: lore.kernel.org/20250130052510.860318-1-ctshao@google.com
>  Use `__sync_fetch_and_add()` to generate owner stackid automatically.
>  Use `__sync_fetch_and_add(..., -1)` to workaround compiler error from
>    `__sync_fetch_and_sub()`
>  Remove unnecessary include headers.
>  Dedicate on C-style comment.
>  Other minor fix based on Namhyung's review.
>=20
> v3: lore.kernel.org/20250129001905.619859-1-ctshao@google.com
>  Rename/shorten multiple variables.
>  Implement owner stackid.
>  Add description for lock function return code in `contention_end()`.
>  Other minor fix based on Namhyung's review.
>=20
> v2: lore.kernel.org/20250113052220.2105645-1-ctshao@google.com
>  Fix logic deficit in v1 patch 2/4.
>=20
> v1: lore.kernel.org/20250110051346.1507178-1-ctshao@google.com
>=20
> Chun-Tse Shao (4):
>  perf lock: Add bpf maps for owner stack tracing
>  perf lock: Retrieve owner callstack in bpf program
>  perf lock: Make rb_tree helper functions generic
>  perf lock: Report owner stack in usermode
>=20
> tools/perf/Documentation/perf-lock.txt        |   5 +-
> tools/perf/builtin-lock.c                     |  56 +++-
> tools/perf/util/bpf_lock_contention.c         |  85 +++++-
> .../perf/util/bpf_skel/lock_contention.bpf.c  | 245 +++++++++++++++++-
> tools/perf/util/bpf_skel/lock_data.h          |   7 +
> tools/perf/util/lock-contention.h             |   7 +
> 6 files changed, 372 insertions(+), 33 deletions(-)
>=20
> --
> 2.48.1.658.g4767266eb4-goog
>=20
>=20



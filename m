Return-Path: <bpf+bounces-49484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1216A1921D
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D860116123A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E9121323A;
	Wed, 22 Jan 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YA/In+/n"
X-Original-To: bpf@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B9212D6F
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551523; cv=none; b=cQUocMqaAx4QbDz42wbDBVHvPebUEQnpOo9LzrZJOkH6vgEpm61RNsUDxcGE0M0ZRFf65uBi24yFt2gJXnRINgV+wztUqd8bIk4ni0ykJ3YdTy7VXj741qc0AcsTiwqwXkLuAg5ESibgrroV/GO4nT9iH3prNFeudxckNc+rxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551523; c=relaxed/simple;
	bh=ARUdgIgcuAll5lbVp+D8VJxo0QY958HvY5MloGYScpA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC:
	 References; b=Q13rfonf3iYX+20eNmXR6CAqjKW6ksESIOzg/lDpVZ+lvpzLTrvHHSrMugYcOKAmkHwPSBYS135aft5vY5yDFaKJQwcfETEOUFSF2fz71Y+GwygBjD3WdvqkkIup3UHqGZXUq6+nz+kNzGxocInHzgbF82GFpLTiyP1EEcaAGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YA/In+/n; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250122131158euoutp013b3e43869ed40eea1fc179b0e5e035e0~dBeZxz99-0266602666euoutp01h
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 13:11:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250122131158euoutp013b3e43869ed40eea1fc179b0e5e035e0~dBeZxz99-0266602666euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737551518;
	bh=7mbqFGEXZvm7aYX4VKOqowLZGB5dkjt6Zll3vBb629E=;
	h=From:Subject:Date:To:CC:References:From;
	b=YA/In+/nq7dDe1ouMzXVtcRVWIeWDlY4+uNLYtNZLecre+BObTViUqwbcsS0z0ef2
	 MVt1KpG/xY3A/S32BMhN+4EvSIvSySAeY9IG6pB/UdJP0qpbPICqxDVd+r3g5Xf6au
	 nKu9l6KhMml8jP3S6aehUoxYpOgUpsUNWDLxrbbw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250122131158eucas1p19c528eac4a5829e3534f734e970b4a28~dBeZUJsSl2303323033eucas1p1g;
	Wed, 22 Jan 2025 13:11:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.75.20821.D9EE0976; Wed, 22
	Jan 2025 13:11:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250122131157eucas1p14bc56b73e8598908574aab12ecdfc245~dBeY61S2_2776327763eucas1p1E;
	Wed, 22 Jan 2025 13:11:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250122131157eusmtrp285c046ddf173399bddd5200675492c99~dBeY6A2v60895308953eusmtrp2L;
	Wed, 22 Jan 2025 13:11:57 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-39-6790ee9d9831
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.5D.19654.D9EE0976; Wed, 22
	Jan 2025 13:11:57 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250122131157eusmtip1634725f49a828c0633603316ad4bb0ee~dBeYuizOw1581915819eusmtip1R;
	Wed, 22 Jan 2025 13:11:57 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id
	15.0.1497.48; Wed, 22 Jan 2025 13:11:56 +0000
From: Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH 0/2] modules: allow error injection
Date: Wed, 22 Jan 2025 14:11:12 +0100
Message-ID: <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHDukGcC/x3MwQqDMAyA4VeRnBdoCl1xrzJ2mG02I64diRNBf
	HfLjv/h+3cwVmGDW7eD8iomtbSgSwdpfJY3o+TW4J0Pjjzhp+bfzIasWhWlTJyWZpDiNQUfYk+
	Dg6a/yi/Z/uf74zhO5YIzk2kAAAA=
X-Change-ID: 20250121-modules-error-injection-176c525791b0
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
	Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <llvm@lists.linux.dev>,
	<iovisor-dev@lists.iovisor.org>, <gost.dev@samsung.com>, Daniel Gomez
	<da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737551516; l=3656;
	i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
	bh=ARUdgIgcuAll5lbVp+D8VJxo0QY958HvY5MloGYScpA=;
	b=PcU5HWw9TVFd8cSNB9w3Nf+zuENLCH0NMTyuynspDxOAlT5nB2u3QAdD9cwuG+djalybC/oxD
	Y7nIKh66Q7CAuLJM/TtC6bPWUJtPYk89E561D4TXrIid+O3nudLlujE
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
	pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xTVxjNfa/v9dml4a2I3HTMSRMdGgHBbbnC4jqH42VgIIuoMzGs2peK
	8sO0FIVtSccQlYzRDZzQwlY0na3YiaVgabRsjVBRyDIopFJqdIJsbhD5MRhD6CivZvx3vvOd
	833fubkULiojxVROfiGrzJflSkgBr61r/pfYhgmtYlvbcBKaW9DjaGbex0fTt90kutQ4iyOv
	qRZHLncHH/1j9ABUajdh6HaNDkffNl0i0ZizEkP9jnoSafRzBBqp6SDR1XNmAnm1owBZ+6cJ
	dMY8SqJn2gCGjDMTODKaxgk0UOfAkPvyIokeNrURUsh4nXcxpl3n5zMGq5qp8PbhjPXKOZJp
	1JzHmc7yUh7ze0sdYK7ZBnjMtHV9puCg4G05m5tTxCrjd34sOFo9bCJP3I06Vf2HntAAQ2QF
	WENB+g3o+qKVrAACSkSbALT0nMW4YgZAu+EOjyumATRrmrEXlnmXIdS4DODZ5tlVKoOfH1SJ
	aBuA7kFlEJP0Zujstq7w4fR2WNb5JxnEPHojbDk9tsIL6XQ4/KA2hF+G3XUjy0MpCl/2XnPE
	B2mcfg3eGK/Hg7sgbQfwjLOS4C5Kgr0/Va2EWEsPEvDG0M8rF+H0IICVA0aSU0XAhWoHj7N3
	YLC8zAa4BgtNvw3jHI6GtV+beRz+DFq6evic4boATl2fDL1ACrQMnQ/tDodP3TY+h6NgoP37
	kOY47J27GVpQCJee/RsamgwDFn+Ifxe6/r4FtOB13arYuv9j61bFNgD8Cohk1ao8BatKyGdP
	xqlkeSp1viLuSEGeFSx/1HtL7ik7aHg6GecCGAVcAFK4ZK0wMKJViIRyWXEJqyzIVqpzWZUL
	vELxJJHCix2nFSJaIStkj7PsCVb5ootRa8QarEi9LvFCRlXKkz3bzUu+RxmpqdmP7fXPHz+U
	Tny6+cOX/M3sV92SzEV5WkvrXvkmX6CPPSg+4vDXPv9BufirtVjsGN9V4NuTHlYyuOuvDF/W
	oZIpzTvVqTJd5G7hwlz7gTfDYu6lqPVZGx4kSkebcrckjT0S7IgYfbXfNHQ451T7jtn0rfft
	++3lH0nbqu4Q25I3XIhxO2PTj0UnxolORlj29bYUGXZ69kanUY6ISSxKWXTgLc/7h9wZ30Rl
	N9YkN7vCPgiUxnhixPtU6+r7etKMxU/kCbHvwS71Vm+53hvf/Ulr5rH9SaLs3s6UzxsScNeX
	tvseSVa4ZEK6+9b67y7+eFXCUx2VJWzBlSrZf0+8uEUXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xu7pz301IN1h5U8Hi++/ZzBZfft5m
	t/h85DibxeKF35gtbqyYwWxx6Ph+dosfS68wWjTtWMFkcWTKLGaLaasXs1k839fLZHF51xw2
	i4bZ31ktnkzZz2axpnMlq8WNCU8ZLTZd/sxq0b7yKZvFhwn/mSyWfnnHbLF0xVtWi6szdzFZ
	HF/+l83iweptrA4SHjf2nWLy2DnrLrvHgk2lHl03LjF7bFrVyeaxsGEqs8fRtiYWjxebZzJ6
	rN9ylcXj8ya5AK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
	stQifbsEvYzJd1awFZySqZj8cjZrA+MC8S5GTg4JAROJn4cWsHQxcnEICSxllNg6bzYTREJG
	YuOXq6wQtrDEn2tdbBBFHxklPu85yg7hbGGUmP/9LTNIFZuApsS+k5vYQWxhAWOJlqOv2UBs
	FgFVic2tz8HivAI+EnfuzYCyBSVOznwCtJqDgxmod/0ufZAws4C8xPa3c5hB5ksI7GCUmHN9
	LiPEFVYSZw/0g10hInCNVWLKvFOMIA6zwDVGid6rS9kgqkQlfk/exQLRvp9J4vSxBqgnUiW2
	X1kCVaQoMWPiShYIu1bi1f3djBMYxWYhuWoWwlWzkFy1gJF5FaNIamlxbnpusZFecWJucWle
	ul5yfu4mRmBy2nbs55YdjCtffdQ7xMjEwXiIUYKDWUmE9/+TCelCvCmJlVWpRfnxRaU5qcWH
	GE2BITORWUo0OR+YHvNK4g3NDEwNTcwsDUwtzYyVxHnZrpxPExJITyxJzU5NLUgtgulj4uCU
	amDaZ2tftjJkd/b7W+7MJgu2mf/Tj9tZfS/49KyZCm467BOOxP636y8+U/Q1sEIsZc/r/S+/
	zT+uIZN+OcV3rXV0ioJjib3HvEO+xaJ99fuUZCzPSn53Wbh26v7Kk0ezVh08uHzyAnO2M15i
	jgU9QcWvC9Z9vPt9WvLU3Sucq6SFr+93YfIWOTlZaJ1azG9O8S2PFPl3B+/dxNbLFuIV73As
	z2XOdMYay5gb78P1nq9lXJA+o9Kz7uilZZqObIuYrm5d/nXa0cBLFS2pXxiuCThscNm1+s0k
	Y90AXrO6P88uGWa/8VL6lMdoU/bo3LLUqSJG/1orjny8YPdWZe+DxVmKguWLf9vI/g52Sk0M
	Wb9ciaU4I9FQi7moOBEA/DJZUNcDAAA=
X-CMS-MailID: 20250122131157eucas1p14bc56b73e8598908574aab12ecdfc245
X-Msg-Generator: CA
X-RootMTR: 20250122131157eucas1p14bc56b73e8598908574aab12ecdfc245
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250122131157eucas1p14bc56b73e8598908574aab12ecdfc245
References: <CGME20250122131157eucas1p14bc56b73e8598908574aab12ecdfc245@eucas1p1.samsung.com>

Allow error injection during module initialization for testing.

This adds ALLOW_ERROR_INJECTION() annotation for complete_formation(),
do_init_module() and module_enable_rodata_ro_after_init() so we can test
the error path in these functions.

In addition, add moderr support, an eBPF based tool to inject module
errors in any of the above functions for a specific module name.

The following example is added to the moderr commit. Adding it also here
for convenience:

    Example: Inject error -22 to module_enable_rodata_ro_after_init for
    brd module:

    sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
    --error=-22 --trace
    Monitoring module error injection... Hit Ctrl-C to end.
    MODULE     ERROR FUNCTION
    brd        -22   module_enable_rodata_after_init()

    Kernel messages:
    [   89.463690] brd: module loaded
    [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
    ro_after_init data might still be writable

The tool is based on libbpf and is located under tools/bpf.

Here some specific questions for discussion.

* I've noticed that some users of ALLOW_ERROR_INJECTION() in the
kernel add the option to fail behind a Kconfig (Fault-injection
framework, FAULT_INJECTION) in lib/Kconfig.debug, such as FAILSLAB or
FAIL_PAGE_ALLOC. Shall we add similar condition for error injection
in modules?

* What other functions may people be interested in adding to the list of
suported for error injection?

* I found a more generic error injection tool (inject.py) [1] in
IOVisor/BCC (Ccing IOVisor mailing list as well). The tool seems to
be maintained and supports error injection based on a specified call
chain and optional predicates. However, it relies on the old and
deprecated Python eBPF/BCC infrastructure. Since there are other users
of ALLOW_ERROR_INJECTION(), I'm curious: is there a different generic
tool to generate error injection in the kernel already converted to
libbpf? Do users of ALLOW_ERROR_INJECTION() still depend on inject.py
tool?

[1] https://github.com/iovisor/bcc/blob/master/tools/inject.py

Additionally, would it make sense to develop an in-tree tool with
libbpf support for this purpose? This approach might require rewriting
inject.py in libbpf and/or extending moderr to include inject.py
features (probably replace and rework some of the current functionality
in moderr).

moderr uses an enum to detect which kprobe function to override the
return value. I think adding bpf_get_stack()/bpf_get_stackid() support
would avoid the need for hardcoding the kprobe detection mechanism.
This approach could also be used for navigation of the call stack as in
inject.py. Are there any alternative methods to achieve this that avoid
relying on enumerating the fuctions to probe?

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
Daniel Gomez (2):
      module: allow for module error injection
      moderr: add module error injection tool

 kernel/module/main.c          |   3 +
 kernel/module/strict_rwx.c    |   2 +
 tools/bpf/Makefile            |  13 ++-
 tools/bpf/moderr/.gitignore   |   2 +
 tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
 tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
 tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
 tools/bpf/moderr/moderr.h     |  40 +++++++
 8 files changed, 515 insertions(+), 3 deletions(-)
---
base-commit: 232f121837ad8b1c21cc80f2c8842a4090c5a2a0
change-id: 20250121-modules-error-injection-176c525791b0

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>



Return-Path: <bpf+bounces-34426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78B592D86A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14859B2232E
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE3196455;
	Wed, 10 Jul 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m7+trm4o"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011072.outbound.protection.outlook.com [52.103.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C398195B14;
	Wed, 10 Jul 2024 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636922; cv=fail; b=Zs9doXpeNG/uSIDZHb9UqCsG3GzBYYYObRi1xXGYT+D4VhYXue3fdzNiTNY54LLpvVMXIp+YZn80ULwfFKae5ltza/zpT/o9LKA/M7WyGX7TpsHoiGySgyq1/Bg+tLjdDPOHkpGMTu2ekY+HhEB605WY6Qu1MtD4cMBZdrbxaGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636922; c=relaxed/simple;
	bh=12yD4dH6HWiTYvo1eUA+0t7n9KrtKottehF0SuRI1bc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rKK7bKFKNRjPW+3hWZypIaR3EYrT8/mqlDSCoLJxunNTHKUuwxAs4oMbA6HgevHOIAoJhpDA8fbB+3E9W95KINAMZMOXY1TNiaVVZSWEpCnZyhRkRnmPFVr33yAH9NvnvdU5BPaJL7ssp6d4eJPwCgOvQlLAfsARuETHuHIttKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m7+trm4o; arc=fail smtp.client-ip=52.103.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOpJUsIcxDr71kjbQKEWGTBF/c0cqdx5nu/rUAL3uxcv87CTrQ66/RZhpntKA9Cd0bLe6ZqgdaY+YsHFW9dOSxBivUkdqkG/MQ8u0Nddh3pzACHk+/ToEn3ZjQj9X//i95VeYS6NY0FOztbyphuPCgRC81l/qzT7hi4mOW8wU/H5m7ago5/1HEj3za18RyQKWRWTI1LKUBZwaAyCwMyb4qMKOsKI2uJD1buZIx9/yi+mVmJqQnY6hCpblfwim9wvdD9oJMUNmxyhDP980frjQj8SWLsVa8V1AhbyNPIZ8ui9Yv7CHRg8k6Pn/q1xglVGH+rpPO+/NgKwDMFTkVTQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj5LnHTqpAzhQLyj56rDnRJAYiVoVNq82NIQsSBqI0M=;
 b=oCITsnUFWDTiUgxuaShvUXFYvHoYKmbD6F2lSE+a60Ih7GLWCDof/W2/dnWr6igqRAYIAabgFogZZfXQq39dynE2zY1dSM1PHEWZdKOqElqH7zz4WzxCf5vGfsqqitdfsyFfp4rWEVlogxWsHXYSiWyoCaQ+QB+AuMlloQIounmNWycyvOK0a4DUPMLClDxClCKhYPKCFfeIS5e2tUiDuTfhmBbBw1MD3vwRZxeqyZYtfWGHIybjKy5aOU+DkQWtrA9s8YSfc2O/cvqbnf/2ZBRzSM1cbDBi2r7+RyXK+rRjXB4pKUNGKl6gfDBz4nGu7/wCI62b4hZxD946dqwt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj5LnHTqpAzhQLyj56rDnRJAYiVoVNq82NIQsSBqI0M=;
 b=m7+trm4oQgz6Q2eb5CArgGyBR7XseVswPO2ofeO3OyMfR0uP6mEpYQ7VE/Hw7oHKJM3TkVvJmZSZu+SGc1JIE5Ki+dzIIAqphOcE8dn0TtOJ6ZsLog1Dgo8Na5k63L/nD5qp5qCPddBe/nBVzhAF5WwsDXE58GMOocDMLAPl3BaDu0FgJaqwDVTwcs5z+xkD0oZJmDWAjz2uw40rLB+rjD6AXx2lSa8NjOQWrajJdb2cugY1cUZTZXBHEQXj2lSuUj9ADshfUV9HcKA9+qw8rjhLpo9kn37QdYhDqOYgUUZEiN/fP8xLXNDVTFSBz60y9cR234PM84c4RZkrEKntLw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:41:56 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:41:56 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/16] bpf: Checkpoint/Restore In eBPF (CRIB)
Date: Wed, 10 Jul 2024 19:40:44 +0100
Message-ID:
 <AM6PR03MB58480B81F491E8A34241EB3E99A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [AcTpxp1mSewBFRZyEk7pL9kmuL8t3G9Q]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 715a525d-751c-4ac0-da9c-08dca10ff96d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|4302099013|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	OaEr6Eq6mQClNY9ai7cTh1VCU2JocYaBGbWyTZIRL0jPTDZnBI01/UAzYkJ+jxADG7P56c44YC5mwdtcuDhLgeYMhZ7unBuBgpxDVoeVU6exlx1ZT5ltN5WYrHXE8n9+hJRGlZF6UdnUZ23UKT+eZZL2q0/LJNmDAMhwfs4wnEChQ2ovNTukxKTyrFIk4FosnOqUonCeWRzY3vknBhzkBD7MXA+tAvZcWWdSvOY7G219SynV22xze7sPiKY+4rO+S05Li4T5v4xqr1kW0eMNn2kj9yFz8eYskMe3eopkQ0Y1tWDtGPTLN+UTu6MH1ZDmoJ+uMcW3z68QYfBpW2+hZp9feleLsK0o2HMGdJERw4I1llkgPD6TjOi1aTmPmfzCOxP4W70aQ+qhSUWd4wbkPuAuyJRk0waPIQXXD8uTdprnSa+bcUHxYW5pDDULLiG8+zTxjGoh0yxIPseKyJLRbkslVO388TP+b6XHpFGGoio0z6hR7/BXF0fzA9on3fFNSbnweRXGvgWtnRHl/0VEesy1RRBcbU/lkxdO99PaUhGtWktwNy+4kgdanMPDX53t196s1UAe2DB33fTFisFmq4vXOqYhOeo+pCOCXv4J52qeyj8JDdLTSeP/jSQrVZsgp+jYEvH8uUaq53FZt4vAcqUTqq2Fwho43E39Us+Iokr44a7XDCUiPuTjpy8Iv3x3DzS4z4czkmwCvZbYSWWGH/a5Ajevgvof6qFk9NEX4macfmGDWYxfCQtg2HRyhbxw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HA9g8OtsMQ4X/rrFX9lk7AL4NeBtGuJ8UJ9jNxjpmt44aTToyeGE+gsSt6jF?=
 =?us-ascii?Q?XBUTHKM+Th+VABX6bAzIillMu116b6dDXa8WR2grHul6pQ7+uTocqsFYt8r4?=
 =?us-ascii?Q?+JuccjdlqJp7TD205BZQ5HcJ8AxdfdhZi9fsTKCrBpPyoSCivDTcily3x5Qg?=
 =?us-ascii?Q?5vK5xkdXhlg8PbrXs/Y31Uc23q9s+s2JTko76H9XPojllipYshf1TKd8Ypla?=
 =?us-ascii?Q?rCWXEADe2zaWR/yGN9kdqi/4R3yBXYTTcDYmazRdQp/8Yi2vqASiK2cyR86Y?=
 =?us-ascii?Q?l6z9pNX9FhbC2SXHE5maQyaDhuSapqREDf1PeT4w3W2IiQTGrEZVSqY9Zmd3?=
 =?us-ascii?Q?Mtv54WhZjmLJ+7aovM+VWXXB/XDJwNCT5sIBkLIqIQDfzPtpxn94KZHD+h3W?=
 =?us-ascii?Q?LhRKKAjYKHdblcXRKGDJdfzhofSAMkjz1TKjc4wAVCGcCEKPYr3tFtUkl8oj?=
 =?us-ascii?Q?kAM9at3fWrQt7On/Eaqj6JJkoq1CzlrrBIKHchK/wMUkrdfdlYAE2kbGExlS?=
 =?us-ascii?Q?fI4fW9t2qnpWu6SKPhRhNxlmEHVFSCp+/wtRr6+Pta66WdA5aACtnQDreMhO?=
 =?us-ascii?Q?FBTC8EE3VXvgFa6PclncXOT2Y8CzUKKMCYvJ/DzIGbDbZaAg3J5/k5TAupAw?=
 =?us-ascii?Q?yy0yiaS5ZmHfTgSpYiRb0Atdq9+NbMadXU9sfp7HhgoAsKCzuuEVMGkEhMrg?=
 =?us-ascii?Q?2pCENoqgMFuYXlv584qXf3jCUTBECLjiOCvIFdP34CYs4I5Nk/57emggjKww?=
 =?us-ascii?Q?cVaVjV4+ZKlMWA7s6tkMe1Nu0YIer78LbiRyN0aUYHLK6qjwHuLwYbKDd59Q?=
 =?us-ascii?Q?ZNXY1wsbxRwcxFYSf8CAA5hcLVjSEv1zlnFzwjuVYNXrQcbevY9IxBL0rVX8?=
 =?us-ascii?Q?TWSRmXFoKtVcXItsmpQNmpmhQ7k/Q5FGCPluLi4b3sFxB2EMA09N3ILqOHN/?=
 =?us-ascii?Q?EzZ7JbbsDYdv9lO5mPlJub9Xaz5chc/jC9SexTckbSgYDs508SzyB81EViSt?=
 =?us-ascii?Q?toLV8C97fGlLH11x8vkdftd258EF3tgKz0hQEnDCkPa1RBUnjRfrQLKIEtWf?=
 =?us-ascii?Q?n/NHX8yZyIE5fDC9xHDqnRF01L1xdipSacNBlB1j5WmaR3hp/zoKAOMDvZQt?=
 =?us-ascii?Q?EVNpD+i4X6uMMK7StI1QlzR8Cjyf7vQTx8fxWguB8j1UpoR0+5CFfpcTqCFl?=
 =?us-ascii?Q?p11xRWktFM8y4/f2oat9kBFK99P2DsJSaowVhEttv+q68UwhusvTNZlJfp8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715a525d-751c-4ac0-da9c-08dca10ff96d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:41:56.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

Overview
--------

This patch series adds a new bpf program type CRIB (Checkpoint/Restore
In eBPF) for better checkpoint/restore of processes. CRIB provides a new
way to dump/restore process information for better performance, more
flexibility, more extensibility (easier support for dumping/restoring
more information), and more elegant implementation.

Motivation
----------

The original goal of the CRIU (Checkpoint/Restore In Userspace) project
was to implement most of the checkpoint/restore functionality in
userspace [0], avoiding placing most of the implementation in the kernel.
The CRIU project achieves this goal and is currently widely used for
live migration in the cloud and works well in most scenarios. However,
the current technology that CRIU relies on is not optimal and has
some problems.

[0]: https://lwn.net/Articles/451916/

1. CRIU relies heavily on procfs to get process information (checkpoint)

Procfs is not really a good place to use for checkpointing processes
(same for sysfs).

- Lots of system calls, lots of context switches (each file needs to
open, read, close)

- Variety of formats (each file format is different and parsers need to
be implemented for each format)

- Fixed return information (if the information needed is not currently
supported by procfs, even if it is just a struct member, the upstream
kernel code still needs to be modified to add it)

- Non-extensible formats (the format of some files in the procfs cannot
be extended without breaking backward compatibility)

- Lots of extra information, slow to read (not all information in some
files is useful for checkpoint, and text parsing is inefficient)

More detailed summary of why procfs is not suitable for checkpointing
can be found in [1].

[1]: https://criu.org/Task-diag

Andrey has tried to replace insufficient procfs by using netlink 
(task_diag) [2], but it was not accepted by upstream for reasons
[3][4][5][6]:

- netlink is unable to elegantly obtain the pidns and userns
of processes

- Since the namespace issue cannot be resolved elegantly,
obtaining process information via netlink can lead to credential
security issues.

[2]: https://lwn.net/Articles/650243/
[3]: https://lore.kernel.org/linux-kernel//CALCETrVg5AyeXW_AGguFoGCPK9_2zeobEgT9JJFsakH6PyQf_A@mail.gmail.com/
[4]: https://lore.kernel.org/linux-kernel//CALCETrVSRkMSAVPz9JW4XCV7DmrgkyGK54HRUrue2R756f5C=Q@mail.gmail.com/
[5]: https://lore.kernel.org/linux-kernel//CALCETrW4LU3M2OAWjnckFR-rqenBjV+ROBi8B3eOo=Y_mCWfGQ@mail.gmail.com/
[6]: https://lore.kernel.org/linux-kernel//CALCETrUzOBybH0-rcgvzMNazjadZpuxkBZLkoUDY30X_-cqBzg@mail.gmail.com/

2. Some process status information is difficult to dump/restore through
normal interfaces

One example is checkpoint/restore for TCP sockets, where we are unable
to get the underlying protocol information for TCP sockets through
procfs (or sysfs), or through the normal socket API. Here we need to
add TCP repair mode [7][8], which works but is not an elegant approach. 

In TCP repair mode, we need to change (hijack) the behaviour of the
system calls, including recvmsg and sendmsg, used to dump/restore
packets in the socket write/receive queue. In TCP repair mode,
additional getsockopt/setsockopt optnames need to be introduced to
dump/restore the underlying TCP socket information such as sequence
number, send window, receive window, max window.

[7]: https://lwn.net/Articles/495304/
[8]: https://criu.org/TCP_connection

The above approach to extending system calls may be feasible, but not
good practice:

- The structure of the data returned by each system call API is roughly
fixed at the moment it is added. If we need to add new members, then we
may need data structures V1 and V2. If we want to remove members we no
longer need, it would be painful because we need to maintain backward
compatibility. More often we need new extensions to system calls,
such as the new getsockopt optnames.

- We need case-by-case extensions to system calls. As more and more
features are added to the kernel (e.g. io uring, bpf),
checkpointing/restoring these features via the normal API will become
more and more difficult (or even impossible). We have had to continue
to add (extend) lots of single-purpose (perhaps only for
checkpoint/restore) interfaces for various kernel features ,
more xxx repair modes, ioctl commands, getxxxopt/setxxxopt optnames.
Obviously, these interfaces are not elegant and may even be
considered cumbersome.

CRIB introduction
-----------------

CRIB is a new bpf program type that is not attached to any hooks
(similar to BPF_PROG_TYPE_SYSCALL), runs through BPF_PROG_RUN, and is
called by userspace programs as eBPF API for dumping/restoring
process information.

The entire CRIB consists of three parts, CRIB kfuncs, CRIB ebpf programs,
and CRIB user space program.

- CRIB kfuncs provides low-level APIs. Each kfuncs low-level API is only
responsible for one small task, such as getting a specific file object
based on the file descriptor of a process.

- CRIB ebpf program provides high-level APIs. Each CRIB ebpf program
obtains process information in the kernel by calling the CRIB kfuncs
API and returns the data to the userspace program through ringbuf.
Each CRIB ebpf API is responsible for some relatively complex tasks,
such as getting all the socket information of a process.

- The CRIB userspace program is responsible for loading the CRIB ebpf
program and calling the CRIB ebpf API, deciding what needs to be dumped
and what needs to be restored, and saving the dumped information so that
it can be read during restoration.

With the above CRIB design, the CRIB kfunc API in the kernel can be kept
simple enough that it does not require much modification even in the
future. Each kfuncs can be easily kept reliable without a lot of
complicated code.

Complex ebpf programs and userspace programs are maintained outside
the kernel, and CRIB ebpf programs are maintained with
CRIB userspace programs.

My current positioning of CRIB is that CRIU as CRIB userspace program
and CRIB ebpf program can be used as a new engine for CRIU, a new
and better way to dump/restore processes which has higher performance
and can dump/restore more information.

Why CRIB is better?
-------------------

1. More elegant way to get process information

If xxx repair mode, ioctl, getxxxopt, setxxxopt are like using
gastroscope, colonoscope, nasal endoscope, and we need to keep looking
for (add) more "holes" in the kernel for physical examination
(dump/restore information), then using CRIB is like putting an
intelligent micro physical examination robot (ebpf) into the kernel
and letting it work inside the kernel to collect all the information
and return.

We no longer need to open more inelegant "holes" in the kernel, and we
no longer need to add more interfaces that are only used for
checkpoint/restore.

2. More flexible and extensible

CRIB ebpf programs are maintained with CRIB userspace programs,
which means that CRIB ebpf programs do not need to provide stable APIs,
do not need stable structures, and can continue to change flexibly with
the needs of CRIB userspace programs.

Most of the information in kernel data structures can be obtained
through BPF_CORE_READ, so there is no need to add trivial CRIB kfuncs,
and the trivial code for obtaining the structure members can be kept
outside the kernel in the CRIB ebpf program. This means that this part of
the code can be added or removed flexibly.

CRIB kfuncs focuses on implementing dump/restore that cannot be done by
simple data structure operations.

3. Higher performance

- Since CRIB is very flexible (CRIB ebpf programs are changeable), we
can dump/restore just enough information and no additional information
is needed. 

- CRIB ebpf programs can return binary data (not text) via ringbuf,
which means no additional conversion or parsing is required.

- With BPF ringbuf, we avoid lots of system calls, lots of context
switches, and lots of memory copying (between kernel space and
user space).

4. Better support for namespaces and credentials

Since CRIB ebpf programs can access the task_struct of a process,
it is simple for CRIB ebpf programs to know the current namespace
(e.g., pidns, userns) and credentials of a process, and there is no
situation where CRIB cannot know that a process has dropped privileges.

The problems in the netlink method mentioned earlier do not exist
in CRIB.

Proof of Concept
----------------

I have currently added three selftest programs to demonstrate the
functionality of CRIB.

- dump_task shows the performance comparison between CRIB and procfs.
CRIB takes only 20-30% of the time of the procfs to obtain the same
process information.

- dump_all_socket shows that CRIB does not need to rely on procfs to
get all the socket information of a process, and can get the
underlying protocol information (e.g., sequence number, send window)
of TCP sockets without using getsockopt.

- restore_udp_socket shows that CRIB can dump/restore packets from
the write queue and receive queue of UDP sockets without adding
additional system call interfaces and without UDP repair mode.

Shortcoming?
------------

Yes, obviously, loading the ebpf programs takes time.

However, in most scenarios, CRIU runs as a service and is integrated
into other software (via RPC or C API) such as OpenVZ , docker, k8s,
rather than as a standalone tool.

This means that in most scenarios CRIU will handle multiple
checkpoints/restores, but in this case CRIB ebpf programs only need
to be loaded once, and can be subsequently used like normal APIs.

Overall, it is worth it.

More?
-----

In restore_udp_socket I had to add a struct bpf_crib_skb_info for
restoring packets, this is because there is currently no BPF_CORE_WRITE.

I am not sure what the current attitude of the kernel community
towards BPF_CORE_WRITE is, personally I think it is well worth adding,
as we need a portable way to change the value in the kernel.

This not only allows more complexity in the CRIB restoring part to
be transferred from CRIB kfuncs to CRIB ebpf programs, but also allows
ebpf to unlock more possible application scenarios. 

At the end
----------

This patch series is not the final patch series, this is still a
proof of concept, incomplete in functionality and probably buggy,
but I think it is enough to show the power of CRIB, which is a
meaningful innovation.

(I know I did not pay attention to the coding style of the test cases
in selftest, as these are only for proof of concept, not real testing)

This is not only a new checkpoint/restore method, but also allows us
to think about what more eBPF might be able to do, and what more we
can unlock with eBPF.

I would like to get some feedback, welcome to discuss!

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Juntong Deng (16):
  bpf: Introduce BPF_PROG_TYPE_CRIB
  bpf: Add KF_ITER_GETTER and KF_ITER_SETTER flags
  bpf: Improve bpf kfuncs pointer arguments chain of trust
  bpf: Add bpf_task_from_vpid() kfunc
  bpf/crib: Add struct file related CRIB kfuncs
  bpf/crib: Introduce task_file open-coded iterator kfuncs
  bpf/crib: Add struct sock related CRIB kfuncs
  bpf/crib: Add CRIB kfuncs for getting pointer to often-used
    socket-related structures
  bpf/crib: Add CRIB kfuncs for getting socket source/destination
    addresses
  bpf/crib: Add struct sk_buff related CRIB kfuncs
  bpf/crib: Introduce skb open-coded iterator kfuncs
  bpf/crib: Introduce skb_data open-coded iterator kfuncs
  bpf/crib: Add CRIB kfuncs for restoring data in skb
  selftests/crib: Add test for getting basic information of the process
  selftests/crib: Add test for getting all socket information of the
    process
  selftests/crib: Add test for dumping/restoring UDP socket packets

 include/linux/bpf_crib.h                      |  62 +++
 include/linux/bpf_types.h                     |   4 +
 include/linux/btf.h                           |   5 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/Kconfig                            |   2 +
 kernel/bpf/Makefile                           |   2 +
 kernel/bpf/btf.c                              |  34 +-
 kernel/bpf/crib/Kconfig                       |  14 +
 kernel/bpf/crib/Makefile                      |   3 +
 kernel/bpf/crib/bpf_checkpoint.c              | 360 ++++++++++++++++
 kernel/bpf/crib/bpf_crib.c                    | 397 ++++++++++++++++++
 kernel/bpf/crib/bpf_restore.c                 |  80 ++++
 kernel/bpf/helpers.c                          |  21 +
 kernel/bpf/syscall.c                          |   1 +
 kernel/bpf/verifier.c                         |  15 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   2 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/crib/.gitignore       |   1 +
 tools/testing/selftests/crib/Makefile         | 136 ++++++
 tools/testing/selftests/crib/config           |   7 +
 .../selftests/crib/test_dump_all_socket.bpf.c | 252 +++++++++++
 .../selftests/crib/test_dump_all_socket.c     | 375 +++++++++++++++++
 .../selftests/crib/test_dump_all_socket.h     |  69 +++
 .../selftests/crib/test_dump_task.bpf.c       | 125 ++++++
 tools/testing/selftests/crib/test_dump_task.c | 337 +++++++++++++++
 tools/testing/selftests/crib/test_dump_task.h |  90 ++++
 .../crib/test_restore_udp_socket.bpf.c        | 311 ++++++++++++++
 .../selftests/crib/test_restore_udp_socket.c  | 333 +++++++++++++++
 .../selftests/crib/test_restore_udp_socket.h  |  51 +++
 30 files changed, 3080 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/bpf_crib.h
 create mode 100644 kernel/bpf/crib/Kconfig
 create mode 100644 kernel/bpf/crib/Makefile
 create mode 100644 kernel/bpf/crib/bpf_checkpoint.c
 create mode 100644 kernel/bpf/crib/bpf_crib.c
 create mode 100644 kernel/bpf/crib/bpf_restore.c
 create mode 100644 tools/testing/selftests/crib/.gitignore
 create mode 100644 tools/testing/selftests/crib/Makefile
 create mode 100644 tools/testing/selftests/crib/config
 create mode 100644 tools/testing/selftests/crib/test_dump_all_socket.bpf.c
 create mode 100644 tools/testing/selftests/crib/test_dump_all_socket.c
 create mode 100644 tools/testing/selftests/crib/test_dump_all_socket.h
 create mode 100644 tools/testing/selftests/crib/test_dump_task.bpf.c
 create mode 100644 tools/testing/selftests/crib/test_dump_task.c
 create mode 100644 tools/testing/selftests/crib/test_dump_task.h
 create mode 100644 tools/testing/selftests/crib/test_restore_udp_socket.bpf.c
 create mode 100644 tools/testing/selftests/crib/test_restore_udp_socket.c
 create mode 100644 tools/testing/selftests/crib/test_restore_udp_socket.h

-- 
2.39.2



Return-Path: <bpf+bounces-34540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D992E65A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE84528769E
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C615ECCF;
	Thu, 11 Jul 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="erq8XoQV"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011027.outbound.protection.outlook.com [52.103.33.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2213C3D5;
	Thu, 11 Jul 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696611; cv=fail; b=mLWf/FxT72kzSJwJA9Pc0qxCp3Vvu3E7+8uyEtM9lqqCCJClBKLk0imoccgLcPqXVwhRXNVJPlbnw7aQ2ZG0XLde2F4bxbj9uNH/ySGCRuWKhDQIweCx7szZEjj7jThrbrlD4k08tczpZ9wgwLZVPmJorMS9d53v2oXv493NC90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696611; c=relaxed/simple;
	bh=ClTNvg00VeNr9yRQk+CTRCZpHfk1i90UAv3IwtuPRtc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WHHyr0vwE7gQP+dG+TCzoLFJ9IW5g+0KOamBpZC7GbU/kAevvcu5bfBCkXtEf5h2BEUUHQfHEzJBooTQ2bHd5YaOK+i0vSC5nHY6cpQpyzECLKFlr7I+PRMnl/A7WKIEyIqNHuno+HHNXQeuyi5WHeMX0EyHkldf4bPsch8TUhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=erq8XoQV; arc=fail smtp.client-ip=52.103.33.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1ONxBKEQGjkgCxXhydqFkf9ZQ7j+Vqx8hj0CIVOv1Q8vvV38eKr0VMmnzeBxUrc3d6Lh/E2Q0p8WyMOO3XS0xP3ilM6kSPh1OqBfxkrBFiDQmj1CzYpjMekPiqAX17joub2gD7wBjF7QKhicIibOc8do4/MTf15uwa8hNzQW/yvRBsX1IY/sJI6yvRMEmi6aVvMMmoubCvyMTz+dpxUAMAFf/uoBNSN1et66Eo5p/Qe/cB5yfHIZobkt5B51Ifg5+57LMOeZuXtTJ2Ym++aj6SBqVEhSzRrkuuYqIh2jp7am081jptd9zNZGmNQ/S99upeu+f55Dphov32UB0R+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2EH9CHuF3D5LCBMpenWZrfw4GPBC8HQGLYnJYtKSvo=;
 b=VYeeX9fRKFhanO9VtiroGaBEIO4H6Rs/RO7aV1gTYNalvD2cc0GSDmyZQ7doMiGOxES8TIs8wVVPtIxxHQDJFyBSXhc20cLVuA4Vq8IYjR5PHqb7lDnIXYQZiyLm13/nTdOfiHib2BInvhfyxGChEH9ejAt6rjNBm6EO6B1DznjTUuz5WMEv+MOxGrih0ZqzrNKtD7Gh2Tam+bEpDffaiTAHnrZS30cxrk0mVLOLbBLrmGgL3Ek8Dd6BK4pB7OmVbh2VvegcN5VtWH5Btmq98Rp1F7oQzRtqeH1z+SHM0OMy5eqTa9fSYec8OHV1WepWcp+e5ioLgPqnO4wAguMZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2EH9CHuF3D5LCBMpenWZrfw4GPBC8HQGLYnJYtKSvo=;
 b=erq8XoQVkf0P9Z115pqBT4ZblZxaz9u3vVbdnbbg9HuGAKTIeJjMbOyaSZsvi0uK3Skw7qF7mtWux6D6LNW3U+ISV1PkIjVC9K6/+MIGv67qzZPHz8ChyWtL0bZGNkVN3dM6LCGPVQFfqnAv5JmOYHX6SakUFmkUPAIsF+9ElReyqhQ9LgifxoICoJ6a+u6+uleQt0rklN7IDuJfa3w6D2nvU+8S9tBRAyZ0re6o0FqTGhGoKKvr97CH5lUnvMVo1/IG4p/L3GM0Kxr90eYcxI0BnHOlf/f+T06DRXID7+rp/2lg0Mnxeb3cqhs9tgwWZ0yIhoMdFSEYsvDZJViy+w==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM7PR03MB6628.eurprd03.prod.outlook.com (2603:10a6:20b:1bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 11:16:45 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:16:45 +0000
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next RESEND 00/16] bpf: Checkpoint/Restore In eBPF (CRIB)
Date: Thu, 11 Jul 2024 12:10:17 +0100
Message-ID:
 <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [c62PQRZPfm7qfy3LO15ldxmVBZ4xx+5Y]
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111017.10669-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM7PR03MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 57abe7a8-e62b-4b5b-d8c0-08dca19af2af
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|4302099013|3412199025|440099028|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	xM+ruN0nevC8Yq1qtwlXiWWrOlsrWiA0nDDyITNlN7k+0ExKR6G4M7y0ZoHo3Z1Fy1GLYV8RZhs6kQWqcHK/uW5YnuSWvC4VkXdwbRU/DIcCXIOTlLRc1EjbEGAx+sVu03KG1ru14m98B0LiOBJ4OBVE/auUQevq7tcHyoAwwSx5mUwOlHNghDLwAb3Gk2iwBdxnnXZSv+miD6F5ZP/KcMX+fxeTKWjWio7u6QBebOHYuCCNzmx/H+8uzFi7MmdyPIm3BdcJ8W3qpBlPHOdh4ZxOonOrO3yHLL8MQLcQRP9jNOETtQWoZJp6BD9BqLEuLw6CWdSGKAvU0AH9EMAa+fLCXDVxLri5NjSsgJ/WSonPNlMmrnZYgqRMo4U/EhFl/XBYW4TwJNtedv1AzDy9P4b7f9EGlRyhduyPsaSiMJcFOcATb68vBAdDhDUsFhhL2F00QEDx29iQQ3W9IN/Ondiuy6UxOGWC2RCk0h9L+TgCI3dsp1RgN5DDGbvus+3QULI9uCRF/1W/DBbRMlXPtNlL+AeNhiHaKN0c+bKE6OGjv4/w7yF6bdxM/im7GGQKxNJg4T1hAUGrVMelyKaYqw2zaVYKGR+cNVLMZpgk+fOIrR7X0YLc+7KoWA9pRyzcLHAKpCLnMgsRzJjFzoirEzY7kH5yI6PqfD+7MuoVh+b5vuGmyMnEKk9R7uPvwF3ggZf6a/peO5pfjq7m6EKwPIA5HUqLvuq3HtkwnD7r+rbf0jPHCeyzlds45uRf9uI9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XpTtxunQ3/07sI7FLfQTBrnVjBQkKejhXST8vKbRoXlJ5mFl5AHGFa6Khhln?=
 =?us-ascii?Q?jROY101RN92UWEKZktgO8InBicg+fF8nkr719/VgwcqmAN7AgzQSBYlHuWjK?=
 =?us-ascii?Q?fQQ1byagoqrqdwG4eESVr/5JQTHIHTMUBXO7U8dLd3of0WmfV5kaorCVosMf?=
 =?us-ascii?Q?6NSZh23Bic+Zm6RVAKKOQAJiyzttl+PBlnWJHxCNiRFBIuMoKPo1vXmwlWrQ?=
 =?us-ascii?Q?VVN6+IsCP/8zlV2kvUt9ZQQPqXoWT23SpQUR+VOUGQOqukScoJdgs4QPnQ6o?=
 =?us-ascii?Q?kJ50pHnayAaYb0Se2Vxyn1p9Z7UZvG/0vX+wGNhuxndiKw1ZlfAKPfeyl7f+?=
 =?us-ascii?Q?cnz1Ri2aoAY6p0lymK5vN1qxjlm7zPe7qmemZggYgCyDP6G0LXRyIXsL0u54?=
 =?us-ascii?Q?ha4LvOGraJBsaJ+K8irJqo0oY1q+AIc6yDXUKimy+INeofrbkshvEOYh70Ix?=
 =?us-ascii?Q?JodXAOwnZkwUIVmqcbxD22b+h8gIqGWgIk5oRwOBodDRUp+vLxGfUiYxxnZp?=
 =?us-ascii?Q?tZ1DAG4Pe7EJqlIr7hyGYu0kSLlBl54WYT6l867o2+I18CM9Qi2x+Im4WyT1?=
 =?us-ascii?Q?F3c4NvENMWAffWhyxW8gwrk7vhTB2s7n+IDlZZi19aXoXeP9KElkrbNzuXPC?=
 =?us-ascii?Q?HdU2PdunT+lCfuZwx5ukYIGwR3CeY4vaPh1GH1gjCivNj9fMODM1BLzWYd4V?=
 =?us-ascii?Q?Qeth3ZYiMA5ynIkfUwlYBGsmmsxL4a03gIa5NmvhLRwCRJ/oa7iiy1Jn0IpR?=
 =?us-ascii?Q?iJYW891OeY6x1KiP1hbOYVjLUIIBex6aa/k1NslXl90SB7Gk9vLv/80okVvN?=
 =?us-ascii?Q?w2ULFMgo3o/uojbGIIxUJpmJ/W8kupgxY2o6yX85qrcvskjL0O2/H17f6QlQ?=
 =?us-ascii?Q?kaUbZYrZ+MdJI1OZ54Fy5xniXFOos/Lgqr1donDLW2A7qkpLRAqUhoIxKm9Y?=
 =?us-ascii?Q?aK2/AV+3RFNfL2wK3eBEcO6zj8zPbfiZn7vlrJJzyHFsF3LBnLlGGfmfW9jM?=
 =?us-ascii?Q?cwicHBPAUwSl9tffXBm8XTcTV+sHHFLqIQWYtGq1wUF7UjyJai3/OuRguKOW?=
 =?us-ascii?Q?HWUzKK9lh8mYibKOhRkAyNkZncv60g1kJ/M1Vha1vCmlFPSlm64KGqXx/Oae?=
 =?us-ascii?Q?9Ix0w9j7m0Rx+p9zqrGaSq2pphSZim2RKp/dpcvHJWHXZ84PQ3wO+P6mqYoT?=
 =?us-ascii?Q?8NKrRtSbGnsUhop31pEe4596i1v2R5QSlY8xjvw2sUgPQLsyb9VMvfnMSN8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57abe7a8-e62b-4b5b-d8c0-08dca19af2af
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:16:45.3452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6628

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

(This resend is used to fix mail thread that was messed up by outlook.)

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



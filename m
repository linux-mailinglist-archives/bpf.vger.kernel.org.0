Return-Path: <bpf+bounces-43437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE36D9B55D2
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84D91C212DD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23520ADDE;
	Tue, 29 Oct 2024 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ekh8PAzO"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2022.outbound.protection.outlook.com [40.92.89.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B07620A5F7;
	Tue, 29 Oct 2024 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241361; cv=fail; b=X5LFio1FiPX5ZNAcI3qUb5xOx6gvEL9wL4rfwgU9NCUlbKqPTckaoytHgN9lnqobLMYQHZkccG0odAJg0wkHqUjUnKnKpy6C+8hXAGe4wE8qpCeBNWLS504LkA/V1DBUUgIo3f9xuwkD48bD9PRCDUjL8QOK9NlFO8GbO21Ef/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241361; c=relaxed/simple;
	bh=bOvc9wURmNRZuzgXsR0a3c2yBYW0Rsiuu0hBryH8UVw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WZCr/dXJht8sCoUop9JKo+sMatp5QePgASl4gb8puKWVO6xVYxU+yXCAW37vLa04Y/c2KIJp2pXC3L2IthMXSNFyOM23T1IvxJEd0jTtoRJ3DxF5BjoKnTqe67FoEfXpPgwjVSTaXAKs211RN4C+Q+AkjOWpXMApDn55nDxKouk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ekh8PAzO; arc=fail smtp.client-ip=40.92.89.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPY1L75w5WKQm6ldf6oX/uV5WPDV5VY1vHI8wUpYusJJ1DTrOMibGo50JjNA1/m5h9edwwn0IM1jYq3Iaox0QU0riYIIw83zYpiMisDKBryhHm6hTn3GDTfUXPEs2MKsasy0aXXXIT9SMNMr0hD0H5nXUXvm65C9aHVki7Utma3sYjUqy+jS0Tl97TrbhR6qnBnK5cYw+vNKCVg2gzFCgX2yVhoKACoJcvNsjDBXtFvmKoe+/sxe/XknWICRpEHcTsXzwUz8TipWFWbEhmysQ83KcfQ2P0mpgtTCj3ATCVk0A442gs65IvEDXCRmAnCZMPOsXIsxloUr1ashxF2ERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b37iq4//P00rbv2Cyg/UUXLAcz9hnoWQExD6n0h8m4=;
 b=pR4IAlBPl7M6ebp6WVxnvA3ZtyHjR6UV2fJnl+3vhwkHpGo9HSNWj+HUSlqimnP2ViCiJ2XJ7Cr2gEfpVBiDBBbsGThkKA2XjX/cxd51QQWr1Fc9UAassYGNy/HPL2qC+nf7I/TsIXcO3//DAuQt6KDJtqhw4rHMYOHzdrRdfDcv8IMb93tbsn3xJnVwrAskIuIW2OsvqZAfNXThMVUJZBDXg2YTo81Wxtjz8JXtgqnZg1jvuAMJ0wbAAY4SQFHFBKBQXbHzS0U6W62MROrK3TOBlofp387bff01iAFr08CPlrTlVrSIEXp/Mp0kAcQbIB59SjTIl1HjW8LRq4vZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b37iq4//P00rbv2Cyg/UUXLAcz9hnoWQExD6n0h8m4=;
 b=Ekh8PAzOdhp4t/y/VWOGwYchKCNoaBHWnVnXD6mhTwKGKJ3xdhpqzxKMfzo/Z8wSc9GPn0p3zJ1y5EnNU4BfJJr6Uj2tpq4H3BaTQODiRNU5D5EzCcd3mvbYdrVEQW6PyB167JJT6N3o7dfFn4XfreUtvUa9W+rpnchJBPBh12e3m2cHvDRCNNO5KPWNwtH6icTzvcB6886+4uA3LfAPnJ7tHR62FeFtIoh0UGvxyFf1RsvnLGTRkcEeT/KhzTjbuHeKoijPXmaZVZQQc2cbvs6r3Regfk8m9HBqOZ12mvwqUuxszGEzM3WIEDeq6AVFDIHzfLz6RsfuJPk28YdBUQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PA4PR03MB7520.eurprd03.prod.outlook.com (2603:10a6:102:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 22:35:56 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 22:35:56 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/4] bpf/crib: Add open-coded style process file iterator and file related CRIB kfuncs
Date: Tue, 29 Oct 2024 22:34:49 +0000
Message-ID:
 <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241029223449.119411-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PA4PR03MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f81072f-a373-4e89-b6a2-08dcf86a0d5f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|5062599005|19110799003|8060799006|461199028|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXhLizNmnTJHqNeDCDuoeC+0E668+Q6f7mlChlo2VrSIfS1j3EMKFqJUFROF?=
 =?us-ascii?Q?vvesMzYJvMuyXZMiGKiEemDwbzM5WN4GXRHNIhCmZPK4F2Kc6ElrX80oQ8Wd?=
 =?us-ascii?Q?0ldyxCAt1psS/1DlXK0e24UxR0ucNN4llNmDztMOp2vsgJygGRuP6n+su89t?=
 =?us-ascii?Q?r6VNjvZcbe1R6KdjHSzen797y4S0yQJEpHKf/ErevYdCRhZwzUOgtSqqT9MA?=
 =?us-ascii?Q?BIR5lwnMcdhIND7VUzmifgvytDh+je5uc5ZxFfM3/ytvnzPJRrmf7FUPqiW1?=
 =?us-ascii?Q?2bmQehe0UE8LWO2c5WL5pxgVdKDoiZsHukxNCjJma1FVUOYC8+I0wjWR+xpu?=
 =?us-ascii?Q?D+yzzGvAfgYD12aKoq/LGByOpzP2aJzML5Lkm5YJP/ZNfznOFm0Nianw5vb7?=
 =?us-ascii?Q?c/Iwspdq8V44otsQNCcOJIQpq3rXRWwGAEen6XaGRrSVUlEJBpg3gZkIrvot?=
 =?us-ascii?Q?6n1JZnxOwx90xglxknltLf6lquEdWMBOXQDaT21YHRYUWS4bLgT6bADOGGAO?=
 =?us-ascii?Q?v5m2sy4HeXOrINsRYtfC7haD00rpEtzrB/jufyQ7Qf3yVORuvZb7WS6Tez2b?=
 =?us-ascii?Q?YGB4wHgs1J902aLYU965Y8zI7E/90xmAgxPc7kAWbtaR8jkQC7DWCaC27MG5?=
 =?us-ascii?Q?2et6wnq/kB9rfEfy/1P9JFW9J5OSYgrqGwhcWaXgsMkXx4UbcBee0FBeLknw?=
 =?us-ascii?Q?s/xheHvaMwegJ1bu8HzpKvNKS2sqf2gPzTCkqOAj/U5CMdjPc3pzsfbZKJWR?=
 =?us-ascii?Q?ocHM/0BhvwvwW8eWJOKZ2fnW6eUyzqJKj6VM0rVAMpUxYu85ObhdwOGgGVQU?=
 =?us-ascii?Q?+adTIbmthOhOqd6n9VMipxuDXJBSXlY1XvHwtvAAk56s4EhQjzJGvK8lYUKA?=
 =?us-ascii?Q?0Q6An28ZsL4QYi2indYeWl2xf5xom/lzRh05zJELAjD+BI91pVkUIgDNDsr8?=
 =?us-ascii?Q?cearINPsJ2e00QIpa+FQsXQcm0iF2Pqn62JyNAgPKuCG1aniqksX5nIA6szH?=
 =?us-ascii?Q?x7UWeolLfFNo+MXbQ76ywRPQpt3IQXtat7O0+oYSoonHy4Zw23FMNUlbu5N9?=
 =?us-ascii?Q?Wt+AxaDl6ntCnBYnrQL/PeX80GFiXIXS0rp5iizvEwcXqkGxsAUK1mTF3N1W?=
 =?us-ascii?Q?cbKv/fBfe09fXjkrFVAWagDmeKXVgcHM/efjLPYKL4CiDl97ZDkHLDodvbK0?=
 =?us-ascii?Q?U6SWPwcSibKUqWH4iEVObFhR8o1AKZNVqbbNqA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HfXjwi0b0v9hrBsupwriK3U2PrNCPIX3ymYvS2lP2NP9KqpXfICsWr8fPPAz?=
 =?us-ascii?Q?ybl+oEN76VdZjUIv4Hr1doBIcB2b4BM+W7u9MsFMnx+IsDf5OqrZWEkRnA4u?=
 =?us-ascii?Q?1sYOiZw3NUzsgwz3j4KnsRPfKzicksSrkYvncSnG4qraHQZwbEiTweqQOOFq?=
 =?us-ascii?Q?UqVcCLKHiLm33mzmv7PLgfxOD/h6tiFr579y6zovguRTVbQVS9HPgwsT9ym3?=
 =?us-ascii?Q?8XQG9cBFMWV5VJFlP/8W2GhPWEcAG4Lu73xk4cAmJReYjGd8Avm3ggglVJ90?=
 =?us-ascii?Q?W96cDENywvKD+tOb8b5KXgOBQlcEoqidb1u2SCJewTUOp+tX58N+vvySa+Jp?=
 =?us-ascii?Q?ZrUnE4gWa9tB/y0GArTjZ2A4R7Nkc83sOt1JHQRwFnYV1R9TCa96MgNjXxS6?=
 =?us-ascii?Q?h0ppek932ZJe4h20NuCLdihGSe0DoiXuN2ExUyD23Gd79vImWyD6Ee9nDT1W?=
 =?us-ascii?Q?FUzxZwjfGtgE5t19FVHgHN37GwHkjnuC0i9aPHzFj1ZBrDtdq8vCNeRLZHCG?=
 =?us-ascii?Q?YhYG+fpgEfaGWcc1F6cZogV0ptjMj++VgmgK5NgMa888xeNA+QRmN839n3QB?=
 =?us-ascii?Q?vmYaYKYNpA0q2IokHJafHL7KjXFDN5L47p/2KPFNyq3Y3R0ji26zKygAG52h?=
 =?us-ascii?Q?RqHR+xwVovBRMcgMYAFVZWcfqZGPgc+1fcWzq/7g3wWbQdcFfOwK0xUACSyp?=
 =?us-ascii?Q?hvl9Vo4e+G97WIloMD4sGpI40CXFB9IsDYuEJwOL9IU0X7/SYOegr3uPYOnz?=
 =?us-ascii?Q?8r8lDHkQOQpp/HGe8veqXfyIo/pS/4XGf96lSlt4tvoCntxLctP08yBTVLnd?=
 =?us-ascii?Q?2zcXoh82MJDMjrVoa0coTRvGSAyx/ovuiWA/VIh+riKOVexLoFmmbNCdFmPP?=
 =?us-ascii?Q?N+LZBwni5FGyhhaj8/0g9oroz2YoWbEJIuBIkbD4yo+yI8ZCg5iL3aVJpJnb?=
 =?us-ascii?Q?Pw49JXn8RFsZPHM66G7g5vQS+skZwH9Tp6873fA2cKH0KwMbmKdbKuIn0heY?=
 =?us-ascii?Q?86NDmjEDkoHrF1wPY4AD9wCEFRxcuCgh1YtRZQxC7rhw73ai9DdWsDrEVamo?=
 =?us-ascii?Q?Z5f3Zxz7ozEeopcyIFQHwDk8444KStc4JSOXT+agJk9d//QW/PKH0Vnp2WKf?=
 =?us-ascii?Q?ev3wf7CphQ+KM9ArynHIBPaPz+YW+spAnKQ1IjFEhAJMnK2Z/nJk6U43IM6B?=
 =?us-ascii?Q?/memVxVRpVWTvyiKqsZs8TVXpHnABMn6H608MqB8ep4H3GR5H/MVpONDYjiQ?=
 =?us-ascii?Q?9E9Ydv6jDLtrtlSQa2fx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f81072f-a373-4e89-b6a2-08dcf86a0d5f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:35:56.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7520

This patch series adds open-coded style process file iterator
bpf_iter_task_file and file related kfuncs bpf_fget_task(),
bpf_get_file_ops_type(), and corresponding selftests test cases.

Known future merge conflict: In linux-next task_lookup_next_fdget_rcu()
has been removed and replaced with fget_task_next() [0], but that has
not happened yet in bpf-next, so I still
use task_lookup_next_fdget_rcu() in bpf_iter_task_file_next().

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8fd3395ec9051a52828fcca2328cb50a69dea8ef

Although iter/task_file already exists, for CRIB we still need the
open-coded iterator style process file iterator, and the same is true
for other bpf iterators such as iter/tcp, iter/udp, etc.

The traditional bpf iterator is more like a bpf version of procfs, but
similar to procfs, it is not suitable for CRIB scenarios that need to
obtain large amounts of complex, multi-level in-kernel information.

The following is from previous discussions [1]: 

[1]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/

This is because the context of bpf iterators is fixed and bpf iterators
cannot be nested. This means that a bpf iterator program can only
complete a specific small iterative dump task, and cannot dump
multi-level data.

An example, when we need to dump all the sockets of a process, we need
to iterate over all the files (sockets) of the process, and iterate over
the all packets in the queue of each socket, and iterate over all data
in each packet.

If we use bpf iterator, since the iterator can not be nested, we need to
use socket iterator program to get all the basic information of all
sockets (pass pid as filter), and then use packet iterator program to
get the basic information of all packets of a specific socket (pass pid,
fd as filter), and then use packet data iterator program to get all the
data of a specific packet (pass pid, fd, packet index as filter).

This would be complicated and require a lot of (each iteration)
bpf program startup and exit (leading to poor performance).

By comparison, open coded iterator is much more flexible, we can iterate
in any context, at any time, and iteration can be nested, so we can
achieve more flexible and more elegant dumping through open coded
iterators.

With open coded iterators, all of the above can be done in a single
bpf program, and with nested iterators, everything becomes compact
and simple.

Also, bpf iterators transmit data to user space through seq_file,
which involves a lot of open (bpf_iter_create), read, close syscalls,
context switching, memory copying, and cannot achieve the performance
of using ringbuf.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Juntong Deng (4):
  bpf/crib: Introduce task_file open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded style process file iterator
  bpf/crib: Add struct file related CRIB kfuncs
  selftests/bpf: Add tests for struct file related CRIB kfuncs.

 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/crib/Makefile                      |   3 +
 kernel/bpf/crib/crib.c                        |  33 ++++
 kernel/bpf/crib/files.c                       | 149 ++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/crib.c | 126 +++++++++++++++
 .../testing/selftests/bpf/progs/crib_common.h |  25 +++
 .../selftests/bpf/progs/crib_files_failure.c  | 108 +++++++++++++
 .../selftests/bpf/progs/crib_files_success.c  | 119 ++++++++++++++
 8 files changed, 564 insertions(+)
 create mode 100644 kernel/bpf/crib/Makefile
 create mode 100644 kernel/bpf/crib/crib.c
 create mode 100644 kernel/bpf/crib/files.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crib.c
 create mode 100644 tools/testing/selftests/bpf/progs/crib_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crib_files_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/crib_files_success.c

-- 
2.39.5



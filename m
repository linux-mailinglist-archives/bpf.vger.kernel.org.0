Return-Path: <bpf+bounces-43455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479209B5862
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76FB1F243A0
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6491610D;
	Wed, 30 Oct 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IXJG3HGy"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2064.outbound.protection.outlook.com [40.92.89.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E5DF49;
	Wed, 30 Oct 2024 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247178; cv=fail; b=dzWtneE81JsCd0SEnysFHXViV1BhIY0KR/k2cwBlpcrYAG1z0thMeI20rdG/J06+DNGkoe2ulQ0V4gKkh5X3IuE7svsk8B4HF1yE1RxD0DIoF0e+hax8qYOgFQ4a1TFxud5rjT8xr+69tdFZlnSXSSwGDjFo1IwETw49IQBcIXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247178; c=relaxed/simple;
	bh=e9d1+HJhVzj4y6uIxqPqtAoVL/xgkvu2zw8R+RimCQo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Es49uAzlxrSNvs7OeRe0c0DUlKfQVim88saAEYxUsCAzwAlWO8zdt20iGPOd2TpLDl2byRIE9fuYBZJ5bW/maKAMXJWRC1cuVhgRQytOSgZl6plZxjjbmDOMXbB9hO8OYnzj8Jsx8X23/NE+WpE8SEhEANNQIi7OR9dGcNjLtGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IXJG3HGy; arc=fail smtp.client-ip=40.92.89.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLZ2iUMVml6o3wNB0Vrypue/KebNg/pulsB1Utjuab4iBZhZZwTli6N/cnFq0XQha+xA6BoymFIIH//IC3uH9wNLC9mjBTK0YIRP2Hk+DQgrPoUBEhh+svy3alhdfxi+9rIvorxjh53kSHMYBdxsFhLvyjuaZb2fX1KKaLkbF8+55FQKGGVfC4rvUtNpKcelDasXXp6Peb1m9AnVIZa7zmySjsDexB804BvVDxBp2IjUYhydsA1GCDkQBLpwPr4MkXitkjgyv1MmJ4VzGDEeYzRiNXkQStLx/sLs5x+gFgs/QP0OAuPDddODJJHe9zk0hhlrJRCH+nyYn3MEF3XjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QceMpaqZPc7CjT0AIUTc+FNx3KpDXpVNzMYvagDXSA0=;
 b=kK3BORtuoqgni68E0BFRyCCqruJh5zHuRhxVX0Ih35nx04ZSMS9vVpp7loP3B2qznby4X9F40woRQwkG3tpi73SH/rUVT+tNI44ydG044thwe2VSvqB/8DT8w6EfBTVNVzDXP59ne+bFvT1RI2sQx7MxUNa5MCh9Tk8OkQaxMjbHmsQzwOwgvNNHmduCU04mVVCda5Z5D27ib/HhzAi+Bum9AMGa7UNm9s6Hq3j96g5fv/PSbBcBPAgpMpL0ZdVmEBh4Ck2ZtqwUFXbHPDklCH949DLcq0kPoWjwUb5E7AzQKpa8DvT3Fw/d46TWlj6chMCHonXOVeUrXJ0Y3ZSCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QceMpaqZPc7CjT0AIUTc+FNx3KpDXpVNzMYvagDXSA0=;
 b=IXJG3HGyk6XMjRzTcfRd+krKC6O7TuGmkTUN8QkmRCTPFe4i/HePvLiANrCdCke5mDnsf04UEvy/V5KBwAI99Lz1rFKjaD37bV1D5+VH3pCENSv7xHMPJxIkuCxMEJmsDJgU2+hIwrD+UKb90+Wxk339G2Kgh78Rx8b+lXpdGXV5ykFyu1qPd+j/LloUQ+oP+AtKbgG+lqk47q7kJmyQx/LgSKrnP8+mUzlxvKxx/RaZxz7sJPgfqzNQ+iMVEcVhcwnRPEhvYR9BFuHeOKmeQ5JTD1oKSpUuJcWDxGQv9rhglLz4T07JbsCVPZqFPjdvglBJ0iQpGCfblMwnLh5ayQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS2PR03MB9647.eurprd03.prod.outlook.com (2603:10a6:20b:5e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 00:12:52 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 00:12:52 +0000
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
Subject: [PATCH bpf-next v2 0/4] bpf/crib: Add open-coded style process file iterator and file related CRIB kfuncs
Date: Wed, 30 Oct 2024 00:12:27 +0000
Message-ID:
 <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::34) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241030001227.15370-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS2PR03MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: da899fb9-fe3b-49bf-f77c-08dcf87797cf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|461199028|8060799006|5072599009|19110799003|15080799006|4302099013|3412199025|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOVzEWp2xPd36v0nJs8esmyEBf6SkLf/RHQX7t6SqSFZ1bK4+KWeVpkdAB25?=
 =?us-ascii?Q?Bx/pbfYjnrSXgqmaIfba4ZlKYA88DQXqGbyKtNz66dnEfNWhKWvNzTPkPgyi?=
 =?us-ascii?Q?oKmjCtEDoQ+ahHB9/toI7z9t/VO1l9SnSwmn8DTs9ZYWpwWzap4ftrnaPom6?=
 =?us-ascii?Q?+fKiERcOs7eStHPrBCNgJozu47x5BZqP0kYx/O97C1DXY2ZCmtMzGOSvdD81?=
 =?us-ascii?Q?W+3MxP4upEGfvgwLL5ZWvgHm5wRgVwxa4iAY/tAcBBwniw4MvM1ZhSLGcXyK?=
 =?us-ascii?Q?QHNbpB02HTTGaPClatzsBDD4uWY+5b7g0o+Xb9o17tg551mwQyV482eaM9XU?=
 =?us-ascii?Q?Gr/lTPygX2lntcF8QJGNhwwQU+5lAW65LHSeFnzTsA7ptenKofNTmZ2Lm4hX?=
 =?us-ascii?Q?mq20P1oREYPH8LbK8MzkRkEptK7uH8Ku7C86+TgO8UoOOpoG9spBa7hlqIGQ?=
 =?us-ascii?Q?+yWRHBGDV+uLf+ORuyUqSjAyqf4raHRMNOyY9V8Dhn1z8cYIGPaRyesVCOUJ?=
 =?us-ascii?Q?bxtuSP85folFE+JKEujkFtxFoZnzTzeODmLS2gpI2J+cp458CLn+IgIHp9eV?=
 =?us-ascii?Q?X/KUB4dtlFOCB+1+3dYTMdXfOmksoKVsu3tpHrL0O6MAjfVrHFxc+wvGhRI0?=
 =?us-ascii?Q?cTLcGQRCynqoadkiu1UCksTfwCc6cD4jotUew+Jwn39etZ+eoF8/MOTasLxe?=
 =?us-ascii?Q?1Ici/GQ/lwDvLawqcH/uRy2n57ZONv5Z81wsjc/QRjju2Dvu+OPDj2822pdE?=
 =?us-ascii?Q?9U1AU11IiHpIiowV58tNEDFh/yLw3i6ezeGOr1EhWSm4LZVPhR9C+hYnDM2H?=
 =?us-ascii?Q?MXyVIvSgXqMwonEhkUWz1OvRX/cQ+dOwhpUU3JNEy+P/F2Bj1FXcFrmTWVxQ?=
 =?us-ascii?Q?QH7HCM3kQ5LzHEBZ3eXqTTeXJZyNtutKPax2Uzgf1f1cGuXG05mamZ4OhbuM?=
 =?us-ascii?Q?oLDIKaftlEWxrJsaz41wKkPWMvVIXPija/lzs6b6J0aDNVwiMW5t3pBJlpx6?=
 =?us-ascii?Q?iU6HwE/Ab2rXq4wNrM39fOdwQ7hZ/ugJSx+73O1ZxHCCIuA4g2ZYTWKMDDFd?=
 =?us-ascii?Q?uuBA7rKJOKz0bVEU3ZCZa5wdMFOJ/94nNdkr5+q939vluRuqtCUN837a2Hgz?=
 =?us-ascii?Q?OM/DioaKEhB42VS2cF2JYzQM1NuvdZG3TXdkjS+NONCvToU4xI76/tqqsxq8?=
 =?us-ascii?Q?0m1J+fJbbcKthziOFO+Ow/OvsT8o7J/G+oSmrQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?veT4/3XQGXMKZitzmmdxkd9lElcpwwIvDupnSOrSw7sPyw+1LTDF0zVr17Ro?=
 =?us-ascii?Q?8hcrrfTUgeqIEvWLXWVyPE1Ivwkmfxpmx+GDv9EtL9CWIKYe2tohQ+Auev3T?=
 =?us-ascii?Q?ts+ymbT+Wkakh2IDwL80EeteRJOfJbQXYw6bNr2shuAnaebysaJd0PIWR1ev?=
 =?us-ascii?Q?VJu+LjG4tf+uVEhUZImfzhwQwiVelBE/L1Rn7iEaJiDZfxWZZG9sqQsMlNk9?=
 =?us-ascii?Q?/jzyXz32ATBM6JUZlkltI5no3+YE/lJGRDbYQax4ZeMnfuF6pOXSCMy0LC0w?=
 =?us-ascii?Q?vCQ9IjZtlPFSpVclxdNjisAt7psKnn9Kjwxs46nTf9ocVT9zsEmjXeZ/MeKj?=
 =?us-ascii?Q?fmLvqYf1n8f/xVeA3Zw/O1TJkFTIBDpcc5MO50UWncOoVBMdr5xITU3ttIJP?=
 =?us-ascii?Q?9yQmMb49ulxsiJzNpfyGtp2SMjboKawdweXobcEikB4CbMh0+037gpCtFw2e?=
 =?us-ascii?Q?0znF8qGs2rWCDtAZ3oZaKgd52jw2Nx5CkB9wKrR+cevY3ozU5FV0QGtgQc3a?=
 =?us-ascii?Q?NwZyn027+DYVy4MDtmJiUl1yUbKuGyBIXqDUFzRKe+A21iMzvG8ELkP6x1Vc?=
 =?us-ascii?Q?LrHvTWF6h2S9P7HCm+S/FGQGoDqAQhpOTC2+V8wGUWvGIkglNWEscQYQOXPH?=
 =?us-ascii?Q?8knvzDRzzVpgSPZjewMwyJ3NoX0DwMhbiql0mUAVn1ebuQEtc7zfXwIdL+fG?=
 =?us-ascii?Q?JtJ2mbxf0Rk2ZL+eu7ppk+rX+tMfhNIPpathmoxBO97DFBQ+jdkUoPiGsVaj?=
 =?us-ascii?Q?4pL6ZubbUo2HjEE16wEBZDcDiA46mtjIdN9WDWWK1h4+JbwNMCD23yOBFE6M?=
 =?us-ascii?Q?/kqZcgCjaZIB4Mli0jU1+UgYo6zDFaoYjES31b3LRyjHN9doeY3H568p4+zr?=
 =?us-ascii?Q?1Gu97W5xiLMojNrjThBLOTIJzZ6aFytJVhi3vPCmJnCAGxs+MdB42hTvk79F?=
 =?us-ascii?Q?3xFLChJfmeeiYdPnYZz6/NVDzu1XNIu+4HHuPlz8FIhVqwD8RU+dfO9bikfB?=
 =?us-ascii?Q?tH0kf9NEzh9nhDILUROJlg/VY6eT8XaiLtCcauPZPe8/0Gc4NasQdy2ifoSV?=
 =?us-ascii?Q?TmMB41VITCCmgsFrQ7VMfbYz9MCg2CEgK4yTrgQ1VUKfpqwnOkv26MPqZDRe?=
 =?us-ascii?Q?KaxpnmTyld18BUpfjElOko2tKxz3cPynQmWTBXABg315BehdakbKxGKMD6Kb?=
 =?us-ascii?Q?lT/I6juqA7XuFBlv8czfoCCLYlZVAVO1SVjPI5lN2e69j8Je+FnLpCUjbQbk?=
 =?us-ascii?Q?d3G2/yMKKlc6cGKeMtEq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da899fb9-fe3b-49bf-f77c-08dcf87797cf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:12:51.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9647

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
---
v1 -> v2: Fix a type definition error in the fd parameter of
bpf_fget_task() at crib_common.h.

Juntong Deng (4):
  bpf/crib: Introduce task_file open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded style process file iterator
  bpf/crib: Add struct file related CRIB kfuncs
  selftests/bpf: Add tests for struct file related CRIB kfuncs

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



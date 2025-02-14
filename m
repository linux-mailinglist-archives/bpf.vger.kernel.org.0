Return-Path: <bpf+bounces-51483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770F9A352C8
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB723A199D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C314C7D;
	Fri, 14 Feb 2025 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gzGAbG8c"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2106.outbound.protection.outlook.com [40.92.59.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402F1FDA;
	Fri, 14 Feb 2025 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492631; cv=fail; b=IoXFq5UPdNohgwsCF+nafdrrr7/Okrwgtpj9RJuDRVU+Ixyh91zlw4E+1/AQl218juIqRo8W5hw407YnX1Ni0TA2PZ22PWv8TYwayoawGa23xpyzmlJifY/NeC8ngDI/JnwR5TiNPAM5CA15/G3C4Th0tpEGh0K4Rgip3j0mDMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492631; c=relaxed/simple;
	bh=iH49QR9D0UZ0sHMJZHdDPIDqlHDllEkuat+u5w66EPM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wx87FNJ2wr5pc+DQa78hPMCS9MApDzinMYJDNr4/RD+XQdWLnm58IOoDZ4e2Z26PAztm5SDEH7/43C0Rgt+o+1aLyWl54t/Z6jYre9a6iOlHmtk7hdDNyyjPL/asHvS/YXvQxBg6B9dI8ZOLYDPg232xdy9yvRbFH0BD9ZQnyYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gzGAbG8c; arc=fail smtp.client-ip=40.92.59.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct2ZoHAERgvK1GxetwQM0/RIu4khu3P2lBEzXq+fEtw05XVkrCjXIhD9feTJ/rNem2zzX3E3BIPwfpaF1s2LgLCUKsTQLVcXx/YCmuEo34HeCxnHnnwHbizC2tbGFzv3W8EuasUff9aHqi7Dor7LjECB7qIRgvIYRVC7hQpbGMKdxRlnqjtWNn0NsoQ0i+kKdkTFafsR2ruJEORBexflR54PBI/BMOVrRJ9yEyrMovT3uZyy+ZyCnRnpaA8CwMmtgotOkGtT7P6WnN8MzPkjGH6uyFEvqHd+jqtTPF9h7BxSEBHwu5MiAtAAaOo0AGQQeybs/uA/pqhtj77zBuUYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkTYTbjRFcbjAKjIa5gY/BqPWk1KGyVU6IjZ+bz6bjI=;
 b=UP8p327HiMds9Wd08GixhF4kJ4IE+laQEdcLEOOHEHqJnTT2HaQwGd18X29rBmC4tSd1WafGDKSGqEnQeolFPRUX1qN8/XtoDR2VlNOtcY7QmTF1/5Yc++DolCdvun6n0SyzLbriKYt7+b+q/MAX5MbfNBPh/ehpBUpdtbdEHSvVf11TPHDN6aUFk3VhAirBO5+0I81Vhu2UhMY2/tvWWT5FDvaVQ2ysq9cZmaE3a+H4brWp9X+v+aApcCH3NTiCv9j5Itvys6yBevKf01iV0sGQnWk9fyBpzAN2nibSopfTZAZNF7uefpYTTO0HOwbxm4iOk93FdkzYqAQsaRMePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkTYTbjRFcbjAKjIa5gY/BqPWk1KGyVU6IjZ+bz6bjI=;
 b=gzGAbG8cWhu7AHidbUxwklMk/psD2EXV/3BJO+gMFCXQ7s3foiLACfwW4BiMm31aWxhGiH3/Z1E/v/U94tVsmeUbRM5Ra+k7m3dh27eRM+j5nMGJn12rsW7zhhm7hk6Za3/0XXJBsj9uxkh0UmhXNqeUMOOadiloUcjHiv3/zccyDERwnQHKwuBDkyuOkC84ChZlinxfri9LRnOwdXXFR7/TiGWjSspGLTIVZgGUdQ5YeVpdYpsMgMlAerqd4IKKTZpByEu39qXVelFCMOKq5tWuLSxaq13MkvGJnY/aIYrH6cqHStJgds+KnrzlAaEVQRyAP9t6olw/HUNb7OF4kg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU0PR03MB8439.eurprd03.prod.outlook.com (2603:10a6:10:3b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 00:23:44 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:23:44 +0000
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
Subject: [RFC PATCH bpf-next 0/6] bpf: BPF runtime hooks: low-overhead non-intrusive tracking of runtime acquire/release (for watchdog)
Date: Fri, 14 Feb 2025 00:21:28 +0000
Message-ID:
 <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::15) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214002128.67882-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU0PR03MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: e78da303-367c-4192-59e1-08dd4c8dd77c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|15080799006|8060799006|5062599005|19110799003|56899033|1602099012|13041999003|4302099013|3412199025|440099028|10035399004|12091999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XCZpskzEilFvSRD08Odn3Kqf+t7zfvx7GBLUkIDTWEyvm0/oJ3YFWOKCNknE?=
 =?us-ascii?Q?7/48z1WXhXplJvGRRnewpXTtPTdF7Nh9ZIfp0U1u/1q25UU7a36MuCLPKlt+?=
 =?us-ascii?Q?agWU4hB7wE+itLJou2VnzrimhT6jDWBVfvuDOKefqj+QfM51A5P0q0Z+3mWQ?=
 =?us-ascii?Q?gXRpqfmcY80C9DkkcFtOcLblDVcKfK9rEDozl5uGQq/gy4LFtj0wUxSoQhaZ?=
 =?us-ascii?Q?rjTfRrgCMKrmlNKeaXKnqgZbK1KI4T2SgdSE+lz+pg01AjCOGrVUSGN4qPcn?=
 =?us-ascii?Q?5lUBgX2UHURNY0pAaT4XJ+Z2bMeKyMQxNnxHBAAMJ8OveKd5xFmtbEWpvVFk?=
 =?us-ascii?Q?lVDNi/CAv6FohSpsWpOvNCWGnYStwdz1utYHqtsz1s3U+0CWggbnJ+OylZnP?=
 =?us-ascii?Q?Oxv8t45XP7tcZMqnC9BkeenE1Ia4Pa9UR3MpkU51SwSGoVczryFYmV3qoJM/?=
 =?us-ascii?Q?o8aCQEswV2qCYLc0FkhVCVHRYp+5YTpG1h94GdFRnM9fpaoaLkz+Z4Cw6l8z?=
 =?us-ascii?Q?PFI60bmLCwhG+eS/tNh9kkSk9iZpJfoVEG6EfgRHiN6wZEITWH0EE7qwRShV?=
 =?us-ascii?Q?4YC8yViY6jVshjdXno1rCyO2x+2Nq1IM+XJMsQq7O9ZRryP5eCcbGUUOvAeh?=
 =?us-ascii?Q?VupFIx8vd95CiQEh0AWcYFS4MJzjP56zNq0VJmD+zYkGAbEom52pm700Oqak?=
 =?us-ascii?Q?gNiHTC4HUbfOmKwMnAUAksvrtLiyDBCnQpib34mY8fJxNVtOBIOlVtHuMDcg?=
 =?us-ascii?Q?X6HhGXCp/FGHWn5DUqYGUYG/NOZMmpSfLCw8qnTULB/DwWDCJLfT0qhkz1O0?=
 =?us-ascii?Q?QMY2U3VcTOjjWOBJ6O9KEtOB+uSNT8nl4jZUL+2lEO1PRMA0tNTCmvuvSHqe?=
 =?us-ascii?Q?6VxZxvligAfBusnK/1EWOcTjjY9jzAnHFZ14HLRHz/UPzwOowd2gt6CszPhJ?=
 =?us-ascii?Q?KtLjfKoqEH/zHgeSJVQFQ+OaOE7B8syKhxe50pXzDEsTvbKqsZ8H5VdTJAdy?=
 =?us-ascii?Q?4nhKDpZ9aZv+pisxwXcxfmAtzk6EQUkchiCRM1rKS0sHBQ9IQq4nXNo0ec+j?=
 =?us-ascii?Q?CCrtJFbRbVQusnSUN66afWZafOZX+PyfWAOsiA4DJrxO5OAeh5x0Ru4bFtgO?=
 =?us-ascii?Q?uFG2bt5JtroPOq8xPp7pthQmt5L8F4g8YRQBkNDmuSC8GoC6aDZDfo9oACtV?=
 =?us-ascii?Q?0no6W2SN12JGKd8iqpwx2rC2bNJ9eT3JoXdad1YA+y8nQKuSAIC9xyDoRgUY?=
 =?us-ascii?Q?m6cTJSq5A7aSfgVkcdVQRhnGOgzeMq8zeHM/pZtrk98J/28MjwdjuzWNtIRV?=
 =?us-ascii?Q?t9w=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gep3ji9zaviQJ0x62XNMpMTP3mVhcicOjfRbrVuIVcEK5RG7lx7/0Qp6bAqC?=
 =?us-ascii?Q?VDMN5j34RPbQZw9FEO1DgedVkwIQTDX4QLWj24YKJkEeR6JzuRgkcIdTNJeF?=
 =?us-ascii?Q?hDojIeNp8LBj6/jVmIHjvSzA/C+xHZ1ISW5C/hTwPbLlzWTNdAGR3qD99EK3?=
 =?us-ascii?Q?KiCZq0x3XQrV5Z78biQhSAOWmlQupvmfb0BHWVZaipj9Oc0md2+ZiGJdG39n?=
 =?us-ascii?Q?6DuWDtcDYMmpjwjaCWkqDg25zhknKE6Jt22Xwis9Vl9g1qCgawLXQkrzFym1?=
 =?us-ascii?Q?6nxhxreebs9F9g0CuoyKbLjLCrNjLS8GHxqpQpux/CXDMMR5p1YfmMvev59q?=
 =?us-ascii?Q?Tj70JOm0aCLuQ3Mwl5Q2tcWRPPSORUq5UtYQ5DD182BVHqdGgYYhaBqWGZl4?=
 =?us-ascii?Q?IEoONMg6dFMg9vCoGd1itl+ZD6NFwje3UwKJ8b+9CJxoST6TcwobAp1WB53/?=
 =?us-ascii?Q?QE/5FxP3EMBy5B0BjqYPs8SBeh6LONxQOdt3K2owh9uLUo9JO9+dRINJv4Rr?=
 =?us-ascii?Q?+8kGPHT9Xmeppb77fNbVCzbyTyzEWMDdc1YB4vxFQl9O3+HYaWXvZ8eNzuug?=
 =?us-ascii?Q?aw0EMwuhqQfmRufitNw7MO7lLfZvtafCFG75t9Fm3VHOPfVXN7kWh6t+esr8?=
 =?us-ascii?Q?Pxc/m1JobAve5kEST29NcYueKfbDM5JF9QKEq4PKOjBwc38KPWXQq9U+KGka?=
 =?us-ascii?Q?hjSX7YCq8xxjxRh89R56xcH6HRlhM+VER6zxYBRCFjBai0dOo5gAYoetpYPI?=
 =?us-ascii?Q?nuUrVE6zdexQcpb+ANjwVS/VQ2s8Zhcz/mThMawku8TUaf1KzN6GYXJqj6mX?=
 =?us-ascii?Q?81Eo7Cj4zdknJ8KikSArq/wT5YUiecgm9Y54FoY1jGx0elxZ66k9DfA+3/je?=
 =?us-ascii?Q?s3FD8qCK7PY4lqgXvGfbt6EKrg4TpENmrXHuGr2e0wMbkN4j23eBn/S4Td05?=
 =?us-ascii?Q?QhIe+xi2fa7pqmkfgo9GfRixACNBbyPhtw0ASETgev5K502PId6WzlYP2PJQ?=
 =?us-ascii?Q?0uM5oQ3mrRQPQWDqcV+KP/ZgqyArU5bPRVT1NWZn5eUt60zJmY/LBVSnrcjq?=
 =?us-ascii?Q?7vteiNb05VGRkty/ECeUUkhJ6Wkdh8vimjTWF9ag3CQjryegnnimu8AkekTz?=
 =?us-ascii?Q?x9Pq+2KWi4oa4BWpJNDV/BU8QfRYfbs4OnzbVGvCEiPHb0HdyJaAhxwUTGYR?=
 =?us-ascii?Q?XdntlY1Qadky3Ma8EFy5bCYiAaVJM9pbm38HNyu8EiEg43qAzP03WhomKxSe?=
 =?us-ascii?Q?+5rSbwbLLOuLV+QNVgyH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78da303-367c-4192-59e1-08dd4c8dd77c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:23:44.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8439

Motivation
----------

The idea for this patch series originated from a previous discussion
[0]. This patch series is a proof-of-concept implementation of the
idea in the "Possible Improvements" section.

Currently BPF does not have a watchdog mechanism to kill "out-of-
control" bpf programs. One of the difficulties is that we cannot
automatically release kernel resources held by bpf programs.

BPF has been working on avoiding errors in bpf programs through
pre-runtime/post-runtime mechanisms (such as the bpf verifier).
However, for these static checking mechanisms, it is not an easy
task to manage the resources held by the bpf program at runtime.

This patch series is intended to demonstrate an idea: if better static
checking solution is more difficult to implement, and we still need more
time, perhaps we can use some low overhead runtime solution first as a
not too bad alternative.

In this patch series I implemented non-intrusive BPF runtime hooks and
based on that implemented low-overhead runtime acquire/release tracking.
This can provide information about the remaining unreleased kernel
resources of the bpf program when it is necessary to kill the
bpf program.

Note that this patch series is not intended to replace pre-runtime/post-
runtime efforts, and having no runtime overhead is always better than
having some. Our final goal is to have no runtime overhead. In the
future, as these no-runtime-overhead solutions mature, the
runtime-overhead solutions can be disabled.

This is similar to the relationship between BPF JIT and BPF interpreter.
We always know that JIT is better and should be used eventually, but the
interpreter is a not too bad alternative when JIT is not ready or cannot
be used, and can help us support some features faster.

Note that this is a proof-of-concept patch series, and all code is only
used to demonstrate ideas and is not carefully designed.

[0]: https://lore.kernel.org/bpf/AM6PR03MB5080392CC36DB66E8EA202DE99F42@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#u

Background
----------

Currently, some "malicious" bpf programs can pass the check of the bpf
verifier. This is because the bpf verifier can only do static checking.

Static checking cannot detect all problems, such as long-running loops,
which can result in holding resources or locks for a long time,
affecting the overall safety of the system.

In some contexts, we would expect the bpf program to end in a very short
time. For example, in the context of tracing, if an "inappropriate" bpf
program runs for a relatively long time, it will slow down the overall
performance of the system.

These possible "unsafe" may prevent us from adding some features to BPF
or applying BPF to certain scenarios.

So how do we restrict the bpf program to only execute within the
appropriate time range? One possible solution is to implement runtime
protection, such as a watchdog mechanism, to cancel the execution of the
bpf program after the bpf program times out.

But this is not an easy task, because bpf programs can hold resources in
the kernel, such as acquiring references or holding locks. When we
cancel the execution of a bpf program, we need a way to automatically
release all remaining unreleased resources.

bpf programs can run in a variety of contexts, most of which are
performance-sensitive, so the overhead must be as low as possible.
Ideally, implement a mechanism without any runtime overhead, but this
is not easy to achieve and may need more time.

No runtime overhead solution
----------------------------

Kumar Kartikeya Dwivedi proposed automatic resource release through
cancellation points and stack unwinding in BPF Exceptions [1] and Fast,
Flexible, and Practical Kernel Extensions [2], which is a solution with
no runtime overhead.

Cancellation points: Create a table through the verifier that records
the kernel resources that will be referenced in the cancellation points
of each execution path. When canceling a bpf program, the currently
referenced resources can be determined based on the location of
program execution.

Stack unwinding: When a BPF exception is triggered, analyze the complete
call chain, traverse the stack frames one by one, and release the
unreleased resources in each stack frame.

Please correct me if any information is wrong.

This is a more ideal solution, but it may need more time.

Once solutions without runtime overhead are implemented on an
architecture, we can disable solutions with runtime overhead on that
architecture.

[1]: https://lwn.net/Articles/938435/
[2]: https://rs3lab.github.io/KFlex/

Design
------

1. Pairing acquire/release kfuncs to data structure types

This is based on the fact that an acquire/release kfunc can only
acquire/release one data structure type. For example, bpf_task_from_pid
can only get task_struct, and bpf_task_release can only release
task_struct.

This means we can pair acquire/release kfunc with data structure types
and construct a table. We can find the corresponding kfunc according to
the data structure type, or find the corresponding data structure type
according to the kfunc. We can use the memory address of kfunc as key
and the btf id of the data structure type as key.

After establishing tables, when the bpf program acquires references, we
can find the btf id of the object for which the reference was acquired
this time based on the memory address of the acquiring kfunc, and we can
record it.

When we need to release the object automatically (watchdog), we can find
the kfunc that can be used to release this object based on the btf id
and call it with the memory address of the object as an argument.

This approach will work as long as we insist that all release kfuncs
have a common calling interface (e.g. currently all release kfuncs have
only one argument).

2. No runtime memory allocation/deallocation operations required

If we allocate a new reference node to record the reference information
every time the bpf program acquires a reference, and deallocate the
reference node every time the bpf program releases the reference, then
this will obviously lead to huge overhead.

But in fact we don't need to do that, because the number of references
that a bpf program has acquired at the same time is limited, even if
there are loops. (Based on the current bpf verifier, references acquired
in the loop body must be released within the same loop body).

In the process of the bpf verifier verifying all possible execution
paths of a bpf program, we can record the maximum number of references
that the bpf program can acquire at the same time.

Before the bpf program actually runs, we can allocate the maximum
possible number of reference nodes to record reference information.
These nodes can be recycled during the runtime of a BPF program, so
there is no need to perform any memory allocation/deallocation
operations at runtime.
 
3. Low time complexity

I used a combination of hash table, linked list, and binary search to
reduce the time complexity as much as possible. I added an active
reference hash table and a free reference linked list to the
bpf context.

At the beginning, all reference nodes are in the free reference linked
list. When the bpf program acquires a reference, we take the reference
node from the free reference linked list, record the reference
information, and put it into the active reference hash table.
When the reference is released, we put the corresponding reference
node back into the free reference linked list.

The following are the detailed time complexities:

- Acquire

Binary search the btf id corresponding to acquiring kfunc + take the
reference node from the free reference linked list + put the reference
node into the active reference hash table.

Time complexity: O(log n) + O(1) + Average O(1)

- Release

Take the reference node from the active reference hash table + put the
reference node into the free reference linked list

Time complexity: Average O(1) + O(1)


Considering that the number of acquiring kfuncs and the number of
maximum references in a bpf program are unlikely to become very large,
the actual runtime overhead is very low.

When the watchdog kills the BPF program, if the active reference hash
table is empty, it means that there are no remaining resources that need
to be released.

4. Non-invasive, no need to modify kfuncs

Runtime acquire/release tracking is implemented by installing BPF
runtime hooks on acquire/release kfuncs. This approach is not intrusive
at all, and we don't need to modify kfuncs itself.

The principle of BPF runtime hook is simple, by replacing the memory
address of kfunc in the CALL instruction with the memory address of the
hook function, and inserting the memory address of kfunc as one of the
arguments, the hook function can know which is the original kfunc.

According to the BPF instruction set, all functions can have a maximum
of 5 arguments, so the first 5 arguments of the hook function are used
to pass the original arguments of kfunc, and we can use the 6th argument
to pass in the memory address of kfunc.

In the hook function, we can read the arguments passed to the original
kfunc. Normally, we will call the original kfunc with the same arguments
in the hook function, and return the return value returned by the
original kfunc.

We can install different hook functions for different kfuncs. For
example, we can install hook functions that record acquire/release
reference information for acquire/release kfuncs. We may also be able to
install watchdog check hook functions for some kfuncs.

After BPF JIT, the function calling convention of the bpf program will
be the same as the calling convention of the native architecture
(regardless of the architecture), so this approach will always work and
be easily portable to other architectures.

The only thing we need to do is to replace the calling address and
insert the 6th parameter (for example in x86_64 architecture we just
need to set the kfunc address to the r9 register).

Improvement?
------------

1. Runtime overhead

If we need to add runtime mechanisms, there will be runtime overhead
anyway.

But so far this approach has low runtime overhead.

All the runtime overhead is just binary search and moving nodes between
hash tables and linked lists, without any expensive operations like
allocating memory.

Although there is an O(log n), n (the number of acquiring kfuncs) will
probably not exceed 100 in the next few years. As for the maximum number
of references, due to the complexity limit of bpf programs, I guess this
number will not exceed 15 in most cases, which means that hash table
lookups are actually O(1) most of the time.

In addition, acquisition/release is not a high-frequency operation in
the overall execution of a bpf program, so perhaps these small runtime
overheads are acceptable.

2. Pairing BPF helpers to data structure types

Currently we can automatically pair kfuncs with KF_ACQUIRE/KF_RELEASE to
data structure types, but BPF helpers are not handled in this patch
series. There are also acquire/release cases for BPF helpers, such as
bpf_spin_lock/bpf_spin_unlock, which we need to handle as well.

But handling BPF helpers is a bit tricky because helpers don't have
flags and we cannot automatically identify the acquire/release helper.

One possible solution is to add flags to struct bpf_func_proto and use
flags like KF_ACQUIRE/KF_RELEASE. But the BPF helper list is frozen and
modifying struct bpf_func_proto is probably not worth it.

Perhaps an simpler solution would be to hardcode a list manually, just
for compatibility.

Possible benefits of runtime solutions?
---------------------------------------

Usually we think that solutions with runtime overhead are necessarily
worse than solutions without runtime overhead.

But maybe some usage scenarios can only be achieved with runtime
solutions?

An example is when we want to limit the amount of time a bpf program can
hold a critical kernel resource, such as a spinlock or an object that is
only allowed to be referenced for a very short time. When a bpf program
holds this reference for more than a very short time, we should kill the
bpf program to avoid affecting the overall system.

In this case, limiting the overall execution time of the bpf program is
not applicable. Because once the BPF program releases this reference on
time, the bpf program should be allowed to run for a longer time.

In this case, we should limit the holding time of certain critical
references individually, which means we need to monitor the acquisition/
release of certain references independently. This is something that a
pre-runtime/post-runtime solution cannot do.

Further, how to cancel the execution of a bpf program?
------------------------------------------------------

In general, we can take back control and "kill" the bpf program when it
is preempted, similar to process signal handling.

However, bpf programs already have the ability to disable preemption
(bpf_preempt_disable), so this approach may not be applicable.

We may need to use BPF runtime hooks to perform "watchdog checks" in all
kfuncs that may run repeatedly for a long time (such as KF_ITER_NEXT).

Test Results
------------

I added three test cases, representing the three basic cases of Simple
(no branches and loops), Branch, and Loop.

The following test results are from the kernel log (I added some pr_info
for demonstration purposes).

- Simple
bpf prog acquire obj addr = ffffa0d5411b8000, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog acquire obj addr = ffffa0d5418687e8, btf id = 13482
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
obj 1, obj addr = ffffa0d5418687e8, btf id = 13482, can be released by bpf_cpumask_release+0x0/0x40
bpf prog release obj addr = ffffa0d5418687e8, btf id = 13482
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog release obj addr = ffffa0d5411b8000, btf id = 161
bpf prog current release table:
table empty

- Branch
bpf prog acquire obj addr = ffffa0d5411b8000, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog acquire obj addr = ffffa0d5411b8fc0, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
obj 1, obj addr = ffffa0d5411b8fc0, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog release obj addr = ffffa0d5411b8fc0, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog release obj addr = ffffa0d5411b8000, btf id = 161
bpf prog current release table:
table empty

- Loop
bpf prog acquire obj addr = ffffa0d5411b8000, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog acquire obj addr = ffffa0d5411b8000, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
obj 1, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog release obj addr = ffffa0d5411b8000, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog acquire obj addr = ffffa0d5411b8fc0, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
obj 1, obj addr = ffffa0d5411b8fc0, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog release obj addr = ffffa0d5411b8fc0, btf id = 161
bpf prog current release table:
obj 0, obj addr = ffffa0d5411b8000, btf id = 161, can be released by bpf_task_release+0x0/0x10
bpf prog release obj addr = ffffa0d5411b8000, btf id = 161
bpf prog current release table:
table empty

At The End
----------

I know this idea is not a perfect solution, but I guess until the
perfect solution comes, we need some not too bad alternatives.

The current inability to kill "out-of-control" or "inappropriate" bpf
programs causes BPF to be unsafe in some extreme situations.

This may prevent certain features from being added to BPF or limit BPF
from being applied to certain scenarios.

I hope this patch series can help in these situations.

Any feedback is welcome.

Many thanks.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Juntong Deng (6):
  bpf: Pairing data structure types with acquire/release kfuncs
  bpf: Add max_acquired_refs to struct bpf_prog
  bpf: Add active reference hash table and free reference list to struct
    bpf_run_ctx
  bpf: Add bpf runtime hooks for tracking runtime acquire/release
  bpf: Make BPF JIT support installation of bpf runtime hooks
  selftests/bpf: Add test cases for demonstrating runtime
    acquire/release reference tracking

 arch/x86/net/bpf_jit_comp.c                  |   8 +
 include/linux/bpf.h                          |   7 +-
 include/linux/btf.h                          |  12 +
 kernel/bpf/btf.c                             | 273 ++++++++++++++++++-
 kernel/bpf/verifier.c                        |   5 +
 net/bpf/test_run.c                           |  37 +++
 tools/testing/selftests/runtime/Makefile     |  20 ++
 tools/testing/selftests/runtime/branch.bpf.c |  42 +++
 tools/testing/selftests/runtime/branch.c     |  19 ++
 tools/testing/selftests/runtime/loop.bpf.c   |  37 +++
 tools/testing/selftests/runtime/loop.c       |  19 ++
 tools/testing/selftests/runtime/simple.bpf.c |  35 +++
 tools/testing/selftests/runtime/simple.c     |  19 ++
 13 files changed, 531 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/runtime/Makefile
 create mode 100644 tools/testing/selftests/runtime/branch.bpf.c
 create mode 100644 tools/testing/selftests/runtime/branch.c
 create mode 100644 tools/testing/selftests/runtime/loop.bpf.c
 create mode 100644 tools/testing/selftests/runtime/loop.c
 create mode 100644 tools/testing/selftests/runtime/simple.bpf.c
 create mode 100644 tools/testing/selftests/runtime/simple.c

-- 
2.39.5



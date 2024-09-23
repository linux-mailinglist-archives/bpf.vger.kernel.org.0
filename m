Return-Path: <bpf+bounces-40212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8C97F0B4
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 20:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FD91F22FF4
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69C1A0723;
	Mon, 23 Sep 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vFarxwzg"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2051.outbound.protection.outlook.com [40.92.89.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828919F473
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116513; cv=fail; b=B0GWlXt9IJtXAqoiW6l6Lfmg7JpkfMzIi0DSKiDIewstK3hsurmrLG7IrUG7ItjaJyug8eWJK4PcKr7WvJtmJGKEA2ie1dL3z3PkGbq/vxeBi0qM38JQmTWLp/c0t/mbp2lNu4GFxkqDJVoKmaZPfAuMEisypPQeODYKH8d47TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116513; c=relaxed/simple;
	bh=Yt8S79i5mPFIddRg/69Bg5A+vkOZOrAAwdRJZGm3hgY=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=c2r9VpWdxmUhqsFoGHVlj5h1I7/1qsjSsgzrjDwGbDzZpg3L8+/mRxnmEm4pkn3LkJtS9pwf8THs44PkfL3O678DlwDezPDzameeesntKLGLac+/7Uwgu5rXRV7OgTzqey4an6ruKGlO0FcgqITq/zXmr4DNmhADGPFKRWQGs1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vFarxwzg; arc=fail smtp.client-ip=40.92.89.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrmJwL5/T9i4dF61CPNZmTIeVs8eOULhx/rxHTGCF/HuIUtPz3kDL40DK0DlRPCv0F14QC4KXibmapwa1zx6j1bvaUYTptQ+VG4UqMJK9SDfkH31is3n2C+aCGLZbVJkSSwD1TqdHc5ER3CqhI5R6q2lEhaQLMePiAXnLKUW5JcISg9i2k/SLScvd9Wvhm+MqZ+E+mKnsHmZYXYGOgC6bLVKyLV6KxM9vmB9Z7NGGy1uJIZOB+3WdktPNUkbuCwSf4kegkdqlM11H4fsptvMpYUfV3LFqNFzZQFd5M7P5CgOExyrEeQUJ5joluZ3a4pwcWe0h40Fx/fC3J4qc2bSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un/8FD+w4Z2n3nJc46EwekiNYN4/iUf4/6mhL7b08ss=;
 b=sY8Lj9V4u2C/8OqoNK07mZByDjlHo7fUy0+4HrT+18v5Ce032QE+T/QgVcqqlAvOJgsUHphOd4l/GTaAo2JwNCHzgaNZ+ONd0fRAgUBA4irxbnLytM98YeBQjLRt+BUMgA4Dw7d7IHbbmLvvu7xFRk3VY8CZEViLE5eUWr3zGM+1Ug3DsQcNGsq2oqndtVGPu+BX+0NHlL1N5NVo9C8124T7er2yB8Ioe0By4RCPGhWb2Hs1cpf+HMtSfKCX/8SORHFsCDcUKXRjKwtDhaOsUrkS9n/yh4Nq0Gbz8KLYVxRtCbDIpr+hFpvDQhPIaWETc9xWBI0BM8W2JrOA43WmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un/8FD+w4Z2n3nJc46EwekiNYN4/iUf4/6mhL7b08ss=;
 b=vFarxwzgAsau9hvYFbc/QOg/Qxl+++KeGJDkJEtdMYRfAu/qE0jiw7YEqtopWQnXn8AM7W5mhWgqU62s9ogrvzeZ43m85BDGCmy09L5tfmVO8jNzUZf0E/mUDJj82FpR9Lgf4FxODolSExWtvSGtWjVtU0lWCqk0Y1KYFH4NGCQsnLaYQGDb4Vi2HYnr6KIG8nFQ8F0kx3UNn9dKc0R9YMIxCCJWzmTS2DBV0Gkeydh+YHRwQX9FvzC86To8E30gQoppJomxWM9KnQ6SHLUnft0WCXaPfGixn+yQ6Rdn/YZj3ZiX1CuXcQ5pvEUIedOSCBXbNTCYGMCzLFLQr8g6jA==
Received: from AS8P194MB2042.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:5bc::12)
 by GVXP194MB1757.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 18:35:09 +0000
Received: from AS8P194MB2042.EURP194.PROD.OUTLOOK.COM
 ([fe80::3644:f8b7:ee68:3865]) by AS8P194MB2042.EURP194.PROD.OUTLOOK.COM
 ([fe80::3644:f8b7:ee68:3865%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 18:35:09 +0000
Message-ID:
 <AS8P194MB2042168EE5CAC311644BA284866F2@AS8P194MB2042.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 23 Sep 2024 19:35:08 +0100
User-Agent: Mozilla Thunderbird
From: Alasdair McWilliam <alasdair.mcwilliam@outlook.com>
Subject: Verifier - wild instructions count fluctiations between versions?
To: bpf@vger.kernel.org
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0278.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::13) To AS8P194MB2042.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:5bc::12)
X-Microsoft-Original-Message-ID:
 <421ea84e-2496-4205-a602-a4e002a79ef2@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P194MB2042:EE_|GVXP194MB1757:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfc2c0d-5a9c-449d-9a5b-08dcdbfe7395
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|461199028|6090799003|19110799003|8060799006|5072599009|56899033|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	08v9Ut5FOy4r8vSTLayRqg/2tW8aJQeEvQOw9eQS14X7lCgFHPeOs8Ty1j002SyaMynZwldTvWWz84O70+R4ykjZejp5efDm3au+xxY4tcW/odbssz8yiJHLcbGyc8bEzVEDjrUzqIyhGwqI9mRyQeVcfZ97rOuJWq4M9lI8QaG974ZHd53JtTg7Ze9KrKhZIyehWJYKl/3biS0u02ktiUMM7AQNuEG5vr/bskznGyno3/Er8cYA71mT/xfpsy8OrInKYLpbkvkdZn973N3j6j7TQB4sM/rOB4EeOuifWjXDbLVjpS/Ls/QCNtwLESrF5fnJTUTI0pwCHkbxKwa0SzRDHKPIuOQv92ch+Bm0xYBqiZ+Ion+nTF8lBqEXKslkfa95enRDxSnFJg6DWP9LaGbxtcpafZvQxk3XAt2x4QGIP5hb6T88TEUUEEI+XXqRI884kCobg0rHLsXcnh3uwrXFICIh7ok1TNZ2yKWh6DN0NpIFApPDtaLyqYXk0gYroSA1H3QmmBSuVJWQv/OZylvuYS1CCtR2w8AGp0fLEa7/iUaM+K06m7zTuUYAoputGjkUjzeaSuvrFYfHB8vptf/9SjIDGMkWxIVQhkKg8f12Xo94nzZNAw/Wssxq37JAodc7VDMOWzFsj3Ml7c6goKAIWt50n9kdO2e4p5NCHD2nT35zrxjYoqC+kcOJ7S7pdetACZg9apLSpyGcPbYCHQwfbpQHik/2U3pmhZ4n3X83RsUSghX6fkOm41KkbJAip/lENTh95izgjRyjHdO80w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWh1ZzVnR1VkcXBLZFZTS3JFVm1GZ09ZeGVVWFNoQTMraFdrWnQ0eEdOcGlq?=
 =?utf-8?B?RzB5cG4vdEhFSTRndE1KSkxJaDZQMDc4R3RZWGg0N3gvWElIZVU2dUdSVUw3?=
 =?utf-8?B?SG9hbTB2QVNjK2VkbWdNOXF4OTlvYkNxWDgwUE40RG43Vi95TGV6VWxiVFA0?=
 =?utf-8?B?b2RHWjhCSW03d0hISjBqcitoM0tSN0dzTkhCT0R6S1N6L3hMQ0o3NXNSS2Ey?=
 =?utf-8?B?Z25wejhvZXNZNXFhR3NpMmgvcVNDV1NxcHRTYjNZQnRveEtjMEZZNkdFOStF?=
 =?utf-8?B?YkU1TC9hVkNxOWtZUGZMb296dGNpZmdrV3lSckJjL2RtV0lnaXhtclVDY1lY?=
 =?utf-8?B?cDFSVkI3bUJaVzN1YVMxVDBaU0d5OWh5Y2xJZytQQzgxUXEyK0pyTDBzdUM3?=
 =?utf-8?B?cWZrdklUTnI4TlVMMGFGNFp6bk9ESzl0c2syajNWTEk2OGtsdzNNM3VmQzgy?=
 =?utf-8?B?ZmRUTTQweWVhYlBobEZJYm54Z0hiUzFSUE5GTUJyNU9xMnZ0dk1jdTB4cmh2?=
 =?utf-8?B?RFdVcWhONzh2aFd0RVJScmJKb2VUeGdGZ3p3bC9HT2FuWHpNUllJUFFWTTJt?=
 =?utf-8?B?a0ZkZkJOQ05sNXg5Rk9GY1lqQVMxTmxuVnBJcW9GVllqK0xReU1HK0NaMkFF?=
 =?utf-8?B?TW5kY05PY3ZPRzJFOXF0Z3VzTXZGRTBueUREK3VnV1FQdnh6cmxiUzJRQ0E4?=
 =?utf-8?B?bHlWL2dQUGVwbHFnZHljVmdSa2xEMlNrZlFnNlNTU1diV1AyMng0TlMzYXI2?=
 =?utf-8?B?d1lCeG0xd1JGQUhpMjdzZytWU2JYQjduM3RYTnR6OTd6MEZwK3I4ejNNSTJB?=
 =?utf-8?B?Q1lpVERzb0F0WnFuQy9ndzVGakRiaGFXenNPdEJIVFNxdmtsb0NOZlo2UDg2?=
 =?utf-8?B?RmhQSWJzWUxQMDFpN3JLUUcvUk5aQ0RPSEcwUGpmd25zYjUzeEJKeUowNEgy?=
 =?utf-8?B?bjRHN2NkRTlQa3c4Uko3YlJYQnBtdUF1dmRlcENPUHdNYktWSi9jOTZkOEx6?=
 =?utf-8?B?U3dqRzVFbVBWc3UzTzg1ajhJMTVxNjZmMjRnZjAzNDd2UXlsam8zTlZhOVFq?=
 =?utf-8?B?Wk1QWW9UMG9wRGJjbjFObko1SDNHc1hPRWtCT2NTV3hSZDVDaGJGckhNUXVC?=
 =?utf-8?B?QlhzdFBVL3RXZXZSM1FydUgvOVJPaElnRVcrdlRYLzF6YVNoSkRGcHpTLzhk?=
 =?utf-8?B?dlZaK2Vra2ZPUDJrZ2g5ZXpObmxMQWg3T01NNnpwdTlTblJwNzdFOUVEUysv?=
 =?utf-8?B?bHFMWjJHcVEzVnZJVWxrRGxVd2xRWTZHVkQzQ2dpdExqOElZNmhWeHhSV2xP?=
 =?utf-8?B?SUtwT1JiaU4zd3VOUFdzWlNXcXFuck80YWViWUJ5Y1EzSmMzL0RreDZiK1pj?=
 =?utf-8?B?ZjluV3hDQjAwRUlFaXA3NU1VU2VwVEp1VVlXNlRLUk1MbmQyNUxrbHRKWmZy?=
 =?utf-8?B?aTIrWlBZbEtpQlB5eGV4ZzR2UmNXdEFUbXYyQkJxckZQYXJlY1BmL25kR2x1?=
 =?utf-8?B?MHd4THo2WnJhWlVoTVhQUHg0bHJndGsxU1RsWkh5MzBWY0NVeUJ3ZUI4ejVn?=
 =?utf-8?B?aFFkV0ZKM2VJOExraXVBRXp5V2hsbGJJWDhoVkxUZ2dPK2VlczlZTktMcUl1?=
 =?utf-8?B?NUl1aXNPU0dKanY3ZmtQSk95c2M2a0JyT2h3VHdpam1zSGdMWFAxT3d4dElQ?=
 =?utf-8?Q?rHsmBw3+Ill2RBDgpzvt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfc2c0d-5a9c-449d-9a5b-08dcdbfe7395
X-MS-Exchange-CrossTenant-AuthSource: AS8P194MB2042.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 18:35:09.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP194MB1757

Hello,

First post so please be gentle :-)

I've got an eBPF workload running on kernel 6.1 LTS and we're running great.

Use case actually is using eBPF in combination with XDP and AF_XDP for
volumetric DDoS mitigation.

Makeup of the eBPF program is mostly packet parsing, LPM and map
lookups, and 2x calls to the bpf_loop() helper. Currently no iterators,
dynptrs, etc, but lots of switch-case blocks.

I've started to test newer kernel versions in preparation to upgrade our
stack from 6.1 LTS to 6.6 LTS to gain access to newer functionality and
just for future proofing. However, when loading the BPF object code on a
6.6 kernel, the BPF verifier refuses to load the program that 6.1
accepts and runs well.

This caught me by surprise, because I have witnessed our stack boot
successfully on a 6.7 kernel. So, I've run veristat [0] on the exact
same eBPF object file, compiled by clang17, but each time running on a
different kernel version. Results fluctuate wildly!

Results on 6.1.106: success: 53687 insns and 5114 states [1]
Results on 6.6.52:  failure: 1000001 insns and 39501 states [2]
Results on 6.7.9:   success: 131418 insns and 8839 states [3]

I have done some searching around and have found references to faults
with bpf_loop around kernel 6.5, patches being backported to 6.6, but
also references to those fixes being difficult to backport to 6.1. Being
truthful, it does feel like bpf_loop is perhaps not working properly in 6.6.

I am going to undertake some more testing on much newer kernels. While
6.7.9 loads the program OK, it's still more than double the instruction
count of 6.1, when obviously the binary isn't changing.

In the meantime, I am wondering if someone might be able to advise if
this is a known issue with 6.6 and the possibility of pending
improvements in the 6.6 branch? Appreciate that isn't easy to answer
without visiblity of the code. Happy to post a repo link if it would help.

Perhaps it might be better to simply write off the 6.6 branch and wait
for the next LTS branch as we are approaching end of year.

Many thanks for any insight anyone can offer!

Kind regards
Alasdair


[0] Exact command run each time is:

  $ sudo veristat -e verdict,duration,insns,states,peak_states krn.bpf

[1] Results on 6.1.106:

  Verdict  Duration (us)  Insns  States  Peak states
  -------  -------------  -----  ------  -----------
  success          23763  53687    5114         1953
  -------  -------------  -----  ------  -----------

[2] Results on 6.6.52:

  Verdict  Duration (us)    Insns  States  Peak states
  -------  -------------  -------  ------  -----------
  failure         325270  1000001   39501          866
  -------  -------------  -------  ------  -----------

[3] Results on 6.7.9:

  Verdict  Duration (us)   Insns  States  Peak states
  -------  -------------  ------  ------  -----------
  success          56959  131418    8839         2713
  -------  -------------  ------  ------  -----------




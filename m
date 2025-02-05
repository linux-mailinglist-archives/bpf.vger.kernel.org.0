Return-Path: <bpf+bounces-50554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8FEA29A11
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A132165ADC
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD41FFC5D;
	Wed,  5 Feb 2025 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VWwjcj2q"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2084.outbound.protection.outlook.com [40.92.59.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA11FC0EB;
	Wed,  5 Feb 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783711; cv=fail; b=UYgQJBWqG8j0Jbu0g5pfpGM4UxticDSJKEIsNeg0C3re8NaNW2M+lJfdGn8hrvbNJEnHCXNULfgRFQKk4ALgj73TXYSdNTGP5A5WRUor8vRGquxs2ANKT+0naBApbmE0HbjTvpYY/wCcca4bQdHDphpwCproddru2m1hHevDe+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783711; c=relaxed/simple;
	bh=CSxDA1DGaW0HRICs8byDtFvfN8NnVxIOtudWGzrnmhk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vn2QLikPd944eSzWHFeQuFj5OU7ipp1Qql50VxIkZ7PfSWA9t3xZUXKGouBcm8anQTDAdL9mfGiAZI9p7btxqPjbsgxdwQnOzhEq8CbknyQu17nsCn/VGjOFLMFzhGUCrbL6hahrdFEFnD0a+dAsgcBqSwPqvXQQUezzOPE6Qn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VWwjcj2q; arc=fail smtp.client-ip=40.92.59.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l74hYj1J6YbBqRqTnMg5ZjaaF51S8mXpej/uYrBxMQvfWATJ27q/XfJmjWdENXqIw3wA4CP9Cgj0bAVNPoA4nupeP4zPN/OlcIQaXh/GNTQ20nazG6ofXUZ4uLdJCUtLixslfuswU/suVuRoWoNSF1hDJUjOq39J2pnDTK0VTxmGtViPAGU3LKf36lx/VTTdf5hzaEuAKO9FzPhFgFNr91sx0UqrKJX845XRjE0R+c+j/OhTMg8cHEc4LYulNQ6ZMwUOY6WIKW0AYW4XKbus2nhg6pxGCqSoxHiad9nu8nN1OJjLbeaDWFkEq2JnAdsDa7rDqPsAOjZwaK5F8DKWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Kg9Za0DjTuHxqxuC/Baz2nehHgsXNrPJ08TEPVMDnE=;
 b=g8nIXq/RZcczBOyF/RQDwgDmMiY4tXvt9DdUaZdKviRtPaOXHJc4Bhuhal6BWLRQlB2yJATlhy8y1lLgxmzuffb7CabS8hiaJIR9Mkgi6T9gGzbHBBdjYgiJsJvj+sD9U0kFor3abQkhGx+vYOWQ8rq0whkWZnpFm7woYgsz+3mCHP8QmWIYa9SXJGzvWSK/YjQGi9z4gCAKR5z3KKFjXuIPZB1NFshw7mkudAFRvwsBm22gvme8CjO3LKqHjlL1XP9q2Vt+45GBNtutEpNg2jh5m/tg/AeVWvQMZCrjjaWFuOGX8MIL+tNUAQI99anKAwOzoQG6Gzy7QKDJatvZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Kg9Za0DjTuHxqxuC/Baz2nehHgsXNrPJ08TEPVMDnE=;
 b=VWwjcj2qV5B3GTX0lBC/xTJJSyZg5fLLpqdICNAPGelLZ6d67FQyd3VgM2UCwj+WH6zINb21oJtPmZT7U7mWjve9gFUrVKehHsMEDKnUvxDKUGIrJzIezgP35d8wG7TFAqs64B2OgThZS7gjV+druf6/EQdIayEZld1QGtBbUeq/gushgws17/JCpFVhu/OHemnCV6GCk9jf01DiimIDTa0P7ER2+omy2MVOgw8rg1bdz7McNevR1UrrMTn1K1tynavxeSveJ6LRK3+b4p0WQoTY6rnukXKSuOCFfk/G939l4+kc4yNAE+PC8ZvKzsnUkKyIMLPJNquUhSXQiPko5A==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GV2PR03MB9619.eurprd03.prod.outlook.com (2603:10a6:150:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 19:28:25 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:28:25 +0000
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
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 0/8] bpf, sched_ext: Make kfunc filters support struct_ops context to reduce runtime overhead
Date: Wed,  5 Feb 2025 19:27:09 +0000
Message-ID:
 <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205192709.184482-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GV2PR03MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bbc959-9796-4ee4-4043-08dd461b42d3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|461199028|5062599005|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yc8P6oHRme9yN7UifngfdtEPw+AL/8VgHRvjiccahnZCTMUIOreX3FFd6bl+?=
 =?us-ascii?Q?/mKpE+nBWLuXGAME7IEEW7VU/swrxH58MFHwloJvdejrnLfzLNIaCANesy9z?=
 =?us-ascii?Q?B1BV1nvCKpJpvvpIyTRulkQAFezsn9D5C46++9ldGxt8raLsCkFckzw7SE9E?=
 =?us-ascii?Q?woplyyC3x6HEESWfpUc5WpZfymalxW8oJi7vqalfqW1VurM9RKnQA+Zr/WYe?=
 =?us-ascii?Q?iQoPPgrai3+RGqDyg1AoKzYlbOkgap11f0pl8qYCIu/Jt+0p0QTKLyGYY/UF?=
 =?us-ascii?Q?JleBvMipYXQCy114sPPBAaOfS4+yf88oNIi9jyNxtqpjAO+S61JyZoD0gC66?=
 =?us-ascii?Q?liwEk9MoXKcpmV1axpE9f2P43q0iZLE+ijaBFt557prfnuT65VBTFSyFmyq4?=
 =?us-ascii?Q?m7f7qE8qlMuhIkF6EdTaitJTU2M0vnS5zqiy8nDBoVhCWrBM3ZigbATumy1J?=
 =?us-ascii?Q?fAO15OIiZiNdMxHZ+p7d0dc1pRhAzBmBtkYV0YRIXm9pOw+nplOihCyrpCEq?=
 =?us-ascii?Q?wO4HtNVaPdCtigeCQc70SIuNfBTE7jIqRV5BhXe0MfBzwmOjjXM4c0JmTrtT?=
 =?us-ascii?Q?8AQc5arpBbJ+vRboVUrF9sDtbAlURmbWUhcD8KbOBwnA52DwDI9kO4JTlOed?=
 =?us-ascii?Q?w1dN8Sjkj0MxbB9WYGhN/vavniDAAu6ZCWWgpON7K7fHQGlYSQRkrq9PHmFB?=
 =?us-ascii?Q?zJsgMJO2F+r10LC8nyP0soXgFVeF1PCPkP64PErl7z1D91QqvEZQlXwEjjMX?=
 =?us-ascii?Q?49LQupoRAX5N6wTsnCSoKyF7OqPDbdhxQkMtyDkThiDwBr1krPIkYOxX9v9R?=
 =?us-ascii?Q?IfC9SAraE+59XEZwCBbhk3s93NblmtStNswJDllGaiXTbKRq24VsuVLhZGad?=
 =?us-ascii?Q?ZXj8dFbLxvBAD5U1B0GS3i1iDdMvAAvQLHR21vg5r0s/So0XMtdhEyx1dm3p?=
 =?us-ascii?Q?kgclZASmnLQtE6VAdQ0k2dc/r9Ze24HKj0x/SOsCEp8SzqQ+aRAimqdz7tIh?=
 =?us-ascii?Q?Kgpt2vIkvP8heVGXHaMoY552Aah9cpspD+gGaTSN+bkk2JcJY37jWj/hBGwL?=
 =?us-ascii?Q?WPNELs8OLz7EdEaMweLOgJ6VfBdwWg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9amaItNIvc62XdvgrOE0sz04mF8g5kqP2QC3NvhJ5zSE56Tr2prSQui8s+c?=
 =?us-ascii?Q?l+VZ4dNlVTGH5ml4L/fgrg7vUTCW2BYO66obL+kGSKqozojj5W91WLfm09k5?=
 =?us-ascii?Q?wfOBXAMvCRyzGv07TkPvABf8N7zOajanGfZVXlqQuRlG1dAccqdVGyFtRyFB?=
 =?us-ascii?Q?EoDQ9AltR0ilghxyROR5Na7ODRh4sxi4I86e7NSfJF5epaZRmgvBOoqCTWd0?=
 =?us-ascii?Q?BARBOe4yfS3XaayIMEcnNBgjGMLSfZ2k5L4q1zlrvrPy0cn5MfpMTFQ6UvW5?=
 =?us-ascii?Q?7U5dDFN7DR2zXBpOSxw/H72bBQYMIC1Vj4vV2wCNKKrB2LXpLrAYHQPRVrTF?=
 =?us-ascii?Q?AGwtzcKdRZRMydjBkrHVO3MeDz5qxfcDWRcWB3fqu7bmdDkJRHPpylN8Oef8?=
 =?us-ascii?Q?WL3Deare4EmMZPpEOnJ1Fy12snlAReDjGDDVtzWax5dvfIj/nheENEHYqYTV?=
 =?us-ascii?Q?ydr2B+l8Un4AbWXFr0nSO2Rm25RtsoCzcFdcvB/vrKycWuQxG2S5mjz+4SD5?=
 =?us-ascii?Q?DnWO3D1e7AO7+npGJwm8UlLxAzIG75wzjxHD1kvfpC/BzLLEUY4+kJWSuWrF?=
 =?us-ascii?Q?GiBg9TSsFSceYbwN/oHECoidG4FeyoiHsc2n0VRA+vMjgWAHVSVozJ5dTzqv?=
 =?us-ascii?Q?DZWDwZ1uvSyAxIGUlyPcrgM80W6Dxxvg6sGmOZpYIxxv/97b701zGd59Ihao?=
 =?us-ascii?Q?NI26wSA72elPSmtafdYZoBGVUxrx5LgsK5TMleb7DsMu9teGsAlwjQ5XaelB?=
 =?us-ascii?Q?nIy5WO3Pp0nP7drpjYeK1loOgkqiBs/v5cMjnIxOepqXVOTGOSibJJicAh39?=
 =?us-ascii?Q?hfSHc2jeijB4yBCce4UJCrj30dTMW5JxEz2CS8NhNWu7o+k/5Dt8Vue6YyxP?=
 =?us-ascii?Q?ZPVVDq8oB48vTXoXvi0OCHJqSo/WGbHOo2Ejh2nj+JPf6kDW9E+srRA0gG2d?=
 =?us-ascii?Q?quTuJ2FXCrAWBuFFhICB02CYkE3+RTiNrj36wDvQVLkZRH2y1+qVutVssFNn?=
 =?us-ascii?Q?QKFyDUBovt5dyvV5t+wN+HtMoE/0WIXVZUZqaaSEM4tBzOG5bbZztGhnnyuH?=
 =?us-ascii?Q?6AuvZlaJG8lBcVj7ddWbwTdQwfqR0/c2bi5dfcVmTRGcOlQ5lI12QjhzqkN0?=
 =?us-ascii?Q?bvFZuHbIm/qaoLeZGm6vaJmqAyu3FnpK9cKbrfXVYbWvsukK9dnLUEZ2MFD1?=
 =?us-ascii?Q?9Sc9NwgxJ6jXjYbJu6q79XMoQ9No2PAg6036HjFTZA9xOi+KJcpjOyfdEKmm?=
 =?us-ascii?Q?n0ECXAc9HXid4NQ1skap?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bbc959-9796-4ee4-4043-08dd461b42d3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:28:25.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9619

This patch series makes kfunc filters support the use of struct_ops
context information and adds corresponding filters for various kfunc
sets in SCX.

After improving kfunc filters, SCX no longer needs the mask-based
runtime kfuncs call restriction, so this patch removes the mask-based
runtime restriction and updates the corresponding test case.

I added *st_ops as part of the context information to avoid kfuncs being
incorrectly blocked when used in non-SCX scenarios where the member
offsets would have a different meaning (not sure if this is necessary).

Note that this is an RFC patch series and I am not sure if I
misunderstood something or broke something.

If I got something wrong please let me know.

Known issues:

scx_bpf_dsq_move appears in both scx_kfunc_ids_dispatch and
scx_kfunc_ids_unlocked.

This results in scx_bpf_dsq_move being incorrectly blocked by
the filter of scx_kfunc_ids_dispatch in the 'init' context.

The scx_qmap sample program fails because of this.

In the filter-based restrictions, each kfunc can only appear in
one kfunc set.

A possible solution is to add a scx_kfunc_set_unlocked_dispatch
kfunc set.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Juntong Deng (8):
  bpf: Add struct_ops context information to struct bpf_prog_aux
  sched_ext: Add filter for scx_kfunc_ids_select_cpu
  sched_ext: Add filter for scx_kfunc_ids_enqueue_dispatch
  sched_ext: Add filter for scx_kfunc_ids_dispatch
  sched_ext: Add filter for scx_kfunc_ids_cpu_release
  sched_ext: Add filter for scx_kfunc_ids_unlocked
  sched_ext: Removed mask-based runtime restrictions on calling kfuncs
    in different contexts
  selftests/sched_ext: Update enq_select_cpu_fails to adapt to
    struct_ops context filter

 include/linux/bpf.h                           |   2 +
 include/linux/sched/ext.h                     |  24 --
 kernel/bpf/verifier.c                         |   8 +-
 kernel/sched/ext.c                            | 354 +++++++++---------
 .../sched_ext/enq_select_cpu_fails.c          |  35 +-
 5 files changed, 184 insertions(+), 239 deletions(-)

-- 
2.39.5



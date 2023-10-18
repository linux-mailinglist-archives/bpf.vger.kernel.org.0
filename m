Return-Path: <bpf+bounces-12526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C77CD649
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20951B20FB7
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D865154A4;
	Wed, 18 Oct 2023 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="o8H5YFaB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFBD125AB;
	Wed, 18 Oct 2023 08:22:05 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F14F7;
	Wed, 18 Oct 2023 01:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtlpaESAYWOAsBn+CjofFvVm/KVwYyK76qGdZSiqTpQjU9ze7DjMgl3JTO575BbfS6x1KmZO+IdU3oUB7Jdvkrv3h8N5nHdFdFAhjJmOi6GJ9jhSZKrHVrRqx1VVSMGYvKctK1pwvVRlEvtiLGglfavEBEjLRJvrhRoXoY8fQdSEUlApByReZ3gaqJAO9tFDWy7Sfsnc9zTtdyLOyr5U70H1sgD8m+xpshwqlFZs9Big3CT9coHeDUM8CGVItCB3cOoYdrdP0mnoq2cd8XEEHscymDcpHL5n1YILWDKi5lkyt7jllf5EfB/jbmCcsnkmhwpegDEvpG5Ij+/ASG64fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbm+tAPuNX9y0d/P3X761goPM9TRc2wfK/slu7bysBM=;
 b=J/UMNK5H0Mbh70O5gF//5OaPT38k93H8nFWe6d0xRFvhqn/ycRGmoouAme6juQi9fl7naH0VoH+I45PhOGJudgucwYYUUQMYEntprq+M7pIsCDCG59+Ues1//zbUxHw6RsWJaWm4eUgSzdWsKwCay9wBf46LWtKTHkgo8ykNcKy1GgMtXEhzWqJ5RYQxBoO4rsnZZ6Dy9S5G3KaZt0Ajwus4BpoKH004vnHhUAURLspV+0AY6Cf6nfvKmIb3A3Qk2TvaEuZODC1EUM/M+Rdntw+keipf6HtORa8WF8w0Fy49vuCJPzNcxuYf2fpKtXtK3Y2SbTgmguDpZv+p7GurGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbm+tAPuNX9y0d/P3X761goPM9TRc2wfK/slu7bysBM=;
 b=o8H5YFaBkD+qUzcFhCqF4w/6BPfoiTgSMCZ9QodVK6v8q4JLamOSVXIL7IRL1E60oGGIDgmVD/zYz7220n55ipg2NymOC10gyPVzqbgT/74OvmfY6K3BXJUz746eNxmet6xnyvVw3naDXKlz0wnWGBA+y8h6eGLrOVs8ZY+3AR4DP8WCvcKIQz5YO7TVrTZu9Yexg50HYXBs/4ytA6qiJyerMu9Kxkw/qFlp34Xjpv2aWL2Cb57WIWoDCLSid/UdvPWJnvR8U1SFhR00E8PH/3Pxu9fQBvceaUwYtVu611AwnZin9NEs8e/1UCbDTc+682Q/P+YLR/+sNLI94ZQpvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PSAPR06MB4391.apcprd06.prod.outlook.com (2603:1096:301:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Wed, 18 Oct
 2023 08:21:57 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 08:21:57 +0000
From: Huan Yang <link@vivo.com>
To: Yu Zhao <yuzhao@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huan Yang <link@vivo.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 0/2] some fix of multi-gen lru
Date: Wed, 18 Oct 2023 16:20:58 +0800
Message-Id: <20231018082104.3918770-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|PSAPR06MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5946e0-1209-4f03-5fed-08dbcfb34af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kOJvDUouTh+53/KINue2xCsWpxKzoMHmZYaA8Ggo5vtEPcrb9vTOgpYzYHvFJ/1kvrup5mOjcB69AEtGBZ/8DVBjqgwSiHJqaK+gWAuzzzp0pTscYmAa/iyk6nMnYrtadlOvdcxXVkEMB+6LR94zI8NNgn0ebLlaE5e87T30inrOkqm64hRyfdgX/gR4ni6PiFkL5GyPl8ARGIO2ZEG61rcTkqUoGhLrgOM5cFjm9XRzJ+6byJehc3hxTYRYVXEDqGNp8CUkfrpun/V+Ly1Q3xYzvFwIGq4sAvmGjrkVzAgtQGzoRBxyveLm8CW5VRrSiu+J9DBMvC+9JE8Mw+grcDf6ruRI4TtARTOFS+V6OogEI2pogWfzbi5q4W8sxu3UMRxGEakybBsreGwzfrRQjjQ2ri4fHO51+C+Tdz0UsbgiEusy93pZ07O7otFkZj6+6OhlxiUl0A2Kv2UmPGt75cyfbP/vVNVZLMCPgydWsAigTXUh6NszjNH4cqNOSr5hnnw8ixM7kO46x47g/avl+28qqxmKf8BywSBekk7ssNg6dRtLKMaQU+l3wZpqIy7i5qVJkoDdXZoH/csNkvb9NQa7VLWL9Veqq6kDGCvp1dDUKVt8UEhMFjXI98p26N5gabZwf9phdnxfRDwyG+iYfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(7416002)(4326008)(8676002)(8936002)(5660300002)(2906002)(86362001)(36756003)(41300700001)(38100700002)(6506007)(83380400001)(52116002)(6512007)(6486002)(107886003)(316002)(478600001)(1076003)(26005)(921005)(110136005)(38350700005)(66476007)(2616005)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NCBQP4wIDalMkTCDGm+gYZd0U4nf1rn+BgosYAWrxUH763DkVWYR/qfOte2n?=
 =?us-ascii?Q?bmXhYbZayx/ONwKn4r6TCgIZf5JUPRNY1OOGKkKaRiy+cQlCQGQ0oXMxP+ld?=
 =?us-ascii?Q?F9/UY4UT7foV2pYcCFdfWnUuDZ6p4zsXtARYGOnILeWEEIAy0QRubu76R4Y3?=
 =?us-ascii?Q?shzkKoZ0Qat4PjhfErq0MnjwrFiJVUbQpmoY+sq8j4/WSw1bgte7R3ZtiVAu?=
 =?us-ascii?Q?TEtTL603COkb4Eau2X41abiuW7tuyIIgXYM5/njymMHTgqLyk8HHYAwDUuPj?=
 =?us-ascii?Q?0vJTB8m89RuR86oMGNU+M9YvyIg+ihGEmaB/ClBdGBdmt73PUG2IdsM9E71Z?=
 =?us-ascii?Q?1m3cCz0aasF6M8CGGPt3MF8gLGn/Hfmdf7ff3/7ELsYP695NcKcXLXWHOasv?=
 =?us-ascii?Q?hNpzfAnoBCsAlEJ1YUfQEKSIRzgFIchRsJt4z+390W52K5u59OpUKjmo6Mih?=
 =?us-ascii?Q?isyIWeF/5JhQHXqlS9wQTSSt3Oewl1bjL9n+AF4AM1CYRgH3brQPoL/LPxZ3?=
 =?us-ascii?Q?aDc5vUHzF6dXBjHjsbW317i+dwy1IJHO8nJia2h0f/oy1OVMWUxAZA1JbF6n?=
 =?us-ascii?Q?k5hsvRpQ9uBlxt/5J8GhDAxvRrGZGi8/wNfhsj3zTDb0lwkckNRU7rZkvXuL?=
 =?us-ascii?Q?lGhLQGHZwBsfiq6rnCU6QDXYBBzint82jjIoF2X2T+rTkwQNuzHUE4S7HdlH?=
 =?us-ascii?Q?2feiQIVRyKRJH5zBEECjnVddVb+0LeijQFl36BsDVBqz6GOI0ttGTuqY5VLg?=
 =?us-ascii?Q?0h+rrqJ3GEeRbNB/L5OX4b6uJbQczYuQDBBBLdNXf1eS9QOywYQrBzLU1C1f?=
 =?us-ascii?Q?IAGlDDB0bMZNyn9AV6t6xUR/v8jpjCAs36Gi/j8dXt38CGzww3fPwFkieGCk?=
 =?us-ascii?Q?ENkKn+IfdgQSbuVwv34XKHnrnS1rED6MhM6SznLn4Hneew4Ezp9V0euXQ7mC?=
 =?us-ascii?Q?3TuCaie7FMO1hhc2bb6nlhfxWpJvb3o/92l3CLrzN2vqOs/n5ZGKwWIZIURE?=
 =?us-ascii?Q?hGfu26et6muiFXsLgNc64VCsF0a2PepOq56/jFbzxpi7F2XJXcIUKj9gR6aL?=
 =?us-ascii?Q?ga+HiVlmdGVSJg18XBVu1zPlR5oIDocUxVbOGoAtBXDz7vDFrgexFvYirTfs?=
 =?us-ascii?Q?ln/IYdnbVeRHv4xKZD8Dsxb9ssiJH0LdLjYwQwXF6wGRMIntxXY/a73pLKm6?=
 =?us-ascii?Q?MeMWwB1yroRLEJAOK+gISrHgU7UBYMH4kejuMEaRM/4n0jJEJ30iy+ChLQ4W?=
 =?us-ascii?Q?s2TWFpsVnJAI0Ptv+KL8D/HA6z8uDOeqd0HynK787QHbIAkbNPhI8GqwW0oj?=
 =?us-ascii?Q?5qx07Yq5aBPd605zPbqh9iv7VWyPsNPaLkA47nwgy6UfyUDMH2PZgfhOQixW?=
 =?us-ascii?Q?4cyuG3gN3obucJJdLIV+CAvRe++tXxaSQkJtKYl3+TNziXTxOTyOOtFdhGS1?=
 =?us-ascii?Q?UNHwvtqteQe83/P38usv+Wv0EXZea5ASTLcptzSXfrjjvpIdb7Qii/Or5TY/?=
 =?us-ascii?Q?W5sQSPcbFaKrVakF5gYiqOjTa9E7pNKBpmlg3TiU34lAualG/icOXIKQIC/e?=
 =?us-ascii?Q?aEyB7XvXBqsF2a8fNVcufNlh/Xq/Xu9wVEnVCOx9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5946e0-1209-4f03-5fed-08dbcfb34af8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:21:56.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ5dkRou410tGNW2aZw4ozjrirJFFNjzAAhzvNodF/p9CyENts1+OYWIYWNJn+MBUh51uckWOQZ6pedKB4Yv5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For multi-gen lru shrink_inactive trace, here are
some mistake:

First, nr_scanned in evict_folios means all folios
which it touched in `get_nr_to_scan`(so not means nr_taken).
So, we may get some info from trace like this:

```
kswapd0-89    [000]    64.887613: mm_vmscan_lru_shrink_inactive:
nid=0 nr_scanned=64 nr_reclaimed=0 nr_dirty=0 nr_writeback=0
nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0
nr_ref_keep=0 nr_unmap_fail=0 priority=4
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
```

Actually, we don't taken too much folios in shrink. This patch
use difference between before sc->nr_scanned and after shrink to
replace nr_taken and pass this to shrink_inactive tracing.

Second, also like above info, we can't get nr_folios going to where,
actually in multi-gen lru shrink, many keep by folio_update_gen when
look around or other promote this folio.


Third, evict_folios don't gather reclaim_stat info after shrink list,
so, dirty\writeback\congested stat will miss, and we can't control
LRUVEC_CONGESTED or reclaim_throttle.

Patch 1 aim to resolve first and second, patch 2 resolve third.

Huan Yang (2):
  tracing: mm: multigen-lru: fix mglru trace
  mm: multi-gen lru: fix stat count

 include/linux/vmstat.h        |  2 ++
 include/trace/events/vmscan.h |  8 ++++-
 mm/vmscan.c                   | 61 ++++++++++++++++++++++++++++++++---
 3 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.34.1



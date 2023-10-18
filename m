Return-Path: <bpf+bounces-12528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C527CD64D
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001281C20A47
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321BE154AA;
	Wed, 18 Oct 2023 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MjIb9KPM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E74114F8F;
	Wed, 18 Oct 2023 08:22:13 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB599EA;
	Wed, 18 Oct 2023 01:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJNjtDbq5MY8+/8k53ArckBxifmZ3KLitaHfWuxF7Nz3cOU+QjGYAk5m0wFCitNS3M8GSfOezR3YzGbwOpzQzsMczdWV21Mc5KCgIuOFPAFMVwM+IeR7I1E+IBnWz/TKijbCAuSWc9gUV1XYkaV4W6EvVdmWCpMpRGE1W0vbS+t3FCwXT5MGBCwzAaO5MLGgHt4bvnqPT37uX5t9SB1aNgQwFim5wyqYCr9Raq5uUgbCAk371n7CH3T3U1+MyxgKrfwnUcvOmtyeQVaRA9EWuJzsO8lX+WcuI6QKDZQi///G/wsm0jJux2R221KkZMxL5G9FcWGcmTwDSrIhkmERbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWIhVH8kG9NLSbfhfkLvuBEveomuvEk4IFEU8DuIXio=;
 b=HoBI4C5m4aE6SBXmEpXbVG+5nDYOYPQoDTMVFYO9jWmNd0rXgqDco8BCrTOybW0rOvDHaP7CmGgqSJ6rOFQj0HFDVjSvLCi91zpUUi3x6E4zVA6CrHCVLpx44nAlmqaXxBMaMRdJ3Wwezad2D7zEMSekGiaXUPLyJf98KIloCfObu3Eno8gs7OQyJFM2TGr6mS+yzgUvPAdcJ1yr2jfrAZNwfXvrHc364iXERIIAB5Ow89FzCtSP39pJqQBgZq2lRI9d2ht8cSs/QuBZInuD4EuBmx2GzUxozcIwNsufpXPtP4rus+ZqcBXIAujpN7pMDKB4D1Ozp7tFeUj0GKEZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWIhVH8kG9NLSbfhfkLvuBEveomuvEk4IFEU8DuIXio=;
 b=MjIb9KPMWPUYy+bMJuJpjnkuL420kv/3z3pEzhwh8SAjHMqqKmt/y+Tjb8LgoNT6QlWDIKhTuaAwVfKiTP2vr8yZATvWYUio4lA1R8dgTspcSIXPariaag6SvQrqXub8w/rwOK8q99B69S2+ULL+ymD64ZtkliXS14n3F5J1vi87A8joyQSemM9Pzydh2IrQJGGgYgZkYMb7dtctvJH3boF34We9FPgBRbbkAHp7UHuzpgRk28AVu2p5JyRrU9dnV2XhypmwEpPZNQ+OAxF/6l5yDV+hX4dJlLo0BHTB8qU6cPsz2seR4LxaHDtc1zNGTHMcwubLm51R1I/CidfgLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PSAPR06MB4391.apcprd06.prod.outlook.com (2603:1096:301:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Wed, 18 Oct
 2023 08:22:08 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 08:22:08 +0000
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
Subject: [PATCH 2/2] mm: multi-gen lru: fix stat count
Date: Wed, 18 Oct 2023 16:21:00 +0800
Message-Id: <20231018082104.3918770-3-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018082104.3918770-1-link@vivo.com>
References: <20231018082104.3918770-1-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9545bd03-848c-4418-0106-08dbcfb351cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jUXaTwskgInwOhmnvEmDReDAfqDVqzr1IwWmWfcoWsvlRGiNX4DdFKXyC0cUpqsDU1/L7wAWXGXxSWaoKes/+WY8NKHpK38lOUkf6H7vWwxuJxcxa5+Sq7tM1lcI2SWHrtTLtw7g+88YXsYpdDAkLnAMRAUxfPopSL/6FK3LTCayh3Je90ngSWQabyYR0ViikbfA294kwBAPR1BOC5NDeKjt+21sXewM+5Evl10Lrq+VZx5GcFqvB00cnV42EPtlyTK7hl+chsVZ0yVVYJ7PgOf5xGcs+bW2bqoeSM8u1mavoNI/PhHng88meKc0/9230F37vj1OAyJ5qgAYsgpmwuDC78dT4sdZ2xZX5erfFe+ibcHsHPA3jj5W6gSWIU7aZt6gkmnNJkn9XUge2xpC6lzlRPb/UkUBUR4v/v6EcMq+GvMc2cseGS8ITq3Kj3IWoCDzWiRTr3HPmW+kvhrFK7yIRDw8GeZOsi12N1lZLtk5zoclxO6TTX4e6MExk9okVudUHfRgEK20WvtkHlSPF1ZUolv5JnQ0wXxM44tQf1ou11k7lGP6fzNApK+R78WUz4niOhOiJL0YQ7526uwKD7TrjipdDkxdA79no2KRhF81PVI7so0jEFGTmu4wLLuBikc4qjppQ1GQEILok2/gYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(7416002)(4326008)(8676002)(8936002)(5660300002)(2906002)(86362001)(36756003)(41300700001)(38100700002)(6506007)(83380400001)(6666004)(52116002)(6512007)(6486002)(107886003)(316002)(478600001)(1076003)(26005)(921005)(110136005)(38350700005)(66476007)(2616005)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mnGyRBonP7nfJzGGd0Um/FvTMR58vdZaxRHqIIFzgsilsKyy5clAdGYSP1d?=
 =?us-ascii?Q?hvgZwe4sCfCVXTq8JZ27b+qjTHILP5JFbK3s5ZV4qggD0iS/AHRNWwQSW+Fx?=
 =?us-ascii?Q?nzmogV3PxCcXzGiI5KjTknsvMDYNP5pMjT/E1waJx1+fTtHV2oNNpGsLOuQk?=
 =?us-ascii?Q?1RGLsldoyweJoLFLTF/ofHzyGxLzZpkfVhT1AGLciZWiybkUkiqXGqVinDB8?=
 =?us-ascii?Q?0iaVQQ/1dwznJFQq8A4IlJgie3sEmAkMMsANTT/9xGAvdYezSZ114BofuBXw?=
 =?us-ascii?Q?aul0yOkSMZfBX9z29b/8tSPjdnqfXjB0Xxtm9gw6wRePyopGHnZNNr9tcxCC?=
 =?us-ascii?Q?ojrBI5aGdEamZbLCCuWKuDO8bEtXNfFlwEG3OqUEARRYX2jGwvr1hoj5ceX9?=
 =?us-ascii?Q?zohH3JIeFQDOD1N2c+YkZZUYrBUgkTvIZqlukvhjEJmrrsc/mTOmvz8m9LLP?=
 =?us-ascii?Q?wQ/VzkC6wHUX0EBN9W26wWtDewB/Mq6RVOHe2I2KtyfhYBNvGVKhpKsyLY+8?=
 =?us-ascii?Q?cJUYMkLaaAIWiCK2GqREghKJEBhn0gMGLVa1RocUoAtsHm2IxN6DTJ9mvZWi?=
 =?us-ascii?Q?/GyGe3NUdAiABohIRWF3zn/Igfgi0yHAL1msVdm3CB5P7kmXlsUj3AFP/oFz?=
 =?us-ascii?Q?zx3vRa7zf03owoIXsrUf8kHBca+T7WJ9L/YR101sb7P/wA6XV1SpufKFKpa5?=
 =?us-ascii?Q?tINUWV804zq1kwQHjbR0M/7TND8Swmi3e22mQYR/oLcnMln8suqut0kP0JkX?=
 =?us-ascii?Q?2BsEs1xNWPsz4BIqi0rkBGMsBl2tAGdTFKnIoybqFCOVJF2ZddBbLcikk6vv?=
 =?us-ascii?Q?V3n6nT68lDQL1gMCi/5ErV/J5KTt9hVihk06Rd6FjxHootOd5Beh2zyGIZA7?=
 =?us-ascii?Q?vVzIUCR/lE3NPjJLZ4ooQ0LTICL5y526mtyQA/MTaQn7CWFF7O9I+5uepj8C?=
 =?us-ascii?Q?dPT7X6wEn7aQ7L/FB1C4Fg2tFVIDpHZR6yA1vzkFywmKONvwRzoSBqflx/PA?=
 =?us-ascii?Q?vSm1MDGsZjtCGOTWWhmwzXxz4fDBJc1nmqRwltsM5mdGbkFTH83EeblFu8Qp?=
 =?us-ascii?Q?i8ESswdFs7f1WHkzYVSmo5YKc8JkyS70WtJ31EOFUuxQzpw3IYW3yMRYXLh2?=
 =?us-ascii?Q?BSfe4fw0v6ChAkJl1LEfEntQI7aCMbeHa+fqfeJuHvKzeShQXqmy9PgrkLh+?=
 =?us-ascii?Q?QZYugvEjS4npEwYqXcvNoGpPsDFvLHnLa6dSxXmkEpB/O7ZxqVCih79zJxqM?=
 =?us-ascii?Q?YTonxev19RPF6VFuiL5nMVPZjsyd+SGWNx5bhaiIqG7yN0gbNJZMeF4P/oCz?=
 =?us-ascii?Q?DaoQY1mB3kb229llzSewyzoHsbTs6JQYDuFY0cPzqEaXJOpgcdVyjeYLaiiN?=
 =?us-ascii?Q?03x8rGHh2BkjnU5RBwJ4n4eK/iPbB1AgdJTDnqrjAJSt7y38Wunn141Gi9JC?=
 =?us-ascii?Q?lhM1Mrn06uhg449iq75GqZLrvWtjLOFXfujGBxsubClRIqYMAJgyzKsRMu46?=
 =?us-ascii?Q?o+8m/z+WyFIV9uIS8MtXpFdZEZr0Q6haNoJi8WwrRA0f7kg4zFeZfdw1Fatt?=
 =?us-ascii?Q?IfA41MX+k1rH7eZA03YoG96EKSYTaSkxP9Fm06/9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9545bd03-848c-4418-0106-08dbcfb351cc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:22:08.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: humrRbJhtzRz7mHw3ImA04YdvnTUCHIFeVefqEAMtiz6oeqaw/URu+bmPYOWCWlYnOX1btJyeZPTSBYDOvXzJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4391
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For multi-gen lru reclaim in evict_folios, like shrink_inactive_list,
gather folios which isolate to reclaim, and invoke shirnk_folio_list.

But, when complete shrink, it not gather shrink reclaim stat into sc,
we can't get info like nr_dirty\congested in reclaim, and then
control writeback, dirty number and mark as LRUVEC_CONGESTED, or
just bpf trace shrink and get correct sc stat.

This patch fix this by simple copy code from shrink_inactive_list when
end of shrink list.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/vmscan.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 21099b9f21e0..88d1d586aea5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4593,6 +4593,41 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	 */
 	nr_taken = sc->nr_scanned - nr_taken;
 
+	/*
+	 * If dirty folios are scanned that are not queued for IO, it
+	 * implies that flushers are not doing their job. This can
+	 * happen when memory pressure pushes dirty folios to the end of
+	 * the LRU before the dirty limits are breached and the dirty
+	 * data has expired. It can also happen when the proportion of
+	 * dirty folios grows not through writes but through memory
+	 * pressure reclaiming all the clean cache. And in some cases,
+	 * the flushers simply cannot keep up with the allocation
+	 * rate. Nudge the flusher threads in case they are asleep.
+	 */
+	if (unlikely(stat.nr_unqueued_dirty == nr_taken)) {
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+		/*
+		 * For cgroupv1 dirty throttling is achieved by waking up
+		 * the kernel flusher here and later waiting on folios
+		 * which are in writeback to finish (see shrink_folio_list()).
+		 *
+		 * Flusher may not be able to issue writeback quickly
+		 * enough for cgroupv1 writeback throttling to work
+		 * on a large system.
+		 */
+		if (!writeback_throttling_sane(sc))
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+	}
+
+	sc->nr.dirty += stat.nr_dirty;
+	sc->nr.congested += stat.nr_congested;
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
+	sc->nr.writeback += stat.nr_writeback;
+	sc->nr.immediate += stat.nr_immediate;
+	sc->nr.taken += nr_taken;
+	if (type)
+		sc->nr.file_taken += nr_taken;
+
 	sc->nr_reclaimed += total_reclaimed;
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id, nr_taken,
 					     total_reclaimed, &stat,
-- 
2.34.1



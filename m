Return-Path: <bpf+bounces-12527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142DD7CD64A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC375281BB5
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658E156C5;
	Wed, 18 Oct 2023 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="laGlQ26D"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD715495;
	Wed, 18 Oct 2023 08:22:07 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAB2EA;
	Wed, 18 Oct 2023 01:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZBj635fOfB3pvM3VEC6KgU22Nepzixrvhqb8A3RL79ZvXV0G9l1WsS9a8r2VR7PJO+essHhfH81x4dgKjneJ2lYZuryuOZeJMYKupPg+xEkCgFtSa7g1OBG9QvtzR6A+3ueGLLtj/+gm+HveEO9wVxe8ZDuUDBlHLFgXOh/NxoFMZyvMR1IyPDf/0muu0V0FOAHRHfwlWshs6CvZ6pvfMVmzDBcg+jJSyyLuF6a5Ro4PtzAydlNjWR45KX1v4M7rSRhb3vN4WK1PFVPuIMHAh9wcDcMU6E9XNNUJ1nIdI/05pZNq+0O51GdlYCgUZzMmMueuiJ6hzC1LGRu5PB/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/eT6KVcewOpLb+WlLYKCO09cMKS2vKtu5gikp+mGh4=;
 b=bYK+7Y3dUAYtljh1FeyJHbk+sq2EK4rRE4GILFPPNIHErDhESASMSAp2FUWsAm8SC0DzkfC+aBfwLFGME/Wd4lI2cIeeW9YA+ejCiHOUT+e11FNCRb7sT48mfryiODqcOeO8KXhxSajMfc93R4XcCTn/aHgyE2uSm0mohGxQbvTtf4nWaN5OIaNZK+LBNFNGsu9ftYdQuC3fO8bGx2G7j12aChf6njQDxgKjsAKPo9fUWmMsz2c8d3v5iQn59dnAj/rGvDqP9CjxTU3LHagK1Wh3koGKI+SHSk+hT07XEL3FhGqEnWYsZfljikrlVWn2LFM83+C53ExdLGxD3lmzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/eT6KVcewOpLb+WlLYKCO09cMKS2vKtu5gikp+mGh4=;
 b=laGlQ26Db/3Oo5Q6rbxOh0QBdnQzY20bHviAclUVHZzVPRfGbudg0GLr4YhGyNjuG+ZuxpR+/dNvPW7DScsNDEtkZ1+txNEzRyhZWYnMzeBEs5ldkkC4BKXWvwUdKeix556+2+rJVLS9/yMg0R/gQIYGkFroHjh4R9zJXzhPQxyAkm0q4ihErFZWkYsmBxOOoEnObPCa9UuyGekuY+7iyukqd6zVQ4WI/PK94LzfAM7+XdEQXKA3I2Mtl9fuigy0xBuLBLeNL6hPzFdxsCW4FGzXAhY/UEeP2PwIsfB97zNoYPDTwWWOX0TLBCS4P6wiPcnngn9zsOX8SlChvQ76Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PSAPR06MB4391.apcprd06.prod.outlook.com (2603:1096:301:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Wed, 18 Oct
 2023 08:22:02 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 08:22:02 +0000
From: Huan Yang <link@vivo.com>
To: Yu Zhao <yuzhao@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Huan Yang <link@vivo.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 1/2] tracing: mm: multigen-lru: fix mglru trace
Date: Wed, 18 Oct 2023 16:20:59 +0800
Message-Id: <20231018082104.3918770-2-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4bee04ef-c9e2-4559-d701-08dbcfb34e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o+3FWqGIOzyLZVowgOupzkXO8oAJTlvnqz5bWKMj8Kg9qBCCIn9nri7dYvSMLwPLEmb3VXMk7xNDfnnLhtIN11Amf6/O0dQGcprcv3FiaC+UQbwHEzTHEQFlk9icw362J4Ne57g1mJ9MGqSiQ+EmgRYbbp5vb/m+Gl0T+CddAypBMgBF75/LpMMAAT7dKlZ1GNZVNB+jGORAoir9RiQUGNGULtkwgCIsxmjw5futbd5eG6Xe9RRDWKYbvOfhCUjV8Qz+ruTIgYYXsRrjl9n/t6IL2CYKXARBbcDWewHdK7BRvyFyyZiwUvTClTWPtKcMYPsjBDjrgIhQhT4briucqPDWJERpzprUEa+gQs4cdU/GSbDB5K8MhioC4XhR5WxJU6+4GvdE31xUd1FXVOf5SGo655RVLVOfjx0CcL8zSaSt0ixvRyfAueWHRkqYINwMUP/0tZ8rtNHwF51VlL31WY9FVyEDRHnh15F55IAMJa9g4wJkPbztvtjgnBinvZcXYTtcGfk6ZNjiB477y4eIQUQbE331aH6uRj1XDkgfQOb3dQ9hm80PSt895ah9taFV39bqgFyCYIMYKRuk+e9mxR3wquhb6QiS4s1wewSOQOwHFpt2UERmeNioKFy44Czo9KQcP/QLhw+z7LgF7pq6nA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(7416002)(4326008)(8676002)(8936002)(5660300002)(2906002)(86362001)(36756003)(41300700001)(38100700002)(6506007)(83380400001)(6666004)(52116002)(6512007)(6486002)(107886003)(316002)(478600001)(1076003)(26005)(921005)(110136005)(38350700005)(66476007)(2616005)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TdHSSxkHxMNJr/kQEBhZL5/r02/l0KTt7Xtv0guRMyGaYBvEhJSv7xUDtbJp?=
 =?us-ascii?Q?lMwYUNYyUKHZUEK+4sluBapXAKE5DiKk06h2drfXLAvheXUUJqYNG74twBya?=
 =?us-ascii?Q?pol7v9A5LfwWtTtNqCB21gXUQBxfqnVZustVzR0wNHRdSAGB1hUVLOKSwixj?=
 =?us-ascii?Q?nENNyCknfI6mjQGxJ9MtGJdRbp/d9Qz2K4sXQo0Em/AFFFD2L0q5TGcTY0cY?=
 =?us-ascii?Q?YVWcxlwVvrtWGLuRtbEU+an5Xc/IB6kcReV4rRq4q001gum8YLQnG1o1yA9+?=
 =?us-ascii?Q?emTFUGT+8cY7y4l8k8C/rd5kJH1sc03WZ9WgKb2gAqZY68Z7cdsH0aucogLH?=
 =?us-ascii?Q?koX3TF1epEG5GdBGqZI1qlTAUEuajIx19Yz/VCGNAmAp6rDMIL4fAR6EE6EL?=
 =?us-ascii?Q?UcN2xIZ8xkvRFAQzijyuCZlb8iXhn2Q5LoTEteiGNvQB+Rxi4Kyh6UiqWf56?=
 =?us-ascii?Q?ZKcnXcE8HX3+qnSKDJPI45mhUeh+//itmJDUQxAWKJbmCAbmkWa6wHjtwjbH?=
 =?us-ascii?Q?c/r7EvbuqJDkJxdxR2A9GUirGZmxQ2X9QALthRYyLvBrr2mXc+ozq2jae83J?=
 =?us-ascii?Q?sgpEHrsNQ1fdSXhuxEoi9ebUw1UPyLiqusJYuEV8LZGwnDh9C0OUJUmL+1+K?=
 =?us-ascii?Q?/nmjt+K3C6YV3IXmQOv9cq3lByyhDDPD3ljfkZXGiJ7jLha/6JwrbaDmZGdH?=
 =?us-ascii?Q?GE00ejYCACQP3L2/eWm+l0QyP3UCRtQO0On4L2GAvB/gdfo5s8re6OJddDAR?=
 =?us-ascii?Q?Rj5xraVxjXQGD4MThMVju5RpkKJGDTocIH/Ew4q1JzwUo/CZYs/22/QB6x9I?=
 =?us-ascii?Q?u7GLrT4OwS+BR6DFR9iGjx8q1U4HI+/pjnOGBUMgcVz0t1ApIeIX6HS/ZJZm?=
 =?us-ascii?Q?ttF4TZcOFe3sjcMcaQNaKr86+vdq9Vsmf+cyX3WhftspZCJtFp3yod7qgy35?=
 =?us-ascii?Q?o2cCN88jcZVaUiX7F2XcJYC2nljFppkd6FdzIbutcYRU0VuqJODdV1xXRx1Z?=
 =?us-ascii?Q?RMOlCdWedMDS8c7vydW8SZDcwsitHnj2wnIehIerdXrdaoH652MUIpByyNQZ?=
 =?us-ascii?Q?jc7jhhdZEyeiYXW1JK+njHrhUd9HWK/4i0HeGCOQCxzQmEQf4PypBewb6t7m?=
 =?us-ascii?Q?Rsr6pg9ONiFk3ZlXp+903XugciYbZq6ZlWHp/oeTg3AE5mqP5TF9Z7h9hx8R?=
 =?us-ascii?Q?Cb7GATVuKwKP+05Rk78XX89DBDsyOvnBEdWSVjJ8eIsECvBBXKUsPG9uAy5A?=
 =?us-ascii?Q?ZZdvjLRWevJp9XKpueGt4l0L50w5EaNaBPZfwJdSbI/ecTVnB4jTKQUaxVkB?=
 =?us-ascii?Q?Ota86fCFWwK+GfMUCZJUeu9Agv8frzHz8ROyarJjUtlr1rqN1RdQb+hDbslW?=
 =?us-ascii?Q?XHuDd/93FGqVM5njihyzP5d4jn1Up4SKD5RmzoHNpK9TUS2KFwk4yK77+8so?=
 =?us-ascii?Q?qbZoGk3jAq9KNVkriluvCyPbJReTzAo42hOv/+0sCjMHa3KbnWZ1bwnzmEp1?=
 =?us-ascii?Q?tVezbWcT5fp/jcNlADCMcQhZHuOuHrGiOIth4gUmenrahiRozAW9N8ezaha2?=
 =?us-ascii?Q?HoOtNScDrDEh1N5hwc7rNBqziWOtrBtJR6u4sysL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bee04ef-c9e2-4559-d701-08dbcfb34e78
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:22:02.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/VOtR9oXkT+G4/qSHOzkBvjHozfJmpIXojLB3fT2UVNgTUjzao2ujf/7vYGkiULOU1MmkYA919eAS5GH9WU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch add two reclaim stat:
nr_promote: nr_pages shrink before promote by folio_update_gen.
nr_demote: nr_pages NUMA demotion passed.

And then, use correct nr_scanned which evict_folios passed into
trace_mm_vmscan_lru_shrink_inactive.

Mistake info like this:
```
kswapd0-89    [000]    64.887613: mm_vmscan_lru_shrink_inactive:
nid=0 nr_scanned=64 nr_reclaimed=0 nr_dirty=0 nr_writeback=0
nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0
nr_ref_keep=0 nr_unmap_fail=0 priority=4
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
```
Correct info like this:
```
 <...>-9041  [006]    43.738481: mm_vmscan_lru_shrink_inactive:
 nid=0 nr_scanned=13 nr_reclaimed=0 nr_dirty=0 nr_writeback=0
 nr_congested=0 nr_immediate=0 nr_activate_anon=9 nr_activate_file=0
 nr_ref_keep=0 nr_unmap_fail=0 nr_promote=4 nr_demote=0 priority=12
 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
```

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/vmstat.h        |  2 ++
 include/trace/events/vmscan.h |  8 +++++++-
 mm/vmscan.c                   | 26 +++++++++++++++++++++-----
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..ac2dd9168780 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -32,6 +32,8 @@ struct reclaim_stat {
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
 	unsigned nr_lazyfree_fail;
+	unsigned nr_promote;
+	unsigned nr_demote;
 };
 
 enum writeback_stat_item {
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 1a488c30afa5..9b403824a293 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -366,6 +366,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned int, nr_activate1)
 		__field(unsigned long, nr_ref_keep)
 		__field(unsigned long, nr_unmap_fail)
+		__field(unsigned long, nr_promote)
+		__field(unsigned long, nr_demote)
 		__field(int, priority)
 		__field(int, reclaim_flags)
 	),
@@ -382,17 +384,21 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_activate1 = stat->nr_activate[1];
 		__entry->nr_ref_keep = stat->nr_ref_keep;
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
+		__entry->nr_promote = stat->nr_promote;
+		__entry->nr_demote = stat->nr_demote;
 		__entry->priority = priority;
 		__entry->reclaim_flags = trace_reclaim_flags(file);
 	),
 
-	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d"
+	" nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld nr_promote=%ld nr_demote=%ld priority=%d flags=%s",
 		__entry->nid,
 		__entry->nr_scanned, __entry->nr_reclaimed,
 		__entry->nr_dirty, __entry->nr_writeback,
 		__entry->nr_congested, __entry->nr_immediate,
 		__entry->nr_activate0, __entry->nr_activate1,
 		__entry->nr_ref_keep, __entry->nr_unmap_fail,
+		__entry->nr_promote, __entry->nr_demote,
 		__entry->priority,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2cc0cb41fb32..21099b9f21e0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1063,8 +1063,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 		/* folio_update_gen() tried to promote this page? */
 		if (lru_gen_enabled() && !ignore_references &&
-		    folio_mapped(folio) && folio_test_referenced(folio))
+		    folio_mapped(folio) && folio_test_referenced(folio)) {
+			stat->nr_promote += nr_pages;
 			goto keep_locked;
+		}
 
 		/*
 		 * The number of dirty pages determines if a node is marked
@@ -1193,6 +1195,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		    (thp_migration_supported() || !folio_test_large(folio))) {
 			list_add(&folio->lru, &demote_folios);
 			folio_unlock(folio);
+			stat->nr_demote += nr_pages;
 			continue;
 		}
 
@@ -4495,6 +4498,8 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	int type;
 	int scanned;
 	int reclaimed;
+	unsigned long nr_taken = sc->nr_scanned;
+	unsigned int total_reclaimed = 0;
 	LIST_HEAD(list);
 	LIST_HEAD(clean);
 	struct folio *folio;
@@ -4521,10 +4526,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		return scanned;
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
-	sc->nr_reclaimed += reclaimed;
-	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
-			scanned, reclaimed, &stat, sc->priority,
-			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
+	total_reclaimed += reclaimed;
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
 		if (!folio_evictable(folio)) {
@@ -4582,6 +4584,20 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		goto retry;
 	}
 
+	/**
+	 * MGLRU scan_folios return nr_scanned no only contains
+	 * isolated folios. To get actually touched folios in
+	 * shrink_folios_list, we can record last nr_scanned which
+	 * sc saved, and sc nr_scanned will update for each folios
+	 * which we touched. New count sub last can get right nr_taken
+	 */
+	nr_taken = sc->nr_scanned - nr_taken;
+
+	sc->nr_reclaimed += total_reclaimed;
+	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id, nr_taken,
+					     total_reclaimed, &stat,
+					     sc->priority, type);
+
 	return scanned;
 }
 
-- 
2.34.1



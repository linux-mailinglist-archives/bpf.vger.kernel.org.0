Return-Path: <bpf+bounces-37696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F099599BA
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052631C20926
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 11:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5874F1C1743;
	Wed, 21 Aug 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CaeEjBIw"
X-Original-To: bpf@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2079.outbound.protection.outlook.com [40.107.255.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8181C1720;
	Wed, 21 Aug 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235321; cv=fail; b=eXLNiY+sYV8vpeblPxhtR8kh2DsEk7PFTDWArh4/5We1W5Y7ZfRsXS+ciQRCduUUK0+qbh9YX6ZgwYGqrRSfVE+3KgRUKp3+2FuU64AwtFGgbVLjHb50ZxUpoQZDgVQF02x8dkGqInTXE6u7NnRb115b1eks9YUnZpl2OrFyNXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235321; c=relaxed/simple;
	bh=iw5m8BfFt6NgnyWUKWaswwzVA2cxA5yvJp3c0N7zjwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AK1TU7OAqHY8CM7E0Ec4DuyQr9svAf7X4XATlXDh6EZnP/Vc8kAbUxjTxxlSR6tn3QX9KJmzrh9rg8FA2twBIZ0/SKGJYea3IrIoQwhcvDmnqFhr0myWezibe7/25yYCAEv9v+q/s5Ne1l4LEsJgLMy5g9ntA1XLUSNv80e60vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CaeEjBIw; arc=fail smtp.client-ip=40.107.255.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsPmJUa6PFHQmbN7y0g1Hlrv0aQewwIybFUAdlyanMyLPXnfBthWe4bgHzTHVbOWrE3PLOudfTZhcnSHfwWxq3szZHxVijgJeOjDmGZ4loTtQCSCnnRMASRXd55ZR97i3Anq+oEVz7d+eyF8SFVYPdB7LEJq2mCvqfsWKPBuxSrodoFKoYe3656P/H+YD9kkxlcmCtMsLrM/icQD5lN8kUL9ZxI3IFErEIRVYFZHx9EB7CrsoCajVVb56brjHQFNDZCFhxCSy+t0/Hu2qcn5sMZkbPtU85wpd9s1MuD9aEhOYb+TlxWRFmNroOLMzepomPZ/YGeDltGjXFQ2rhcw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IlZBHXQDC4R0SttgonBfnb39pGFcOqyl4tvCqz8Hc4=;
 b=KLO2884jzNWg1Frn5jkeXRu9HP6hcjhKo2YjSsQSdoZ9BnuHQrE3BCGfV08zmZW3goJZl5nqzOPiC0Vbb/Dp22o8+tie3F+ybvbJ2SSd9SU83jYfFQYrUqysxFTs75PjBfmXeS/Y2AA7rvFOa1AS5U8CU1EUMPWNZkfU3nemhjDvPkJfDEyI9PBuNVXo/WG9iqceF6uXcycTtILBtY/Bc0suSDXnwhU1p6LUlzlDjHMEiagcH38pbGLxa7rsqZO+MEor9mXs32Wla1x/h5GgpwxUSIWia6ewK0gHm5mj/M0raZDTOQ6MF1dvyiaiSOISbHfO7ZhYdbUJnrVEEbxgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IlZBHXQDC4R0SttgonBfnb39pGFcOqyl4tvCqz8Hc4=;
 b=CaeEjBIwXxaheHakekVKG7LsmDrjE3lDEtGstblbQSamOi/vo50D3xky5zomouNOzZIZhAry45bAApNT8Xy0gqm4TME7kr5yZ2Q+zWxKbbHBwEv/sFS9Aa0S5rJqY5MTzFN06XwnLWKYk9Z//eVTSci3YNzACuExm+OXbPP4X3K2PfJsdub/RjMJAqtT46gV6X+bP/OXCSR9m9fLUEHA9AqpdwfMPn3cXWenFbcSOVoguG9TapLIgO30id7bzbMHeR5yOqSy8mBE5kprOD1wgJdhXk5ZKAapRako/lps4ItR98LTX6dExiYRBZPX2l8NUc4Zoh63voJC3pooEBzA/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SEYPR06MB6432.apcprd06.prod.outlook.com (2603:1096:101:16f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 10:15:16 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 10:15:16 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yang Ruibin <11162571@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] tools:util:Remove the check that map is empty.
Date: Wed, 21 Aug 2024 06:14:56 -0400
Message-Id: <20240821101500.4568-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:404:a6::17) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SEYPR06MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: c1867bea-ebea-47bc-3992-08dcc1ca2739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCc3NvRUx95X2coGyAVhtl4khPg3FAOA1Npo0btZtPifrvCIgvLAxFPPbLzv?=
 =?us-ascii?Q?A1W3Pb1xz+2B4NXBdfKLcCi2c1ITQLdltCqLoUjyCGsvR4VvqPQs0oPFMlUm?=
 =?us-ascii?Q?MqbzZ4pGMaDZrPoar5c//8kZruNec+t1coDvT3rQCk+++hH4Bgxy5OXuJmwX?=
 =?us-ascii?Q?oH/zjpo9ih0hIKQnV678UMjDH8ZrYVZLr5kf14Jx0WqpsnWcX/nOK7BlzPmn?=
 =?us-ascii?Q?ngRHbbG5tPx20ijSq4EA3g9wQwJXGbdUQ1paGDTjggCPuiaE+C5pIBVOjFr6?=
 =?us-ascii?Q?bEs3WlRXr/dmISHUxOy+OjcuSScKCnyV+X8cg1Y6S0h+J8P8VT/f4YakoFdl?=
 =?us-ascii?Q?ob+pRglB6uARtobd2DHkdYvb+u8LqTLdwK+/hgJHDjqDajY93S1tDZTRYIiR?=
 =?us-ascii?Q?ugVb1WNpmNXbAceG6LzpNqTS5HsKQ5TnbaW/xhphN8OMQi1Lj0B9sIe5cLzx?=
 =?us-ascii?Q?8tYjjc5nizOWDbLa/rLWzEI6JE6gqAbb6gAk/Ba6nJ0IwtBg3ELvwddq319K?=
 =?us-ascii?Q?c5TEdqMxKxyEPx//iDAYiQvs2PJ/3orvZfL6W7AS6fnYYws7JGlVCIbM9wU2?=
 =?us-ascii?Q?OPbwuVnwgb1uDGDxVjB5r+jjFreubaZHcHpFEC2swZgReo/oaajaAPd5xGQM?=
 =?us-ascii?Q?v/+4/WtGKS+MIxONievDdQhpNdA64QqgsEJg4KTr/hr8G3gHtRusj8HywAnP?=
 =?us-ascii?Q?RcjYL7BM4R9BgMYJle1tasp1xcIhrfuTyq1o92xTlDPj8BSd3gRnVj5kv8/+?=
 =?us-ascii?Q?9wZmrU+VRPiriEpH2iWF7CwHneRw+Ee9P/8/Wk+cuVd34Qyf2XLDKGV9xBdB?=
 =?us-ascii?Q?8PHSMHoT0YMWfmyXjJJFPlRsop9fJgbPguhUgWTbDoTKkVM/EQrC23Rw520Z?=
 =?us-ascii?Q?cKMRXD223dDR/StrNWnkCUpnI0qd0YDzBmY2VCehmu6N4u20Yy8+DrLex3Bp?=
 =?us-ascii?Q?EaeCvuCn+6sJP5gZhCR8hLANs60FLPZiTcAh3zdpJnvWSJmUEZllTeTEOKqk?=
 =?us-ascii?Q?N1qm3M8INQwmUSVcGvy1Mg8wUaxxIsib3rzzLMUjLWkLP732pq2YwkTVFFsL?=
 =?us-ascii?Q?thwRmP1Sx03vB6a08UUOzLivlSyppIxuVuOMQsNHmnbsIR30WKH3MV2DCjO9?=
 =?us-ascii?Q?CVeLwYBzqz529mQbvsIhbr8diG4tOM9qFkcgeTFX6KMwTCt8vW8y0CKBU1zF?=
 =?us-ascii?Q?fssZD5PntgG8TKcPVtyYDTsmgNLvh/7nfSDC9ce+JAZE+hdujksA04lBq1o7?=
 =?us-ascii?Q?Q7ZfRVHGvy9vtNglkXStawMthLi9mcxUSPMkly3VSWlGzeixtCzIq1sMgLgx?=
 =?us-ascii?Q?CYQbE7N8KFgeRkv6hMxDQMcwEq50gYtmeHGw8ZfKeyg21PrYukvssyV2cfoG?=
 =?us-ascii?Q?jfkLZrGEO+AupzJEFbkcWjlq4dCb3LLIfzSONE17wXEwaUiOxqQJiq9lAGAM?=
 =?us-ascii?Q?559PZpoHVwCa17iQFh1QHq7vVxxnoZ4b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fh3UEwUKUx/X9Nqi4pJZ0D4o8OpMDWSwRbbXt5ZugUiAnYotaqLjvU4KUEJ8?=
 =?us-ascii?Q?fJ4JXPlAf8hL+9GIAqmngf63WLVNzBQTYy0t1dGrsbo3t/zCo5JEh1Avd9z3?=
 =?us-ascii?Q?yTvVNSr6seJMgzOKw947hr6tMaZ9pvIBfhrFUopz8OwddRHEpbsv651ja6nV?=
 =?us-ascii?Q?HVU++fEMSkDJ+ynDzPy7um6q6z/blGvDrCvh/WGwgrMpBLw5u4rdS6M5wsrA?=
 =?us-ascii?Q?Ecj2xlaa/y5EiuKPrcLDGAFio7bxBGaGbAPTttPO3uBa+BOo06d9DlHHT7kG?=
 =?us-ascii?Q?RiryMEHYMfHOGEP27GVOgA+3FJdEw5t1BE5Q8wqMLlTw53ukAbx9k3emyuwy?=
 =?us-ascii?Q?a0TnEnijVi1xZRinOLQivqejYyMEUc6/8hjTqIMmZXpANuMpZGATh21IqB51?=
 =?us-ascii?Q?slT6XRYRmjV6dN7WdD7/b/Jt2uliDmuGCzra0NrWfA0DstOtu6EARfV+1hUX?=
 =?us-ascii?Q?gHKSGu9b77ahjLW9YnF/QWCZh+hnjh722Ok8/EPAS2CjxxWifmYh4aTNdU1/?=
 =?us-ascii?Q?MRQYeCQXmL8GuDp29MH5uVp3qlAz3Iu3ou/03SCazaBJYwSDWIHURf3B3rfI?=
 =?us-ascii?Q?7I+XeU3N4K/cjkkeZnjXu+i/zIDikSNUvq6vdHapEukg3UdC6SMEtx8iJZln?=
 =?us-ascii?Q?4gJ6DA8JvTxwORuGsB2EsAQKnw4VA1TSCQvlnjbfc2h+7xwFi+bgFiupvWBu?=
 =?us-ascii?Q?V2YaBxDE40rdTIntSqwThMQ3eQYklh8O0wWmLQ9joT67b7OlzCmix86Cyh9i?=
 =?us-ascii?Q?zFupLQ3Qa51sFZEGgmxJanVagR9X4hftuXa33QdDaRO7YABqp0sqw0JAMYHy?=
 =?us-ascii?Q?WmYF7jo0fKn++H1cp/epTdnp0+/pZiH12rf0NysMqcHnFkO1RLk2hZkZ2fyG?=
 =?us-ascii?Q?U2NAwZZMUnpw9D4pychXXUYlFe24Dj547xB/u/zdLzFvIUhgZ1r5dvHpGxyi?=
 =?us-ascii?Q?cHJZvAllLq4b+cZADTFnmuJR4sVr5FGSJi5+u2fgOTVJhqb8diO0fvyLbi4U?=
 =?us-ascii?Q?dqmIm0fWgEfjNyZm9Kfg+GtBa6WcWzX3JokJoudRY/jWGiF6SV0UmzoJVv2g?=
 =?us-ascii?Q?BH3P4ol3hZt9FTZJG5Q5n7pp7qDNSgmQHerFklJLhkJHmVwEMdVNVRvWuVUW?=
 =?us-ascii?Q?h7h5YmJQlRjVn6zC6AZD4M1kFc1cUZvzD4LMeU+vdAA1ERd0sNE7kMcNkM39?=
 =?us-ascii?Q?YjJn1NQvc0JbQLbZu+FiCUMmyiyzoTSLnimuXg1BXCoUSFJ/0lACJvT7VH72?=
 =?us-ascii?Q?NdA3HclhreIC9H4z76xxurUB+ufpghk73WVYoGFupOE57cWX3RR3t+DFcsQA?=
 =?us-ascii?Q?B6aA/kWM9jmCXBRMZFRQ+CrsRrIUnKEmHfkfuWLVCHqOORl80rNbAukINSZM?=
 =?us-ascii?Q?hTLQL9/K6xKTJSh4XdhDrqaAoTRq3kKIV9iks6jSoqXcXQG8uSra8N3KgXU/?=
 =?us-ascii?Q?VB6llbid4v63BfnqalriuevPdQQ8NBiR4O6OWJgsoX0Vq8aMJ5Pk/bjtyhz+?=
 =?us-ascii?Q?oFvuAPZKiagdKUxYhV0JXtZuqWkH/wowfIroziOPABMMSIuF2eTD1GWEXHRB?=
 =?us-ascii?Q?Mn6qdK8Ct3zlVFWPJhIug+UtevDuQU87oXvGeGF8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1867bea-ebea-47bc-3992-08dcc1ca2739
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 10:15:16.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hJ4jz05UzvUX0+LSs5txvGjAD2ijeXTmOB5addCBwqY3u0YCwUrit9A4H+CfOATAHYBcXcM1FM0ELRShUaP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6432

The check that map is empty is already done in the bpf_map__fd (map)
function and returns an err_no, which does not run further checks.
 In addition, even if the check for map is run, the return is a pointer,
 which is not consistent with the err_number returned by bpf_map__fd (map).

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 tools/perf/util/bpf_map.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
index 81a4d5a7ccf7..578f27d2d6b4 100644
--- a/tools/perf/util/bpf_map.c
+++ b/tools/perf/util/bpf_map.c
@@ -35,9 +35,6 @@ int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
 	if (fd < 0)
 		return fd;
 
-	if(!map)
-		return PTR_ERR(map);
-
 	err = -ENOMEM;
 	key = malloc(bpf_map__key_size(map));
 	if (key == NULL)
-- 
2.34.1



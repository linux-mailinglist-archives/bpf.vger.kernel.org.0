Return-Path: <bpf+bounces-11133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED1E7B3B64
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D3386283025
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E842C1C;
	Fri, 29 Sep 2023 20:43:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4001C8EA;
	Fri, 29 Sep 2023 20:43:34 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971C81AE;
	Fri, 29 Sep 2023 13:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxoKmNPpRvlnSW7rJuO2FFROhBC/eQj5919hGzMGhnQSouxT+sn3b98DvKe0zuFNvNMa0Fm0agLb037YrdE8Wb4Ftwfgpeq0oLSSRbeQSYYJH4QDjv3LyW8x2kYPESp+Y9AVTrLb/YkI3UzwQ0bEyPxxvmMNyvX/Op9nOzoPj9N8PgNVdqSBB70T+zYYgwB/i2mDK7JVxaORzr8jZXNi7qmOkvDYIZOHko9kLWqFzYPyBI2RL5VRnFNjxRWUpLypgMAdkdk/bNmZi1AUzPYNVVnnWOVo8RpWfiPboWk3OxVYERPYXZsoCzcotD+n8gyI0yCX9SuQe4b0pyVcNzyOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXFNeo5UWEafj2CY2GwEkJpsUM73DhTAB01Uavi+FFs=;
 b=SfKDarQapz4RH6VRdOpy5adYcKppSukhZ2o5QcnrkDmdfKi4jbnw2yrvE1NtIPubvWf/0neTDH86iH+eD5gBwWQdspW36XQA+8JjwJ+D7ZlGhruApCYvVF2VR5v5S+ZnIVl5blIiRVFlhPW370VcjgaqN3JUyJ6O3CueHc+Xknpq3rhO5+tuGSxI6lNKwc2ynr94CFZiCkaDSl7Kxq44uSh+yzf9ZtYaV/E1yiuGPwVvaFCQuXEhbG5mKpFxVKdbsGdYVbIQmRFwssUEct0ZAKckzFocNOxqYEYqbKKsNry+uM3D+ifShNMeso/jyaLJNYxJu2f42gVjrfhYL1s7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXFNeo5UWEafj2CY2GwEkJpsUM73DhTAB01Uavi+FFs=;
 b=aN8BT7h/2SWY10GFEvp/iTlaYml+n8H+L7XdO5bnO3S6uF4qKmvgITfuQwtU4kTzFwi6s73xK8QAEA1Ej6rnDbBqOMGek2vktWKJf4zIOQ9TsOP5d76O/IqKuzwYng1f4WJiTfh/Kovt3BYJ/nhau++e/FJqfC5+gMdwLQLaYLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DM4PR21MB3178.namprd21.prod.outlook.com (2603:10b6:8:66::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9; Fri, 29 Sep 2023 20:43:28 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::1d4f:5006:aed7:78aa]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::1d4f:5006:aed7:78aa%6]) with mapi id 15.20.6863.016; Fri, 29 Sep 2023
 20:43:28 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	sharmaajay@microsoft.com,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net,v2, 1/3] net: mana: Fix TX CQE error handling
Date: Fri, 29 Sep 2023 13:42:25 -0700
Message-Id: <1696020147-14989-2-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
References: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|DM4PR21MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6ddd9a-4a7e-432d-2538-08dbc12cbc5c
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 ky+aIH9ovTI61fWaAC/99ga6zf9/lFpHnIu/DCch6iYZPwpGMNsJ9mVG++KjfDcrWaOrWHhtkGZ+zjacGLTilZVPHgC0qTjoaRnnpgWREOJA6J8Swm3PnGN8vmwmpAybmqnhlUQPo3sGFoQXZTmFC2j2YbzDi5CNtXwqFakIogyQ6Au5CuJI3l4I4BcAIeWr02gs4qNTIITBjte+qZ8joFgKZB3a2c2k3bgdu4Z0mF/dsmwZRrm2NQcPbF315jM3cWeh4QSvu0WCdWIMQ1X0clUwpIFMbtgDNqvvfXUsml9aRuJTTSRIhp1stNWfpV4+9B1wdJQ1R80y2TDgvMje7aGx9WoF74RmhRmDCKxl60EC1JP47YeNLnagLV1Tv9Zgx7JbS1DTovNAYRXAELj9n/lSlWNSC219j3WPDBO0o+47y77yi+YGeQeUPkdBiWW8qlZVC2UxjsyH8sFAV3kdBqDtHR8S0/T7eHojsiXlOWVyd1W4gv/aoiPDtRMX2lse+sxk1fSMf2QXjES5OCl+ZoQhP5/ejUFz9kp23DgrEi0Xih2CTMQnX1d6XIHae7wokWh41wY1d9SR58gtZdRDAs9yHn4/RV2XOztLDV5Yv0eJ3Lj2byeBvlP2x5HIM/rZFtVog38np4RYiYwAp4Cj2qw58Hu3DxudOApFSuo2SiY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(7416002)(2906002)(6486002)(10290500003)(41300700001)(8676002)(66556008)(66946007)(8936002)(5660300002)(4326008)(66476007)(6666004)(478600001)(6512007)(7846003)(6506007)(52116002)(26005)(2616005)(316002)(83380400001)(38100700002)(36756003)(82960400001)(82950400001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?aP9P2sunhKLjtjERB5cKXaO4KdYqGcKRlWBwj8L4gB3DiYctQ+WmgzTAVB3S?=
 =?us-ascii?Q?4LKuKQlUviDTP+kDPBy7PfVr5niW30LvTjDN03MQ+APdniTWAmlbHiYsRKHT?=
 =?us-ascii?Q?rqDp/H+le8C1NwuWcE/VCWX5kmckrCZ03LbAZT7ShYX5aIf7CUjqLdwwREv/?=
 =?us-ascii?Q?hGVnAkomFvMox8HKkyBZmkcSm/K1nrv7cAF6bFbxlJWskqtKA+FGsFfn10HH?=
 =?us-ascii?Q?1ObiZgU60h3Aujpeo8dVcPa7Dko9zcRu7AdvCq8vQWsIOZjbuqzV81kzHAsd?=
 =?us-ascii?Q?aY3QoFXgMEvlKuYf2qa4yZI9p++FGCbaE35swhTwvx79P6tMRb8X1aWM38mt?=
 =?us-ascii?Q?rbbhBWFjxL7A8DCXsoHueSqtrjHIc6ObEhPnRpzqK6BNQjpTRhW7CupSUrW4?=
 =?us-ascii?Q?JzR0BVBRTpFg5eSGNIXPO5Gbx4U5pe61UttSPbKV3Sk9v0kfar72ITL0jQlf?=
 =?us-ascii?Q?7IleLo/R4wRnmf2PWhfyyFB+IJB66G5NQY3WjFCIOVoVrEXczVD9h2Cy+7fF?=
 =?us-ascii?Q?t11K6I0DM4kQbjKEAJeJeIYT3LJRSCztdbiNCJOd3yZKUTEUAx/qEsf9LjPA?=
 =?us-ascii?Q?DGAQbOz+IUGpucl4Ogj6PtEVSdbdbsRK8WQlpUM34GTui8GZl9a2h2mMd1Sf?=
 =?us-ascii?Q?2mPZD0ltZTCAKCf9oq8uTjhgUyNlOl/L3t4AUy6540MJvw4VU6TSzrT4gslD?=
 =?us-ascii?Q?MV2YKIUJcwndKmBm8ltS+KbHfxrfNIVUNKJ/uIVpB7ORuWtGscxjRJQFwwlB?=
 =?us-ascii?Q?XSJ7VegmUVtkZPmWpEMbAzf/nVa+kD+aKTSNDhnsSXobv3axHlyOwvlgj3zI?=
 =?us-ascii?Q?QPRsg5dXf95Tw9nva/8O1ub4ZG7ye9hZBij91SmKVJS3jn9H3Ey5cJKwSNhJ?=
 =?us-ascii?Q?CzibsZWpR3kAIgI5e8eOTn+XMAUu1zLmq7RVl1x+RH+D/U49lBVgZN1nYwWA?=
 =?us-ascii?Q?gyxPLe3jdv1xUCkDtjAu1nGMz3hlXtNhR7FAhdCSjsQaiqsUhbpAEEzYChSt?=
 =?us-ascii?Q?s10C2D68B0e3nrI83vG0ji/o6irp82+1UsdwwCI4w/S6I5pPzNGqCN3yn4XT?=
 =?us-ascii?Q?is+9SuGT1eGHE7FMdOvKXfn5xoAKpIswVf6Ow4NwAsoWk61nr1yZzVPaCaV8?=
 =?us-ascii?Q?+riMUHXIDs3gAqWly2K8Cts9xLshTnKmkjFphQJQlfO9DWzj40YC6e5KV3fa?=
 =?us-ascii?Q?m97e9R7wbiYSwOxQKO5s+xm5jXCG/vMzsbffouB6PMxmf06GBIlpIKrnyiUI?=
 =?us-ascii?Q?V/eksz+bMMk3y5XcPU0/QeuDJaC8+DL//QPSc93HfGPx59lTiQ50hBWPzO/G?=
 =?us-ascii?Q?94V7q/coZGwbuY++eOL9ADyvKOPJDMqHfQPhIo1FPSvI/xx7Kyk9gaZMG/L9?=
 =?us-ascii?Q?IKa2ap4XqVaeqDNriEyLmR/3wLdVTjPtGQzMsdAKSRw2ETS25kER0N/wTgS2?=
 =?us-ascii?Q?kfk2uCl41FywyH3lUVB7/4bdCnqSgGoTcWEy7dL3p/03i6mVi6MDeImYrfQG?=
 =?us-ascii?Q?uPgp6aCq8azd9zIZzkzCd+ZIhpsfTrL2bmnJIOr2UP6oPuExIYBpTF/TYbjS?=
 =?us-ascii?Q?g4vou4F+n8jRvUSJlLWLbjPIJfpBxE0TBbAJ4z/x?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6ddd9a-4a7e-432d-2538-08dbc12cbc5c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:43:28.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRCpiBE8wU+d3Qiwl6wRtoYo4uVB6sNfUebSbgYkjJw+yjP64YOvwwS6RvZSQPzkfYfJKxe6t7E+nKO9Ku1j0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3178
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For an unknown TX CQE error type (probably from a newer hardware),
still free the SKB, update the queue tail, etc., otherwise the
accounting will be wrong.

Also, TX errors can be triggered by injecting corrupted packets, so
replace the WARN_ONCE to ratelimited error logging.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4a16ebff3d1d..5cdcf7561b38 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1317,19 +1317,23 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
 		case CQE_TX_VPORT_IDX_OUT_OF_RANGE:
 		case CQE_TX_VPORT_DISABLED:
 		case CQE_TX_VLAN_TAGGING_VIOLATION:
-			WARN_ONCE(1, "TX: CQE error %d: ignored.\n",
-				  cqe_oob->cqe_hdr.cqe_type);
+			if (net_ratelimit())
+				netdev_err(ndev, "TX: CQE error %d\n",
+					   cqe_oob->cqe_hdr.cqe_type);
+
 			apc->eth_stats.tx_cqe_err++;
 			break;
 
 		default:
-			/* If the CQE type is unexpected, log an error, assert,
-			 * and go through the error path.
+			/* If the CQE type is unknown, log an error,
+			 * and still free the SKB, update tail, etc.
 			 */
-			WARN_ONCE(1, "TX: Unexpected CQE type %d: HW BUG?\n",
-				  cqe_oob->cqe_hdr.cqe_type);
+			if (net_ratelimit())
+				netdev_err(ndev, "TX: unknown CQE type %d\n",
+					   cqe_oob->cqe_hdr.cqe_type);
+
 			apc->eth_stats.tx_cqe_unknown_type++;
-			return;
+			break;
 		}
 
 		if (WARN_ON_ONCE(txq->gdma_txq_id != completions[i].wq_num))
-- 
2.25.1



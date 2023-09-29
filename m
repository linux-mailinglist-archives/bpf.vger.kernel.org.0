Return-Path: <bpf+bounces-11134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07617B3B6A
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 3AAB3B20C3E
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C969516F1;
	Fri, 29 Sep 2023 20:43:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCDCA4D;
	Fri, 29 Sep 2023 20:43:39 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020024.outbound.protection.outlook.com [52.101.56.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE971B9;
	Fri, 29 Sep 2023 13:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIoxStDkUulpjhGQVEDvBRQ3006hOqhO6wNfJBh5GqFjOjS4h0hVX4giCliGHolE96a0xKwOkapCHald8u3boH/pQGOhI96MxDetvt05/OzCO3zsxjOB4zNBrRs54DaW/J4kdpRNv9SKXphgQcn8AbX0zvhi346k1CuTAo1WHv09UYA8F7+0KP61amO3V+IYItw12OccH4myySO0VMzlCj7Qu2sXDtfiL0bWMlt1a81yYyR53VnMV6tnFba+hTQlXpcCYwbdMGnd+ZVOL+puDNmEXYaqoO5sb5dubbf57vq3pPEw8Kby2CPWS5mKOAClL8aAFhL8Gew6GIrmvZc8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO61FgGwPpmJ4QfoMvSiX7Vk3sqhPzpyEaU/2v0N10U=;
 b=JCrXyjiYhOXHpyPev7kW0H+dutr7eYq2nJCWpkD35huVOE5OVkrnlk6yKtuvEj+PcYQmzLbik7F6iOIuat6WdRwBuRXOifhuxRApaESgcKExjGOwBWXq5/mNiZYNPafE7Eviv2e44J+OA9Lm+Nv0kkUUtNso61nFpWjogaKNExvAio23onYJN3BhUmmUQ9aWduvkHrj4t2Ls8sahL/wWuZn/YUt+18fapOqDLBFnaUI8GMJImY+TWGs2neeLm66O3smKvS8N2+LpxIUcggdIKzGTm37g48PLFqNvAB6tkJuei2XLHqwshd9il7HwalujQjQJw2wPj+Et0PkSV0/eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO61FgGwPpmJ4QfoMvSiX7Vk3sqhPzpyEaU/2v0N10U=;
 b=A3HjZ7xSeRpKHuiA9ViEKEYMUU7veYH3OMqbGAMEnPETMJAmE0KMNSlWVl9xwlyF7KwKzEOtUX7l3L92/ZVOnrz2tYgzw/Tvum+Tfc9f0RyC0YwCMEPR9JIigXzhFNM5gE5DpgTqmXVoyMYeIaGOFP6xA5jNUmtzS6wJSP3j70g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DM4PR21MB3178.namprd21.prod.outlook.com (2603:10b6:8:66::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9; Fri, 29 Sep 2023 20:43:35 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::1d4f:5006:aed7:78aa]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::1d4f:5006:aed7:78aa%6]) with mapi id 15.20.6863.016; Fri, 29 Sep 2023
 20:43:35 +0000
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
Subject: [PATCH net,v2, 2/3] net: mana: Fix the tso_bytes calculation
Date: Fri, 29 Sep 2023 13:42:26 -0700
Message-Id: <1696020147-14989-3-git-send-email-haiyangz@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 252a30d5-8eee-4757-8365-08dbc12cc032
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 RmtjItMvE5UYEoSnI8w8GU8H7WVOFLdbw7buUhSa2jvkQGNKUzVZD/MY+ihr5QN7uQuvBPudy9K6RoUKDpCruzHm+TXqvsz9Kny41P5k+3nZ/YFMouzF0b0EGUP1OinesaGlMxReSut60R0EZY3qxeg2xSjfJqW2zLaEsqu9/oxDFHgokGxc7JGVyliE2z3JFwEelmTs8CCZErlK+476BxVcyfsWWsWkT1ACONrTi3EKMlpATHr30z7PHehz6eh2kIgzPDaxAID9BDBuCo38DVrbUM+UIMG800CtAbY3XbyZ2vKf9Tp+Cjakxi6I9QdXwYd/O8oP1lV9FGcs5NCErsQQC0GrfJANAEIHJaL0VV++5w/Ewu+G562ViRhnGaZlPh9h4zylt3A2hcOc2kebTVJcMGokXVZx95xZJASPcoaX2RnGY26nw6I/gUWu8dXIgRr8ZllSZupNxIkOsWFr0DSt5jbvY4TKP5lId0m4JkvitmK4yej7dxGPRwuYV7xhEXASdbrfBehHeXjZeRgHaxnyP3VwDvkBwSZV2pWnNsyF2cfo3IcKirMkR5Y6BBBRvjfoGGoLqQnp/ygy5BMXukNwrWwgPBFWIuc60tKep0IXd+aKI2FttXGYDOiwowTFbz5h64rijB+6F26hNxyUSI0uJhekWvzfTz8RtbGCNhM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(7416002)(4744005)(2906002)(6486002)(10290500003)(41300700001)(8676002)(66556008)(66946007)(8936002)(5660300002)(4326008)(66476007)(6666004)(478600001)(6512007)(7846003)(6506007)(52116002)(26005)(2616005)(316002)(83380400001)(38100700002)(36756003)(82960400001)(82950400001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?sls80MKSXIytK138hjVf9dyNBUpCkn4x7O9fOFItU9sGfhd0OddknLXjnosH?=
 =?us-ascii?Q?oLdxMUtVtZSRGTSofqeaRnFptJynHr7Vpx/b60pDkX+TWCk1YP9rwJVLXavN?=
 =?us-ascii?Q?yovkjfBt/ARDanuvPw5A2AD6dHWjVzfjOJTD/e4Ak8B1y6pX8b3DzA19Am0n?=
 =?us-ascii?Q?pEWmKus8qy8QZ2v8Wb6zVCWcZVSV/SDMDrSyyMxNmjo3Q+2Jai+j3fQK5pX5?=
 =?us-ascii?Q?H02qx2IBhljo+oGqzMhFaqir+d6Tu8rBz5ySW7LokBb15HHTPfed4YB5SGLn?=
 =?us-ascii?Q?0EDV2tY4zGI00+h/pPALiic3+vlrh/Kula+d1O2E2W4M5UhPiIB/ZOCsjIEH?=
 =?us-ascii?Q?LM75XzUNkFVBQ+EZZkMwWCyOBJXMM+5bB/xlDtImCVI2aDMcACenkv6/Y+WJ?=
 =?us-ascii?Q?YsqSAVr39yCDE7pVaPhVIm7SyMkAq0ovvYuPtDwXVt7e7mV4JpBXm1lZ2N1v?=
 =?us-ascii?Q?wT9Wa46bnaZiDTyjXSEf2apwIIJFTTOrsItnAG3Wir8r/m3D1MKo/EGAWuuE?=
 =?us-ascii?Q?iKFYMSI2W85kxKO1zUf5TwrPDoW0nVwm0GX74z+a3aq6gxY1cey02uRV0H/m?=
 =?us-ascii?Q?F+umclXc4cpTBsH9QUjr/iez7LtjbPsTBtSLuEURyVoaStUhzJ136RCBWCUj?=
 =?us-ascii?Q?3wUSy7uHFQGQRdhhE7jV8Bicyr84DK45HHIUBJX7JbR8BoVB/UCe+3Vz0VZW?=
 =?us-ascii?Q?FjHZwenIfCBKxjXGxIvMUZ8ozBvHjUyMHu9DKgEhdzI5hs31W3UBMtkOzlo7?=
 =?us-ascii?Q?5R9jX+FlBn45KmiF44zMTT4jzbvUaYiRMtAOjL+VjpjRrEl2hBGBC5Y+jK1s?=
 =?us-ascii?Q?FdhJUXkNOJzCwFMxczAUSmv5U16f4jlI0/qdNWPXpfAVEGU4wj0ynbFS+s8a?=
 =?us-ascii?Q?JLsE/EcuYHySOMEyzXF3H0pOQsUHTqKV5JuMFds2JuZPBPzMwO0ZN65kFNPZ?=
 =?us-ascii?Q?Jg2U1+eyRmD0bGhNK0gwIB72V8zDOBRzE3v/ZHHcKKslxJtjys7BA890EoeX?=
 =?us-ascii?Q?qkb7r6ZTniQPQe+xbHnnhRW3U/EzKCPiOmF/wnkrh8tvz/ZqPLS9cAJ0ktzy?=
 =?us-ascii?Q?gcwV3cO77nGaH4mYAb6tvRzxChiW2DUV4Jn6nXzFa33zXhGgwiFut1EBDkGh?=
 =?us-ascii?Q?G1g02EX5oPJtFJK++wZCLaJEP4uunxP/DoiPW6gm5AGEDDOMB1+a69QMQa3E?=
 =?us-ascii?Q?Hw3rWUspTkIm5WU4cG1QCObDVgViVlRGZxiDmFhIRnidniMB8/3h6doC5p8j?=
 =?us-ascii?Q?JyA+mLNnMB9xFdxEacLC5Y5CQQXdIZn04R4FR+Q72xKp/rSTLlCqXAjXZram?=
 =?us-ascii?Q?LVQ3iXaF71wi/V1cJbY6oCP32YmgTRsOT95zCPIM3LdRjI0PI3AX11w4uevZ?=
 =?us-ascii?Q?9p9l4qJ4CMQsjxkzPHYQw2tYO7Mf33hyHO267ItnF1IJoMOReCNAtHbe+cAZ?=
 =?us-ascii?Q?CWqnlPUUQAdBqyYR2RJ/JFsAMnCFhhmvAmJmZ27QLk8FrNLq95IlswInVyCw?=
 =?us-ascii?Q?fUdhGfwP/DH12h9l7FjrFNn2sWak/BGJZcuwyXsTXaZzZdnHAIcK9t8HyE4S?=
 =?us-ascii?Q?vNR87+Ukxp402uHYtmx5eCJiYbLSbWh9JIIchT0v?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252a30d5-8eee-4757-8365-08dbc12cc032
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:43:35.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJT2jyGPcXLfN0C4s1Fo0WzWPaUZh4/5nD/lzx2iYYboSdxSZFF0Ed8T4yPfGBtaevur5T1ctYSKjMujJkJugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3178
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sizeof(struct hop_jumbo_hdr) is not part of tso_bytes, so remove
the subtraction from header size.

Cc: stable@vger.kernel.org
Fixes: bd7fc6e1957c ("net: mana: Add new MANA VF performance counters for easier troubleshooting")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 5cdcf7561b38..86e724c3eb89 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -264,8 +264,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
 			} else {
 				ihs = skb_tcp_all_headers(skb);
-				if (ipv6_has_hopopt_jumbo(skb))
-					ihs -= sizeof(struct hop_jumbo_hdr);
 			}
 
 			u64_stats_update_begin(&tx_stats->syncp);
-- 
2.25.1



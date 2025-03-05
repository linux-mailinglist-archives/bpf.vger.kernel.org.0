Return-Path: <bpf+bounces-53410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7488A50E1A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEC01657AA
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1AC262D08;
	Wed,  5 Mar 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OmXVVSqB"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020127.outbound.protection.outlook.com [52.101.61.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AF2580DF;
	Wed,  5 Mar 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211254; cv=fail; b=L6sqlzfMNvofg8IIzfiLj3vpCMUJUx3h8flXF1fyzG5smwB2nenvgY1/GrBPcFh1CHKzS4yaoXuvNXuHDgMluaKVWsUQvoLo58L4w1xdDlTgSn9rgPicQ0kayFn/kyLEius0aRfx+3IhUbCupIPOqCRM3uouPnc1tkGwwkzTKvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211254; c=relaxed/simple;
	bh=OBmX0zfgsf0HO00vqPy3LRlZjkwMD+k5OPwCiMMNCDA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hW3upQLum5bf35ZWN4u2bDOlL98noTOnt1do9d+yVuo5Ib7qE9rjT6FCwuBZTCtZ0j34USEI3uImHBzyFrtN0udbUHtpjtl+rNi/szWuvfrJ9vDuySF+8Qu6RAvr5081/9rdPd8BLD5xi9/LawUAjW77IMidLV+dMJqtHebojjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=OmXVVSqB; arc=fail smtp.client-ip=52.101.61.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClJ9CqBVrbQT1pAZs0N8EGl+ulLwrPenydaqKDtISFWT/WO4tWBV160Zj3sfgTQ7QKx+xl+unhbq42IE4uegn6rYUpaypy6vocIsKvawQauxqynbun5dc47soxSHjW64oVJ+BgWVDd7aR85l/D3bomZVIdr8yz//0cdcEnArNfZSrFqlL47gcC2JgwRZmniQD3n54pJICiPu97MNyyN6y+2LZ8sl6uXeYmWvHQM7Mr7WLiHmUEBKP0Rtn0RdDCBmr3wALX5r/ELraBGTQl4twIvLQt4+TuZ+zpEx5+ytNGYG/8TccIY3KFMxXuNfwDBQh8ncW+glQoF9BAd6QEbSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEF7RmZraXKWGMLEYNzOYeb8Ia/tDYqhsCbPhFU2wTo=;
 b=ntGRnFpJFvM56fGLhrX+nrgs+oC5Gu/MI2bAWyELELpafmy1A4nRYTsnEnewgZOUGj+ZB8LjCNhDMOFNmhL6FCKioT4Opi8kmTULDu8I/B0awwnbZp1rGFfRn3ATnvzn5SckWhLVMMiLYXC9BcWMFG2cKzAsmz9wj/mVGBhYOMleNNfIU8VSlQFYoAxB06rW6POUZIg0xHgmaRdgEdgRrajiHQwUiXq8Ind77e1X//iDGqfrOqp0buaTogRUnupra/aTfWRZB3EWGaxEw7ubh4zWJ81g+g1QA9abGVntlW/4DPYRlsrcYkq+SDoC+C0pjj9OTqqa51E33lqAZ7D+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEF7RmZraXKWGMLEYNzOYeb8Ia/tDYqhsCbPhFU2wTo=;
 b=OmXVVSqBHN1IyNsDri6d93bo2jrGY43vrff3imtmuO3VH62av3SZxZvGAFB9/v9AmS15rFZL1KEtVTVoRjDfbJqN9ECh9Y0VUkrVny2hYfUIFiTYCiIHGtdIhpDmOVg7bNbMlH+JbPwmkOP6pT1cGltIA9KhjGJ6llj0dd7xLq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ1PR21MB3763.namprd21.prod.outlook.com (2603:10b6:a03:452::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.6; Wed, 5 Mar
 2025 21:47:28 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f%6]) with mapi id 15.20.8511.014; Wed, 5 Mar 2025
 21:47:28 +0000
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
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: mana: Support holes in device list reply msg
Date: Wed,  5 Mar 2025 13:46:21 -0800
Message-Id: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ1PR21MB3763:EE_
X-MS-Office365-Filtering-Correlation-Id: 435c058e-e00b-4579-17c4-08dd5c2f52ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sWlyFMNVs6wJVJEAyyBaXoH8gj910UfqOilT0WJFhT/gfk0363GQ3shTp5yg?=
 =?us-ascii?Q?tcWCfRD9JFakDp0514JVgdj9Dch5C2w1aWqQ5YxwrrvDbrmeVIfV7ABlsLzl?=
 =?us-ascii?Q?tDsn7dSgfy/ectRoE2yJftl5PKamQR85Ag4GFlvwdOoldDvQudS7AyDRZckg?=
 =?us-ascii?Q?AUU/3rIDiIo8pq/QRbPnUJah7YDzsEjI5KDQDNkwoNTqeuHLsfmzd/8q85TQ?=
 =?us-ascii?Q?i0OyoM9xufjS0afQKVaHZg33CvIvRpYEqjFSWL7KMfVsC3WILFdRQ3l2NHHW?=
 =?us-ascii?Q?reVulaiQpLEyk0FCZU0bVs5NVhvLkSXt6QY3WoPTLItu8J2hTNEUjbrIR0dL?=
 =?us-ascii?Q?OxiElOAOjSaS2uOx+MJpWxSJpW4QZJ9OZILwDFG/aDIgeRSm3hlVL/m2YtDB?=
 =?us-ascii?Q?Sz1Q988xLOyn7EPnlRxqrZy9IWPFERNzmRETszCj3HBYOGJzdkVjWs0sTGWl?=
 =?us-ascii?Q?qkTuxHOQy5/AeyIXSmI0mWdIMS4HDM6c7vQhHadmJRzD7RnSY7/rK99itjVv?=
 =?us-ascii?Q?KuNi2Oz7+ajbnXKSs8NIYqX2IomQR1k2cmkB3RXZDeSp/f4t6dzCZLLc8j2K?=
 =?us-ascii?Q?sJsJi2COeqLC0sEcEaflOqeyIpVmX/e9SG7Zm5eZcIbW4XEtr01M+7WRHARh?=
 =?us-ascii?Q?Sp+QskTAfkYxoXe8CMMJIGJexTI60f51UpkeGDauneyEbohnsFoFLXRsMsFu?=
 =?us-ascii?Q?y4MmcfcCaKxVz/b7Ua99B/SrtCMYbBckagFoQ+OBudzerxaebhvDwXUBTq09?=
 =?us-ascii?Q?lmvX2+do8JMUfyWyy3pYkC2mIRHTtWDxmtgwklcjLZyC23AJInffgMjmD3eC?=
 =?us-ascii?Q?03/T2c1R3MaJuofbEbEDrUoA7mhxye0VmY4E005aRw9hj1ogCc7UcPcmrwDt?=
 =?us-ascii?Q?nmT6SLSDjQqjg3i1xsd8KiQnHs54MtnsIBYLkK3gC436+O6BN5d1gJoVuqzb?=
 =?us-ascii?Q?EDWd9C9YFKQvPBUgItQAXy/4y/BdQlQWxtuFEnltfyaQo8AYjLM59dMZHIiQ?=
 =?us-ascii?Q?6I+GdafisWloAOBMagSgK7nqDn8VahVye+jsdZyNb1mH/3JiplZPA/4z14DQ?=
 =?us-ascii?Q?bbwRsJ8V5D6PQhIojia7XuM81zZErkKN5EUr/fybqbjGehYIPbcuwwi17ppA?=
 =?us-ascii?Q?ewzKWu0/hIKc7RQZHbKdUZ6IHc486Cu/K5MqT3vhcBxTdAgEmUzWnWEOvlPb?=
 =?us-ascii?Q?wo7e6WhyJ+DFZrnm0TddXHw8mVP83UGcL1ydPW1UD/uqtw6n1HHEF9pEabGZ?=
 =?us-ascii?Q?1JMmylA1HxhQ7OjeoSOfm603KIqLOGEAvEjap6exAelUhO6o5xcOEoaAjEQl?=
 =?us-ascii?Q?Izh0gcYKYiT/iAXQsGMpGxVQ8Huicb8lPEbgmZH+vhyZ+GWcj/KxnyrxfRvQ?=
 =?us-ascii?Q?Npb45TBtL22ZfSqjVSNLyg7OentSv6VsHCJxhtFY9oOntZMTW1MOozlR1wj9?=
 =?us-ascii?Q?+D3CR+c82wWgTGGq0RX5b6haWIav7oS1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GtPQiQxWupReImxXn0ns2o1Yu6hcg7j3mV/pFTdH5P13Kv0d160NCFDbC4Ls?=
 =?us-ascii?Q?htwLMcmpGdyBsCdDA91P42UL6Bs/cqZVLGkpkX+RYvshuuo9PoZ7egbpGMPf?=
 =?us-ascii?Q?ejn9BMnso5U0GhBS3oDyRJuzz8Uvc3ZoJhQamCZX8RVBRijLBa0bK7SddDUB?=
 =?us-ascii?Q?JlG6yUzB1s3XB3xcWCY0M5SLBzTi3shYbfS4svDxZTPNsauYHzzb9ftH6AiT?=
 =?us-ascii?Q?u1jeI6B6pbw+aCens+KBKH6kelEUuELMq1bnmeZVmQVA7OEae0ld7VFJO/Qx?=
 =?us-ascii?Q?2RcIvJMl3/SQxKNQE1V5rvhnUJ4ySNoLFuJFQ/hwUZSPiWLf30tlqzkTA/7j?=
 =?us-ascii?Q?X53AdsZET8TKiRj0QMAAtqxrn93wFw9tLdk2GZlsnZ1XpCCfonzq7x5IDaHC?=
 =?us-ascii?Q?2nEltZcfBW6Zya7faPAsSLcR4c+PEWHWrV4mibYMO6Grc7vh9PAAO0e7uv1R?=
 =?us-ascii?Q?pbOfeltn6xP4wSR623BuCl7exJ1+ulE9fuxvPZXHpspvLXnfvoNdX4ZtOe8r?=
 =?us-ascii?Q?KTGLo14K5AJl2UddGrBxXXaKU9V/qr++UWDbEDSe1bUnyfOyNpTU/lEexPgl?=
 =?us-ascii?Q?+1yNbEHDyW4uipkYJCuF5UOy+t7HFh6PWEBPsiXX+GCzyo+QoJX8scoTMJq5?=
 =?us-ascii?Q?IKxfBYGod20bdMBTlUDDRC5sY0ZxqAeYKR4TtM5Vl+6e5owwe01yUwyi1Mt+?=
 =?us-ascii?Q?DogXe3tQ73r4GXbU/530Qow1X0EJY8g19N7tyG7qjWDnhhXnavcCrFN43hgu?=
 =?us-ascii?Q?fl5qblwc9e+2JCvlLcoNjrxCOCWaEt0UFCAYkAersVJcIaTKucSPx5HCOz0I?=
 =?us-ascii?Q?Kq3M0ziBIRvuzwNV2TfhhWyJfrq10V3OyhDcPcTzQ3JHNyiDEvP0lUILFs0b?=
 =?us-ascii?Q?FdDS4W4QISXb9JvH0CvgTodomNbEQ12O7WqbaHI8by0KHLRssV+VAJZRp5Gv?=
 =?us-ascii?Q?MJuBCgIYw2n9yEuK2SPkOVOiRcOcLMoWu2b2dRBxUmuTa68wm1/4484HgbE0?=
 =?us-ascii?Q?al/5Nw7b3MWMxE3Ng9gvST09t2rVEXU2T/FOn0dqDRcymUcIP29Q/LV6dCqR?=
 =?us-ascii?Q?5p7DIGsea1GegpbCZYKw7qRZYj9J46ylPq83q30PGn6no8N308FBuBlithbJ?=
 =?us-ascii?Q?op8BTF2JKTEbCrvg1h/I7yOwMQ53w+Z7cWAuVzggqMJPIql2u9n/h3UC9Qfr?=
 =?us-ascii?Q?2zEq/r3T3uraEJ46Z8QoQZPo4dZexTSjDK0e/E/1PyAM+y9cdxOZKPh6y+sd?=
 =?us-ascii?Q?jyL7uCPmzyuK3qzJWj2zad1oVUJV2CN06VQTA9jDhKfv/kYYwCKI9XY0ARnj?=
 =?us-ascii?Q?IJXzX+ifv6JOQyeCSZ2xFlpIErKq/syAYoOVo78pf8Xjj4xc7hj0YQEPwyhK?=
 =?us-ascii?Q?UQazs9ztW6Gfl15W263ZsnbZ7+//55SAUezTK6+V5klD46p3AQzFks2xC4B5?=
 =?us-ascii?Q?kY2i5UZ0FpHwOWI6q4hVQT2A9jRmC/4dE6Z491bRkeG3LIRSh6GWsWQmvS0l?=
 =?us-ascii?Q?6gwabsQOLTu2duUXSE+cu7crCY5utmPR/8klBt4SCBzqS1DETvq4cDMlpOO9?=
 =?us-ascii?Q?ywBUvIro5SPBujdmm7DymiGAHU5+LOHVmHB88PUo?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435c058e-e00b-4579-17c4-08dd5c2f52ab
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 21:47:28.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8jcpiuYGCRN0W+eXbfev2jMWTusT9MUIIYVVvYhBEQyk+pX3X+xwg5xFabOZSvA4hweziCxpgVqGdGItaYBsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3763

According to GDMA protocol, holes (zeros) are allowed at the beginning
or middle of the gdma_list_devices_resp message. The existing code
cannot properly handle this, and may miss some devices in the list.

To fix, scan the entire list until the num_of_devs are found, or until
the end of the list.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 16 ++++++++++++----
 include/net/mana/gdma.h                         | 11 +++++++----
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index c15a5ef4674e..df3ab31974b1 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -134,9 +134,10 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 	struct gdma_list_devices_resp resp = {};
 	struct gdma_general_req req = {};
 	struct gdma_dev_id dev;
-	u32 i, max_num_devs;
+	int found_dev = 0;
 	u16 dev_type;
 	int err;
+	u32 i;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_LIST_DEVICES, sizeof(req),
 			     sizeof(resp));
@@ -148,12 +149,19 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 		return err ? err : -EPROTO;
 	}
 
-	max_num_devs = min_t(u32, MAX_NUM_GDMA_DEVICES, resp.num_of_devs);
-
-	for (i = 0; i < max_num_devs; i++) {
+	for (i = 0; i < GDMA_DEV_LIST_SIZE &&
+		found_dev < resp.num_of_devs; i++) {
 		dev = resp.devs[i];
 		dev_type = dev.type;
 
+		/* Skip empty devices */
+		if (dev.as_uint32 == 0)
+			continue;
+
+		found_dev++;
+		dev_info(gc->dev, "Got devidx:%u, type:%u, instance:%u\n", i,
+			 dev.type, dev.instance);
+
 		/* HWC is already detected in mana_hwc_create_channel(). */
 		if (dev_type == GDMA_DEVICE_HWC)
 			continue;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 90f56656b572..62e9d7673862 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -408,8 +408,6 @@ struct gdma_context {
 	struct gdma_dev		mana_ib;
 };
 
-#define MAX_NUM_GDMA_DEVICES	4
-
 static inline bool mana_gd_is_mana(struct gdma_dev *gd)
 {
 	return gd->dev_id.type == GDMA_DEVICE_MANA;
@@ -556,11 +554,15 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
 
+/* Driver can handle holes (zeros) in the device list */
+#define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
-	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT)
+	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
@@ -621,11 +623,12 @@ struct gdma_query_max_resources_resp {
 }; /* HW DATA */
 
 /* GDMA_LIST_DEVICES */
+#define GDMA_DEV_LIST_SIZE 64
 struct gdma_list_devices_resp {
 	struct gdma_resp_hdr hdr;
 	u32 num_of_devs;
 	u32 reserved;
-	struct gdma_dev_id devs[64];
+	struct gdma_dev_id devs[GDMA_DEV_LIST_SIZE];
 }; /* HW DATA */
 
 /* GDMA_REGISTER_DEVICE */
-- 
2.34.1



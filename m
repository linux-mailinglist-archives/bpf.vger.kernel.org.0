Return-Path: <bpf+bounces-37764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBE95A601
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 22:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406B3283F76
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220DC170A2C;
	Wed, 21 Aug 2024 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fiAaY4Em"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020113.outbound.protection.outlook.com [52.101.61.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0B1531DA;
	Wed, 21 Aug 2024 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272986; cv=fail; b=WvYfSOa3+on2vTZXId65l6OUdZK2FjVneaAwlvADK0uJLmQT50Q/tOVXsE4FjXIY2Kn4HFisKlj3WWim3WKkErvTTIF3EO9Xiyr9G1j/QUvyLPfv/i9kvGXB1FX3wf2JDRXWHajtspaK2I0Wik9FoXS4kjXJQ40VHQy5s7IoE78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272986; c=relaxed/simple;
	bh=ani77+uUH/oUOEqU+3n2PC0PL/9eUTfa7CeaGLj8AdE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a/35EyUx8xqCPD1fIMYJ85tl6+SxkXkqd+JPUPb/faQkQbITwxnwht5QC/2CVCBmxGfWABY1yg3ttoVWmdx7teuLEkavINbz3GlUHH/usx9MXN6mkymeXP9D4WD4LjI6t9/FkIoXMb/GYympQSGclsjHLdFr3289nr+kPZ0VbYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fiAaY4Em; arc=fail smtp.client-ip=52.101.61.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAYP5MsNC/S64snWqus5vWzoUNODebxNkl63yT6d5idxS8/aW55m5D6egKYLXJbegwnVFQKspV5gwg0M7Kg60UFb/bBIKqcpztLas04C+aY03rd0gx7qB8iNsQA4dh9xl8kxFOrSVCrCG44igl2c8Qz9WrXM1mrPI4YanStPgUzpqKHwaGzmWM7ebp4k4p8ft1H+PtllzdQpxt+XKrev+fFk5UHfyUWhyDfZoClBU5pPnwVIbrRVSL8oryj+k/aoBQz38rzu/y1i5HX8h3skcM87H28/lnJZCs4ScRL7c3qR5g1rSE0B1772V7Mhtg4M7Ns3u39Iy9ZElzueoM/IXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSiF9QZJl8NPU2bS08M9AjgYrKrmGh3HecugF6V5SZA=;
 b=Ogqtonqe/k5t+bjzfmji8aaCLXdTSQTwo1s8j6c7ZTpSHt7YHQz6ak97rU/ZsRbbHUTkKnQ1RHeaUNn2pu2Q4HEWLrNzhpxmYgaO5CREG4899MaBpoqeNYUb/e3oz4n9Bq87OLOCjmeVu7TadmTxsr+7LiE8rHe4QWWFK1huuVkd/neNXwlxtXb0vOpBhCncgejhpD6P6n+h/4eyDaYJFxuZKh+maxgtTayftT2SCl+rHA2ywDRaxaR8mVzDx+f8Xuh+J8830vUYSp/RQqOrneoVnAOiQAoxeOBql8vBRlBP2wRkX2Ts2XOsaOqm86n/JTrVzftbXomdHmkfn9J3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSiF9QZJl8NPU2bS08M9AjgYrKrmGh3HecugF6V5SZA=;
 b=fiAaY4EmqHsOx0HfJJz1JAV/H3r6bvyb2XuIkHY5V1z0b+HKOtn3NHTz0JTMIsAaqU8r0Ac+hMPeIaNqm6Rj6YZEGxI6LIXhlfVk1+rNKqZpyYyyfuOy7Yq1paQSiFxcSDo1LkhnkHb1ccX1j7Y+YeexNeJOTQQ5F7WxS59CaLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by MN2PR21MB1407.namprd21.prod.outlook.com (2603:10b6:208:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.8; Wed, 21 Aug
 2024 20:43:02 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%4]) with mapi id 15.20.7918.006; Wed, 21 Aug 2024
 20:43:00 +0000
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
	jesse.brandeburg@intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response
Date: Wed, 21 Aug 2024 13:42:29 -0700
Message-Id: <1724272949-2044-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|MN2PR21MB1407:EE_
X-MS-Office365-Filtering-Correlation-Id: 444c7948-088e-4e77-db11-08dcc221d88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQTAUBl/VIrKQBZAhqncQHfnHY3BTJlwWL9F0v0yLmoaJJeLtr0PaCD4Gqe7?=
 =?us-ascii?Q?BXG+VKeB34eJa7kh56uOtxyKZTu2Emu3EmIV1q0fHvSqDk+PpRJHRzNaMJDN?=
 =?us-ascii?Q?BuS/tPvdbHZUJwco8weYKIy+c6Tk+TF0Q479ewuQLWnvHRQuA2wI8rp+GFLz?=
 =?us-ascii?Q?GBXBp4HM5Igj4uumCj1cMPcNq008Vtszv4FJqAIAINiIVzwJ9m9N7OqvUu6g?=
 =?us-ascii?Q?WzvIseAJ0rCsIgRmcsJbHxbx10V3orFlDMx4fwqTtxZfmDSoWNkFOFBPDrEk?=
 =?us-ascii?Q?x3fsH1RGjOi6sxGLpPk5Z9fZ+Vzawmx2poxidauYIEnrjWCSQnf2uAnlxDba?=
 =?us-ascii?Q?lYTHphMLFtv3scgnZL+y5Q3fgjys3d71Ml4r8XyX4c2kKIsaQtfFMFXsFzDI?=
 =?us-ascii?Q?RK/kV6SEGqHP0IL3gh8lypOaaOEfgwB9LsNSSV+Foz1vxC2v4oef8cr1olu/?=
 =?us-ascii?Q?ZVkijJCSX8UuLYKeBR+b4RSPPaDu+DnVhAcrTW/pLXxcC0nRkqzL8ChvtxZp?=
 =?us-ascii?Q?Znoo2WdrlLxiVTA8TE5FsCw0vxDi+KrHoBJBSh9xbfVG/QKTrOO6xaKSITCp?=
 =?us-ascii?Q?vGNSPT3if6omxFQAcHGBdq9X+AX3eK9zuTsAiB0MBHKLWko3NQCeJXUU1mBB?=
 =?us-ascii?Q?+eoN0jFS0P1ooD25A3Bn6sej9KxufZAXIune1r8TBDJcTHnxLsoJraPGoBo+?=
 =?us-ascii?Q?anHOkL8lNzbwjWt15nJ5MIXtUskmVgGrKo3UK1CiHDp0+J7ImjkcDhjEBbhu?=
 =?us-ascii?Q?7BNGAykIF/StcpmKTI4OQ/jARFTj+VlZl2EXF3Cla208ksVVL4aPULT8oWPb?=
 =?us-ascii?Q?wMPXv54RpRxIPbJsuD7yImTcbhfE3Iw8c0dm7k14Z9gd83m3BENKFo12cAUh?=
 =?us-ascii?Q?TTJxCmcGXyZCOruVDA+lNrEDiP39gLv5HIVBSc5nwza1pTxeidaqh6a6CQbt?=
 =?us-ascii?Q?Hns946Syt7zF6VUIpm0ktKODiyxyeOkhM2ufF1RxGtyWw/Wv2x0duuThmaxL?=
 =?us-ascii?Q?V0qUJ40RW6jldcVYJrEo0esgewQ1BFpgypEHfmyqaYJ+siy1ZveQsu055kPv?=
 =?us-ascii?Q?SczjZUQ5K/C/rlZwawoJCPcik98TXFeJsTERWL4l1j5sOG5SufipNwEpjw77?=
 =?us-ascii?Q?TFoJiWzWclOTPacl0V50J7sFuXISY17FARYlxkRxvoJOX0eaXsRCRjqyJhD0?=
 =?us-ascii?Q?2QRYSDHdvQrwjDWDbEmt7uSvuaLiwBVzmY/NArkZERZk+KBLqBKRBKTxuzvx?=
 =?us-ascii?Q?ok6CsKhmzNMKRJNSoWhh35RglePWMUttjRAvg+8D272Uvl38FMOfpmTxjyxi?=
 =?us-ascii?Q?YYLOopogLZltVVkacXlyipFXrh7rzHCm30t4phRmu7shSGfYKzJonXfUgTHU?=
 =?us-ascii?Q?YcpVzdl1ewq2Z2iLpsDLFlX3Cre6yEwuf4LWkaJ6smolB/selA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zFwys8W0UHKMTGHn6b7C4+o/iLvdOCAcBNYOGTO/RmiWeND4vy6FPWxEQAi?=
 =?us-ascii?Q?EE4uG05QlzI7GLvKuypEWA8NdoXdco1dIF6Cub6TvcpdmXRNYsWa0sDmDP4Q?=
 =?us-ascii?Q?+jRr07g1Gk2RebyQmI2pqjKMYEttT9zv3WGQEx80xEaVEClhV8t19cdcT/42?=
 =?us-ascii?Q?dtfjGPL7wrmEjeH3H5iSaV+ePMf8hH4VuF5e1Z2gFZ93w70yOJfJRZY5yHZ9?=
 =?us-ascii?Q?yo2QJGyetIBgZMSy/LoNiIl8gyfsw6FQ0rpYjwYfUhXBygnVOAii/VUea+zC?=
 =?us-ascii?Q?UWxICsv5hUi4DwXyIug7rPtqEf1qz5MqQcRP1b4zn52GLih8oyQlANJehClM?=
 =?us-ascii?Q?U6GuY3DvlyWdpYpLBDLdAeFMNSQ591SeSPjxKeMfgyR5PD9Ewc2DoTpbOM0h?=
 =?us-ascii?Q?SyXwGebGuM2s1kSQ/o4OXzGY3NgbqcRW2PoIwv3iVJaP2fZt/He1JEQzd1Zg?=
 =?us-ascii?Q?4ZIFrZQy53k/L9CAeKsgJcbI/PTay3UJ0zQIFl9e/HsVNEevFMZpl3zEBYpN?=
 =?us-ascii?Q?7wZZM4yf5aGQ6EAxGs6htKsWO5MT4QJ5iX0y5dBA9RyReD3RtSZDN3C2fwmu?=
 =?us-ascii?Q?Q9jvbmKMxOKEWDiYwxZpt2Cvb09MMsGK/OuB5NiRlidtYGrR0UdImc6Ems9B?=
 =?us-ascii?Q?xkJEW5zRZJe6kXAdtEnDJIXDXKPLnJlPKggez17TdMXbRfDM4QoBJrU65pFl?=
 =?us-ascii?Q?1RcaHoEIO9SdwkgHAc2gurTLeoQNKCoiWjh0ViYDxVdofjleSk2wIPkhg4U9?=
 =?us-ascii?Q?/sQFkQiPweFMP5ciOR7MmoDAr7rA+vva60TZEbxoNiQc7bdFa07iIq1pbLgf?=
 =?us-ascii?Q?owY4WyDXPC5vGgL/7h7leU14RDJZ5HPb1inPH5yvQfln17+1ncK8w+MTJMEV?=
 =?us-ascii?Q?/+2JBiVX468xNAZv5N8JLXP5HfJu4HXuwAQSDg/PCEwqCLKL/SPShPAqfU6d?=
 =?us-ascii?Q?O8t4lp72UCduugwnebO1Cb8DFIC5M9kg3l2+JdDfUOsKPatZlHtPbG77yTRS?=
 =?us-ascii?Q?f9UmTc2KsMNPnkF8biyrZSkX/1uEYup7RtuO+3vo+8bVSP4Cui6cCXZTcSEQ?=
 =?us-ascii?Q?r7biDheflXkH3FILTUPXHO5G4+leH8gd48wEronU1RWZRQINgIadO3SO7OCC?=
 =?us-ascii?Q?tPPBTkA7ixXystt0DFK7kW0a7zCmH8yefZ6dYaQJDQ5jUgI0eTxvkxcT9sRW?=
 =?us-ascii?Q?HckrXvmqgQp5lahOC4r5dtK8EYlp5PiXmJmT2X7uZWxTG2XjFntxuFg9wjJi?=
 =?us-ascii?Q?+04mv6En3RGGn3ZCOQzVrJwnEPH5/MxnIPtQCRg0v1qExeCJ5+hUUo2r5pR7?=
 =?us-ascii?Q?YKILCN9G3ABEIKc3WkJf54BUTNstDFQzG9aYm85MHuMFjmSartOywm37CWNP?=
 =?us-ascii?Q?h6NZWIRjFKnzcSfVInnGzAPtyqPGwWuEubOCrFXv4NDqtHT6b9M+xGDWdGvK?=
 =?us-ascii?Q?BE2sQefZuDjF4l5SBtdx0jfUQU4jRsyC+8AkWbszTKOlwlcz5dqxaY0aPrJl?=
 =?us-ascii?Q?9/bMOFTvwk7EmEy615zouYqsjYB+cwOEDqIkIr3M6vHPlhuVVhItcH1u7XRM?=
 =?us-ascii?Q?5MeML2yG4gTSsGhKhmNFtfZ1JYLSuKu7HgigrI6/?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444c7948-088e-4e77-db11-08dcc221d88f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 20:43:00.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OiL/NwO+ODF5ud9U9ooeMVDdKJBYrKINKSarSqTv602KolZKfXVi6pvvY1vysyPG0xvFVOdQ1WuUC47/mPXRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1407

The mana_hwc_rx_event_handler() / mana_hwc_handle_resp() calls
complete(&ctx->comp_event) before posting the wqe back. It's
possible that other callers, like mana_create_txq(), start the
next round of mana_hwc_send_request() before the posting of wqe.
And if the HW is fast enough to respond, it can hit no_wqe error
on the HW channel, then the response message is lost. The mana
driver may fail to create queues and open, because of waiting for
the HW response and timed out.
Sample dmesg:
[  528.610840] mana 39d4:00:02.0: HWC: Request timed out!
[  528.614452] mana 39d4:00:02.0: Failed to send mana message: -110, 0x0
[  528.618326] mana 39d4:00:02.0 enP14804s2: Failed to create WQ object: -110

To fix it, move posting of rx wqe before complete(&ctx->comp_event).

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 .../net/ethernet/microsoft/mana/hw_channel.c  | 62 ++++++++++---------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index cafded2f9382..a00f915c5188 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -52,9 +52,33 @@ static int mana_hwc_verify_resp_msg(const struct hwc_caller_ctx *caller_ctx,
 	return 0;
 }
 
+static int mana_hwc_post_rx_wqe(const struct hwc_wq *hwc_rxq,
+				struct hwc_work_request *req)
+{
+	struct device *dev = hwc_rxq->hwc->dev;
+	struct gdma_sge *sge;
+	int err;
+
+	sge = &req->sge;
+	sge->address = (u64)req->buf_sge_addr;
+	sge->mem_key = hwc_rxq->msg_buf->gpa_mkey;
+	sge->size = req->buf_len;
+
+	memset(&req->wqe_req, 0, sizeof(struct gdma_wqe_request));
+	req->wqe_req.sgl = sge;
+	req->wqe_req.num_sge = 1;
+	req->wqe_req.client_data_unit = 0;
+
+	err = mana_gd_post_and_ring(hwc_rxq->gdma_wq, &req->wqe_req, NULL);
+	if (err)
+		dev_err(dev, "Failed to post WQE on HWC RQ: %d\n", err);
+	return err;
+}
+
 static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32 resp_len,
-				 const struct gdma_resp_hdr *resp_msg)
+				 struct hwc_work_request *rx_req)
 {
+	const struct gdma_resp_hdr *resp_msg = rx_req->buf_va;
 	struct hwc_caller_ctx *ctx;
 	int err;
 
@@ -62,6 +86,7 @@ static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32 resp_len,
 		      hwc->inflight_msg_res.map)) {
 		dev_err(hwc->dev, "hwc_rx: invalid msg_id = %u\n",
 			resp_msg->response.hwc_msg_id);
+		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
 		return;
 	}
 
@@ -75,30 +100,13 @@ static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32 resp_len,
 	memcpy(ctx->output_buf, resp_msg, resp_len);
 out:
 	ctx->error = err;
-	complete(&ctx->comp_event);
-}
-
-static int mana_hwc_post_rx_wqe(const struct hwc_wq *hwc_rxq,
-				struct hwc_work_request *req)
-{
-	struct device *dev = hwc_rxq->hwc->dev;
-	struct gdma_sge *sge;
-	int err;
-
-	sge = &req->sge;
-	sge->address = (u64)req->buf_sge_addr;
-	sge->mem_key = hwc_rxq->msg_buf->gpa_mkey;
-	sge->size = req->buf_len;
 
-	memset(&req->wqe_req, 0, sizeof(struct gdma_wqe_request));
-	req->wqe_req.sgl = sge;
-	req->wqe_req.num_sge = 1;
-	req->wqe_req.client_data_unit = 0;
+	/* Must post rx wqe before complete(), otherwise the next rx may
+	 * hit no_wqe error.
+	 */
+	mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
 
-	err = mana_gd_post_and_ring(hwc_rxq->gdma_wq, &req->wqe_req, NULL);
-	if (err)
-		dev_err(dev, "Failed to post WQE on HWC RQ: %d\n", err);
-	return err;
+	complete(&ctx->comp_event);
 }
 
 static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
@@ -235,14 +243,12 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 		return;
 	}
 
-	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, resp);
+	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, rx_req);
 
-	/* Do no longer use 'resp', because the buffer is posted to the HW
-	 * in the below mana_hwc_post_rx_wqe().
+	/* Can no longer use 'resp', because the buffer is posted to the HW
+	 * in mana_hwc_handle_resp() above.
 	 */
 	resp = NULL;
-
-	mana_hwc_post_rx_wqe(hwc_rxq, rx_req);
 }
 
 static void mana_hwc_tx_event_handler(void *ctx, u32 gdma_txq_id,
-- 
2.34.1



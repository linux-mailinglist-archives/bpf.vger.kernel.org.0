Return-Path: <bpf+bounces-4578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431FA74D145
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6651B1C209E3
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17673DDB0;
	Mon, 10 Jul 2023 09:21:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B0D53F;
	Mon, 10 Jul 2023 09:21:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C56A8E;
	Mon, 10 Jul 2023 02:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZylTb4Pj6pz9xzJBEvw2l/7m5p+jhQxPVjqw0oySABtzOqZgKDmaDD8mB2B/FA4II2WEOTg4srCoh1MCnjDxu8aw9rqSfHhZe0GIZLAIstHMEbkC8cTVjwhl1YRLDSc7zQSy+5Mryx+0a8Vo+sxx82QCsItALFmPNBiKXN6LzUz3sEPfuZ7NkuCdFVJSEJ5L42t6LTjLRIxOBQY1A46pj962r6NC6QSyHAnDwFbXn1jfF++VFuaDY71ZBWZ6hMVrtOFi0ve6KaUXqYiX2DhEtn0SU67xNCZDkFNqLaIIHlZiACP83MeNq3zMM2Aafc75D+uflzgRJ5NJhxSOwizUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QdgIvHEVDFvfH4Ry7MyAFDnb5ixGI/D1dR9GEMzUq4=;
 b=cLKR7ScJHkg3IGPKgwXZuKfQ0lacDxR8MV6HELIlgCA1nRbc1Daj+qIkJi9WMFqUZAG8ubEey9MvYmdPRroLztQbQNC3KVmukTL2g1uw4VBh8MyF3Kp7oFr89/FW3f6upu0VuHgaZf2P6opHo3wyC3SPGhJ7zeCZVxDFoPpoZHnpt+7ehGqmgXH0vkzzRYyRDorsPN15sV2rVBLyaxuKnVnratzoTnAMBV3egoFhcU4j5+Fie3FLpJ0+zAll9bkGDyxqdEO2Ju0m1K/Oa58ZVIBCevZizfPKQ6N/DdtIWuV7ktvrS80PVKBvmMoQvdgmuH3iJInrVkzmvRHeXJqU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QdgIvHEVDFvfH4Ry7MyAFDnb5ixGI/D1dR9GEMzUq4=;
 b=Tmq8bp42iRwt+0eBMzFYPSfVYDd6vVJmeNxkPHfCJsRT6FRoaeV/zn39PbUXbmC21/Tms0YgXrGEc1cZPFm12p4Hg938xiTpLyh54UOlrht6mKKvUmj1CqPoDfemAgkH1Cru1r6h8qdh/w/TQtskDTeihkDms+gc+17deV0PeI8Yh+n2fULEAsrCaITYY3bsf5/uTcPQa95r0WRms/cITzoPTJ56houhjwXk1U8r4z9hXOL2KkwkTqz9C/jgFN1l3pW1zzF70gBs3pPWBspS9hU6uyWeIGum9C22oyeuoySltKg7vV9ghe0NGzwQtpC8NMb6IgzwcrcxXzxljyN5gQ==
Received: from BN9PR03CA0196.namprd03.prod.outlook.com (2603:10b6:408:f9::21)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:21:09 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::c0) by BN9PR03CA0196.outlook.office365.com
 (2603:10b6:408:f9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 09:21:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:20:48 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:20:43 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt coalescing support
Date: Mon, 10 Jul 2023 12:20:01 +0300
Message-ID: <20230710092005.5062-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f6122f-0968-45bd-e820-08db8126ff10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ABOmY2z23mprI7COSWl0vxU93XHRtFMO4l6ywTP2FokSmulC1yjfaXTaPWwqo/l3YbBJuYKz39thRrdV3vCDPuwnDvmi4M5xUijSYH4uP7xH//mMwuizZrjNatSU6I6h0VHaznF2jAcMZ95M4zKQDtPjjasgYDgYV71n1WjSxudxzJb0H/tNuIZA9KorZfkOrYpyVOffs0r722kUFMax29KBqLhpu0bNPRUqmAiiT9mwW775U+p7j2uM4LuPgcthu2qKLagUZxqXBkkxjSAxktijYN4eNzX2JxSgfFc5Mxf4qDk9J0Wbk12v76TV6Ih7SLJsTv4YClrMuWbZGpiMN36xr8EgAb8HRa+69EHA+mzNTLotKE6+OEFqkLj1HF+mlhnaAFybuHqisuG3YpYm+M13f5Iw3RGwAgD//nLNFbWyR8O1Lf8NHSVgqFA2Sv7ehYf/OiGkc9XYjGaRojFaQDQUJMooq1VRsWGJC48ewULj7EkF5tn8+BUHJUyGVAk0y5F+rfqE4cyvNThwANnl2C50E1ZM7gor2eTQ5oiVy1zhu7FdgyR1P4JqezzGzKogq0EcXhGNzmIag3GOv9JVpV4xmFPXyYj2dGi98uz0AoGcs/LMIBjDyY01pz1r5ZTmdg+SxRobfn5Dvj6vjRpy+29xvcIvjNVrq4CoReXDT43lEypBIRUuVxE10pgXdvReUkWoq861nj58oRvazO1WDnazdWtaq7nyjPL01NN0a/wsXiRzTht4FQNOXjhyZEVVTiWQizSru6dVNOsQRbXi9z5OdEQWyASS75twlmydx7hp8ArNZhUiwlQ7JBpRqknZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(478600001)(7696005)(110136005)(54906003)(16526019)(1076003)(26005)(6286002)(70586007)(186003)(336012)(70206006)(2906002)(82310400005)(41300700001)(6636002)(4326008)(7636003)(316002)(5660300002)(7416002)(8936002)(8676002)(356005)(82740400003)(921005)(2616005)(86362001)(40460700003)(36756003)(47076005)(36860700001)(83380400001)(426003)(40480700001)(55016003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:21:08.9064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f6122f-0968-45bd-e820-08db8126ff10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, coalescing parameters are grouped for all transmit and receive
virtqueues. This patch series add support to set or get the parameters for
a specified virtqueue.

When the traffic between virtqueues is unbalanced, for example, one virtqueue
is busy and another virtqueue is idle, then it will be very useful to
control coalescing parameters at the virtqueue granularity.

Example command:
$ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
Would set max_packets=10 to VQ 1.
$ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
Would set max_packets=10 to VQ 0.
$ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
 Queue: 0
 Adaptive RX: off  TX: off
 stats-block-usecs: 0
 sample-interval: 0
 pkt-rate-low: 0
 pkt-rate-high: 0

 rx-usecs: 222
 rx-frames: 0
 rx-usecs-irq: 0
 rx-frames-irq: 256

 tx-usecs: 222
 tx-frames: 0
 tx-usecs-irq: 0
 tx-frames-irq: 256

 rx-usecs-low: 0
 rx-frame-low: 0
 tx-usecs-low: 0
 tx-frame-low: 0

 rx-usecs-high: 0
 rx-frame-high: 0
 tx-usecs-high: 0
 tx-frame-high: 0

In this patch series:
Patch-1: Extract interrupt coalescing settings to a structure.
Patch-2: Extract get/set interrupt coalesce to a function.
Patch-3: Support per queue interrupt coalesce command.
Patch-4: Enable per queue interrupt coalesce feature.

Gavin Li (4):
  virtio_net: extract interrupt coalescing settings to a structure
  virtio_net: extract get/set interrupt coalesce to a function
  virtio_net: support per queue interrupt coalesce command
  virtio_net: enable per queue interrupt coalesce feature

 drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
 include/uapi/linux/virtio_net.h |  14 +++
 2 files changed, 154 insertions(+), 29 deletions(-)

-- 
2.39.1



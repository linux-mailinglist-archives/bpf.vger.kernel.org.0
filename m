Return-Path: <bpf+bounces-4584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4AA74D279
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7599B28108E
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9B101DE;
	Mon, 10 Jul 2023 09:59:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802ED53F;
	Mon, 10 Jul 2023 09:59:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F53E7F;
	Mon, 10 Jul 2023 02:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmMRZp4ZhHXDucxDs4x3qv5hj+O11zWkeXVec6QB5zSMFjLIaoEYJzGQ//4b7Sq1mx1OCENs5NMh3PG/sB+OIdPklL82LJOBkfc5G8Dwat8mUkLkQnZMEc+MzM2/Oxi8wJCP1hfGr3GcmQtws6Zuc3HKedL1ecNsV9C+mk49it1F0itbTIhXzp/s8IekH/oY4FCCoyCRfu8qhrkOMxZl/jCbM17zEhDTlsKY1pfIRRmTO+x8Etg8aBiYo0aot+rGlfaoa5CYBW0NK8wMjj2AHI71YHOy96WPRuEDKe74G740mmGHVo/k7pL3HdI1dhU1uDIyv8paoh1UZqtoHcBVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QdgIvHEVDFvfH4Ry7MyAFDnb5ixGI/D1dR9GEMzUq4=;
 b=lAKzyZNM/OZ+B/oP4QD5qG7cl2lZv7eKVbz6QJ2GJi5DZRdZSxVKfmHklt8SPVfHqCtYPuAhv9sEh5NZc+6KyJgBF8gxQnRR1MJ1YD3Dfo8Vwnp0veh2GPf75R01YBNvmZ0XMw2iB2ES3+pZaX+ItzqKVFR5Weddc+Ze80wFxXWHdfiFWKaiEhMYp3vxOGQNjYC3q9EnFJtA0L8POTyYwpsEUQQeRaM/y5vjSD4gMk1xku0pHzmdbPewGAJQGsHcG1hnDAEPhlosvXDqKySBT7j1yU0TNo0ebvy2Op6PomPyFE1CU9nsJmmEbkxMDD3KTBtTYOZMO1AZdtuQzc8LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QdgIvHEVDFvfH4Ry7MyAFDnb5ixGI/D1dR9GEMzUq4=;
 b=ihWWFtbWxa5MsCtX2t6IDWuKoQzBxLnZWV1v3DZArEjEQM1ca+d+gMpcKiaUO0vsdORA9ket0xOzZleVwM9hhgyzmKiePlzZp5IOOcGIUaHijACUh7SZEGc7HhQJUFOfv1tgTpxexw7PaxDt+pZwTzQ3uoLJ8rusTNL45ozkTHiqdeLSGpi6DgV8vL6AQSM2jxmPJalBCK0mrT/rb41kQfCBodFNrqowNaFq5b2KD7JZH9v7rt085Aq7011mt6CMWKFojsynuNDhW3fns3+XXVP5CDPxf6ZFJvKPThcYINfNnTg0aoWvX5wV5UVG1slA24OTA+by7oq307C7NWMt4w==
Received: from MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::7)
 by CH0PR12MB5028.namprd12.prod.outlook.com (2603:10b6:610:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:23 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::71) by MW4P220CA0002.outlook.office365.com
 (2603:10b6:303:115::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 09:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 09:59:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:59:10 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:59:05 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [RESEND PATCH net-next-mlx5 V1 0/4] virtio_net: add per queue interrupt coalescing support
Date: Mon, 10 Jul 2023 12:58:46 +0300
Message-ID: <20230710095850.2853-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|CH0PR12MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2af87c-0d68-46a9-00b5-08db812c56a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ctB7ONfOpAfh8CF6txCTROxdK5rs5L2Idf+dOaRmUiDSS3tMICcrHQ5h/Hf9bd/Zyu6KRE7Sx5b7nz6MDT0X/evOjJ3G7i9ZfWsJLmkycd2O1iSx5+FsxB3Rc/J3b6UK5nzRs2jDgQslX1Wi7yxVWpOJZ4k0scOBLaXlHJCXW4yItb8G2KXliSiEfOohvc/CizI9cRY9j7lhIZmArkUL9dlOmusPrZbGtn03FrWeF3mvgwcFhLSmEOhhj0ldit6bkvQEKnISDS+Ef1a/3VWIt5jC4DPbd0QkofD1XsYpmIUECdkBizA+hFcDsg4lxO9b3u1fLhI9S13ECLasxv2ORCxRZta4Esr9AZdEF9y/SHlTJH1z4p5G28OfGOFeORCi6iPi14RsmxhN5QCtbj4PSC45OPe1LJr3/5OR6iE3Jy087WCdMttAA6Os1RfkyyetAYS0jmgxdq/kxZjJXvoJlZotBEyDBF0bfbBGw3QhcxpaBhlcxc9Oksdonvfkja4DX6iHJd+L61CGn753dj+U+R4zDIC/s2ojSCOuwloOlIyIJJWTWAndyqMdVHSn5tsG5YVE//imtnRVbf79WLVa+/6Q2PfTzw3QdKjcSxBs73vJC4rC+/lLKuulEq6MkEW5dWQeUIE/W6McM382oKemZe1u2ph/7JwZuglPBKn21lPGU6hQ38N5Rfb291Emyqu7wCotuTdEW3jyKVg12GsoXK6wKC0LvrQ+KJ66CrUHtH2DYkW4S9t9RrOCvhQWd5rlrYg4gr8zl9TloX9Kg9Hf3Iw3KmryErcg/K1LobE80+mmLzWdzREQdsWrsw7m3Yi
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(356005)(82740400003)(86362001)(40460700003)(40480700001)(36756003)(6666004)(7696005)(110136005)(54906003)(70206006)(70586007)(7636003)(921005)(55016003)(36860700001)(6286002)(16526019)(1076003)(26005)(186003)(2616005)(7416002)(5660300002)(2906002)(316002)(478600001)(8936002)(8676002)(47076005)(336012)(83380400001)(426003)(4326008)(6636002)(41300700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:23.4318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2af87c-0d68-46a9-00b5-08db812c56a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5028
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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



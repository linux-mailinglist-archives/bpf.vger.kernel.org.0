Return-Path: <bpf+bounces-5818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D996761957
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 15:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC382816E5
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795AF1F186;
	Tue, 25 Jul 2023 13:07:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C41ED3E;
	Tue, 25 Jul 2023 13:07:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1E6173F;
	Tue, 25 Jul 2023 06:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPV3T2fVcW5UTSV74ow3vRcx2wt8PRU3JMqju3fTkoO8aHc1nWAu52pEajCpFOgyI4RvzgZnXPHgnfGd+fP6dNssqYCV0ZnN6lmpy+9633udWLW4gV5HjYHwYkqpP7vL3Sd7DIgHb6FESsvWWwzPHygItO2v2Gxs4/6b4Ylsq5tI4StbkaoOfl0/XqtwAylYK+yEm7HoONlMm00w3fedakyjWpnJRGEs2ZJW9OzdzA4yOZl7+M6e1cPYqox94KkIPvGY8xFf/DbkxRLXhFGIL0MCvQ+BZq/blafGyVGxENsVICQeCdSKCWveHlCBCX5UyLPJ57ZF4EXsR/uR1BATog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK+8ALn189/VYcZZfobTNdm4LjWO8rr/qianUzVIx50=;
 b=QAy2swkwMTphrCcrr5ihhBJLNSqspu++X1xfsklOg+eiLWMUsbK6zXbNzKD5EYGZ39goRnuUzABDIBoSLMJCqqrX9xK/xfUgntN5Huo0Nq63XrrCZrzoEIR3Qp1CJ43lLfjxBNn/pmB1z7v5AH/ZAtk15lTfd3bwFg3CeoiukvCk9XadsXnO6F2EqCxxNRNx4j5riAn9I3cwDZLwATIM6qxEL4hzXwBvAE9v82HUFKfVX2zg1B6xLh6/zqSqquKbk+/wj7WzkRi6cFB1VvlkpwG2WeW82xvz4d29paAbaehmCUL/BM2LQ2UbhdGMq2sOIAcJCMgwXbkGbvcF2dBkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK+8ALn189/VYcZZfobTNdm4LjWO8rr/qianUzVIx50=;
 b=TxZQPLWKSlCevg1ua7hOpsCTz031DtNCepE1Y504auhNyipoRQLrwn+Jb7rkTzKHwhSe/UTtvhNXWkTR0m8zkBYYVziOoqBd6ZmyTfCizDrS/Ow5FHah7YzznMciFkjbMq2Oe4N5+jdWkc2q3V9RUSYV9xi0VwXaGBHPQ9t7+cZLAFdUygr6JD7XaYzyQtkOivR18Pg7frax4K0TtzwKN9gXWF68Y+uj7JuLMx7YJsAYWOYA8r7YxXgZo649KZkobc8khMJ0BKmRWUdAFgMBkA4n+XJQFYg0ENO5uo2Jvee/bVyALjnbmqNWWtnih9bbo6LMF3StaUbgLCM5qKSAbg==
Received: from BN7PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:20::31)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:07:42 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::2) by BN7PR02CA0018.outlook.office365.com
 (2603:10b6:408:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 13:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 13:07:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 06:07:30 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 06:07:25 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V4 0/3] virtio_net: add per queue interrupt coalescing support
Date: Tue, 25 Jul 2023 16:07:06 +0300
Message-ID: <20230725130709.58207-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8987c99c-59db-45ea-c4f4-08db8d102187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SKfLTiMKVgRqU/Wl6/sod3mmxpVs8Z619Uo+MCquKVxT45037wzQudYP09+YBvxGRpd645GJeF0y6wpSWlorp7U+qT2zqZUXskeFu2m6b25N+H88UOJiUW1dL37DAU+APo3jm+BTUWwyEnJuTWdxsIsuLElYRrOZAKWE7adPyGoac2Hn2lQfwMneObnWvyrrqmgGBjRYg5NIC+GRJqfGW9sAl2I5kYUaqKKvmGo06+O0GyWmqjsSyNrXjZBUtmPvAQqykxQVmhApoo3kGBaJiFxfdO6UE8xAVnEYnw7gM4OgjJym19px+5NbWw6zHE6qbPlNBi7NPZDyh33AgXcnE3498a7mjNVzF7QB8HlpQPmg7dZf0hxlmdvjjaXPo1iEXr/u/NjBtjtf/C0B61mWjPx2WYfB1hHv7Np7eOB+gD+hYNMBHZzBEekqlIEPCKPaMquPPZl9l2aIHsjjg9HtgY07FCsKY85P4J0yeNyEfz3HMVu2VU6HJ0J9nBp7KRTDfmkZgSQlsv319EQmaKci6IqaeNNdyZq7Hm5UR4f+kvHFeb+a46DPJFpD0d5wTvYu49CDw+mtjhLGAQz+9Ahr0L6mYM2L3S8bV70yVUIMH11xYEFkFmSLchm06cd3uirS8irzjHqb8a06zSUWMEtFW6z8wVguQLFlNpGRmdr5KYzaf4hxl3z8Odnxb51hoCDNR/Kfbz8Juvs4yCY6aYk/rcZBIXEGTOs4qxRb7QbGoax2rPlttwyCORl3MMGJBqwNcViF7i/63Ad8EV5hOT2BHpIacUxGtBa2cGT8i3zAXs9cWSa9xs2edub1pmZpuG6/
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(6286002)(16526019)(26005)(1076003)(40460700003)(336012)(186003)(36756003)(36860700001)(5660300002)(356005)(7636003)(8936002)(8676002)(7416002)(921005)(2906002)(55016003)(40480700001)(82740400003)(86362001)(7696005)(6666004)(70206006)(70586007)(83380400001)(54906003)(478600001)(110136005)(41300700001)(426003)(316002)(2616005)(4326008)(6636002)(47076005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:07:42.2721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8987c99c-59db-45ea-c4f4-08db8d102187
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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

Gavin Li (3):
  virtio_net: extract interrupt coalescing settings to a structure
  virtio_net: support per queue interrupt coalesce command
---
changelog:
v1->v2
- Addressed the comment from Xuan Zhuo
- Allocate memory from heap instead of using stack memory for control vq
	messages
v2->v3
- Addressed the comment from Heng Qi
- Use control_buf for control vq messages
v3->v4
- Addressed the comment from Michael S. Tsirkin
- Refactor set_coalesce of both per queue and global config that were
	littered with if/else branches
---
  virtio_net: enable per queue interrupt coalesce feature

 drivers/net/virtio_net.c        | 187 ++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |  14 +++
 2 files changed, 177 insertions(+), 24 deletions(-)

-- 
2.39.1



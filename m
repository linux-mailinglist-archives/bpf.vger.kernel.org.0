Return-Path: <bpf+bounces-6405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F8768D4D
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8886A2815DF
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D263B5;
	Mon, 31 Jul 2023 07:09:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54F63A0;
	Mon, 31 Jul 2023 07:09:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0119AB;
	Mon, 31 Jul 2023 00:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKl4uDJhhib/Cpefu1HCoQtiF8eLQXAfG2o411kN56oKI264Rj16z27MlFJ2D4X5Nvmvpu8Vxv9ZLeYKvlgbyGHor4EcDL7vfYI4vfijkBwZWTeNJCww4ZQHlE8FIRuADscb9sfvluCqGdJPYt5QZmDrP05qw1bFU4Lji6FdrtwzmPsp6gh9EJkZB0vPdBXlrVJiw69mW0hC3Ppey+IeamCmRlP3nN0RquX9XgWCni/4uD/mimf1J4NYTiXhTfBKIj2Jb5DlY+QwDvZ7BBYQgUAw1pbFwHESn6xIZpK4v2/O6UcY0dJW9QomZCAfCEMoPrYzJXjVuzREWSr5EwilVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4nbaO0W3Y3VapI+BGsT9dsdxzSLkkO9XhL+jT65+5Q=;
 b=P+1C7UESIqPYUkj1JwpLhHeZya4DsEOOPRPbGAEGsTUdABZnhQUGpKw/Ls9OZ8LX4QWT7731a84ZdOZtMzP8Ue+Nv/XyC6BIKn9FAW+d5TF/nfkiogfocQayU/MfBIo8/cCwrz2jZ5+2mWmupdAAqCp91c2tcVR2scjdx9iEGyWU4rzvV7eGM9+ckmI4eMsYR7/jsCP54001fl2riPEfcTVppCpozPtALnDbG1I8wfk/YZvIx/LTBvSV1Sn33Y1n1tESKB0eo4F/gjcqDga7azg2Wud+Q38O6eFfImQ5g3GMHRKzntmdAcAv/yFPWfk0vkx3SevjvWCC89Fdz782pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4nbaO0W3Y3VapI+BGsT9dsdxzSLkkO9XhL+jT65+5Q=;
 b=LbOsW1gcbBRjU1/7HuPAgIwwsBULntA9GlaSse5HzM4/K+qXQ9vsRR0AOixgFOlVpkYZTXuakJs//jFbuiAHEi2S5w0+fXYQPm5SWUAKBzp5WF0HOLhmg9wu7WXFYz5z/YdDzLrISIqQJ8pvIbOpSEiLRTdd34YiJQD+zGOWsgJ0zhjpkbyiiOBRQtiGD9dPg9JZ0fawX7GaAiuKNY44Wf4EoIgg6lIgZAc1BzGZ+PepyVOOvXI5cByLlqmJ5L+wtFRnCl0GKlJC6ROdbWj+MXSbu/nbVuTW2cJMB8ahWXspnNiHjFOjh/E0jimZcKDYSkQQ6SFxRuabUkA0ArGQOA==
Received: from MWH0EPF00056D14.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1c) by IA1PR12MB8519.namprd12.prod.outlook.com
 (2603:10b6:208:44c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 07:07:52 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF00056D14.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3 via Frontend
 Transport; Mon, 31 Jul 2023 07:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 07:07:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 00:07:36 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 00:07:31 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next V5 3/3] virtio_net: enable per queue interrupt coalesce feature
Date: Mon, 31 Jul 2023 10:06:56 +0300
Message-ID: <20230731070656.96411-4-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731070656.96411-1-gavinl@nvidia.com>
References: <20230731070656.96411-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b151960-a9af-4198-84f5-08db9194db44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V0g9PaWcMluEUk+x4KR3jmsD1ZKhvFgwIFuC9kVIEU+8wvmfk6Xf69innaUCy753xlqIoqMSYvphVnK/BeZMBLpeIQTMw2vu1g/uMzKwKIQLdsLFXRvKZqfUAPxZ29tQWkNZ9h60J5BbcYT7OWbF59XJW25auahzfUfM4CFCVkb0iYpBxIhREI3YE8PC4dYwIqmnAtZLYau/eTGsnMGdxnzSwB8itc70+rgbN+a++NkKbvODAQ/2nFhxWl8aaYjNFfoAbz2QFQEe35k6kYch2qXEYh+5QBKKFwZ3rlXGu6G5fNA0ugykapuPyKfUhpSZcbIvb42Rw+Vxg8GaN36vGPwJHKOr/+eV6VbzdhDbL8NhtD1ZD7UePmhNHz+cmRGANuJt4L0ce/Jk7cgGv1mhZoT27/3MTcC+bQLlci1W96oeJPwfcxbjmh/VNSJehmpdvW3IXi9EIaA6KaeDlOP2OGUyRslr787e9l+4dRMDb48m07zEVHxQD5GzRi7pP/tedlVNC/otOSF3n2SNjYcKcrzmj8q2oaoFEU2vYZUFd0iUBO9SUxOFEpq1vOr+PXnRvRjZtzMwuvtW9OATc5zsMZrO8D9X5YfMEL65sLVtGThjC6MZRDtPgVveNAqNHjiE5dwS3DH5Mc0H7+8ebX7WIge2HqDfp8SLhX88ddvdvOcZ+tkrbOvKQzK005N/K+VS7jiL/w3A9Pjbu3/QTm5BTYvYHcVW23Km45sYRD3t2xLS/wseZX3U/kqcxOC+9q5Acs6SAxgq4KIJB8XnFPEXjF1bTwEjfRkYxi3R4B1L8LY4S4cOn7csRj/kao75I0r/
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(356005)(7636003)(921005)(82740400003)(55016003)(40480700001)(86362001)(36756003)(40460700003)(478600001)(7696005)(6666004)(16526019)(2616005)(6286002)(336012)(186003)(1076003)(26005)(8676002)(8936002)(7416002)(5660300002)(70586007)(6636002)(4326008)(70206006)(2906002)(54906003)(110136005)(41300700001)(316002)(36860700001)(426003)(83380400001)(47076005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 07:07:52.2164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b151960-a9af-4198-84f5-08db9194db44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable per queue interrupt coalesce feature bit in driver and validate its
dependency with control queue.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6640474f46bd..10eba113b5fa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4088,6 +4088,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_NOTF_COAL,
+			     "VIRTIO_NET_F_CTRL_VQ") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_VQ_NOTF_COAL,
 			     "VIRTIO_NET_F_CTRL_VQ"))) {
 		return false;
 	}
@@ -4512,6 +4514,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
+	VIRTIO_NET_F_VQ_NOTF_COAL, \
 	VIRTIO_NET_F_GUEST_HDRLEN
 
 static unsigned int features[] = {
-- 
2.39.1



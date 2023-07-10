Return-Path: <bpf+bounces-4581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64B74D14C
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD5F1C209A9
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731D4101FF;
	Mon, 10 Jul 2023 09:21:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4E101D7;
	Mon, 10 Jul 2023 09:21:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE361BC;
	Mon, 10 Jul 2023 02:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRWwe0QtcoXVOsnUrmqW912M25HtnD3aTMZvCoh1SfQiTE+2JUq8x1Ci5O2NIkKnZkye+yIaab7dEXTrKuWdEm2QO9rF1EGRex+kHjj9CCjEQVvZ8IIC1DvzpZq9egszcfDLLcVETyR6SgPTT6N77OBzGj5imHAUVOCxaMdJBleTHgkjF+iIc+5cXxizvEyVzZkHFeyJ3eXFuCXco98+J+hptJQwo9q2QNXzRgh1ru1zRG1SAm5dqj2SO6lkBc5iTn11HWgc/Qf7fQBMyfZwkYkQiP1UnGQzIW8PWUOyUlN4kqxnx64Kfw0kMdp1ckCsFGeH8ZR6m9k0HstuAJgS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0oHsOuXgvTMjpbxKtqjrGPAMf2I/9i3elpw5czoUwE=;
 b=VgYvskPBO2078y3YSk9TxGGwZ6ucVIOVBk7QQSnheYuIOcs++RZCpMFgH1oKZupLV2vSt/Lh9nWwxD0fXDWJupHaURv+fojIy0hLvJOKJ+1+AxEuYJohKyqfp227lhGQuvvK6wQD5GZsN0Bdy7N0y+c7gcI7MxACWM4l2gCFCaAIrN8lPVwpplwIVpH6VrlJCtkGKNrcjgrw8/ACqnO4fom5rNPSZQmi/Eon0oeLeLXXu3OVopsA9T3YqF4aj7vX/3JrcnDNfUZ2her+4nIOFrUhl3mbu09DxBWYk2ZUB0FstJ5bhohzQnXPzSUGK8OXmBuL5X79EbPFaSNtvrLFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0oHsOuXgvTMjpbxKtqjrGPAMf2I/9i3elpw5czoUwE=;
 b=srruZDNAVPwx1u6hT3wkhYO3rJwG0UXtmUtKPfnB/kyxu9pfzwXqunn0JbUQzdspbaq9YbOezbAj6ToNee59zaGg5YvY/x8UMjnad/HWB8O3QzeH8wvpa3tPepYt8JPjRlWIYWNYaIF9M/qbjkJtwHOf6JWlmfY44LQagBE0tSGp1YGBiMX/LJmdn5rXU341u5kF/acKtc2RsNymOq4bKE8l92ufZ0c8KF0E5dHA8HYGUKOhPC5Ym7A9gi0kvoVQ3dcZ2cQ/23mqmIcvW+eLFweyqY6+sFQBDHuOKHSpFYrwNAfM/9yLoCFkID6DjJkpUiLqpq75XKFPX16KO39EEw==
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:21:29 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::f8) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 09:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 09:21:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:21:06 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:21:02 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next V1 4/4] virtio_net: enable per queue interrupt coalesce feature
Date: Mon, 10 Jul 2023 12:20:05 +0300
Message-ID: <20230710092005.5062-5-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710092005.5062-1-gavinl@nvidia.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fcdad7-4be5-422b-f98d-08db81270b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fUl7dZ8hA6EviDSbySZZ43UlqYQkOzDbTdgX4n7Xk37fkwBe8xbXfpLOQ+gqQC2V4QiJYqNYgxqfwDuc82HubbuKsK59vkvVvk3I9ueJOct9j4ip7BqfD8mdgQWxnM/HMwksGWNuIAvjOrkessgSmtqvFT0uTbMJeIczqWJIv2M+BO+n4ipqaL+AvCNSMr0+gd6G9LhGlhVgwKNqSFwt1GEEHX+pxy8jFCjEloFjUH0ePuX+j4zta2gPZXfCNUAa11Hpn9Fn5lJmt3H5fSt5nzhzmr5PlIGRIW37RlIqa8FdRfe0GrzTfmD/QVs0emA7V+G2gV/WHYZ4PmYvrA8lpUqbhESN3PfdeZFA2S6jT4lfbUjNgD/330f9800vGhaT5Evm6VDJu6KERqDHLQwmsopqyl3LRlipAD+PdOfoZXhaOtWjOtEUTg7X3nZ2B6ZtJIaG90tIR11sTTqtwI3iw3xx57aSMvz/FUbfQSQ5yQdeHojBrTJL3qx2BY8MO5oxiKkqPg0TCi5RbMWAumohzIY11/LOAN99XzkifCwVIWXMhSKCasLKO4TVuaDJ0kqnjDVK1JXvMwI6r6V+N5ii+gVO7JxGjO1HKcrjNlvt/+dCJcNIBPSxh5JQBdXI4IhgPcdjQdrml7D16ND98IEkagVMO0OJCBhgaufMp6aH1wB56EUCH/KMAxYvaNBZJ3DloN1cr7NVLd61BTgEnF9wxj8ESLovxUki4oiK9aoLoxXGOPb50teLdFFxk7AqPNVs/iVpt7aaZ7Iy+nKzaqamXwd7jxdEJYbGXJbz7RXpnuBPpWKe5AuJF5NvVYEtaxzg
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(55016003)(7696005)(110136005)(54906003)(70206006)(70586007)(356005)(921005)(7636003)(36860700001)(6286002)(16526019)(26005)(186003)(1076003)(2616005)(7416002)(5660300002)(2906002)(316002)(478600001)(8936002)(8676002)(47076005)(336012)(83380400001)(426003)(4326008)(6636002)(41300700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:21:29.2795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fcdad7-4be5-422b-f98d-08db81270b37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable per queue interrupt coalesce feature bit in driver and validate its
dependency with control queue.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 333a38e1941f..81bac3597a2b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4060,6 +4060,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_NOTF_COAL,
+			     "VIRTIO_NET_F_CTRL_VQ") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_VQ_NOTF_COAL,
 			     "VIRTIO_NET_F_CTRL_VQ"))) {
 		return false;
 	}
@@ -4484,6 +4486,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
+	VIRTIO_NET_F_VQ_NOTF_COAL, \
 	VIRTIO_NET_F_GUEST_HDRLEN
 
 static unsigned int features[] = {
-- 
2.39.1



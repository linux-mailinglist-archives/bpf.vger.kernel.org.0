Return-Path: <bpf+bounces-5821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B735761965
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 15:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2151C20E32
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8B1F935;
	Tue, 25 Jul 2023 13:08:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FB1F92F;
	Tue, 25 Jul 2023 13:08:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F932E74;
	Tue, 25 Jul 2023 06:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9eEoet4N28PcM68iNQwwb/cnpoHdbOsd5QBf1H9ZHBtiwCBDGDOo0ralQfAN29MT2VLNr6Qlqy5OrIvsHILtzvH+2S1zGMIGKMLxloHYTmHLViXV8TyPvENXr7cDMWb5cp48/vSvDitO8gQkJ5jVQLe7Mcsj178LeZ4f78+9TrN2YgGaDvcICcEQaLmwJvhnKFBiBbEhnjx65wU7FZ0avaE9Qvdri3QlB1fTZcHuMgVyXfF8BIZftF1aQWcuYfazvJcZAkhavIftShWh4EZjbgxrFgZSX4Deq4uPi4eylhCDOLKL1pAQnTMnxTnt+mH59mzh8SV225rBcTkevhvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F68uh+5E2MK8vPgXqUr6OxqxX0KW/cOiWvwQdxldrZc=;
 b=AssYdqOJ2NqmTP+Ux/L1nf7hA3Ca0KuxTttMGm13HG2StMifPd5ItpkVydABQ1AAt1rBduQbLi3ABcJHibz2PIVaTjNDlkxUf/auK5O1y5k8MkZ853bYGniVdmfjBGHR8R8mmL3yiw42Fnj09NTjFzE8MQsZYN+3EwPTNX55XxdEfXNeUD53UDl9IrC69Hs9GPpL76cF3sTUIbxmovMyJvVBs5h/08kWCRz3HFEecjSZ/rji5+4aYbJy58MRZwRCPJRePVh7e9RAQI34bUqFsHd9M86IayuEJPAfL87Yvgu2IEsbhDozlCmIC7UhVpn8hOxmQnMpKMqMDyqUhmfL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F68uh+5E2MK8vPgXqUr6OxqxX0KW/cOiWvwQdxldrZc=;
 b=Uv6u3fH/k2EIilteUsfPQj71+LvB+QoTk4rsA34lEB9w2BVpFw8iol265r5lsY+E1ObdDC03CRQ41mDsaCFzM00Z6kdCAlNh1Wy/x3gzt0yeaM5a1P/3uMF5Ds+lXOBLNsORdm5TWZ+NSPep7fnSyKQcN8MtaerPVrJJ5Ukwcwna626CWg8OlYkmkekcYgBHxCxDTJUrPDe0FfYouS8UOPk3Fuyomdi3xEl+AwWOlWPGhkP/4DFKBxvGhhQ0KOQFbj6XzIGtyDBkvI7kjYqc8F4JAA5K8ShKrLPTqbn6N9NExfTtR66yRuQWTZJ1LmmfHZv5QRKZMLdH/y/74pqv0Q==
Received: from BN9PR03CA0430.namprd03.prod.outlook.com (2603:10b6:408:113::15)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:08:01 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::c5) by BN9PR03CA0430.outlook.office365.com
 (2603:10b6:408:113::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 13:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 13:08:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 06:07:47 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 06:07:42 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next V4 3/3] virtio_net: enable per queue interrupt coalesce feature
Date: Tue, 25 Jul 2023 16:07:09 +0300
Message-ID: <20230725130709.58207-4-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725130709.58207-1-gavinl@nvidia.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 508d9403-924c-448b-5084-08db8d102c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9lCwzF49CW9pLeC/pr1DCWGtcI1eW2OqflHpNr703BOKDyKFOXlTi/fiD9ly+B7zoPSuXCPpsXZCKfr52T4ENntsLecpEUIiyxAty2/J3u5SO0nh6ruCEhe/Xb30ZDaoAFZWGOx0QZNB1Ju9hBIBGKIrVv15tsQGpugTCZOiKFU+k6ut1KlaRncjWIKLmMM1gH2Rr/Mf09F957MwcPE1bdOcQkS3w/pX0Rsjy4cxSC0gZkEtlrusOPN/cm1W//4kg54/IVvXLIAsZz3sVwIi5IyS4BZn0JCdJiwsj1KpABmzLND4a7Fa7/oltQVu4NspYXpIqjj3qUA6wnnCZm0aS7WpgLJFeyJWLaatkmW4AUA4y8PgMDiT7tB4h09ssx34jSmTReOug91hcdYcqsWng4zJ5u9ZzGgeLM9PmBpZ4TAxY78arbbbEID2Un8gRKj4ZlijqPaNBECcrRHaQSNQLYM57xKIh7xvoNhpNCcr/PEsY8Hf/1+zjB+x9agoO7jGawH+6snq+pyJUYZS728vMFhvyEr0HjotvP4fAF4Fyy+FkXXmz3CX0JAhUrluvLaqCkHVQbKx2/X2og4js3cqJeq2XV5bGasUV6Y2dVM5KRzbDAy2SeUjGqkzmdz59kzsSfMIHtQ1zDPO/tYtA9JClwGcB9tLyPwOi3Kv5GJSMQzwHi7hT9Xtfu1Gr0Pd47uDeV3dECchJ3+0exEGx26xtyp6enXJZ5vNLZtWfyFrQuNjT2JBrrq3gCIQM8Js1VpRf6Ag0cPi18qlKKYLtVGYuqy/9FpuKa7to7NTxBHyzRrBcCxNEuhOT//dvakEBDgE
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(7696005)(6666004)(82740400003)(356005)(478600001)(83380400001)(47076005)(1076003)(26005)(7636003)(70586007)(70206006)(110136005)(4326008)(54906003)(6636002)(6286002)(2616005)(16526019)(336012)(186003)(36860700001)(426003)(921005)(7416002)(5660300002)(8676002)(8936002)(40460700003)(2906002)(41300700001)(316002)(40480700001)(55016003)(86362001)(36756003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:08:00.5118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 508d9403-924c-448b-5084-08db8d102c69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable per queue interrupt coalesce feature bit in driver and validate its
dependency with control queue.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c185930d7c9d..57cb75f98618 100644
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



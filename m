Return-Path: <bpf+bounces-5700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1093175EA2E
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 05:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06252814C0
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 03:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E551C3D;
	Mon, 24 Jul 2023 03:42:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8FD1C39;
	Mon, 24 Jul 2023 03:42:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3910C8;
	Sun, 23 Jul 2023 20:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV0NF+n57gn/kXZ4c+yviS/dLCz08jUcyYkLULs+zWcpgc6cKzVtxb4Cs0INVPAVdCmLuklNzpvd122cSmKr6Cel+YWdlyNDy8pH5gu6QB72k7RZmnkASyefaMWiKmtrKZYRlZ1S+nZleqYOUdLwjkMPzBvgENslxa/LCQ1uaMhv2L/Od/0pxwOgUXPo71I2Wpacdkvs4QYOj85dHveiCcPo4hpmk2QnTBzeSggvNec9a8bwsaFaJvhxBjDXqFs8mlxFevqmDT8ZDjVPfNCMxaCB78TFQghCK0KzttUS3c2j+mHAejksCrM2fuY99jiHm35VryuysLAKxClCIA9QqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuBoUM/RIGTCyYd/wQd3oZEgZE1JEa2nvlIobdk6q50=;
 b=DIAQnovMdpPj9XLg/eiaNt9tYzFaynnik6ymeUPrw50lsb9CA95VqEXTnOJm6aBCLDe29ylKWY/pVhSZ0qFMeqdwq4ZyzajsvZxgqFcmkurv+zXUxp1B10P/lFx0w/oXT6Be/1wprPBofiNG/OvS4FMyQWFG/6n2+d3QG0cll+tfZpNAj9I5051mbNR3txNOEV/72dito7HeOc/9HkTU5IbKFjhcIOt3wnRewm6E4IEBAYhvxwh5W1huH9QhNLrthKewnllotJXLgAPKu94Atqo3QauRTkyOJpxJ//jFgu785+tr86LnYgxYt/IRRrSVIIbeAXBkZDLU9N0Mla60Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuBoUM/RIGTCyYd/wQd3oZEgZE1JEa2nvlIobdk6q50=;
 b=qX+HqzG7IrLSfgNjpNklZ4pfIyryZjH98dICGcQOJDmk5zcI43yoOLce9AeJ5fU4eRJlkNUtGba76CSezyBc3+uyjiP50HQWzHprCWK6XDDPJ5Ru8erhETDObNnG7CuMytkmzrqjbkwgaNW09cp+ELnyLb6xF9t838N69WI9OEDCmwAWf4n8g9qVZjPhayb6o8KXw2ENhmi9BaXvCW077moPxfcDy6BmaXZ+PGV9obFcCa4kh0Y7Cgb4YYWzryi4uhtHKyw2q3AfIKvrLT/xcXuYwGm864RoRZnt3wF2KWE1x/4z2bx8Jst2cVx+MF5gtPC8DHe5XPc1JWvGid47SA==
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 03:41:46 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::36) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 03:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 03:41:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Jul 2023
 20:41:35 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Jul
 2023 20:41:30 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V3 4/4] virtio_net: enable per queue interrupt coalesce feature
Date: Mon, 24 Jul 2023 06:40:48 +0300
Message-ID: <20230724034048.51482-5-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724034048.51482-1-gavinl@nvidia.com>
References: <20230724034048.51482-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac3734c-8a1a-4369-efc2-08db8bf7e6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JX7x/o7TiuM/fzN8t655dQUd1YzlWg6lWcZpgZ1oiM6lK8ecjLXHuZXwWMPm3mCXj8o0Z9tKj2tHZrW2GdPBmVXHJg2ArTx39UflWplyrpKXskbjtANwi57fU+eoaEp8dBT+kk8nOxadAITR+8j99cM3w63CSot1ocNGJhIJc+EZ1Sjer0HjVVKolSN9p4ut+hJHvlcXwXl3k0VfNETUzx9uttBjb2UIL3Qveo92ofkMVhVgVwQ29e9qD7wKYwKRe+x1IjbFqaVTU1c/QHEyfq08xVXfPtAFw8qe7Jw15SS8Vkq0xXr76RF9GpUznvrLGcFEKvo7H1pHSejjBKNq7LxsmYXd27WuHBFvxmYOsp0VYQKBwBm0WFaI+c+OliwXH6gVbCMH4PIMsj35DWbz2tGZaUC2wyFxpBJioFUPtt9BrywRnZccOocdkygq+LqWpY02z+HmVAwUSHD+YSbcDYKG399gkXwys8qOR40ZDL0EWJwEaAxyVdVgRI7FzxsrRrm9t00z9Y+ul727Qv/ybZak5NyGW2HiQgFvf0tVVf6/YEkTL638DF7Y6RCgG6PCBrnmU62TcvDJ2ale/0SeiQT03FRxebrhKaavQZtZleT977drZITbXQscBEObYLP/hs+mNBzvWMqZbCw+2NGYRkDXZtiCqi/HY6XkBRoqyPertKtraZhEJt/M5pJnYlDrvvHjP1gG1sHqGfqB/tHfjrvIE9zk4e+Gs+hJvg/2srmP0ZwckMwvxQA6IaYxAEK0pk4fT3iqX34t9n4jcQWjeeGbkxwexZytHJxqsQYT+8eKn3gs47MEx/NffkUCBQjq
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(40480700001)(36756003)(86362001)(82740400003)(40460700003)(7636003)(921005)(356005)(55016003)(54906003)(110136005)(2906002)(478600001)(336012)(186003)(26005)(6286002)(1076003)(7696005)(6666004)(5660300002)(8676002)(7416002)(8936002)(316002)(41300700001)(70586007)(70206006)(6636002)(4326008)(16526019)(47076005)(2616005)(426003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 03:41:44.8375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac3734c-8a1a-4369-efc2-08db8bf7e6e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable per queue interrupt coalesce feature bit in driver and validate its
dependency with control queue.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0c3ee1e26ece..a03289da9f51 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4063,6 +4063,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_NOTF_COAL,
+			     "VIRTIO_NET_F_CTRL_VQ") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_VQ_NOTF_COAL,
 			     "VIRTIO_NET_F_CTRL_VQ"))) {
 		return false;
 	}
@@ -4487,6 +4489,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
+	VIRTIO_NET_F_VQ_NOTF_COAL, \
 	VIRTIO_NET_F_GUEST_HDRLEN
 
 static unsigned int features[] = {
-- 
2.39.1



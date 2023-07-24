Return-Path: <bpf+bounces-5710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2442375F41B
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 13:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB3028148A
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630D53B8;
	Mon, 24 Jul 2023 11:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE77B1FB3;
	Mon, 24 Jul 2023 11:00:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FFE188;
	Mon, 24 Jul 2023 04:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnCSK37jUq3n17ioxGaRy0/38B9VfBBKBMumkQIem0MXykl6Mqsg21ZEcAweXL/KKclnTA7II7ge3ybrNmP2CR8rlnBxn51qGhJsQ5zFH0XQ0YhbDwY97pDI1DQ2CECriwn1VqypbsNakWIH0Uxaycwjnuuc6kCcohfs0pjlrr4cDrsXK9bZmJnay2IyLLygcrn/RdNyXwwl0VEGLHUk9iAq47vLRBMKwLLxtazUFcNLlf+syD+SBwufaoWrXIXSDfww7HPcgR6Q1z6HTs5ozfGrHPhkhwDSLD6cY3X/WTE6DkrKRwFtP9N7P0Z0iSMuby76UMhsDxh033l4+NUhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyl6LSvWNJb75Qn8xJHJno7i/Ly/YaQwavEI6Dnhoo4=;
 b=DvVFzshQqQqavY3DpH1QA6XpxXRzNNlFoi1tRbzunZcEQ9aUiEaHgqkgf25k5XtVsVXyaFC2eKaHOSTQoSq7Q+3onJAhMGNbhyL8QpOJkBGWoZgZ4HJYRb60qdN35W+u1XM3wq0VJGyNYKR2V40cd3RGJ653lRIPKtHxCr2mJPJCcCHZthQfBfBfMk50UvRCETCVCSs690r+ngBFs2OTZTOOiM2JD5JfTF2pcr0Tu/Xvqyz7JBdEQJBtFT/ZbqoSQ2H4wYco0exF+8e2UlYuYlKEWxHf1/0f7Mjtoqzky2Yj9tLUJhODWx74Z85qODxmjn9XjNE9xmx+EkP7JBFlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=syzkaller.appspotmail.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyl6LSvWNJb75Qn8xJHJno7i/Ly/YaQwavEI6Dnhoo4=;
 b=nXKHxN1I/h9LsmWUxxZPF2CoF9dJNW13KlyCRtwhZM7qAb3+jHcptGKHS0Jj8ZFxnOGHsTNa2JbuszLdjRExAMXJieIxg8w6d615Q9KGHmcSUxXUwsvsMSxYO1ikKqPHoxX9/ShB89v0zE5OfXfWs4ez3HaPhxoBrrC0usFMjop8CREHqdaGqPbZAigdeDniNKPIqe5W7uJIKgR3OW5dlsMvrgDDtUMRCEERG9ZCzHkdh3N611EddizkWcK2fao6axzDqK1KTCYZ4ix8f1MFJ/6cXrUd2P3K6zxA3GJeGcNYFPpL0gaYcjpnNPTn1JBjwAxKyAeVPOfU820eS58sFw==
Received: from BN0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:e8::33)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 10:59:56 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::74) by BN0PR04CA0058.outlook.office365.com
 (2603:10b6:408:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Mon, 24 Jul 2023 10:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 10:59:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Jul 2023
 03:59:43 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Jul
 2023 03:59:40 -0700
References: <20230721233330.5678-1-daniel@iogearbox.net>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <kuba@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	<syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com>,
	<syzbot+b202b7208664142954fa@syzkaller.appspotmail.com>,
	<syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
Date: Mon, 24 Jul 2023 12:55:40 +0200
In-Reply-To: <20230721233330.5678-1-daniel@iogearbox.net>
Message-ID: <874jlta82u.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0f6976-1a9f-497f-fdc7-08db8c351dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aYlixYjszCbEM1iXOFNxR8F9ozAO5yVAWIUiwr+1IkwXWwQmhhjTklmbcBuVU6yCi5luxIkEv8yaoWR0c0ct4qhFNnwZbxIvV3BWUYe1fbhAclVO/UU9BLElmWKCKnefaZQ0EysfNgLWXceJzGGTkpDbxon9Ny4Sv86Vt0wV6/+xQ+iLmSAlr31ALZzVKm3SVdYanybBjMKTTFDLCjTZByv5aOohi18lWAiomBE8VtPPpvilp3I2gqS9DXbQqRoHpD82nMWzsvQDLGgL2LiqxXf40v/xGu/A4zZl3AfPVHuxkXZb+/vum5HhFh9rSYPuCRymKOM6nmJbtB9JSnsa/SOo0UywH8VAwDdryeB2bDeOIAIWxtANVukqQPp/MbZWxfWa+C50RO1DE9M71mn6B2TlY28DCWGuQddezuHEgr/3L1Rr/JmNu8vIcm23j1WsvMMcZBVnfdJ90xAymE0dHzdk7e+n+EPixJiJvRHQtF5jECMHlNrz20A5/73VKbneCwYVJP3QeWKLmMJGubUl1oD3sH7cBoSNaGrPtM/v7lpVJaWbDyOrvNEu9knyGbR1TKU4l1ToDqt5r6RFn/5zShbxsp7wgxBzKUYNrmnbPd0PW7onLVgeleILu2ZO77fKwdUdvB+/NJatM7mzP6kDCBTqSszBssfkxG3jEtRc/ytGgjHXQq2Dl/++es39etO32eTtZO5XJxRp3u8jBQoaJDnlTtuHvLdhviwde0UGPK7T3Y/rzFZ7oqAhHQzW9k4m
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(7636003)(356005)(40480700001)(40460700003)(36860700001)(36756003)(426003)(2616005)(47076005)(83380400001)(16526019)(8676002)(8936002)(5660300002)(478600001)(54906003)(316002)(6916009)(70586007)(70206006)(4326008)(41300700001)(26005)(186003)(336012)(4744005)(2906002)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 10:59:56.2613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0f6976-1a9f-497f-fdc7-08db8c351dd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Daniel Borkmann <daniel@iogearbox.net> writes:

> On qdisc destruction, the ingress_destroy() needs to update the correct
> entry, that is, tcx_entry_update must NULL the dev->tcx_ingress pointer.
> Therefore, fix the typo.
>
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
> Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
> Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks!

Tested-by: Petr Machata <petrm@nvidia.com>


Return-Path: <bpf+bounces-6344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5DA7684A6
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 11:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08C92817FF
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895815BD;
	Sun, 30 Jul 2023 09:31:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5B1364;
	Sun, 30 Jul 2023 09:31:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879EF1BCA;
	Sun, 30 Jul 2023 02:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXmzYocq7vjm68NsGXUQlMc6Qn8iuZiKtdeshe9uk5/E34tc7FHsJx3ONJqQSSuZgA29tcS2J7+TDegFmm4AKhr9tMz8dhxvIZZpqCKgmZsERQ7KiNYqi/XxnhpzSRWEoPoaiwaBxsd+yY8322aOd/0laJbeGjWSn8SF6GPMn/XffJPeyNNT3K822Xx1JipvOJWQ0SEs4ky0dnI8bm/4wzMPPhL0OF3n2aV+IxKJ40dsqJJv5Gdbq5ojD77Gkb8cel6AQn1OvpkUy0MNGWDvq7YQ/WVoOFEQXiHCEAQTCguKwGHEHu7/yu2nLiuvi+q1e2h8MxPzXsFDoFS1V2HUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VdVglGIQz5usUHl1cVPy6GTioMumoH4IjqC7mHu/R4=;
 b=TDQNALwv0Ik8LX3Szmaw6Xrm1jCskr4EtTZ6i0CbJdgTfOuc8iYOEV8LugBIzpNYsTnJyeOqFyLkjKFy4jhBX5sXu+KNxv16sCUe+QQevlIVhkj28iy2zBj6cqxG1dGco5UJYljWQ7YzjHYgmbY0Vu4CKQHwa2vV8oC3HlvdY/oldXSQ1j5fj8Tb5hHnCUU6yPUOffgoN9y4kprerT2PHGQJXvVTCV4vGwj/24ZISTw1t1cjKbxFgfG991UW3BTFZqDHq+aL7u55U9aBoCENcpnXl4Cg4Xc0RvlfmANp87MahIWKS6PaGHyJX54g1b/+ZPfNWThu/knKe+8OMYrvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=iogearbox.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VdVglGIQz5usUHl1cVPy6GTioMumoH4IjqC7mHu/R4=;
 b=REuSYkqGrba+Ib8GQU1KFbaZ7UOaflJd7w0hnQvoR+1xz/AOnMeM0d9IiFkz8HHVBunCGT5BbMRXefxehuv/tmOfsJrLC4Xm64w2vn2jRbBAKwA7cceLWhAMthCk3fQUz0vxTEz10pQm3v3yZpNdQjFqMt9haWoawo0sILXwXnYVK5umceAPnNV/WN2M2sa8kRx+I+CUbibf+saBUboWndtSOYtxHFHRv/PX0yTd8mjQfRgQtDqHlbSU+IK9fUlYxmwFxSjrtaR4Z4OF7UzrcjsEZArf07UH5qrsxPmoZKwRAQi7zRbN9ZxnEpGgn5pRmLy8pbma+o9vTbCDyYoI6A==
Received: from DM6PR12CA0014.namprd12.prod.outlook.com (2603:10b6:5:1c0::27)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 09:31:47 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::65) by DM6PR12CA0014.outlook.office365.com
 (2603:10b6:5:1c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Sun, 30 Jul 2023 09:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Sun, 30 Jul 2023 09:31:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 30 Jul 2023
 02:31:32 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 30 Jul
 2023 02:31:31 -0700
Date: Sun, 30 Jul 2023 12:31:28 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <kuba@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	"Martin KaFai Lau" <martin.lau@kernel.org>,
	<syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com>
Subject: Re: [PATCH net-next] tcx: Fix splat during dev unregister
Message-ID: <20230730093128.GA94048@unreal>
References: <222255fe07cb58f15ee662e7ee78328af5b438e4.1690549248.git.daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <222255fe07cb58f15ee662e7ee78328af5b438e4.1690549248.git.daniel@iogearbox.net>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 25240a6f-b5c2-4019-6024-08db90dfcbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hTG1JXxgqtLlZ3HByJzdP4SlMoASOGfznzxVnEtNVK6FJV3dtbTGnPdEkdLtMFZyLkkNAG1T7KkI92SSg2gfBDri3e89a8STPP3xzkKlccYbNBO7q9cqwcNjDdJ4G+ri3I+scx4hmSUny7WcaaI9ON4sykk5djJIdOz4atgGPTbETRyjFv6xlFyTOaAOHle7StiXNbXmHxq0JN1VsHdIRBceejmlP8GTzDZhPhuUdzUZ8/euPkC90XQWZtUWNqphBXBw/KEkd07i9hVce8Pb2Lgny5c5YZFWuwIi/7GFgdVRbq6E6henenXs88QrsdiFEQMxe5DHLAeMNE51KmWMGz5RrAaK4eTgZ6I8gxixDxkale8bRWNDXgY5jkC6zGg9PvVKH1H9MhEAysI2E9dC4BQ3ywB98cyy2ugRFIQXeJyO19zm8l8KlN/QgcblOl+VBOUo4g1ch+ecEKEvS6FHwIuhzpS9coAExZ42gDHPt87hsnHFZ6XeU7MbgM6JpdyOilobH+gCapTp/I7wgaR5NJRzugDGW+4z7iGdjc88nB6w6omVFadvv70vy5mYVpuM0rTEPb3HaV6IJubP0/iwjOsv6Ujf6X8aQVWJfg6AZ4BOwj17Jf1tznTgYUhxLppitFOJ/hSFCgOZAOE+k8WonAX4twZTCLRBxb3XX1SyeAd9emAi9EN6CxAVTtQ8kgQ++hZX/BMLGzlhtY4dvCgnKQkDxp7d79YC/NroHb8NPMp9LA/E8Tf2k1KxplRUP98a
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(376002)(346002)(396003)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(9686003)(47076005)(36860700001)(16526019)(40480700001)(40460700003)(1076003)(26005)(83380400001)(186003)(336012)(426003)(33656002)(70586007)(70206006)(7636003)(356005)(33716001)(54906003)(82740400003)(41300700001)(86362001)(316002)(4326008)(5660300002)(6916009)(8936002)(8676002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 09:31:47.3304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25240a6f-b5c2-4019-6024-08db90dfcbcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 11:47:17PM +0200, Daniel Borkmann wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> During unregister_netdevice_many_notify(), the ordering of our concerned
> function calls is like this:
> 
>   unregister_netdevice_many_notify
>     dev_shutdown
> 	qdisc_put
>             clsact_destroy
>     tcx_uninstall
> 
> The syzbot reproducer triggered a case that the qdisc refcnt is not
> zero during dev_shutdown().
> 
> tcx_uninstall() will then WARN_ON_ONCE(tcx_entry(entry)->miniq_active)
> because the miniq is still active and the entry should not be freed.
> The latter assumed that qdisc destruction happens before tcx teardown.
> 
> This fix is to avoid tcx_uninstall() doing tcx_entry_free() when the
> miniq is still alive and let the clsact_destroy() do the free later, so
> that we do not assume any specific ordering for either of them.
> 
> If still active, tcx_uninstall() does clear the entry when flushing out
> the prog/link. clsact_destroy() will then notice the "!tcx_entry_is_active()"
> and then does the tcx_entry_free() eventually.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Reported-by: syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com
> Reported-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com
> ---
>  [ Sending directly to net-next given the issue was reported there by Leon. ]
> 
>  include/linux/bpf_mprog.h | 16 ++++++++++++++++
>  kernel/bpf/tcx.c          | 12 ++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 

Thanks,
Tested-by: Leon Romanovsky <leonro@nvidia.com>


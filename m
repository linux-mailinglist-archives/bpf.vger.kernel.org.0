Return-Path: <bpf+bounces-67258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F8B41A87
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FAC1BA1BD0
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46CC2741CD;
	Wed,  3 Sep 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b9QT09/a"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A7726E716;
	Wed,  3 Sep 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893032; cv=fail; b=iXBMFXjcMo95s1DrMFEUi3/+aiOEJ2U9Vsq3SrIXMWkfpBfWtDm+81CF7CUaS+hPpVJYB+b2YdlqL9rQg97LARjOUJoCDtHnseyRDBVTehhUeq3Kms3Hbe8gJLpmZVL8+N+8QiwJcMfJaCoBjSweaZndgNc8VcT9L1rKsxXkejI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893032; c=relaxed/simple;
	bh=tSLYycDjmw/DdczIewznbWmb2NhS53Emgsy0YAXoTL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SDoYFRwkCkGqB714WiOwwN+iPZKp7bcwXe40j0YP4rQI6FnvTHeSIqoValQ0Lg4RFg5RMP5+h93NMIOMBjUGUSdWMyO9fi9De/+XLFh/hvtZwoRYQjRVDO3yQQ9kZckclmbwb1EalK5BvI5MeirRq8JlwQFrBNPn2a7JGQpT7Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9QT09/a; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJRQZseca6u+rqrmryoY5ICNbY7cOWFd9xnNZU0iDOi5oo6MXNaL+TLKFpRARIvZZM7toBIosynuMD0fE7g5rEM80lYfFeHo0UX5fYCXp+C+CV8BTpk4whARiURz5VkJiAIgEHCGgAcJLniwAyILpVP/jUkdgdlMMYilCUW4pk0yftH42nWyHtEHp2SOrF9WINuoK6uDyz2FmgRssxqNyKaHS6csffVgaFc/V4WUnFAVLYX7abBF8qpHRez+VQ4Ts//BZK6RrTShDoBy+xjYJK/UXC/1edAyVeBzhB5+DnwvMbSxaZ8BGmfWDSUCL+aS+3fNIJiBCj/F1Zy4uBevLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tVMhc9bsCYQ9LlN8gDAxSftKX6GDY8y8YOrqyAiEv4=;
 b=ynCsyoEjFpYz38YI6f2g7vOJ6pI+qQQAaCyTaeClApvwwS0xXZRly1Kk+YklTuzikdaWx7smPJs1Efaxkjhb36QnhwdhGWqsP5aadgUqygJxJmpeuk1dXcW8yX13N/WH82G0WYTZ9l1gPVrpAbMEMu7ex00M0HBf29n45oi1lT2Hq6uj+pMu7RL1mUVL7yWCVFc3dp5/wGZ/wl1uzQhdA+qxakIXXo5SHNX+Uqq/QlxHo8i/dIuxmzGmbsS4hJJ/JN+rI2KO0Ka+5K4l+JIevLKa1JSxBe3opdZNDevdZo1M5TuCJ+ywFwU0LW6cobhN1CF2EzsOEoZseojASjbCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tVMhc9bsCYQ9LlN8gDAxSftKX6GDY8y8YOrqyAiEv4=;
 b=b9QT09/afc2Ub4eEF8OvIAknbJXKvRcZSd3OPMOb4Hb99JBzhTyJF5fToKY+s2zFBHG/17DUYB0eZGaHfla8qBS00liDd+iF4KxAGQF0KH1hDaArVfqgnY/vLoH67omDXI2oNhFMtluL6V7NoE37Yyfi/kjeriVuXlor94J8CKuieJRtzEsdlve8OTzrkSydNiwsKu5axUM/b7U050jTqId3dhiDk8M4J1WfL2K9yjT4FuyQG9Rc3PoQm7HaTiSKJygWGIp+GtnT4fDyO6EQBdWO1QeG9HgO2DEjMvG1+MtxrhaaHRvadEGz8d30B7Vl05SejdDPoCmWc7v029x4GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:26 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/16] sched_ext: Exit early on hotplug events during attach
Date: Wed,  3 Sep 2025 11:33:27 +0200
Message-ID: <20250903095008.162049-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a0f2dd-7590-4984-dde5-08ddeacf4f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TMoQ/n6M9DmN/Jm57Vl5/+cTnLG0B8UwozxFTTa1sa3y0CGxmzyqxUJunBxV?=
 =?us-ascii?Q?4J69hXIF2vD9xsSOToDsCZvVs1qiRz/yTUkrMstqslqAmqrGsoXs0FW6d8wZ?=
 =?us-ascii?Q?55ht2sZXV9KhLN1FaFH2ekSCSgIEhr8BVYsTcXHgRGJz/Koh1EtfkdQfiqhj?=
 =?us-ascii?Q?X++qSxckfR0WCtLc0fsmtUuIfkwDGzg71y93kpS9u3bwoH6+vi/TWqyQRwUS?=
 =?us-ascii?Q?UoZouADs69QHp4XNcwpkgzA12FMapZbdyJK+7Cx1iIT+eUNM3BvnjdUeBdqz?=
 =?us-ascii?Q?zTs2JuOqqALcIIiwaqJJ4cPKKlfzc4gRgO8fk6UnXmjgUkLz1LdZqB06sLmR?=
 =?us-ascii?Q?sq4rDak6OzOcENl2Q5xC1SG//Kquaex3Z8SavqJizuNhnzW5MtaQtMVhxG+H?=
 =?us-ascii?Q?9eWNbbc6u7FEguPgHtX6xqXgKQxiqhUM18ZHzjSCmD/9Lyvpe01+e1F6AvNF?=
 =?us-ascii?Q?x5aE5dIoijsJq9oQBuB0NJl5BpXw42oQ3PAXg9f30ysHBLwukGM8PBxY4gTn?=
 =?us-ascii?Q?jmBJeYf2KeJhSizKVVgGXnhKcBWyPYDk0W34G2XnagebKq7gFzrWkXcvARz3?=
 =?us-ascii?Q?B9awjs8+OEB/7XFi//jVHHxHSTv+jdKELDkdXMdS4e6PWWosIJd0iethv99N?=
 =?us-ascii?Q?IgTqcaDvURhE52rHBnbx3xZTIwz40PU9xpZL8Q5IC7nQC8kkykzMsGnxsYQ0?=
 =?us-ascii?Q?kf3TpBuDHxjUZb2OCt+KaPaUKRlolI7oOhOu14RtUfVf7RN/Y3666FCAXbZv?=
 =?us-ascii?Q?t+SI+w7qiMzJa0jjE+Ee6OCkDFiYDEb0QGZ/XCp5jwFCkT4AdtI8mLGZ9r6X?=
 =?us-ascii?Q?JsRMID182OSJFzYzYMffrfYsyTu9wT+5mH2mAd5Kw8g/hi2JgrC24Hov0iTQ?=
 =?us-ascii?Q?9EtA8Ab9BqW3IhkSkMqUOUVvm6nqn5S/z2p9byxRWCgjhiodlwb+V3dgOYpr?=
 =?us-ascii?Q?74EYx3Um+xoB9fbtEC3zGVKjwUZHDmRH5suIgf0Ioo93RM6E0m/yyRHkuFIy?=
 =?us-ascii?Q?nPXweK7pCcSjBsvv5acKxW1EjwgDov5apcqz5dTigeZpxiOvHzqx41M8Zn7Y?=
 =?us-ascii?Q?jbSSMHeP+wy0j3XdDtWL8J6ZZTBcYslnwCXoBqomTIQTBd9vHT+oWvaM1lBt?=
 =?us-ascii?Q?IK9Y4EjqcfX1vKta8vMCIuaALcQBD35PtUONy2CyYRuDniTDv385LwbgpAOh?=
 =?us-ascii?Q?W9K5FsO/DXC3tdJ9WMuJyyMqAIWkcx4Cf7ySGA58Z1EO+uQfqda6M7CTeHU/?=
 =?us-ascii?Q?93wB/Vp68Pgvt2QcGfUrAuPwUNi3G1Sr7VZfyC53jwodDbXvpNW+UPAU5LgJ?=
 =?us-ascii?Q?cvPZPTPOn4nrqV9K+3uMAsKfyRN4Aie44Oul+jL9Re13l2f17OZJJ27dAT0X?=
 =?us-ascii?Q?rZMmZEb9LRr+VSFNKoi+cyLODZgXedWBUPywWy0jDfuktCsvhpp7UBKHU6BA?=
 =?us-ascii?Q?fLnojVOsxe7nzyk4N2WFqy2zf9xU/QzufNovOy8qpLUK6lV1RM10SQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d+bGd2H3AhJq2P5rQgQjKfQqBq08JtE5t2ayx205pnafwEecQcJiTTY4USpM?=
 =?us-ascii?Q?R7t31V3z/m2RGIqlVvYmln6SjDepTO2YOW7YujiRUhN9E8H+Op/3OQsCBWz/?=
 =?us-ascii?Q?eFR2SE5ib/CWRm7+EqjUGc/Ugf4TDDOBIwAYYf6gTHG5kLtzDlKlutCOfOBb?=
 =?us-ascii?Q?BJLPCkExoOWQJJjRaqX9IkYwNjmTnZVscmvukxLEczLvqH6C7tNBM0PGWy9+?=
 =?us-ascii?Q?RYmUBxAHQZ/7zXrdZueqT6HW/knW2qjJmY2+396OGI3EgdOVNYmm0xgzWkwQ?=
 =?us-ascii?Q?Vn0hG6rOR260KudD/yQRRTyPmgUxzrJ73204JznNGFP4pjrAoJpGwGwOh+23?=
 =?us-ascii?Q?jdnBNJ0pQZPqYKL0opBZlmGSGAhg+ZIH+s/kFV0e0++iTprB4IEzTgPSaP+C?=
 =?us-ascii?Q?GcXKERPOOkmhSFIdBdBsu9N3QHNd7fC+udSVL/NIk7i6csVP72Phf2R8kHks?=
 =?us-ascii?Q?Oz7ga0jEh44YZDXs7lJyLNHTMnNRNLnNSZq/UrwX9KiUe/FfYEBN3QY/gNtE?=
 =?us-ascii?Q?jeEkrsqcXa5qEa9HtXRZ5uyBNLeMRk/Gwks1mJeGNQJU7xiTEvqTMrQ5ibe5?=
 =?us-ascii?Q?iuhgxAKeuJIECxUwSEGOr5RnJ57+pyBs+Yh3U1/cAmp2hB5hr9TukC+SclX9?=
 =?us-ascii?Q?157lWDjbMFkcv+ay7VcKVqN+aRQja5GuUXoZfWe302h1sP07z8ExcY7W+GiG?=
 =?us-ascii?Q?fgM5U7wWnJRDnyVxvzigpgYBQQUR8aOCPCsq5YjwdMYZGD6xpOlmkke0iA6+?=
 =?us-ascii?Q?CVHKNGhtOx4Avwelcadl4AghXBwqs/m327Q+xkvRMSRNVWTSDpF5Or1vxfyl?=
 =?us-ascii?Q?yc0w4gjl8GTHtYEonIgsdJMTj0qjWdycOU9SyS06oQOvAc/+j1LW2hjg3+IM?=
 =?us-ascii?Q?2Uzy8ZDyB2EPzWqy7kbnJ51risPmXn5/9C+tvK30YOgdL3NHk8MVrSd4z3lb?=
 =?us-ascii?Q?Jvx2q9Owci2zIrK7VGU3DLcW8sQBaBOOY4YKPMSEAe3O1Xs7w2kMSgV73tZT?=
 =?us-ascii?Q?Zj6o8vN96pGen+GC7c9QiErkRi++f5vLtrQr9wvjW/cKSZC3lY9vcgd9s2i2?=
 =?us-ascii?Q?7i8CmQbQb2XI+5qq2c5/kRAjPRfOXKq6G5ta+nlJtd8uhftgLUww1drGAvSY?=
 =?us-ascii?Q?nq3DSe2BjhpGpjcMoL1bvAqCstobVOXaUhdF1A8tLFjW8+jxKFyvpM/nbydF?=
 =?us-ascii?Q?UHCs5ohHkOcQPJeMbgUbFCprHs58pT9Li6MfBG0DS5dIxzD7pR4FwM4iZZBM?=
 =?us-ascii?Q?kXCgq4Zdmiba4PcHdAMwMuXxE2AoHrKPrsjvHKdaQAyZPReRFhQ5ByCBfH2h?=
 =?us-ascii?Q?6b39wKD6MPxyhxdSlQdzWDGxiybQ/o1iUpDggVa44R6fve92rp4dSUh/brdJ?=
 =?us-ascii?Q?eZ9s+NRNCaaJoV3eqx+c96w+AkPpTvRrHXEPXDpxpbYeM/NBV99uGKsJaXRF?=
 =?us-ascii?Q?y5BtWCLSMluMHCkASa743qgXy+IkSlfjcKc3g7IO31AKDYLoZT4ZijZvCUdc?=
 =?us-ascii?Q?dA4PRNM5OmQuO6S0a0aQJknrx4uTevKAngmnAstM4lng6BITjEAnAUmSWXwj?=
 =?us-ascii?Q?+9Q5QCJHkiw/PQFs9/5Hlc2WtV2tN24O/MdeV9Rt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a0f2dd-7590-4984-dde5-08ddeacf4f0a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:26.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Agfe/A/E2lG4cloqKDwy9bexsngP0oDV9dJOQjDlKq+Phrppy+F6JBPt/cTVX+VKZbfPSfVSjviLnvPBNgFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

There is no need to complete the scx initialization if the current
scheduler is failing to be attached due to a hotplug event.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dedc9a16281b..63d9273278e5e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5512,7 +5512,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 	return ERR_PTR(ret);
 }
 
-static void check_hotplug_seq(struct scx_sched *sch,
+static int check_hotplug_seq(struct scx_sched *sch,
 			      const struct sched_ext_ops *ops)
 {
 	unsigned long long global_hotplug_seq;
@@ -5529,8 +5529,11 @@ static void check_hotplug_seq(struct scx_sched *sch,
 				 SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 				 "expected hotplug seq %llu did not match actual %llu",
 				 ops->hotplug_seq, global_hotplug_seq);
+			return -EBUSY;
 		}
 	}
+
+	return 0;
 }
 
 static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
@@ -5627,11 +5630,15 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
 
-	check_hotplug_seq(sch, ops);
-	scx_idle_update_selcpu_topology(ops);
+	ret = check_hotplug_seq(sch, ops);
+	if (!ret)
+		scx_idle_update_selcpu_topology(ops);
 
 	cpus_read_unlock();
 
+	if (ret)
+		goto err_disable;
+
 	ret = validate_ops(sch, ops);
 	if (ret)
 		goto err_disable;
-- 
2.51.0



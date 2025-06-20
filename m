Return-Path: <bpf+bounces-61208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09AAE238D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 22:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B915169C2E
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A2234973;
	Fri, 20 Jun 2025 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S8xl0qte"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B01862BB;
	Fri, 20 Jun 2025 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451570; cv=fail; b=t0KlkV0aha/ijgRdnO7VtaouYfxMWqdfn7SCHT760Jwz0X+rsazz+YclfLiBVokkYaKFrjAzNJBD7m4DoOlGirlAWMNB+B0G/p6YlsFUr+3YyFXvRZKQiZ+uymGiQsaOY2dvT+Qlg9gum9MTwxnAtAGs/igNNlHLc3Ihk24E2v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451570; c=relaxed/simple;
	bh=GH58TuFqx2wz2gM8dhSiM/DgFmDIIqnFLET9DfvltFg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LYD+sQaBqSCj1kW388TK68UH/FdNDFBSP5VniKWuHPqCZvHa+mYmMFfNmwaFZOX/c0Yr+yAhBytycDn3jlgw2P7FDb+ml7UUfdvmGesjq82U7a49MemN+Xuv2OqatnMXf6bUx1kZHaC01IVdtIjXzveTMAjCV6z/sWN62eYrpMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S8xl0qte; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWBF7lrOKTLRqlAlxnwGpPpA7p4TOuFMW4rP1gz3uHysI58PSFrOIgVEuLZkRtzeXCfhYFIDv/si79HdIef2eRC5Zese22fJqYE9DqGZiGZYhZfW4wfqrnwi6qAMMJ3+RfM451OaJFz40W74MtS8HGYc4A/7gNjjzcEQBe15znAJlSO0ymJFPW1/qiEJMk+AST2Jkd9o8+K5M8GFAMmfMJjsv2wyK0wC+qsevDHFBnjXhXAVC05k6fw/f1NFDKZhiUxYZ6rFDr6JG/z2deb765tVE7AFgV/F08s4Rez5tncbC80lh5/O/6aOzx6psz5Siq0O03L2Bfh7NQp+krvLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Wvg5H3A/aefavaXx5k1hAAYxZqbEgWEW9YTQeI8M6U=;
 b=Q+MOT6wMdspZ0AdGJjWTa0C6eSIjjW1hNJ6aejq0GUPfk7eVqwH6pRnzVQKCqXt/MT7zIQXMnkWkdfp0rjMS3G/vXZ0BtgrICHGJ4b5vd2/KOvlJEY8NLcVR48bsa/lvSFC8eyMNM39nZl50161Yjurr9xeBaWOUuSBolSiWGnBZBOcqpH7rK+R3ynovo0qlzSZuXGsnTnUXqYjR0dAqm7AJVz4IFpI3fcfHb1bxiW6nzRoYDOHz71BZ/HYSIaS8UQ0/zkaAY0qwZCDQOUQtv5oEBc2rxznWZ+0F7Qoup6dtAzd4b3QKMugxoSAcEasFrEbuSQiWc5TK/LL2kyh9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Wvg5H3A/aefavaXx5k1hAAYxZqbEgWEW9YTQeI8M6U=;
 b=S8xl0qte8Ldtn0RcLi8JpMarZMInPknyAC9paT1GK5tvXZzDpuA3TcVLonqwTnFNuj7xGCe5tZN7Bcsjdo6SoutzUtXKRudnoQL0i4GX6YrixU1GMFXCv7S5u/soqHb400SwdwOpx+y1JsbJhK3iI6VeTRzV8OHXRPto4JpQzh16PWpLdDY65UfYUojEd0uSaj4kLUE3wDcURQpa7CTOdMsCwtjjqpAqDK6LPw6PfoLfXdsg/8cNLkf1sfcQ9uqHOsR9eAfwNiP1yLMN8SFa8ECnBbqi97ImH9vyHg17P2mc0yxxdngnjH9KFTR3kS9YGOB1iFWFi3H9D5vXBqDB9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 20:32:43 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 20:32:43 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org
Subject: [PATCH v5 00/14] Add a deadline server for sched_ext tasks
Date: Fri, 20 Jun 2025 16:32:15 -0400
Message-ID: <20250620203234.3349930-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:408:f7::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: be5f54ba-c4f3-4d11-357c-08ddb0399bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s9EoVFXm3pFzE/P67OA1OfBNFD8M1hEwVdjYzUFc0AxSCWkJRNPmYle75N4I?=
 =?us-ascii?Q?rb9AoYTVM0mYSUxEoTSTud95q6yY72hd2KA1KlST+xIdrC1sfqVx4UkMVkOI?=
 =?us-ascii?Q?eSS5tikbmjh0UD5aEbAemwyqVH0H1qXfsNounchG89EzmejWWpBQyZyDeqCM?=
 =?us-ascii?Q?X1Id8oPVDAmqymxmTnNTXOLyH73kXFNTAr0380oQdpxlYqbUeTIl5Ca2105J?=
 =?us-ascii?Q?kdlYSmSWYlLq3rcYEd4CWu5iIZXHX5OV29k5twPy+dHP+mTU74OBt3LYfVLr?=
 =?us-ascii?Q?KBWsEcyRt+p3l3p+ciuJhDBgnqMMgDT1QAwASvQnlhy4+jmsjzk0amC3JWgk?=
 =?us-ascii?Q?FjrrwbVAzq+/AZ6+Qf+SKFVncDeL/H2M79611L9+KPWgIMSB4DCRR+SitNJV?=
 =?us-ascii?Q?vaocHmRMAHlPetyB+lD8m23nbx9/0c/6pg4Qm+V/TgPIVCHCUGwNcVTaWLYr?=
 =?us-ascii?Q?iN635EWNi2zBrF6N7LTm/vA/iFeK0XPv9E96a7XgyNOXVUTyhhw7+494JxVl?=
 =?us-ascii?Q?QvIMtJV2iDk4/17yO3IzYHBg8a3y0tGdKvAcMB1XgqBWvh9Lj7ak5YNb6uuR?=
 =?us-ascii?Q?cb4k2tOdnn7HvO5ayWSaau1WiTg17EMtFqXkRqkbApzqFRBw3KtO3Pc5fafy?=
 =?us-ascii?Q?8XD91MgQtZDX50lHQTQbMos6ggfDyxaJVBZUkFyhpEKUaLdQLB+wbPa95Jiz?=
 =?us-ascii?Q?ZnxSFzoplyR/jymi2oa3/opW52q0RjcL+C0kWafTNuc3kWPoFgGnKTCjU6S6?=
 =?us-ascii?Q?ULd/gWu3ydKbxEV3hi/XT10K+32l5RYMgTCGwIMcyGJWrgJy1DJOcM1S/gzv?=
 =?us-ascii?Q?Kjo80xtfHM26EyGv6BBhxebaaZYxihIunAxT1kqMS6txxpsxxulGqbfQ8VkN?=
 =?us-ascii?Q?aumO4/y+Z4t0r2T01f6OM6TwnHFJn5waj28Vwiakcdt7wVEkqiQUFxBIixDW?=
 =?us-ascii?Q?0Ieji2LT1rBf9e25hSeR4D8jrMvvTANeH1V1cKj1+lvxGTqSkkV42U3Pj7ws?=
 =?us-ascii?Q?FCirXByveW19/PiIamYC8qCwsOA/loSCciEmTT+kkfCpxsLl0BSQYKd0M2wK?=
 =?us-ascii?Q?r2bJ8AvfMm2EXapTjydRkifBrBCmtjTV4JW325OvQAte54m2WnEv9o1HDN4u?=
 =?us-ascii?Q?TXj2+CQ3ASMyL0EYI8rs4jKmNn0wYK6QWHPuY5joALtaMn7FjT2UtIChe0Od?=
 =?us-ascii?Q?Mbal3B9H4mLK6Nr9gUUuGJcRADMJHpeWLSlzfVy1Sn1ciyGfjeB7YmmKqHr3?=
 =?us-ascii?Q?Zpk720XrxR71r1MePv4N5fqJZG2NVrylAt1C6DB3ic18jF1G1kl6s9YJvu0m?=
 =?us-ascii?Q?Zetxgt4J7agwnPv7TRDuJW1gzmmWfolNTCHiO187ksSW0p1RMGmIVBEa7RWg?=
 =?us-ascii?Q?Vp8dGOo9SexHhjQRnaPuRBX01IyM3yzeyEi+86Kl6PDRcwpWAEKugTKpwuXH?=
 =?us-ascii?Q?/BfDM/n+30U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ctsDCrUbVQG/mXEXsJMvATaZomv/0FyZJXbkKO+B0tF5sANNSLLKZ7Ba/qdT?=
 =?us-ascii?Q?IT2OQ6liizF/BoEPORvY+O37wn+OglzGsRdCgaJm+SoEWmYks7cqAzB/Fqlq?=
 =?us-ascii?Q?OjYeipZClAy8HE75nTAHlH2y82x8HVBeHAPC4tfWJUmAhkR0tFvoUHZ5PypV?=
 =?us-ascii?Q?BSZcnUsLNlCB9tBRZCKmfUHhcKw16bXDf0Aa623S+TDEDHUaZWQotGl2LtKl?=
 =?us-ascii?Q?EkIE7Ql4xI3X9aApYQlhTnooY/mPRlgNO447kU95TdDG6heTkmLRAUhLeg9G?=
 =?us-ascii?Q?VI58U3oJTt4lcWIZoOCy6lT3b8q8AqMEDgQh+piHKd5FrwqhmhIxjkINz05s?=
 =?us-ascii?Q?046WP3u9ZOEe9lArvOMHkKpOXk/+bH2UlV9v33jVPfJ6rFyGz7bE9CY+odcE?=
 =?us-ascii?Q?phxCwLRTxJnH3G3Sm/6myNchJCf7WhGDN9/TnJkOLOdIpq3l7rhFqfUgWzUo?=
 =?us-ascii?Q?TXvTLQuZmO94hIfBlMlG796wPvgceJW5Qjk7+hd1Oxjc52L1ATYAUO3H3EPl?=
 =?us-ascii?Q?9rbk/+0xJQ4+RF+lNf2Ss85kkvlMn6vyV4MJ6/LOPruc8XlqRDNJootN9/27?=
 =?us-ascii?Q?WFwwvjxJR+6dNIf2ZMHKN/dN/VOP+pOCF9GmPssOXVuzoU84tU9w2WAZMC9E?=
 =?us-ascii?Q?oJ6pxM/KuXV8JSWL5az7pG5zyoPRouRcSr8lTNntKFcFgyaGQ5IdHkri2qFn?=
 =?us-ascii?Q?5RpVWA/enhX0vqPhA0WRO4wDC65ezCws6F/8Ze9xtuMggYQ1nNlGe90YDLvB?=
 =?us-ascii?Q?xNmy2ZgyRunjcDu6rotTZKlNz0ILtWwThQf+eqJj8nZHdKb2LQgF6LMhXvX4?=
 =?us-ascii?Q?IzqQhGCep4yUlyUNQgbBY1QDkYMJRm7LN2pnb7XL7afTGGBwBaPlwhEM1Da2?=
 =?us-ascii?Q?DkN1nETqeyIAciyiVZ+Esbdxjv3ODH443DsU5JRJ1nFFkpw5C06862jXG9+8?=
 =?us-ascii?Q?X9TIYTs0jjkQvdPoc7oBDmogIdSQefiZxLN6GnFF0OCdK0F/yC5sh4FWA3te?=
 =?us-ascii?Q?eo4wNU+i3MuVnMnTCbQH1Ij+mUcXmEP0uUhcQ8R0fIjRfEoja7rmpEqtX+n8?=
 =?us-ascii?Q?SvLwdOVrMovNw17u3Cw+C9T7yXXCiuBgHm4P6nt1+1Hl62PZGjQSoNiHiSdG?=
 =?us-ascii?Q?Z6LdZeZp3vamatpt8Ugh5ky7KB97e5zTDXBANYHJViQzwOCAd3e7181oddxc?=
 =?us-ascii?Q?oUGAYLdBK7YbU67JkBWNortPJwEGoSln6f2x9kWtQcE8VIA3GSHrVqoBdJvC?=
 =?us-ascii?Q?Szk+LrHj/vx+9Bnmo8L4JKxlJdPdffD7zkT3DFR2ztsQeF+jHCGdb9n+mGPs?=
 =?us-ascii?Q?4cikasyZ1KCHWRy70Ffx0AUeTKQXFYADcAw65/RLL6q3owRQvzRTiWW02P3d?=
 =?us-ascii?Q?7y0N7Vdib9q7IMTEARQDT918OFpKqChxm5FfKv2MTqH3QY10SS5/iiabCPxj?=
 =?us-ascii?Q?9sKjGoNFtaaHfM1nLl4FTJe0DX8L+haSfrFjBjUzRZFtGvVPU5KKnMOQFw9K?=
 =?us-ascii?Q?zkNM269LhomV2OtGopoDLaRVzMxUMP9kzeL/FeYV9f66lqisl/WSvHYo9Oy3?=
 =?us-ascii?Q?2hKHLVsBruvkreWkDATKC9rZl/b5syRix2BLTzSF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5f54ba-c4f3-4d11-357c-08ddb0399bd7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:32:43.2041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2R6xj4yBm18PZ2zkFHO4tAD1YvgsqADC0gs3DHsy3RzAcZrU0OpyBzDcSpzrIniX6ogLg+Y+NrwfuoN0XvUzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

sched_ext tasks currently are starved by RT hoggers especially since RT
throttling was replaced by deadline servers to boost only CFS tasks. Several
users in the community have reported issues with RT stalling sched_ext tasks.
Add a sched_ext deadline server as well so that sched_ext tasks are also
boosted and do not suffer starvation.

A kselftest is also provided to verify the starvation issues are now fixed.

Btw, there is still something funky going on with CPU hotplug and the
relinquish patch. Sometimes the sched_ext's hotplug self-test locks up
(./runner -t hotplug). Reverting that patch fixes it, so I am suspecting
something is off in dl_server_remove_params() when it is being called on
offline CPUs.

v4->v5:
-  Added a kselftest (total_bw) to sched_ext to verify bandwidth values
   from debugfs.
- Address comment from Andrea about redundant rq clock invalidation.

v3->v4:
 - Fixed issues with hotplugged CPUs having their DL server bandwidth
   altered due to loading SCX.
 - Fixed other issues.
 - Rebased on Linus master.
 - All sched_ext kselftests reliably pass now, also verified that
   the total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with
   these patches.

v2->v3:
 - Removed code duplication in debugfs. Made ext interface separate.
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch.
 - Fixed running bw accounting issue in dl_server_remove_params.

Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/
Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/
Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/
Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/

Andrea Righi (2):
  sched/deadline: Add support to remove DLserver's bandwidth
    contribution
  selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (12):
  sched/debug: Fix updating of ppos on server write ops
  sched/debug: Stop and start server based on if it was active
  sched/deadline: Clear the defer params
  sched/deadline: Prevent setting server as started if params couldn't
    be applied
  sched/deadline: Return EBUSY if dl_bw_cpus is zero
  sched: Add support to pick functions to take rf
  sched: Add a server arg to dl_server_update_idle_time()
  sched/ext: Add a DL server for sched_ext tasks
  sched/debug: Add support to change sched_ext server params
  sched/ext: Relinquish DL server reservations when not needed
  sched/deadline: Fix DL server crash in inactive_timer callback
  selftests/sched_ext: Add test for DL server total_bw consistency

 include/linux/sched.h                         |   2 +-
 kernel/sched/core.c                           |  19 +-
 kernel/sched/deadline.c                       |  84 +++--
 kernel/sched/debug.c                          | 171 +++++++++--
 kernel/sched/ext.c                            | 120 +++++++-
 kernel/sched/fair.c                           |  15 +-
 kernel/sched/idle.c                           |   4 +-
 kernel/sched/rt.c                             |   2 +-
 kernel/sched/sched.h                          |  13 +-
 kernel/sched/stop_task.c                      |   2 +-
 tools/testing/selftests/sched_ext/Makefile    |   2 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 +++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c  | 286 ++++++++++++++++++
 14 files changed, 872 insertions(+), 84 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

-- 
2.43.0



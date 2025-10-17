Return-Path: <bpf+bounces-71187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D345BE7C7F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8609635C2B1
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81162DE700;
	Fri, 17 Oct 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nxrin5Xb"
X-Original-To: bpf@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473D2D94B9;
	Fri, 17 Oct 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693614; cv=fail; b=uEifAXdJz5QgE75dHw9d1M2ohvgg+PQ4fLHsiZ7CSvAxBrLsK9nnrGBk2Jab4n8Llfsdmexu64/uCzIKnoA7x23voP2pltXLk4VzQf/T34qr6jO6ZcKE6fzeGmN9Yz6J1pC2J2gUR7Xt5/Ykm4pdw5/dcvHCzpTW3q2HKwGLs80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693614; c=relaxed/simple;
	bh=wUpoYV6r1oUQRDN7Xd7TykJC4A2wbBGfE22sL3tm9Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQw1OPozJr61RUhq4H1NSl937eYWawZLUhVKFxid6o+kqD3Quo8FLiiGWtBhV5HQRIz4cKnxtSVIektgXRMxNtNYDwaHlOnV+NgqOvlsrLr9ATqaa66giy0FrE1B4u2X92qXscTiNW22+Ctco5CzGNrcfVeRNhdpOaPhZVE/rEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nxrin5Xb; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrJ2LIpKtV6321o4DzMuklP3kSU6sDXCJHtZtZIxjRv2CFkf0F6cnEh7VCNzmPZirxtZyseq0tKe0PPDJd3h0Yv6A9apH7sjddmaSrhbgbT0udAfJ7d+lWNEhl8RqdjvzBPTuJjndreNw9KwLqu9H45UeB7/QiTOP/SRYJudDmu6EyTysNjFwVOUVsC59scxc1ToiAOZOBn+9EPmPzdKrPFBJCgLBZJcNDW5MGmYpoieX5Vh9RBWrN0NPPo6Xm0A7qGc2Q0ymrXheYk8cgP7WsiC5BUfMiR3W6NmQA+OaYluOSHZ0kjZr8/ZPejxclpXzp6RJ+h5QYNlmnN+HvZYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9DZzkLrvI97Ga6jsh7GKRGPdev4waZjcCyTMg0mLsg=;
 b=JRijP6RZ3Xg9Rb/gsQHoJ5jX2xpDVpTj/DNIKMYITIutX1JlhlQUTEZBp2w4mKomgcDCXZENaPFgKNKsncmq6yTqv/5aDOh/tvt8XPTKGE0kW6WGfpw+g/LZZMf94ykr3G95CwkwkWUBc0JOf/hKdvuft8J51ew0jGUh8EE4MUjyYzov8uOh5JJ9jexum8Yuu1ZftdWDxheDKnrRdGTNPcuO4myQ8CipWgkiE0swlA4s9QIf0qeihjyWzhv9tSl4k/2qawySk+ppOAVahybaL7wgZqZ5EWEkilyiW4ho7NWtnQQMyxzvVgwVOpPqMp9axp81KPmCZhZQVkB8XCy9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9DZzkLrvI97Ga6jsh7GKRGPdev4waZjcCyTMg0mLsg=;
 b=nxrin5XbKEFDD0u0qUnWtWCEkXjsu3EYrwNXaiazT0hbSCvkGmZiV/FBQdJoOczhP5NTW5r+K3/eCBkiRe6FdBn3A2S8bUvIFa27F0l/u071Bwl83acR0ntB9+gan1gqCyMV6n30MevX543GKvRrlLmwiimKelDh5DNNAD8KYiP6eJBorwIR0sb1vqiVjZ9s6tAJWlVDmykdk6O84Gu9iqMboexhDwosC6SQGNX4jAqE3HCE7373n4Le4aB/d5P2kI8aQo333HAymFTHU2nf63thyv4MYq+OcBnBLP3v5rgzh6p4IT3nYJzHEvHM8H5intPIgsxLJmuBqc2rfk4DSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:33:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:33:27 +0000
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
Subject: [PATCH 05/14] sched: Add a server arg to dl_server_update_idle_time()
Date: Fri, 17 Oct 2025 11:25:52 +0200
Message-ID: <20251017093214.70029-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6ec6c3-dddb-4621-1a98-08de0d603a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tSPsTgHPmO79tM4euVKBeRjsvR8QyoJ9Zn19gGCwLvlJvn6creElFMCLeX8A?=
 =?us-ascii?Q?Onp+A/U/Erky/Bb/ii5r0pDdM5xlkgIjooFDBbfuBldQeP/qVb4ER+tQfl9F?=
 =?us-ascii?Q?NjYZx3ztSl9q2GjFJUKbfiUkA47Xs0RfFeIzQ3J0r6dcROWuGcc79VIVIgpV?=
 =?us-ascii?Q?NZEgQnhy5WjhzEuXmB5xJ28Wz4yKM31HduuT+E5q5eC1J+UtYvo3pKp7FDts?=
 =?us-ascii?Q?/7kS3xbXNyGGljtj7fM60k41RqcYM07eoT4Sl1GoFKHJi8rMZnudmBhatFNR?=
 =?us-ascii?Q?ue84vEmCnURV76k8NvDk97gY/UclfT1BOvX01ZDO4IT7LORZJMODbUT/inTe?=
 =?us-ascii?Q?O8aVF+o8iAMTknEVsZ9Bz6Txx8c8Z8FmCMaphkfP4UMjQalQV+XAA8V5bC28?=
 =?us-ascii?Q?d0hnvJbIxnJu7xQzLpfwncCPtjTwuTjTdPIWJ5ApMtoslCgaYxxY965qu2Wn?=
 =?us-ascii?Q?eC6TR5C5ifyygnrZORlNWZ3skhwU+YgyEqYSTBb28F2BidBkYEi8QIcZdfyM?=
 =?us-ascii?Q?9czZjthao9O/TLKMCGjXJmTWpoBq7U3wkpmm3RxSE2HljOnsWF8IoxQ8a5yO?=
 =?us-ascii?Q?TdjhjsEclFGLAcBEyw3U8FoNcO9+Kp/i6PP4OoC8MtQpYC+UHuzSFs9uiJBo?=
 =?us-ascii?Q?7UeyOcKZVVil7zpkJU85+3f4U/d0pGBLfPFUTggYVwhDzsDCT/CoQn0Blt8U?=
 =?us-ascii?Q?XwCBL1SP1KPNb9n4RTYsEAILmwLEA8UgeZ2Wcug8immsstCNe5AqzZdmQWEu?=
 =?us-ascii?Q?tJAUHWq8S0Gwi4OJPaweHqZ8lp7c6h8szlvu4A17aZ+PQ7S27dXcsB9vj0Uq?=
 =?us-ascii?Q?obZTKft/ULJvHMPR4dYnqKnfyZbUOxXEAmLpoYYFEp92dbMByUIrJ5MqR1om?=
 =?us-ascii?Q?swE18nrAWzoVe3OCbHUfA9udrKR5gR9biLcxsgQNT7kMLIDt6imvmruh9ymT?=
 =?us-ascii?Q?zROMtBshF+nDYK2rKegZKJV43a2rCshw3EDyg4fD0EofyLFF50NFypZbFsKu?=
 =?us-ascii?Q?kXlWyqaUXWl7RZWWp2ABVBJU6Qc+4lW7HRQOaffnERu+iKzOnZAWyXIh8Pzg?=
 =?us-ascii?Q?fksxJiLjzdnMPlupHridrpkRC66UnqerbykCGQDw5ebcEUCNzokFXYdZVAhy?=
 =?us-ascii?Q?Ev5KvzIsf0WmE6utotVEXOEPwkxzrmt3FuQy/dZUpBHLN1+xEDpMNQqGIUlY?=
 =?us-ascii?Q?1dg6oEejWfkM3vEnL+1GJO0kF7TzhZgPWZFhVvoboc3Ji+Fjwop5E4UHhXIa?=
 =?us-ascii?Q?QLxgbb7A26OYJUOPoqyzouk4UbNxlQ+tuSrmzxCQSdQ0Qu4fBY5mP3sQxSvd?=
 =?us-ascii?Q?vgl47ZpYDIfIPHRMMa/lgi1UzKQx8fV1mH+SU6DivHeZ8OvalKYguxyMFuw3?=
 =?us-ascii?Q?LRC1ZWiiwW+fuRhWwtF1ufn9EOLFXLoS0l7m5oBDYlJVzXLT1QJNK1tTsp3f?=
 =?us-ascii?Q?22/8Yygass9rX8zdkj8iH++zn5B5LgeF4DkfdNplRSFRFUSDkbycnCRS3ajP?=
 =?us-ascii?Q?cpOOaw3hXw5X3pE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RHfF3jHS3WRfZJc4oAY0+FcNLWO03ZBkj1b/nGDj3A0wFPirUzvYZOpCGCvS?=
 =?us-ascii?Q?CfMw9i002qWQ2x5+KXvoS7YJbTxQTYaPifKXTgxlQtnOkeZzvikqjoSyelOg?=
 =?us-ascii?Q?sqi1mgmUnpoF44iWCne7C+PGTZY8HE5BPUGAPpeDmx3l55OQl5f68xRtSrV7?=
 =?us-ascii?Q?Q32OIkulghymJU+vkOBtng1wkHEI3NmVo9YNaRgyKeWF8H7l8P6DCn++62dT?=
 =?us-ascii?Q?4R+Eu6FBf2FQcWjnu3X0b2KDtYXOXoaqHfsOoTycx2MCRxQudnfrDXfeJDTd?=
 =?us-ascii?Q?4kEl8ms+huoxHyT8z0KCILgK15JEtjYmW7+tY7pawiKbNepILmkbI3VUMoxv?=
 =?us-ascii?Q?tnGReYJGoDD8pI2OrcyuIQec4ZNznLLAK6Il0//fi2QnwXkcKVrwc3giLNBd?=
 =?us-ascii?Q?pWgu3JsJ0S45/84A11Rak57w6B8t3gTDfWS8vRA6Cm8e9haH3q+yEaL44Xnw?=
 =?us-ascii?Q?X7FjHZkorWmv1RTb4VQLMZvrwWalzKdmYWDl/gbBaLI3D5BX9x2SSe/ssuRW?=
 =?us-ascii?Q?zp7pPPLnUtw6lzBPBwbigK6WBoTIS7x2rDlKE2BbFWca0sCfIpJGjGOEeozW?=
 =?us-ascii?Q?8aKSKzkBWow6LG+pMNuAl6VVfci5t1XGagQdfBB+z8lOB/g3iuBk7TF1WrTv?=
 =?us-ascii?Q?P/SuViRuL0xqNrAFQjIiqcQlpGFWxWdW0uQUzxANbz45YU+QLZOj165gL4Kn?=
 =?us-ascii?Q?Ku2ZBIYICcsblv2uryamE/wMTZqO9PJo3hi+YLH3aNS0mBR6f7PgrEk+YWO6?=
 =?us-ascii?Q?+dbf4XvaiKqbO6lnyOazUcWYrWYXU1ry/zBbBtGEIBIbHPJJY2V0dHhJSFsR?=
 =?us-ascii?Q?UxL8cJ20c8O22EVb+csfcpUT9pydsQ7rhokE38BI/yuqOg15rn06/hstAAI8?=
 =?us-ascii?Q?o3LI+vcFN7t8F/OhOTgmjvjnidHv0ldtvyYA3mJNmNGiEWYjDPI/bE6ERiMG?=
 =?us-ascii?Q?0yVsWntx92qcl3yZZN9gY6mAraVq/TPCtKXxDSi1hphuq09LyfqhZzoY+mzT?=
 =?us-ascii?Q?/XZHmcSSq2iWHgW5BnnzaLLw4lSrbpNEffo7qaPuYaUMM/t64LscvQL8phb+?=
 =?us-ascii?Q?Uu2IT251CC7purfvFudMVIaUZZExSF+azsZ3YmlOf5ATVt1LJcLSNLPwPAch?=
 =?us-ascii?Q?dv2egMgcaM8blfUQwacH/9KhHP0Wz5U1p/mFptwJEbO1q+QiYNZiCKT/7YCu?=
 =?us-ascii?Q?YyRnE3+hXGOOCwhOlZdBOSNWiOP9y2RkyGoYPEhlz3YasbEVmA/Elwd2j4Re?=
 =?us-ascii?Q?e9Z1ZQj9Lu5rWut9m5FnUb39QYeGOZC2v00qLbDZTtUgRWSe/0iDb3u3e4Qm?=
 =?us-ascii?Q?PxQ5kX3qJ5AE7MDme03AahMlZgCH49CpHrxoqNUj+ZDV2CQhpq+9Pc8cjjJZ?=
 =?us-ascii?Q?vMPXH0DpEdWbWV9N2Ni2RNg7d7yB67mfxIG2sqTfdvoUwceycWASec1mlP88?=
 =?us-ascii?Q?5UDhjyZiSlLN+2qaFvggl3NeTVQ/UXZdkTrFc/54NbTKYq6pTpdNcdOyQ9OT?=
 =?us-ascii?Q?9J+cxpuOLYHtlLLV2quPhZlFBEe/AVH97rN7lIbGZrWh+eYyMPOjIhDWSorY?=
 =?us-ascii?Q?/+2iJwGrRgO9JqprfkotbJqf7CgQmt6a+SG+TEM/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6ec6c3-dddb-4621-1a98-08de0d603a04
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:27.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeLLc1QvRiy9IHK61RrQX7+1JrqjAT/Ga4AnvKipHKlezuBsOi4SmWjgy23DM1nB0ptGqy6czEFK3laNkNFVAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

From: Joel Fernandes <joelagnelf@nvidia.com>

Since we are adding more servers, make dl_server_update_idle_time()
accept a server argument than a specific server.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 15 ++++++++-------
 kernel/sched/fair.c     |  2 +-
 kernel/sched/idle.c     |  2 +-
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f2f5b1aea8e2b..0680e0186577a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1543,26 +1543,27 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * as time available for the fair server, avoiding a penalty for the
  * rt scheduler that did not consumed that time.
  */
-void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
+void dl_server_update_idle_time(struct rq *rq, struct task_struct *p,
+			       struct sched_dl_entity *rq_dl_server)
 {
 	s64 delta_exec;
 
-	if (!rq->fair_server.dl_defer)
+	if (!rq_dl_server->dl_defer)
 		return;
 
 	/* no need to discount more */
-	if (rq->fair_server.runtime < 0)
+	if (rq_dl_server->runtime < 0)
 		return;
 
 	delta_exec = rq_clock_task(rq) - p->se.exec_start;
 	if (delta_exec < 0)
 		return;
 
-	rq->fair_server.runtime -= delta_exec;
+	rq_dl_server->runtime -= delta_exec;
 
-	if (rq->fair_server.runtime < 0) {
-		rq->fair_server.dl_defer_running = 0;
-		rq->fair_server.runtime = 0;
+	if (rq_dl_server->runtime < 0) {
+		rq_dl_server->dl_defer_running = 0;
+		rq_dl_server->runtime = 0;
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2554055c1ba13..562cdd253678a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6999,7 +6999,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
-			dl_server_update_idle_time(rq, rq->curr);
+			dl_server_update_idle_time(rq, rq->curr, &rq->fair_server);
 		dl_server_start(&rq->fair_server);
 	}
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7fa0b593bcff7..60a19ea9bdbb7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -454,7 +454,7 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	dl_server_update_idle_time(rq, prev);
+	dl_server_update_idle_time(rq, prev, &rq->fair_server);
 	scx_update_idle(rq, false, true);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 63ffb3eafd05d..fa2fb64c1f3bf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -412,7 +412,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void sched_init_dl_servers(void);
 
 extern void dl_server_update_idle_time(struct rq *rq,
-		    struct task_struct *p);
+		    struct task_struct *p,
+		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
-- 
2.51.0



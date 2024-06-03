Return-Path: <bpf+bounces-31186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D87E8D8075
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 12:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B2D28373E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 10:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87F983CB9;
	Mon,  3 Jun 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gscbj5GK"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8224107A8;
	Mon,  3 Jun 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412304; cv=fail; b=gAO3+LyPHTQ5ocCadYB7wld1EPQidiZ4JNWtLT4F4eCa0K+WFxLZWzCqHDMs7VMOCFT0L1G3MoOD/t0vNMD2uZD3sRAnOrmi4wYrLTAzFKgFiy9nU9//ZlM1ZdSmaSTcmWjT5htaQghiuqDZiK2lCGUM8C1VSfL9UQ4ecg8WCyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412304; c=relaxed/simple;
	bh=h+CsfOjIBVLi24sMbVmhux7ZPD7E8uryebbbs8VHjGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UDKyJkI5TKwjFdBnZbrVDRTcrSiWunnbp5aGx87tb8bImFjCsKuRmK8JPOD1AW7//3NcQ2J13OHV4ghzRO18WvDdNTK9oQxumWuKqDbBqR9vuf3xY1uWfZjdIvYQlJk40frPhD9FuWuVK2vJWcaQGVWySjyMTtMbdoreSrCzeBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gscbj5GK; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFaS8PLLvXduldTq3f07zrlRz2/vUOw44qPVSqgbLq/uD58a6xntuXeV2D0RWSsXbJcXJeUP7aqemy+2+/S2XPtA09SQ1B/xC14nO5Y0A+HnmhdqQ6s8s0dMhFjC6ls4JT2ZjdVP54EvsTCJ4HW1qBDDCJd0VBbHyEw3xrTSvD9uYjYhTLTxuYHaVOU0bEtcoXLygnCgIRGNQeLOWrVG9Z+B8QfHdEAtUsBfwL8LtqMe59YUkesWjfZgs/VVlK5wT2jCP5gXNop5E5VhL2qz37eAh0P6RGihIxzGM1C0JsREQXWwHwrAkhBCzak9casZzOJAufu/4sVUjjH5y4XwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6QP6oGCF9zNG8nD2oSMKuX3eN/GxFXw35opZB0OI7U=;
 b=ju7tuDnSiv9vMHTxN2Lfy/v8VrpGPzmA/D6nqAvHDs+oekdZwz4giBCb5YE/hLdI0FWZ64/mjI5xytSx+I1kpeEprTkUuX/KVg3zYg0vOorGCwKa7IYcKipBMxy1r+wz3gCGWkUcqSY4qaoKo9QnW0968Suos/SHxNeKLwe04QsnNcSia7XXDZ8Fq5bKRd5AxY3kanEh1VAGiM7mSd37ks0xO+P595HJyMc+pNPQwM54P4Ncwb0mhrDMIx7K2jr5cM39UF6K0q/3kzebNFu17x22Jrxgp+E0pkfEYgU1NeQlCQflpSAW454fwg1R5K/P44zd9ELQeuNjLuoMDk0lIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6QP6oGCF9zNG8nD2oSMKuX3eN/GxFXw35opZB0OI7U=;
 b=gscbj5GKYHLKyosjA7KK7zRSlA9E9VXZnvk93nPdnalJ6WW+rtIAeCJtyk63X8Svu0N8q2gn4vXNIYd6FH4TDqHVHeDaKCPPoo6fFY00ye+Kuos/m8TDN3Nn0LZe2nTweOPPGW9bzmCMoMS/yN3UL3VqHv04POtSa7EaQ9kA+7JSTgAfgksyjiKTmP2/MKODbgrN5pAoniEnaHt3BfkTvjCXy04vhVtBV3QZpsOBZn5hOvt/8zlp7jKzmJjZOsz3WlelVmBAIAPmTdMn2b8N6nUM5BEggNWYvs73wuPl8mxPTrFbu96CZ3Hvu7UFhaAeLiuWH0dl2lb/CXGD49UW5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Mon, 3 Jun
 2024 10:58:20 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%3]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 10:58:19 +0000
Date: Mon, 3 Jun 2024 13:56:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	David Bauer <mail@david-bauer.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH v2 net] vxlan: Fix regression when dropping packets due
 to invalid src addresses
Message-ID: <Zl2hd4EcLAYlHZ9F@shredder>
References: <20240603085926.7918-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603085926.7918-1-daniel@iogearbox.net>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 4416e456-5984-472c-de3c-08dc83bc143f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E5zGkVKCsOUMuvdHjEfTaXe4vFkiGr25fptIJZA8jWdF+H6sHk5bJMvVq58V?=
 =?us-ascii?Q?JyiGjk7zGCPOJger8Qwe5qs1EhAO5oM3Cj2/4OOoTogSZ5jZex2vFChHHjCj?=
 =?us-ascii?Q?7X9sp+Jr6ECJtCUKG+SHXZnhPQ5fhHBcmrAXWr7HjQ3ipLnT6s+D0M31dsPG?=
 =?us-ascii?Q?7euyiApZmTAPEteIs6pAHzSEEiafXNJBj/+uM+FbxOkWkTGNXG6Ddmbpf7Jo?=
 =?us-ascii?Q?6ye+JC9I4vaylG5IBRwp6AcMZmSRA/zMH3dMoSnCgA4hLcaSvjjuRSVyh1MH?=
 =?us-ascii?Q?DvIxWvR2PVeSgG+EQn9JbHlKLtH4DRkNPp2pCVcwoDRDKSwkf9rJPiQljTOv?=
 =?us-ascii?Q?ttaQNuIBy4/hBKbgZLsNbjCnvGCPcEhl64U2w/Q8rb4tbcO/zzVtoepBevH6?=
 =?us-ascii?Q?vceSXdsghIENjOx+IUq95/QTNsOf29dw8qDdwMR+FUvn87rhqb7TPoRjtvN2?=
 =?us-ascii?Q?W/wLYcPrNf+K5JFWFcPP9ZWwuIzP+gJ36DYSIYmutO936fYzhsAwYhCfgWEN?=
 =?us-ascii?Q?2go1AewOf3Cugj/EEQACI0+r4Qxd8S7aFnpsF0EpWuaYeNEr6DCDy86E5voi?=
 =?us-ascii?Q?6GojwwCYdkghMBWg1ZXOkL3qIxnhYPMHRLkT6wWBZpi481fmzRZ8o3cCLhog?=
 =?us-ascii?Q?r9OnVFtQnajBpN9TbVqNj6xrdkE0e9x1q87cEeXp7sgCTm14hHbNsrNCX5et?=
 =?us-ascii?Q?lAXuB+o/+M8hpJSd1uZhzscyx+yguV1j9J+UvWq3CnQMjnox1rm7JmOC1iVI?=
 =?us-ascii?Q?jVr9G5mTeOZ6Zz8Z/GTceYMZzufWXn8ZtK7jE/jx7NTkWiFv4gh21iYUyaxS?=
 =?us-ascii?Q?AK+a9Sf6K+/X57kn3rAKW6U9WXRBkEwotLN8NBZ2miUtufxiLtPag4C4mh1o?=
 =?us-ascii?Q?7FtcEllAu3RhWJsX2yn7W/dHvUqOTefBcCJdBooaKfHckNcU2gZwggn+r599?=
 =?us-ascii?Q?Ey52zZhW51KCEBebMJd/22F7RT8HPSKdVpYz+sCZ9VVoSyZl6okluRcclYUE?=
 =?us-ascii?Q?vDofe3OKbdFNrrmQ7vMHX/oMWN2l/VBjLG8Mb93RV2chcr63FaQ5MgY1FFVh?=
 =?us-ascii?Q?hG6UU6vMV5vvf5xed/W/vZrJ+gFptiCLfjU4xJLGvs1i/8tvTxrhuflVyK33?=
 =?us-ascii?Q?K2AwIDcSTdIbBzwQUtS+uJBWM864tJKMDSfMq4DSGuD77pmnX/Ub9eJmRXNw?=
 =?us-ascii?Q?rWwE9Yc34P30R398sV0dnBc3b/U+bK74wXr3Oqt1NtHuolQier9bhpr6FmCN?=
 =?us-ascii?Q?jQL+qCHounG3Kb7uyJaxKo0zdQ/flCc8mNS0dFP4AQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcMIbC1wu7dVTN/MS2yz+lbCfTNjB4fechCOURTtxgl2gJM+lzt8sCWl0yRa?=
 =?us-ascii?Q?8KXURoYP3xPw1maZXeb4ziousWTU9s2AEGvMSaUuOHPxNdjjPAdvJk/7t8Ap?=
 =?us-ascii?Q?39KqYrb5ra2gPuPxfNr7+4gWQLvubHFySkongYkJ8n6PLw60MyJY3IbN8cku?=
 =?us-ascii?Q?Fp7DQt1Nbo020eVIdQx83h4cX77z4Jif2phGm4pX6z528wbtDLxxLJXMOBK7?=
 =?us-ascii?Q?4C+PkE/QBjpxaAni7hyd+SGWnNlXFyEUCpEEtFljj5ZICIuaL5z1IHHkI00C?=
 =?us-ascii?Q?oiazXOR603S4VXFVcOVdBljTNcKakkSc2YxcmuM18YGkSCxXkcIgUutGux9i?=
 =?us-ascii?Q?uaTNgPtNkG1WgRLl8G8gkoQWDyc4wI6uwYJpU7aEKPDD9TCZDgZMU/Sf82Ao?=
 =?us-ascii?Q?2VXSlfqIKjFzalhqXpBHVTO2sTULiLLfh/AgwWdaR1tPxeiC3GMhXVOJpOcy?=
 =?us-ascii?Q?JnkoAs1peLK+vCMToMLSGYAewYIlew3aCw6kMHTFi134TIboDHE88d/9ak9o?=
 =?us-ascii?Q?D8VAq40M34dPZa2MozTqvzScMe95cbv+d9GzNSs4fx6YERDOx9VkLBFmn9VV?=
 =?us-ascii?Q?tJVs8zFNggBJYpvbqxNI1ew1Pn+j1doJnXOkJnaDEeAN4TJYwRI4gPBOlecz?=
 =?us-ascii?Q?Pt72AEG8GmzMxidgpgJJXaJZw3R8eIRkU15U/X417TbWn01vL4PH/eRvLpS8?=
 =?us-ascii?Q?qfpKbPv724W6IMAa4dC7cWKZuzmvTHeAeRgvz6a+2kaydZtx3TgqbJ8PYet6?=
 =?us-ascii?Q?H6jhZDdt5I9biUrjXEyH5Vw4ZyEFQIW5u+tgH+1JzP2d47wZbK8zzb/Oor69?=
 =?us-ascii?Q?iQ/rDmGpy0yZkmo4RwwImbRfO+OxQXq02GaV4D4pVarH5RjjIbXtGn38RB7N?=
 =?us-ascii?Q?QMHokGtHAVvHB1iIkfocqu9mO91L8hU+x9DkcB/6H0qZXQTLJseCv5vSntJ+?=
 =?us-ascii?Q?KhmJO+j/dTf6VWe4Ghru6VbqTxPZxaJy1A/pcygyfmwoB02UfMX3e3kiXoI8?=
 =?us-ascii?Q?uqsFlMufEkKYMNZIAhGqJ4QHbQnSWuKjVPQ4uNke9kHDkzMWqHB1NpaExKyT?=
 =?us-ascii?Q?rV6U4pNeXd3j8D6eUQh0U0O6ar/K6n4E5V9buAzKU5vSPgZUkbM0O5LBT6G6?=
 =?us-ascii?Q?EyO77XPV0wcvhTv98ZwC61PY+xLOVKS3igaKxHA+p3pRB2O7rl/5CQyEgt11?=
 =?us-ascii?Q?I8YAMxYw58Hc82HulFYq5664OS0yQIX1vXBgFKXf3uQ1cZbg8l8aY5OSTpEw?=
 =?us-ascii?Q?JIPvkOe1fCF8bhZfeJObr+h0ihQ6ge6MuZE3Ba9CYIePHXttdnVV63dI4QW0?=
 =?us-ascii?Q?jQqG+D3F5c4K+Q9S5Aq6En3ON7x6Tbp2oureELXFLeLCR/Rg2lGxB3E+L2er?=
 =?us-ascii?Q?YwDy0mrnee56XCbFsYqzS4DaFBu3U+uY0lnOCT66EU0CJjWMuHVHHJLK8KDr?=
 =?us-ascii?Q?uAg0dHY3WWtBsx6Se6VPPP8vwcLhnG8j8Bb3Evpo9rUoJiQnai7V/ksmwpxw?=
 =?us-ascii?Q?tHHceP4XQshyNjurP8eJDLGm+XTR8HPv82O/z5lIDjpoFh/Opok1I53vkhP2?=
 =?us-ascii?Q?9S4ZOzqvTuRgZSsAoG70tsBUJa3rV8tn/riL8MkC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4416e456-5984-472c-de3c-08dc83bc143f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 10:58:19.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RM91ZtOJZA8r5ij1+Q88eni8YPs+ISUcAkmYiFtOkXi3nCxmfb4HOIczYQSyIsXPOeeqZT4SAHuWUZNErxToDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678

On Mon, Jun 03, 2024 at 10:59:26AM +0200, Daniel Borkmann wrote:
> Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> has recently been added to vxlan mainly in the context of source
> address snooping/learning so that when it is enabled, an entry in the
> FDB is not being created for an invalid address for the corresponding
> tunnel endpoint.
> 
> Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in
> that it passed through whichever macs were set in the L2 header. It
> turns out that this change in behavior breaks setups, for example,
> Cilium with netkit in L3 mode for Pods as well as tunnel mode has been
> passing before the change in f58f45c1e5b9 for both vxlan and geneve.
> After mentioned change it is only passing for geneve as in case of
> vxlan packets are dropped due to vxlan_set_mac() returning false as
> source and destination macs are zero which for E/W traffic via tunnel
> is totally fine.
> 
> Fix it by only opting into the is_valid_ether_addr() check in
> vxlan_set_mac() when in fact source address snooping/learning is
> actually enabled in vxlan. This is done by moving the check into
> vxlan_snoop(). With this change, the Cilium connectivity test suite
> passes again for both tunnel flavors.
> 
> Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Bauer <mail@david-bauer.net>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!


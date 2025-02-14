Return-Path: <bpf+bounces-51540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748CA35972
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C853ADD12
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53917229B2C;
	Fri, 14 Feb 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lrflX5JE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1221C18F;
	Fri, 14 Feb 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523334; cv=fail; b=JxX2H4hJBxTYwDQchBIgUSCDVNk+Vj450FvYWsw+ovgPdvfzKcyYF9Y/PYALSRrnO9rRwwBd5+n/ttYys2XPdqfGGnrTEtjA7I6xIJLuKe9dSysOAIM/JrKjpkS8x9Es4tphYliLEy/d0ibYodgzQzvZ3UEH0j/gFlUSDKgkbl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523334; c=relaxed/simple;
	bh=Rpbgxzjt8CyssOQwBCgeUxDMHEg4YoQzWyknf0HFDUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EY7qmAKFcJz22NvefEoaU1nT8LQuv6lrJpY3WNgyt80NLmC8E1PlnZBXWucmAbWX8DN6jCQcsjiWnx55Uoh4SIcYa4R4xmcxAPZwxOvPuKeCUoE8SFyizP9ysC6IBZQP1JpjGuqS6tBWqna5lP9kz2ivGfHyzsqgBLNd+0q1SEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lrflX5JE; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EElh5f4CsyKsp1jz2AVqT+jU5dVrapSLnc6P1Tp48my+VDRGmfQcSKkgQx/WsM8GUbfDtm/bMAK++/91jr3IKHY0ZUgrkprZwD4WzguD5zEyzB93e2ZMOkOeu5yt2766TZuFJCDHRjdJZVOa2pRVLtA5gfhyJElm+efLnsYNJISMzX6ZrULxqjKmJTDZB6zkihS6QToBVI4eoITWaWUAXYhMbPNEqDI/V4TIxdtdhdDLuTItXRr2BXF4Z8ZvP0saxleJ0UjwMJJowOpoCiN0QnkBU/l1NTnYzLSYSoP0XaTiRbMFUJKzL4Rz/Mj6dUO6Mu+qBawOaeSqhfWx6S4KRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwteY6edHaPuM1H4Rf/GEHf+/9c/Lp1qo5J+4QUo7UY=;
 b=RIz0w1UBndfuf/ATYJ921Ol5nGgLcII3rmzRFx9iC7Ys7YecA6rkYv1tnSGL9T1KoUBs1slH7Qk9Obtu+/FO2me3D7OkBHOZdkxc1Xr9oo/4us6H11Zt4S4AdFnl7XSO460zRMQVpRGHdifvFrJ8GE5sjiqWlLRK5Qe0O6XeqlnUysPnHcrNxKIKXbaiiFJnkM9toB9WhU1gAbBIwyNXu2mdJlGDDCl4na35MfrtGy0fQMHWY7NiSqsGU1gKc8E2LMVbiWj0+4dRqwH+Snz6uOPZlcDV9vNY1jxxkpydyY/8ojeL4+96G61Bivd0PqVv5mYvJ1Rkc5O8yF06N0QyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwteY6edHaPuM1H4Rf/GEHf+/9c/Lp1qo5J+4QUo7UY=;
 b=lrflX5JE0j16VkWY0NQezPTLvbcr5zJYQ1Qr+a5Pph/vPw6y1Vo5hBeUexhzNsED7jBx0AFzK2HuPZ8Ws77a9eb9ffI6R26pOvAOxuDqF1DB90ppUERMe8AV8pjZIjJAsyDjfjV2UAbNcaUCmSuMhJG2Hib5EaEHZ62cCHkdW0wBk9WNrTY/ur91AIi30eNK1K7E+4Rf24JL85PWpVLB+SAXm+G2Pzrv8RqOqReY9xR4CzXhyF4NeK7pxe1Do+2Ol4jpmcK2yawYJ54gfZR7B9KsPPt0sMQ/mL0RXatEHiMPCJXvjwZb2Tdb84KFyfhn3NRQkSEq7HF8hovubscg1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 08:55:30 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 08:55:30 +0000
Date: Fri, 14 Feb 2025 09:55:25 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/numa: Introduce nearest_node_nodemask()
Message-ID: <Z68E_ar8l7vNOxgh@gpd3>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-3-arighi@nvidia.com>
 <Z64WTLPaSxixbE2q@thinkpad>
 <Z64brsSMAR7cLPUU@gpd3>
 <Z64oDlh9vzvRYziL@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64oDlh9vzvRYziL@thinkpad>
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: fea5b032-cead-40fa-d9bb-08dd4cd55536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5afBrsdQO4OTCVj1N8iQmd4Ff5YhE5hgctTPdQ9sOOw0ZiYpcbox4/py4KYZ?=
 =?us-ascii?Q?wB4XGou2IKRtXuOYPV5YggwcNcV/Ka3yEZZIAmoksrL/YtppcS8mkC/igGD6?=
 =?us-ascii?Q?6h9hQ7VvcJISHAci9i8gxaeDRyeSi+wZOWLHlt4hKaaYONmwPi8j/eEuk8Gs?=
 =?us-ascii?Q?KiYBORq8T7UbgQRbDFczJetgceex9ReNcb5CFl/i0HfU/vyEBy2bSrNS6d7k?=
 =?us-ascii?Q?kD9HHkZ8zonDhidvKA/IXUS334SnNylDkyztELSz8MQtUvnu54fP7O9AnatZ?=
 =?us-ascii?Q?C+VNjju9KYH2QPO8rzUXQuwEgi1+uxdmV2gP4DxHFlFg6q2bK7DtJh7FnCY/?=
 =?us-ascii?Q?NBsdTyuasL8nVpcMWY9F7eEn7KwR86liLC/fAMxjciQGGPrtypIsVIjAXFMo?=
 =?us-ascii?Q?xB6kLPkYHZu95CouML9PHpTLpi8f8M4Lldi/g7w4ZBhqEIfOpU4J0j40Gm5R?=
 =?us-ascii?Q?RASKdhM2gLPRubYSh0j+Y6RurZAMS00mFB9OQ9/hLKaZsaq2FkEjpPe74KsG?=
 =?us-ascii?Q?9qpbkGsdSx+oOidbSuYwq9TvuFAvZWFoA7FH9HIPT+9VEz6UrjzYLilgUOhm?=
 =?us-ascii?Q?ZZTtgE5Aa4X/n9TpTpG41BRgI9ayaR1maarpuFiU/NavvoiqEdQEoEVGSh1b?=
 =?us-ascii?Q?I7RHsMAUwjkJejRoVoU4ESlQIoQSrL76bbkH3XdoozX3S3J7ggYU6p5fL22/?=
 =?us-ascii?Q?14+QL/6GhVqkc/CrBaTCbDffCuhO0kbYKoJZupiE8hyXf830IElrOMSf97EH?=
 =?us-ascii?Q?yAVQiGKbgc/LkOndU8iVryevNuiE0YG2x7lMA1K55gVQm/slqfUKHjRcYpe5?=
 =?us-ascii?Q?Yj0Gxqe3OmDxwzYFU7tFe1aqah+Q/bj/bXh2xAtZTF+U5gaZHPApa/PETvHH?=
 =?us-ascii?Q?3Sr6rY73b/xL/PHxHkhvR1C4GGX+iZRBHLgDlpSJ7/mahgodDD3v8lO8v6iZ?=
 =?us-ascii?Q?AeiZ8E5kEUBpqvrI08FG9TNt0vkkk8ooC9QJ7dA6IDgxjdzGZtIGvTXhAoGC?=
 =?us-ascii?Q?sz1lsEXv1AkbJtO+Iw9fG80ObxsQS9vo+tiIXMs/KUN8cYdO4R3U5BFbkwcp?=
 =?us-ascii?Q?yKW4odBqZR0BehYnG9TwYr377Sh+RsXSKsyQqmEzSeW5PUNInNpHBD/hPZad?=
 =?us-ascii?Q?2e7KoF+is9QshDsT6S7G13foCVaExRU4G7VetPZejzzIVSBwyD4R4nlIoXqr?=
 =?us-ascii?Q?CPdXNLL07xGgCwS/earondwYYnuf4LjUxb3scmPoq2I28vzVDbNbkwg5z0Hr?=
 =?us-ascii?Q?+SXP2Xrhh7y3+NmjfCB44/A0fcOO+oPgrV+2W4XFCF0Z9C0Oy9wX/bEUmRNz?=
 =?us-ascii?Q?LM6YZcQ5r4tO/ngP8jA/KzfUAyZTSqk4dvgYxiggyWPCOawV6YjVBDtGSyPA?=
 =?us-ascii?Q?GRZ5+CF6czGWjdiXgN2DIa/svq1S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EN1whMOkL7TsDfb7rEs48Fv3hgDcvtiy+IgCuUMZg+vhTTO17PAXw3U+Iis?=
 =?us-ascii?Q?nswgtzC05H3ElLQyNtul/ECIcc2qtSve42gacWdL4i5kBVvy+z4E+zkOt1rK?=
 =?us-ascii?Q?VQOrbZlPJbqVln6yT7cMsO2QDLQRvTLvrwJDYf45A1JgaEBVcKAv/wC1crg9?=
 =?us-ascii?Q?0zS2jO73eqZAvQrd9/apvMFt5n1Ue8txElmLLV6jTOkSrYVX/EauQEyqpufn?=
 =?us-ascii?Q?LeFMzz1PmYBP7s2awVOFckj0H7zGJEELfbxAWFCsvb+KluESN1YXi/Qhjtes?=
 =?us-ascii?Q?JRL3T3xPHZoQdrWGAgS7qQnI1KvSPB+uiJspaO/8TEYvu9682az+onRqOWsq?=
 =?us-ascii?Q?Zfh6wOjKv6auc8BU02ZCvgjGU3rJcEi1AA19s9LNzdctmY0M37PIvuGyt/y3?=
 =?us-ascii?Q?2sG3UmH3Bsequ/HKJjaiMQPeNjH6RJe5M1dpXaFKQniPnfIUfqKrymzygawP?=
 =?us-ascii?Q?9ecYq9l1fTz6+6Cm0/8gv5Q74pfkHNoxiPlN4B0elHA/UNTpGNfXBRf8+rRh?=
 =?us-ascii?Q?ibzH5V6lG/ISTtDKGwBKwMp44UPsWn54pmOONf/1HXviWqNeYHlT/SkEbYA3?=
 =?us-ascii?Q?LaWg03yF3CY2xnqiSv69K0SvbDKDIixQiwb+8td2Wa2LoXW2H4tyqRIOgfTL?=
 =?us-ascii?Q?Pt9vw2IRGVtdeJmqfBmG5rhALhU85RXHN3ZUrlm57/3iAGpgFZxEjrGTwQ9l?=
 =?us-ascii?Q?iWk0nOg895ZNwAjWwH9cML1dD33fHj6/zVOu2vKauhkslnxBNue+A9tMv8TX?=
 =?us-ascii?Q?5qKFGLWy5rV/jg0WeqN7++WnnniSdk4e15C2UYRlejO2SeWUI0FWMACRCdFP?=
 =?us-ascii?Q?aAFEbCPp6/6Dernz1rBetfqqwtQfB7VP5gv5YM7Z8sezKk9Xw7pj3QOQu13g?=
 =?us-ascii?Q?cqTrZ2BA8au2q8aV3BkLhVa9Txd+q1nF96JIdU1xwqQGg+4sJ4dPXSDB/7E9?=
 =?us-ascii?Q?4nCtwFYMRcesy3rOzH9+SiLeESZfYNIkqghS4R2SBFN/iukideROCLPl7gbq?=
 =?us-ascii?Q?fjut46eVOadLUMpCfLVBtQxsaPLq0pYaQTzhzs0d/0jQmKuu/5yr4Y23eqVx?=
 =?us-ascii?Q?NkYeKvvXHdXjl74GxRGKCGIRUClJwK+46O6EvdPMR0DmMYN29cznGP5YZ6GT?=
 =?us-ascii?Q?gCo1Q3MRtgjsz0LG5E1delWvxzwFCuxtohhCdJGZ+EhM7emFBUtfz39gC6tB?=
 =?us-ascii?Q?BLUFYvHXpXccLKWFy90rUOeJr5erCLnHqQcgkus567vPWsR4R5eXJA3IPnjb?=
 =?us-ascii?Q?jCPwA1YvOueLG8SxoM5LIbP2mXTn3TmDD+6ycP7AuXst38HFIVTsaCcTilAE?=
 =?us-ascii?Q?9aNgttJkhm6xQYZQtBMbY2sBpQCFquRmakCcQ9L59vq0o64LEYzoS2lMeJmt?=
 =?us-ascii?Q?dML7sh1OoTafbl1Sog9BuNfcTD2hNv4GQJctPzcdyLFt4af1FhvPxhdYRAYi?=
 =?us-ascii?Q?A5mAMW2e5T+Jq3AjkZEYDD0sbg8R8+njU2iT4L6ot3prswqm0YjdlHK2rS1+?=
 =?us-ascii?Q?TuspelUuaykQaOOkR2z+MOmVFFSsi2SlSVBuqjZWHbhM3gtUoZhe+RZP47+b?=
 =?us-ascii?Q?MJExW0rVwfG7Xb/WfEtU93l/s+PlcAPhLFQj4MPW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea5b032-cead-40fa-d9bb-08dd4cd55536
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:55:29.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3ksM0Ujwq42VKljkf5Z+iRZYRt5lhn71JQxXPysCjgKM3xCNHCcNv9chOopXpZAMA41lxCXMHOgta8q8vu+lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323

Hi Yury,

On Thu, Feb 13, 2025 at 12:12:46PM -0500, Yury Norov wrote:
...
> > > >  include/linux/numa.h |  7 +++++++
> > > >  mm/mempolicy.c       | 32 ++++++++++++++++++++++++++++++++
> > > >  2 files changed, 39 insertions(+)
> > > > 
> > > > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > > > index 31d8bf8a951a7..e6baaf6051bcf 100644
> > > > --- a/include/linux/numa.h
> > > > +++ b/include/linux/numa.h
> > > > @@ -31,6 +31,8 @@ void __init alloc_offline_node_data(int nid);
> > > >  /* Generic implementation available */
> > > >  int numa_nearest_node(int node, unsigned int state);
> > > >  
> > > > +int nearest_node_nodemask(int node, nodemask_t *mask);
> > > > +
> > > 
> > > See how you use it. It looks a bit inconsistent to the other functions:
> > > 
> > >   #define for_each_node_numadist(node, unvisited)                                \
> > >          for (int start = (node),                                                \
> > >               node = nearest_node_nodemask((start), &(unvisited));               \
> > >               node < MAX_NUMNODES;                                               \
> > >               node_clear(node, (unvisited)),                                     \
> > >               node = nearest_node_nodemask((start), &(unvisited)))
> > >   
> > > 
> > > I would suggest to make it aligned with the rest of the API:
> > > 
> > >   #define node_clear(node, dst) __node_clear((node), &(dst))
> > >   static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
> > >   {
> > >           clear_bit(node, dstp->bits);
> > >   }
> > 
> > Sorry Yury, can you elaborate more on this? What do you mean with
> > inconsistent, is it the volatile nodemask_t *?
> 
> What I mean is:
>   #define nearest_node_nodemask(start, srcp)
>                 __nearest_node_nodemask((start), &(srcp))
>   int __nearest_node_nodemask(int node, nodemask_t *mask);

This all makes sense assuming that nearest_node_nodemask() is placed in
include/linux/nodemask.h and is considered as a nodemask API, but I thought
we determined to place it in include/linux/numa.h, since it seems more of a
NUMA API, similar to numa_nearest_node(), so under this assumption I was
planning to follow the same style of numa_nearest_node().

Or do you think it should go in linux/nodemask.h and follow the style of
the other nodemask APIs?

> 
> That way you'll be able to make the above for-loop looking more
> uniform:
> 
>   #define for_each_node_numadist(node, unvisited)                                \
>          for (int __s = (node),                                                \
>               (node) = nearest_node_nodemask(__s, (unvisited));               \
>               (node) < MAX_NUMNODES;                                               \
>               node_clear((node), (unvisited)),                                     \
>               (node) = nearest_node_nodemask(__s, (unvisited)))
> 
> > > >  #ifndef memory_add_physaddr_to_nid
> > > >  int memory_add_physaddr_to_nid(u64 start);
> > > >  #endif
> > > > @@ -47,6 +49,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
> > > >  	return NUMA_NO_NODE;
> > > >  }
> > > >  
> > > > +static inline int nearest_node_nodemask(int node, nodemask_t *mask)
> > > > +{
> > > > +	return NUMA_NO_NODE;
> > > > +}
> > > > +
> > > >  static inline int memory_add_physaddr_to_nid(u64 start)
> > > >  {
> > > >  	return 0;
> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 162407fbf2bc7..1e2acf187ea3a 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -196,6 +196,38 @@ int numa_nearest_node(int node, unsigned int state)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(numa_nearest_node);
> > > >  
> > > > +/**
> > > > + * nearest_node_nodemask - Find the node in @mask at the nearest distance
> > > > + *			   from @node.
> > > > + *
> > > > + * @node: the node to start the search from.
> > > > + * @mask: a pointer to a nodemask representing the allowed nodes.
> > > > + *
> > > > + * This function iterates over all nodes in the given state and calculates
> > > > + * the distance to the starting node.
> > > > + *
> > > > + * Returns the node ID in @mask that is the closest in terms of distance
> > > > + * from @node, or MAX_NUMNODES if no node is found.
> > > > + */
> > > > +int nearest_node_nodemask(int node, nodemask_t *mask)
> > > > +{
> > > > +	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
> > > > +
> > > > +	if (node == NUMA_NO_NODE)
> > > > +		return MAX_NUMNODES;
> > > 
> > > This makes it unclear: you make it legal to pass NUMA_NO_NODE, but
> > > your function returns something useless. I don't think it would help
> > > users in any reasonable scenario.
> > > 
> > > So, if you don't want user to call this with node == NUMA_NO_NODE,
> > > just describe it in comment on top of the function. Otherwise, please
> > > do something useful like 
> > > 
> > > 	if (node == NUMA_NO_NODE)
> > > 		node = current_node;
> > > 
> > > I would go with option 1. Notice, node_distance() doesn't bother to
> > > check against NUMA_NO_NODE.
> > 
> > Hm... is it? Looking at __node_distance(), it doesn't seem really safe to
> > pass a negative value (maybe I'm missing something?).
> 
> It's not safe, but inside the kernel we don't check parameters. Out of
> your courtesy you may decide to put a comment, but strictly speaking you
> don't have to.
> 
> > Anyway, I'd also prefer to go with option 1 and not implicitly assuming
> > NUMA_NO_NODE == current node (it feels that it might hide nasty bugs).
> 
> Yeah, very true
> 
> > So, I can add a comment in the description to clarify that NUMA_NO_NODE is
> > forbidenx, but what is someone is passing it? Should we WARN_ON_ONCE() at
> > least?
> 
> He will brick his testing board, and learn to read comments in a hard
> way.
> 
> Speaking more seriously, you will be most likely CCed as an author of
> that function, and you will be able to comment that on review. Also,
> there's a great chance that it will be caught by KASAN or some other
> sanitation tool even before someone sends a buggy patch.
> 
> This is an old as the world and very well known problem, and everyone
> is aware. 

Ok, makes sense, I'll just clarify this in the comment then.

Thanks,
-Andrea


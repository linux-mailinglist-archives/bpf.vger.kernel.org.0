Return-Path: <bpf+bounces-65659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845AB269E6
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEEA3B45E1
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD51EB9E1;
	Thu, 14 Aug 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F4cJEQgJ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A918A6B0;
	Thu, 14 Aug 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182559; cv=fail; b=IK3Aw4D2FnlzoRAY1GUkU36MyRk6OXVI13OYgawSkrA23D773v8DJCly83KO8PgRdoZSBgH/o2MaG4PYFp7di61+XVu/3vDnTvoXdRsI2bizndUqOofZ66RVwcm5rs4oQyBfEBxtLlDai4gP247MGCYGxMVKjxyWL6+XK4Q7cqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182559; c=relaxed/simple;
	bh=JiHwm/IVp+HmzAVips3P4Cje+b6FofJH00pZdPABHTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5TSDl+Siw+64vfHXQ6W4+9qBDcWM/O+/BWOkGEwshzeglbmIZH1mVe0GWhT4BbC9FUGlnJv9g11Xdr80jBWLvoknCpnOA2ydpctDq7nifo0bfpzVnc/fR7W2NqtxTP8SjHTNZ0s29m6p21AhEaIDcfy09Pa/X9RgsyFgVcTues=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F4cJEQgJ; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prvBJsou+dJIMjwmP7pTnZ5L7joTcCiA9LjYT2cqmpoLcukOc3+2PS5/w+TvbnbYOEs0NTcC8fJTJidg6GqsHR0CO4Mb4+E6cJ70zFcNfYIBtugLgasuwQ5x31LgVs+nvmY2xSG/9zkJ3GcGQq8yzfpORXU5MX9lVj+i3K+g9Y++3pGrhmlMZiUJqAQzK5b4mIDR9XHGOTHeMBTkjBZmUYywhojr7KqnS8B9aC5bQWv9ZCpR9QEiD25iWbT9l1/YHTyMLXnkNRW53ni4B8WPILf5SLG1yx9UsZiQobFYLQn6FqWHaXWQwsxQ8QpQrtyQctyQ9k2J50y6xkaq3HlErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3JyqorZBNfT/JfG1K3Em0EWmtD5jaQzU/YULuql5Ao=;
 b=m4nWwugroOO11ZKcYgiyMNuNYU2pJ6MKWYPpGwDjM3jwrlCYNYslbEHZkBo2Z3nuYQoaBGQPPkXfI+cNV1mUTOJ/Sh7j0rvqPqpxI9TQcj2P2LB+mMtJTSnkfDgyX3x77AdjFqWUVRL6SGeUh5LHGnvz1AcRP8Yvmq8I6DejUHc4vfTvidhjWvmbjtuhehROqbXVf+F0bu4RM/MK5D5xhoM1EuUIIst2EMwdiqmrjSdJX/Ay7iVSl/RpDm1WSgw1prPMrcUFhenMzxqlLSWUS7IaMee9vy6Cv/6qKabWYR0U3swS6AxThCU14ipaNejZgXTMqhWE5CIipSQJkUA9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3JyqorZBNfT/JfG1K3Em0EWmtD5jaQzU/YULuql5Ao=;
 b=F4cJEQgJ8Pp1c9gCIcwSINSPFQS6DM7d4LsRvldYCOXwSmLJNfWTObCucGCdNgAWc0NKdPmk7n2qd3/gs5QCI971yPHSaprWN2LdgQIB2U6CwlVGNoJnE81zhtlGuw8XxujRRRbckfCLh6JwgQXDSXXFbyUiBkjY2qZIvzP2/TzuZG0PiwgxpNnq9/hPcvKP6SgU+rWT6lptW4wQn4LRn21AYpDLenu4hDca1HdUOuwpg7H3Bhh8ZGUBTb061JUpxCKfC2QrqYyJQzhvnGAsAQ8NgMtrLSzKx+5ATIBY0SI3lmyXm8WqTJuRPx5jJRVz9h3QN1jTau2Za635BqTwXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 14:42:33 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 14:42:33 +0000
Date: Thu, 14 Aug 2025 14:42:26 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
	Chris Arges <carges@cloudflare.com>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>, tariqt@nvidia.com, 
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Simon Horman <horms@kernel.org>, Andrew Rzeznik <arzeznik@cloudflare.com>, 
	Yan Zhai <yan@cloudflare.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <tyioy6vj2os2lnlirqxdbiwdaquoxd64lf3j3quqmyz6qvryft@xrfztbgfk7td>
References: <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3>
 <aJzfPFCTlc35b2Bp@861G6M3>
 <5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
 <4zkm7dmkxhfhf3cm7eniim26z6nbp3zsm4qttapg3xbvkrqhro@cvjnbr624m5h>
 <e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e67fbe-a4f9-436a-fde9-08dddb40cd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2y9yf1/GbOmpZd5ac53EN803hn0zzEZJj+bwCZntzjKTK6o+nAcDDNmwv+Z0?=
 =?us-ascii?Q?pF4ZDsVzg3f4TFaYjhXYCL2rFAH1hsGje9vWrkHCizcKyDnhRjBLDek5Ft5h?=
 =?us-ascii?Q?tTp7zrzbw0AMIDdNbFoLfLlhuo0NDE5XnrvtQmtQ82/yCOPnFcwkN7OlRw+q?=
 =?us-ascii?Q?wtRkPTtmp0A+r0nWYIkdAuzQDNohqY+qqVe6XEIKv2I28nH0wPRXfbw7Kv/k?=
 =?us-ascii?Q?givt+lgHqxfIkQQxOxprBkSfN3CylC9ga21USD3Q8bq6w57a8ZMgsoamPlir?=
 =?us-ascii?Q?RgR1t4jAQPRFrVpta0Jchbom6ElK+gcWfZhXaaqO75RMzIU1QmbK06aoCioL?=
 =?us-ascii?Q?4aFGcBjAsQrxo/5vtPuq2Ek31fvNDPyJ92A1oUXuepu1syc43QpSZ58fs7Yo?=
 =?us-ascii?Q?gzcNXxQ/fTE26+T4wAprjlnNbXJuWHaJB2xs8znLRLeTaDRfJjSS2P30jd3/?=
 =?us-ascii?Q?Ie9WoRUl9KdNc3/76+4B3vieotU7PkNDMc8KlsCLZWnbPYir80BZTPwoBPnF?=
 =?us-ascii?Q?mArxx6ZfQFqedRHQiAjqvFXtUeMeB49zPBunipY9B1f3PBZadalj94VfRqNA?=
 =?us-ascii?Q?8Pgxu4nsOnBHXdtvmo+wzipVugezlUTgjkZ8brPxWm5TfuB9qxVy2molhBt+?=
 =?us-ascii?Q?81Zuq7Cxd+YKxiqqiEoXIwMqI7bvzWm047IJJw0Sxha19eMbv2Ehb/BYLukD?=
 =?us-ascii?Q?cNdnqrRko/rTuK4K7pISGmT/EU17vnlDuKBf5xMyXwXMcfLhuJSJoopZDXqH?=
 =?us-ascii?Q?h/V8KShOCjxV4Lvoo7iAw6iqBxOPYCfg2ATQ8rNuNo0AtzXDb980T9jGdu8k?=
 =?us-ascii?Q?wfW9Mt26CtdKXqmONPyLttz0Z80sWITGAIIdPxjCl/0jfmcFeQ+m0D3rsGmp?=
 =?us-ascii?Q?PebRqFkwgx6Az2f9jV2hel0XzGCOPFkd6NlK8P8hZf5/DbYBcLlIqXd2ZfMi?=
 =?us-ascii?Q?kAEWjw1nxY6n/w/yh4ytvZ52yGJkUz3+zY55chw0+TVIcueh8iIiSowhiRFP?=
 =?us-ascii?Q?CAZUUByL8Sn3YNmVUmuJN5qtX13vmtNksLzyJird65XhbiIQ8OjyXcBflEA/?=
 =?us-ascii?Q?jplZyPzxAmX2TUN7/I65IYt/Vy54xHGlLoInMPJCifGELaIkUQPFyueiQlYo?=
 =?us-ascii?Q?bYJkUiD90d/aAka/Y3BIfkvQgxM3AcgRR1MSVbSy8ms7U9ad1pU3kWIObKKh?=
 =?us-ascii?Q?Mpmenh2a0iGX7Tbng8EggPEK5HQRgPjl4Vc/4fc4MWPFrkhihBWn9rh6nxFe?=
 =?us-ascii?Q?eXM37WPtwKnfNVlwI8LE6gYloB49byXl+UUQVfjilFVqn2D2i9Wt2m04LFSe?=
 =?us-ascii?Q?gagyY2BIuh/KH3Hc+6GEeLeEjF8v2MTz+ITN7chToL/ibYChvHGzpJ8lXWjh?=
 =?us-ascii?Q?KCgs7rtcslNSNl5EqG1CiNN8/OcBEJk4f0P2ydZQx7lBHpQuYGIjWLJchgPe?=
 =?us-ascii?Q?LwTI8pHOh3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80sLfYsP2A8otrpHa3T7MjALic3O6eGSFuGbT9Z7EM5IIO5K/RvucepmCsuA?=
 =?us-ascii?Q?P2opcC+X+U8/Hf90dvp29d6kmGGB83sy78Tiwe1CBPqTKBNrkNA/BR/e1/n/?=
 =?us-ascii?Q?vOQL53hkCUaAH1Tea5tVfSzv+M9lcuzTJs/GdlLWQiIpeo3UMZsEejjaTFl3?=
 =?us-ascii?Q?TmvWqVBwlDKGo2zj+wHouigx0ODFneN/197CB8ULh/33596ZPxqKMh/YmGtP?=
 =?us-ascii?Q?9gRY0r+JTHRRD3Q/S152GjEBFoT2q17qyBRFPjAxWU3/Won2uc3X+ojhtGGN?=
 =?us-ascii?Q?9EXm3GCtgq9DeHBgt7SoNVIeoPgIAyrHlp6SuZG+QSHhUuwjJJwhzSEvU/mF?=
 =?us-ascii?Q?jN9QMw+GvDd2s7pV64pc/CTfw1v7Ql8ycz3mN+mvU6mB/bD6F5X7IIy2DYrF?=
 =?us-ascii?Q?+nc+NvUo5eLAG7MmhjqDkIRUtLljRkPVjqkSJGsuuDv2g9p5uVyVsLHksRIh?=
 =?us-ascii?Q?eI6P8Nn/0vCu8XWMWyUP1d/JnILmF21Cz2o1SJfR19y0aR977BGThg7wi+5S?=
 =?us-ascii?Q?CS/acjczmjk3bgF6UmEONYBbUnTa+/7lhnH7u/4+PpKqP1pXtvbxijfDXI72?=
 =?us-ascii?Q?XGDBeybY1Po5/yoUo3L9lopFisf9MI8y58D9WZjMzDM5XrNjmLjJeFiahIkv?=
 =?us-ascii?Q?05qCXCmBR/ELi2J31ajPGXTRuJlbQ7qVX7AZ199PsBTMqXXsVRQhdeGXMBI6?=
 =?us-ascii?Q?spfYR8xWy2cPFL/AzCfVWpKEU5uyTBaVrQE0ciO8VznZGNpvxFMzM9SQVZCL?=
 =?us-ascii?Q?yO30Rho501PGZi+Mezw2z9PahbfkftC0o07WBARABuaL4vQHc7q9BJxW+Ieg?=
 =?us-ascii?Q?/jdUpJtWfw/yf9pCQs3qI/6c2WXn37dIpjvF2PsiekeJdEHOIkEsxsh8DFQb?=
 =?us-ascii?Q?Eaq0eQOovwztvdZMrWOT6YWA8pMsXfQS+btko2jJ3UFg2M6VsSAnBCMcJaZq?=
 =?us-ascii?Q?tu96EhBGA//pInTRYy3RqgWKSMd0WK0grWjIKrjTHjto/NEF8pvJXFixjr8H?=
 =?us-ascii?Q?k36AdToPzIlVwMyPQ/SkzLGjwGHUoQPTWU7byHpKINce+Wkleh3zh8sw+j5G?=
 =?us-ascii?Q?le9vTt3OS9B2xErkaCkDwZkYCG+V7Z/OJUtkVKOR0W075W1ZJXVBLaP8sMpW?=
 =?us-ascii?Q?eC/pUrxpTTVZTIjNu67UjNukIkcLTqpS1+iCR5+fkiK6BO+HSx4w+6QT4aEu?=
 =?us-ascii?Q?EAr7yM+pH6h6fI6UB41klTqN4YQyRBg7XQbLtSyoERRdMkQQVPD1qCOcLvEM?=
 =?us-ascii?Q?DfX6El7QAqyjdK1xJXinghwieo6VoESnyOvvm1DQPvjjo/8v4aVsjyYjiPPy?=
 =?us-ascii?Q?ELhs6iyRwrf7tFxktqWZxKnE9a4L4JlzfmxE1F1C9JdZlqkwTgRy9rebeJV4?=
 =?us-ascii?Q?SfYWY42O0w/1AuvYfH8wIt/8d4Nusk3CUEAJeIexHX65aGmyeyyXHOj9q57o?=
 =?us-ascii?Q?rbbr9DGiPlfiYNbCylDHZR4DEnMAJt1JeHM2Knpco3l9ODSj9BF9P4rnY+n3?=
 =?us-ascii?Q?NdFx6PRu3jboFsvOWYBt/hjoT1WpvZKeVY0Cinkvywey2VwsyUGeajiM9IO8?=
 =?us-ascii?Q?B7/unWjfe66ryPZwT++qtHCcw8i90UF+8t4Au0Bt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e67fbe-a4f9-436a-fde9-08dddb40cd54
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:42:32.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K992O0zGsUI+1P4VNqO3jfrqihU+5oJFQQ9TSnGIuMIw/IDHKrhWDvwEdJ0eQXaVXT23wVLGjJF6gMeSVibqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749

On Thu, Aug 14, 2025 at 01:26:37PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 13/08/2025 22.24, Dragos Tatulea wrote:
> > On Wed, Aug 13, 2025 at 07:26:49PM +0000, Dragos Tatulea wrote:
> > > On Wed, Aug 13, 2025 at 01:53:48PM -0500, Chris Arges wrote:
> > > > On 2025-08-12 16:25:58, Chris Arges wrote:
> > > > > On 2025-08-12 20:19:30, Dragos Tatulea wrote:
> > > > > > On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
> > > > > > > On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
> > > > > > > 
> > > > > > > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > > > > > > index 482d284a1553..484216c7454d 100644
> > > > > > > > --- a/kernel/bpf/devmap.c
> > > > > > > > +++ b/kernel/bpf/devmap.c
> > > > > > > > @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > > > > > > >           /* If not all frames have been transmitted, it is our
> > > > > > > >            * responsibility to free them
> > > > > > > >            */
> > > > > > > > +       xdp_set_return_frame_no_direct();
> > > > > > > >           for (i = sent; unlikely(i < to_send); i++)
> > > > > > > >                   xdp_return_frame_rx_napi(bq->q[i]);
> > > > > > > > +       xdp_clear_return_frame_no_direct();
> > > > > > > 
> > > > > > > Why can't this instead just be xdp_return_frame(bq->q[i]); with no
> > > > > > > "no_direct" fussing?
> > > > > > > 
> > > > > > > Wouldn't this be the safest way for this function to call frame completion?
> > > > > > > It seems like presuming the calling context is napi is wrong?
> > > > > > > 
> > > > > > It would be better indeed. Thanks for removing my horse glasses!
> > > > > > 
> > > > > > Once Chris verifies that this works for him I can prepare a fix patch.
> > > > > > 
> > > > > Working on that now, I'm testing a kernel with the following change:
> > > > > 
> > > > > ---
> > > > > 
> > > > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > > > index 3aa002a47..ef86d9e06 100644
> > > > > --- a/kernel/bpf/devmap.c
> > > > > +++ b/kernel/bpf/devmap.c
> > > > > @@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > > > >           * responsibility to free them
> > > > >           */
> > > > >          for (i = sent; unlikely(i < to_send); i++)
> > > > > -               xdp_return_frame_rx_napi(bq->q[i]);
> > > > > +               xdp_return_frame(bq->q[i]);
> > > > >   out:
> > > > >          bq->count = 0;
> > > > 
> > > > This patch resolves the issue I was seeing and I am no longer able to
> > > > reproduce the issue. I tested for about 2 hours, when the reproducer usually
> > > > takes about 1-2 minutes.
> > > > 
> > > Thanks! Will send a patch tomorrow and also add you in the Tested-by tag.
> > > 
> 
> Looking at code ... there are more cases we need to deal with.
> If simply replacing xdp_return_frame_rx_napi() with xdp_return_frame.
> 
> The normal way to fix this is to use the helpers:
>  - xdp_set_return_frame_no_direct();
>  - xdp_clear_return_frame_no_direct()
> 
> Because __xdp_return() code[1] via xdp_return_frame_no_direct() will
> disable those napi_direct requests.
> 
>  [1] https://elixir.bootlin.com/linux/v6.16/source/net/core/xdp.c#L439
>
> Something doesn't add-up, because the remote CPUMAP bpf-prog that redirects
> to veth is running in cpu_map_bpf_prog_run_xdp()[2] and that function
> already uses the xdp_set_return_frame_no_direct() helper.
> 
>  [2] https://elixir.bootlin.com/linux/v6.16/source/kernel/bpf/cpumap.c#L189
> 
> I see the bug now... attached a patch with the fix.
> The scope for the "no_direct" forgot to wrap the xdp_do_flush() call.
> 
> Looks like bug was introduced in 11941f8a8536 ("bpf: cpumap: Implement
> generic cpumap") v5.15.
>
Nice! Thanks for looking at this! Will you send the patch separately?

> > > As follow up work it would be good to have a way to catch this family of
> > > issues. Something in the lines of the patch below.
> > > 
> 
> Yes, please, we want something that can catch these kind of hard to find
> bugs.
>
Will send a patch when I find some time.

> > > Thanks,
> > > Dragos
> > > 
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index f1373756cd0f..0c498fbd8df6 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -794,6 +794,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
> > >   {
> > >          lockdep_assert_no_hardirq();
> > > +#ifdef CONFIG_PAGE_POOL_CACHEDEBUG
> > > +       WARN(page_pool_napi_local(pool), "Page pool cache access from non-direct napi context");
> > I meant to negate the condition here.
> > 
> 
> The XDP code have evolved since the xdp_set_return_frame_no_direct()
> calls were added.  Now page_pool keeps track of pp->napi and
> pool-> cpuid.  Maybe the __xdp_return [1] checks should be updated?
> (and maybe it allows us to remove the no_direct helpers).
> 
So you mean to drop the napi_direct flag in __xdp_return and let
page_pool_put_unrefed_netmem() decide if direct should be used by
page_pool_napi_local()?

Thanks,
Dragos


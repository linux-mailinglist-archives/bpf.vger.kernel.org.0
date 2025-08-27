Return-Path: <bpf+bounces-66633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA510B379F3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 07:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6017B21C3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 05:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490E93101DE;
	Wed, 27 Aug 2025 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dD2clvtS"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366272B9A8;
	Wed, 27 Aug 2025 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756273302; cv=fail; b=EID0Xf/EXiI3JJoxMS7xBfHzT7ZJEBCp6NyQBMsyewRhBVjEJDcTYeUT4VY9+AT5ulvwlMGnzkhfWSN87WK25Zast7y1iJ67nA/TYuQLNAMW3vzwZqhYJDhaH1B28YVwoZ6ACueAYX0d5rYZ9WhqKH7xeI89Ob30+vYN5kMPOFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756273302; c=relaxed/simple;
	bh=Zu0pdS+vAhggpz65MonGFmZmRdxtCZ7DUiehvJMzNt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HprfgJjx5xePjydNj4FWjpw6Is6jHEFVXW/592GfmRManMz2LuJJChjbMdSQ1+jGlOlbSOkDWnrBxh9Y31g6QMpCq3Qd34oWlGLuzD08fdQO1inV4UYp1BoQ7gQXIo6ZhtIS13hp+0UL4MXX2bEQ5hn0ESmhfJqd9akPAizFTQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dD2clvtS; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjyaurFdeoRedYns7HYiaClRLmYanh0TMgvtG0ohXjl5EQQvWph0yja2xqU6w2U0H+B2g6cKJbTA4WlfvD7b0d9par19HP2CkDWPCtzZWS77CDaQwD8ZRiybimnAn9QhdKdqZap5SKS8RV+CcFB6BXsFoHCNo+TxId4JRS6A9dZEK5Zs+zIz5A8nNR5uCV8eQVqYz2yDzubqjrqjuHVbQ1Vqzn4uUDNzv4bZXfKfQioZ4MSZoeoWZSlgkO+sf9LaOz9l9vpECRZ0bjZOfVdZ0afVJiuuTLc7wyscOLEY+Fwz4U1fxnJfqX4gujmyP5DOVh8v6kfHj33TbH0H62HHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dkvp3R+r7xQucQLRKeKkZL2xYu4d3Lr1PT89L8FA1Xg=;
 b=Uv3g4NiFG6Clkq5a3/d4ues9kZh+Xl2IcjMGxAkkWkVYf+FjrBTDBKnglx9dbDQwYWjyv2Y4vDObYWtqGCpYH0kLvfK3ePiHX3Gn7N/jZcFCUjpcKXzrUhroSJL7AZMdhEloLQ9Ycoe7XNRX91sIr+jKcjNDSmGo7o6aWkV4djd6G7FPRbq+Iwcnh4bLigBirza1LeK0BB3i/LKFDGe3SJ8YJOUurZJrIxPKXhJmbJ/TiLTgveYd+JIpa9qwQ9zA8+Ry+NIO4MvSG3uS6v6edB7aBbQiNG7knOZNoc3gbvc8VA3gn2jZ0iySsFqCgVjp7w8Z2r3tUkBFbM37qS4C1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkvp3R+r7xQucQLRKeKkZL2xYu4d3Lr1PT89L8FA1Xg=;
 b=dD2clvtSEVdOgMo+dYO76uzihCQh7mLxgvbnz+YG/JWjbF+XL9Rat55iVP6aDKFgRJF6O+8qVWYfC4UuSFx7rqVqElKjs4sz+gVvPna3OP7LpbKWovPqz9sZI30MaXOFdDlC8bJ/Pj5+X9Cj77ylEiLsNX1j1CTBbwmcc1E5xBVlCkUPir8eO3vdA2NAZoGWPiyn0A3oRNgp7HuWtwYJnxvVCmmGSDuWyWmc5f/m+vIjTbejMJ4j0Zn8uRJyukw+hQzYUSkkyd3yEN0TRDyg22/oMVRGdlcBYWOrjpU2upryQj0BbMlLyQc3RXpYMGvdTh+1WUpgHh2KZQGUZPsMSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 05:41:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 05:41:35 +0000
Date: Wed, 27 Aug 2025 07:41:28 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Message-ID: <aK6aiEbgYaI9K-pt@gpd4>
References: <20250822140553.46273-1-arighi@nvidia.com>
 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f23646-6fdf-4aa3-6884-08dde52c626d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VhnEfMs837U4fhy1+w0NbVbqUf/Xz0kEUtsoFQfrwUoOqxnyrli92rIs3ax5?=
 =?us-ascii?Q?1zMk28gKHRdLGsk44BqwxF97adtP5so0pVvRpLUuQx6C5htq0JCpYcKbZxlc?=
 =?us-ascii?Q?KDsFklMFyUBkyaxIUVH9DcTnIgMhKfXOXbzbi6nwtW/gGL1QwC0drQnl0tPP?=
 =?us-ascii?Q?ZybiUeX59/rnQRv5MQO8ZU7U5sYBZWVRRkaROhJtsfPnD9VUJ/10dNKhOcFR?=
 =?us-ascii?Q?sECgW8ta02mdmNPQZKuKZveUtxzeHf8r+HFAjGRQ31WQPfqweY8vghWt4RLL?=
 =?us-ascii?Q?Ry0ppaCe3sBZ4Yv+zl/LWQ01tzJSNo8pYgjvl9PBCVlIdm2+mvr1277W+NzI?=
 =?us-ascii?Q?t6m1ucCJb/d/35fXJaM3lIz6ofA2obHkLWvNjL2AdL++Y3LAAA5K229WmBRr?=
 =?us-ascii?Q?1DUBNKbg2gW8+hixBxIi6lRefe3N4bET9QInZ31gcSYGWvVC8vubBv0P4cFo?=
 =?us-ascii?Q?pbNeHmlRMpJW36BL2yg+EMEKH+aCQ90rzEpYnJwfJ96sMDc0ZmFsqWXgLP9/?=
 =?us-ascii?Q?MKoUvp+w77gmAWbQ35HMwt1zO2KIRRMIrWemxoLY0MSfaZcoh0OJ8iHNBTCw?=
 =?us-ascii?Q?iJXkDmcWL8lm2SvIDPy/SURpHUG9GRUlB2v4WhcDFIjsSXCtq8Fw+YgfUJHm?=
 =?us-ascii?Q?9Ysshroz4sQVccPZGQqQb9+o1OA9HfuaAkzIh4+OwB3tVky+2+bEwiDGgbrz?=
 =?us-ascii?Q?ZwmHXhJsP8sqDD6rWJ8yW9OHq/SvQ0p6DNmT/nNDO1jwkpHtilK4VcGCU+wW?=
 =?us-ascii?Q?L9JQJRqtAYPAavvf1JyAY7y/atJjjwk8Bkj4GYYFy0SNUe0NuvJFI0bQXka1?=
 =?us-ascii?Q?qorUp115/tJA4P5DBYdd/Ih4FMcVJ1nHdP3/NYVwZjB44zRCoQhOAeXDBbAj?=
 =?us-ascii?Q?Dp+bDqphkV3R3WcS64VDS1mXxfOdBz4YQ9+RoA2WjVZRfceXAUstgKrMEL7B?=
 =?us-ascii?Q?rA3JelojLEd2MMAxbjvtWPWjS/5esFPmzzN/2L0X/SgFqkE+35nhmh0piDKx?=
 =?us-ascii?Q?0zxll4VSt1SYfLE/c3fKO6dePmEq4aFC7XsvVY3D4wMaucc4xbQVgM6bumOH?=
 =?us-ascii?Q?Z7TzRNH1UEzqZWVe0Ln5dYsXHaRTuqw8OMfelG6xqjqYU76/Gg4Vg6Tsc/8L?=
 =?us-ascii?Q?o/MW9r3yBqMeXcmcowgpdxGHetrH62JDSEhOgh1nPyteWQ1CpUDv3yzyBlBq?=
 =?us-ascii?Q?8IMxtVZHH6LXs67oQB5dDPe7WAmpcpfYfQEMw121Nx05nb6nYpPms8d/ktQL?=
 =?us-ascii?Q?4kgEeRM+BzSWf6TN1a+VtQqj7Mm4VEm0j9RZqXzsxgOV3ZoQnMWj1LSrY33h?=
 =?us-ascii?Q?xZx8F2x0yoB/ZnZvW+WYizS9Ep4/uQCmVTHrf5x+Txaf77PUhJkYW/S+HgJj?=
 =?us-ascii?Q?TEQzOkWAKG1uhWXjPFP2C9rfiU+rwjaUmr4VEnnpUrcgm4L9OHissdBOiF24?=
 =?us-ascii?Q?1pYO99hriQk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IX51uGrRNG8URI4dN6PRQP6TDx7U4AjDiRhTPpMOQ2KWbmF8j1GQ0yiav2Gh?=
 =?us-ascii?Q?gNYr0sHxuW7AlntcaYOqU3K5ARHIPqeYfIvRL7XIXTmGyNrBm4OvDhVloJYJ?=
 =?us-ascii?Q?Q9lHKqj9ky2Pf8RbLJrMTBfzgN7lgH16m1gFb8DWyccdw3efZIRWY0tVtWAM?=
 =?us-ascii?Q?Kgt/IElFVb+vsAHWtHgJ3V66xlIiTwOjWnaGd8iHnMCX/YjwVU5DZDVWA80d?=
 =?us-ascii?Q?WuCy6Hbbm0bkdTi9LspWc/l/9WM9kElpvrTATkddaxbRRtx4B3wqRxZ4N7vW?=
 =?us-ascii?Q?wM2z7s5AJ9Ps7viRMYhE8WTxg+FtjNaG6DjXp1thyDK/ZoSWYh9EZbjsipyY?=
 =?us-ascii?Q?7hbdJeHgGCAzeSxLnjH+YZeVmuQbuXZkKhc1zW8QBjryUFe46+rf5QXcGhYl?=
 =?us-ascii?Q?4cj4ypMh9HW4v55dRtuYK4YwC0u2KdW/N7MbUgJNnqXFSA0Lb5XVtoHtyvof?=
 =?us-ascii?Q?BNEwMrERe8XDVMAq0/lG7DTiqdADRvm+wP+d3HyK1I5gCzgEhivvtasGtV2Y?=
 =?us-ascii?Q?fH3GZHPvMffL1DVEKcxPAGSK6Sbo5vuAtil5PhQ0DWnm8pNIMvf7Ticj6jx9?=
 =?us-ascii?Q?/J4pkxdOXp6fYnqhH4FRkFttqwso6cc6Oy5Bfm9QKnJx8V9rp0Yog0P+7bRg?=
 =?us-ascii?Q?QDW1QEBg8Ag9sZWdyQJ3+CZFeizSEzJol9juhSWIjaClO4i7oj/SzZlaZLL2?=
 =?us-ascii?Q?89kWrUFfUcbrWm0lpAsknMovLK+DPKfso8VrsIkXHziNsN8QyxaYzwhLWIO4?=
 =?us-ascii?Q?4AFGj3YaQ91jceCAndNDFtRtXEI9RG3vrJrEa6KUNalnYwtQ+ncNgY6aRXei?=
 =?us-ascii?Q?L9CNEe42D36RoDl1I4+/pqNH76IcHnZqSBfWxLEWzccidx1QytZB6vZe5h+s?=
 =?us-ascii?Q?/7Os1aOTib0x2ioLhZuz83Iu56fiqISXDG0LkFjwpfjl9LV6ZhFAasVMfO87?=
 =?us-ascii?Q?ULhNjGiS8PJIDxcz60fXmcfH/1rddbp6NROkzOXcfZ4og+b2Wq22ZfFHRGlc?=
 =?us-ascii?Q?5tsEuSDz/Ws30Fg03SRTL/WtHbOHAMjgZDopFhgQrtwwtchjH20EuvzHIVJn?=
 =?us-ascii?Q?qiu6PDQVviWF9YoHSWz6efYG0ou2jlGU/Kf1nUzthzmOtGDE+wNwhmULTFXd?=
 =?us-ascii?Q?dH2b3PhQHKEX/dC3FINoP0J5BoUh+oJ5pwOvxXlb4WIUOXFLpFzWa9OC6qBk?=
 =?us-ascii?Q?RdiV/IpwcZJySUFgx27zPY/AFV55FPlCu7a1mwAmigZkCzgbCi6HGatBMUoa?=
 =?us-ascii?Q?J+HNt1XUchuuPGmj3GT4lNXuFrqGtNeEgOxAdaJSouU5aa3LxeZ/Z1S9zbwb?=
 =?us-ascii?Q?yCbJmbpjB6uJuYg3I6oCKtjVEMsyhwDJfkhUcuSumY0pyB4QPY5PiMxahmp/?=
 =?us-ascii?Q?vBcYLqFAMrMRGnGnL+B/DAv7vi1HFq37P1F/vhi35sqCG3kgYzfZ2hhEVfig?=
 =?us-ascii?Q?x6/O5WbbQNOZC+d5wIGYvEdbvGd5EwtvuLdZL18QCkrWQXE8nWK5M1NLwtwf?=
 =?us-ascii?Q?UbGwlwc11rwnx/xChZOw+NMNmnJ/dldrlUILAoJiTuwfzMZY8K+BBVjPWZwM?=
 =?us-ascii?Q?X+qkQkDp6b3a2PyN2DHU0oouPsRrPmfiEIdnd95B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f23646-6fdf-4aa3-6884-08dde52c626d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:41:35.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BetKxAGcVB+XSZkwg3rdn9mhfBypH/GJpV2s2CzfFz5QvVw/dQEnQUeKPo3Q2plzSbm6c9iAwbCkB4YSvdbtmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

On Tue, Aug 26, 2025 at 10:02:31PM -0700, Eduard Zingerman wrote:
> On Tue, 2025-08-26 at 13:17 -0700, Yonghong Song wrote:
> 
> [...]
> 
> > I tried with gcc14 and can reproduced the issue described in the above.
> > I build the kernel like below with gcc14
> >    make KCFLAGS='-O3' -j
> > and get the following build error
> >    WARN: resolve_btfids: unresolved symbol bpf_strnchr
> >    make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91: vmlinux] Error 255
> >    make[2]: *** Deleting file 'vmlinux'
> > Checking the symbol table:
> >     22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_strnchr.cons[...]
> >    235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_strnchr
> > and the disasm code:
> >    bpf_strnchr:
> >      ...
> > 
> >    bpf_strchr:
> >      ...
> >      bpf_strnchr.constprop.0
> >      ...
> > 
> > So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strnchr.
> > For such case, pahole will skip func bpf_strnchr hence the above resolve_btfids
> > failure.
> > 
> > The solution in this patch can indeed resolve this issue.
> 
> It looks like instead of adding __noclone there is an option to
> improve pahole's filtering of ambiguous functions.
> Abstractly, there is nothing wrong with having a clone of a global
> function that has undergone additional optimizations. As long as the
> original symbol exists, everything should be fine.
> 
> Since kfuncs are global, this should guarantee that the compiler does not
> change their signature, correct? Does this also hold for LTO builds?
> If so, when pahole sees a set of symbols like [foo, foo.1, foo.2, ...],
> with 'foo' being global and the rest local, then there is no real need
> to filter out 'foo'.
> 
> Wdyt?

I think we should do both: fix resolve_btfids to ignore compiler
optimization suffixes (.isra., .constprop., .part., .cold, ...) and add
__noclone.

This feels like the safest path IMHO. Fixing resolve_btfids alone works
with current compilers, but future compiler versions, under aggressive
IPA/LTO optimizations, might decide that the main global symbol is
redundant and drop it altogether, leading to similar issues.

Basically, fixing the tool makes the BTF pipeline more robust, adding
__noclone also makes the exported symbols themselves more robust,
regardless of compiler optimizations.

Thanks,
-Andrea


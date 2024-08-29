Return-Path: <bpf+bounces-38406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E56964916
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 16:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA3E1F2299C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB6E1B140E;
	Thu, 29 Aug 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ss5YlHvy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2B1B1402;
	Thu, 29 Aug 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943144; cv=fail; b=MNY012vjo638VnnRIhsVyby9+Qd7P950oX492Qcz21dny9XmOOrumbvAW8K6+K8sOg0L61wqvGwJ/qTd8rtIyvNe/T01PE8NzX3iYQnTPY2KTnpmT7ybuhSuD9mPYlA4+fybY0z+6+Y3ITKb3ets9uF/6ZpkH2W4QcMQJaP5jes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943144; c=relaxed/simple;
	bh=ijZeTYFvcU9zhVK/2DWraZj98Uqsnr6hqGkRK3e4H30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LQB+HG3uyp2nVSjZrW0rtyxZrKOK7FnoSBP50yS2DCirJWegJUeLqm6ndbm5aR5QDEslq/J0ZtxkCVBRiTtWxflj6ZUmg3Ff1E4zXEGmSQaC1ykZm7K4hGvsQI3bgdGKxcgx5JeT1IX6GLtPbUjGCVPc6gZzOGmBWs1oepNzXds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ss5YlHvy; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMkumdri311s5caMJyBaoy0fHQSyoW0lgl3XoTZP/pidmIZ6U2HGCIXJKNEnMk20cPmMwqa38Jf7FgWm9kSN3lX/m4Yt1qZ0/481uvLGp5S3bscox+qPmJ87tVWr/shnSjXeTcu/hSP9rEmsdtZzpxd2aWc/swe7hVSffnBsHdmWnkDMIEREV4x1a8sDFWuquNB5XBGO6292EyCW5QUUJ4ALRW6mAQdf86qjAw9DvC1T/fctduBxlxD7KQT4D+FC/SOHfE1upyNTldECqs3BzDuCO8nUuF3Lz6WNKqENN08zELc7mR2F38DGtXm1EditXGH5o8ZNrh4oPIMhh2fziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4g5FRu6Vnljm8gDaebMzjAvlR4KpUm4kftwRA5iwIU=;
 b=nb9BZu5aMEbI55LxRru4QtAD98zAiDQe2SBg5Fa5XfPjFKDGAuiIMyLQOJ4DoK1xLj3iN/aAb1lWT/7FEiwbP0qgHBBS15VPu0KgTeyr0/PAdnBl/S0KcnFjXPhM0QbWpmbxMsJ8B33bf7Nkx8PVk1wNGdYkV5iMgmvKHZcTkqQHOkMDOvNsDmz9E2vG/8t1QaAHq35doZNtapD02Cc4ZOcbZYcOdXyHKX/aZSIeUaX4u1dke/+J1OifSJJqTFmarFS/edRcTEEPd3w0WQ1bGCuXGqJxp5rNTrtXZSnX53c7vUZq+OKPRho+oWPCCSsn2kpaMXRqkgxO2vk51CDhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4g5FRu6Vnljm8gDaebMzjAvlR4KpUm4kftwRA5iwIU=;
 b=Ss5YlHvykEAWZa5iEsexbT5IsIqnABSTSwfrw4AfeyLXgyB2YynTuzPaTeAXe2mGOWCGw/Ypc15qEAaQJaqnds87DWUYY31gnFBKwC6PBW5hqFfO5ZM5luxSrlbZdS7KPtSKn3nmd1jIZRQCOC2W8TpbIUILSbTNxhPXdU2W+56JZl1sTpEBrSEAj/nkV31wpPbJYx01C4GGM0mYwuxtkcCzE/vxs+9hiAjJNhAGOfYS03KmkNAquJgA1bYt1ClQHYxOjo2tPgXhgXD6p1RXLlbLKDtMV6pnKoL4zQHBlZ/JDuw3OnZ3Tq/UiMoR57k04QcKt8y85VRVVd6sgiROXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 14:52:17 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 14:52:17 +0000
Date: Thu, 29 Aug 2024 17:52:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <ZtCLFYdbw6rPinwS@shredder.mtl.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
 <Zs30sZynSw53zQfW@shredder.mtl.com>
 <Zs8Tb2HXO7b9BbYn@shredder.mtl.com>
 <ZtBhhhBeKj82CkYR@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBhhhBeKj82CkYR@debian>
X-ClientProxiedBy: LO2P265CA0373.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::25) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: a85bf983-1bf5-43b3-7f57-08dcc83a2d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcqc30GcX/aM3gzutEi6dLbTCOj66NIfiLf4DS0HGw6YiFouNaTOETsQpwrv?=
 =?us-ascii?Q?7iAedpG8nh/A6+5ZAs6JjWYWEJo97+shY3v93PnpO8a2NMeo9mmDJVlae3E0?=
 =?us-ascii?Q?2aTeC4eoING2KS97aSTkMeF+SOLOn1UNxvl/qZunWUkKzmnZLQoJ4/zf2r6d?=
 =?us-ascii?Q?+TpNl5yNAzTB5BufM6lMSrdPrjZMOER/YskwcLVsKUD1oSjA9NcL0WhQ6hvK?=
 =?us-ascii?Q?By+Yhj5Pe5S6k0BLaNiOeC23433lWfe/bmNJJ2aNHT3K11+259Ao6yjLDbmp?=
 =?us-ascii?Q?WtOBWAqOsiqn7//ZyPnUJI2AxIqRoLCS8hGXJenbHbF6duUAYI/fkkW6oc4U?=
 =?us-ascii?Q?sHcyHdyAPv8ZaY9vAdPTNEfe4AqnDPtsnVZWaZjAh+XhL0mFqj+Bl15bClvW?=
 =?us-ascii?Q?xEunZ43E6bBerNKKVr1OulH3OgpCBffZqsTilG9PchISuGLvywaNsy/lId9M?=
 =?us-ascii?Q?1pzLWk5FMBvvUYlPL2N7wwX20kCwW79AnBLTzYSwnmx2LOLC4x47S+p+ACr1?=
 =?us-ascii?Q?E+Hky3Bfp6km+4q7oB7vxzdns2hJN+VMVRpk82v1PpcqDVN4/v6lmNBjQwsi?=
 =?us-ascii?Q?dzJYr67S4l9geX4tnVgFVGP9axektnMYy6CGh0LbozHNcl5c1aQL3lwVJnpa?=
 =?us-ascii?Q?lMQ/e05FVlvqtCIBLA4Y8S1fUaugkpYWCvtAxW0lTgCqwxJq1B0oEgDCJWIM?=
 =?us-ascii?Q?GxeUAGNoS8vrTrWuxUFAO02iudpi2zUYyxawAsaOyW/C/dwbc9kUtwSN5snF?=
 =?us-ascii?Q?IKRJB+s1A4kAH/Cv7KIraSDa/DC83QNsvW3980ZHmG09/qzBaIgS2JVH0G8M?=
 =?us-ascii?Q?uFvQUnkNcW5GCYNY9fzYrT/wjRgoO/Lj3X/Nh8gAvWPkIZdcl4h69KzCCWVw?=
 =?us-ascii?Q?WVOAwn7Ed1IVkFxyG0th6WI/ncYVgB+xf2mANjD4HHgbLjuJBSBsBFuXL1Ce?=
 =?us-ascii?Q?QBPEEAQ8FW0ePrFaFPa7hB5DySi+M61lt8gmCOuFjx/T5L4KI3nwVLVenR2s?=
 =?us-ascii?Q?wq07rMiAvT+QQoVyNu8kKdVk7Wfy1C/TICRcE3HCq7STkFa8hEPR8uK5LQdu?=
 =?us-ascii?Q?8XNXVaOO6B2tdFiX6S0SgtuVUTmEqPd1fcV7AKktfl3tlCimaQSDEAqqhO2/?=
 =?us-ascii?Q?fe6Xd3BGjkob8MYVoX6sKhxxQJal//XF7AjkQGsphoXlIu2V9U6rnQaojoUo?=
 =?us-ascii?Q?i6cy7pCVbLT1rm2WwZWDY18ZFM2bB3hTT3ORNfzpbrArPEAjGD7T1+v8bRuo?=
 =?us-ascii?Q?iJ5jEETC4u8+5Hvr+g1kWHsaj2FtLkiH9LfYz0HINm0Us8uhisGmgBKZ2Tum?=
 =?us-ascii?Q?nmpPJ6mXU9Lin0p2OHIveMxvM07wPe+6/83YwZ4M+YRFRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?keUuh8wVS9fgKTVf/yGE/SM51YDWeKtoocqj3fLHIP1oa7nnKRYj5/CgOFsF?=
 =?us-ascii?Q?0PwcabbIdn6ChwZzGj3wkXPzIyqWt3sT1ZBWngBvdEUGXIwz2HZOVWnb/Wpk?=
 =?us-ascii?Q?5VYKbp73YPG0V7sbQvLG1KH16ChDOP9fyf7by3382bP6atebTMLMMub2CGcb?=
 =?us-ascii?Q?nWgzGwlE6VpiJOi9HXJLODJyLc3oYvmTdoq/lc9XSeO4WtdG2qcfvzsBkbzj?=
 =?us-ascii?Q?8+OKWH6HebxX1lCzqkUQ64zgqx6+qni3YqUlTjUl+j9CbtmSrn0veKkecSJz?=
 =?us-ascii?Q?KqmbjMqcu22dEH5w8qnPdd6FCzgSXaiqIsze401VE2rt1aUa7CPW8JdF9Je3?=
 =?us-ascii?Q?VXqJrABHwlZ5hmg0CKTcmn6EZgRaDzlALqZRXVTcECpHm8H5P81vFMza6jdW?=
 =?us-ascii?Q?tsK24rsS9vK6RRywIgpitb+oHQm3obeKYuEcThq4+nZd8UrYC4n0UrDGnQFD?=
 =?us-ascii?Q?eOvFVNZO1Y9etbRSm2b+bDzC+IldR7ojL+u7DentjMBA189gnbi+NQE2hDkp?=
 =?us-ascii?Q?jZ65pBU2mUCzvYi8mrhy+9eRu2HY88IsBZ2V+4tO3/sdzzERcKeQyv5WoC2/?=
 =?us-ascii?Q?Rwx249Lfsi9h/GoqjETKSZuac6g1nKcINbwiTDv65dUrApUNde/T9T4GARza?=
 =?us-ascii?Q?kDTw8ESLv5f4v9UrmX1dlwKe5S+vSGJ4rdj2pIsUdiTg66bgDQpcyb1VNGks?=
 =?us-ascii?Q?EKBy84WIieA+13pxntUGZxaavyu8nwE4VSc67BlFQWURI3ejAmPqKuSFxgD/?=
 =?us-ascii?Q?+vY1mAJldW3EJBa3GmvIQixsqHJ828h1ujzF6zTwn8WTivgOeijc/oBQy5v7?=
 =?us-ascii?Q?wio8N7rkado7lMVFjXbxhTOCJI3d5JCkZiE33oFi2kDdVY9r52bZ+5/sgywv?=
 =?us-ascii?Q?tOWi4LX5uQz2M2ecEF0GHV5BdJhef/7yeyg7yL9ZyxYEzztEA/koYNqy2ha7?=
 =?us-ascii?Q?aif/Q9EgwBft1XlBdTCa9V8QaRp2A0xqSafyPIh1Eq6y2cjFxEDVHq5mwqdb?=
 =?us-ascii?Q?odZr+K4ON3VCjK0CyA8PVeLzgDD/u/sFunmMrEIajbVXJ/aYvxRGD6q71PO5?=
 =?us-ascii?Q?j8SbW0Wi+r5UaqBOMU26/CKJq6OrqjgKSsw/ZKp2aI8nsNjiQaccJ96E2DPs?=
 =?us-ascii?Q?3uHjwfvdGCwDsMS+5NuQ0IorXnSu0jzQkonm0lxX5k4+XB3YJ4IeGmMXBaoI?=
 =?us-ascii?Q?ws8sqseECGOeCviHFqwamx3DQiN4wlDOluJ28RRmh9j9k2ha4L/vTq/TwzWx?=
 =?us-ascii?Q?QOckjt1bjZy6xFcuLiSDeClqysEHlhcjLpGWdj9WlJk/JP6xbVu4y47cxk34?=
 =?us-ascii?Q?XUPxTomRQFiG6UHFpyYmlpgu1i9Q23K+jOjTZm+l+hR3d5liZVLzQrO5v0cV?=
 =?us-ascii?Q?vq5FolSLi1+YKI4wbrjCgh5PGE4U4zWNMUmOWrAZSLAEILFCtEmjUEH5Cb3/?=
 =?us-ascii?Q?e9Cq2Z1Ykmif5AKsosYXVfNKWeB3CtkkMO9ImXZhGeKQbXswawriEWdiJcPT?=
 =?us-ascii?Q?MuIhqLVSiWjZh/eY0wGYVjk8Rt8uanDQTo9xuKivs+bJFTy/cwq8VCTizLZh?=
 =?us-ascii?Q?k1PINKEej2maXb2+Nt7BQvPbDpxQqROIEcKdqgR9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85bf983-1bf5-43b3-7f57-08dcc83a2d41
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:52:17.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9fVwfPCk9XmG7MYlFPxcPNM2qIT09ma6eJNJO3Y3EklSnAdMZzSshM0FLL6/CmIJcW3ruL6ovNnx5+GX2I0eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

On Thu, Aug 29, 2024 at 01:54:46PM +0200, Guillaume Nault wrote:
> On Wed, Aug 28, 2024 at 03:09:19PM +0300, Ido Schimmel wrote:
> > On Tue, Aug 27, 2024 at 06:45:53PM +0300, Ido Schimmel wrote:
> > > On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> > > > On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > > > > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > > > > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > > > > DSCP. No functional changes are expected. Part 1 was merged in commit
> > > > > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > > > > 
> > > > > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > > > > lookup to match against the TOS selector in FIB rules and routes.
> > > > > 
> > > > > It is currently impossible for user space to configure FIB rules that
> > > > > match on the DSCP value as the upper DSCP bits are either masked in the
> > > > > various call sites that initialize the IPv4 flow key or along the path
> > > > > to the FIB core.
> > > > > 
> > > > > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> > > > 
> > > > Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> > > > necessary as IPv6 already takes all the DSCP bits into account. Also we
> > > > don't need to keep any compatibility with the legacy TOS interpretation,
> > > > as it has never been defined nor used in IPv6.
> > > 
> > > Yes. I want to add the DSCP selector for both families so that user
> > > space would not need to use different selectors for different families.
> > 
> > Another approach could be to add a mask to the existing tos/dsfield. For
> > example:
> > 
> > # ip -4 rule add dsfield 0x04/0xfc table 100
> > # ip -6 rule add dsfield 0xf8/0xfc table 100
> > 
> > The default IPv4 mask (when user doesn't specify one) would be 0x1c and
> > the default IPv6 mask would be 0xfc.
> > 
> > WDYT?
> 
> For internal implementation, I find the mask option elegant (to avoid
> conditionals). But I don't really like the idea of letting user space
> provide its own mask. This would let the user create non-standard
> behaviours, likely by mistake (as nobody seem to ever have requested
> that flexibility).
> 
> I think my favourite approach would be to have the new FRA_DSCP
> attribute work identically on both IPv4 and IPv6 FIB rules and keep
> the behaviour of the old "tos" field of struct fib_rule_hdr unchanged.
> 
> This "tos" field would still work differently for IPv4 and IPv6, as it
> always did, but people wanting consistent behaviour could just use
> FRA_DSCP instead. Also, FRA_DSCP accepts real DSCP values as defined in
> RFCs, while "tos" requires the 2 bits shift. For all these reasons, I'm
> tempted to just consider "tos" as a legacy option used only for
> backward compatibility, while FRA_DSCP would be the "clean" interface.
> 
> Is that approach acceptable for you?

Yes. The patches I shared implement this approach :)


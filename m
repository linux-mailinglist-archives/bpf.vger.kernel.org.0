Return-Path: <bpf+bounces-65536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9875DB253F0
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A137B1082
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25282F998A;
	Wed, 13 Aug 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U66pNsBl"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D55C96;
	Wed, 13 Aug 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113219; cv=fail; b=XRC19TkHw2WlnwL9EiiClVh2hQeh/8BKPigwwVvrdk43B66qrHgxVyfCQKrCEjo+fyai2aTAZiv0uIMxSEOrwTi7OCLmVLv0hDjZ1H3j8ccyfD3nrZNRbeGZOHdms7zHQoc/38jpXUondhNMebk2dmQsyx6aQzgo6qwx605V0r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113219; c=relaxed/simple;
	bh=aGWYNWn6PTf/nUpK6yUbRfGOkMUXWhW19M9jki8+XAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fyMxM0rneD7x1MaJLkj0gVFU+CvJ9VQwcwBK+CTwRInFoKaCVot9hsgtnM3JaOaDRZ3bgemVmDKH5C7QU5OH8sg5U0AqhwhdHGgvnvkKcIdpibPWFX++VWtpW+VFpKNaOda+fKRQRScQ2JXJpGdyPiOgsUr/V88bIuS6pLsXd0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U66pNsBl; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ6KtcH7ACL1Q9kf1JEaygS/tsLoS9FpZLcunsnAxpHrxw1KyzUe6GO4bYD0tVmhdXre3HDLDUHD5MJNg7j/zFkytnJy/RO9RMG/ORlY85tQT2XE5/czTJpoNRu7UJvSMFO1OL9YvQ5lIcV4XzULYsZrpG1i69UO520JYG2h/KmIP1WUrPDcSoebXrWeCggXt16Jcexux5iyS+TesqsVtRU9RT0+cwKTaPXmUvIsCOgjjLi3b0At+ZsfJkeu+u4ipJ4FYB5EpIygP1g27Es0pnkKaqB5HoKo76ZNn0ZlTG10cgi9TE+RYn5AfRPFY8Is76vnM+EEvj6LGjPvrK+bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA8pWAI8jLIke0KueBQ+gRvVxLAwsISZmGJwRSq9QfQ=;
 b=qlPlPdsR9qBrRSHWGM1s4T5Mb/4sgymx/fU0/9xmIu9wcHMZjWejZNDa2VYB2oyP6WqoioPIbXk9DSPQgwf6Bi2Hg05yuAF/kXDkHIrFW08a/RQ6297pydP3qDZCS3LxeMSGBCHSFdTC+2xJX3X1IcdKh0HtjSXljPRFw/eU2zf4Dj1EuCQ7yQHVtVxBW9PdelTbepyI/rv59CjLXQQ15fPerTj9aSublQxp6Eo5+6CotHTQuX1driKj9uBqvjDFgqBHhd+p/DKXBSCqr4gDePXqweeWMA6K3FWUIhOQJHkDHfV/Fc10QVwKpeY9fKOakyQ2x/7E2pTUZ/JqfEUgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA8pWAI8jLIke0KueBQ+gRvVxLAwsISZmGJwRSq9QfQ=;
 b=U66pNsBlAeOOu2CMFUVp+GsFdPsctfD0tlhCqzCLJVNSHTYbp5MCtb6Zz72uVcMWl/rfgQgUrgDHuZKsfBzL3RV2P2HGKb2lTFppU6yfCv+37/NqRCyUQtrzYWqfIqq8vrNJwl8FeH6hEEO0smwRwbe5GV8BhpQoBh/TLoBhQmGh4Ra2GU3G2wnY0uD3n9sozMd10WOKXQ+hLoH5ZQ5vmM0mDElkbd7GLT5h5mevmrEiA4hXIWxPLTgPOAEbvgUW7L4WZ1D99JftYRQD6jKXMhNFQ323aKVmluvrUR4sfTfoe6ob/8UPinQAGktRrQk6Z81wOLK6InyIMJu1fi+4cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) by
 IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 19:26:54 +0000
Received: from DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438]) by DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 19:26:54 +0000
Date: Wed, 13 Aug 2025 19:26:49 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Chris Arges <carges@cloudflare.com>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com, saeedm@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <5hinwlan55y6fl6ocilg7iccatuu5ftiyruf7wwfi44w5b4gpa@ainmdlgjtm5g>
References: <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3>
 <aJzfPFCTlc35b2Bp@861G6M3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJzfPFCTlc35b2Bp@861G6M3>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To DS0PR12MB9038.namprd12.prod.outlook.com
 (2603:10b6:8:f2::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9038:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ec8d29-84e5-4bb2-7b2b-08ddda9f5c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KDIgLNYRbKRqXtPYYNuKqcI7fPJYi5Icr/5oG7j2+rwuGuwjrLI99321LaR?=
 =?us-ascii?Q?bmNToKmSqaMbdC7b0JiCSk69I9OYa13Kw8MPF812EQYtQAQ3z3wuVpWcK9CR?=
 =?us-ascii?Q?mNE3oP/+yXA2fVjAwBIg+vQownb9K/MVUVGxYThcHjvkzD71JYhqVTYdj5us?=
 =?us-ascii?Q?vU5vehj3O7kOAgaD8Im3uY6GXB3IQP2B/yIR2l4l7qvxnQyHZcyg7+wxBm0J?=
 =?us-ascii?Q?n8HzfJvJHLdr1t6SoXtl4LdXBgOLlCe78wbUjddD4AksL/H+nLt3CAUfhTB8?=
 =?us-ascii?Q?zNZxUxte14UHyUU1CYDiONZTPiVLZ0CUs5F5XmZbxRF1Q2XsJY8amm0hNaPc?=
 =?us-ascii?Q?37CNOPwRUip6hVEVGin9451qZDjkpVmUWBeqcjgYr51zfjs1NyKuaYiE/5Y3?=
 =?us-ascii?Q?/z5TFAjOc8BjzClRJEqecFotqF129coyFDJ8owgzB4hI8flmMB9wv0Z68QNd?=
 =?us-ascii?Q?7AoHE7i6jh5OEHmnBKemoJvy7yFqb9KnHkZTW028Q8wJLn60laQYpcfxXVzJ?=
 =?us-ascii?Q?DP1oSgpw4XgqoMB2s3qGdUc8wQHy4ghbQ0YK7QVWxe8eLdjoUAZikwngLoXj?=
 =?us-ascii?Q?rX5ViBnAQ2VBz/x2ig7IBgDBGp/bSKr7k5THmLJfpAFgMXpW9IgXSmxdc03l?=
 =?us-ascii?Q?V5JtbETHfWWbKghqWL5exENGCRTCXpv8qf6S2cjXTNenrkx+nVra4fGAuSPy?=
 =?us-ascii?Q?bm/Y9E+CeU2pWLVY+yeRwgfAfHL9N9p3dY/fBFWMNEqpKYJFU8C86PTQd9Hl?=
 =?us-ascii?Q?pbTrVwzqFeXevzXUurPN/EPVP5BbNmbTAsjVt5q631z7DY8fZzKZKZTdIJZh?=
 =?us-ascii?Q?Q3AgSjtS37sHkqmPHVIGFdQRhoHgComR/JYCGgWouUdG80HaGbazdN2QRdgp?=
 =?us-ascii?Q?y9IOc+MUb/mG5F9RrNuFmIFy0QYYzUiwd2SHzetCFqdiprgpI5f8AVTs1eS8?=
 =?us-ascii?Q?xKIptGnW3Gq5n50Od2FpsATzaghi1DIUv6rDJgfOi1UFrPZ3gCKBbIeQ0Eto?=
 =?us-ascii?Q?ia6hM+HrPZ+sl/FfLY9cEZRXBa9Y88Gx1nRJup2/YmA5mWpiFPL6S0HFKlCt?=
 =?us-ascii?Q?X3sXxjmMeDRltZo6ko/icGy0p4LGrUq3hYj07N9DDqL0aYiPht4YGW/OaqDk?=
 =?us-ascii?Q?FSHSkUdHkYl7zMNikMxo7MGSp7iIjg26+dp5vVKUTBON3CgcfurLlo9QKLVa?=
 =?us-ascii?Q?13YzWqrJCizewzaVeSN911lOSAiui85BQfFYGkATYhXEAdAXurcJelVGkEkl?=
 =?us-ascii?Q?yw6Jys4P7FGXMMlBrYR6L3KPX6G5Fx2UaRMiRuzrARxdppTblDOLRfunA+zX?=
 =?us-ascii?Q?0fM/rdcJPq4tglo85J4tZ8L+WShnTMoVKs/pOh2qDHHXpvvdzmBd15PGwCwN?=
 =?us-ascii?Q?OA0f5UuITm7tMvjVLEnB14ue+h8++rKF5o9Xb3RpQs6NAeNBmQJ+b/7bF/9x?=
 =?us-ascii?Q?V8aaaycKkJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9038.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c0vciVJm+nLZr/B1jBPkO7yRFIyFNdDUFZzt23Vw+4UTTkPKmXv0779qAsq9?=
 =?us-ascii?Q?R5SmbdyoCRJsxdIoPPFGkzO6wxB2zDAaGy6hkQ6bvxzhD9rKmxe6MykUdvFP?=
 =?us-ascii?Q?nOGwzhasqzJH2B2oxt4/Z4Xg7Z2cHlZvULwBisvi8d001uoY7Sh+SfOP3i4D?=
 =?us-ascii?Q?T+o8Rt73UAFqrAJhafSJ5j1n1HBpE/jZaEPcKd+bLZ/ooEBUZzQkYwc9yaCu?=
 =?us-ascii?Q?I17tpYYkSpqlJWUKSAxRlvQ5ptDo2GuyMHdxtPKzMGyHL2JwG/3tJq2JSZZr?=
 =?us-ascii?Q?BB+lmzpcmSFEPZjG7OL2wE2Rh11G4yej6GMdwi1qfgrlByjdLlm8zCtEg7d/?=
 =?us-ascii?Q?jzjE3QRZhplWduJVwpbcc63FyiEUUGibsw8MqZCXp/F6b7grZkMGxmYZdKe7?=
 =?us-ascii?Q?P1aCwtIp9QIII5BZrem6T8oiKcCR3US6bTVGgAS+ED1StS2yRMqswxpwh+/u?=
 =?us-ascii?Q?R7aZSFgHzFixVnnF0mKhB8schQeYuRJOTYuslvu4e6izj4q/O6xZO3Hx/574?=
 =?us-ascii?Q?lAjSWX2OJlO+JE2PrhlLqExi6hRcYoGdJyHQ87ouB3m5uVrHFkD/2FgO5k/D?=
 =?us-ascii?Q?F6NIsbPu1ECgQi0Rm4vlGmNPhoVktIsqTxRSrRrrgWEZoSzUK6S0cZrdYs7C?=
 =?us-ascii?Q?BCNiive5kbOfFnK5yCH55c7nozn4jBOcm6yllKGk9/UyI2Z/Wu2V4nb1fJWI?=
 =?us-ascii?Q?tLQNd0Ax5IeKFUFWMfc6PWfsz8iF1HocYkJFtaRSdHz5AOH+6AzdeHPlpmoW?=
 =?us-ascii?Q?Ajz7jW1+7ykgrcOfmamP46J8EQJYb/BTM2USjNIFGQjbbHTdmd3ixeaQyIXE?=
 =?us-ascii?Q?D9+GfQEzqT69wRBbkjAgo5iVmnIzxkNFOrs4S4mI26k9v8kXNhase271pZlW?=
 =?us-ascii?Q?uqkRoz5m60+gwQ2O0YhAUtzEVVzzIJFnrjBTDkhPw+hrDP01GHb/AuceG99I?=
 =?us-ascii?Q?zgYAogbWqDabx3jf6iiEeYlHjp6CoCS/RQThBWEOFBcEeeI30ReFuKlwGVtY?=
 =?us-ascii?Q?Gnqr2unpRfEVABKYFgrqGXyqn8uixNuHVGpTLBflplw4NoWd9/MDTWxGxBZF?=
 =?us-ascii?Q?XoXrh0Jpi5Gp0cr9HDEnGB7ecH6KKd/3wZnidoZyoZu2ycmg/IzzaCtZldpl?=
 =?us-ascii?Q?9rMnLw+J0KefIeb6tf98YBPTOL46UqN9qod3zNmsF6JhGtXhCDymaUIyb7W0?=
 =?us-ascii?Q?sgoeuP3AUOGbhmeOdrkGUmot1aYxJ64yM/KrtQlSirRvoIugHxJ4C8qBUNwv?=
 =?us-ascii?Q?jJ+bfxW6U+1y7SvMY432jZfjnWCtJmY7+c4FijmMERfviNKpSyT2vE9m3uHT?=
 =?us-ascii?Q?Vak5ZTmKLvXqXC5WsmUIMIU10/r3E9fN4WP+B4xYDnbyktSy4XtzYWIs35DL?=
 =?us-ascii?Q?WueQpems9IRoo5oM9/En+iqvitXwHBLIIUIzppids5oh6uNBkgdrhXku5M/C?=
 =?us-ascii?Q?jOpsONtHpdW085oaCM/EdXtU5h68gAC2LP+TqYrbBZMQMtuL2NmOzgKbXN/e?=
 =?us-ascii?Q?0j4eXlD3Z5WGPkTuoK4jnFKjCBle9WixJaZNiGkjYgdLXrl8NgTU8lixIqnz?=
 =?us-ascii?Q?nzIA1h5eRw7M01jzebz/nEWXYyU0aH5VTZFfWDYz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ec8d29-84e5-4bb2-7b2b-08ddda9f5c72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 19:26:54.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uy2Z+d3IXjzEFuOSa/oXaVfEzDU57oyotnhSvuqGOIvax1xDMTjGwZuqr83fIdlkGD4pntMeNLEc2tyU3xed4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932

On Wed, Aug 13, 2025 at 01:53:48PM -0500, Chris Arges wrote:
> On 2025-08-12 16:25:58, Chris Arges wrote:
> > On 2025-08-12 20:19:30, Dragos Tatulea wrote:
> > > On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
> > > > On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
> > > > 
> > > > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > > > index 482d284a1553..484216c7454d 100644
> > > > > --- a/kernel/bpf/devmap.c
> > > > > +++ b/kernel/bpf/devmap.c
> > > > > @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > > > >          /* If not all frames have been transmitted, it is our
> > > > >           * responsibility to free them
> > > > >           */
> > > > > +       xdp_set_return_frame_no_direct();
> > > > >          for (i = sent; unlikely(i < to_send); i++)
> > > > >                  xdp_return_frame_rx_napi(bq->q[i]);
> > > > > +       xdp_clear_return_frame_no_direct();
> > > > 
> > > > Why can't this instead just be xdp_return_frame(bq->q[i]); with no
> > > > "no_direct" fussing?
> > > > 
> > > > Wouldn't this be the safest way for this function to call frame completion?
> > > > It seems like presuming the calling context is napi is wrong?
> > > >
> > > It would be better indeed. Thanks for removing my horse glasses!
> > > 
> > > Once Chris verifies that this works for him I can prepare a fix patch.
> > >
> > Working on that now, I'm testing a kernel with the following change:
> > 
> > ---
> > 
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index 3aa002a47..ef86d9e06 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> >          * responsibility to free them
> >          */
> >         for (i = sent; unlikely(i < to_send); i++)
> > -               xdp_return_frame_rx_napi(bq->q[i]);
> > +               xdp_return_frame(bq->q[i]);
> >  
> >  out:
> >         bq->count = 0;
> 
> This patch resolves the issue I was seeing and I am no longer able to
> reproduce the issue. I tested for about 2 hours, when the reproducer usually
> takes about 1-2 minutes.
>
Thanks! Will send a patch tomorrow and also add you in the Tested-by tag.

As follow up work it would be good to have a way to catch this family of
issues. Something in the lines of the patch below.

Thanks,
Dragos

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f1373756cd0f..0c498fbd8df6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -794,6 +794,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 {
        lockdep_assert_no_hardirq();
 
+#ifdef CONFIG_PAGE_POOL_CACHEDEBUG
+       WARN(page_pool_napi_local(pool), "Page pool cache access from non-direct napi context");
+#endif
+
        /* This allocator is optimized for the XDP mode that uses
         * one-frame-per-page, but have fallbacks that act like the
         * regular page allocator APIs.


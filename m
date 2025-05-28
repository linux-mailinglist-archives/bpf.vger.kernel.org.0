Return-Path: <bpf+bounces-59147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F3AC6582
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0422D3A4481
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763A927587C;
	Wed, 28 May 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="piJtdrwH"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CC274FFD;
	Wed, 28 May 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423835; cv=fail; b=dsD1No8bpfvlxKNIJGms+y7ymH+6qVPWTLJjxX7ROspHBcZOEIW9lUSTkQa2by5dgVzUXVm8zuXu6SugSUOoL9D6e/hSn8FsHVTZpehisEJjSJIYp+IEW9ruR9nVPITjzTF6rstXcvsskJiqSbKCfo1yCz7DRZLqDjUfM9gHDvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423835; c=relaxed/simple;
	bh=Vr+R/Y//PGBe2/NqK89hI2WET5PUHGNYChvxUl+0s5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AaI43ltEiza8xXWTlnIASAOBhLE7ey6t+7M6pRkOeozpohmb5Ua1mzUyxn/ZInD0hCRy/nK0urXuHuteJfVjiZxG8eQwNWia3G2Ekxh75DHt+ziyJPf0UUG+JCBu8gtZY31WapPof60yC8X1P7gKvnNtPw89Z91bGEEU1RPX9Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=piJtdrwH; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFH5+g9nmA3w6MwFAZZMPG7skrZHBllmZ66UVoYyJK9G2NvSkM3AhN4ru8npvb8IphFf6SR6C7A/X0sR9UimDiIZ86TyE7UX8ExYlPTssPD2mie+xFvJXU9nwa86cmu5LB9w9uFa2QxWvh+ArrDtVLv6NAvankIiot39EE9VMPT/j8vKCqCziLEgUU4qCm2v/RoTXZhLQ9TF8jG8x5Ns9i/oHlLzncR2VALnLdGK0iGXxUCYZiy2q9rI6DgjqM7BHPR/sWYXHi4jix9PZ5f0UA49/kKtDXK9n9KV+fSSZ6kVlIv+XJNKMYuySTBinrdc20g+dvZaaL8ve3y4OVrQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBizN3gkf6Rtj6KfgJTDf0u68s8AjZAPQ/eMr5+2BDM=;
 b=CSZel/2kwEU5H2NAuDVqkpUkoNCgP11it46RQlAQr3ZlSNas8AjMjO308xYsWmz27tED2AiZiVQNBiBClwgW3nacItXyUZCNRnD/naUrApVeDblLqi4nfLLWztNA5PIJ+zcHZ9RuCEeDXFI3c+05BASrY8LafWP9kiGTP9ofIjpmZ7wOTGfSh4XLT+5Vlxe2Ue6kxLAXGpvvKkaIvg3KxgKrB6FA4i9ylmsjMHxnGgloV2ccmidG7k1UjLzuidJJaGVQCH5vxxQFzt1CU67xX3qng412QnC0c0iDT4pNBJpfC4e6hL6ED6vwy14gzNE8do+qxNGJs0OjLZy5b981vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBizN3gkf6Rtj6KfgJTDf0u68s8AjZAPQ/eMr5+2BDM=;
 b=piJtdrwHzpuzwNkv5a/sN4rR79cYJ3sztiG36A+sNFK0Mmv8K2ctecJpvDeeE2ANYRFpDlu3Mv1uWhdY9uEIeHceUIAzX9tEnMBD/SJxeTSvh+5QOWX2xIt2UsS0V54ingXczO9G0G3DA4H5uFB/XcIO+T38z6YcWSmCcGihLh7qZmYoTq8VwqIbTr+0P5YmM36QGUZ8zQGujVd+zv+l2X14D1YA1QqD3wUJsMFkwfbMXB0/cDvn4VLXSqeJR+Iae1GbxQrF6ZCXXtLKaSJJ/qOOjV9V2PSb54DJrAgiN7COFuB6TzgaiO/X2Smeo9Y59F8+bDyYFt3BFZoZrYX9Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 09:17:11 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 09:17:10 +0000
Date: Wed, 28 May 2025 09:17:06 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
	Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
Message-ID: <izjshibliwhxfqiidy24xmxsq6q6te4ydmcffucwrhikaokqgg@l5tn6arxiwgo>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <aDXi3VpAOPHQ576e@mini-arch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDXi3VpAOPHQ576e@mini-arch>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: e24f50c3-e0c9-4412-07df-08dd9dc86d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L2/SVLyiGbON23HDYFhQQBSZzeGMiTSByC8bV1KmBb5ASFkwz2iqiQgsZ4gP?=
 =?us-ascii?Q?nN6Hf4S+SP2GsolAkSBabLFyClVvQopJBCVTh2eYXxmSuQzFcaVeumcQOIrm?=
 =?us-ascii?Q?WItyBs7gKj37++yOovVNYtij4Lm8XOnanJXvb6OFV/rQMLgPV0obn9pf7ebU?=
 =?us-ascii?Q?UhtHpIliU80uNwBxAR7czGjDUHBMZ5dq0hTyaRFOZSzlSnPjF6g0AAGU5png?=
 =?us-ascii?Q?ovw7JI4N5CLeOa/JxqC/eR4EFmViediI+Sm9uspTqJoi8ful8qZdTdk1Up5/?=
 =?us-ascii?Q?wKjeaV7QMDcKWnuQgQKz8CrPYCmQ32O1DtclIC3YEnJgPoxdzhcIx+RObsHK?=
 =?us-ascii?Q?jp948+Dm6oxhbkRPE2GBAgnoZh4vHepN2ALwS079m49wUuc7X4kRFf61xP68?=
 =?us-ascii?Q?IWE/5w1uD9SoWC83iST1IQqIjDlwV6fNbyPknneTAFqvqGJB3qqbPOi/R+LH?=
 =?us-ascii?Q?PbA/Ic2bKOA+6pyxgLUHq9yJVJ7P5dbrdsnvlW2T9M+AVcbDGH3qJzEeyJxu?=
 =?us-ascii?Q?NKk/y4YEW26TcrhDzvgTcnc53EBbmiftco89CBtkSyGp7fhum6774tDJ9t3j?=
 =?us-ascii?Q?CNt/k0ybwZ5bW+AQzppLUNPqVbYUx3rCkd62R1Aj+GUn1BucX+vVIJ1plWUc?=
 =?us-ascii?Q?VvMLwlQE7DrrgqlN0YLt1GtJIKOwYLZAldwn3rpl6Ywdk4VoCxSiT8yzGVQV?=
 =?us-ascii?Q?27PSoHURzuRl0GeWafKZyFg9N3qlt2P2y0V00V1PBdyjRSwmT95aXDZzsiE9?=
 =?us-ascii?Q?WspBvyt3/FnPQEyLbaRbXwT3UDkn+VozPN+iugLMCchKeff/XcvdfocF7dpI?=
 =?us-ascii?Q?XyLYi4j0lk+ZqYDTKV0P56h7c0/420kg+gEM0twVDNhARW9CK1+E9SZgVAi8?=
 =?us-ascii?Q?sb2vxszq4daV0W3zw2+bYvnNVnbi+R/K9dVBGaG+EXUPbGD/btSetkjWCRJa?=
 =?us-ascii?Q?TF2HgPJkcK+7Clg9gOc4GCYlH2OHuyoYStQW67z4lLYiAUhtwHrR/WKkHWLG?=
 =?us-ascii?Q?sN+wwFPTBbyIQ56A0TG3nWnSuBaN2vncTQx2WkjTUok6aLyjhrso7czi9iuZ?=
 =?us-ascii?Q?L/BnCkh+aF2HXfvtyKAwiNcfAdSZGEy6Nhx1Fm5+SYvItDJZEkgTX44b41QM?=
 =?us-ascii?Q?XrlikxFJjyFg+adNgtzAcRW5sQ+s27OP6GyL+8gpV/sPy4Rckpf4XOxdvYbi?=
 =?us-ascii?Q?XsttjnHEVeEzvIzMGFvdzqRllgX/qJg0ZjPQGVGdxBEsCgrr+lZ7vfAT/P1f?=
 =?us-ascii?Q?Ah+AiUyJzhD7NX4LOFBXlBhaUCfgc/fookCXDBA0Edh1W5METLoaUwfdmEkl?=
 =?us-ascii?Q?txw2vg/PDryp/sJQvXwZJkRNr7EzsfG6QZk/JJ/bzevHSZHNRFo0BWhrRLqe?=
 =?us-ascii?Q?jqaQb84/b8ksUM15+jh7BsJM6oCkU0kvg/bfTdxx2JXANG03EABniOP9wj4v?=
 =?us-ascii?Q?jAA0rh6ysrs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6X3vy2zjndqF9/8Uu6FhM8mlfJhKxWcfKBNUO2iC5fVn3Oow+1oOTIwzmaaP?=
 =?us-ascii?Q?0gFE840yCjLUrK1Qcw7M1tOWzfngBDf8R/badv0OMu6I3xGfZscWv/lSPLkz?=
 =?us-ascii?Q?GdbfCfZ/6348mU3tK4beN+ZM1MTGgr1l7I30O7wu7k3Sk8j6xoew7XocKEHE?=
 =?us-ascii?Q?sCy4jTzY8ldpKRpkIhHLQGfXJEYSNIcxmn9KluzduahVSUrjHfUctYOQmw1y?=
 =?us-ascii?Q?SjqrXYrMQkk7KOGp6nl6aLFUg3XC3GiFwY5T8EcAJRV9lT8e4QchXK3qS7BJ?=
 =?us-ascii?Q?C8KdxaSoXf1m9Lwp7uumYrhGw+YC1RvmPXA4P0aa5/YfVw0mwc1j97g6h5ue?=
 =?us-ascii?Q?mX3DGxCeOhIrw2UlbKZkbVoSUiOsg1ZiSG3Vv+Rt0QIucDD5rUQ31Ud3utnJ?=
 =?us-ascii?Q?MVUF5T7exp8oWCG+DYeptuvly5hq7IsvPUzWWirQZ2zmLt8PPwbcJts7jjr0?=
 =?us-ascii?Q?aKqqVCX7O7S2eA+Kq8G+yagQJecYgmF7VbVJUCd7dJLeKxL5sZA+v0bpObNp?=
 =?us-ascii?Q?ogIqp3ck3lwOPFCpvkvKtlqYdrPUj7P8pTPqA+O6hWXhyCpxKDNAzwLvtM4d?=
 =?us-ascii?Q?Oiyh9DTtTuK7aryXBshIyeCcbcJJIGb+ouT9umbuqxuQFohdS1UxV0GLlVte?=
 =?us-ascii?Q?weSbwXOKWCDsUATZP5cihaJRiuBGZO3M1iMwB9dSuaqOsUVDvehTQlT5YRhh?=
 =?us-ascii?Q?odcCuHXMQclbBszvVCT3ob/hugerlwb74PqjkGgQe0DrRBq79jZmflrmr03C?=
 =?us-ascii?Q?0C2/GBhyaC4juwQqAZWcifpxzlOpyHxdRbIV2wZl661/ZYC4O7LxBaKH4x/a?=
 =?us-ascii?Q?dyBLZfHifY5MBSfoVyWErQ4p0NJ4Lr9LHOUlOnZUSOCPjKChwRlquB38PHbz?=
 =?us-ascii?Q?WkHsH+Yg1VDuLKiajWpt77nK/ewJbgbtwH+d5U4jvsO0tyD/1G5KhiRKRq5W?=
 =?us-ascii?Q?20mqCQ2ns+vQmmd7ACxlQaregbnudY8R2fyu3jU0g04MrNB9dZudG8KNhBS3?=
 =?us-ascii?Q?C5Zpph5u86KS1vJPaRNtPlgrcsHXsWw3t5ayVzqDDSK98645EjOqU83rzq1U?=
 =?us-ascii?Q?xX1J3D6Vop2fZ0EhHpB3fM8Rjof2LyBhuvXlDFI5+7Ddx1lR4cfFTR5E1aYy?=
 =?us-ascii?Q?jVZ4YLxapCo9/6S14qTZ4x2+vMUt+rUqSZP/MAmJ3kmoDRi4MZkhKXHmWVXt?=
 =?us-ascii?Q?yx31kx98zcQpvjHHzWIs0ohs3Oef7L61D2BHIGvFGxFSErqHAxk9QVGoKwUf?=
 =?us-ascii?Q?uzsTEdN/rFBQrH8INcv07ygDGIROcYOGdbyoUJeiGfRdj24fNtkgCnUeEcF2?=
 =?us-ascii?Q?Xxy/+VhTgcPxOX0u5NLDCvtAhiEK+5UmRabMMIW+RS1FL8HoeS6y8GiFkYCL?=
 =?us-ascii?Q?P6SJFLfcVxsttvjh95Uq6hI/m15JNzC1Fp248q6SNUSxTyr0GwZbRneWZgfo?=
 =?us-ascii?Q?TKpvlvDU/+kf6UPhN1tYqDW8jQj//KNpJOnASDPck6QR2OTod5TxLMgR/ILk?=
 =?us-ascii?Q?SIKv+Wn5CfDL9FvvOXDQQbCvtiS7aPIvxikcnfFtVPcoMTQaadZdgXUQu5Cn?=
 =?us-ascii?Q?1AcZI62kCVKBuZhnvq8W4qbe1YtXC1ItQyxk0ZV4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24f50c3-e0c9-4412-07df-08dd9dc86d30
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 09:17:10.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKCdJPVw+9ScYjvfd/xMcQBvKdUFIx9JpNH50lPafZevL/aCBAhwHJoyIZ5648WJJt41yI3Syf9KfM13SNIipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564

On Tue, May 27, 2025 at 09:05:49AM -0700, Stanislav Fomichev wrote:
> On 05/23, Tariq Toukan wrote:
> > This series from the team adds support for zerocopy rx TCP with devmem
> > and io_uring for ConnectX7 NICs and above. For performance reasons and
> > simplicity HW-GRO will also be turned on when header-data split mode is
> > on.
> > 
> > Find more details below.
> > 
> > Regards,
> > Tariq
> > 
> > Performance
> > ===========
> > 
> > Test setup:
> > 
> > * CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
> > * NIC: ConnectX7
> > * Benchmarking tool: kperf [1]
> > * Single TCP flow
> > * Test duration: 60s
> > 
> > With application thread and interrupts pinned to the *same* core:
> > 
> > |------+-----------+----------|
> > | MTU  | epoll     | io_uring |
> > |------+-----------+----------|
> > | 1500 | 61.6 Gbps | 114 Gbps |
> > | 4096 | 69.3 Gbps | 151 Gbps |
> > | 9000 | 67.8 Gbps | 187 Gbps |
> > |------+-----------+----------|
> > 
> > The CPU usage for io_uring is 95%.
> > 
> > Reproduction steps for io_uring:
> > 
> > server --no-daemon -a 2001:db8::1 --no-memcmp --iou --iou_sendzc \
> >         --iou_zcrx --iou_dev_name eth2 --iou_zcrx_queue_id 2
> > 
> > server --no-daemon -a 2001:db8::2 --no-memcmp --iou --iou_sendzc
> > 
> > client --src 2001:db8::2 --dst 2001:db8::1 \
> >         --msg-zerocopy -t 60 --cpu-min=2 --cpu-max=2
> > 
> > Patch overview:
> > ================
> > 
> > First, a netmem API for skb_can_coalesce is added to the core to be able
> > to do skb fragment coalescing on netmems.
> > 
> > The next patches introduce some cleanups in the internal SHAMPO code and
> > improvements to hw gro capability checks in FW.
> > 
> > A separate page_pool is introduced for headers. Ethtool stats are added
> > as well.
> > 
> > Then the driver is converted to use the netmem API and to allow support
> > for unreadable netmem page pool.
> > 
> > The queue management ops are implemented.
> > 
> > Finally, the tcp-data-split ring parameter is exposed.
> > 
> > Changelog
> > =========
> > 
> > Changes from v1 [0]:
> > - Added support for skb_can_coalesce_netmem().
> > - Avoid netmem_to_page() casts in the driver.
> > - Fixed code to abide 80 char limit with some exceptions to avoid
> > code churn.
> 
> Since there is gonna be 2-3 weeks of closed net-next, can you
> also add a patch for the tx side? It should be trivial (skip dma unmap
> for niovs in tx completions plus netdev->netmem_tx=1).
>
Seems indeed trivial. We will add it.

> And, btw, what about the issue that Cosmin raised in [0]? Is it addressed
> in this series?
> 
> 0: https://lore.kernel.org/netdev/9322c3c4826ed1072ddc9a2103cc641060665864.camel@nvidia.com/
We wanted to fix this afterwards as it needs to change a more subtle
part in the code that replenishes pages. This needs more thinking and
testing.

Thanks,
Dragos


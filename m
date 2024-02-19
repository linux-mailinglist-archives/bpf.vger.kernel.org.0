Return-Path: <bpf+bounces-22250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4EF85A2E9
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 13:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801C3284653
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3442D605;
	Mon, 19 Feb 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKFTW41A"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8712E620;
	Mon, 19 Feb 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344798; cv=fail; b=SfyUCcpLg9+gVxc/YdV0M2P/E2gADLDpQ8kw+zEG12Z4z/zx27pbszV6tn2Z0HHL3vn1Le1bX4kF6smXP+na3J3sK+5UnS1q9W7h6bGdEXdDnHqCYS0cJlt75OadGST0A2uVPutcCK/F1+Im6y3GtscJJUjh5Y51nUvgAKTmUgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344798; c=relaxed/simple;
	bh=PnSbytyJSaftXPQLerwmFUymUD9y2mNSlyqQUDNfqOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NeZPvdI2H8GokjSJasndlv9Um/5XjG6hQ+HD0MN39jIWcnjiikKsftlXTAxeeUxHvM647KtVeU517CJqRsMN+XGyRLx5s8mDKKC25JVXxDgLjInv+ym/QUbNjpwEzah2OSOqezSqzITP/Yo60PrbmkKaWRXVQ/VG3AwgSuxoTYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKFTW41A; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708344796; x=1739880796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PnSbytyJSaftXPQLerwmFUymUD9y2mNSlyqQUDNfqOk=;
  b=UKFTW41A08RURRDu3pjl+4MzvnystHqHGV4GDo0iFrZywU+V1QKo7WpE
   c7AkH4lMdj/bzQ+ygHM9hTkmQIwE/s4A9A+VUf9yuPCp1FyrwKEOXynCU
   W6cNE9QcBUuNdw2XR1/9P95mchD6+GC01stEepf9x9RCwJYg6WhHXd0/M
   FO3dQxMCLFbNslLIWDbcXLELNDXldBBHFGwYbigjs5X/gl97p9Wi35VOd
   x0CDTrz4NGu3YZOFywhB3bUPhETtCJ3tRekikTlq1WhSmKphy+jThCTMN
   dOE0cNVKiJ3KPIOU5FaKUX7WxnBXkLPMwZTxMVZo2jGD39hQxNCgDHtte
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2323882"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2323882"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9099485"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 04:13:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 04:13:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 04:13:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 04:13:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlUlpo2gDVxIDrNMuZM7srGE7SgNFdXks1szHCyg1AOK+M4rFNDBv3Rpd8xUEL9+rtkhO9IVcjHMKIgg8kaeFvTyxdU/EElvO8og7Qi+E6eMUiC+K/OPQ/Ra+LsiLV4YTL1c6mBs8zxyDlJFADIydHfiY7oPJ1tyynbG+fIVtiUg68DVpdlHd80266KWRyha8j+GIphJhgZFGp1vR/iY8J0Ti1ZS932KlDNACuC4/MI44MfBp/ShfqJ0y1Y2vSVYwDzCedNMp4IEx+OfYOvTiwjKAewaTcwoSeRgfKaX0Hhv980vXFcbQ0SRwX5e3ChLxe8zNFTDdqI7Q1k+Z+xXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnyhMm8T+6QkouziiMQfmSaEypXIMPnD1nYL74ik90M=;
 b=oZVZ6JGq3J3pYwim9gY820pCB/HR551FO+oAJUCp35MhXvhhALXEGL5+i0ToEfSSzLSzi8ZtDS+Ifr8qW58hg7dpgF6FvtQUT0MDFmIIo6FSyZZQg3EPKQ9+Ub8tTy9gKoN0dBM8ZYtsnDLQhNY3WrT2DY+IQJKeKApnjEovuedBVdv/wGeZc6Ua3BuIP44bTY5ejo/O2PBVkR27MHy4Jz6H63FRmzIrYWoo/96JmJtEtyj3eIlHAL0CBVZ1G+XGRVTOKyNWLAqm46eBAez7irZsdptr6SZNnRIIZ0HR0hjTZ+1NdUMG1uCDeBOsBbirwNf4k2LJ8/QRWqBQvCrACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.29; Mon, 19 Feb 2024 12:13:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 12:13:10 +0000
Date: Mon, 19 Feb 2024 13:13:04 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Florian Kauer <florian.kauer@linutronix.de>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Jithu Joseph <jithu.joseph@intel.com>,
	Andre Guedes <andre.guedes@intel.com>, Vedang Patel <vedang.patel@intel.com>,
	<kurt@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net 1/1] igc: avoid returning frame twice in XDP_REDIRECT
Message-ID: <ZdNF0ArChUkGzk42@boxer>
References: <20240219090843.9307-1-florian.kauer@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240219090843.9307-1-florian.kauer@linutronix.de>
X-ClientProxiedBy: DBBPR09CA0041.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::29) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 2317593f-1a63-4e60-86df-08dc314423c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9Is87oJIl9rIQ9CtPhV67oItodjb30MmYmQB4Y2w11xFkRTZBqCmXPVYd7DpnJNpZuP+7A4gF0EGiqTuvZxh0h1ZLTbBEa8vXIrYb55DSqnW4hNiUffpfGtACetNEAs9U9k6/K3bkl/Kc8OcFP52GVf/Ee/xHULOmZyY3Ttc9UONhfOb7W0Y51z3bFykoqP49OEM6rVnFOOPKSnkNiUJXiiW4O4zd4/kK1DCtg+nW5e82g8KA+xjY6OKPfQe2AWpYn3LTx0m2kst/oPFaJN7yFuLG2QANizgjyCbOxwNw0aBkKNcdsphK4fI6sxVbQ5+YutmRyzQsOmYjJF4j0UNoce3ZguoRbkaBwNuqGASB+LZBSaTbHgUWzl90qWuBo2bmiEBLL8yH9r+80P44KR+lhSRUC6K3I9rmpqpI2/fe98Wx5TFCmwCLwU2SaxgnOwCc4XbYXVgZkTDtD9gZUSAXPUCfxy0vvoovmBpqJeg37LMSai8eBIO/oSx1/mhVaX59Vw5665t2A6tu2BrM5VdWkngdtaR9umtAcZHwzULw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tqwmGu7yZhp8xAXwJe8PnNrveWwha7ZJus4BJ9jGVuvhK1LucWSoqRdPqqoN?=
 =?us-ascii?Q?Ngge7Vol1IYIR3QsyBwchFEn2jOvRfCp6SchSLx8DOZoP1Sw72Sj9WT0CYiw?=
 =?us-ascii?Q?86PfzVLjl0i1q5Lla32MYR9y/Mcj6sVy8Gc2shHzzWSjsxRs60ZK+7whtbK5?=
 =?us-ascii?Q?Z0oZg2L+6p0/RKRAwu2tzSbGFsMmb+ex2iYVd/+SkNHpN4TCM/jDLmWTIhB0?=
 =?us-ascii?Q?NHbsReCQQ/oUjwTznXsErOZPJMVdbfcbkuw3E+nk5QsHNxQCYTJ0mBZHPuLK?=
 =?us-ascii?Q?JIvVi2KL88toMpCdkyKj3zZyuC3I5I2Muqe21Tzxud2e5wdB2E9yFh6rbLKj?=
 =?us-ascii?Q?7T2xn1mJcitUNRPMgH1mcaoOQIUTI8i7bGH2fxIHP8JixWt3FmF4v2VW9Ipu?=
 =?us-ascii?Q?+2iOAAmvFqfaKmQzjHPExvZYcU0ewe2b1dsmIg+nXfG2DjHngbYrlMe5E0Hr?=
 =?us-ascii?Q?Hz6aY64u0x2sPktb9jjGorDhl5nTmrIrmKCjV2ndGnZJsUvXHWj3ESIh3itV?=
 =?us-ascii?Q?l2qeS/ifIT8fILUCo0U/NgQxUaVcC7THvosoUzCr4ODUiRY9Z3d16NvowxK6?=
 =?us-ascii?Q?SivnC3k+fDpNudituNYT5InT43xPONxKR/cgBmTO8eOzDep7ZyHymJVMeoKu?=
 =?us-ascii?Q?dQnPOQRN0XmGtg+KCemmrqwMlpooW/Ukges62kDZ2mxzLUiZ4CP1kJCLkAlm?=
 =?us-ascii?Q?JBvYnm1+LNlt4rputZyzyR3VSGBLVQMqCTmzB7W4k4aIdllPlcBCJ1ZiaRTY?=
 =?us-ascii?Q?qTOx/CrfZtfqCwSor14GsbxPlglnN+1FcU4fjPXHCfrrSkmC21X3/Qoo6Plz?=
 =?us-ascii?Q?6TvXCDtaU3IRcfLOqNc7kAMvPekc2n6+fZsi+sBR4IC9OO6Mv6o4CREhSMsr?=
 =?us-ascii?Q?IRRnRP1z3e6CEtfrFPMFF+wyJaBf+Mu3jACZh0eO1NziPl/ayyV+L3GROyqI?=
 =?us-ascii?Q?hOS7CoKdlxBhvVNWZ93GVqnLxNf7v/AMoIgWgKJktrxEHPb1S7q/yOke0pJ3?=
 =?us-ascii?Q?0S1m+7W6rzQDJ/oUCKBMUElxUr/T+9MK2rVbXMiwfjklCbUGcy0BPaYUpBKP?=
 =?us-ascii?Q?Cdob3fo9rfXpnqzvgnh8+ZPIdrIAJk04Sf6EVrVEpXyWpjxYUqCs32V7ZxbT?=
 =?us-ascii?Q?TNkB9gFcKSvkqSUQiEIqT1GzX65Odm/lxFNz5oqh1o5n6jPcdipj6XxN0ksb?=
 =?us-ascii?Q?zXuMHuE+GaQlxREgaeE9niN/sn8nnfFNP6BLHOac51EQAkHpYauVDVtdvY5/?=
 =?us-ascii?Q?Em56yQSqIxvrPLikDCzi8pSJJGbUSWzhVcVTNMXbCucAioQwLCE/ztiK7vfQ?=
 =?us-ascii?Q?fBQraq6X0UNRM/D5j9CzPH82fLWcyBZryGp0Gz5N3a8I1kQtSHQL8ZGaf7rc?=
 =?us-ascii?Q?Emj6NA9wvKsMcxjFmtAlNCeOtGl29q4GsBnpmEU2Iul1Jiar9keIHd9gf+8o?=
 =?us-ascii?Q?RHtRBw3K7vZs5p/dWPBfK2mhv7otVbXJLRvKEqnvvaphXk+BVwCYV8oHfjul?=
 =?us-ascii?Q?xuTYcWsXQrRQrAFDUUaCa85RUmbnWqB5oofpldjeJqh+Q3s9Ekb+oO+fKldR?=
 =?us-ascii?Q?p7vTlt4ao2Ktxh/VDDxvMzmda/lUP9rXoJfuwYdmzdVZtCfaQXtyzZeDWylm?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2317593f-1a63-4e60-86df-08dc314423c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:13:10.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LI+0794D0d1WMK3eZQOz79gELSXQeSkmIfE6lmii1bJj/nCHqjJTJr3MSNIHG2fiA1DqZMECKaqQOqdT9BHbziQ0q21RXbI75oE/LNHB5MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6392
X-OriginatorOrg: intel.com

On Mon, Feb 19, 2024 at 10:08:43AM +0100, Florian Kauer wrote:
> When a frame can not be transmitted in XDP_REDIRECT
> (e.g. due to a full queue), it is necessary to free
> it by calling xdp_return_frame_rx_napi.
> 
> However, this is the reponsibility of the caller of
> the ndo_xdp_xmit (see for example bq_xmit_all in
> kernel/bpf/devmap.c) and thus calling it inside
> igc_xdp_xmit (which is the ndo_xdp_xmit of the igc
> driver) as well will lead to memory corruption.
> 
> In fact, bq_xmit_all expects that it can return all
> frames after the last successfully transmitted one.
> Therefore, break for the first not transmitted frame,
> but do not call xdp_return_frame_rx_napi in igc_xdp_xmit.
> This is equally implemented in other Intel drivers
> such as the igb.
> 
> There are two alternatives to this that were rejected:
> 1. Return num_frames as all the frames would have been
>    transmitted and release them inside igc_xdp_xmit.
>    While it might work technically, it is not what
>    the return value is meant to repesent (i.e. the
>    number of SUCCESSFULLY transmitted packets).
> 2. Rework kernel/bpf/devmap.c and all drivers to
>    support non-consecutively dropped packets.
>    Besides being complex, it likely has a negative
>    performance impact without a significant gain
>    since it is anyway unlikely that the next frame
>    can be transmitted if the previous one was dropped.
> 
> The memory corruption can be reproduced with
> the following script which leads to a kernel panic
> after a few seconds.  It basically generates more
> traffic than a i225 NIC can transmit and pushes it
> via XDP_REDIRECT from a virtual interface to the
> physical interface where frames get dropped.
> 
>    #!/bin/bash
>    INTERFACE=enp4s0
>    INTERFACE_IDX=`cat /sys/class/net/$INTERFACE/ifindex`
> 
>    sudo ip link add dev veth1 type veth peer name veth2
>    sudo ip link set up $INTERFACE
>    sudo ip link set up veth1
>    sudo ip link set up veth2
> 
>    cat << EOF > redirect.bpf.c
> 
>    SEC("prog")
>    int redirect(struct xdp_md *ctx)
>    {
>        return bpf_redirect($INTERFACE_IDX, 0);
>    }
> 
>    char _license[] SEC("license") = "GPL";
>    EOF
>    clang -O2 -g -Wall -target bpf -c redirect.bpf.c -o redirect.bpf.o
>    sudo ip link set veth2 xdp obj redirect.bpf.o
> 
>    cat << EOF > pass.bpf.c
> 
>    SEC("prog")
>    int pass(struct xdp_md *ctx)
>    {
>        return XDP_PASS;
>    }
> 
>    char _license[] SEC("license") = "GPL";
>    EOF
>    clang -O2 -g -Wall -target bpf -c pass.bpf.c -o pass.bpf.o
>    sudo ip link set $INTERFACE xdp obj pass.bpf.o
> 
>    cat << EOF > trafgen.cfg
> 
>    {
>      /* Ethernet Header */
>      0xe8, 0x6a, 0x64, 0x41, 0xbf, 0x46,
>      0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
>      const16(ETH_P_IP),
> 
>      /* IPv4 Header */
>      0b01000101, 0,   # IPv4 version, IHL, TOS
>      const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
>      const16(2),      # IPv4 ident
>      0b01000000, 0,   # IPv4 flags, fragmentation off
>      64,              # IPv4 TTL
>      17,              # Protocol UDP
>      csumip(14, 33),  # IPv4 checksum
> 
>      /* UDP Header */
>      10,  0, 1, 1,    # IP Src - adapt as needed
>      10,  0, 1, 2,    # IP Dest - adapt as needed
>      const16(6666),   # UDP Src Port
>      const16(6666),   # UDP Dest Port
>      const16(1008),   # UDP length (UDP header 8 bytes + payload length)
>      csumudp(14, 34), # UDP checksum
> 
>      /* Payload */
>      fill('W', 1000),
>    }
>    EOF
> 
>    sudo trafgen -i trafgen.cfg -b3000MB -o veth1 --cpp
> 
> Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Apparently fdc13979f91e ("bpf, devmap: Move drop error path to devmap for
XDP_REDIRECT") addressed all ndo_xdp_xmit callbacks but igc support was
added shortly after that...?

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index ba8d3fe186ae..81c21a893ede 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6487,7 +6487,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
>  	int cpu = smp_processor_id();
>  	struct netdev_queue *nq;
>  	struct igc_ring *ring;
> -	int i, drops;
> +	int i, nxmit;
>  
>  	if (unlikely(!netif_carrier_ok(dev)))
>  		return -ENETDOWN;
> @@ -6503,16 +6503,15 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
>  	/* Avoid transmit queue timeout since we share it with the slow path */
>  	txq_trans_cond_update(nq);
>  
> -	drops = 0;
> +	nxmit = 0;
>  	for (i = 0; i < num_frames; i++) {
>  		int err;
>  		struct xdp_frame *xdpf = frames[i];
>  
>  		err = igc_xdp_init_tx_descriptor(ring, xdpf);
> -		if (err) {
> -			xdp_return_frame_rx_napi(xdpf);
> -			drops++;
> -		}
> +		if (err)
> +			break;
> +		nxmit++;
>  	}
>  
>  	if (flags & XDP_XMIT_FLUSH)
> @@ -6520,7 +6519,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
>  
>  	__netif_tx_unlock(nq);
>  
> -	return num_frames - drops;
> +	return nxmit;
>  }
>  
>  static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
> -- 
> 2.39.2
> 


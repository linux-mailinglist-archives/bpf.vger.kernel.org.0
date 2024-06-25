Return-Path: <bpf+bounces-33081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9D916F6A
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BD91F221D8
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BDD16C840;
	Tue, 25 Jun 2024 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H52dfcBj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C4135A69;
	Tue, 25 Jun 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337263; cv=fail; b=XundJN/mM0VWFYTTO3ZgANDHpJ2I9pwPAoYBNvnooLZmU5WX8+hrqOkcXNnZJ807ObjYH2ttJ0bQ/0SR/UvcGu8Lajk+0ywQd6DpC8Z0tyT72KWnE4BiLhJUY712wYRsVL0bq5Dp81nilnJyHfZtRIfM26UARsjwg9FD0+Lem0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337263; c=relaxed/simple;
	bh=IWdOd0/3VZazRfsjRKToXF7N5ViOU+jhrJHTu2BxStg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pK6mM6yQcCzeEIR0v4PvQFZnIgfljigeHygVLHPLtkjLHE7yssWdyBIW5ICtYPeyJVg7BUTH9p7/5IUO2uy6zvDYGLE1yfQEAri2Vv4utmcSUYyBHqMy8q/mfmq39cOPniliMepaHG6kJ6rOtPCA6/nlIK7IGIHxAWZ8/Acgo48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H52dfcBj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719337261; x=1750873261;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IWdOd0/3VZazRfsjRKToXF7N5ViOU+jhrJHTu2BxStg=;
  b=H52dfcBjY11LWxoPPvr1FjQAoDGSvqF6CAVEOiJekvzpxrBl0heHcmLR
   C1fV4fHITlNJVc8+PgEy1klR6Ao2ypenuh39E0+rPCuq2VzyMlk0AHDWT
   GDg0YnCGk/ADKxLTcp2PIJiIqtKacc/BetVWXBtpDettNgbrzg3mi+BrR
   BCWha+pPF6cyAVbHk48t1Qf9l6lfkjVuibXZI44E8q8B1DwPxw9Do4rnw
   7DLUpAoOygx3uWXSYL2BhOXPJTMgCTVGU5wdGh58sXtLjpcH81rKcM/Bs
   ODdpEW44VbqfBpUGauFDLg6PA4/HCpnOu06U3+awa4RMyJIXV7iB5k/Ui
   w==;
X-CSE-ConnectionGUID: Xl0poy6rTpu0U/GyK1i71Q==
X-CSE-MsgGUID: 1ao08ljJTwec1PkU9IQYsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27778021"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="27778021"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 10:41:00 -0700
X-CSE-ConnectionGUID: FX1064YvSkeyub9zpYf6QA==
X-CSE-MsgGUID: 819PvFygRTSJ7tj8aOcceA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="74943487"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 10:41:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 10:40:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 10:40:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 10:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoC+3lEEqZniQOWAQXufV4rNNRRPkh+q9h1EOkh4YfQl51kZKdnS+SRVsEYO0bVv7dE861eiqPgZY6lZ8w30AirYD2R4dAQA7Tz+MXw9sCgEL8Mk/KgtI2FPCyPkB9pvAHZW6uw0nSCI9aqpDoCSBRtdG3HIjg7Z44XZTGCKvZjJvlpvQntmI579R0IOmbSI8tRPzBuO5N5ReurlDUrvqTZOp8Ck53KiMeCJ8hxIKrZhYth40CwO7/f9N19LfJEZJYYwXpoH6sL9uhil7dGtpnmHVHNydmbzxUDjkKG5o7SoZ0h0Q+/10m5vsoHsta4NmKf02vuGXfETmqIIEk/aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX3witLNwHGzqBUaVwlUNDKQxINRJBiZJvBzfBFCJow=;
 b=Nqe5UYF/buxvRyrlIlrkEugjc66SeN7tmUVV+A6nSbX8/m11TwuQpIxwdJBA9k1xapzvEm10gATonldPwTpbOM1ru3tGluMXs7sKTMwec27OWNQthbpPhYjsgoZlzg2WMe+ONIuDpT2/zlxlHVdy7gr24Cby9xv28TM+R+o1vaMO/ot438UXRffNFaGFx3IlNfTiIwOJLYlpjheBlejDXIaTI40yvgokNcegBikhlbkA8zvQAIquLdB7c7/XVoyB0Srnh4ErJC8h8Q0DVqgBZ5XG3ZWATAR2oATLlTjNP0DdjkDJzbtOVT7RzI8lPyK16E16NS7ZP6fIIkl3mZZ8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 25 Jun
 2024 17:40:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 17:40:51 +0000
Date: Tue, 25 Jun 2024 19:40:39 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/xsk: Enhance batch size support
 with dynamic configurations
Message-ID: <ZnsBF//QuXQ9Nyix@boxer>
References: <20240619132048.152830-1-tushar.vyavahare@intel.com>
 <20240619132048.152830-3-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240619132048.152830-3-tushar.vyavahare@intel.com>
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: b7499f4d-48a2-40d0-ea83-08dc953df4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?15W6Nygh3vhsNnxg0pZ9HEkoaCYmnojR5Is4gZv+bObahQO27zf3XdEc2tOh?=
 =?us-ascii?Q?Jom1kF1tL6V7skz2Csc/FbZEIPF8LKbgZJUAfLO7G7brsLJ6DS0VEXlq1ZAp?=
 =?us-ascii?Q?CvXLz2PkB01nTLJaWFCFu/eDqOO9GOqtGMZQwJB96Hz/rFT3pktT68bb0hbI?=
 =?us-ascii?Q?DYEn4qfkar4ReZtxo7pwVO96TPpirkNcXKvWNyRjVwqb/7+d6ATsPrCuy+i9?=
 =?us-ascii?Q?NL9Q1C47Gmgn4Z/I+s1bCMom1nmP2qvREethc1aPQuxSyDvldQxyBVH4AwH4?=
 =?us-ascii?Q?xcGbKBT+A5L6PvXWz/LQSC+aj7XmGOf/kSpYlRKTzlz8wXGk7x/Qjc4sW1fP?=
 =?us-ascii?Q?DT4JoPviFava57/RB/RzN/JrDzqkDRrMhtfLzqZyfABb/qpmHVgDoqyfzrhW?=
 =?us-ascii?Q?OxzuW3s6//0tNpNkIgecXEA1WCoizH0cry4SS4vwo5yPHFkgO0w+bQCfuLCr?=
 =?us-ascii?Q?DmLmpVtEKe9sBANpjc50ZgYQ4izDLZST1cxCaUlCiQYyJTYpfu2USBTgRg8A?=
 =?us-ascii?Q?0Tf3lxJddpVLEPnB20C3yR2/9DEv3TvdFryY7SBl06ZYvkjs+klxriXwXH+l?=
 =?us-ascii?Q?2WJqvzpLSwVsItLe22V6M3xEt+S+r3CFHQyO1YT7S3Q+mf76KF4cA3CW6y7Q?=
 =?us-ascii?Q?gj5n2pVs90ecJ4Im8i1lULReOGKiWwYwUSg/EtYTE48Z9p6b3MdmHTuv4Q6O?=
 =?us-ascii?Q?fn1YG9p7fwD5An0HYttolwwjWB8vbieMcj9O2m/KE5+K7WWjv7snJUeI8rVS?=
 =?us-ascii?Q?6RnaH4k6d6CQQ2LhQuCfvP0MSaENgKbqtG2asEZKN9tVV65LdeZX8J//z3Ia?=
 =?us-ascii?Q?2yuBXZFgvdlgMc5gqkmK4YilEp+5ZKQJVc9vTWPjGwik9xxeTPTfOR2S4mVT?=
 =?us-ascii?Q?FvNpgwfAblklNGI8l0nN9+udqNbIeQJ8rjeU1yXVVGtJ9F+BpaulPMh33TfQ?=
 =?us-ascii?Q?vIaLXRcnbso+ndfZbg8nFd+oS4XM/DRs7Ohe6yYgnwDXHw09s5osARh1eOZV?=
 =?us-ascii?Q?kUY9S+FUamGVGl050798zF0VwjI+CbypGoYXvewapgpBiOMtwYf8muvRiwpH?=
 =?us-ascii?Q?xu1XQTwc5wGy2cXppbeR5MosfoBUWh57Ca2BZ1wpoJPkcdlkOoZHvHBlJTVY?=
 =?us-ascii?Q?Zp8KI7RPSHRFQCTZdvx5N5+d88ndamvUs2ETocL14HLRUoJiD8EbMfhGz5M1?=
 =?us-ascii?Q?3bsZvXYx3/YtOedLSajBDrMflP7iJ+w7HSgzIMdh8E8HkMTDw+iXYoDVjz5M?=
 =?us-ascii?Q?xVNbiDOzryiTMIICB96LmcqNjn2kHB1cqroXILZykpw8ww14+4gK4UdDYHsl?=
 =?us-ascii?Q?FHgfw6nQ89fLmH2eQiZXn+Cn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DtSNePqtzPEChxjVaIxzDgQ4Kxjyr9XztoWdWoLZzeaSR5FNhfJoDiPiLC8t?=
 =?us-ascii?Q?tmc/72jzSQF5dKUE52QmDa0g1KNP8qjcfdZMrwa52A4MZhhSjfFFCgFB6krM?=
 =?us-ascii?Q?xPbyKPwd+56eCqCBBZ/zGs16c13gzv7SAPxNwB7h7TdY+LmWe6uYFfayxF2k?=
 =?us-ascii?Q?BJOVBPrAuUhsqFin6LQ2SC+eiie5r+nwFYjST1N/VWXsnUCT/y9syjIiB2YF?=
 =?us-ascii?Q?9+0N1rvGKnDWhTI36h7A3lfZ1xt2JSIbU9/7idDRG6SodDJfK+ni24p8tA7b?=
 =?us-ascii?Q?byUdk4xKzUundrnCoN5ozrNu5W4/AS2tF5PRxa6750QAPU4JGzPTHuQgEctO?=
 =?us-ascii?Q?+nK3MT+EmWkQqEUR4amIqpGmkU64nFFuUnp0JCgnpgclLk20w0riI9uUP7XA?=
 =?us-ascii?Q?+30dfJzh124cnHkHJpkL7BrNjmHXOcCmvedeBG6Rm2vbots0DgPfijqH+psI?=
 =?us-ascii?Q?PYW9rNnqEyLrU/s87J2kPMMF46zpvGqsT8RmUbVNKXSv6FDSHcsJaRh6lCWU?=
 =?us-ascii?Q?RI7XakgUdgnB+q/NDS7E2EQakrOBvvPv5EmQmXscZqJp74aPHGwHcqzaDKF8?=
 =?us-ascii?Q?ozIhGZjW+QiqQqcHdD1q/rlVtg2e5HUbUX7EpfM/qsjF3YeonFPo2A4W3Ghy?=
 =?us-ascii?Q?TKuOEFikDi7WiOVgfbc3YZlb8IWK4uUVDQlN7jLPx4P2IUNyRBOCCdWe4z/I?=
 =?us-ascii?Q?3bf5LuN74GL6QR48tfpO0mXw/Ck6XN9kxLtKttt7zgTxUNc93JIpZGDd+Vzv?=
 =?us-ascii?Q?DTABX3y3Duk5hDM7kyRgok0hDewcTZT23JmeBkG7qNGPhL+cXZILKKFBFeo6?=
 =?us-ascii?Q?RzlcylIejUI7Ct1xsHcdjHKjaB10TlEEAyWUnu2cm7/WY7DL4CdI9fpVSHs2?=
 =?us-ascii?Q?3Y/awNmTckGLzMrfgIk2xRUlmctZdL3hbN+nEluoiVMwPdWkg4RLb+PveJPN?=
 =?us-ascii?Q?6QS3qUvWts7kcGD5gJo/fvhBoc8R5F2TQKWL/3c/3q47IXqdxI8l/IwCntHS?=
 =?us-ascii?Q?OCNnx+seWZBdJTJIyKd9P1j5045rcNooXrFXOzmrGhJHcTURC2E0XqTlpUcr?=
 =?us-ascii?Q?coD0gXfKnlq1W1XUuvM6F4fdjUDnDP2ajFOWJGP1CbqEXTuqvreHmtRLl+Ns?=
 =?us-ascii?Q?QaOW0qF6gfZ7upXx3nifL3quFp+6BQ9OCTXrz312uU80hPGEmNFF1CeIQIi3?=
 =?us-ascii?Q?114oxKpjwLH3JVE5f2w8gDChFuPLBQBxaUov7Q1hwYvnM0xKnsHeWLSQs6Ij?=
 =?us-ascii?Q?EJ10JTb2XQHu/AW9JR5qPO0Q3q+DkpjQqQhw++VOMe2PgzUgrh9GD6FCpSoS?=
 =?us-ascii?Q?q38BBICk2A5QBOXxwRGnSkmBdFWWFvAyaxAcnty6O5HcCR/CnbocP4HThhgg?=
 =?us-ascii?Q?ZjYpLGp0Lu8IHy9L9SdpRAv/fyr7So2rW1FhNV1/edCXlHMXJYBYkPLufaXo?=
 =?us-ascii?Q?GrZncvqq3Gb75vmXYSOwlLWpGR9nbJSRR4/kzg05aFTGqNwfEGrCnQ99aSkK?=
 =?us-ascii?Q?2M6QvboRg03qBc5Bw8InYZAaHR9Sgw4R4Ygw0Jt1QmNfbEe+2fyY53yvXf7i?=
 =?us-ascii?Q?W4J99fvQqtPm8x0w8nEf+xb342gXF9jig88J99qtJjzRGi5NLg5ApHr0AKzD?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7499f4d-48a2-40d0-ea83-08dc953df4b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 17:40:51.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WHBXVJgt+sLwM2vTKdo2ZiD0CX/dA8qVYaf+k3mYW94nUKi7zVf1kwEv/G2bUNu2n3ycfERFwpGfTjSozifWu/Meh7kXU3Dpmng0/8bJbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com

On Wed, Jun 19, 2024 at 01:20:48PM +0000, Tushar Vyavahare wrote:
> Introduce dynamic adjustment capabilities for fill_size, comp_size,
> tx_size, and rx_size parameters to support larger batch sizes beyond the

you are only introducing fill_size and comp_size to xsk_umem_info. The
latter two seem to be in place.

> previous 2K limit.
> 
> Update HW_SW_MAX_RING_SIZE test cases to evaluate AF_XDP's robustness by
> pushing hardware and software ring sizes to their limits. This test
> ensures AF_XDP's reliability amidst potential producer/consumer throttling
> due to maximum ring utilization.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 26 ++++++++++++++++++------
>  tools/testing/selftests/bpf/xskxceiver.h |  2 ++
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 088df53869e8..5b049f0296e6 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -196,6 +196,12 @@ static int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem
>  	};
>  	int ret;
>  
> +	if (umem->fill_size)
> +		cfg.fill_size = umem->fill_size;
> +
> +	if (umem->comp_size)
> +		cfg.comp_size = umem->comp_size;
> +
>  	if (umem->unaligned_mode)
>  		cfg.flags |= XDP_UMEM_UNALIGNED_CHUNK_FLAG;
>  
> @@ -265,6 +271,10 @@ static int __xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_i
>  		cfg.bind_flags |= XDP_SHARED_UMEM;
>  	if (ifobject->mtu > MAX_ETH_PKT_SIZE)
>  		cfg.bind_flags |= XDP_USE_SG;
> +	if (umem->fill_size)
> +		cfg.tx_size = umem->fill_size;
> +	if (umem->comp_size)
> +		cfg.rx_size = umem->comp_size;

how is the fq related to txq ? and cq to rxq? shouldn't this be fq-rxq and
cq-txq. What is the intent here? In the end they are the same in your
test.

>  
>  	txr = ifobject->tx_on ? &xsk->tx : NULL;
>  	rxr = ifobject->rx_on ? &xsk->rx : NULL;
> @@ -1616,7 +1626,7 @@ static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
>  	if (umem->num_frames < XSK_RING_PROD__DEFAULT_NUM_DESCS)
>  		buffers_to_fill = umem->num_frames;
>  	else
> -		buffers_to_fill = XSK_RING_PROD__DEFAULT_NUM_DESCS;
> +		buffers_to_fill = umem->fill_size;
>  
>  	ret = xsk_ring_prod__reserve(&umem->fq, buffers_to_fill, &idx);
>  	if (ret != buffers_to_fill)
> @@ -2445,7 +2455,7 @@ static int testapp_hw_sw_min_ring_size(struct test_spec *test)
>  
>  static int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  {
> -	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 2;
> +	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
>  	int ret;
>  
>  	test->set_ring = true;
> @@ -2453,7 +2463,8 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
>  	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
>  	test->ifobj_rx->umem->num_frames = max_descs;
> -	test->ifobj_rx->xsk->rxqsize = max_descs;

rxqsize is only used for setting xsk_socket_config::rx_size ?

> +	test->ifobj_rx->umem->fill_size = max_descs;
> +	test->ifobj_rx->umem->comp_size = max_descs;
>  	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
>  	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
>  
> @@ -2461,9 +2472,12 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  	if (ret)
>  		return ret;
>  
> -	/* Set batch_size to 4095 */
> -	test->ifobj_tx->xsk->batch_size = max_descs - 1;
> -	test->ifobj_rx->xsk->batch_size = max_descs - 1;
> +	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowest bits when updating
> +	 * the Rx HW tail register.

i would wrap the comment to 80 chars but that's personal taste.

> +	 */
> +	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
> +	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
> +	pkt_stream_replace(test, max_descs, MIN_PKT_SIZE);
>  	return testapp_validate_traffic(test);
>  }
>  
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 906de5fab7a3..885c948c5d83 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -80,6 +80,8 @@ struct xsk_umem_info {
>  	void *buffer;
>  	u32 frame_size;
>  	u32 base_addr;
> +	u32 fill_size;
> +	u32 comp_size;
>  	bool unaligned_mode;
>  };
>  
> -- 
> 2.34.1
> 


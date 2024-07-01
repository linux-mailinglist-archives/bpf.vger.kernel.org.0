Return-Path: <bpf+bounces-33511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C491E586
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50831C2166F
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193BB16DC0A;
	Mon,  1 Jul 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dr6jY73d"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D8713C908;
	Mon,  1 Jul 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852079; cv=fail; b=EcCuUcu/dHiKIa/B7FLNk/UMaapkJw87bmHEvBd2c6wQkRC6DjzOZdYU9Wo53TUVRgvUR56EDXauov37Xy7vxH7DpQFnpH4DevO/1Bq12tKiFcrkDj3ZMSAK+PL8uQdn6fo7gYGUbiHy8nIkuimmtperQaoYXnHcPwkMVDxz4T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852079; c=relaxed/simple;
	bh=PAMlQgReCQ+Y0uJ8cRJAEIYri2p840O2WgZ58TMM5xk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h9Ts1UwEGKjZO8aZB3fmg9xhyJH3+F45STVertYyJXhI38C7fLv+MG9vJqfR1n4mf+EnErLq+wSX2e8xGcscNM7WtOldlJV3ez8ghVrgrqNlpVfG0iNFjeWYHyX7ezYUKN4YQnPxH6ejP/u/7uP8HU6BBpnsDHVUeuRD7C8o56I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dr6jY73d; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719852078; x=1751388078;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PAMlQgReCQ+Y0uJ8cRJAEIYri2p840O2WgZ58TMM5xk=;
  b=dr6jY73dbAKSj0EwsK7Igw1fqWIsepDKiai1DJPxocRZ8VYFZvpnfLFJ
   PcLL5N1ctw6dnbutMmoL3tXNt44bBTKGj7HvfbeDCvDfGXru4nEp3jJY5
   oP4ZArgVpX/z+zpxlcXggvtMS1L7IMYpLT6PWM/Mpn+UpmkjJEpUs5fNI
   u3SlJLls3n4BG3WXV7pm+TuSwSt+LsmWKaUq53tD25hvUnHKYzKZSst8U
   dLKhUHqW4fKCEinG5bg3q4od1ueeDJpwlXwA/JntpL4XtK6jLgb95yFMb
   Of6umhITPgSlsWIChL3ha3oZdn8bC9S8aXgDZD5Wjt+bhwImpSM4iCtGz
   A==;
X-CSE-ConnectionGUID: 5RpZoPf3SJmzJTR/L1NjzA==
X-CSE-MsgGUID: 8+wNQaQYTImoAnDFMFMUAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="42417331"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="42417331"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:41:17 -0700
X-CSE-ConnectionGUID: Y1ZL276MSiajPpOXvf6qgA==
X-CSE-MsgGUID: AhhNMh6wTZeqa/RNFqvOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45481027"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 09:41:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 09:41:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 09:41:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 09:41:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 09:41:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLUNDbZYvEEHEV5ZFjj5PFZEwrTIwe976AmVuI3TkKHojO6nn/2CgbQt5/J1N2oeQID2b4AUwXvYR2Rwj2SKjpYb5LpDe3zmUdi5aYNjoUJb7pwtZCNOx7U1pIJxTpOrAKjFqrSHDujjL7kJI3MxPla1ifgqIJGPM8L+S7s/NVHjvj8pg5AUajA6rsaS+4KVP6rULFDDTr6TWpFSyd1Iesfh5cFiSDIrvdH3nAjaTH0YNtKWljVRU9yrivqfPtwOKFpwz03byJ1dmAgRFq6qTBZEK7Y9hjzMo+NsCXs1kl7B258edK23vFHPHvsnKoksI+v7/jiKQMf+mbT7xZlZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfSOG7RhCLgXOHyUKwe9wFpkCpz3RrUq7bLJeyvp7Mo=;
 b=JxQZ5gNXCVB3039NnF8eVkRdUimhvhgfxL3n4NTkNPBUPhmk19bro3JprPc6mj+86Uss3SA5q4qFELsl+rAzlVsNMvq0TafWfOUOkjUzRTsWHLmLjZOjjzlULt+nHP9GML9WlL0SyFW/PDnMkYPBJEFSifBE3HluNjGywD8BtbqrdCJyCLfen3em8mm2+4514tQJp8xOi3pPg3BZRGkwGZHXCh3HyJWJC+djLEM7s7S3cUbFtYJX1bs2R/517WF8uvbsNmCJApNGhT5wgVfWBBGdn3Wxqo4KvS+v1FlQg4AsXIhWBYPRtz3Bb99CPyLg2qhGHbsXRlpzEK9ldKi3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Mon, 1 Jul 2024 16:41:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 16:41:05 +0000
Date: Mon, 1 Jul 2024 18:40:52 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/xsk: Enhance batch size
 support with dynamic configurations
Message-ID: <ZoLcFPyFv3pcqPTT@boxer>
References: <20240627043548.221724-1-tushar.vyavahare@intel.com>
 <20240627043548.221724-3-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240627043548.221724-3-tushar.vyavahare@intel.com>
X-ClientProxiedBy: VI1PR0202CA0025.eurprd02.prod.outlook.com
 (2603:10a6:803:14::38) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ1PR11MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e70a85-55fd-49cf-a1c3-08dc99ec99c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JqSL63nRDYeXe10vyzSgQ/sPdHR9Mj365rmhXhlS1lwgOv9NKo0QGTbQzps6?=
 =?us-ascii?Q?FyhGt1pRo3Pr2DGrwzAmz3KMEwx7Ct1KDm6i5Y2R3Lteh9ZwJpAAUaiRu3rj?=
 =?us-ascii?Q?rTfeTwzKH7RrRirrJ7reF39noSbbwuykm6vZ4+dbTjJowhlFUBX9/jBar4Ps?=
 =?us-ascii?Q?Gbvd/cNNcBrqPdfJdfz8sFAaIqD8BWLv5Cj5WTA23Y6x2VVr231z7xPKJjOF?=
 =?us-ascii?Q?WVy3kUZXdH6ehVZDXVVwmu2LhCYurr6iVLWVpjysG7J5GV7EiDujorc4VmoJ?=
 =?us-ascii?Q?e+LspKaFXwXZd32136rOlYW5hw4Ft7fX16lBqV/x0rx6n6CNInvKx1Ekh8Au?=
 =?us-ascii?Q?WKgtF3PAceJTovIpHWyzV6I0LgTG8VycdCi6hc+8NDjjtoQhnvKy5/O04Ix6?=
 =?us-ascii?Q?Yo8xHIErWBVrumg/avs8QBts66pyQzDzV91WpAHYNj3xfDfWRL8Ke8cafZiV?=
 =?us-ascii?Q?qDbX0/FjK9Xrs86tg0iKX5h6M987kGGSYXoUnlOJNKXmVIQkXKXhFMSiV4V0?=
 =?us-ascii?Q?WSPaZh8IYVUOFX80L+j4AW93KFL2D67aX8fWZRLVAydLhB2QYCfnU7h5CZb1?=
 =?us-ascii?Q?e5QiZoeR4njfFAiHG+wV5160SFubIncjp75NJN90hDegYHBQoCWwgcTkJy4h?=
 =?us-ascii?Q?6KTJXXoyitt32gTl7pZMUpryiWmwfXzqjnNwzIUiLk6+yVhNs7vuo8purd9/?=
 =?us-ascii?Q?gH2cOSRrIpVBl8Fpgn+x6/BNq6LL5eL45dFspffaHl2RSxS/TGXH1Zaw3dKK?=
 =?us-ascii?Q?rd/CfnUWkcZop+RmgECgk/1utMb2i6fvQqC8J0wUG+OSfJ7TzS+49znBfhkE?=
 =?us-ascii?Q?tLBwpgDMKwiSfSmirAT4m84fY4U1p20/6gcC3ZpC5BTVhQ8LdJm9jgS8Hp5d?=
 =?us-ascii?Q?NGJiYDHHS2UHZeeqQEBZkK7ZFw02LgiYspCFiWmt6lQ5PTI4gPEJtzRXp+Wy?=
 =?us-ascii?Q?e6DBRABVlRytW5RNvVFmiloS8UK2UxBdr5NXnle0HB5hjhFkvP9AeKaaRxMs?=
 =?us-ascii?Q?ZggmC4ixD3RdwoDYC+SVx4n4pp1MEtSmk5qvHH5kTa/ZvoWUc/DTXRt6L+w8?=
 =?us-ascii?Q?rdTBCMqxyQAmZSATcwC6MRUAscDLDTerAOIYCFinUgS3mMKs4103cn32gQdn?=
 =?us-ascii?Q?MUcyimnMiQf/d8NA3K2/woAAVZwxcy9x+6jOIyhzW4pCvlrjBtLRUr2vMOrG?=
 =?us-ascii?Q?lbH7YpaLpDUCgiv9RsQ76bfDRnaSY9ClqgdHghaDco+DzEF/zMABNDZ8h6v2?=
 =?us-ascii?Q?ryiDo6Pl1paCzAk14nxTuo6Fdhu/+cq2E4O2HSuMa5EUj5ad9svEYoSXyATe?=
 =?us-ascii?Q?/2JwkdCokPmQFrC8Qp/A6aiiM9JRQ5oYjXl3f8CDeS6Oww=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skafuq0BQZvjhH3UPX+LLRzd9XVZo+hc6pOuV0xgziQ6ZF42ZoZX/P/UenEh?=
 =?us-ascii?Q?lBgvqqmjrGkKICNUIIaOr3G0m9hM7T9PFctOSrtbjB2vd2C0XE6Drb9JhwTX?=
 =?us-ascii?Q?4TfNLD9V01RI8q1JnxyYk28w4LcOwso8R1ZgLUzKzuv18h2Dm91OeqeUZPqg?=
 =?us-ascii?Q?w32F+FPDh2KvERkHAMvRMjBMT5LD7TEszVy5FqgqTvX5WjtnWCDL8uYJFr0P?=
 =?us-ascii?Q?EUy6bZEjRYwHExIklMnhModPs/Tit6e4uyK30K4nIyQrZRaQM9pUcwM8+Klg?=
 =?us-ascii?Q?XuYofRhpqqz90mU45l3qt7zROqJFyYCvOejs/JJDVCWdFVtCxSoNQuFCCGAp?=
 =?us-ascii?Q?IkdUOnHhgXXxoIadeWYcyU/lDq3iwX0opjYzs3GeyvgZK9TE+gvud5mSGNfR?=
 =?us-ascii?Q?jQ2noQjei/VfvXEQ51y6bLvB3R6EokNmDtCjQDmIUuR7KsUnBHlaGeuCCzYc?=
 =?us-ascii?Q?ELYqFir3XEKsk71g73bICx+SV2FLUbMK/fAgawf1baDocYs8UmmppbhORfE8?=
 =?us-ascii?Q?uP+NP6Ti/smXCMIq8588Bj/UwHUP22HQlaA4pQafWib3ZWRkqwdHIsmpw6nk?=
 =?us-ascii?Q?Q2rJeR1Ajz2YMc4XIoAXPPa5k3kzYAY4S094hKVSr14oWhM15edrQGNNfMGj?=
 =?us-ascii?Q?RZowGD3ziBW6q1X9Ig1R9VwEcWJzDhWyUyMg/fwjCn4AZc5PCszWnhzI0sra?=
 =?us-ascii?Q?o57rE3xjqdl5NnDSx2Nh+gWhd+9XZOX0sKGYooEuChGt2rt6PXR9YVsf1llT?=
 =?us-ascii?Q?jHPY0hneRMixxwevAmFyFKnmlkkJ1nrQux7qr52e6jenYJDE0w+2AHyl+p2l?=
 =?us-ascii?Q?PhZNOr951ZBiVvKIe3YoaHya6mE8LtXAtW5lLRfCp4R4yo184xNBKPyHP0eo?=
 =?us-ascii?Q?NRcoXSvUEWL0BJon75Yr5t1UVTTqMY2oa2nRYF31H/l8q/QSPuSPm/xbliUs?=
 =?us-ascii?Q?s18Sct51nQa2CM9eUqk/m/FYmZT8AYmkKHL5vT5Kw+AeH68E+P0TFDMVYtdk?=
 =?us-ascii?Q?llPKYi6fOEezAeAEiVeTo03kakDZP6WZHb29b9CFWkHvfwH6oIuxByj4zCym?=
 =?us-ascii?Q?r32FOJnlOJidx3V+eC5Nocr+ecDP15m4VHnuEY7zAWMU01EutpcWLcL7P1cQ?=
 =?us-ascii?Q?J4KDDvzbADVsQO6ufd9IJoXD9PHlzPJ4LlNvcq0wEKly6VUVztVT25QKHsjQ?=
 =?us-ascii?Q?TjKK2mVBJ2+IBam39W034bLmk4IVA4UdE1fdqjVw/m4FlwFw+9jwvT4spk7z?=
 =?us-ascii?Q?QnW/kZGbL/Erp/Ntf9h75Q8wiT7+p901s19Dzn0Gc/Pk1IN8qfk4KuZexB3l?=
 =?us-ascii?Q?49RHXnNCuHRAC/46L7uXiybfFYbcweYPbbSBd2/QjyF/QpIB6xU3ZgMNN148?=
 =?us-ascii?Q?GYIRN6sVMHtQ2SF4FtkiCMGFnFY4zcWL8s92TIZv8XMREXmWrf6ar0medsNn?=
 =?us-ascii?Q?Xx5uYcUGQ43i7VwoZLMKJzrWvgB8j0Uj1c7k97v0HnHRUnPeV43i5ZEz7nR6?=
 =?us-ascii?Q?BwK6uTp9XfeSrSauvyYcqRNGRpKk8HiLRSthUpGffpuvZJ2K05bZj8Zkdxiv?=
 =?us-ascii?Q?xFc1Y4rg8xuWof1j0UlHPGJqYkRqKwLCC8p/8JsLkRPPWEPfpIwIbRjeWMfl?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e70a85-55fd-49cf-a1c3-08dc99ec99c9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:41:05.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSDT2q3ofPit4YA58oHfbBKLznls+Cp9ka29K4h1xXohwjJPYMYu5ZSSenCIcEQTxJk5KVEdY5bIir5ai8LOP5LR4yAo/1Dda00RUiv8kGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-OriginatorOrg: intel.com

On Thu, Jun 27, 2024 at 04:35:48AM +0000, Tushar Vyavahare wrote:
> Introduce dynamic adjustment capabilities for fill_size and comp_size
> parameters to support larger batch sizes beyond the previous 2K limit.
> 
> Update HW_SW_MAX_RING_SIZE test cases to evaluate AF_XDP's robustness by
> pushing hardware and software ring sizes to their limits. This test
> ensures AF_XDP's reliability amidst potential producer/consumer throttling
> due to maximum ring utilization.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 26 ++++++++++++++++++------
>  tools/testing/selftests/bpf/xskxceiver.h |  2 ++
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 088df53869e8..8144fd145237 100644
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
> +	if (umem->comp_size)
> +		cfg.tx_size = umem->comp_size;
> +	if (umem->fill_size)
> +		cfg.rx_size = umem->fill_size;
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
> +	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowest bits when
> +	 * updating the Rx HW tail register.
> +	 */

Minor comment here is that in future it would be nice to have this quirk
only when ice hw is actually used

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
> 


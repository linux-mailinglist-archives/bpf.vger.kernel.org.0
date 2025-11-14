Return-Path: <bpf+bounces-74515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7617C5D3A5
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 14:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E34A74E1C95
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CFA3016FE;
	Fri, 14 Nov 2025 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCYTlkMv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821754774;
	Fri, 14 Nov 2025 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125329; cv=fail; b=ufSA5NBGiJJOQd4aQlBKSsHeCZoc9AO0CE9M2tAk9um37L+uDYxG1iKA+NbnNtwbM7iYA9i9g5lbzNbhShBiDNy0DbVyQbriFa3zXRXPlGgkdsFgPPSBLEJUFXVcJudGJMZ5fhXI26X4vRjIrC0lxUTkyH60MfPqEjngiKHMLcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125329; c=relaxed/simple;
	bh=LHjlVPBsedHIrZ64zDCmVI2mkXfva9hqDB/dkeezLp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JvXi8r8OcXFSKpU2oJdUyU3ooUntJIluDstGs63+iFpXwfcOKAAOjyTRnJ+uJ/cU4J1cQQmLKC2u3FSFM6Ia5eiZ1jRhHw2CxNRoM776Ol2o31x0tZGwXR7G5fHf9BG48NIUcd5eE9dwgC/D+rXt7VF+OC6GqdH77ZYxJT78z/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCYTlkMv; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763125327; x=1794661327;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LHjlVPBsedHIrZ64zDCmVI2mkXfva9hqDB/dkeezLp4=;
  b=NCYTlkMvNQd6liSAbv9xKAk55gfqpBH9eU1IcKwoSkmeeNP8TfW1abZ4
   +IX4zVQaMvAw8a4CBl38Oo/Kwix94Jpw3lUO5ZPbDT9gGth2KseHAQthn
   UwEvsZC0AO20zlPYdL4U27F3Qrwbzddh7JBmxPTfkbKEn8frjYf9HUtFv
   teBcltSlc1fvjtHj9bSkTHGvZZkEN8yisSdU07wBkGTHXJCKSUvHrAeM1
   jPEKmSD+zxhPY+RjSBdG940QkGWN3v4iGnWQ7aWSaMae07AyizZDUY6hm
   wt3lmmQQokuA0JphqG5BY5p5iaPFkTn53y5k9OCuCLiwq5vN/BUQCfZcT
   w==;
X-CSE-ConnectionGUID: 8uTvBzppRDSqubxiIYvnpg==
X-CSE-MsgGUID: CWGXvTLWQBWAn9BWlQPT/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65315119"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="65315119"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 05:02:05 -0800
X-CSE-ConnectionGUID: svh8fh/9St2WLJpbeGkk5w==
X-CSE-MsgGUID: I34HsqOxT1KnKN2f5Z/7dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="227120943"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 05:02:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 05:02:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 05:02:04 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.70)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 05:02:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNslhC6czOiF0Um/y/A1UlzhKn0BcyuWWEnJKbfGqBncLaQt31YPZgMC1KEYWiI0EiEqHGHtGjVN5TTeLjsL8nWWVNpz1swieEpRKN9ENMoif1fqdrVfMobPsnMO0kQmbWkJnqWpcqaUDgP+zhQSPeQ8qriDMiOQyp4pyFF5aI00s1WnqswnrcDsgW1zdwrZntxxkJGP1qzzMTItseVTDYusJdyQEYVDKrID1EEM02WzkGpc0N2LAG2XqwRk9bbobpcr/RKwxrFL/XJNSnQKlYoCXCbGLnHuphQjPir5FTLWXt2iB42wfGBszqt3uxqibRe2NRXPJqtqXgQgXaSXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4xXRTZn3nrf0bC6gz3MBdGERwxFTWoZp79wgvIGDLU=;
 b=lnua/T7XuWlT4jawLz6uNdDs7EedReHy0RyYyMh/wvGoIpwTdfb4Dtod6KpQbv6muQfEq+uLSyoPuvov+b+HuD/iLCRchtXnA9MeNMIHcR0+WAXvqGLn4Kbd9tb0c1azLp4z6tzxwkMz0WCTWLmIEzaigEuo59AdOAgIPb6fMK3xa1UIGfN0LshpsttvTouwdiBBzoq79AkDI9sLzIU3HQ8Hu63JgXYjpZjTOEYgq4zj21ToS5+Nyw6s89Ns9rnfrNZ5sqBlJqLqvwaGTdLYP3pLSX2GCICW3aEuhfob3dCQvP0pe0zTJSYnJbqY7rgss5IpP12DtvexB0BBt87tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 13:02:02 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 13:02:01 +0000
Date: Fri, 14 Nov 2025 14:01:14 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alessandro Decina <alessandro.d@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Tirthendu Sarkar <tirthendu.sarkar@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aRcoGvqbT9V/HtoD@boxer>
References: <20251113082438.54154-1-alessandro.d@gmail.com>
 <20251113082438.54154-2-alessandro.d@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251113082438.54154-2-alessandro.d@gmail.com>
X-ClientProxiedBy: DU2PR04CA0153.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::8) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH0PR11MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: b0dd8795-f578-4aab-1006-08de237e008d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9F3BZKFaagcugt7B8hwnSDG+vqmhMwJwsxqPUcA6dDOIRgZfGVv7y6fD3met?=
 =?us-ascii?Q?m6xbAqLHB0DgQoDp+FnpLfs4nMilWwpzFIUPo+tTSCKx3u/6jry/6881j9vj?=
 =?us-ascii?Q?XhR7G0gPuNrNgRYzCB57/qTOr30d0bu3tf5xWh0JkX0RYFF51w/m7NGkE8B6?=
 =?us-ascii?Q?t/fKOOaJmC5oSmykr5w1eIm+GZtKSXBPIzpBUgqEm8vP9J16WW9M+nG0dQOZ?=
 =?us-ascii?Q?QOgZeCKiu248jdlFj2JH1uPfQJQ3aDfVsBIFWaNTtbEg0FKgpui5MPjxhOE3?=
 =?us-ascii?Q?GPem3IUBW0qKndlODDh/kFSbosR8ZEVhpWu4/WX6sy7vB3ST58BjmhZy14jd?=
 =?us-ascii?Q?8Eka6Z3WXeKvA/C80n8g/z9+0yVIVTQxpu45ZlzAPb0DtG0e9H0Qv5Rr9YIL?=
 =?us-ascii?Q?5I005UqDIaAs+AAoTC2mcztYsN1MJm7XgaF3EZk0EoaN6f8oPrRJo5xmFLTA?=
 =?us-ascii?Q?/nFGCFU7iZRKsYLbVWYKxgWrgsqmYSOPgSfiWwPWoacpj/7qCP+I1udbyguM?=
 =?us-ascii?Q?G7yguKOecNSB+o3UcK3Vq42PPiqXbEshJqz8mjSlQf5RLUENNZMb49widiBg?=
 =?us-ascii?Q?vOexPnbnU8XE8zvAvpRg1PadGmF+/L042sjjicZ25EZHuYldg+J/WGhlRiUW?=
 =?us-ascii?Q?z1f+8EjhmQVeJSXdCNoBAe2fdrmF0zV8u8npBrRazzpqDG4doktWwOs/WjDA?=
 =?us-ascii?Q?l/SNbkeDmID+qfbdTkhQoo9diHgn4BRoF8PkiQw7uSHKd5Xv7795S5uAeZxn?=
 =?us-ascii?Q?4BDdtamS3tDjGQ/IZEGa4kdozNdQZFvlN2P+THXAzWYKuT0aPSj9eLjxdWv9?=
 =?us-ascii?Q?QvWCQySpGtlc05zCIDxEbsRIKbxi8wdh/NSbZMPHvGJe0/hQcCaRfcKd2muh?=
 =?us-ascii?Q?gfqktjLgnDAIN+8F1YD37Q0biIRRsj18rLEW3yOZHS+cBeNM1WmqAsrry8in?=
 =?us-ascii?Q?72/oS9lWgfTbt184Lr9JbHi5huitSDv8LyMHsU07FBfua8QAkoHZcGJLY0Ga?=
 =?us-ascii?Q?v19DSdpR5SdbISpevotp1tXqJ99urvyIaTSfKKR8Khbc4paY7ST11brg4WNx?=
 =?us-ascii?Q?9DY7UA0IUFuGH91+h/3BaLonTk5UuqCamDyRsZ+zBaLlAbYHCjqq3O9SXL3S?=
 =?us-ascii?Q?hSh/mHjErYpfss3Y0aLjfPppuuWRtPnilMITseWm1I/XZ22xgvQDGSEQHj5V?=
 =?us-ascii?Q?OfwnXV0stnA0veqaVNCjHQQ5efPbfqmZQp/ZBcaIGJxM1nVVKbloWcZ7OGaN?=
 =?us-ascii?Q?aiyESTGiMCQpfGvL9Naet8E1xej/dYJSIMOOO0GsH1bOoK9yAjzwRmyQ9KeE?=
 =?us-ascii?Q?b6EUn58j3xC0rC98cp0cUM2myIq/mMAt9e7nKRcnS049FeEdJfeP1Nbn3Lcv?=
 =?us-ascii?Q?MuVQcn7nNB3NsVWRBFp3j+5H5g9WVTOXtO+ENT+/6obfghK54WtvTclBYhCu?=
 =?us-ascii?Q?RHlSZcA26wesjRfvgGSvdV82lg5sYIs3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rgQyC8kmm64Ch4A23meHZvNkyxOwf3sKF3T05IGVoCvidgQo4o6fY06YXA7+?=
 =?us-ascii?Q?A7dT1xGwMCGJW313LEbqRNNoUVq8xin1I7TczyhsTtITgCx374qsqcAgcdRG?=
 =?us-ascii?Q?aAng03qFz0K3jWtrV9DC5G/nlRz706BuTOm53BlcY+mj6wC7WkuED4FVTmAx?=
 =?us-ascii?Q?MEY376pkS/hYIsISrHx6QWVWhe6aYtj51a/X9dmX16HlFH8JuNGDK3lphlW4?=
 =?us-ascii?Q?7AQi76ZxXyDHd9jD+QH0YSCs5J/fFms3p7K4TnQKCwJs8zABZ4YEwRBnNSLM?=
 =?us-ascii?Q?Elp9WhPSO6RrezxMik/1jIEyCldybFVva6wM4cjp8ZXps1k2RJWpY5T/mpo/?=
 =?us-ascii?Q?ar+QSNlIU+2iQxLQ/De8DMQOhqLdfUXGiVD5QZoDthihTH7eDx9WXhWqlBo8?=
 =?us-ascii?Q?43Kz7g6LxHzp5HBKeIUBxomDhtSBmXpLrpavUpz03GPlGcF3EhoIZ8LXNK1T?=
 =?us-ascii?Q?twKH5ai5Ga5A7WOuIGevhpbwevnjGm5pCPRgEQUpoQpMoIP2TSQYjJbtBEXP?=
 =?us-ascii?Q?J+twS4Ei5cYgxq1MNbsdw31HR2HFhz9Vg3DtjHfVU4fbZZxe4c9bD8fXdpwz?=
 =?us-ascii?Q?yZg4UvZivIzdaK9NUTA9gtfWY8VdZ5A99m9yv2ao95bfO6/eoxKM0hrDLpRt?=
 =?us-ascii?Q?IsGhrNXd8WERCkpmutqePBSLICxPD4gDp7yqN63je9ZA1vjs99r+YbKnK/ni?=
 =?us-ascii?Q?SyBnK/Yu8LUTuoJWKqW9/4h7trLPBd73TMWApCXr2c+6RFIaEz7NUStzFLSi?=
 =?us-ascii?Q?tsFnkFfk4gY7i7daADM9iJ9NGPWdZnT5mq6qvTg8agTTu3sstvlDTDCKzkdY?=
 =?us-ascii?Q?Ed+FfQzq6vWCdCxB7/sZVsuqE7ACwWC1avr3YThQxZz/1vuabq+3aC0hq87c?=
 =?us-ascii?Q?UhKBpcIOLJlGnbOX9Psoeg86vDLgSrMN0FgCZyosNc/NJEfGCUsbKexYJp2Z?=
 =?us-ascii?Q?V/qoEg5yXf6jbTDhagpGE9ZDKLj5AFkmfa1bidzjTStwwq+fNuLgGHaUbfQ2?=
 =?us-ascii?Q?rNf0J5V7pzcd3w60pe9OzaP6a67eFVfOuKSJzv1UxLErvh1UXxSs2F7YMDRQ?=
 =?us-ascii?Q?UR96DUMq/zTeUlMGQhQ1taN60l586Kw52RbP9VsXGOfioSA53rScgGsvIIAK?=
 =?us-ascii?Q?HbtFh59pNPXqf8npUUig2zW43eVdtGNMlj+iF/8FtJhSjW9Pkae7PdUfYtzz?=
 =?us-ascii?Q?RsZVReExcgbLHdLDd5F1dcAjmQEU9CZ6v9B8JWT8xg85KIwtXpfL6CEpDgse?=
 =?us-ascii?Q?i6JKbcLhsmKEYqv95ULbCgJ8qZrJ7P3WmhVUhjDzjrurieFf5BVFlHQ3vhCR?=
 =?us-ascii?Q?JjVv9kHvDF6ONDNM7qitrCEmPecqzxUU2J0ioFCrrdZMHUj0oS/th7UNEycf?=
 =?us-ascii?Q?hBhyprui1DNiu/jCi3pqlhLTz1J/PrjHmdtuY8b2S/7jmquORpEB6mZD4UrC?=
 =?us-ascii?Q?P71L27hKTF7oGmPmChhkChMR/0lJd4SJM4zy4cSEOSlkRE54pnCcOHViSJn+?=
 =?us-ascii?Q?heMZyGgI52ns/1MJDgaJfWyBBy1q/4aHczCstfjMJM2zuD2LK94MAbhuIYRp?=
 =?us-ascii?Q?/rfPNuQTVdmh+yeiXa8VdlZ9FpdznH8TXKvSZl9nRg7pxA72I0lETgzezs/x?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dd8795-f578-4aab-1006-08de237e008d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 13:02:01.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwcU45Ce8RuRQSpR/L4XVDo3swTiGXPpU+AgAjSf1xuHX+5SLhK6AjDMzt7bw1nC/TIGeXN/ENh7aHCoD/gVD50bCpn9IBb+m8UVpgaNQX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com

On Thu, Nov 13, 2025 at 07:24:38PM +1100, Alessandro Decina wrote:
> Whenever a status descriptor is received, i40e processes and skips over
> it, correctly updating next_to_process but forgetting to update
> next_to_clean. In the next iteration this accidentally causes the
> creation of an invalid multi-buffer xdp_buff where the first fragment
> is the status descriptor.
> 
> If then a skb is constructed from such an invalid buffer - because the
> eBPF program returns XDP_PASS - a panic occurs:
> 
> [ 5866.367317] BUG: unable to handle page fault for address: ffd31c37eab1c980
> [ 5866.375050] #PF: supervisor read access in kernel mode
> [ 5866.380825] #PF: error_code(0x0000) - not-present page
> [ 5866.386602] PGD 0
> [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted 6.17.0-custom #1 PREEMPT(voluntary)
> [ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025
> [ 5866.412339] RIP: 0010:memcpy+0x8/0x10
> [ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
> [ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1
> [ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI: ff2dd26dbd8f0000
> [ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09: 0000000000000000
> [ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8
> [ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15: ff2dd26548548b80
> [ 5866.483509] FS:  0000000000000000(0000) GS:ff2dd2c363592000(0000) knlGS:0000000000000000
> [ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0
> [ 5866.507079] PKRU: 55555554
> [ 5866.510125] Call Trace:
> [ 5866.512867]  <IRQ>
> [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
> [ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
> [ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.531408]  ? raise_softirq+0x24/0x70
> [ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
> [ 5866.551493]  __napi_poll+0x30/0x230
> [ 5866.555423]  net_rx_action+0x20b/0x3f0
> [ 5866.559643]  handle_softirqs+0xe4/0x340
> [ 5866.563962]  __irq_exit_rcu+0x10e/0x130
> [ 5866.568283]  irq_exit_rcu+0xe/0x20
> [ 5866.572110]  common_interrupt+0xb6/0xe0
> [ 5866.576425]  </IRQ>
> [ 5866.578791]  <TASK>
> 
> Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
> 
> Rename i40e_inc_ntp to i40e_inc_ntp_ntc. Make it take an optional
> pointer to next_to_clean so it's harder for callers to accidentally
> forget to advance it.
> 
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 33 ++++++++++++-------
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 17 ++++++----
>  3 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index cc0b9efc2637..d3dae895a058 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2359,15 +2359,24 @@ void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res)
>  }
>  
>  /**
> - * i40e_inc_ntp: Advance the next_to_process index
> + * i40e_inc_ntp_ntc: Advance the next_to_process and next_to_clean indexes
>   * @rx_ring: Rx ring
> + * @next_to_process: Pointer to next_to_process
> + * @next_to_clean: Pointer to next_to_clean or NULL
> + *
> + * This function advances the next_to_process index. If next_to_clean is not
> + * NULL, it is advanced as well.
>   **/
> -static void i40e_inc_ntp(struct i40e_ring *rx_ring)
> +void i40e_inc_ntp_ntc(struct i40e_ring *rx_ring, u16 *next_to_process,
> +		      u16 *next_to_clean)
>  {
> -	u32 ntp = rx_ring->next_to_process + 1;
> +	u16 ntp = *next_to_process + 1;
>  
>  	ntp = (ntp < rx_ring->count) ? ntp : 0;
> -	rx_ring->next_to_process = ntp;
> +	*next_to_process = ntp;
> +	if (next_to_clean)
> +		*next_to_clean = ntp;
> +
>  	prefetch(I40E_RX_DESC(rx_ring, ntp));
>  }
>  
> @@ -2484,17 +2493,19 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
>  			i40e_clean_programming_status(rx_ring,
>  						      rx_desc->raw.qword[0],
>  						      qword);
> +			bool eop;
> +
>  			rx_buffer = i40e_rx_bi(rx_ring, ntp);
> -			i40e_inc_ntp(rx_ring);
> -			i40e_reuse_rx_page(rx_ring, rx_buffer);
>  			/* Update ntc and bump cleaned count if not in the
>  			 * middle of mb packet.
>  			 */
> -			if (rx_ring->next_to_clean == ntp) {
> -				rx_ring->next_to_clean =
> -					rx_ring->next_to_process;
> +			eop = rx_ring->next_to_process ==
> +			      rx_ring->next_to_clean;
> +			i40e_inc_ntp_ntc(rx_ring, &rx_ring->next_to_process,
> +					 eop ? &rx_ring->next_to_clean : NULL);

Woah, that's not what I had on mind...I meant to pull whole block that
takes care of FDIR descriptors onto common function. That logic should be
shared between normal Rx and ZC Rx. The only different action we need to
take is how we release the buffer.

Could you try pulling whole i40e_rx_is_programming_status() branch onto
function within i40e_txrx_common.h and see how much of a work would it
take to have this as a common function?

> +			if (eop)
>  				cleaned_count++;
> -			}
> +			i40e_reuse_rx_page(rx_ring, rx_buffer);
>  			continue;
>  		}
>  
> @@ -2507,7 +2518,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
>  		rx_buffer = i40e_get_rx_buffer(rx_ring, size);
>  
>  		neop = i40e_is_non_eop(rx_ring, rx_desc);
> -		i40e_inc_ntp(rx_ring);
> +		i40e_inc_ntp_ntc(rx_ring, &rx_ring->next_to_process, NULL);
>  
>  		if (!xdp->data) {
>  			unsigned char *hard_start;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> index e26807fd2123..3d7e4b3404f0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> @@ -17,6 +17,8 @@ void i40e_update_rx_stats(struct i40e_ring *rx_ring,
>  			  unsigned int total_rx_packets);
>  void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res);
>  void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val);
> +void i40e_inc_ntp_ntc(struct i40e_ring *rx_ring, u16 *next_to_process,
> +		      u16 *next_to_clean);
>  
>  #define I40E_XDP_PASS		0
>  #define I40E_XDP_CONSUMED	BIT(0)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..fdf72446ed67 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -410,7 +410,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  	u16 next_to_clean = rx_ring->next_to_clean;
>  	unsigned int xdp_res, xdp_xmit = 0;
>  	struct xdp_buff *first = NULL;
> -	u32 count = rx_ring->count;
>  	struct bpf_prog *xdp_prog;
>  	u32 entries_to_alloc;
>  	bool failure = false;
> @@ -430,6 +429,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  		struct xdp_buff *bi;
>  		unsigned int size;
>  		u64 qword;
> +		bool neop;
>  
>  		rx_desc = I40E_RX_DESC(rx_ring, next_to_process);
>  		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> @@ -446,8 +446,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  						      qword);
>  			bi = *i40e_rx_bi(rx_ring, next_to_process);
>  			xsk_buff_free(bi);
> -			if (++next_to_process == count)
> -				next_to_process = 0;
> +			i40e_inc_ntp_ntc(rx_ring, &next_to_process,
> +					 next_to_process == next_to_clean ?
> +						 &next_to_clean :
> +						 NULL);
>  			continue;
>  		}
>  
> @@ -466,16 +468,17 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  			break;
>  		}
>  
> -		if (++next_to_process == count)
> -			next_to_process = 0;
> +		neop = i40e_is_non_eop(rx_ring, rx_desc);
> +		// advance next_to_process. on EOP, advance next_to_clean as well.
> +		i40e_inc_ntp_ntc(rx_ring, &next_to_process,
> +				 !neop ? &next_to_clean : NULL);
>  
> -		if (i40e_is_non_eop(rx_ring, rx_desc))
> +		if (neop)
>  			continue;
>  
>  		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
>  		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
>  					  &rx_bytes, xdp_res, &failure);
> -		next_to_clean = next_to_process;
>  		if (failure)
>  			break;
>  		total_rx_packets += rx_packets;
> -- 
> 2.43.0
> 


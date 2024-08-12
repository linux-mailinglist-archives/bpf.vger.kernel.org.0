Return-Path: <bpf+bounces-36890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74194ED8B
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19801C21B62
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7A17A584;
	Mon, 12 Aug 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caZy+1XP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2017BB12;
	Mon, 12 Aug 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467506; cv=fail; b=igT4fM9qFn2XuSQBSnZENPwFn3iBv3YfGOdFVQS7bjjOkH1Z6coqbWW4AjvhE87LZOOL+YJ9BxomBctsXPgWeNWyvMankzq0aTj9caWWmompL76VzC6DR0Qj+y2y6WYQn2GRTDa0IZjXVF65uD6+Gsjt7HXwcKYkGesFhkvresU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467506; c=relaxed/simple;
	bh=M1KJut7+fVzDiAIaMqBU7/X2Q+edRtK+XVXffek2qUw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drlSc18vEEvmFEeyDEEyMp6P039170AHiAQcPCC0hPMMRRlPInMa5eqgVMQUfC2SUjCWkcSYwdo5HOMPFji+vstpQCNlOyz+Uu7QtgFUY41EpJI82yh92E+A81ZhytALUaaKrVWRyQ/E6NuXc2CA3P1SfEk5m9/4n+idLSa8zNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caZy+1XP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723467504; x=1755003504;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M1KJut7+fVzDiAIaMqBU7/X2Q+edRtK+XVXffek2qUw=;
  b=caZy+1XPGr4OMLGL71HcIyp5cGbc3T7P+kjz6PxsNoboUfgsy46nFADx
   7emKMcJu8KcyEh6VRGvSGxpvDlNKygLsstpBGWBXZrTeHrHGaLUTqSxDv
   RD9a3eeBNMLXFU0rTuBlb2e5IEe4UkJImOyoGBRYCqTBVlsIFPNZ5cfnU
   2SHJelCM8t+p7xYIUwRvrfbkIItIpGRzq8Zkk68YaqiRkq0mqt0enf4tp
   pdIVTFrZepAXOUtoRKKZ4HN8Ax0wcCRid2wMPPDSixpq5h1LrwfMqM252
   62vNs4V57S4rrcBHZvrdAOQYFW4IMH3oKJPdCKbl4JHNxL6QUnSdEbhAj
   g==;
X-CSE-ConnectionGUID: p62YrOfRTSmEEdPrd15pYA==
X-CSE-MsgGUID: MeP7jsEOREqLfX1J4fP3JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46975877"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46975877"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:58:24 -0700
X-CSE-ConnectionGUID: ZdzLwz04R5u8fCi4K3a8VA==
X-CSE-MsgGUID: 7I3tV7xpQ6KE50mC7y+PdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="57918151"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 05:58:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:58:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 05:58:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 05:58:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsltjYo0JCY5wFRFcs6lFM4UEtGu1jQvqW1PG3QUvbky/5buCp3S9gcbj2V1yUU+1ndsQ8o08xbNFyz8UUfX8hmamzX1QjnunO0rsS/DA75tBaRrU8nE6ferMeYutd4LS5ZkLA2RcCP05uXT9f2EQ7cNuSagsJ/8XoscYhXdM+desBvIijAK+Tip7bWdWQ2/6kJcjOFbHlwglYv8pnKq3qXK3bko3M1lMcD8YhDsPsd7RaON3LaG6tyZAwqCx1OKfrQBH6j/YHit0WKbz8cI0pQVEjx1WPezsZRBnqYmYGD0uALthWCPmSBZAzthbZFF25KOXr+HrEnBPhvHv02eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46HVSv4Hk31DPrBHhJNp6bja2RQKqjhlrrZFrezrivo=;
 b=du09kt8Cj3RU7QsAILAmluI5YYRI4FIgOwwL8ASJveIT53X6Y8+OzOMNTUdidXOI5vzAGDcwpzwC6Sq2WU662wCixrxPuPVlJn6lGIHlMRfE0NSDhjRKQdTIGbuRAw/Li3Z4QSd8cX2XMK1RPXALMXGRsaQgKGuhmsTXOcnrjIiB3grp9nIr90Sc0oZNcnHTAbmxiYaRX+Uo4/P/6G9/h1cQzfvpNt1Fk1PiohfqRF3SB3nzhGBenX+0qdaBGucXI0/Xv45g5PrXpMMoQV1llGjymokV2wjSTcUt3pW7OwJNaPjK+0+wcKl0513PRmAqZUELzxNvu4MjYBvqB366AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Mon, 12 Aug
 2024 12:58:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 12:58:14 +0000
Date: Mon, 12 Aug 2024 14:58:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>
Subject: Re: [PATCH iwl-net v2 3/6] ice: check for XDP rings instead of bpf
 program when unconfiguring
Message-ID: <ZroG2LxHn2Rt+Txx@boxer>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-4-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240724164840.2536605-4-larysa.zaremba@intel.com>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: acc666ac-37f8-458d-7262-08dcbace6d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cUDU+axBhd0yQag6SNig3OxvDexasiXgNxFKlj6b8flRn0daSsR1nCRgvai9?=
 =?us-ascii?Q?O5yNU7AQbT3FyPS0KmxZnA67bu3XLP53eUdHcZy6FHYHh8aa7tBc3+xbdaQf?=
 =?us-ascii?Q?FQcusZvMayhFrelsDnnSRMi/hSaTrJxgROd6MFEa1aCQ8Fg4SWfOZMcs3Ygd?=
 =?us-ascii?Q?m/nsCtC+ivFjWKg8dAMIy480hzhaATkmw/9yy8Emk/RW7yh+7ZmsLTRWw3nw?=
 =?us-ascii?Q?fIGBXrwqS9u3HRWkjL/cYJP3go9O2gIlclKcetkhKTD2rpjIkzFVnimwvi3F?=
 =?us-ascii?Q?7PNjS5XWD8CRi5OCetUmBWB0xzTCleKku0vbpntmZxwV3RvMDoynp614CPS4?=
 =?us-ascii?Q?AVYt3UDPg6r+gdQc9FgGsMxQqJWynezAeYKhVvtR+SCaLipYQPUU7BPZwOGe?=
 =?us-ascii?Q?rRmX85Pa9QSQhnXlP2hwlwrBAD+El30PQHx2MuuTJ+e4VVyAqeQPjK3M3IGH?=
 =?us-ascii?Q?7GEHpjjcbnx3Wthqvx7olnK8zzIkmQxWYFcp1nigE0lHHTMTOSxExPkGm+Jy?=
 =?us-ascii?Q?36/xTGOuGeKbVmFqr15ZpUjTFq7s2dpg4rEFD/c5ESqpzMJAm0iEtah1JM1l?=
 =?us-ascii?Q?efTwF5OGt04D6+y81QiMq42u98DKORKe5CZlNf3oX25g6Rf9EC60LFSmRm/8?=
 =?us-ascii?Q?pDBgqBV8mKL7SX1r6rkQyIkDbGadzoQ/gmw3hTr5FeZlFcLbxt+4kGkC3F7+?=
 =?us-ascii?Q?Nq7QlY7EUfETVQYLCKsYOrydTJ3QBG9oCcBi/neo1MOUhd36tNuwWbTKmcdO?=
 =?us-ascii?Q?apffz3Xivst9xnhINngmGl7lrmdgru2vSLY3+uT9CkJxbb+50o/X9+REhBjN?=
 =?us-ascii?Q?uwnRpEZpMF+yT44LvxMSqiPL7yL+nJSa3u7nxdE+SLiuohv6HEF0nxZ+9j/b?=
 =?us-ascii?Q?wSUTlvew0FYCkvufNeakBCim3yeU4ZtPH+ZaI3ipe/HbnVqoIJNVelgbP+Ev?=
 =?us-ascii?Q?RL47rNd6mbfZeeFXn0Sn+UFfOqNyXRmruL4NNKXmuD3GutT9y3VHj15oalpk?=
 =?us-ascii?Q?cOyXac4tlXtYLpctkOWX4ms1gw+iaQ4wq/wT28PcNZPi4sBcPhOi4BSHwXsc?=
 =?us-ascii?Q?ExbKwWASdFdlQUf2Xnwyi7mwnbIgmIe31OBRlNJt+d3xdIHnsZOpChIkN6nl?=
 =?us-ascii?Q?Wq4F0Qet8ntJvDXrQUtcG4GZlwivPTwe7uxDxwIrp52DTOrIdActaLLKFSEt?=
 =?us-ascii?Q?5MyjmKpOcZzaW7geV5iKzuxu8pKu+tmylca5KzBgyxvDKBnsk2Nw1CqNpfDZ?=
 =?us-ascii?Q?mDIFW5W5DnWZM1deJW4S2M5WPDNcn3n3UAGJ20TbtDzKIV3cZ/Vm7iemWcYH?=
 =?us-ascii?Q?GRzwlUPbAM8vGbJBBfVB/q4RuRDr2flKre1Ah3EAJWJKng=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hi2zPn8RSMTVQVk/v/zrzi9QmwM5mi2jnlv/9KA6Wb2xgtTyRzjy7e0IxbeQ?=
 =?us-ascii?Q?v+I2BhVGtxuYY/969xrPtumXnNHUEjfM/1eLCVusTZHGTuUT6ysWc9mRNYWm?=
 =?us-ascii?Q?ZcyQDh0a3rxXmMVPHESGW0fQjqql+oH/sOK7EfjNYorWN7VDy00a5LCe9ZEJ?=
 =?us-ascii?Q?Q78ZGNwWhUoy52Jp1dc96jxHofD+UiNUxVwzhM+iW2DnHkemMUiXKUght9Wp?=
 =?us-ascii?Q?7Ck9mbmzfDeh0u4CZ6toq72xIEilvhWHyiiBkrDFeJDWHVCSIwH5cf8hn3hF?=
 =?us-ascii?Q?Fvj7eeXtWNJLVMnueT14LuQisUrUKxOID7cG3Thr1aUeC2D9zZ/XMa1PXS4x?=
 =?us-ascii?Q?sw6teytBhE5vJZmGLsgAY6M+TudU4q3+feRgX9QXi9L1j+qJuRQ03rGXHFnh?=
 =?us-ascii?Q?Z974sjlYqb+ZxlmNVIFHE1V3FgATkamWCBEVavWU1NChvqcRkRdLNs8obg/B?=
 =?us-ascii?Q?Luy661SPzK4lCjgb+i38V3Jwq/qhQ5ccoITqc9oRwzhA03JOPZK5xNuszqkI?=
 =?us-ascii?Q?67gOEAswLuoNKQDHqyM8lL4IWM6BfsmxNDDwjGSDAJ7Ya4AhsR/QD52V044u?=
 =?us-ascii?Q?J5aMM+g3+I7QWqK3vQM+T0m5CTnLMUSY8R2gYEF3irQo+GAkz0m3gSIamMQr?=
 =?us-ascii?Q?CfjNsEa3Wsu900LT07eNoX0JMLn/bb3sM7TEeHc000tFUMbOMPVBk8+rmd6Y?=
 =?us-ascii?Q?X5husGegN1UWFho2XlGXBg6Hi3VNQOXySwEk4Vf47PBQMy4eYYKKuCEuwD37?=
 =?us-ascii?Q?YCFoeCdIBZYEjRZ2LL0QkDU9zMat3yFMnEWXU0rPME58v3bHYyD7SdEpjN43?=
 =?us-ascii?Q?l9YmZEjL6zQzd4ALIEJ1SgbnFud21A1Ob0oZ94+/WiByCUzocnmCyg6Zh+uw?=
 =?us-ascii?Q?qvaz9YjK5wr4dKxDmGU7n/MIpzI5acQqEgSJy5VvzYB3UmjVeZWnJv3JzGlR?=
 =?us-ascii?Q?hmgf3OHP1LBfZXxe3arczmtGN9mkdzby5Y3R9A+7+UGBwoi+MZfzJcYIv2Ui?=
 =?us-ascii?Q?SzitUT6KRFHtXhKDXmrff/+tYNND5bWDSWhGWJbCZrIHQ25Nm0NE92jg65yE?=
 =?us-ascii?Q?TfdTm3/47vykOWhv69qpRK5AhPiFJ+5vqUWi38ycESEt8RRLfZCejuQxqfbW?=
 =?us-ascii?Q?yfTeCGsc/saRGAhrLoMjuoB3zr3IGTY5LtoD5HuoPER8tyLxbsTWesvx5Yku?=
 =?us-ascii?Q?rNcvos1mRmbnr88JVKA6b+c9ZmLvTWd1ZLDg4lDCHhLOXzroiaigpLM1NVsA?=
 =?us-ascii?Q?yNBn714ccrbiA515mQ014dEQOgsi23le333rHRnpPzN4yBnU1pBxiiZuTJhg?=
 =?us-ascii?Q?zRQD+gXhrKa2vZTEnifWS0Q+468P9/NH3EhQYANW0n6/AwpQJHj+45FhXjOv?=
 =?us-ascii?Q?Yq2CMxAH5ussVXffCItqQMpCDHqbUT71MDrBxyjb+q03D98kzMwK2vbEZjkB?=
 =?us-ascii?Q?CDmdv0uBIdWhLnGMIqSaB7UhFZdCVBY8mkhZH18fI3KKXKJ6726j2x0GAUEM?=
 =?us-ascii?Q?c0D8hu3CmGwyXXojTZCL5AEaYxCNofyvt2l5Y7x8c+tWdFY3EtuibLc7xko/?=
 =?us-ascii?Q?nnK1Vg0ckq2CXuuisrHCyhLJnD5Nhx3B8flvdE+JaFyzqOFxf4gg1VqVRMjr?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acc666ac-37f8-458d-7262-08dcbace6d41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 12:58:14.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HEoMrUz8E9wkG53daeCgVtSjBKMyOPztko0Jfx2hoBALIbOphBj7D0o+3+YhTBiSkd/wCzNRjy+gHGGm4MgCzNiE7jxkXmry6j+njDp2kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com

On Wed, Jul 24, 2024 at 06:48:34PM +0200, Larysa Zaremba wrote:
> If VSI rebuild is pending, .ndo_bpf() can attach/detach the XDP program on
> VSI without applying new ring configuration. When unconfiguring the VSI, we
> can encounter the state in which there is an XDP program but no XDP rings
> to destroy or there will be XDP rings that need to be destroyed, but no XDP
> program to indicate their presence.
> 
> When unconfiguring, rely on the presence of XDP rings rather then XDP
> program, as they better represent the current state that has to be
> destroyed.
> 

No Fixes: tag?

> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)

[...]

> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 2c1a843ba200..5dd50a2866cc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -39,7 +39,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
>  	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
>  	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
>  	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
> -	if (ice_is_xdp_ena_vsi(vsi))
> +	if (vsi->xdp_rings)
>  		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
>  		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
>  }
> @@ -52,7 +52,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
>  static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
>  {
>  	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
> -	if (ice_is_xdp_ena_vsi(vsi)) {
> +	if (vsi->xdp_rings) {
>  		synchronize_rcu();
>  		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
>  	}
> @@ -189,7 +189,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
>  	if (err)
>  		return err;
> -	if (ice_is_xdp_ena_vsi(vsi)) {
> +	if (vsi->xdp_rings) {

From XSK POV these checks are false positive and I will be sending a patch
that gets rid of it (I had this on my tree when working on timeout issues
but I pulled this out as it was not a -net candidate IMHO).

Just a heads up, this can go as-is currently.

>  		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
>  
>  		memset(&txq_meta, 0, sizeof(txq_meta));
> -- 
> 2.43.0
> 


Return-Path: <bpf+bounces-64886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2381B1822F
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F873BAE52
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AD0248F6A;
	Fri,  1 Aug 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6q1LnBq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457833D8;
	Fri,  1 Aug 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053931; cv=fail; b=ZwbmbquTcwAl2NSPgze5EnaWfJFIiKrc0PiYtuPW51FPq748sCbMjsxlzMJK5dWXR7aUidshU/QHm218+W5HGdT32QV4KgqmHbPE0QoM93OLBtffj2EAYGeR47fj0l70oKneJLZX5CQdrFBLyI0PXW4i+rPOSY3rYWutKdD8jIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053931; c=relaxed/simple;
	bh=kJ0ml9ZhTWZ2+Y4N4ZRxr+drgCJu8pUNsfbJuoPYtew=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e3dwP8qEBZ+l7SpM5IWGJewv6XYUmV7GV2b951lzGuER6nfUD2exDKOClgDUgasok2o85JfYH70lgZjamc+liHLp4vknmiH4r6F2gQAc5bLp9kim/N+2O0E5Zj//PnCLgeRt6enr/6+/RQu92cf+XidfLJemf1OAZE9kF3Fvsu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6q1LnBq; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754053929; x=1785589929;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kJ0ml9ZhTWZ2+Y4N4ZRxr+drgCJu8pUNsfbJuoPYtew=;
  b=G6q1LnBqEUDxD9Drv2CnkzdlpNrps1S6DkUL7OW6eiSUIaJVNjzBep/j
   pYYn33VnB4Y3xhsxEgO3Tl6+DKNxlc/8T4LOELB0rXR+fgR05oH5muhMq
   960vaD+941kEpDTWnRKnXHCTkChHzrWR2xaypbrJFSoWPV00T+kmHed93
   eZH/TNXhcuRc90+BLMfjaLw5XTenDH+2P3Ob19JeIUktYy46DJI+4s+8x
   mE+WUSo/cb/AFJu8zF4qp5DNuHLpC0BZg2FKC+EsUa0XQiFSOzQhL3dLC
   EPTJRtCUldeN1cY32yC+dnhP9gAvSVq0B0lJ0s+63qhDfXPhYpjTPZJWt
   g==;
X-CSE-ConnectionGUID: bJ2E58MMSVm5PRxXfmvv3w==
X-CSE-MsgGUID: X4fXutkwRaKqgbE4xc45fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56479439"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56479439"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 06:12:09 -0700
X-CSE-ConnectionGUID: v1Xp6SzbRR2LeBoKj+XxAw==
X-CSE-MsgGUID: ca01tfpJSy6exaMMzrb1Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="167824640"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 06:12:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 06:12:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 06:12:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.88)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 06:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QupRNabw2SAadzflWnNlw3gC3Cjn0OFswb1vdlsCq2FvSeimqwzDcwj5v/0fbdAyFSsf+Cy483ZryU58mmYwBoDGAJKREzEJGBDEYP2M0jZThH7mlSYWU4vFzpjUYrCKos+WYksaubpVboGXAYFVK0F+HfucybVum5hUwLIsmJnEJfp8waDNtrQMGCfcnEkpqKBePKRE1iYgn1B/gynnhTJTvijZcQdK44/HGZDXvaWi4vfB1f56bVfwyOiaD6lr8UrHtxQbYyZI2MCOycipq3Gi6heEwJ5cNpBX/fZHG6s4qOCS99aUx+CaVRfcOqxHhexpmEc0F78ggZ9K+paXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb47HiOyFCM6ZHqTOJzXQq658l2SGgPzMdkjLkjpias=;
 b=WegMFPCws72uouXIH6OiFbAtMms3SbsnfqjwsfQTmcKbgsflrDHOo/M33+oW8ylHXNjZBB2A0scWIpM2YstHvXnhwMpeC8743MvIV3Pkicp6I8sqHyO5Dnt0u8+1xHMXvR3S13i6QTDyl9H6uVOwfNDhTQjhN5AQxkN+5WxuWsZhMlRXrqF41Q0rnLwXLPuPTLtlyi2Qm+jzmVMHsBwcGTKUMDrnZtaJ8YArud87N+D5TyInyRLgBC7ZB/otvBMnOs6ikn7dsvZfJ+hWDjb/FQyZPZ8APDdnkDNDPm1vPiiuS5okpmlMEyNuaD5hK2uXgTesnoCbsE5FtZ1bFaFocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB7157.namprd11.prod.outlook.com (2603:10b6:806:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 13:12:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 13:12:02 +0000
Message-ID: <9538e649-0e9c-45b7-a06f-d4e8250635a6@intel.com>
Date: Fri, 1 Aug 2025 15:11:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
 <20250730160717.28976-17-aleksander.lobakin@intel.com>
 <20250731133557.GB8494@horms.kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250731133557.GB8494@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 02879933-d1fd-4897-e59a-08ddd0fd0141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0VCMTFwdVErV1pzcEJaZTBSU1pCTTAyZXBTUTJsK1JRREZPanFBZnphSUJE?=
 =?utf-8?B?dFkxNGdlMDNHZng5VXByemNqUlNpL2tMQ0R1dWswMVUwalVvclpHOExIc2Vr?=
 =?utf-8?B?R1ZsSXd0aHoxV3FoMk0zcE5LdWxBM0hxanY0MXJ0aS9SL1pyRi90SGx3R2RZ?=
 =?utf-8?B?MExYNUNEYi9peUY0ZkE1YzM1cHRxRTBvR1o5dkJHOTVOMzBHWkhFWUJKRHZH?=
 =?utf-8?B?aHlWeUliTkVEaTNUekhDdzRFclFiTGc0MGJDdlZkT3lZNWh6TU1LbWF1LzVh?=
 =?utf-8?B?eEhIVUx3c1hsaFNxZDlReTRUelFNYTNlVGU3Tnh4L2pnN0Z1eHdyWU1LUFNU?=
 =?utf-8?B?VGR2NW41SHRYYkhKZkJ0WXFRcmZvemlVTWI2Kyt0VWJsVVNPWG5wdmZPSHBR?=
 =?utf-8?B?azZtZ2puU2pKd25BT0hUckdMZmFML3dLQStLQitzRS9uekI2N3FnQmF3MWE2?=
 =?utf-8?B?VHJ1YjU1MHNwMnh2ckZmdUV6eFJ2N1VSdFhsT3FrRlVLWjNCNndmRkFoTzQ3?=
 =?utf-8?B?NGJhdmJwWGMwS25DV2lIaTkvMjNRcW1xNHdKcmY0VTVtd0ZmMWV6SFZXTDdl?=
 =?utf-8?B?cnMxZVpOMXBzeDVzcEs3c3p3U1NRM1BZQThDL3JVbiszbmRmbXY5REtGT3hF?=
 =?utf-8?B?dHpwcGhuK0U3STlka0NEeUlzOWJ4cFo4YVNucHkwZWxtb2FVYVBycEJ6alJ6?=
 =?utf-8?B?QVlHWElBaUNPOGJKT3FadU9rd3RKNGFUNzU3OEtCMUhsRXVnV1d4QVBma0ti?=
 =?utf-8?B?QWtOV09hS0xjc3ZRaTFiRitVaTh2NVB4OW9CaTJsSTl2T01yMzNuMld4RVM4?=
 =?utf-8?B?R0RMT0hDSmtLaml5RXo1b3lRSlBBYkNBVDViTTBvUEYwSUZwUzA1Y2ZLTDNz?=
 =?utf-8?B?UTBvRlVVbFBaL1U5NlUvREFDMHB5Y0VwbDdvdllFSnF0RUo2M2p5UFVicERK?=
 =?utf-8?B?OXV0N1orUVp4WU1PeGJVK1RnVURpbC9HUnJLVnVGSU01dVdRa0x1aHVhR1BW?=
 =?utf-8?B?V2FLZWU3dnV5NG9VRkM2Tld2d24wMXBvd3RndC94aGJYZTFEdjl6cEJ2enlO?=
 =?utf-8?B?bU9aM3IzM293YnU0b0NuM3d3b1FJcDhkd2o0aU9KTnNLRk9UTUthU3Y1V28w?=
 =?utf-8?B?MUg4c0dYWXhPM2FLU0d4STlabytYRGJMS1JVT0JxZzlXb3BoNmpvWm1FQ3Mv?=
 =?utf-8?B?RzZEU1EzcVRXa2F3QWkxNUZkSTlPbzhiTS9RZVpIRk0xNEE0c2tjR1VsWnpl?=
 =?utf-8?B?NGdFZEllVXhKNnVFSTBkWVp3Y01QTWVYVXBEejk4QnZVU1J5ejRid3lGNEIv?=
 =?utf-8?B?NGxBa1dNbFUrYkpWSVBxd1FkT2FGUytzZXVad0M3b0k0YlRUOHlTL2pPNWtY?=
 =?utf-8?B?YUswMlh5Rk5qd0VDbm8zM1IySm1SRHEwQ3BXTFBuMFN5ekpLWk5RNkVvNUZI?=
 =?utf-8?B?TGY4UjM5N1VOZTdnWm1JN2FacUhEOU1hbEg3dGc5MnQrQUh1QzJ1ei9wUVpm?=
 =?utf-8?B?OHpFT2J3UEw0VDgyL0tGdis3S2o1UllhbVdQTTAwU0hjbTk2cmR1ejBhNTRh?=
 =?utf-8?B?N05heFpsRjdLTk1RbUdweU1CekJCbkVkbnBaSlF5Uzc2RkZrd1ljQzcxbE1F?=
 =?utf-8?B?ZnF1aXVuc2o4NGtMS1doOHUwSjlCWmRrSysrQ0E4TGNaOGtxRjQzVWgxcUlw?=
 =?utf-8?B?TnpLS0Z5b3VoWU1iL2FDaUh3OVdFTXhCMklsWWhFbXUwTWVrbm1jMWhjNzQ5?=
 =?utf-8?B?R0E1TFdYR05MZStueStlcEFJUzhybFBHd2FYSmV5K3RGTnF1THRsNFErbjJB?=
 =?utf-8?B?c2gwOXNway9IdHlSM0FBc0JtTTVjUGYycFRBUEk1eHJzRjdzeHkyeDJEd05U?=
 =?utf-8?B?Qnh6TGlEdEo4WDZDZTFMalY0R1BKQVRtUksvb0ZZZ1RJNS9RVlRralQ5YWN5?=
 =?utf-8?Q?nytCZCBLdT0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2MyQVh1aXdpSDQxYU1mbEF3WmZONklKWmk1ekhMR3dVa0NLNnpCUDZUb28y?=
 =?utf-8?B?SFFtQTZqNFEwZ3hON0VmeG1zMVF2aWtucXU0Y0E5NEdlRXRuZklLd3pMOThO?=
 =?utf-8?B?eW0zSERBakNKbkVjZ3gwZXZ2N3gyNU1IZjRDdURoVDFHNHcyWEJydTRyUDZj?=
 =?utf-8?B?bEt4ZE5QM3JDMk5aeWg3SmxIMHl1SS9FMkR0bDVIZTA5a3pNQ1NMNnRyL2lx?=
 =?utf-8?B?bnRNbW52elFZOHA0T09ZVXRYRjFIb2RkeXlaQ0hNWUtBQncxSjFvbHBxKzha?=
 =?utf-8?B?K2pacnYyWmpjdDFWcXZRZ3U0aWRJcnY2S1VCL3ZoL0MvSzV4NVJrUHlQTXNz?=
 =?utf-8?B?RFdjMGRRMU9rY0NNUHpXejRKTDlHcXRQTmNCNmRKVzE3WktZQnJwbnpoSnBU?=
 =?utf-8?B?RSsvRitsRXRyT1VXakZJanJDY0tiTUdtUS9xaFN2blJEVGxxV1cyWFMvaHFF?=
 =?utf-8?B?Vm13TFJsekNQd3o4bkF6NHZvalJMNUNJUjh0R3FKV0VHUG1nTG5HaWpjVVo5?=
 =?utf-8?B?UUFUajBWUDJkM01TTnA1SEJpdXNDZW9BVW16RUxKT29xMTlJSTFqZkdqQUVp?=
 =?utf-8?B?eFlMSERON3NwQWR6N1dZV1pDa2FWWGE3TjJSVEFvZVBtVXA4OVA2Y2o3NXg4?=
 =?utf-8?B?a3pmaWNIRzd6UVpzOWxlOGpkWm1FbmxqSExQc2FLM0FjTXpkOWhmMGRzY1ZD?=
 =?utf-8?B?enpya1YvaDFFaFlGUm5zclNOV1JkODRLTUJMSENDTlA4QzJLaTgvUFZteTBk?=
 =?utf-8?B?Y3ArRU1jSFNpZlRnb1FkRytGN3lMUXVCVHh3d09Cd05tQVJ6M0NoUzN6MmVV?=
 =?utf-8?B?VGs3aVVHZUprRUdabkc1V0YxYU1pUTQ1cm9PdGZMREpJcVE2alRhWnJxcGlE?=
 =?utf-8?B?T09CTi9wd0M4UVQyZEdUV1VrWmlBQlFXenpPSmIwbXg3cFRMOHFORVQ5YSsy?=
 =?utf-8?B?b0tkUUF0OC9ZRlNHU2xtd3RWekJ2Nm41MWxtQ2Z0SUNRdEwrR1JxcUVHR2xF?=
 =?utf-8?B?VHRNcGpvYUJJZXoweDNBOHB3SFF4Tk9WRXh6aHd2ZFpERXFqbTAyZ0VheTh4?=
 =?utf-8?B?RTFvTVdyWWYzc2JOTWIyK0U2RFk2a2IrR3Q3b3k3TzBHZzFwMlQrMWZOcUtZ?=
 =?utf-8?B?N2w5MzBkdkh6QjRhY1IzUDluM0k2NkN4dFhDZi94UlJKdGtrQjZ2ME1yQ1ln?=
 =?utf-8?B?Uk1xbEhzUkcwa2x0aEFEbWtlc1JtUFdnWFNLdHdsbk5ITHJhK1hrNWVVQmtz?=
 =?utf-8?B?T1BzTE5vVlR1VUx0UHU3eU5xOXNLVHZpcDRZWWNLZjJiMkQ2WGI0cjhaOUhF?=
 =?utf-8?B?TURkUk9LbFdkNnNkRlJ2bEhVU0tncW40Yi9BQmFYMDI4YmpqNkpLN3BnKzRi?=
 =?utf-8?B?dlJVMlRaYlVadTYwVWR6VzNQTzBlWFZIV1RvdWJDTkl3VGJFYkRnREVuajIw?=
 =?utf-8?B?Q2Y0MDBnV3p5WUNLNnRoYUoxaGY4NS81ZHI1YWYyNnJodTQyNkcxSHJBanZM?=
 =?utf-8?B?a0NhQlJlUE9XekJ0cWc4cFo2aVJhOERCNXpYejdmTmlkWm1vUWErUTEvSEJH?=
 =?utf-8?B?TzB1NHV5NUs3Qi91bURmL0JPUW1LNUorcjRTVEJSMVF6dlI4N2JHa1Z1eXZp?=
 =?utf-8?B?ZGJUZ0RaNUtZN0lrODB0MGhVR2ZMbTkvZVJzeGVjd0VMRkVTYVNZSHNLOTBr?=
 =?utf-8?B?RmNEdkdqNmZmQ0xXVnhnZ252MkcycE9sam1rODhxRVhVNDFTMjNKS3I4SzA1?=
 =?utf-8?B?REV1L3BYWVBWNDh5Rm41M0RnTEN3NHNMYUdYeTlCQ1dFUEJ4bWhWZE1ydFNj?=
 =?utf-8?B?T1QyRXNiQkJNMDVhMEEzT1lyKy9oZTVXSkVuaEtXYzFNWmZzK1FLWXVveG43?=
 =?utf-8?B?U1Vickxsb093VUs2UkNJZncrWEFia28yMnJqMDBBbnNETEUyRXRISmNiWmZS?=
 =?utf-8?B?cmJMTkJtQU5yQUxwWHJQRlJvdnAzaTVKTGZrQzV6Tmg4eEhDOTM0VFEyNHly?=
 =?utf-8?B?eUgxY3lXTUF1TjFRblNxcnA5cDR2Zk9iL09LTTB0U3dCUXdpbWtsQTltUmYy?=
 =?utf-8?B?U281Q1BZZzJnaExERmRNWER6ZnZ0RU0vbVI0bjh1Y0dPbnp2TW4vbmUvQ2Nl?=
 =?utf-8?B?ckJkL2pJaTNKZUEyUHMyL29LQnpNVUwwYWFUUEhPZUFVMmlRdnc1bko4UmlC?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02879933-d1fd-4897-e59a-08ddd0fd0141
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 13:12:02.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5dEMn7Y+5ZXoMCDh99kgiQsTVZwFOG7s6F01AGUZFI11O2e+jp49r+J6UXs4P4KVx5RMA5cO0mQz7o7RuYCZpBbwFkXBRoyrSUXEaRSjXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7157
X-OriginatorOrg: intel.com

From: Simon Horman <horms@kernel.org>
Date: Thu, 31 Jul 2025 14:35:57 +0100

> On Wed, Jul 30, 2025 at 06:07:15PM +0200, Alexander Lobakin wrote:
>> Use libeth XDP infra to support running XDP program on Rx polling.
>> This includes all of the possible verdicts/actions.
>> XDP Tx queues are cleaned only in "lazy" mode when there are less than
>> 1/4 free descriptors left on the ring. libeth helper macros to define
>> driver-specific XDP functions make sure the compiler could uninline
>> them when needed.
>> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
>> applicable. It really gives some good boosts and code size reduction
>> on x86_64.
>>
>> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
>> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> 
> ...
> 
>> @@ -3127,14 +3125,12 @@ static bool idpf_rx_process_skb_fields(struct sk_buff *skb,
>>  	return !__idpf_rx_process_skb_fields(rxq, skb, xdp->desc);
>>  }
>>  
>> -static void
>> -idpf_xdp_run_pass(struct libeth_xdp_buff *xdp, struct napi_struct *napi,
>> -		  struct libeth_rq_napi_stats *ss,
>> -		  const struct virtchnl2_rx_flex_desc_adv_nic_3 *desc)
>> -{
>> -	libeth_xdp_run_pass(xdp, NULL, napi, ss, desc, NULL,
>> -			    idpf_rx_process_skb_fields);
>> -}
>> +LIBETH_XDP_DEFINE_START();
>> +LIBETH_XDP_DEFINE_RUN(static idpf_xdp_run_pass, idpf_xdp_run_prog,
>> +		      idpf_xdp_tx_flush_bulk, idpf_rx_process_skb_fields);
>> +LIBETH_XDP_DEFINE_FINALIZE(static idpf_xdp_finalize_rx, idpf_xdp_tx_flush_bulk,
>> +			   idpf_xdp_tx_finalize);
>> +LIBETH_XDP_DEFINE_END();
>>  
>>  /**
>>   * idpf_rx_hsplit_wa - handle header buffer overflows and split errors
>> @@ -3222,7 +3218,10 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>>  	struct libeth_rq_napi_stats rs = { };
>>  	u16 ntc = rxq->next_to_clean;
>>  	LIBETH_XDP_ONSTACK_BUFF(xdp);
>> +	LIBETH_XDP_ONSTACK_BULK(bq);
>>  
>> +	libeth_xdp_tx_init_bulk(&bq, rxq->xdp_prog, rxq->xdp_rxq.dev,
>> +				rxq->xdpsqs, rxq->num_xdp_txq);
>>  	libeth_xdp_init_buff(xdp, &rxq->xdp, &rxq->xdp_rxq);
>>  
>>  	/* Process Rx packets bounded by budget */
>> @@ -3318,11 +3317,13 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>>  		if (!idpf_rx_splitq_is_eop(rx_desc) || unlikely(!xdp->data))
>>  			continue;
>>  
>> -		idpf_xdp_run_pass(xdp, rxq->napi, &rs, rx_desc);
>> +		idpf_xdp_run_pass(xdp, &bq, rxq->napi, &rs, rx_desc);
>>  	}
>>  
>>  	rxq->next_to_clean = ntc;
>> +
>>  	libeth_xdp_save_buff(&rxq->xdp, xdp);
>> +	idpf_xdp_finalize_rx(&bq);
> 
> This will call __libeth_xdp_finalize_rx(), which calls rcu_read_unlock().
> But there doesn't seem to be a corresponding call to rcu_read_lock()
> 
> Flagged by Sparse.

It's false-positive, rcu_read_lock() is called in tx_init_bulk().

> 
>>  
>>  	u64_stats_update_begin(&rxq->stats_sync);
>>  	u64_stats_add(&rxq->q_stats.packets, rs.packets);

Thanks,
Olek


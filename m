Return-Path: <bpf+bounces-35551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8E993B6B0
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE46D1C23BA8
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C5016B732;
	Wed, 24 Jul 2024 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xsvo1Tu2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CCF15FA6B;
	Wed, 24 Jul 2024 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845644; cv=fail; b=s3xom8g6FUn2PByS+90z8sSV3vHs/CIOocCbTyvro8+xm9MwfN33nTrmxbtJmzFGrra/pwG9sYkowESWc+RXrKBvFTAGi/5BiGVu0uV0zAWJ1giod8LMIq52TkoU3onp9RSrz5djxTohYHeCVBYjwi9IasPfThXVX0C1h2muHps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845644; c=relaxed/simple;
	bh=29UQZ/wKZ5b9teQx7nMbbHr+YgL25FXfj3Ns/tnJMXs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rFfnj2shvjxFajdC4jusybEurTRzeAboFDR2HDAhU/dSTr6l+IWCnPZ1ApCPdPYFVU52+80PjMqfpBVzdA+daynW2E7ysjQUxwuWKFE9fFb2W3+7lNurXjxJPEfjb487jwAUTK2FjD+1h6/YTnl+eMe+fwB2cjOKseNaATDjgoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xsvo1Tu2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721845643; x=1753381643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=29UQZ/wKZ5b9teQx7nMbbHr+YgL25FXfj3Ns/tnJMXs=;
  b=Xsvo1Tu2verHLn52LD3hA1pzD6Hc0zgPiHmeFhqzQwIIqJ1QIKO72f9S
   ruFVt7GK906D9xiGOGFgowydrM0a8mg4AEdrNvE191L0porJ/9Z5LGJcc
   d0ZgbB3jpbCQC4a0L2W+bj9+LNCRLnRTz7dg51W2ap5YKiuGOEU/Jw4MP
   zEKNVhbhA9nVQ1ifdgmcmvGvZt2/kDbAtjDy2WOxXj4iEMqw2gXcEcm4e
   DiEsugVaSeboRFnO+nL2lsKWWpYh1ciO6FYJgCpfPKqwo10KxP/8pireK
   2e6IbI01nvpxJ0iOvpiTt+c7TXjb10Ac8WtDCCMEELrreViKbE08tdYI1
   g==;
X-CSE-ConnectionGUID: Yi47OMdBTU2TU0hh95h0Dg==
X-CSE-MsgGUID: Kdz+6Wy6RaG0oJBbkvNv9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="23408879"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="23408879"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 11:27:22 -0700
X-CSE-ConnectionGUID: tTpKlg6FRWmoAZ1jEHgW5w==
X-CSE-MsgGUID: MMGjqWRNS9SS4gZNy2fymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="75901414"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 11:27:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 11:27:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 11:27:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 11:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7wLIz0/I4i/sCJ1lXetBeHTmvZ7MAzMeslrl8ReqzTKxRymt6sckH9/vczqoXHNShHIEGEQEKeM4f69nhnfi9OwW4eLLsyeW0bvv7fmhY2xI6r49TI6SMY+lmTPmum6fnMAhv1830iHRsERFSXEcFbTNK1FA0DF5Y22ctImS9wpYUld/J7puGLJl2ibBpFd+0mEbPvTAoQ2R0M7122uNP/z/r8JGBm8KH6URmvbzE7+lqowijXC10u8/KW4gswcLXqGBhGmDzQBHbDdpS6/e9Jc/jN8Tl5xr22hJi5z4PrJ3L6QJ4OtvNU/SK2zP3ZX27UoXPVLYwxiB7DXTpUVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5SaEHmt+QRCp8/NGToh+Nrso+U8kpxY1Kt1ESQadQ4=;
 b=KvUPd/tfL7cil0GPaVhQkTIU3NsZbDT803fp/0263S4QfPfau01pNC4xJOYKHmFkmQxEbpsdL12QGp+hcd/SUXIocJXaWMmeM0pn1o3my0EfafHUxheGEDo/s8oC/Gt32rQiOemqGN3HDFUEkR587O3/ycQ8Fw8ubWJkMe+MBgLn447r64JHGrt0QwxLoigpSUxnOWwSPxpF6ArITNFpTvqn3mbwlkKFv3Lt/HtZTOeJOafoPF2xNjvIElIV7yOGOzNg42XBQ0I7hQI+/3/P85ZZQpjO1fDSp0wNygOLpBkAi0LBzSgyRsNXa/Q1ob4gUvtwgalAyVPBucoAKPZ1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 24 Jul
 2024 18:27:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 18:27:18 +0000
Message-ID: <d08eeee9-1178-4f33-b22a-a32d6f3dc086@intel.com>
Date: Wed, 24 Jul 2024 11:27:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 4/6] ice: check ICE_VSI_DOWN under rtnl_lock
 when preparing for reset
To: Larysa Zaremba <larysa.zaremba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-5-larysa.zaremba@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240724164840.2536605-5-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:303:b8::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0780f9-b418-4f79-1b76-08dcac0e401a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUFFWEk2Q0YyaU43SXhUZTZDK1hvdzJHd3pqcnFJTFAyNVE5Zyt4dHpueTlU?=
 =?utf-8?B?SFc0WGZZQkN0TjdKMUpybG81UGpnRWlEZUlFRmNodlhxZkdrVmdWUmU3VkdH?=
 =?utf-8?B?YklZS0JkaDZaUW8vRXVsMmJCck1SR29QSzhuRHlxSVZsek4vLyt4VDN5WHda?=
 =?utf-8?B?UkRTQll4VzZLL01qWWE5aldocVpra0hvZ0ZXUzVjUWhPR3pMMXdZb2lHcmZt?=
 =?utf-8?B?cFZmdFo5TWpxQ2x0alJHV240VkdvRnZQTk9nWElGQUtWbGhmdVMvRVROa0ZI?=
 =?utf-8?B?QmV4dmg3UnlwSmhscExJZG90eWFQUnBwMm11NTA1NE4rV3h0bWQzNHYwa2po?=
 =?utf-8?B?d0R0cElpUWhpcXhsck5KcFNZcFV5ZHZET1NEeVhKRHlBcVZGeU9JMXhNcFJl?=
 =?utf-8?B?QUE0OUdPc09qSGIvYVVOZFRrVmRtVjB4NUgrRXErZ2RSN1lWUVN5anhnZ04z?=
 =?utf-8?B?SUNTTVRIU2I1RUlHNnFEbFMwei90NnFxcjNVRUtFSXZlM2xoWkhNbnpnSVFS?=
 =?utf-8?B?bDJqdXIzMFRpeWovVVh2ZTFjUWoxYjU0TkFzazJxOEF5MmZpMndYVGw4TlB5?=
 =?utf-8?B?dVd6ZEUyY1pYTldNc2J4U2hEamlHNHhCOFVwUTZZb2lEUyswUUJEbHQ5aDVQ?=
 =?utf-8?B?QnpEUmxUeTBLamNWYStCSTcvUjlTWFplZU42c2Rvc0hieit0bkRreU4wdHdN?=
 =?utf-8?B?WGYyMnVvTlUxeUpVZG1Xb0pHSkkrWXNzSkV4T20rYmN5Y0hscmZIS2FZSTlk?=
 =?utf-8?B?THhVSyt4UVB6Z1pUajBxRUM3UVJzV1hLbGVXYnBGTmtWa3FHdW8wcUZDdVBV?=
 =?utf-8?B?YTl2RG5NMGNyY3F6QW82aWVKZGNUTG5wR2gxRnA5MytnNEVta09Ta1BkY2k3?=
 =?utf-8?B?eTZ5R3M1YnhBU0IxdENkRHE2aEIwZVR6NVM3S0ZqRll2bWdOcTlDSW9jRm1x?=
 =?utf-8?B?UDJXNU50NzBrVWRUZ0RwZ0dCTWNQQnFvVmJSU1BWSndnYldpMnJJZk5uSmRS?=
 =?utf-8?B?bXZjcWVFSEJKL25OSzZ1YU5NYlhZc2taWFAzUGhLcSs2b1N0Q3RTcUEzRUNL?=
 =?utf-8?B?SUx2K01kS1ROeWx6a0ltU0F5SzczRXVkSy9WYWZrakovdlByVmw1T2t1T0Q0?=
 =?utf-8?B?MmdOdHQ0NGFKRFNZS1pKMENQbE9zM0pTK3Zadkl2Mzd6Z3Q5QVUwcjNqQU9x?=
 =?utf-8?B?MmR4ajN1ZUdHUDJZY2EyV3piaHBNUzNwNWFXdlhuUEV5TWg1MzVsU1RWK1pz?=
 =?utf-8?B?dVFlRGt3NGUycFVJbHMwcllIaldlUjk5Y1NkY2V4akhhckhTUUZZZS9UUzAz?=
 =?utf-8?B?N0liS2lieHZIakRjaW9CUDRLek9BeHl5M2RXZHlZTWppd2Y4c0xRUTU5TEk2?=
 =?utf-8?B?WEZadEd0cHA1cW1vUytTbUNRcnJpbWxSbkgyUHAyRFVCOE5JdTVNUmdqSTFu?=
 =?utf-8?B?eHhpZnYzWmtFMnNIUU55VzBkakxJd1hhOStLd0NjdUN1OUlWOTR2dldmenp2?=
 =?utf-8?B?WmJZckZqMG0wNmVlWXVqdXphV0tnekg1LzNMalRzb3FOYTV1TkpIQ1lCT3Yr?=
 =?utf-8?B?ZC9Zbk9BTEF4OC9GTy9YaCsvME5TVXFjY2FvTkFhdlQxdWhmblg3M3l5Nktv?=
 =?utf-8?B?RGtiT2ltTzlYYmg3K0w2bHpQYWtROHU3VVU3K3lPcmtWdFUwaXNraUdVU1ZK?=
 =?utf-8?B?bnZvQ2E3WkFqamNqMmJpVTBhSi9UK016TG5XcFFQSmYwRFFIL3o1emlwZExk?=
 =?utf-8?B?NUJIUSt4SDlwK3M1cE81ZGl3QnBjS213WU1xUlVsNkV5aUt6U3RSQTJYYTVD?=
 =?utf-8?B?VXBVUFV2Tmh5cWwvVDNadz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnNlaGVaUVNyL3VPNEdyM2c2dXlZc1l6cHQ3aHRoQ0pCOUprVVIrSkZRelM4?=
 =?utf-8?B?RzExWkNDamlvcGwrNU5HRGxvcFZoVDBMa0xHWGRvb0FpeW9kc0EwOVY5U09m?=
 =?utf-8?B?MlMxNWdEL1B1QTNidFU1VE43ODIwZTlkNDkrV2ZaSFlLT0t6bk1zNm1yRmkw?=
 =?utf-8?B?ZFdlc0hWL2lOVHRGNytMeFM4a2E5Wks3OHpIaHl5aEJ1cWs3TUYySUc3S0Z5?=
 =?utf-8?B?SDhNTHU0NGg3R016ekk5dXlvR2NCUXVEdTFyRE1JeWhMcnZzc1Rta3UyY0E1?=
 =?utf-8?B?anBaTXNWSzJBZzVSbWtTcGlIZ0Rrc2k0dCtzd3dTdHZqTDRBQUhxd3B5UWhV?=
 =?utf-8?B?aWhLcEY2a1F0TFgwTmJlS3JwUzF1Y2JtTTZTcU1lSVRPbjJvVVg3a1IvczNk?=
 =?utf-8?B?UVhsZFlBN1NNY3I4czlPcHN0Zmx2NlFjc0NGcm1YaG51SW1HZFRNZHJtd1Zs?=
 =?utf-8?B?TFZucEprZytHenlnU2FHY3FlVGhXeE14YnIremhnWGNqd0lXT0drZWN2WEhM?=
 =?utf-8?B?aHNCREtmRFpZVnBUVGkzQmsxQlArVHQvT0pmMVhIZGp3ZUNzdGxJRWh1eDJj?=
 =?utf-8?B?WUZWQmNjVHRiZStuWStyQUZXM0YycG5XK2hDWWQzWlZybWI4eTI3bjY5WVhj?=
 =?utf-8?B?bHNVdjFGVnBHL21kMHlGdG8zZUk1a0lSbWQ4Z1Q2SGZHcjhLMWhrT2ZsOG9Y?=
 =?utf-8?B?MC8zQ3h0azlCSmJnSnM4N3dqUmNiNk8xaWRsdkIzWVBFMDRIeTlPeVcxOVBN?=
 =?utf-8?B?Yys4cGhzVFR6KzQ0M3o0YS9XcHRsM3FGdC9pT2w1QkpwcXdOaUJJWlI3UWVl?=
 =?utf-8?B?bGtYT3B4Y25OZGJpSzNnK2t2bmNlWmE3WDVrOFFhOUwyV3pQVE12dG52Nm5s?=
 =?utf-8?B?L3lQZnRDeUFxN0I1dFNRaFlSa2cxaUZtLzViY0RBK3JoWGVjdGhPTHlpd29k?=
 =?utf-8?B?aUNoZWw3RUhMbUpCVkhVVWxPL0dGWDh0OThZZnlMeHV5RGFOSVdBQ2NXeUEv?=
 =?utf-8?B?VkJDcWtFWU5tSVZKQWg2MUlseG1zY0ZYUXZWcVVwY3p4OU9BK0ZXS0N0YTNG?=
 =?utf-8?B?K083RFFQZHdlTVh0ZytjUE5Gc0J4c1B3YWNpbk00NDU2b2grL25VaGdjN2VF?=
 =?utf-8?B?MktZVXdpSzNoaTRib0M5dEtsMzh6Wlp6aGwyM1U4QmNPU0JQNVQwTmNyK3pF?=
 =?utf-8?B?RkR5ZEg1bnJzWGxwNmI3NFZBSVVUUy9nZDRVYkRyeEd5dm1hNy9NazczaDl0?=
 =?utf-8?B?U1JlNUVKM3pvTXhCMVlVMUo5NTlESDdSdXhmWVFPY1ZTWGZPUEFnd2l1Umph?=
 =?utf-8?B?TmlvS0xNMTRFb21KTkdGNjU1blVERUFxK0dlazR0dmVkUmFhMVNZWmpELzBJ?=
 =?utf-8?B?MUJtb0w0a082NVNHUGR4ekRJYS91VzBTS2k5N1hNb2lDNExydHRjZUtONExi?=
 =?utf-8?B?amhWNDcwMXg0L1hDL2owZUJNQ3dpNWVWeGZabWZRcnlERlF5SEp1NXJVeTVt?=
 =?utf-8?B?dFpVTXh1M3R5Mmk3M1ZrRUw4dWl6aW5Od3p3eXFpVTV3allobGtBVVcvWXd5?=
 =?utf-8?B?aCsyYzAyTWYyUGhCWk14eFd1S1Jobng2OFJyQ2V1ZWxHTTNDUndZUGxxRGVr?=
 =?utf-8?B?WTNoY203aGxTeDFnUWlMcm1KSCt3ejF1SjZsUldLdHFCTFFmSlZWM0YrdXl2?=
 =?utf-8?B?RjFsM1hFaGpRZ0VCa2NDQVFOTGRSWUx1YmNIVUlmYjlHTjFlSldmenk0eWYw?=
 =?utf-8?B?SHhwVzdJNVV5ZFdTTTNuVEQvYW9XTHJUT2tWd3JIK212MXRBVW1TTzNRS3Fr?=
 =?utf-8?B?aG1IMTF4QVFOSzdtYW45RWpMUkdyaVNNZnV6K1pFeXNtK0cyL0dOVkRob2Fh?=
 =?utf-8?B?Yno2YmRXclFrRmdYeHY3YU5LUG93S3YyTEZRNmZSbTlndlhaenV6d0NtU1Jn?=
 =?utf-8?B?eUlUZ1JrV0J2SXhybC9pTHorRHZDU253MGtxODA1TmhhRTV2ZDZCalZOSmxT?=
 =?utf-8?B?VElYQU8yc0NxcHYzLytkRUxDRnNpbXpFN1hUV3N4enh2UkprTUkwZlMzOHQ2?=
 =?utf-8?B?UUd5bEpzWFh0VlZoVFlsVEFOR1FuK3NRMmFaRGZ3NG50SysrK3dmRldLbVBD?=
 =?utf-8?B?aUsxLzZTVk1DT0I4UmRqMHhUTnNQSFZDdkd4allPMHNxRC91VWg4bE91c215?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0780f9-b418-4f79-1b76-08dcac0e401a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:27:18.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f7tv+tCc8KkOP+kJz5IvlaL65VWPKDYODtAuzTB6HQzRocDST+RjIb9tJtuC/Y3qHlwpH3DXIFX8SROsg4mK71KqvXMrBB4oTWmQixMbDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8775
X-OriginatorOrg: intel.com



On 7/24/2024 9:48 AM, Larysa Zaremba wrote:
> Consider the following scenario:
> 
> .ndo_bpf()		| ice_prepare_for_reset()		|
> ________________________|_______________________________________|
> rtnl_lock()		|					|
> ice_down()		|					|
> 			| test_bit(ICE_VSI_DOWN) - true		|
> 			| ice_dis_vsi() returns			|
> ice_up()		|					|
> 			| proceeds to rebuild a running VSI	|
> 
> .ndo_bpf() is not the only rtnl-locked callback that toggles the interface
> to apply new configuration. Another example is .set_channels().
> 
> To avoid the race condition above, act only after reading ICE_VSI_DOWN
> under rtnl_lock.
> 
> Fixes: 0f9d5027a749 ("ice: Refactor VSI allocation, deletion and rebuild flow")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index f9852f1a136e..b773078ad81a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2665,8 +2665,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
>   */
>  void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
>  {
> -	if (test_bit(ICE_VSI_DOWN, vsi->state))
> -		return;
> +	bool already_down = test_bit(ICE_VSI_DOWN, vsi->state);
>  

Do we need to initialize already_down? I guess its because the other
initialization happens inside the conditional which may not be executed
in every flow. Ok.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
>  
> @@ -2674,15 +2673,16 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
>  		if (netif_running(vsi->netdev)) {
>  			if (!locked)
>  				rtnl_lock();
> -
> -			ice_vsi_close(vsi);
> +			already_down = test_bit(ICE_VSI_DOWN, vsi->state);
> +			if (!already_down)
> +				ice_vsi_close(vsi);
>  
>  			if (!locked)
>  				rtnl_unlock();
> -		} else {
> +		} else if (!already_down) {
>  			ice_vsi_close(vsi);
>  		}
> -	} else if (vsi->type == ICE_VSI_CTRL) {
> +	} else if (vsi->type == ICE_VSI_CTRL && !already_down) {
>  		ice_vsi_close(vsi);
>  	}
>  }


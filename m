Return-Path: <bpf+bounces-32706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D535991204D
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD90B21EA1
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356816E860;
	Fri, 21 Jun 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDezsrbC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E752F71;
	Fri, 21 Jun 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961454; cv=fail; b=H8cs64W7msmFo8ZQBBILvF9P16s6p1BOfdd39KR7U3mXkRJ9d9g5hrhksFhvvJbMWsSvFrrq50z9qv5YdJ0arxBqGuqi+pPpIcc7Y9c5iEITLdhOWGCoGTT+CZJOcM1i79OHd57EUiveZ/MBW2r1GcymwQ+YPyt+FBZV4bcgQ9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961454; c=relaxed/simple;
	bh=fJHwYa7HWKlaYsfw3hd1zmAUPin1tUlf3XfOLSeJhME=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/JIN+Wm8jWFls74KzaWh/Y+PHnBeXAmFg7K865DyDl5gerfV0ZnCj0y16ftKEXYNbtRGDSyFexqbu2maSsIdnn2ZGaeTDdsTtf3xia7JMRAxOvFqtDVMaxF9VSxEZXYxvq257J7UjbI6xX7tITrudE4aIbVKJ4deVfYe4cLfsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDezsrbC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718961453; x=1750497453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fJHwYa7HWKlaYsfw3hd1zmAUPin1tUlf3XfOLSeJhME=;
  b=gDezsrbCIazY7xSMBjiKe1fRLk/pwWd/OwQsu2bGwVx9NF0In23+NAme
   VOm5JIQ4L9KXe2Sj6IrLJAxuDOmr5vtuZCwSZIephh7iwxCBTc8Tn/FKW
   ezY1s2i0OgkKYJEzNdeVJ1lum4SZPw2T/ybG3sB+Xj53XZfdmMAPDqs8k
   O60UrlNmwLwHi14Y57sFFlcrr91N2i5weWCNeGksJ6kG5H8AX37LmdFh8
   7dSDTFlk8pF5+L3fBV9D6JGQVx3uG1gCib10isL3gpUfIWkOo+8fYp6+5
   M5vjd8/Wp5xC8uTnhKskzN2KX/VY3awCLel/efOD/yGZTHBo81UV9zx8D
   g==;
X-CSE-ConnectionGUID: +fn9VBGMSdKUsgbwG9oMDQ==
X-CSE-MsgGUID: Xn1anDr1R9SK/3vOqYTykA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="18894493"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="18894493"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 02:17:29 -0700
X-CSE-ConnectionGUID: ysy7w0fMS2mYei78W53iAg==
X-CSE-MsgGUID: graROBHvQk6b7DEimsCrYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="42494157"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 02:17:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 02:17:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 02:17:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 02:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji8R5GxqFPanC6JDy2Ae+K+9ZKuokHMlJLI0kPgvs8D/VJqZFUd7YN+Nhm6JeC/jflHhkXRJA8TUmWJz6EgF1kFnP5OS1QPrI5xSd/2T6PKFjl0y+yxQq3PDscvVSrV8cC79tue7YV6SoNxn64LiThIfV0SoNosO2yOx3CCvq/WqWcYSDF2jlYqt8jRgbaGS7M9i338kSp4GOnBPCEYfNjrMrnwuRAAFcz//kbL8mwqDPL7l15T2saMqUbgOqknuoDWRoTjf8ExO4D5tHpfCNqIRIYC73fzIqvVfMyTtFb7ul4pSavxEo23qK9TjraSbojk9MjW1GGCeIJRXq1PaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXPPex4Ogo1jcnob+/KlKDOT3ZItoOUSNo0Ko/zaYOk=;
 b=doTMyIsOhUzVpd117jaLirx1d3aoISvWpxeCO1ATUiYzywznwcM5tYG0Mr6OwlepYzao7dFyq0kqHi8EeVoouSjWTRdhS1PU22biGFhiaVIdpD4lNLaKzRQts5T2PurxSLK1gheg/HDKd4zcwGroZ6Gd4UIpUqUkjTkVCBfN6Tzqh9nYsgBkAmrqbV2AdVIbLekuVc+Bbz38OITPsIW9PdVVVKv/xaiWrdm8QGqJUpcCjx/cG1kgIu9Lbax9VLwmmO7tcFuWaXt8oWDBufXz1TXcVQEPIxIj420LJnYEOUP9STE9yKUkCvFJ6vfdp+fWqUz3y0UGJeNJUwohJ2P2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7832.namprd11.prod.outlook.com (2603:10b6:8:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 09:17:17 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:17:17 +0000
Message-ID: <7ce408ff-77e1-4d7b-8b4a-5ce5e16397dc@intel.com>
Date: Fri, 21 Jun 2024 11:15:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 2/9] xdp: add XDP_FLAGS_GRO_DISABLED flag
To: Yan Zhai <yan@cloudflare.com>
CC: <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1718919473.git.yan@cloudflare.com>
 <39f5cbdfaa67e3319bce64ee8e4e5585b9e0c11e.1718919473.git.yan@cloudflare.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <39f5cbdfaa67e3319bce64ee8e4e5585b9e0c11e.1718919473.git.yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 836a3a62-6007-4059-3f27-08dc91d2f211
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWdHY2pWZ1Q2RHVIRGFSVmFTVmt1ZTdhMHAxdVdDblhEUXBOb0FKaFM2T0VU?=
 =?utf-8?B?bG0wZU1SbkJyUnJGeHJqRHRxZXl6WmdWa2tWVERkNW96UDN4emFoUElCOWlO?=
 =?utf-8?B?NG10cnp6STV4WExEeHIwOTUwcktWb1VTVjBtdVRmWi9Za3Nud3ZoRFdJWGtO?=
 =?utf-8?B?RnBKQzdnZVhRK2NPZWlyZExqOW0zbThZdDFxQjJKQVZvelRZa290UmxHZ0JH?=
 =?utf-8?B?aDJuRExJalU1WElGNFJ2VWl6QkJ1ODRtdGtmUXplcTNNZ2pMSGZMVjZnRGJL?=
 =?utf-8?B?MEJhUFpZaFRFOGpFQXNRYXBFbjNQQUhubFhMMWlRUnYrKzluOER2UU91RHBz?=
 =?utf-8?B?cmZsZU4ydUR4RzJONGlZaVlrUFBodmRPMngzOTJ1ZkwvaGFHY2tXelBkeTZo?=
 =?utf-8?B?UzF1V2N6Z28vcWFDNWZ6aVFCOHdyRU1QS1pvRXF2T2FnQWZiR2NaYzN1TElT?=
 =?utf-8?B?b3VSMHJXMGZSSUk4b0pIUXVyVkNWTkw1aTdMcXdzdnpLV2xIZi81VXlGdGhI?=
 =?utf-8?B?a0gxSDRXdXh4ckJTckZxY1BGM3V2ZEU1ZzBPN2VvaFNieVpvczlrUmVpOHVB?=
 =?utf-8?B?K1hGSVZhM2dQaWJvUXJoMjE2amRyeGFXaUNnc2hCZ2htWTdlVEM2RkJaU3Vq?=
 =?utf-8?B?TzVNc1VoWGh4WUx4NHpHamQvc1djRjBMak9JelVIUk91Um9NRlZ6dGI5bHZp?=
 =?utf-8?B?UHAwZmxrTFMwYkRZOEtvc2lZS2ozY1M3RTR5WlZPTUQza1YwTVVQRWdZaUpT?=
 =?utf-8?B?M01NbE5URW9ZTjNrRHVLRmZhT3dMbGwvYUN3SHU3a0V0Mzg0VUVwaTNVaWJR?=
 =?utf-8?B?N1dVZjNua0l4TjZFNXB2eGNNaEZVeGZhVFUwbnl3bUxCc3lOZVEzTUpKWDJX?=
 =?utf-8?B?MFB3ditObkdZcG9sLzFuSnpVZWpCV3Fvdlhsc09xUkNJRlIzeVJRZCtaWG5W?=
 =?utf-8?B?R1RIYmpmSXAreWk4bGx1Q0o4MS9ycWlpSS9PcEJ3Qm94YisrTm44N29CS1Zk?=
 =?utf-8?B?aTJaNlFxTWVGQWFIcnB2VXlGdUFERHRzTXdQY0hsTUNLSVZqT0FDYnpZZmg2?=
 =?utf-8?B?REpuQThWWVZOZkVLNVBlaUNNMzRsUGx3QjJwWjkzQlB4ZmE3N3ZWUVNKTlAz?=
 =?utf-8?B?VG5MYWlzV3JmcFROSmpocjY2ZFhRdW4yRkdpL0hkbkIvdy8yUis2NTZTVHg4?=
 =?utf-8?B?Y09JMU5mTGtsYWU3eW14ekxYUXBnREhFaEFTQzl5dSswVFVEWjdSVFR0L2hs?=
 =?utf-8?B?K3Y0blhxbncwc25tOWd5eityZnI4MUZoeVh3TmFGaVU5SEZDSU1vby9VbHc3?=
 =?utf-8?B?eUJIL3p0cmNnYlV1UmMvTHhHb0Rvczlab0tUZG81bWpyWTBLa1lkb2pHK29m?=
 =?utf-8?B?MUtydzFLU1hiMGNTT0lCVXR3cFBpZmFSV3F1UWJPT2VaWXZBL2hOUml6aHIw?=
 =?utf-8?B?ekVlbTREblJHSWJ1VDJETXg4dlRjYjN4VEFlZG9kUGFVOHFtdjVrdThyWEwz?=
 =?utf-8?B?Mmw4eWhBMkFoR1RBUmdXNFNoZVJsd084YWN1c3JtSjI5MWlIVnhzWGhhb0lT?=
 =?utf-8?B?bFN1c1B6ajN5dWFoWTRNWFRKcWNGRjBmdGRuMkdYL3ZCeWRBZVJJczNFS1VU?=
 =?utf-8?B?US9oUGNRcm5SS0FTWVlKSDhnM0lnU2w1WU5HR0hiTGI3YVZuL0tKeGdzZXNU?=
 =?utf-8?B?YmVaWnFBdXpwdFpDdXp4Q0pMRlNESGN4K2ZiazhWZHI5OXdrcHhnQmlTcWVO?=
 =?utf-8?Q?AtgUjQ82Kmm5MnpczD4LGGWYgs995oMTdYxKnFr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEM3WTlRRjlSb0hCV2lMbUNpam5KM2l0TDlWbThXSXM4M0hyOCtsUkdsMUQ3?=
 =?utf-8?B?SVhIbXNYOTJhTE1Rbk5uT3hmaEpZYTBnS01jYjNwK3pYZDRHb1l0MEN0S0Iz?=
 =?utf-8?B?SGpkMy95dnRlTm1oVkJqN3FmSmFYamVMR21QN3o0eWpGOURydXRMY0wzdHc3?=
 =?utf-8?B?a3RCSTcrb0VrQ3dUVmdNSkFIalN6VkR4VU5pNnVhdkpFRnRzcVdVOUdZKzlO?=
 =?utf-8?B?U04ydWp3d1FxSlk5QlVIc0dnSWNnTk5iQTBWcHFDNkZuMjd6cUdqcVdDWUtz?=
 =?utf-8?B?MmJ4eVVGV0s1cUZhZHVIRGN4OUhYLyszYXpxTjh6dFVNSXV3OGVFMXJtY2Rw?=
 =?utf-8?B?b1JkcCs1ODVjcXl6SFBkcmViMFo2S2drRlFpR01VY21NV1R3RVUxNm1VVm56?=
 =?utf-8?B?U1RIVWdrWkthUXF2dXpZK3paU2lFT3J2bFhwakY1SnM2SVFVSzI5clNkQnZU?=
 =?utf-8?B?Y3RZb3A3dVdNOU5BYU52VTVmUThUR1g0SlNsaWVaTE9UcUxuVHByak5qenlC?=
 =?utf-8?B?ajdpVGxzenIyNnM3cTFydHNUNUZJcUszVThhQjFNSWxoTGs0b3hKa3NIbm5Q?=
 =?utf-8?B?SnUramdHLzIzdG5RL214eWJTOEtKd0Y2dEgvQUtBVHc4bXNEY25PYjIxQWtK?=
 =?utf-8?B?TlV5aVdKeTBRVTlOcThkL0xCbCs0ZzJBaXpvL213OEVYVDdEa3BzM3VQQ1du?=
 =?utf-8?B?T3hVZFBjUjhKbERickRFeW5UMjF0TVJOQ0U1TWxTdDRJWXJlVTdPUG94NHZs?=
 =?utf-8?B?VmphM3JKdU42VklPN3hxZ0l3bHhMRENGN3AySnlFMUxoWmRDM1JtUXlGZkI5?=
 =?utf-8?B?WkU0SXlhN0kzTCs4enNuWGN5dHorU2pkaTFpazRQMVFiRUdGSHJpME5weWhL?=
 =?utf-8?B?Z3lCMjJORDNPWU1UelMyMFFrbXoxdzVvYmw5OWdpaSt0RnRyL3hubHZic2Zo?=
 =?utf-8?B?em8zbXB5OHhnSDZGQlhnRGpURmRQbUNOb3M2bEdGRUxTT1ZmM015UFpHTFdj?=
 =?utf-8?B?SWhwd1FxV09XTmJiWWtVTmNGRElxb1p1ZXUrMHhSL0JPdjJzTkxyNGZzeGxu?=
 =?utf-8?B?NHV3cTMzTHhlVENUYUxtS3lER1BRU1lnVTBHVDFWa0VOMHRlZmJ5cTdZSnF4?=
 =?utf-8?B?anhYZWRVMFJZMlVMRzBad0JGazZONloxWFVwVW1aRTlqTTlmV1dDSjA2RFdF?=
 =?utf-8?B?MndUVkZPSXhYNG5DYldXVnFaZFBRUnU1UXcrMzQ1NVZGTW9JbVhOR0ZYekFD?=
 =?utf-8?B?dEd5cGpUTjNsdmVGMlBTbXk5RlNETGZrYjlQcjNSV0pPMnd6VU9wRWdtNlc3?=
 =?utf-8?B?aEI0QlU1SSt1emt4S21XdTROOEl6OWZTTGlhR0JXQ1U2Y3BrOVNRQkUzSlVP?=
 =?utf-8?B?WVNxK29IRi9wT2h2MUcxcm5EK2pkVE9HZFd1Kzc1NE1iSFlIMWV4T3R5NTB2?=
 =?utf-8?B?UHRHNnRWVktob3o3WEpvYWg2aUllTHNIYUMwRktSZEUxZWZTU3UwZXVDN1pN?=
 =?utf-8?B?TGFhZzJxZldKa1BSVGcybkZIV042cUNGSmZibkQ2aGo3ZHVST1MrQ01VK0Fj?=
 =?utf-8?B?ZFJWVTJ0ejh5M0trcVZLUndLejgrVUNLMXNZWHM5M25NZ240Nm84OHgrS2da?=
 =?utf-8?B?T3hQazdXc1ZWL3NNcndNODl3em9iUDh5VVQxd0JaVXlObVNRSVY4QTZINWwx?=
 =?utf-8?B?SElveXlMK1daY0ZIVS9GNXJDcU1DTytNSS9lcjJuaTRaTUx2VithdDBTRVU2?=
 =?utf-8?B?U2hRWDdOVG5EdTNUblBJQVpxZzNSV204SWxPZW1PWUlqenF6WllkTlNjbGZv?=
 =?utf-8?B?TG9EaU5KeWVTZzhtTmdlanRGajdVeWlZckxPUEJzYTRRclkxR0FDWFhmcEVF?=
 =?utf-8?B?S0hhYkNWYjI1cjM3R1hLbThtUzFEN1BRREIvTzdnMVpwUitaa3dwWkNmQnQz?=
 =?utf-8?B?ZVdlT1lialdkemM5ZVNvUzkvWDJXTGthZ0ZmWDFJUEt2UjFQTEVzZVlxT2ZX?=
 =?utf-8?B?RGNBU2NnM3VXeWNpYlBnNWxiVUl3cnhESk10MVI2dC9PNzF6WTF2WW5Za2Ra?=
 =?utf-8?B?WGFGQ0N4U2ZRb3JYbHJCNlNtZHhLcVcvZDg2Z280WXZUQytQckhvQXFIZFo1?=
 =?utf-8?B?NTVLUUs3Z0w3d293bEh4UlBtTzhZRG1GbEZaeHNQN1hTSlpiQkM0SGswa1Zp?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 836a3a62-6007-4059-3f27-08dc91d2f211
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:17:17.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlVKelclriLzWwZ54qpL5ETb/sTR9ACIJqBSWJJWZ5BmpcpU9kJT4+JPdwiNycWBVgKZYEH8anxYq6mhm8OHYX6iatFInFkAPdU1MbJtbW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7832
X-OriginatorOrg: intel.com

From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 20 Jun 2024 15:19:13 -0700

> Allow XDP program to set XDP_FLAGS_GRO_DISABLED flag in xdp_buff and
> xdp_frame, and disable GRO when building an sk_buff if this flag is set.
> 
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  include/net/xdp.h | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index e6770dd40c91..cc3bce8817b0 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -75,6 +75,7 @@ enum xdp_buff_flags {
>  	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
>  						   * pressure
>  						   */
> +	XDP_FLAGS_GRO_DISABLED          = BIT(2), /* GRO disabled */

There should be tabs, not spaces.

>  };
>  
>  struct xdp_buff {
> @@ -113,12 +114,35 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
>  	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
>  }
>  
> +static __always_inline void xdp_buff_disable_gro(struct xdp_buff *xdp)
> +{
> +	xdp->flags |= XDP_FLAGS_GRO_DISABLED;
> +}
> +
> +static __always_inline bool xdp_buff_gro_disabled(struct xdp_buff *xdp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_GRO_DISABLED);
> +}
> +
> +static __always_inline void
> +xdp_buff_fixup_skb_offloading(struct xdp_buff *xdp, struct sk_buff *skb)
> +{
> +	if (xdp_buff_gro_disabled(xdp))
> +		skb_disable_gro(skb);
> +}

I don't think this should be named "fixup". "propagate", "update",
"promote", ...?

Maybe `if` is not needed here?

	skb->gro_disabled = xdp_buff_gro_disabled(xdp)

?

> +
> +static __always_inline void
> +xdp_init_buff_minimal(struct xdp_buff *xdp)
> +{
> +	xdp->flags = 0;
> +}

"xdp_buff_clear_flags"?

> +
>  static __always_inline void
>  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
>  {
>  	xdp->frame_sz = frame_sz;
>  	xdp->rxq = rxq;
> -	xdp->flags = 0;
> +	xdp_init_buff_minimal(xdp);
>  }
>  
>  static __always_inline void
> @@ -187,6 +211,18 @@ static __always_inline bool xdp_frame_is_frag_pfmemalloc(struct xdp_frame *frame
>  	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
>  }
>  
> +static __always_inline bool xdp_frame_gro_disabled(struct xdp_frame *frame)
> +{
> +	return !!(frame->flags & XDP_FLAGS_GRO_DISABLED);
> +}
> +
> +static __always_inline void
> +xdp_frame_fixup_skb_offloading(struct xdp_frame *frame, struct sk_buff *skb)
> +{
> +	if (xdp_frame_gro_disabled(frame))
> +		skb_disable_gro(skb);
> +}

(same)

> +
>  #define XDP_BULK_QUEUE_SIZE	16
>  struct xdp_frame_bulk {
>  	int count;

Thanks,
Olek


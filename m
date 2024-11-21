Return-Path: <bpf+bounces-45398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311689D5244
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B871F226FC
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30011C878E;
	Thu, 21 Nov 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cdf5TKYe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A21C7281;
	Thu, 21 Nov 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212217; cv=fail; b=M/NLzwMLjZhUetiQGQtuY2qKWTTN4pvSFIZYSQRnA38JEetES8o8cptqtg+Wgtzb0Wl4ZYUNURChMeKiOnUVo9/cMVITvy8OwQ83MVNc9V8qAPdrBMtXmH3fVOw+o8Eau0PMNEnNUZmowWpCoVoPbrWoxjrC3Z3U2RaDNlwOXls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212217; c=relaxed/simple;
	bh=FFhruS9lTNkjc/lKFO+yPIbfEvmf4a+TJ3UubtH1fqY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kg1eMrhqFoph1Gd+vmYqYWvulScbtIlVBZkTF0XHBGrbNTTZIcNIZ1WYg9xz97YVY5mKlp9AQbMxIElG24i/cVeIGQP1aJCUk+PDxlHWTtHToZ9dkuAexM4576HyCL7xGFSOrY63yQcdGFOxDQLcOrKYtCJ8rf7SJUVZyvIzU3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cdf5TKYe; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732212215; x=1763748215;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FFhruS9lTNkjc/lKFO+yPIbfEvmf4a+TJ3UubtH1fqY=;
  b=Cdf5TKYeQz2nFf3qKPeodwsCVNBV3ryExdqOYAqX0rSI4TOPRYJmCnqv
   UTnXlgzIzqlbTq5tHBVjBZ6jBuKerYlE5SDjfgiXWVwdg7agCYuzhWyqS
   8anPJEe2+/Ho6wCuiHikvG2OfJLywa8iyq/zhZLE/OolEFB4Cx2vf0YSf
   oI+Kw4mC2yfNke6un00U3g35ScF8q3SP7ER8WjlPdbL+bDi0HoqU2Spc2
   uhi9R0sSnqnDuHos5Pg+/c6wUsSnKsY5S+y2sQW78VHbgigRGranCuOw8
   YhFSnd6uh6WkfMtSoRpDNmIN2r+frJxFpdQ0Z93YexROsWIX+KnLf1et8
   g==;
X-CSE-ConnectionGUID: kyquuV57RfGt2zKCFsqpJw==
X-CSE-MsgGUID: 8uE/esPbT4aw9TZVx+WKKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32092219"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32092219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 10:03:34 -0800
X-CSE-ConnectionGUID: fVxA1I0VQou+YNbQbfqrtw==
X-CSE-MsgGUID: EvGCMYGARFexUq23qbjsTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90747122"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 10:03:33 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 10:03:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 10:03:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 10:02:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGIwFE5mDpcc8/u4iip3y6bhSFG9gnM3hsQihYX3bwZs+fuQ6RYJnZKY6aRIhdvo+Ia5GFC/LM4VzobrrAgd/I/3a8i6RfZJnsRyf22yChZB87iQZluafj1wY92AI9VAoRBJWjsI39lj2Wu8lNoKciZn3tGUHweBDM6zxIgV0G3brUwXOaTZqnTpBsCahCo31L+1X12BBcGBf3jyAMYECwKBEm8u7iiwJ2HN6/C8dR1DPpBK4Aljw6f+ks96QTexUh0VMo6ytTbrvTvxiaKqH5zyH0BKfPGQUprc1/O6YuCopoGvPpmCngrEjMzcJ3/J59Dde+PeeDwBS8GRq3M1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICzeuJ4DkER76F1K5jEXkdcN2JodwF/OVfMdUJeajPk=;
 b=FtIjma5Jh8leh6Bx9VAwtCL/CrkeNhuKb4Kn3Km86p/153QzuEme9XGnhSdQHKOLTTEEjViPwT/0JPqpaMdXedJ72EV1x98/aYktasQxqrHcZu5wXY90tKsonEGmRJAdHFljUWt2xyfQx24FXlg0QsJU3VyMCvyYvutPpI+UGqn4/za6PnMFR2Y7VkQeB/hIKMHRrQo49sVxTQUgj8SHqr3WhN/AbxDuEesr8Zv6HhlPlEN/0fEExumkYrHWaCQpMGgZtUm6df1B3Xwz+XXtm0CzSudnj8dDBfuRt5F+1dcx2R5or7ye8UuvMRCKjydtOFLTwW75v0v990CWPe/a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 18:02:43 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8158.021; Thu, 21 Nov 2024
 18:02:42 +0000
Message-ID: <55628623-220c-4512-acdc-0b3bd38685e1@intel.com>
Date: Thu, 21 Nov 2024 19:02:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
 <6738babc4165e_747ce29446@willemb.c.googlers.com.notmuch>
 <52650a34-f9f9-4769-8d16-01f549954ddf@intel.com>
 <673cab54db1c1_2a097e2948c@willemb.c.googlers.com.notmuch>
 <6af7f16f-2ce4-4584-a7dc-47116158d47a@intel.com>
 <673f55109d49_bb6d229431@willemb.c.googlers.com.notmuch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <673f55109d49_bb6d229431@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bb0eb8-4872-43bd-8566-08dd0a56b1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3FhMHNzZGR6Uit2elJVdkJ0MFRBdjZVTVR6aVd0UnZ3ckZ4ck13NWtneVRh?=
 =?utf-8?B?YTVBL2ZseGpsMkpvdTRGM2NsOG9qMlRHY3F0ald4MGtaUithR0c5ZXJJa042?=
 =?utf-8?B?eXRTQ0NTSXdhVERYanAwMWh6cHEyZTNGS0FFeVNqeHRnbHAvK2N2Y1pVOGhM?=
 =?utf-8?B?T2dHUWxRZ0NGZGFqTEVzTTdPNXJSU1o1SUp4M09VWjJjL01zRm8zanNaT3gz?=
 =?utf-8?B?UkJnRjdvVzF4WUJpZHV5MXROeE5kV2pJNkxDend5R3ZxVDZXQWwvMU1ES1g4?=
 =?utf-8?B?Y0oyTHZNVm9MTEhaa2R0dkgzcTBTT1Y5SmFMdm42Z3ZZdFo2VVZreW84aGh5?=
 =?utf-8?B?OFRKTXRrNlk5ay9DMWE1T3RtVE5GaStkVmQvK2I5V25tUXpqUVFqdWhFQkYz?=
 =?utf-8?B?ZmFLOGUzNW1vVUdybDJ6VkdiNlZOSnpWNUVYbytROURaTndMZ1ZiSHJVZTk1?=
 =?utf-8?B?U0oyalNtUG92b1lzWHdaYUxwY0VJRzgvMm9Oc2tnY2ZCMi9Ob3pQYUdzNHdQ?=
 =?utf-8?B?QzQxRFdQZkR0Wnh3YW9YblpoUzBBaVRJQkhWZXBuUy8rSmFPa0ZsaWJNVjFQ?=
 =?utf-8?B?bVpnR2pjMnBmWllWcnNjQmQrQ2lyWWZIbHNnMjF0NmJUUmpnTkRVZGhnd0k2?=
 =?utf-8?B?cHJUZ3Y3Rmt6cG5yMFlybFMzbkhHZUo1YlBReURVaFN4UVNRaDdjUVZmeXpR?=
 =?utf-8?B?UER1RDJzSTgwUjNyVjh4TWdBUEdZTVcyMFgrY3ZMK1hlT1d1aDV1U2Vab2JT?=
 =?utf-8?B?OFVqbnA2bTJtM1Nkcm8zVVRFRStOUUkvZXBmbTdjWlRJS05Qait2QUZVQ2ht?=
 =?utf-8?B?VjNDYlhxSmIyUUVHcFlWaGRDTmJXSDhRVjdaZlkrVndRd25NMXA5bTFMenU0?=
 =?utf-8?B?YkhWdmRHWjc2YVd4dWN1RUQ1UWFFVDVQc1FNZENoYWFqdFJDU3ZGSktBdkwz?=
 =?utf-8?B?b3FiUHZyMm1wQ3FueHlCTVlJekFsTjByRnJIa2pUTnRPSWxETFp3KzZXdGc2?=
 =?utf-8?B?V0hzcmFUaUZWdlVPODNMVFYxZy94QlJtdFpsQk1KNDdBTVJUNlVuQXZoTmVj?=
 =?utf-8?B?bGlyOE9xVktwTUUxTklVdTZUMXpjKzNLeGd2Zkl4SkhrYi9neXYxaFNXa0lN?=
 =?utf-8?B?UHFjbkdsVElFYWE0OWo1a04yWlpQUzBPNldrRElsVE1pQkY3Sm0ydlVQZnlP?=
 =?utf-8?B?emxNN0JLRDN3YTV4TUNJbHdXUUhOU2dyMTRDcDdCWlRzYzE2cmV2bWUxRlQ5?=
 =?utf-8?B?UjJ0R3BtQUZyOEx2MmhqSzl6T2NTZnBMZ3VOcGo1ZU5ITDlXeUlERmhxZXFx?=
 =?utf-8?B?WEFsanUrRXlBanFjdkw5UzU3M3c3dmZHWEh5NkNIRHhrN3Z5bXBYUW15bHF3?=
 =?utf-8?B?VHlreVNIMkx6eXprVWFxdzMzcVNwTzBwZVU3S2ZJWkFDUzZMMHZhSjJ4VElv?=
 =?utf-8?B?RnlGTjhJZG9vbENhdXE4blJ0aFNubkg5VkNiRnd6RUJmdml0TUZzeG5CSWVo?=
 =?utf-8?B?aTk3SEZ4OXlhWGFQVjFKZWFNTjgwS2h4eTBhY28wVmJseElVY29YaWY5MzlK?=
 =?utf-8?B?dWNXVHVHSi9sQVVDc240OVk2cDkzVUpjbmlva0pzVk1lbDI5VGdxVzBMMFRo?=
 =?utf-8?B?MnFmajcwSG1FRThaVHVmK1lvVWdlVTNCeEdHMlBvanoweWd3cTNwVm5WUjNI?=
 =?utf-8?B?WXJMcXJrZEhHZStJTVZPcnQ1czlQcUhzS1BITzViQ1htWHQzamlUVnQ3MFkw?=
 =?utf-8?Q?gRDeBvduRK5yN4Il4L8lt7chXIvwTM+L525wFz9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9IRktZS3o1MnF1RVAvZnJVbUdTWE1aMndlYmZHVUJLVnB2R3dnOHF1ZjZ4?=
 =?utf-8?B?eGp6N2M5SnNqTzBuUk1JZmJFL3Ivem9qcUF1T2RocE11U2g2eExnOG55YnNt?=
 =?utf-8?B?ZGQwbUlGcTI0ZGFzM3hEcHQ1RG1ROGtYTjJGeEtrZzlGalhpODVyb1VxN1R0?=
 =?utf-8?B?RGtJcy9rU2NyMkpYVngxcGtIclo3Q0htcDZBZU9IY3NIZDVTRnhwSGJINVBP?=
 =?utf-8?B?SGlMbVdTV2U0YzluQnhpMUVBZVZhWUdBRFZ4a08ydFN2QXpQTWh2bUw0dHVJ?=
 =?utf-8?B?dWRnNXZvKzROQnVLODRDeUhUQ0dzbHpnbVdDcTRGamdLdGcxekRwWlR2dHhI?=
 =?utf-8?B?TloxbjJ5Yld0MTY1UkZ6YUFGbms2R200V1g2bEhvSTZKNG5zRHkydU5VeXh0?=
 =?utf-8?B?Y3RPeFl2dVVYUk5PeXBPZVNFb2NTS1ZQUTNtbDBMOTNsMzZQY2RROUdPSHFJ?=
 =?utf-8?B?T2FDRnhqUHBWYzFPcWQ0b3NFQzZkTmZ2N2xMUnRSLytMZXV1Qmc5aVNCSEZ6?=
 =?utf-8?B?MEtZbXpudTVJcXdhbldoRG0yTkN3NzBzZ2hDT3hhSzhDdkVOWDBXQThlWEl6?=
 =?utf-8?B?ckhDUnVEZ3lmVFcwL29FSHV2TkhUNnRpMmJMMUYrN2d3Wk0zL2xnM2RsV01v?=
 =?utf-8?B?SkpUcnBTSHNyY0RQekVubjdVK1RrSERxMGtOa3lGdmthMjZzekFscjNtcko3?=
 =?utf-8?B?V1BwS3Z0SGh5Q3JwTjZJN2NHSS90SENYYlJJRE40bjFIREtjd1dBRTFsNDUx?=
 =?utf-8?B?VTh5M1k0WUlLZUNqOHhhTDBLc2IrNkxBcUpDaFZnNlFnTEt2UGpFS1dWSEMy?=
 =?utf-8?B?Z1V3N3BEQjU0aDVwei8yTkpFS1ZDd2JwVTc3OG9jUXoybzJFcmdtVUh0b0lQ?=
 =?utf-8?B?aWptSTgyWU1GeHMxQTJsdVFqeVp5UTJ3cDhpWHA3dWF0Yy82T3g3Rklrblpq?=
 =?utf-8?B?Vlg1RmFoeUhIRDAxaElwQjFBWXpKRkYzVkpMK2UvS2pNY2R0NVIzY2x2OG9x?=
 =?utf-8?B?aUdLRzE5aHhzRi9KVFcyZFdNRlBjcDc5eXVkaVFjcThEN1lndVorUkZZY0Fz?=
 =?utf-8?B?NnRBUGJwNksvQlJXNHZEemdPNll3T2Nvemppc2lYMitISzJvVTh1djNtVGtt?=
 =?utf-8?B?Q1VSNkt0K2pFckMvZUhkY0NtU0xzRGk4M1A0UUo1dm1sRWQ5UHp6MGxZakIr?=
 =?utf-8?B?Ri92YjdPbG0yelQyQUhqa1hQR3ZXT2VFOElMZE9YVk5IeFFNL0JuTGU3QjBS?=
 =?utf-8?B?dU4zTjY0b3pMVkgxOGw3eHN6dWFJd3J5Y0x6eE1xaXhYejAxY2psYTdNRm4x?=
 =?utf-8?B?OW1Yd21BT2xGVGpEalZSWTUzOUpsMnJ5NHFuMysxMklINUVOTUZTQ3ozZC9w?=
 =?utf-8?B?TE5XelNUZC9iNlZkQnplRmJKd1pxRWdhTlREbHpXVnl6SVp2OFFiS3loL25k?=
 =?utf-8?B?QlltOGo0K1NxbHFKeWkwZVgzeXVSSTNwaWh1ekcxbXRjMHBaOFZFWUhjdW1u?=
 =?utf-8?B?Tkc0bE9VbkxWczNqckppUktzcVlTeUdZSnZWNWhuVCtBVjRmajFCM3Z0T1JX?=
 =?utf-8?B?MHJFUytKTk5TQkY3Z0NneWdZSXVnckd6MSt2OGgyMWY0dWM4aDhrbi9SVDlz?=
 =?utf-8?B?NC9oSzViaWxlcVZOVUEreUpmcXNTQXZKZkNQZnErU2RINDV1RVdaS1hqbmk0?=
 =?utf-8?B?L1RLUWViKzFka1RIejdJT3RpNkdJWWt6a0hvMUZRNm0zSXN1S3RkUFZ2V1Y0?=
 =?utf-8?B?WldRWVdOSG41NFBlUEJUMnMwVkQvMHVWVldDMWh2QVVwY1NBbDVHNnVRcHoy?=
 =?utf-8?B?ckdpUzgrKzdPSWJCWDNEOCtGT2Q4UlBybk9Bck1hRVlDZjRsWms2eUh4RzlC?=
 =?utf-8?B?ejBUNjMraWg1MkNhMkJXN3BUQ2FCdE9wRlFVQlUxZEdTWlBFQzk3QkNya1g3?=
 =?utf-8?B?dUtUN3V5SGZsWmppUlVXbUtTYjBwbTZXRjgra2V2MmorR3AzczMzMlVkSGhL?=
 =?utf-8?B?OHJVVzJlbUVMNVFHeGlva2RWMnFMc0VIanhDR1NZM2hDUWRqdzgzU05ncWpM?=
 =?utf-8?B?ZGhvcTRscWRSYlN3YXpURFRqRHdyaUZmdEwraFRUakdrR0ZFelNLZmxpR1l5?=
 =?utf-8?B?RUFCWXdKVU5DUVRzOUk5eG9MbGRSanhPWUp3dXkzRk42L05FZGg3eGJHTTBR?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bb0eb8-4872-43bd-8566-08dd0a56b1ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:02:42.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAjU0Y3ile6/tD3uh/suR5PKp+AQTr8CIaylDng2Wt/cJiyGgXVt9DwoDI4Qwov0oEuEN3lzt8q16Y7M00VFuqCDYxqNTgrBzntpYUWNu38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 21 Nov 2024 10:43:12 -0500

> Alexander Lobakin wrote:
>> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
>> Date: Tue, 19 Nov 2024 10:14:28 -0500
>>
>>> Alexander Lobakin wrote:
>>>> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
>>>> Date: Sat, 16 Nov 2024 10:31:08 -0500
>>
>> [...]
>>
>>>> libeth_xdp depends on every patch from the series. I don't know why you
>>>> believe this might anyhow move faster. Almost the whole series got
>>>> reviewed relatively quickly, except drivers/intel folder which people
>>>> often tend to avoid.
>>>
>>> Smaller focused series might have been merged already.
>>
>> Half of this series merged wouldn't change that the whole set wouldn't
>> fit into one window (which is what you want). Half of this series merged
>> wouldn't allow sending idpf XDP parts.
> 
> I meant that smaller series are easier to facilitate feedback and
> iterate on quickly. So multiple focused series can make the same
> window.

You get reviews on more patches with bigger series. I'm not saying 19 is
fine, but I don't see any way how this series split into two could get
reviewed and accepted in full if the whole series didn't do that.
And please don't say that the delays between different revisions were
too long. I don't remember Mina sending devmem every single day. I
already hit the top negative review:series ratio score this window while
I was reviewing stuff when I had time.
Chapter II also got delayed a bit due to that most of the maintainers
were on vacations and I was helping with the reviews back then as well.
It's not only about code when it comes to upstream, it's not just you
and me being here.

[...]

>> I clearly remember Kuba's position that he wants good quality of
>> networking core and driver code. I'm pretty sure every netdev maintainer
>> has the same position. Again, feel free to argue with them, saying they
>> must take whatever trash is sent to LKML because customer X wants it
>> backported to his custom kernel Y ASAP.
> 
> Not asking for massive changes, just suggesting a different patch
> order. That does not affect code quality.
> 
> The core feature set does not depend on loop unrolling, constification,

I need to remind once again that you have mail from me somewhere
describing every patch in detail and why it's needed?
When we agreed with Kuba to drop stats off the Chapter II, it took me a
while to resolve all the dependencies, but you keep saying that wasting
time on downgrading code is better and faster than upstreaming what was
already done and works good.

> removal of xdp_frame::mem.id, etcetera. These can probably be reviewed

You see already that I even receive additional requests (Amit).
Sometimes generic (and not only) changes cause chain reaction and you
can't say to people "let me handle this later", because there's once
again no "later" here.
idpf still has 3 big lists of todos/followups to be done since it was
upstreamed and I haven't seen any activity here (not my team
responsibility), so I don't believe in "laters".

> and merged more quickly independent from this driver change, even.
> 
> Within IDPF, same for for per queue(set) link up/down and chunked
> virtchannel messages. A deeper analysis can probably carve out
> other changes not critical to landing XDP/XSK (sw marker removal).

You also said once that XDP Rx Hints can be implemented in 3 lines,
while it took couple hundred and several revisions for Larysa to
implement it in ice.

Just BTW, even if Chapter 3 + 4 + 5 is taken literally today, XDP
doesn't work on C0 board revisions at all because the FW is broken and I
also doesn't have any activity in fixing this for half a year already.

> 
>>>
>>>>> some of the changes in 1..18, that makes it more robust from that PoV.
>>>>
>>>> No it can't, I thought people first read the code and only then comment,
>>>> otherwise it's just wasting time.

Thanks,
Olek


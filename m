Return-Path: <bpf+bounces-43892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE0C9BB81B
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 15:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC4128490C
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD71B5EBC;
	Mon,  4 Nov 2024 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUx8JPfH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF36139CFA;
	Mon,  4 Nov 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731260; cv=fail; b=u1x81BGmKi1ptvRtE88CWpqeFh45OdGivNSzIHe8Z27CfNh80BMMvvdfOGTrq3B+gDChQvgtxl/zT1WsD2/zwi/wdKChGQqBdFkyj2xeVOmjHeovtr/iryqLVpIIJRK/mUbH8ssL4dK1XqipR4yr1vqDkZXWaNYI5L9RGEyEpP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731260; c=relaxed/simple;
	bh=RhHvMudx0jm0fnHOPQzUCvoIU0Q6lJF2z3OZ/cZpDfw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kclAvNltAf1tRLGMnYxNN2MJtNJ1Zm8xy65p5UO/HTLmUxddcA8BB5ao8mNr4Lh3wCTCj8wAtPA6VFZQeRLpWs8lIy59vfIRfhQAnaipGFW/bwU/3xtz9E5Lf2IpLvvcBW/Kdo5nA4EKVqBaen2zV4XXhEWH0kPywgwuARMQTh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUx8JPfH; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730731259; x=1762267259;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RhHvMudx0jm0fnHOPQzUCvoIU0Q6lJF2z3OZ/cZpDfw=;
  b=cUx8JPfHBN78S187ORY6YxlSMMc/+Jez5OQWuUHDTf70akhBJLoSdmFV
   Nq/58sSpJg42+QCocOrxas1sewHR1LANPvok+U4ED+jxq/qLCOmnRWSUx
   yfL0k29BttnQ++CNsEIf1ASZKuLnn81VwIm8+PqNq2jGVCWAo4uvmEiwM
   ffLFy8kEoSwmFgRTp9ooIEywWpil9rZf0y6BmDyXo4JeJuKxnEeNZwI6J
   /4gI8xPDEymYs9nX/vRwgqJNnpM2pIRxl0Q0p0pOMcdJDsrbhtZys9hLa
   GV87ljbR5mk+ceEzZLd1Y/1O0jS5rrM+39QknxloOjXYNXZi5xpgGqnuP
   g==;
X-CSE-ConnectionGUID: NZA51GIWRVuqWomFqVeBTw==
X-CSE-MsgGUID: ky4WOixHQQ6IemOzvB5JyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41534948"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41534948"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:40:58 -0800
X-CSE-ConnectionGUID: SZ5rRJ+fTP6SZPnkfll5Xw==
X-CSE-MsgGUID: gJmtaCHZTKevHx/MjGvAXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="114470472"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 06:40:57 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 06:40:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 06:40:56 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 06:40:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvoTQ2AliOuFSMxQgS4eBpxKq7Y15IkLkvSaVfB6pERPWM2ncOlVowpQxAzcQAHRLpH0HVKQlt2x4Wq1vWUZ5qlELkYIi6UElyF056eAawECHzLwY8NMnP6aFYGuGVJi0niYggPrz4b0Stsxe6IVC/6tY8ZaLQaWgL/EsRuciOYhPwl7oZaeBmZ4SgpU2vMh2gWmXuTGqJMSnycFJCPoTJD7cH4s0nl0i/CoF5yKGU+mM8sY+S+Vz0NbDIZrn6x32Srf9G4zmutOSrnATZQB+9KiSkRJ6QroXqVHMMZAsx160fFY07csrFh4xAHsdJQSAa8OF5yXUGamZ1djin+2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjOSaQfPsB/vnWh4ap5vtxtdpCKjX9e4TeiAjfWSAS0=;
 b=J3HcmuWTuTVkgLcdjnvhDQS1gTHqUFUR+oqtGVxd4WuJIono9rJME1adyWm2aYyv8Q1mqjpuk/UK1ECQ5Muinvimib1O5Ci1YdUIFEDLUqVCYML4RRj7PnFOMwywHujsz19mjxV68ipDRfO8rE6nNnqFw00lNLWxOFCcCXlg+wrqjkaZsiIErEC0B45/qab1Vv6oIHuYli7kQOKUUsqNnXsHE7dK1TFRi7NigMPQ2RBJsbPOmCLYeJOv65daNaPYgZMnHhHUdaeSarGlBcdwXMhlUdevAC5FmbTKxTVnNoJH9dKTQWof8N3FtxLfKrB3HmIA37r06oORrcbVae6IQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 14:40:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 14:40:54 +0000
Message-ID: <02e50ac3-a1cc-4c29-aafb-e36f28b51eaa@intel.com>
Date: Mon, 4 Nov 2024 15:39:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/18] xdp: add generic
 xdp_build_skb_from_buff()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-13-aleksander.lobakin@intel.com>
 <87frob9joz.fsf@toke.dk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <87frob9joz.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0063.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cdc503-e170-4404-15a3-08dcfcdeafb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N25qaHhsRmExOWJQakNtM1hLa3hMTG1DNTl0L1FXbW5ING1qWmNLY0pWVlls?=
 =?utf-8?B?ZzVBQ3ZHa0RkY3Vic2g1SE5Bb2J6TE0zVmEzdGpNVVViTWRJa2k4cW9WSDB1?=
 =?utf-8?B?aXh0Vk9iZHlLSkdSN0hBZjBTMkhuTXhwd0JyT0JPWTUzK2UyMitieVNzYjBN?=
 =?utf-8?B?cGdKRDhEYkRyUkZmN0hQb2tZL1VYUXd3M096cXJkS0hBNThSOERKT3JlTjBk?=
 =?utf-8?B?eE9CdjFOcnBQYUFDL01FNEZhdk84am53RW5XbVdCc2FwQjlrSFBvVTR4ekVF?=
 =?utf-8?B?bG5mTjVsVVZraXo2RHpNZkFpMkxSeGo3TjNrakNNT3VDcFVoKytGbnprUGZJ?=
 =?utf-8?B?SVlSaytCSHgxNWRtd1daNXlndytmdzhNSG1ZRXlEcWVVMmJ4bXJCL2pxNGFY?=
 =?utf-8?B?ekd0VTloa2I3VTRPdWoyamt2UzgvNGo0RGlTa2J4UW95dXZTQ2k1dStBL1hv?=
 =?utf-8?B?NVNrZnBmQW1PY1hiTVdtamlLN1dtT0cvS09NRWtHaVMvVDFOTS9VVzZsVkVp?=
 =?utf-8?B?bUlIS054Yk9jQm1xRE92TkNYNk9tRGJmUTZvbWJZYlhjYmxwREJHcEF4d2pH?=
 =?utf-8?B?YTl3cTVBZDI1NmFRY0dwUjZSeklKMS9qR01MVGdyY254MnlIRGRSQ2N5RjdY?=
 =?utf-8?B?WHZCWGVpWEZ1a2JIcGpmR2phWElzUGdmdVlXVFFDSVNFcWRyQ3ltd0xSckdl?=
 =?utf-8?B?cktpbVVKYnFHSmJ5QStUbkUraG5LaFRML0RRQjlFQlg3cmxkYVVsd0taMEVJ?=
 =?utf-8?B?azFOWXIzbHM4WUtEd2pNYitXQUVNckIyNkRac2ZsVFVwODhucEgxaVNFRlN1?=
 =?utf-8?B?dUFaSm0xQ3R5WmdkWDdUNlozM3o5azN5UENkdHdjcWsvOHJiREpHa01oTC9H?=
 =?utf-8?B?RG9PSWNvRCtubnlTam14ZlIyK1JKTHVFSC8vRHdYY0NTNGFuUHc5b3d3K29T?=
 =?utf-8?B?TUdibUlZU09CTkMyQjMxQnFyQlpCYTJxQks1cm9NbFo4Q1FHdFAybW9PUXZ1?=
 =?utf-8?B?L0RXbjlOVFpJam90ak5MN2orcUlPQ1ViSWU3MHhnTll5dzlQVk5LNHFHMEM1?=
 =?utf-8?B?VWRkOGhBdkwvdjVyRTVjYzhDVGhXRG1jYTFlV0JnQjlUTkM3STBtMFUyRjRt?=
 =?utf-8?B?V3NSamd0SUR4eVl1MnQrUkM1MGpNU1A2VHZ5bmlhV0Zpak9SWDJXREdjejlJ?=
 =?utf-8?B?VDdxK1VjcHN6MFJLRFBiQUZHNFlBQTJXK3FYZ2wxWThoOFBZYmpPOGs2empI?=
 =?utf-8?B?VmNzOHdUT1R2eHZ6S0ZqU3BHQm1lSlRQYzVLQThpMEV5YXBQMHFzVnczanZu?=
 =?utf-8?B?YWl0Z09ORGlpVmtXb0xBM2NJSXowNWU0R1UraTB6Nlk1MlVERFZlSWtvdWZx?=
 =?utf-8?B?b1ZYZ2VBWGVieCt2YVFlQTYxMlRibXUvZDVLZ1hWWWNIYXdXQXdjd01KOVBR?=
 =?utf-8?B?d2p4RDVSZFp1ZFNjcUp2MzVCZ0pTQnAvUEVOeUhzSkFkUjY0d09PSTBjRmRl?=
 =?utf-8?B?M0JxZlBjay9aRHloU0dwVEl3V3NkM2swbmVwTW1tWUpKMEdIN2NsTXlYc004?=
 =?utf-8?B?eFFKbERZcHlZNnY0S244S3RQMzlVRHNpQ3MvV0ZSS1N1U0lXeElXVW1qMTlR?=
 =?utf-8?B?bDZLc0tVdkkrUXJvZUc3L0V6R0JFT0hveGRmRnI1MzFqV2hvWWhDQU9YakdD?=
 =?utf-8?B?R0QxQ2JTUjdza0N4amZPdHM3cW94ZFpjV3M5ZmVYSCtDSzBoMWE3UllvT1dm?=
 =?utf-8?Q?od5abNbX/fvbr2OPJ1DYh3TOP+P3vjhRRwvrEOz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhwNDFXMFkwck9wUGpjNHZVeUcrZ0k4TnAvZlZmU2liSkhWUDBpUVNkTnNh?=
 =?utf-8?B?a2FGOEQ0elFER0lLRmErYmJjSmR5UThhSUpQVmhwZjgrM0EwYXlqNDB6QU5J?=
 =?utf-8?B?bnk5NmFRSlJvZEZod05sNmp3d3U5c2VMbkZ5WWVGUmRncThQdVZ3Rzl4WDVw?=
 =?utf-8?B?N1RtUGl3REhvd3dqQ3NzUkNWWXhsUUZjNjZyU2VFd0orVm9aUU5RNVUvOXdG?=
 =?utf-8?B?MFB1eWMzVnpHVVUwMGFuVmQyMjA2cWttL2Z4RnlHczdYMWliN2hVSlhrTVNq?=
 =?utf-8?B?dlZOcUlCVU8xQkxucTBpQ2xWM0UxMGExT09jWkJXUjlFRjhBd3o4bTJ2NTBv?=
 =?utf-8?B?MGR5enFJNGRIZld0bmVXYlFIa1dHYzJzaGNINUdiZUkrc3QvYkplVmhmRUth?=
 =?utf-8?B?dG40Z3hwd1lYSkRwTlpGaitSZlJtc1RYU1ZLQkhrMXo0T290Z2RZeUh0TnVK?=
 =?utf-8?B?U0NmS1NFWHFCSjJZYnkwYkhiVWw1TWE4TXppK3ZBbkdCRzlFSXg3ZU5GOUxy?=
 =?utf-8?B?Tk1QeU5lM25BNFpnSld3c1NsaVZ2U3NYWU44VjI4aFFxT0VQQU1OOUQwMzc4?=
 =?utf-8?B?dU9mWDljWEdtY3VzSFRmNmdQVnNBc21YMXZXeXdnbGZjNDRmaW5rRVcyVHR5?=
 =?utf-8?B?QUJZODBRWW5UVTBtMGdLVDV4WUlkS3NWdHF4RnZtQnBrakxvaDQ5OS9QMmNy?=
 =?utf-8?B?U0tHeElsM1d0bUFlc1dwRWRjV1dkM2dWd2VKUlRIanl1V1Jkd3cvMnlkT3Bz?=
 =?utf-8?B?eVVtQWllNWFKYjN6ZDdSZnBTVFdIbkNrU250NlhscGUySmVOTngvRmZoa2Zh?=
 =?utf-8?B?WHJucDFaM0lISXlBb0dubnJYcDZFd21EL1VYNm15WkhtR1FraWJ0Vzdha1Mx?=
 =?utf-8?B?WDRIbDYvQVNoKzAwMExEWmdhUWxBSEhQdWswczM0Vm9zbmcwUEN2ZWh5UVZE?=
 =?utf-8?B?bi9nM1pZZHpNcEk1MWJyWEhzWWpOak4zanUwZkJ6eU5JUVVJa3c4MmV2cGYr?=
 =?utf-8?B?ZlBLT0hrZ080bnNWeXVDYkF1ZUhuVWhYMmdFMWp4bVB0b3pUNFJGdTJxcmx4?=
 =?utf-8?B?QjhkOEhYc1NwVTIwU3JBR0FGK3VGcGdVcGppSmphL0RCb0w4c05TTmsxM1dp?=
 =?utf-8?B?SDFrQWp3YjlsdERwRHJDeEZqdDVjWjNUT2xmRTJGU1FmZ2oyditzZERvOEU0?=
 =?utf-8?B?QjRZVlhTQzBic0dlYzJPSVIveWg3dE9uQWhVV2pRczNzRHhKVGRRUnFleXlD?=
 =?utf-8?B?Qmh2ZG5zcG9rYklpSnlYV0RHWlNVMVpueFF4WkdjdWNLc2FnZHpYVXBsU095?=
 =?utf-8?B?TjZjSFhMZWdlbFcxekEyZFcxeTU4aGFYazZIbWJob2J5VU9Bb0Zkc2crR3lj?=
 =?utf-8?B?Z21zSHRiTzdhVDViVWRGQzF2OFNMVmtSYkRMWXV4ejlJaVEyZUZrR0FLbThO?=
 =?utf-8?B?cjI0SElPbDlSbitBMElJVUV0UXNVeXhHUkFKVWFpVjdLV2NhVm4wUEdVOHBa?=
 =?utf-8?B?REdiU2t6RkZFNW51YVBtT0UrbTN1ZURmSGlTbUp3WWxUekNOaGw1ZlhGQU5v?=
 =?utf-8?B?SU4wRXNpRkY1cW5XZEdCbjc0ZzUwdkpuQ096dWNwcU5mSll0ellJcGdEN2s5?=
 =?utf-8?B?c2ZWd3BqaVNWSDFTOG04eVJiS3htZFBjOTJmK0l6NSt3cjJrcU1MYXEyNU5s?=
 =?utf-8?B?b3lHZ2NuemFUQmcxeCt6MzdoZEpxZEdNTnhreVRGWlQ5bTBVeWszTkN2c2VD?=
 =?utf-8?B?ZkNUeTJCTVdQa3F5Z3dWcXZCYkl1ZHlFdTFBMXFwbkNJS3c1ODM3QXNqVTNs?=
 =?utf-8?B?OEJPb0Q1Mk93QlVWZG1sdTFudlR6blpPM0JDZlY1MzM5S2lMWjlNMU9EVVMv?=
 =?utf-8?B?WVpiRWRrNjEremlGV1lGVHJVZEhhbjRGRVpWSnk4S2lFYnUwU053RUpmZ0th?=
 =?utf-8?B?dGhwcEVNVloxNUNXL1B3OENWRGVTRmpzaDA4ZmMzQndnOVlkd1VuTllFUkNN?=
 =?utf-8?B?ZGpnTXFKWllYdmE1TmUvL056VTZrcXQ4UHhLeU5vdTNTeWxNNDNiRHkzOUtT?=
 =?utf-8?B?dHIyOGtmWFpWRittMWNRN2NNMWNYZ2lJaStQTi81dk5ZTldva1RMU3JVZ3Bo?=
 =?utf-8?B?UnpJS2lMWk0wYTRySEZDaEp0aFg0YkgzN2lUb011WHpZVWt6RUt0ZlFwL3Fq?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cdc503-e170-4404-15a3-08dcfcdeafb2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:40:54.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liAmoUNSSJ+r+da5mjUeKCKsi4hjiVXpf/tKNwIKA+q9QnOKY4BEouKnIGasFPUSdQXd1CsgGvOzxw/9te1f6G++UMD6GtWoGmT+m/7Kk6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8050
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Fri, 01 Nov 2024 14:18:04 +0100

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> The code which builds an skb from an &xdp_buff keeps multiplying itself
>> around the drivers with almost no changes. Let's try to stop that by
>> adding a generic function.
>> There's __xdp_build_skb_from_frame() already, so just convert it to take
>> &xdp_buff instead, while making the original one a wrapper.
> 
> This does not seem to be what the patch actually does? :)

Good catch. Initially, I wanted the common function to take &xdp_buff,
so that frame -> skb conversion would convert frame to a buff and then
call it.
But there were some functional differences and also +56 bytes on the
stack, so I ended up just introducing a standalone function w/o changing
any existing ones.

> 
> -Toke

Thanks,
Olek


Return-Path: <bpf+bounces-42643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A49A6BC0
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45291281AC4
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DD01F8F1E;
	Mon, 21 Oct 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7VBFi6X"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC211F8933;
	Mon, 21 Oct 2024 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519877; cv=fail; b=q6hjPyulgPsGHuBxbQrFEnf/0t2DSonhnEdKK6yJ4ZFQhaIb2H+o8BpJWNhfHqPBJc6v/vWLBD3ohsRgf3TSuCIYQQqzjt+SDYgCA+uBDrDYrCpajgzXBukQ7PecMd3nJ1ZvsG8D5+IkAAIijc6ya/8kbXst1Iw/MeGC7VMzOhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519877; c=relaxed/simple;
	bh=OihHwAoVkx0eKkY9YWbxFomPS345qCyOEPmsfcZhOos=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sy/saf9eo3StGymAmxy28YDTVtH5mQ3lk/Ws3hrPWXdu6NuHaFwLbEKE6i18B0KUasBT+pgDAK2lMdd0K4Mo0+mvI3YHVuZKD7AgFlHFgiMeBANrPUZQMVe2BaaiGASYepYLt3yE1v4d4wAfh9d8vMt0TDZlrG8zNWGqaNhcxfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7VBFi6X; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729519875; x=1761055875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OihHwAoVkx0eKkY9YWbxFomPS345qCyOEPmsfcZhOos=;
  b=C7VBFi6XHVAPy/YVM1js/mQXR3EStqhUormLbAYw0zecpMpXJwQ5maBC
   VHlJ1O/mSo4XjLSJeHsqu//EyyIPtESa6ANyhejOcW6kkMx6j5QnXIOBW
   eLwhQg+z6XyKL8oGMbhCwbHIv13rJpOd7FwFEfgWCWRuJtOHXiUOyfbrp
   2mZsdGYNrUqPTuVCcBmocN5zaSGraOWABLHIIHCSj48BqMJ5qg4/txYOz
   fxLYjfY0gddY5KtcVVIbAHCCPHnMEBBInZFBDLu2e+yNOdrTE3vDoZ3Gr
   3liAFwQpMBBS8041q5WJtZSoRsvHHMbC3yRmB/8ZFAYf0CZijNo71V3hM
   A==;
X-CSE-ConnectionGUID: xQePXcaCRyq3HjN/2KdQTg==
X-CSE-MsgGUID: rmsoyX1tSF+cauIY/P7r1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51553276"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51553276"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:11:14 -0700
X-CSE-ConnectionGUID: nhb60wuUT/ufnL2u4VvuPQ==
X-CSE-MsgGUID: MERLUzkoRfyS0O4JNtigEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="102852628"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 07:11:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 07:11:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 07:11:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 07:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVi8IaZH7KyFILm4q/C23hkt7skYz+H2//hKFjr/q2dTCL7FV8ytbT8VEoCDaEXW7CLFIe/BN8IuW6/9yUZkjxbP7mc6B8C2m6V+FXhQBvmKhjhVwoElCTsRHUSyB+KhvMIdAw/nUiBa9R3ws1piYZmH+Up/Qn9yMjAesfrh+Smb4buC424SxMDy2xXKU31wfJoUyspHk9ZFUOJg8i5JKauym0ZwjoVyj4zzeOIgwOhJYkhMXFmMHfAXrb/+kl37G5s4YKXv7YQPS07y+5I91E4uU/DAZWUsx8xAgw9HYKODK5ZQ/7kfgqSsWOPk+3kMahAR148Wj31FOpT1hgT+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL5UidHF5u6/5ps5Y40hBEHv9qmwoRkhzqilhpV2pPQ=;
 b=n+qMKI2pSSbi2XMTU+/ZaQ8e08Z3M4i/stTM/fGhk4OfiQpDWR5IvrWn+GTsGkWwlYcNmOcAaf47PLVRDaDpOBD4Zyz9AIfj0rPJ/kmmUfS9hkODQRC9xANqbAMYD3xpf9YXOu6a1cvV0AxPnjhI4Y8GtigplTBhnYqB+uuZwqyomf78hHERYWI7JltBZMgvs+GCj37V05W5fFaCUFuQOMfMA7xXvb9yvE1DGtAuFz6UxZwin+DQL5KCfQOQxMqMhGrIBc+9TODg+dnDrnrbkWDkzntIQRBq9w7XLBDnR8hDBbHRCZmgmaEPO2+/trpqq+m8l27XQP1suOgQWKbapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6509.namprd11.prod.outlook.com (2603:10b6:930:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 14:11:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:11:08 +0000
Message-ID: <fe952ad5-b0f3-4547-95c8-1126411c21d7@intel.com>
Date: Mon, 21 Oct 2024 16:10:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/18] xdp: add generic xdp_buff_add_frag()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-12-aleksander.lobakin@intel.com>
 <ZxECiKa4a4LSq7zq@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxECiKa4a4LSq7zq@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: 534ca850-a5b3-4f07-cafa-08dcf1da357f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3Exa0FRcklRa1luMlJzV0dZOXR1elNBRS9PU3p5T1NQU1BtZmplWXJmNjVL?=
 =?utf-8?B?TzRGWHAyVXA3SUx1MUthTzVXZzZraG9Tck0vNmFmbHRPR05XaElUTVczVGJH?=
 =?utf-8?B?RkZzSHhTOFlQT3h0NGVYa3VwdzJZZlVjZWxpcndKTFBvM21pRFZZS04zV1Bn?=
 =?utf-8?B?UkxFVHhFUHpQZXlwc1AyTW1RK014bkNwUmlLV0ZMNHYwVzhhQWNIZGVpZVYx?=
 =?utf-8?B?YU1CM1d6UnJOVU1JMzJTUzF0ckw5L1Z5TzNsd2trTk54Z25QcEgwQUdXVGlZ?=
 =?utf-8?B?ZFoybjlzQ1lZazhHSEVHVlBjSVUrZ1I5aFc5dTQ4d0VGRXVZem5ETS9Dd0NK?=
 =?utf-8?B?Z2JNbXlTOWJXMlhyTWk0UGd4MUIxTmNjZERxVUcrOSswSDlTMWErZ0RQaDZI?=
 =?utf-8?B?clpUTTRYZEg2dnlvRHZxNi9nbWxmd3d0Q1hOT1o1eWRZVkpWbnI0RXFxN3JE?=
 =?utf-8?B?ZjlVNEFUT2YxTWVHQnRIdlhUUUpZalFGbCtaVHVnWHo3RDlvM1ExMEpGUTh4?=
 =?utf-8?B?b05DYU81MnVnZVdPR0puanI3MVUzS0wrdWoxTzY4RnptcGJPNmJZMnZEYVlj?=
 =?utf-8?B?S3hWcGE3NFEveFRoakNRSGg1NEh6aXEveHByZlFPSU5UNlVqQWhHTVNuUFNl?=
 =?utf-8?B?S05LdlJxdEZWY3ZkREt6NG1VVWN0UUlYcmRoZDJwa2p6UzJKMlFKeFFLYVFs?=
 =?utf-8?B?YVdoYjdFZWpqdmFBVDUvaXA2MXhuTmR0dHBKbWtncW1nU25sOGZHUWNhVFRv?=
 =?utf-8?B?dFJBYzhVM20rdWVzS1lpM0ZEUDVWUXJXM3U4cGZERGJ6MjNLU0JzUGxWUWYw?=
 =?utf-8?B?aWxrcFh0eHV0NmV2UWsvMkZrUzdLWDg3VkJnUU9pYTlkV1Nnekc3U3MzTlE5?=
 =?utf-8?B?d1VDRUpWdTc3V01xNHJEaDArcmJiZmRSZ01nbU1GQTRVRDRDckJFZVVXcW12?=
 =?utf-8?B?WmhFV3lEOG03NGFGU3IwODNMeTJkaGdjQ29RWG1TbXdZVGwwSVdyb2ZDdVpL?=
 =?utf-8?B?UGNZcDhGM3UrSXVLbEpVUUgrcDF2L05hQzhaNHh5a0gzZjU5bjNwYXI5WE1h?=
 =?utf-8?B?alpmbTV3R1hyRzVEUkRFWGV3bmd3clNjR28vY1NLWU0wT0JieHU3bHdseWxR?=
 =?utf-8?B?KzkwRDN5MHFFM1BjNFNBL3BkRlVFL25FZytBcU0xZkpNd0FJWnJpelo0NXBC?=
 =?utf-8?B?bm1sNXlmb0ZWSDhNdzFBY2I4cm1DOWc5SCtvZzVESjVmeFhUNTBWTzA5Ky9m?=
 =?utf-8?B?T3JKU1NMeG45VHcySmtqUG83U1Rnb245ZXBTeWpvdGNvMWQxbFljWUsxY2dY?=
 =?utf-8?B?MzBReGI4bkRiMm02Slcyai84clQrSVlYNnphejlPU2E2eUgrM2ZGbXc4d0FE?=
 =?utf-8?B?RTBPRHA1NjVuVmJ2L0VObUp3eFdKQkVER1o2SFFVSmgxZ3Z2VFNuQzczQisw?=
 =?utf-8?B?MTdYaDVyeUFDaVc0NmRaNGJEUEh1amNlQ0ZqV0ZjZXVmYTJKSGdOaHNxTDRp?=
 =?utf-8?B?MmhDWFcrbWRyYlppdE5uZFVtZ1lpK3JBa3YwTkNWc2I5bFptdlIwME8vNXRp?=
 =?utf-8?B?azV0eXBFN0JYVkhmaTVPaENUb2FOSkY1TkkyNkhFRTgwWGtEMEQ4cVBqa0JD?=
 =?utf-8?B?MkUrZU9FWHZhU0ZRVHRHVDBEWUFFQnNLTVdjQ1lYYVFkcG4xQ2hHRFpmZk93?=
 =?utf-8?B?NDE4cnV6dnIyQStWUXNWNmQxKy9HRVRLL21SdW5uZU50QVJaSzJQSi9xYlM4?=
 =?utf-8?Q?gDEAOR6scbmka7Hi9pA1lQqH1btQ4S9QOvTYQ5g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVjc1RuSHZyNzVQenNmWEhSTzBLVzhGVVdyelpRUVBKK1ZIbkZJanNlYkF4?=
 =?utf-8?B?SUt2TllLWWVUQVdtVVZpcUVYa2kyUnloTEMxaWp4bmV5bnhwS0FsRlJCZjY2?=
 =?utf-8?B?ZkR4cWN0aTNrQk5tUURtN3UxUW9yb285dUdXa2dNalpJempNZ1VPcExpRWdH?=
 =?utf-8?B?dE1lQVpJMnNTUmpwcHhlbXk4N1pTL3hxdm1BZ3NmOHlFOWJSUzdLRnNad0NN?=
 =?utf-8?B?MEMxT01OaEdxZEZpbkdHS0tka2h4S09UbzZ5NzM3TU5UWCtWZ1pLQzlKV0pM?=
 =?utf-8?B?Y1pZT1M1dm1lV0g1THlKL291aGhjMGlYV0ZkZnp1dkEyanpEc25EcEl0eEhQ?=
 =?utf-8?B?b010c0tlVkw0U2kwbnY5VTZEZVdyU1R5aHJSQnoybVhvaTNlZnZmYmU2NEpz?=
 =?utf-8?B?bG8yOE50QityWmUxYm9xamt3OFQwQ1RhOTUrcXlpNzE4SGQxOFhEbWtvZXdh?=
 =?utf-8?B?cnRQQXRWSTIyNEQ1MWZvSEpLWHNzWDVXSWdBelN6dlZXSDc3YTlHUS9pa1V1?=
 =?utf-8?B?RE5NVXlKakRpRGw3K2I3cEpCWEZ6ZGhnYzRxSHJYbXpSTUhpQS9IYWx3dmVZ?=
 =?utf-8?B?WFEzb3VORHYwNU9pSEdjVE1aWW02RGpnSXBVdExJKzF5bFlHSzUxcGYrYys0?=
 =?utf-8?B?TFZKV2tRbEhUSW9XQ1VrREZ1NXpVOHpvMVJxQUF6QzNxTFlwK3dld2NRdDhj?=
 =?utf-8?B?Nlh2RWZpUmtqMVBzRzYwbUNJaCtHRmtCVE1yQTFmVjZrL3lEVm1NYnNVWnJI?=
 =?utf-8?B?Vjd0RDB2YUpZWXlIazkvRGZxc0VsWnRKajdnRlVKNCtBRVluMFQ5b2pxYjFv?=
 =?utf-8?B?Q2MrdUE3aTFlM1d3RktyejlqRU9hcFpEWXIrRGZ1WEN3WlBJeUZXWHh2WFRv?=
 =?utf-8?B?VXdLYUZRMCtHVXc0UUhIUVo2UEJJVXN4VnBwTUR1NjU3OVB1V1MvZllWZFJr?=
 =?utf-8?B?WjcxNGhaTEl2QVNpN3ZLZm0xOU56bkJHR2gwalYxdzNBUkloNVlUOWE0Zmc5?=
 =?utf-8?B?eC9RZS9maVY2R2Q4S0plTkMyTlNtTitJNnVlNFFEbkhveWdNcVE1bkYySG5s?=
 =?utf-8?B?ZGh5ZHdMV2V0cEREcFpOYm5zaTZzV0h1RVBzS3Z1MHlFY0IyQTdLdVpmY3A2?=
 =?utf-8?B?TW1sQnQ2WjZGbW9vbGhnUXFwdUJCazRCZE4yRHNLWmFGbmNZNS9rSlZpdTB4?=
 =?utf-8?B?UTMvT0ZTUDVkZG0yL25sSENHQmtFZ1p6aDhaV1V0VlFCSmk3eExualNEc2VI?=
 =?utf-8?B?L0Z4YUtIVFZybkNnRnNDQTFvU1ptK2ZNWXlBaXQrUmRVRmQ2WWp5eUI5eDA1?=
 =?utf-8?B?U1hoaE14RWo1MkpsYUhRT3ZPUUZ6KzgrWkY0T0JWUXZSM2RpYjFoNDVFVHBj?=
 =?utf-8?B?RHFrdnY4TmFOTlZoT2FyZWNUVHZzdnFPc1VPZ3cxZ1puTGxhV2JsUTVqTTlk?=
 =?utf-8?B?V21ib01IQnJDL2tGV2ljM2tXMWZtOXlWdWpoNEN3Wll2ZS9ZTUt2dUhSUE0r?=
 =?utf-8?B?NTJRZlRsZGdnZGVGd254ZG1vdmJmV08yVmJkVURlWnlwV2ttb1cxSHRUeEpD?=
 =?utf-8?B?aU9kVDl0OWxSM1FmQ0kwMWN5UEVkYTRuTXh1WnZTZTk3UGxob0dRblRLcURB?=
 =?utf-8?B?S0FKMEZmOWVRZTdtNlNGV1AzTXNhUTN6c09jbStCcm9QaGoweHJOR0NOQmxG?=
 =?utf-8?B?cWh5L0VLdWttN2RxaG1OOEpZNCsyVVBXRjl0R2VVRlFJc05XRjVsaTZzakJO?=
 =?utf-8?B?Q3hDUGVRMVY0YUFCdDEwS2NvczJYM2RsVjAvUlhaM0NYYUdyd2xVb29wMWpj?=
 =?utf-8?B?d0lEM3Iyd21ibGF5VG9yWW5LOWpyVU9BV1c0QUtyRWdRNExWTkNTMTNwMmVM?=
 =?utf-8?B?ekNBSjhYeXlqUGxLQmViUUR2VEtYaVhESFhGRmVQdVgzRWRzbzEvcFdWTE9l?=
 =?utf-8?B?aWJaOHk5YkxMMEVzaXJaRHA4RXJTK2RSUGZkZHI1TS9FcWJqOGtURjBWMjRz?=
 =?utf-8?B?TWpJSzRaY0RKcExGR1l2ZlVvWHUyVy9FQnhrUUdmdDFCZmJGWVJGaG96dkdq?=
 =?utf-8?B?OUZmVHJmM2l5VkVnRnMyblhRQ21rQnJIOFNNSTZEOVZTV1dOaGtkL0h6Mlhh?=
 =?utf-8?B?bzJTbDVSK29TcitEM2hrSzJiR3BoMVFVdkpzWmZhSSt3ZnBRNzhPUnVneTQ4?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 534ca850-a5b3-4f07-cafa-08dcf1da357f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:11:08.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXigoTW0irSpwFoBv7Es6ONEentOcKQTg14WOSNF9COsqX+MCywfJmsSJJDdHiefeAmXe2ac+MBKlvcH9vPBx69MZYqBr7bbWP70nlDjzIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6509
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Oct 2024 14:26:48 +0200

> On Tue, Oct 15, 2024 at 04:53:43PM +0200, Alexander Lobakin wrote:
>> The code piece which would attach a frag to &xdp_buff is almost
>> identical across the drivers supporting XDP multi-buffer on Rx.
>> Make it a generic elegant onelner.
> 
> oneliner
> 
>> Also, I see lots of drivers calculating frags_truesize as
>> `xdp->frame_sz * nr_frags`. I can't say this is fully correct, since
>> frags might be backed by chunks of different sizes, especially with
>> stuff like the header split. Even page_pool_alloc() can give you two
>> different truesizes on two subsequent requests to allocate the same
>> buffer size. Add a field to &skb_shared_info (unionized as there's no
>> free slot currently on x6_64) to track the "true" truesize. It can be
> 
> x86_64

What a shame from these two typos >_<

> 
>> used later when updating an skb.

[...]

>> +
>> +	prev = &sinfo->frags[nr_frags - 1];
>> +	if (try_coalesce && page == skb_frag_page(prev) &&
>> +	    offset == skb_frag_off(prev) + skb_frag_size(prev))
>> +		skb_frag_size_add(prev, size);
>> +	else
>> +fill:
>> +		__skb_fill_page_desc_noacc(sinfo, nr_frags++, page,
>> +					   offset, size);
>> +
>> +	sinfo->nr_frags = nr_frags;
> 
> is it really necessary to work on local nr_frags instead of directly
> update it from sinfo?

I think you remember the difference when you started to work on ntu and
ntc locally instead of accessing the ring struct all the time? :>

> 
>> +	sinfo->xdp_frags_size += size;
>> +	sinfo->xdp_frags_truesize += truesize;
>> +
>> +	return true;
>> +}

[...]

>> @@ -230,7 +312,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>>  			   unsigned int size, unsigned int truesize,
>>  			   bool pfmemalloc)
>>  {
>> -	skb_shinfo(skb)->nr_frags = nr_frags;
>> +	struct skb_shared_info *sinfo = skb_shinfo(skb);
>> +
>> +	sinfo->nr_frags = nr_frags;
>> +	/* ``destructor_arg`` is unionized with ``xdp_frags_{,true}size``,
>> +	 * reset it after that these fields aren't used anymore.
>> +	 */
>> +	sinfo->destructor_arg = NULL;
> 
> wouldn't clearing size and truesize from union be more obvious?

But here we actually need to reset the destructor arg pointer.
size/truesize are not needed at this point anymore, but the arg can be
used/tested later, so I thought clearing it here is more clear to the
readers?

> OTOH it's one write vs two :)

Sometimes the compiler can optimize two subsequent writes (e.g. to addr
and addr + 4) into one bigger, but I wouldn't rely on it (that's why in
patch #18 I intensively use casts to u64).

> 
>>  
>>  	skb->len += size;
>>  	skb->data_len += size;
>> -- 
>> 2.46.2

Thanks,
Olek


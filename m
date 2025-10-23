Return-Path: <bpf+bounces-71907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE39C01786
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04F0F508747
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CB432E126;
	Thu, 23 Oct 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhPByt1F"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADD315783;
	Thu, 23 Oct 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226338; cv=fail; b=T6dZrq+EB9zK6zShiwN0x/YdJxL/erJ8aR7jLNJ4t+h5+AhKgsvSjhBfLI2+uTVQnXN53EyuNGIgzpRH99ReUcbcNhUZS9o0k3T5+zoNYXzwFiHR24wkMZoHNR9BmVRLQ7icSN4BDDz06Z28iGHbO3i4lwmTcqYwEu3BKmCHIc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226338; c=relaxed/simple;
	bh=l4lzkGdFQvswyTO1Zeem0WDwk3SDT+OHxFUv7qd1s9o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OH0lPbB6Iix+ULna97N5WVUG7L+tIuJDnjBnIF6wicTgWh764euqRjh0EhrhwYhjbY6O7uDf/ZwC6f64iSVdsdq5nFs+1r4gkO7Kcgk8NKnUl4Ay+dxOdpAwagI9HO9RWBTQqmY+RFgiVYsyuXI1H48/xgiI7C8kVgdzC7KBmQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhPByt1F; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761226337; x=1792762337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l4lzkGdFQvswyTO1Zeem0WDwk3SDT+OHxFUv7qd1s9o=;
  b=fhPByt1FV2YXbOAOoEhqMH0Ggkass9gMl64MdgCo5gLAlHDrRmd/b4Ng
   R/Urx2hs0OZ6mxLcAque2X/7LQ0uI0E+38kLjFT9syneDGQ9yrOK3KzJE
   X16Mts9pXoxdOrd4scI8oQ193TxSFGopPJU+u9Z1y6eCkKJszRviHeYz0
   rs6RAA42WreXQ02+bAd/1R5Gqr+S+KNK5+w/4fLC0RvShNzV2IliTCE/+
   tylltT6Z2uxoycwPK8tXH/lQBSUnnF46ixxaqz/1EYyH7960ZYK0xdG22
   tWJiouzS+hDGpHQlF0XEJ1TfcT93B+JFjlOKMLLWeNihxUQm+Q8BcSkUU
   Q==;
X-CSE-ConnectionGUID: zuVDr0GmS9W8CtTQHZht6g==
X-CSE-MsgGUID: 2EbNA+SVTuyGPFwNXkkPwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74832626"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="74832626"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 06:32:15 -0700
X-CSE-ConnectionGUID: W/WA9Fo7TQuzQSOgTDHDTA==
X-CSE-MsgGUID: pmC0OjLdSJixKnZOziPh1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="207811578"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 06:32:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 06:32:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 06:32:14 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 06:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh6RsWsEPNa7cXcENgk3lp+kE0gm90TnyzqAqCXlmnTToimfVFdFMFP1k0qfOatqVrC1PQBGwGpKPu62jV1o9+kph87PiZVBjddlYzt3fB9WgL+XR9wGATIf+KjevYl9G/0W06ON+zwD3nxzLbTKRuWzocqqRr5dU/pug91vO7SS7WFfkP4XfJelvvZDvUeCPudHSLdhGJF72ZBgNIMsmF4AEGZe265lQWUHgwM41Fqw8CUU6XjlmvCf2aeNFkSSPSSxT8mZYYqaog9gbeQsj5WtAZPvfZdWRS7KI1DQ9lVrF8OIY9WCx35DXeSNPbob6Ckq3t60wduoTIpUlp9wYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vC9RTK8mM83QH5W3DtMea3+VRcUs+IQqlnFZ367IDM=;
 b=Ad9orw9jF4Nv5Z9kzcPs70E2lxsiPsZRBYlbZbjNNYmekeBEjBYvbE5Cwhp+46t+15RhcKsuLBXRH8MvpLUQQVFFtmpuDW91aRaFJR6RnB0D44ReQHPX2UNvg0oPPGvQyQkgHe7p1v3sca2aJPgGsk8TYs0GcuHkBJktG00LWriVOP2kMh0jBmi3MD82ibez1v5G5pf8iGYUxPIMHPV+pniACrPpo8+LRp9TvcoZZknri+6PX5DnXEsyrLN3bHufQKA/7gEvFnPhkJLdbiFVykG6i1wrPN1Mkn7Ax9yDYElY9wTlIj0NIfFOo2OI4dK2V8wLCoJZKAlA+1JUE/slZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 13:32:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 13:32:11 +0000
Message-ID: <d3c91a9d-4de4-4091-bec8-c339fcb65fb7@intel.com>
Date: Thu, 23 Oct 2025 15:32:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] xsk: add indirect call for xsk_destruct_skb
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <joe@dama.to>,
	<willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
References: <20251023085843.25619-1-kerneljasonxing@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251023085843.25619-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0248.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fc350b-858b-4675-5be5-08de12389257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blNTcVlQRUxQZlk5YmRIejZ5NlpDQnhMdGFHcjlFdEpTdHJNSVkycGRXaFdB?=
 =?utf-8?B?Y09GSXRxMThoQlBMK3h2MWgzOWZIK0ZaZmtYdmR1Y2J6OHpzL3A1OGFnTGJ1?=
 =?utf-8?B?WGdjWTRiVzdZNEZpWEpFdjZkdW5iQ0VRMWVzUlJWUWZmUmNlemMzdGF0aTdy?=
 =?utf-8?B?ZFFsYWtRUkJBa3ZLcEp1VWNXKy9FOFNaMkllOW5kYks1RG5CYXpBeXR2VGpu?=
 =?utf-8?B?QjVmNzRXWFdybDYvTVZKcy84ckdvMmtSeTRRN25DYmZnVnRIck1vMkRjeGhw?=
 =?utf-8?B?d3YwdW1mV0tRL1hNaTNMUk90NEVPTVEyanZGYkNZSWFqdzhvMXlmaWNZdzBU?=
 =?utf-8?B?c0pzc3lkUlRQVnNtSUpWeXhqd040SjRmT1Jld3I5TUlWMlQ4R0FsQzFMaEF5?=
 =?utf-8?B?VXdPeGVEVU9yd1lIUzJiaWNQQ2hlZlNsTFVlaWt4REd5dVpDLzN2Z2RHRDdM?=
 =?utf-8?B?YkxrdVFCUHQ5NEFCNUUxU2ZIS2dpbXAwRFFQM0g1Q3JaWFd6WXpwTTZVSkZS?=
 =?utf-8?B?SkhlM3Rya1UwRmJ0bnVocTRURjRreUNoeC9mNm1rSHdaNTEvaWl0bTRuc2dw?=
 =?utf-8?B?YnNTQ1BGaUdYcDJmSS80V0tkYStCSldPZ0FTVDA2ZTgyWTJTR1JlaS9tazZF?=
 =?utf-8?B?dGN4cDFRV05tZXgwYWxGU29tVmdtZVRhR0x2OFl6ZjNGcWh3NUFYcmwrRXdP?=
 =?utf-8?B?dE9DQXlLbUZKYXF4eElPdVBuOTMranBjSytGb1R4aTAvRTJFNVVRWS8rMzJZ?=
 =?utf-8?B?ek1uYVhTT3FJU0t0REV2eG5PR0tWUkNsNjk0NzIrSThUNm9UVElTTWlNRHdC?=
 =?utf-8?B?cnNTaHNmd1ozTWxaT1JCdkpPVll5THhuYkt5dkVIMU9SUytRUllnbHlybkM3?=
 =?utf-8?B?ZjNRTGY1amFhZEQwa2pLcUx6MzE2eHZJODB5T3puN25OU0V4Qkozc0htZW1I?=
 =?utf-8?B?am9HZDBzS2NubThPcXM2K3puZWNDalNFRHdGUzRpa2c3dVVvN2VkRjNPQVVl?=
 =?utf-8?B?c2tLOVhjTkM3NEFrNS8rMWFhOXhqSHdaR1FtcnJRcWJvWThxaWRvalY0a2ky?=
 =?utf-8?B?REJJbUpTYlFUaHczU2RXbUxvb2x5bWVTUFhTcHlnUEUrNDRFakhFL1lPSGNx?=
 =?utf-8?B?VUEyT3RBY1lYd204N1dyaHV2eXVLck82M2FQNlpleGlucE1ML01XaHQ4S0I2?=
 =?utf-8?B?QmI5eEw1QW5xRlBmZ04vSkNBZVJzSVZhUXd5UmJSckVuUmFOaE9ITGlhYlE2?=
 =?utf-8?B?Vm9ZaGR5TGJMR2Yzbjg1WVpEbDRoR21CQXFaMXpjVlkza1lFajV2aFFXK1F5?=
 =?utf-8?B?TUhDemVvbFU3cnNxcHBWMHdralQvaVFHNUtvOW1wY0JJbjhFcElzUkVkbGkr?=
 =?utf-8?B?V3hMc1FabDVINlVCUTNWOFZGQlFPZVI5UHhFekpjQmJ6clNMZitwemVHTDJ0?=
 =?utf-8?B?bUhua1dJak0venBGcnYxOHJyWnNIN256RkdHdEt3OCtZeXpNT1lnTHc4TkJ4?=
 =?utf-8?B?amNSMStBOUJxdkw1a2hQZ1B6T29kNEZBSjQ1WmxOVmNHeHNnd0ZIaVY3bWZR?=
 =?utf-8?B?WE5LRFQrVUN0dVpDdFpSZVUwN05aOFl2VExlcWtrcHFSaGhGYnluRUIzWldW?=
 =?utf-8?B?cmZBYnA3WlJSalRoSWQ5T1NrbjRxK200NTFWVTBZWUlRWWlVNjBuL2thOEtF?=
 =?utf-8?B?SHpKVVhhU2VBcG11RTNhYWdpUG9hMXRGR3BoNUdqUjVZeVpYa1loM20yVXVj?=
 =?utf-8?B?MW1LV3Q0dEpnTTJsSjVlV1FkS0lXaHU3YzA0WWNNUmVvd012bGE1Mkpkd3lD?=
 =?utf-8?B?bWszRCtSYjJkVFNQVXRHR2U3TlpBQ25kZFprbTFlbGtCV1F4WiszWUpweW1Y?=
 =?utf-8?B?Y0E2eTZEenNXZnRjMVk1SVhNZjRxZk8zMGpXc3RLWlROR0h3NmpaUlhhMUhp?=
 =?utf-8?B?TzhzWHIwSS83UmlsUnJwYjNHZ3RQbnQ4TW51dHRGaWxRSUcyakRBTEwyK1d1?=
 =?utf-8?B?dVBETUIrOE93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRtQjFXQUVkOS9hWW90MW93Y0NMRkFFVUNGaGZPcGtKekFtSmR1amdWZ1Y2?=
 =?utf-8?B?UG9ZblVjTW41bXdITlYrZmpjMld2WVMyU1ZESEQwS09DTnlNdy9LTHY4L3lE?=
 =?utf-8?B?cnB4OU83cUxCcDJucmVKYnUvOTlQMWZsWHBHMWxnOUFROXhmWmw2ZGw0VzFy?=
 =?utf-8?B?Nmh1eFlQaW4yd0FiYzlzU09Rdi9qTTV6OU1KcENkUUl6UDNjd01CQmE0aTA3?=
 =?utf-8?B?SEttWUFEbmx0NlNlZW5rdmFVK25jQ2psb2pMTFo2czZpRkwvVmh6V3VWMmpN?=
 =?utf-8?B?VlFaZW5Oc2JzS09oa2pnOFRxTHMvdlBVWHNnL0RJb3o0cUtsRElYUkhhUy9T?=
 =?utf-8?B?QWdxMjAwNVFLSWFmY3EyNlNnQWVMaUlFeUlEbEVqOG5ubSswVXQwbms1Szdi?=
 =?utf-8?B?czdYTzhnSVlraVhnUWhnc0x2QjNiRzZXS3d3YmRzZHp2dHkyRS9JVncxSUJV?=
 =?utf-8?B?SlRmMDhkc3N5R3VEYmg5MTE4dU1jWitZOWZWVmJ1UGh4L0tFdnVkaVBYMnkz?=
 =?utf-8?B?M2xYZHJWOUtZQTRRSmJsWGNMbnBzMjBLREJVUlpRdVgyNERFTmg4dkFQcWRP?=
 =?utf-8?B?WDRYNWc0M2FFOEQ0dy9KTjE5N2hUMnlGRS9QbDlSRlRzaFdpQkl4SytxeU82?=
 =?utf-8?B?bTFhWXllUUpNSyt3UkNNcU9idG1zYTFRSmdtekhRb3pRQzZndTdwRlg2b0Zo?=
 =?utf-8?B?b2t1RkJybE8wbDFFeHdYY0RHUWV6bDRFOFl5Y0VHVGd5TkVEK1BqeUhrRGlK?=
 =?utf-8?B?VGdvTVY2T3JacGUxblNtbjBGUkM3L016VFJoZ2hkcTRHd3VYNmxmRHZkcStq?=
 =?utf-8?B?NEJxQ0x0U0NzQldKdnAza3ZMaG1SbkpNVTZyOE1WNE95VHVpcW9VWjZPbkRm?=
 =?utf-8?B?R3lRb2hmL0E1QlFuaDJaYlIwL3l6bDg4TFcyTTZoY1liQ09XZDNSNXR5NG9E?=
 =?utf-8?B?b2NOSHN0RXZxTERFSkJORTlFTVB2eW5rZW9CWVBlY0FkbjRhdzBFV3pQdVQz?=
 =?utf-8?B?ekZtNUNvNytjZGg4dHZmMm1ZQWs5NHpKdm56ZGc4ME5veVlYRWozcjZIMTZi?=
 =?utf-8?B?bWNoSVBHanpoT1d4NUp1aGwwaCtyazRwME1Hc2lvUVgweU1ZS2ZLQk04MHhq?=
 =?utf-8?B?UUZ0MXpxdzBON3d5SFNrZE1LN3RVdXRkdlgvWE1Zc2w3dkt0RWVXZG1RMUtJ?=
 =?utf-8?B?VlBkUm1GQlRzbERiR3NvSDdKL2FOUW5KczBSL1owbXZaWncyOWNIWnRDdXgr?=
 =?utf-8?B?aWxJSzN5K0hyY3hJR3VDcTlOZUxmK1pTVU1vcFRMR3FXTklIYTcraDZTT3FN?=
 =?utf-8?B?enpodWNOK2xwb3lPMXR0NEdjL1A5bVRKR2FiOHdQRVFqUjJ6MDNyZHFBRVdj?=
 =?utf-8?B?enFzUXJUaGpHbGZ4OFlxOTBvTTQvNnYyNjVuUVM5UXVkMzE4UDg2ZFg3V0lD?=
 =?utf-8?B?WElHUTYwRkZha3V3WC82MkNDQWxzanpvVHdZanJISkVFQWJOM3k2eTd2VzBk?=
 =?utf-8?B?MW1KZXBlZlZXVHBOUWRYWWlscXkwbDdPdzFDOG9scE1BeG5aeXV2T3dyMDZJ?=
 =?utf-8?B?YUdHaFNKbWVtUGhQdThBT3hUbnl4TU1Kdk9uaU1NRlkxRFI5RkxYb2N1MDZ5?=
 =?utf-8?B?UCtoZGJ1anhRNmRkU2hNWGZOT3VTeG1HU2V3RTU0WURiUVlnY3BrdmY3K1BB?=
 =?utf-8?B?L3VYUGpFaTRMeHAxbW1aNlpLNnZndTZUZ2k4dDN5Z3IyV1psYTVhS2cyQi9k?=
 =?utf-8?B?OGFPMlNTUlRIK2swdW5NUVdqcTgxREwrWjNTZ0ZtR3M0OXErWWJlNDY1eUpo?=
 =?utf-8?B?Umt4WEV1OFZKakd0N3VPWFZqbzZkdGhSclBvMHZzRjFDeWVSdVVYSXRPNUhM?=
 =?utf-8?B?aDR6bkU2S3ljY3dSSVZZTkdoWU5URWI0K3Q0bUFmMnUxWk1WdlA2Qmp4VTZy?=
 =?utf-8?B?VDhMTUxNTXBvK09remIzTUtZUitRaXRPenVkZkw4SThNcDVyY2VhT2dDQS9G?=
 =?utf-8?B?TGZBQ21BdDZPSzlvWStORkJ4NEIwTnhEMjJuNjlBM0FCSEdrZGRQUTYxQXN6?=
 =?utf-8?B?cHZMZFA1YU9mekczM2pUbkpjQXhGVTBQd1gvNnA3c3ZSOXg4SFdkMWxQRWI1?=
 =?utf-8?B?YXhWWGZzbnVIREhPTnFMaVdnNllIWW50SVNUd3hHc3huS0ZyMGNXTFRybzV2?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fc350b-858b-4675-5be5-08de12389257
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 13:32:11.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCV6ZJBXS5o4v2TKSPyD4EjM+gy7UW6qPw2dEvaJV1ayS7yhOv35DPXl5AWzuKdjLuVRAw3Q5gr7lJmgRRpJab+nzAKm3cv5kl4dXe8rKUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
X-OriginatorOrg: intel.com

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Oct 2025 16:58:43 +0800

> From: Jason Xing <kernelxing@tencent.com>
> 
> Since Eric proposed an idea about adding indirect call for UDP and
> managed to see a huge improvement[1], the same situation can also be
> applied in xsk scenario.
> 
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> will be magnified. I applied this patch on top of batch xmit series[2],
> and was able to see <5% improvement.

Up to 5% is really good.

One nit below:

> 
> [1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@google.com/
> [2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/xdp_sock.h | 5 +++++
>  net/core/skbuff.c      | 8 +++++---
>  net/xdp/xsk.c          | 2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ce587a225661..431de372d0a0 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -125,6 +125,7 @@ struct xsk_tx_metadata_ops {
>  int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
>  int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
>  void __xsk_map_flush(struct list_head *flush_list);
> +void xsk_destruct_skb(struct sk_buff *skb);

I'd suggest wrapping this declaration into INDIRECT_CALLABLE_DELCARE()
here...

>  
>  /**
>   *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
> @@ -218,6 +219,10 @@ static inline void __xsk_map_flush(struct list_head *flush_list)
>  {
>  }
>  
> +static inline void xsk_destruct_skb(struct sk_buff *skb)
> +{
> +}

...and guard this stub with CONFIG_MITIGATION_RETPOLINE, then...

> +
>  static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
>  					    struct xsk_tx_metadata_compl *compl)
>  {
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 5b4bc8b1c7d5..00ea38248bd6 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -81,6 +81,7 @@
>  #include <net/page_pool/helpers.h>
>  #include <net/psp/types.h>
>  #include <net/dropreason.h>
> +#include <net/xdp_sock.h>
>  
>  #include <linux/uaccess.h>
>  #include <trace/events/skb.h>
> @@ -1140,12 +1141,13 @@ void skb_release_head_state(struct sk_buff *skb)
>  	if (skb->destructor) {
>  		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
>  #ifdef CONFIG_INET
> -		INDIRECT_CALL_3(skb->destructor,
> +		INDIRECT_CALL_4(skb->destructor,
>  				tcp_wfree, __sock_wfree, sock_wfree,
> +				xsk_destruct_skb,
>  				skb);
>  #else
> -		INDIRECT_CALL_1(skb->destructor,
> -				sock_wfree,
> +		INDIRECT_CALL_2(skb->destructor,
> +				sock_wfree, xsk_destruct_skb,
>  				skb);
>  
>  #endif
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..8e6ccb2f79c0 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -605,7 +605,7 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
>  	return XSKCB(skb)->num_descs;
>  }
>  
> -static void xsk_destruct_skb(struct sk_buff *skb)
> +void xsk_destruct_skb(struct sk_buff *skb)

...replace `static` with INDIRECT_CALLABLE_SCOPE here.

>  {
>  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;

The reason is that we want to keep this function static on systems where
retpoline is not a thing. IOW the same that is done for IP, TCP/UDP, GRO
etc etc.

Thanks,
Olek


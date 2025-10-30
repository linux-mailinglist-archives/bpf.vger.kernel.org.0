Return-Path: <bpf+bounces-72995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30361C1FB16
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4F11A25545
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA5424169D;
	Thu, 30 Oct 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MF9O88GO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E4286D72;
	Thu, 30 Oct 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822021; cv=fail; b=u9xUgHPRhyKq4dxsQRt7tbNONKRCD2rQLkUm64qMQw0v4Yasg/ivnNL3M1PICS22uLpxHwirjRdIH05BqAw6W0HQyI384w1hp2l+S45MbR2dlSYCdqwboOUkYae4haYCyRfJWtvhqHVMQntAeQ+WNmjzG5p+w1o7Gz6EgEaA2lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822021; c=relaxed/simple;
	bh=qbUg2kicSz+GmLvOwlz92sg5Ghe5gzTU33sc0zNs+y8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ei92rBI1uSQmEDP5yZ5RF1lOxS7BeRMBocWJc5PjuXhLtGJ6ZfU6C9PGkDI71TllnwWC49YBAgVM9gUK6WIczcgL7XrMSrJ/mMIzclpJxt8BtpbkFbEY/Vht3ymbUtJDT3s2qos9/NkmNgXjXIfd24ZGf60/WbA533xyTJvctJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MF9O88GO; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761822020; x=1793358020;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qbUg2kicSz+GmLvOwlz92sg5Ghe5gzTU33sc0zNs+y8=;
  b=MF9O88GOfcEwJ53kLOlDPy2X7ROlgw5WgAEJodwwgB4RxNvSqGp1Z6KZ
   QjwJMiZZIdCjR3uK/KtFwvt+/k5G+5AWWBaRnlPMEIYGuI4ga2ddFb4DA
   OxiaVZzGG2aQyVZpN1bsR/82cxMc3Dz4iyxf7Q6/T5l/dNr974xgdHzrF
   RQ7G3oRjYuPk75L7i5FfyW6cPuThN87S6WW2LzL8OlWaL8GjhjhQY0YL6
   lRR+w4G0qLKbHn2pCl6TaNOfP5Ds5+j4jx7taOt9mMndY6tMJCcuoKBKq
   z1rKo8qMQdy7/06xdYkxCqF1ZdfiA6IOUMgwB2auLPTIpZlx8JUgPeEkZ
   g==;
X-CSE-ConnectionGUID: g9Qk95IOQMGUFm4M9GNbwg==
X-CSE-MsgGUID: WuwWbjOUQTWb1lu287kL8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63659965"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63659965"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 04:00:19 -0700
X-CSE-ConnectionGUID: TtanjOVSR0iOEswHbwtwkw==
X-CSE-MsgGUID: DLJ/3e0QQf+C/hYPb0qRbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190285812"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 04:00:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 04:00:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 04:00:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 04:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G++l5HSVJnVP+cOqS2rONSO3mGwaFcME+8m6/DnaLnNq1W8MCCFYmyR9DTzi7YYU5DX6UfkbcPQwKVlursmGoSOjkZJPY4lAcD0DvcsP0dEkJQytiGD3GnFc1/z7rE98zljD5los5L7MaBpFGdAezeoziz86DchDkI6f6ulJVZrpKcG4hhUH7zJ+c65JgAvtq1G5jItHSSS9QTDpY/0sR18J22NJWQ8tdLl40ocfptHs6/2093shy7HZB+iUZSxtVil0El+ED4Ljx/juqD9Q7hJfZG7bSjuOhJYl6M6CoPw8Qp/DkUNGaYrEXluj12pvEqCpATZQ69/Ypco07Mc0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzhomEiuasieBFIzmDglQuTKOpvDHVKrAqQxLJE+9qE=;
 b=n7Bi/5Q5+sI+33iccWdWNTvz333b4J92O73kQsgFFnRYOBdsX/53YZgY8GAWN9Lj7HAlhSbuABOSulB2OYmKS7mS5R7qIwE8Iin41cxnYuQqCeo/r/Pvrpd+1tLBqYIoLTVCfd6fHDkKg6czEbdf5QXEcZKUlZQiyzqSVl9Qa1aw4/88jQQQ7Sl5Farncw8CJnGOPyKHmJ0I9gaQFEeY4ErNnkS0AqRBmJts6rmXdFF7Y5o7p8XVx/t4XqIpWAZPDaG4aInOHUCiCqqJuwzHCfC4Wwu3iR7aNxyDBAPzi4UREyC6F5jFUl0drO0xIN9y+xprvwBEFSSWNAcjLzzszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 11:00:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 11:00:07 +0000
Message-ID: <e290a675-fc1e-4edf-833c-aa82af073d30@intel.com>
Date: Thu, 30 Oct 2025 11:59:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Paolo Abeni <pabeni@redhat.com>
CC: Jason Xing <kerneljasonxing@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
 <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0333.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dc608c-6488-4238-2d4b-08de17a37cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmF5a0FLMDZjN1JITlQyMzNuL0lmMk91YmV4NDh2QmVsaXhJdS9VTUg5YjV6?=
 =?utf-8?B?WkMvNFN2dFdVdk9PeWNGVHFUaVBNRUxwb3BWcSswRy9IRll3N01JYlZ4MTk3?=
 =?utf-8?B?SkNnQU15bTRTMEpEUE1xUzUrZHNjUkZRQm9nYkpQbDcrQU9yUGJSaFVoeVJo?=
 =?utf-8?B?UHh4VFdkd3FBTjg5TVlya0VVVzZRZFNHSlBCZFhlRkFMdUF4MytFS3VyVFFH?=
 =?utf-8?B?eXJORFkwRC9JTUdYSUx1WlJXRkVjL0cvbVhvRWF0UFhraDVIdTgwd3FXK1dp?=
 =?utf-8?B?V0ZJZ2Q1RE9ibHZFMTFMbjVWT3Z4WXJCWHJtRy9ucFNZdGFCYWhheVRSZ0RP?=
 =?utf-8?B?WFdRMGd2YU4yN28xMGRpUnpCcXNFWXVHaHFmdnl0dnM2VFBiR0M2Vmd6U0dD?=
 =?utf-8?B?alByOTY3YTJLKzB1Z1ZkTnlDaFl6a1dGcFhadHZkWjNZRVIxQkFLV0VlazF5?=
 =?utf-8?B?UFZjYVVXMWV5bEVuZUxwVFFMOHlFSTY1YXU2T0owQ0U3VXBleXZkRk82V2dk?=
 =?utf-8?B?Z0lCWEtjOHRjaXFpaExwSEE4OVV5SmFVOFMxczlVK0dzcXl5TFZzU1pTbUtM?=
 =?utf-8?B?czVmQkl0QWN2UEd4Qkk4WlZIV1BqMEZYL2RpNVBKODJTM245YXlVb0Irb2h4?=
 =?utf-8?B?MjJpNWd5LzZ1d2RCbjJGcWJXQUR3dTk4Q2NKTHRBTjVkby9VS2twYzF0TFUw?=
 =?utf-8?B?cmtpU1RLZUVIZVBxVTRLQVhjWkl3aGxQK3oxdjlad0w3L0JoRFpHcExqNVVi?=
 =?utf-8?B?Q2lrMWF0OGF6R3FGUWdWR210L08rbkFhVy9KVmtMSTRiYVhOL21nd3JBdFZN?=
 =?utf-8?B?NWIxWWRUaklRNm01VXlJQUcvRGZ1U3AzOEJrZ25xUE1VZ1RjNGEvR0tMZkZP?=
 =?utf-8?B?dmYwVnpTa0FDM1pYMGtJcE5IK2Z2b0lEN2w2ZG8zS0dxVGhiNVl4by96ZmVK?=
 =?utf-8?B?VCsxRzJheFI0bFZPNmhWYnF4OXExNUd5TG9aWmhlWU8vN09QbFpQRThxRjhZ?=
 =?utf-8?B?R2dWUFkrQXpKZ3llY2NCV2N0NjNaT0NLV1V1K1BFU3E5N2dxQXRWYjJva3Ix?=
 =?utf-8?B?a0tmcmhIOVhoS0licWxndjUzRDNGL3ZjeVVHc2VaU1BsMmlQZk1HTWhqQWZk?=
 =?utf-8?B?SEFVQmhUR3RaZ1ZBbEpGUEExa3QyMFNjSnE5NC83MHJGaS9jZ21ZTUZwd3hr?=
 =?utf-8?B?ZzZnUERvdzlrTWJPZyt0Q1NBVHBMVXRtV0JFb2JjN2JsOG8xOS9iTE5jbVBR?=
 =?utf-8?B?ZEVOOG9YMGtiTzg2a3czREJOeUFVNW4zZ3hwbXlPVnVnOStmMzcvT3poekgv?=
 =?utf-8?B?ZlN4TjZLcmVDMnBZbktBQWRuY0ZvdlBDQk12ZERPVm1RV1dxazBpa0dhbHVp?=
 =?utf-8?B?alJ2anNxT2p5L0p5a1pFa0ZndWZBWnhubjNza201REljUksvUFIyMzZJNlJN?=
 =?utf-8?B?K1VLcnBxWUZvemtTQzhoVXBXVlo4d3YxanozeUU2cGhJV05oVUtnZmM2aTZY?=
 =?utf-8?B?c0I5cS82V1lkYlRiU1U5ZUYyT2pTL2FIVXN5OW9FRVZNbDZKVDFwUjc5eHJW?=
 =?utf-8?B?OHlRVCtqMlQ2MVJqbE9EaVNQK1QzNzlwak5IQUx4bkhUTTVwSG9ob3BXN0xV?=
 =?utf-8?B?QzJMNHlVcE9KNHA4WDFMN0p3VEZ0aGlDOEM2aUFjS3FpK1F3SnF0dElHY1Rl?=
 =?utf-8?B?MjE4Rjh3OTgveHlvNFVsWnFRby9ZRjVGd2E0Q0Q3YjVlN0U4NDg5cUdMNUJy?=
 =?utf-8?B?anZEbXh1M3g3dmhUc2J5dVVidTNrK29NbDhPbFk0VFdaWFpiVW55SFpFVmc1?=
 =?utf-8?B?UC9YeXB2bkhXaXozREwveTRmWlpWeFZheURJYWt4N1YrNFhTVWM5M0x6bXhZ?=
 =?utf-8?B?TE5FNDZqdnZwdmZPdFRFS0pDQldIdHViYTNEbXZkVUpQL1hLTnluUkc0NXo0?=
 =?utf-8?Q?aZFgaluydM9o+ZzQZrcAL6xLva1S4zr7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0FMdE9ILzIxMFg1R2gzbnZiNFRoOXpyNFJqZVVMVlhFWlEwaDNSVmVxZmpB?=
 =?utf-8?B?TnhoSFRFbW9TY1FrS0V1WSswdEpGY0ExWFBzZ3l5TU00aE9ZejZ5Q2FiSmJO?=
 =?utf-8?B?d2xqZEpRSjhtZUgxTkxtVDU1RFptQ3pUUmhjSkxxUEsweG93Tnl3TCsvalJv?=
 =?utf-8?B?OFZWN1VCcXRhNHE4MXo3WUhiNlpoOWVsZ1B0b2JpeWFCY3loOEkwS245YUhB?=
 =?utf-8?B?UUF4REVUWkFYWWp2OWFGeEFIenBFemhsb2cvRFRtUm9ncnQxeVFiN3c4Q25k?=
 =?utf-8?B?NytCZWFGY1ZZMHRNRTBUK3JvYXdsV0lRMUFlZXhuSWE0RXRrWlRMb2tyZkw3?=
 =?utf-8?B?Z000ZEpoWDFPTXc2RVVHOC9EZ1F4WFA4SHlhdzR0WFRZTFhPQjVHWGw5ZUxt?=
 =?utf-8?B?MkdlcC9LU01Fc2tBM3JsbFRzK3BzckM5QjNhYW1SajFvelJQT21tZUQwbWU2?=
 =?utf-8?B?U1dXcEYvK1JXQS8ycDhUdXQwUks5QktHR1Ywb1JDcUFkS01rNDdLZEhrMnlh?=
 =?utf-8?B?eU1hdGJQUVdEYmRsaEJTN2svTFpYNVVLaEg3azJSa2NiVkU1U3pGODR4Z090?=
 =?utf-8?B?N0lybTM5dlUyZC9uSjFYNmZmUFFpbjZtdmt2aG1keW1YaGhGVWkxZjdZUHZt?=
 =?utf-8?B?Mk5SSkNjWGtWUVN5RXExL0p3TTV4ampnOWxObkhVdmxVbTZBZUNRNTlKVzJq?=
 =?utf-8?B?TDFHRWk3YUFRS1FKT3A5U1pNR0N3VXpnL0FrbEpqU2NKdktsaHBvcS8rQVV4?=
 =?utf-8?B?NlVSVnZpTkpXUGVtb0pvVkh5dXlRNzdEeXoxT0dkN2VvNUNGL2JrTG5JTnBx?=
 =?utf-8?B?UjNaSWdhUzdOdytlVFdSZ2lhbEc4TEVMeWZscjRkQnZiV2cwS3R0QXB4NHh6?=
 =?utf-8?B?N1lZWUdoZVVLWnhzTjBBa0VoRzYwZmpNSmUxdVc5S0ZMVmlXQkVGUGFuRy96?=
 =?utf-8?B?d3JybEp4UmlmS3FVeGlaRFlOdmltdjZ4ektVWW9lak9ndksyVmlEZkNHYThU?=
 =?utf-8?B?NXhkZzY2SURWeWhYd29XN295a2hyV0pvQTEvKzBEZHNvVGExQWdNTXhxM012?=
 =?utf-8?B?NzJYYS9neS9ONU5ibGY0bDRXMXplWmZsMHF3UmhxeWgxUXVKUDlDaExXc0Mr?=
 =?utf-8?B?VW5ic1lBeGJDN1VRVGF6STRKczhIREYzalBzeGxzZ0c2U3Yzd1dHMFVDR2Rn?=
 =?utf-8?B?REw1VWtVY2RDZy9NeExEZ1pLY09sbUpPeWRSaGFLOG8wMi9GSjFaZEVtL29M?=
 =?utf-8?B?YjRaRkdac2tzcUg2TWhXSXJlSnc3dWNBbWg4WEx0LytmeCs1b05VQWtUekJi?=
 =?utf-8?B?aXZ5cXprbzlrd0pXaWVEaFd4OXJHdnVUT3JUMHJvSzZsdXFCRHFhcUdhRTJj?=
 =?utf-8?B?MzFINmdnb2JVbUl2azFWd0FpTU1tRElGT0g1VXBkNGNYTnlIQTNvTUxoMEl0?=
 =?utf-8?B?ZEd0dVlxam1ZaDRDQzFRSzF0WjBSVDJid1Z5QUN3TllqNkRnSUxiNEUwbnFq?=
 =?utf-8?B?WFZDZEMyZDByeEY3THJCUGdkTTc3cjA0QVdYN3R3OGtrdlpwdDJYV2ZwcTZ5?=
 =?utf-8?B?WDVtMVQyVFUwR0IvbXNPRHY5V2QzNEg5MGxjQk1jM1FBMTlLQ0J1OVNqQ3Jw?=
 =?utf-8?B?N1NVcTEyOFlnZDZLd2xWY0RqcGhRZy8xalpuMjNBc2oyanJjT0EzRjFlU1h1?=
 =?utf-8?B?bUw5YWJzcGM1S3Y0dFo3TFg2MWswS0JXdU92YktHa2FTcXBiUE9nS2ZHU2JK?=
 =?utf-8?B?ZVgvV3ZjSUk2OHdJaWxvYUNtU3k0YThjWEFyV1M2anVsOE9raUpoZGpkaFRq?=
 =?utf-8?B?UFpMRmVNenU0SlhkQkk2UHBUdDFOeVdvejBjZ1FzcjJsaTdlb2dISzVxWmRD?=
 =?utf-8?B?UjJVUlZxSEZ2SHkvdEhOSXpBTU0xL0xRNTdFb3BHV3dKTDdpTHRTNlg5Q09X?=
 =?utf-8?B?TUR0czFrZkNkTEhFc1FHWjR0UHY5UXEzb0dXNkVXZ0E1cTdnbEI2dUxMMFlk?=
 =?utf-8?B?aktVck80ZEVxdXBtZEpKRkE2Y0ZDTGsvUGdXS0xMcU1HZEhuMU1hV3BhVDEz?=
 =?utf-8?B?aHRjc0lCV0dHMDRGdW94dzgxS2JXeFJDZjRyYTlScFdJMU9JU2dvQ080dzlS?=
 =?utf-8?B?eHFLbHY1N1pJblJscEpzVlU5eDNOMnVzV09EWVhtekRNeWtDYXFYdjE2Wkhp?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dc608c-6488-4238-2d4b-08de17a37cbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:00:07.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lydXNhmCTK4GsjPLl5eQjSmTa3ZoBEOxYLzGTJO1bTz9a8+3KzlUM6sGY6QZtwgSHMZb5yuUxg0Lxt3z9CAS24q8uHZ0UScWSKSPrT+LENw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-OriginatorOrg: intel.com

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 30 Oct 2025 11:15:18 +0100

> On 10/26/25 3:58 PM, Jason Xing wrote:
>> From: Jason Xing <kernelxing@tencent.com>
>>
>> Since Eric proposed an idea about adding indirect call for UDP and
> 
> Minor nit:                          ^^^^^^
> 
> either 'remove an indirect call' or 'adding indirect call wrappers'
> 
>> managed to see a huge improvement[1], the same situation can also be
>> applied in xsk scenario.
>>
>> This patch adds an indirect call for xsk and helps current copy mode
>> improve the performance by around 1% stably which was observed with
>> IXGBE at 10Gb/sec loaded. 
> 
> If I follow the conversation correctly, Jakub's concern is mostly about
> this change affecting only the copy mode.
> 
> Out of sheer ignorance on my side is not clear how frequent that
> scenario is. AFAICS, applications could always do zero-copy with proper
> setup, am I correct?!?

It is correct only when the target driver implements zero-copy
driver-side XSk. While it's true for modern Ethernet drivers for real
NICs, "virtual" drivers like virtio-net, veth etc. usually don't have it.
It's not as common usecase as using XSk on real NICs, but still valid
and widely used.
For example, virtio-net has a shortcut where it can send XSk skbs
without copying everything from the userspace (the no-linear-head mode),
so there generic XSk mode is way faster there than usually.

Also worth noting that there were attempts to introduce driver-side XSk
zerocopy for virtio-net (and probably veth, I don't remember) on LKML,
but haven't been upstreamed yet.

> 
> In such case I think this patch is not worth.
> 
> Otherwise, please describe/explain the real-use case needing the copy mode.
> 
> Thanks,
> 
> Paolo

Thanks,
Olek


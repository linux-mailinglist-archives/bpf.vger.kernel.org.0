Return-Path: <bpf+bounces-53962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2EDA5FB26
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8629A7A22AD
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C72690F6;
	Thu, 13 Mar 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecuaJhzx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF251FBC99;
	Thu, 13 Mar 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882665; cv=fail; b=CNhV/mjrXGpA/OZHinkJUy+mZJCMMeJF/T8Uj2xdJ1b0z0AlYkNZ7CNsOGw+xzYJIVPOXYhH9XyJqA/0I0uq17CyjKOzS3EDL189pr6ek0+jMX0ZAsCpdYgdzKKjglEiZ/QdShTnUB9lvVBu3gFzs15mnbptNRnc9xLWAkNJLx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882665; c=relaxed/simple;
	bh=OAW1FWQdRacftoCxMnfHq6jPK9cgKj1pasPiO1DTXPU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iLUxmuKYNSvbf0gQDtS7Rq3HSZW55JQV75U2nLJO1yxRWx1wtUm0BNXHxpKicOa6votYs1uEg/LkNb440xBh+T6QLzFKiiFBOEPhIxniUghX/1R+Be4HxJbknl9hZOm9V6qV32WHyzIWkqld4RXS636oyV3hA1h7Vmg1LKqKLTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecuaJhzx; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882661; x=1773418661;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OAW1FWQdRacftoCxMnfHq6jPK9cgKj1pasPiO1DTXPU=;
  b=ecuaJhzxp/NgVAn92S60XvH95VMHk7x1TcQKIjV5Sf03+FvuqWxw8vGG
   7Or8I/kRpauWsEMov7TOwGwUFzX9LEqdIfjglCRad8bpjYA96//J52DDt
   iHSmg7kdbTqN/QCx0bPKLQ7QfnqFGl10BOVOQkdA9NYZVDJOYe5EfEa7W
   r6KqFP0zTxAnwxWUc1jUXypI+AtoHp5oOSxgoWNF+x/2vmYo8z0wskJ+t
   i6QapFejW7lo7OvcKTlhq+UCj/JYC9r8AWda5C/nvlXHZ6fI9lIcY0pPk
   QAlFfOr3bCNM6g1Kvi68WJBF1+VZ88/AI2RyQAbkdu92sgsHrLcS19G8S
   w==;
X-CSE-ConnectionGUID: 8OrTaBtKR9S2wlR7wbOE4Q==
X-CSE-MsgGUID: XuL7OZULQNiAk4f18FbEZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46799000"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="46799000"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:17:41 -0700
X-CSE-ConnectionGUID: I++hGwJvTrinb484VqM5Tw==
X-CSE-MsgGUID: 7PZJAZl1Q8mJ3vcRuQcfSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="151858665"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:17:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 09:17:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 09:17:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 09:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va/iaSiNTWL4fyScFdhbblW/mMnIs3iOlp5Plg5DTV2CzYrlfzHyoPzuNHyis5uWPkUDFSLwN8gQiX9hYeAnYHI7M4nusI7H7N5DPabR7CF+SgmhvK/pKOmat1WslIxwcdF/1yxmONR32lZNxZFOODuQ7n+jYWCdh3ouMgyxQAwJNOGHVqBkMODP0X1vrnDoppySn0iMu6UeOdU7gqDdN13f7ocaz3Rn/XBMAJqPb9mv0hd5V9gwuRTb4uTUb2rjQeqDWrPBsj/SmxMHAtBFtJ1xWsRyJmKc1T+XH/YZCqK01M5cRjASFTIvtzIyNGntzkOY2dQjsIVUqtvRgmi9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAW1FWQdRacftoCxMnfHq6jPK9cgKj1pasPiO1DTXPU=;
 b=cjb+IvjQLHWleg+tFBfTGE0rgDVMHbdqgHUwXK5U5E1rxmlwMY6eNMTrG2NfjmaxKn/7x6r+Bd50w2oXxeVCvJ29sFeDJyoEtrtYoAC1Vypht/ptY1IG8aM6ExGg0o4nxL5Jqhk3Dy5HJxd4ihb2/YXahBkK5PwolQ5lWYTt650wH4CAnSBlySjSa+RttG/jWTuPRxZNBRVuHa9VExnZ8+MQE9L2aJR3hRzQGhjZym2VGLSEpt8jETeQboW7321JeD/PNF6IGSn5Tz1/u1cm9mtsW36JDaEACmUwXJKgRef3tbGJBC4b3HQpN3Ob75b0Xqm1B5quibM+rnnPB1L/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4624.namprd11.prod.outlook.com (2603:10b6:806:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 16:16:38 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 16:16:38 +0000
Message-ID: <5806fdc5-aec8-45e9-85ed-5646c8d652de@intel.com>
Date: Thu, 13 Mar 2025 17:16:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/16] idpf: make complq cleaning dependent on
 scheduling mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-9-aleksander.lobakin@intel.com>
 <Z8rUSb+XocCGHSrt@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z8rUSb+XocCGHSrt@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:10:be::40) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: dd582d42-3c89-4d18-c80a-08dd624a6efc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWt2RHhKbS84Y0FZT3NhVi9rNUJVeS9LU1Q2bUJzOVhSeG1IV3Q3ZlhjNTVH?=
 =?utf-8?B?Zm5CazNWUVBDc0VrU0hOZUZGMFhIVHNyd29ENW9MMEFlZzhaRkJ2V1o5em90?=
 =?utf-8?B?b0J2eHE4V1NhQ0R3U1c4NXpZSTRRdWdmNFhBTmJjbFlZeWZLWHFNZWd5ZUdR?=
 =?utf-8?B?a0pXWklqM0tnSGJHTUkyclI4TXFrcDFvc08vdGdHSXo1T3RBWXVlOWxZVE1N?=
 =?utf-8?B?dzBHSFh0QURNZ3kvdWd6MHloSkNCZjhGUVRKclZLOTF4ZS9WN2IrWVNnWlRz?=
 =?utf-8?B?MG9xR04vdjFuaTV4MlRVTUkxdy8zSHVrLzZtSFFyM0cyTXpWenZQcE40TDBD?=
 =?utf-8?B?cXdLcjU1WHRYclhCU2VmUVJUOHBmekZ5SWIzVFVvaDhsc1p5T2pUOWFma2RG?=
 =?utf-8?B?b2RpeDlPS0hDRndpdllZNnNma2QrdWswNmNXR0IzWG1JVktkaGppeHBHN0JQ?=
 =?utf-8?B?NlM0S0xyYnloQ0pvcXA5MmdRaXg2ZTYxRWQrTk4vWWx3UEtWYmRuS0dDaWFP?=
 =?utf-8?B?RU45MUE5clc3OW5PNTBraDVKZlRHL3EvRjhpb1VtSlNDMW1WMUpBM0lMUVBw?=
 =?utf-8?B?TXQ2bk9WS0RQazIxems5SVpBR1FEc2JOcEdTbTYzbUU1aHJpUExSV2hpNFlt?=
 =?utf-8?B?V2Fzc095RFkzcm5DbCtIUUV5b0E1QUdZQVNzVWNoSSsyUXdlY2thczBCZXhh?=
 =?utf-8?B?clV1cTdWWlBuZDc3MVFMeWVabzdrRFJXMWhSN2JCNzFrdHorS04wRFJKZElZ?=
 =?utf-8?B?cnRXbzNqRnlZTjdSbjJtYUthRTVwMnd6azBLc1Y2RUw2UGtlc3BOM050SVBL?=
 =?utf-8?B?ZDNkUHlzVTk3SmFaMnRUVWpqMjd0WThRWUpMbmhmWStZTjQ0VkdJWXZTSEh0?=
 =?utf-8?B?TS9LVktYSnZMcEl3VmdwQ3R3WHhwQXdlY3FHNC9BRHdnMy9NTE1xUDJpUXZ1?=
 =?utf-8?B?a2lmZ3lVdmVqVDZqRWVwQllRcTFCd01WN3preXExcjluVlpnaU1OU0I4eUdv?=
 =?utf-8?B?eGdVODcwa2grZkxIVzB5V2x2Ui83UXBRdHI1OHF1ZXNzZWw2cmZDaGJTcXAy?=
 =?utf-8?B?aTJtNTdia1p4bzYzbnM1VDF0ZGlkOFRpNlFkQ041Tlp1YTI2N3I3WWVTTlV2?=
 =?utf-8?B?aDhuTDMzVEc3TlBVY0YvSkNyZ3ZyMENicWtlcm9aNUFnV1JCWGNUWVNxQUVT?=
 =?utf-8?B?ZHN2YkV3ZGhDSzY0Qmh0Q2hENHV3RlNBcGVFbjZDTDlwNGVsZUJXUnRBVkJp?=
 =?utf-8?B?NitDQWJLc21HWmMybU5RcHdSZE5HdDI0VzV6N1JIU2pGc3VxcCswZEZXSTR0?=
 =?utf-8?B?TDJrZXFvanB5a1JGWmZkc1pSOGF6bGZSUHlkUUNrZnNaV0c0MFNmdkpUTEgz?=
 =?utf-8?B?ZDh0NjA5aTRNN0tCdktrWjNaV3pRZS9odFBZbTFxZW9JYUprT3pZQlBkQzFV?=
 =?utf-8?B?bVVPZXdMR1loaWJhVlNPY1dVbzhtV2FhdDlscm91aFBZaFlTVEVZSFAwbmFE?=
 =?utf-8?B?dGIyVURySnk1R0JYSE50WWI3UlNnOGhyYWlXbFlQYW5qbDFpYjlYemRxNG1z?=
 =?utf-8?B?dERQU0Y3aHlsSkdueTNFYS9WNnV6SmxHT005TFprblU1K09zMHQvZFNzdkN5?=
 =?utf-8?B?aFNaenJ3VXFHb3RMMHJmQWs3QjM5OWR2RFVJaFY1anRwem9JMThRcnE1V0Ur?=
 =?utf-8?B?aDVWOGdJZE9aMDZEaVg4WExhOHZGb2VNVmc5U2ozdkk1VWNoemNyMWtZUkJs?=
 =?utf-8?B?U0JNbWFlQ3J4MUlMSkV4VExsTmVHZU1XbWxyWnNodVZrT0xNWkRDcU9KdWF3?=
 =?utf-8?B?M1dZUzd1eTRYY1pYK015Q1M2Nk41ZW9pQW14ejBLZFpKQm5aSUpBeVQrN1VT?=
 =?utf-8?Q?RBl8XrzD4Hvqb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjUzMnRuaWQ0cExWVWhmSWtzSkp2dnkvN2U4blhPVFZ3amJyc0wxcTB0d3Rx?=
 =?utf-8?B?eXdwV0ZJV2NzTjVhbG5PakRtU0ZEOFpZcGZZak4zV0FuaWY3V1ovVUg3TnVl?=
 =?utf-8?B?TStMcGZ3NWx5L1pOaWVycDd1R3d2YytEYkU3czhJYWgrUGpNcWhQVytaem9V?=
 =?utf-8?B?aThvTUduTkF1WDkyWXdEQzZPTGU0T1U0VS9KNUx4MWN5Mkc1UjY2ZDhGbC9k?=
 =?utf-8?B?R2xPWlVDWkZDOHlWNVBsb0RSeFhud1ExK0FGcGtQc3F6VzAyeHlLYndoMGxn?=
 =?utf-8?B?amtVcVNkbFJhUEkxWmZBMFZTaUZINDRHbUVOTUdoTXBFbUFESS95ZkJQZE1E?=
 =?utf-8?B?ZGhxY2lCQ0pjVDZvZ2Y4VXZpSGRHUkhkSE1WQjhwNnNvRUsvYlVOczgxUDJm?=
 =?utf-8?B?OCsxMjhhNUtibGhUcjhrRW1VTW95SjNwSmFJNzVBZEdJSWVEWTVZNmFlOHBi?=
 =?utf-8?B?Z0xwVWZaUlJuSnE5SFR2MFlGbEZRUmZySG1tSEhRYjR0MDVTSS9mK01YN0VG?=
 =?utf-8?B?bGpvdTVySVUyeDBxUzhKVk8reWZJUStGdFNPaUJ6QjhJS2ZlNVZQOVZuNTVk?=
 =?utf-8?B?N3J4UTJZQktCM2ZiSnJuampqUWZ6UFBYR0V4Qlkwb0ExSmxLMVVVWFg3VC9X?=
 =?utf-8?B?bmJhRFJjSGNOdGd6ZVlKNUI5MUY4UDFhdjQvVnR5OC9aanp3SjRGTkhITlJk?=
 =?utf-8?B?T2c2cWZ4ZWp0V1FiMmx5eGYvZlE3eDdjcVNGMk4xVUtlSW5tZmF1UWtEVlRQ?=
 =?utf-8?B?ODVta1dQOWpvZ0dqemNUZnVkM3lmU1dvZHZhZk1SeWhSSEZuSi9tdW9CNGl1?=
 =?utf-8?B?bXlSVnRvYTZ4bjkyOHB3RWhnQm1QdWFWRjFwT3ErdlE5RERxeHdpcG5qTjcv?=
 =?utf-8?B?U3YxWUtQQVdWajMxcG1PVzJ4MEJLc3pFbFVIYUcwMDcrTS9FYzhVRWJsZFJF?=
 =?utf-8?B?dWV2WUpLOUhlRmF3S09idkhIbUorcTJLWm9WTXUyQ1FkNFpFSE80S3A3RDVl?=
 =?utf-8?B?NW9pR1RmZy9zZkRjdFNtb1JWbGlpdjBObXRUQjBuL3o2S3JIcWpPT1ZDZXJp?=
 =?utf-8?B?cm9saGdISE1DeUE4RGRJUnViQ1c0OVpuSllHZEZ4UnVTS1pzYW1xeVh2UTBT?=
 =?utf-8?B?dnVHM3pXeEZLTWpOd3BmaEM0OWcycWVYdVdseXZJbFlOaG1uLzYxQTdLZVpY?=
 =?utf-8?B?VVpDTFZ3NWp5ZXVFNWxmTUoyT2ZTTHcwY09OOE5QYmZCVFdhVUpiL2U2SWtn?=
 =?utf-8?B?MTRsckpRSWxqeU5BRDR1ZGIzMEx1NVVyRFdNb1JIMExIeW1qTWtMQ1dMdGdE?=
 =?utf-8?B?RklmdjVGd1JaY3J1dnltai96UDNEektLZHA3cFJDSEEvdU9BaFdESlUwN2FY?=
 =?utf-8?B?dHZUL0NPSHE0ODM4ZHBaU0JvYTNnUThtd2duckxLYUtWK1JGRlVPRUNxMGpF?=
 =?utf-8?B?Snp6Lyt1WE5IcjM1RVdyWEFlcCtNYWY5Sm5NMWcvdkN2NjVuSzc1TWZNcFgz?=
 =?utf-8?B?dHI4azc5anAxYlJWakY2eFhSK1ptam5jTFR1U2JjNjVZcjdmTnRPbXJ1Uzlt?=
 =?utf-8?B?MjF1T3NnMVN5VHNmQlkxcTM4VmZtdzNzTkljNkN6QlBTa0tyYVk1MkcxL0RQ?=
 =?utf-8?B?MEFUS1d3Z1dvQlhWZjRMRmlLQXI5Nk5OWGh5T0hITDV5KzRNRmpmem03RlFZ?=
 =?utf-8?B?WDlkMHRxaG1ZVUFzZnlTeFBUNzRCM1hQbThsOUhCSmhwelAzWi9XRlJPSklB?=
 =?utf-8?B?MENqTzNKT0xpRmFmdjlIWUJSbTArczR3ZGZZNi9sbHdCTDBXbXpLdkJueTNv?=
 =?utf-8?B?RXkvZWdpL3E2NXA0L2J5cTk0MVk1b2l3Z2loZXZ2bWFTaFdDbmJvNEFneXds?=
 =?utf-8?B?d2FlcVVTS1M1cnpSa3lBM1VKbTNYQUt5b0RDTTRrekN6VEdVa29qMTFCRElP?=
 =?utf-8?B?R25pWGhhajB1U0FpNU9JaUlyWmVEWDhhNUt6by9IWjdvbS9NYjh3NTNGUTRL?=
 =?utf-8?B?UTVUdUpmZS9IRlBBcGduUmZMZERsYmpvNDZUbS8rRU80d1RhcGhGMmcrUEpH?=
 =?utf-8?B?eGVaQnFLV3JXaXhIUmZneXV1eldCR1FMN1J3cFVSWnQ4andhUFlJRktURElv?=
 =?utf-8?B?VXM5Q09jc3A4Y0Y0RlBlTHJtYWZrZ0wyMS9uSnVyOER1NWFRUWV2T0JMamRR?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd582d42-3c89-4d18-c80a-08dd624a6efc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:16:38.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/YPzPlzVa5gEInBSL0qbHa5fJYJ9ncWgLZbxav5pHjkxXDEUEoDjU/0sWDM7FBnpRgOh8fMqayGh0DWMfS0ZYlxilvKXjV37gkIbuPx5jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 7 Mar 2025 12:11:05 +0100

> On Wed, Mar 05, 2025 at 05:21:24PM +0100, Alexander Lobakin wrote:
>> From: Michal Kubiak <michal.kubiak@intel.com>
>>
>> Extend completion queue cleaning function to support queue-based
>> scheduling mode needed for XDP queues.
>> Add 4-byte descriptor for queue-based scheduling mode and
>> perform some refactoring to extract the common code for
>> both scheduling modes.

TBH it's not needed at all as the cleaning logic for XDP queues is in
xdp.c and doesn't depend on the regular Tx. Previously, the same
functions were used for both, but then we rewrote stuff and I forgot
to toss it off =\

I only need to add 4-byte completion descriptors and allocation
depending on the queue type. Regular skb functions don't use queue-based
mode, XDP path doesn't use flow-based mode.

Thanks,
Olek


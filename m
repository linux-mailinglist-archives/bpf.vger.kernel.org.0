Return-Path: <bpf+bounces-35560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBEC93B824
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B6D1C212EB
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E97137772;
	Wed, 24 Jul 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgBo8SLC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64965E20;
	Wed, 24 Jul 2024 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853665; cv=fail; b=gTrdODwhzWcqDU967FTBZIAt2GaZ6vT2VOi7pTgxoE8CBCv99ha4AXsnp3AdtnPGKYx6nr0duXrZDCsbvNjKxX8lw0zOLqUgmJU7NmMxtXBs52UREFZZKTP1CCJJLlgpe+LldRZBDJYXE1ZgRdp9pl7bKteswFH9lCepURfg/fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853665; c=relaxed/simple;
	bh=PnDWz+bqf580fqC0aLo0E5Ibwc9QZ49M154Pfg7tI8E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p1ALMfzl8l1SPw3NWV3ffquMUk/1bM+wEdcjXMVWIZtMa0aIKjpXpIZwFu3NH6pPArvgUaf9KSttn60tW0/Yc2GdR6UgpkzZ5SFb/qS6WnrEB/FdkwPoVaQZyq6anRzrOZAtFDDSN+muiZM9I5OW7NBiXPJAy0nR6WFkgfhKazs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgBo8SLC; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721853662; x=1753389662;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PnDWz+bqf580fqC0aLo0E5Ibwc9QZ49M154Pfg7tI8E=;
  b=fgBo8SLCC1q+H67V3D9zC4I+9LhEA34y9HTGfFu++rIiZIqnCoxlOgX+
   Uwckw6vnWoQ/dEVRjMgRiZnpqTLAEg5Yij3Y94TJfwdEe8h2PyjweW75V
   MlUA8nUyD0w/him1Ja95EtRGdCSZWfb9Cg2tcEtg/a4YVIm8X/qV5QSfO
   vIMfblbKFkhBksoWV6JsjUxp7D1qz8nBAxeqnXpaU+WQ1iSU34WJfCvx2
   Chzuu9GlSRgopGUF++MS65DkL3fLsOp7gjma6Jo/GAfMl6XQKUngVrwu4
   to1OOV9i9PV7IAfWuCoE9f3IC8m4H5V6Z4RO9XWyq6G0v+OIaVDPiJdA1
   Q==;
X-CSE-ConnectionGUID: EBYTcmoJQJKPyVAaL1D/zA==
X-CSE-MsgGUID: WM/EiVUNQRuwdMSqECkK7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30951260"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30951260"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 13:41:01 -0700
X-CSE-ConnectionGUID: bIRU3E6SRS22Lm4mzoChdw==
X-CSE-MsgGUID: WQuOUkCDRrmAHHd1aXOTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="83314734"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 13:41:01 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 13:41:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 13:41:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 13:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJAEdKXJvuzMZSflrCWWY3cPQXIVJidOzWdD9iS4k3V+azdezFhDi2qQor0i9nVTxaeCKSHJwt6cLwavBs088PDf8IG4U0MeDPQAKV4GywE/a52oyoOL+cROdjAx/9iCK9wlMAI1s6dBeAoTOid59s6xPII5iQwIvjLJ9ioIZyDlfl2o6kQIzEb7Az4FdvmjATZ8wJZ+EMm/dyjy49wEPnyZ4AcbuKYVnmAXfnO2Pae/136PcVm52BXIRj6OCe6xbtDQLKWI33euqp7uLNz1UlqOk8vS2Ra5F5z953tfpDFdJR+xpYG+3oHXNwnbxbcfdUrCJVmGQ3PWzTm32owc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckqixfrjr4mfHfORuYxX9AiBu7bJxtyCPlv7dSX/0Co=;
 b=tNA/S3YzjqG8shyCAIk63hGNqXRBTBrmgRY9FXjl9yQT+3zYpO5uywQWu4NSGzU86BR76r1COxWkq7vikOYXQUDBQkYU5yl+AObZub8reoRWQDnh4hpGiNTEKisl+Y/JIVDF4uz7mukwLqQoExCQU8FUnRSh9dSn6ZHhi6wOCJLpyxK8YeEaY0x8CmvlzKu3oI3NDUaLEFjKUHqLQp6agQszXpkPM461OM7ggHBY6qDC61j26MgJDDFEQnqjdXvC5zTvxxi/jDZLGlxrMgz90DTv0+DKSjt+DygE77RVMDS16maoNrBuywUYIF6Wh7TpH8WaAIhs5ZhQUY2hlMdeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB6383.namprd11.prod.outlook.com (2603:10b6:8:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 20:40:56 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::18ff:e3c3:1dd7:8a12]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::18ff:e3c3:1dd7:8a12%6]) with mapi id 15.20.7784.020; Wed, 24 Jul 2024
 20:40:56 +0000
Message-ID: <e63d88bc-6927-4cdb-808f-aee4eee686a5@intel.com>
Date: Wed, 24 Jul 2024 13:40:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/6] ice: move netif_queue_set_napi to
 rtnl-protected sections
To: Larysa Zaremba <larysa.zaremba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Jacob Keller <jacob.e.keller@intel.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-2-larysa.zaremba@intel.com>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240724164840.2536605-2-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df8a119-dae3-48a8-dd1b-08dcac20eae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFc1Q0pLeDJHdHFUdVFVTmp2TCt1d0g3R3dFUHhENEZoRlovUkFhWE83VGgz?=
 =?utf-8?B?aHVCQTRnTDI3WHZad0FJRzZHaG5WR0FGbUZFRWV1TVl5em5IbUlFa1l0dGdL?=
 =?utf-8?B?cytUbzRIVWtNWWdwNzdLTmUrQ0pEME5xMHZuSjZ1Z3dEUDhKRFpCVHJlK3JJ?=
 =?utf-8?B?ekRPMkd5RDF2NGUwRlA4S2xZcmZpWGtQQ3drRHhrOFlIOGhxc2R3ejJ5NTEw?=
 =?utf-8?B?QU5ycTRmUlg3bmoydmxLK09JdUhJaFN4OEc3bVQ5TWtSMGhLcitEZzBBZndx?=
 =?utf-8?B?TlZCVUVCQVE1WU90bStFblVUUWpzc0FFdWhBdzF0NWMvc2FZVGVWZ212SGZi?=
 =?utf-8?B?eHNJY0c1MjZXbTVVKzRjT3hPNlZTcHd3NHM0d3ozWEdod3ZOU0FPWU1rRFhC?=
 =?utf-8?B?Tk8wQ09QSDJFSFdXS0FQbFliUDJQaXdkL2Jhalh6bmFBbzcrWUJIeWFLS1FF?=
 =?utf-8?B?UlNzQ2F2d0NTSGxEL2V3Sm9yYVA0T0k1aVp2bnk0TkN3Y2Z1NzJJKzBQeW9C?=
 =?utf-8?B?L2gxRnFUZXJWcm9IbVU5TlJGZkoyczFQYnZrc1BIcEcxUlBNdEh6V0J2WHBv?=
 =?utf-8?B?cEYrOW55NHgwQmRKcHlhTzloM3FPU1V0YzFuSlZ0a0ZtVFNZeU9DVkJ1ckcx?=
 =?utf-8?B?bm9INFNJdXlZNXZaMjUxUDc2ak9TaW84TDEycEVWbkdFQWlBUjEzcTlYRnE5?=
 =?utf-8?B?YldUUnJ3WnkwcHlkMnNZREpDdjBLVUNpQzhWYld4alJ2QkxCb3IrRHEvTEFr?=
 =?utf-8?B?QXdOWmhPdUZnamIwZVpPc3JMeS95RUFIL0lkK0ptdGxWYktJZGlvdmE5aFcx?=
 =?utf-8?B?Vy9IR1B5UDFLTytlYjJiVm9xR21IMTdBb0lJUDFwK0swZVNQUmNvVmZ1TVY1?=
 =?utf-8?B?OFFoZEd1N2JEY0V3eFV0cWZsT3FTZGlLS1pudHlIQnJZTjJ1WEVlcHlWTTg1?=
 =?utf-8?B?T2JxWENsQk9qbHlCb3JRZitxNk9IR3BOOTBHc3plVU93TnZTb0drT0FpcG5U?=
 =?utf-8?B?MXhKQ0NwclBONDJXWGQreW9OQlArSzkxcm9YRXF3MnZnVmZ4OXpUZHBMemZP?=
 =?utf-8?B?eE5KMmNxOWJSc0VoQ09iRFl5QkJOdVFiYzZvMlN6NTdTSThUcXRFRmQzM2Jk?=
 =?utf-8?B?akwrVlA5MTFVNGpXQ245d0Z5ZlBwd3k0VjNSbldSVUVucGFMTGhmYXpUdkJ3?=
 =?utf-8?B?S2UwbHRZaWhRTWxNcGFlYVpDaWlUYjlicEpCSlhiWWs2Nm5MVUN1MXBKdHJD?=
 =?utf-8?B?ZzRmYmRZMUlMb21adHdsSjB2NHB0enpJNkxwZ0RMbmpkZFYyRDBQZlNyeGc2?=
 =?utf-8?B?d2VjUmlhNEZUdUF1ZzBaL1crYUdWNEV1b1JKRFpvVVJHRy9zaWxET3RyYm9w?=
 =?utf-8?B?VHJDcXU0dzhCN1JSMk5lbWJrUUZHWktYbmhTc2lWWWJWdjdCQUlkRnE0anB6?=
 =?utf-8?B?Q0tiTVc2aWpJaGFhbnNUakhjb0hEZnBLbTIraEVNK2xhOE56T2ZPYS9VTWJw?=
 =?utf-8?B?aDFOaWxqSWhNTW1tUHN0NTkyc2hzRGJkVkU1bjNEMHBsY0dhVmRUdnVhekND?=
 =?utf-8?B?T0RnWU5xYnZENkllL09RY0ZWbXBBM1EyTGZVTDFXQWZTZkhwait5ZEpwRThj?=
 =?utf-8?B?bG80T3lpNmtYQWxwK0o4OFRkUmVnL09MWW1wNWMzNlZZMnJwQXl3bk5MUkFo?=
 =?utf-8?B?R0YxQ1RoeXA1WHVPRWVuRnhML1pkYUFzS0dyMXpwblBUWGIyT2NDYkUzaTIv?=
 =?utf-8?B?bkxCZ2Nnd3A2RGtwNEhRVkc4NWExUEV3K2dtOHJRSmZlNm1WdEVPL3Zwckc4?=
 =?utf-8?B?MGVpb0dqTzlyV0ZHZXA4dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC8xMldiSHdjWmJGQVlocmNESlRyblRDQ3RnVjF0QmcrK0R0ekMvQUE4YStk?=
 =?utf-8?B?eHdVcis5Q2VialJLeW5RTjhRZkNYY09WV2Y3THF1SUxpL0Q2cHF6bXpWMmw3?=
 =?utf-8?B?WnJXMWNTTHI2a1hSdHd6U3ZYS3BObkNTc1JDSTZRd1lidU1JN1I3VzBsdzZW?=
 =?utf-8?B?RGpiNTFhUUM3R0FGSzFlU2FDd0EyQ2dzUXpXbFFteTlYZlc0OEhQQ2w0c3Yx?=
 =?utf-8?B?dGNySHpna2llOU5STndWVjJ1aXRhTXpXYUtWSlNaV0RhMkxGdm55bTJPbDkr?=
 =?utf-8?B?WWR5djZ4RnpKWjhtZE9wc0J0RzhtK1NKdDk2Z1FlZklTei9QZkJBNFZ0bC9z?=
 =?utf-8?B?ZGVkaXJuOWI2a0d1eWtWd1hldHF2UGZHcnV1YmxWQWdrTUMxb2dKVzNQZ0lx?=
 =?utf-8?B?VTlNR3lJSGNKTmtoZkdIM0dkQVJlbWtaK0FaVVI2QmlFeGNPcXFTeUN5dC9x?=
 =?utf-8?B?R2c5Q21CL2VORGR0dmVQbzMyQU52ZExMWUswR01qVGd2cHNkZUw1OEVCbWFD?=
 =?utf-8?B?MmcrWVZ0bCtsWmFDV1IzZE9WNVNkZEhwalBQRVBPZmZjcXFEWEJ3NDVnVWcy?=
 =?utf-8?B?eTF6aDA5YkM1aTRiSDhTZ2I0UDBUNVpWMVAycEVSR0IyeTVad2lqVmU3UEhV?=
 =?utf-8?B?OENrYW5QZ2hlZFNFYzlRUXF3MXp6TEJMMTZnR1pTQk0vVUpaOG9pcnhpUGxY?=
 =?utf-8?B?RDROUDNqZEN2aXFEQm9hNk9mZU9SdEtpUHB0MWROeDlJTzQ4ckFEc2IzbmVl?=
 =?utf-8?B?Rnk0RmJSb1N4U2hNMW9JR2M0NTdsTksxOHc3am9SN3oyUDcyazdER2NlTVlV?=
 =?utf-8?B?UXcyQVhiWUlXZjdTcC9BSG95Yk9yVTRqR1pOcUF0WTd5bHJ5RlhXQ0ZGZ1dq?=
 =?utf-8?B?TDlkdWNwb1hOQ0dCdjhBZi9jZDBDR1ArOEZhT2RNV3VkYm80aWpnc3BCQWVF?=
 =?utf-8?B?UUxqcU1KNzNlU0dWYkl1MHZPK0ZjNFlaa2padmFwaEo5V3RNK3RUdFZybWxE?=
 =?utf-8?B?UjdiSFNYT1V3dzJzVlhOUUQ1bkR3KzRZQnFFK3RNUU5jNmUxV1htbTNRVnc1?=
 =?utf-8?B?b1ZsU1o5R1VWRVFiSjZWWENDU1NGeFFCdTVjeU5DMzRTQVp3b2lLZDZEa05W?=
 =?utf-8?B?bFN6eGtwZkZpNHVHdWV4Yk1wdWlrdjVSOXNYcDN4dHVoQ1FNclk5aHVTUVdG?=
 =?utf-8?B?MXJGRHYrTjJQRHhGbU9hVm1OOGhOQng4OW9VSEVVa1JHS2RLZFJkMEl0eVlG?=
 =?utf-8?B?ZHZoNmptUHBuai9NdUY4MVJlekh3VlprTE91Y2EwV3NuazRFVTNuNTY5RFkv?=
 =?utf-8?B?ZVJVOTEwVjJ4WFRqMGlCSmYzRjM1b1M4RmQ4Zkl0bjJlRXAvWmYzYUVHNTJj?=
 =?utf-8?B?SDdvaG81blRIeTdSdTREc1RuUkhkUnVXR01JcGprbUV0b2ZPOWw5OG1ZZFRm?=
 =?utf-8?B?WTBSNDNXMmorNVlUeEoxdjdQWnRLVHRpUnNHOEdtdTNOMnRBa3ZVejFPMStS?=
 =?utf-8?B?TTNPWGV5b3ZZMCtIVlVOT1lyVmJBS2dyYnJMSGp1UDhtYTRCWVdoZEVIamFh?=
 =?utf-8?B?ZDZvSW0wVXppeU4zaUdzN05uQXdtdGF6dy9HT1c4bGoxZlhYQTY3WGk5ajkv?=
 =?utf-8?B?WE9wYkFNRFgyRzlJQy9oRkhUcVJiT2ZPT1lId2h1V0JrQUs4ME5mKzdnUXRt?=
 =?utf-8?B?OVZIcklGV3h3dnJ4dHh0azJqWEU5MWxleVJCZElFV0d3SE9MVlBWN0g1RzVT?=
 =?utf-8?B?R0R3Q2h3R2tKRGdyQkhPTmdza0hTbUo0SXhKZjZyN3FKMjR1TTFHdjVCUnh3?=
 =?utf-8?B?NWhWakhlMVdnZC84TnN5bmZvM3U0YW5TM0NhVXVQNDQvcUYwK2NEeHRoUjcz?=
 =?utf-8?B?bjdJazFyWGtZQWg4Mk0wZkZXWk5BZWpXZ3BWUFdYaGsyWVQzdzZIQjN0SlBN?=
 =?utf-8?B?WXRYbDFmYzVxL1dtVVFRL2x3djl4VjFtQzVjLzF5RXJVVE5YclFxMXBkVDFo?=
 =?utf-8?B?K2dWTEQxbm5YSkJPYXFKQ3RJM3RuTzY5QURLakVkR3JQSHJuTlBLR0N6Qzd4?=
 =?utf-8?B?N096MUlENFFaM1IrZHBSTFFUTkEzKzBOK2tlWmRWaC84c0g4MHlLOVBLZXFm?=
 =?utf-8?B?SklJK2g5dnNwc2F2UE5RWGJwRlNZamJZenhJSmJvUExrTUV2aCtXSVJoQ3A4?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df8a119-dae3-48a8-dd1b-08dcac20eae6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 20:40:56.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8Gel5m22hOKaeiKhAoS4zcCR56yRW3fdFCO9K2QN78zqgAxqY0Z0fEgRMBY5wwP228+ucLbKpsJTXY1i3lZFaYX+I1orPZZZzZ5zVTg6Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6383
X-OriginatorOrg: intel.com

On 7/24/2024 9:48 AM, Larysa Zaremba wrote:
> Currently, netif_queue_set_napi() is called from ice_vsi_rebuild() that is
> not rtnl-locked when called from the reset. This creates the need to take
> the rtnl_lock just for a single function and complicates the
> synchronization with .ndo_bpf. At the same time, there no actual need to
> fill napi-to-queue information at this exact point.
> 
> Fill napi-to-queue information when opening the VSI and clear it when the
> VSI is being closed. Those routines are already rtnl-locked.
> 
> Also, rewrite napi-to-queue assignment in a way that prevents inclusion of
> XDP queues, as this leads to out-of-bounds writes, such as one below.
> 
> [  +0.000004] BUG: KASAN: slab-out-of-bounds in netif_queue_set_napi+0x1c2/0x1e0
> [  +0.000012] Write of size 8 at addr ffff889881727c80 by task bash/7047
> [  +0.000006] CPU: 24 PID: 7047 Comm: bash Not tainted 6.10.0-rc2+ #2
> [  +0.000004] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> [  +0.000003] Call Trace:
> [  +0.000003]  <TASK>
> [  +0.000002]  dump_stack_lvl+0x60/0x80
> [  +0.000007]  print_report+0xce/0x630
> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  +0.000007]  ? __virt_addr_valid+0x1c9/0x2c0
> [  +0.000005]  ? netif_queue_set_napi+0x1c2/0x1e0
> [  +0.000003]  kasan_report+0xe9/0x120
> [  +0.000004]  ? netif_queue_set_napi+0x1c2/0x1e0
> [  +0.000004]  netif_queue_set_napi+0x1c2/0x1e0
> [  +0.000005]  ice_vsi_close+0x161/0x670 [ice]
> [  +0.000114]  ice_dis_vsi+0x22f/0x270 [ice]
> [  +0.000095]  ice_pf_dis_all_vsi.constprop.0+0xae/0x1c0 [ice]
> [  +0.000086]  ice_prepare_for_reset+0x299/0x750 [ice]
> [  +0.000087]  pci_dev_save_and_disable+0x82/0xd0
> [  +0.000006]  pci_reset_function+0x12d/0x230
> [  +0.000004]  reset_store+0xa0/0x100
> [  +0.000006]  ? __pfx_reset_store+0x10/0x10
> [  +0.000002]  ? __pfx_mutex_lock+0x10/0x10
> [  +0.000004]  ? __check_object_size+0x4c1/0x640
> [  +0.000007]  kernfs_fop_write_iter+0x30b/0x4a0
> [  +0.000006]  vfs_write+0x5d6/0xdf0
> [  +0.000005]  ? fd_install+0x180/0x350
> [  +0.000005]  ? __pfx_vfs_write+0x10/0xA10
> [  +0.000004]  ? do_fcntl+0x52c/0xcd0
> [  +0.000004]  ? kasan_save_track+0x13/0x60
> [  +0.000003]  ? kasan_save_free_info+0x37/0x60
> [  +0.000006]  ksys_write+0xfa/0x1d0
> [  +0.000003]  ? __pfx_ksys_write+0x10/0x10
> [  +0.000002]  ? __x64_sys_fcntl+0x121/0x180
> [  +0.000004]  ? _raw_spin_lock+0x87/0xe0
> [  +0.000005]  do_syscall_64+0x80/0x170
> [  +0.000007]  ? _raw_spin_lock+0x87/0xe0
> [  +0.000004]  ? __pfx__raw_spin_lock+0x10/0x10
> [  +0.000003]  ? file_close_fd_locked+0x167/0x230
> [  +0.000005]  ? syscall_exit_to_user_mode+0x7d/0x220
> [  +0.000005]  ? do_syscall_64+0x8c/0x170
> [  +0.000004]  ? do_syscall_64+0x8c/0x170
> [  +0.000003]  ? do_syscall_64+0x8c/0x170
> [  +0.000003]  ? fput+0x1a/0x2c0
> [  +0.000004]  ? filp_close+0x19/0x30
> [  +0.000004]  ? do_dup2+0x25a/0x4c0
> [  +0.000004]  ? __x64_sys_dup2+0x6e/0x2e0
> [  +0.000002]  ? syscall_exit_to_user_mode+0x7d/0x220
> [  +0.000004]  ? do_syscall_64+0x8c/0x170
> [  +0.000003]  ? __count_memcg_events+0x113/0x380
> [  +0.000005]  ? handle_mm_fault+0x136/0x820
> [  +0.000005]  ? do_user_addr_fault+0x444/0xa80
> [  +0.000004]  ? clear_bhb_loop+0x25/0x80
> [  +0.000004]  ? clear_bhb_loop+0x25/0x80
> [  +0.000002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000005] RIP: 0033:0x7f2033593154
> 
> Fixes: 080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain scenarios")
> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
> Signed-off-by: Larysa Zaremba<larysa.zaremba@intel.com>

Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>


Return-Path: <bpf+bounces-43567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE699B688C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C19A2862AC
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBBF213EF9;
	Wed, 30 Oct 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jz/IC0sR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D67433D5;
	Wed, 30 Oct 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303787; cv=fail; b=aP0q2o3czuuENPzR0kaPBZ/RuvXkLuwXevviU96/4mH0V2xhUvYf7enItYiwi644oz4oujhMF/YE1stcVe6KSJFXnzZGeKOXQNAJjWeySG7snuqykhuCZZrBxVpeqTHww31e9HdjnJW6ZV9dEUqwa6QuiyQgJUKqAKPbMZW3d10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303787; c=relaxed/simple;
	bh=+oJEdyN91VYnLiF0bFPSfZGu2enl3FqY16SaY2yQwXA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s+nYUWUDIGMfmwp1K3maP358xzF/sPh0DX8BHOsSbnkQVgsP6s4Qhw0dOL3FCCzKpNSy8Cnc8uT0qCT19GXC4ETNjlpjwChq10UvvRKWsOfvDh3r88AkF7wENGq5cYYwW9rVf5t+f1+32TFLVysNubs6LqbSFVPWnl0YEsF7fv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jz/IC0sR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730303785; x=1761839785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+oJEdyN91VYnLiF0bFPSfZGu2enl3FqY16SaY2yQwXA=;
  b=Jz/IC0sRLikn/LcS0PSIYshea/ycQynZLCpjN7/9Bfcf0uJhsNdlKz2q
   9BNX7CztwSRMld8fBPDBCWPvSLOmaryLYyEi2zbT7fDG1Ii1dH2dkhp2T
   YCG/1lVThV3QZDb7Aafzpl6z6kOQC+EbrTFs9ejzFFVLMA0szhb6SfWQx
   x2fFLh1lzrcB3vkbPNICKxcLF1afX9k8z2QJ34nt+wzUAeskzoFW//yB/
   UoTmcY0yMJWEim/2GPyAAYSESkNNTqIgBL/BuZ4L1x5kNO/Sak8WBlO9e
   WlF40ALEeFegSQgKDjSuaI7NWneaBgpu9sZXdamjDVij5ko+bO+q2PpH5
   g==;
X-CSE-ConnectionGUID: nSMp/FBpQRu5gx5g9kPQAg==
X-CSE-MsgGUID: pMo04G+CQ+aaQ064aRE28g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47476139"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47476139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 08:56:24 -0700
X-CSE-ConnectionGUID: mEeZl3pjSECZ/WlLt+2RfA==
X-CSE-MsgGUID: zjkqOSSATQSzOSsig2pBAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="113207456"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 08:56:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 08:56:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 08:56:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 08:55:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoFPKr46/6YREEI8oXA4jERYIodJZFzgpp6AXdGV5mMYaBWokk3eu56oygyU5HFXEVuyq9qJqd6otm8XCFyI/cayaQTmKsZzfSNOcVB0ahRHqjHpLiqu1OCV7PPb6bLqWEnFg6y6cjCc1xxGxVKpo0fKdr/SCBZGkGjTVnl3yhvOND0IpddWD8ywdpQf2K4+dFQpxD4RMtfQ5mzbPkShQwkY29nnzQwr4G//RL5as3bNILGylnCd3DrZPaVSQ+mFNIJUPMyijupPWtM7MLkWIjo5J1TzMa1eumoByj9CSs/YP9B730rlQbA+GXeOL/17Q7HMOAW97W0i1tETMoh3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci9li/dQsPnlOt9TvmRqGv7wonTMAhq21A/fee/+Cyg=;
 b=sdpM1emNhaeVA/DR///O/N9ozx4s8BDSSJLg3+MYRz/d0kpCSn5iTx10oWPE4ANrOw6tejgEUtsOvTryc1m6iRB1/aLKOUjjd6eEGHMk2vdPcVwIXygM32GrJIFsWIxhbbyseDC6T6qwU5jNj6E1CkNCo9gkJ8JPH9yU+YUL8B71+md/h4wFs+LsijYXgLuELn5vezkvP8a3kXN4geIhS/iLQAP84NNi1QY3Hc9Z8Qh2o4D5U4XpKYpK+8YRFxip+gBX5NVuuPDjFDj2i4BurZgbjlizHUPN1vJPDBSeEGMt6q7vFywhuHB4w1cJvEAKXtynWu+ysSFprJiuan15IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 15:55:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 15:55:56 +0000
Message-ID: <0c1f1b72-a70b-4c94-b3f6-c874c9c0a611@intel.com>
Date: Wed, 30 Oct 2024 16:54:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, test_run: Fix LIVE_FRAME frame update after a
 page has been recycled
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<syzbot+d121e098da06af416d23@syzkaller.appspotmail.com>
References: <20241030-test-run-mem-fix-v1-1-41e88e8cae43@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241030-test-run-mem-fix-v1-1-41e88e8cae43@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BY1PR11MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f7700d-00d7-471a-4f4f-08dcf8fb5732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlhuV1FwdGFsdlVWSUpGdjk2dGhiUVd2L1JiV0taeVdHT1gyVFZRRWdlQk1r?=
 =?utf-8?B?TWlnSDAvODhreDcrME1nZVNxSWQ1SStJNVBSdmVXSDZ0Z3d1dERiLzViM2xE?=
 =?utf-8?B?d1ZZQlJkY25RWE1mSks5UlRiZnNLK1FzajZNY3NaUHJxWmpXYWJ1c2FhMDh3?=
 =?utf-8?B?Q2Z1OFR1T2xtRnludkQrbnhoU1hvVkQwZHh5TXhWZlZsdGJzSi81MUdwNi9P?=
 =?utf-8?B?YkJNWWNMek9BN1FkTFBjVVJJU1VXbmUyMEU5Qm1YM1FqcE1JQ2tXWEVtZkh1?=
 =?utf-8?B?eStadVVJL2QvbmtYSkIzcnFXRTZTejdiNkhwRHhtdHJJanlaTFdMWG1JRW5L?=
 =?utf-8?B?VjlmaCtKR0R1WjhDY3lpOHdiQTQzcnBubzVPNXRaOHFBa1cvaW9zNTBSMkFS?=
 =?utf-8?B?d2tiVmhHMEpwVENGSkJodUJBVGg2VGdEU3hnSUw1OURhKzBoY0pFTUdRbURP?=
 =?utf-8?B?dmI1TlJEMW1FVnRiOWUrV1ZIYllmMjNBb2Y2a1FhUHpTR3Zld1RHaXoxNVlY?=
 =?utf-8?B?WWRyenZMdEQrK3dTNTdoU3ZGenJhaTNHU295L013YkdkSHZzcUN0Q3pDRk5o?=
 =?utf-8?B?SzBZV200VnB2QzlLSTlDNTJVSTVLNlFzaVo2MGpiaS9HcVppalBidjBHakhW?=
 =?utf-8?B?WVBvbytYK1pXRnJ2SzhaNExpQW9EOHNiRktjTmE5RUFsUGl1TU5oSmZLWGRO?=
 =?utf-8?B?ZWV0T0ZCb0s1YW5IU1oybHdzaEpuWjR4WkZTRCtBM1VNUG5oZmt1WGRBbmFL?=
 =?utf-8?B?aDhJMGg5WlE5RUxBdGwvcHV1QTBqdlNUSlhEQW1aTC9EWU1GSThwb3ZVY2dV?=
 =?utf-8?B?WFg3NjVFUm1wTlF2SkNpV08za0VtUWNQTUwvRGlQZXhDOFE3TmlrYW5Ob3hH?=
 =?utf-8?B?ano3UnMzNDhWMVZYQWhnVEt4anFtTW83cFdzemw2bkFESE9XR1hkVTMxNjJE?=
 =?utf-8?B?QWxpczBDRmdQbUs1OHJsY0lNNmRYNEVadVdBSUZUWkFlMzhYZWIwTjkzZEE4?=
 =?utf-8?B?SDRXMzhYRTRqbXlHYWo5NVdxM3pnWDBZUE5mSDY3U2Y2S1VINnFscHlJSHFV?=
 =?utf-8?B?N0JGOWF4S2NEQlg1YVB3VW80Uk05eHZ2SW1ub1NjWXZaV25NNnUrQVlOMTZq?=
 =?utf-8?B?U3YwT05nbll0d1lsNVloVzAwOUtrNlVNVHNWS0EyaURITTU0THRENzZMcjR4?=
 =?utf-8?B?N1ptTXh6dzVMcFJDdzlzeVFrekV6UUdVV25IU2xWSWZJV3d5eXJKemVRc1M0?=
 =?utf-8?B?RWdJcnF5SExVWVdvUmkyd1BNOE8veDZRUHYrQmhxdjZmaENpMjY3dWxpY0h1?=
 =?utf-8?B?dzJ6ZTVNZTd0QWxKNXBUa2VCRnRRelNZT2JpRFlndmt0bEttbThjWTNOaUkr?=
 =?utf-8?B?NVJWV3c3ZFo3Uk12SHQ2ZzdDWkZnRTJ3cVBKM3A4TlFxM2swT0FZQyswYVdC?=
 =?utf-8?B?a0RZWHFqdTh2OWdjRG5wR25jUEhnZ05jOUxYVi95RkNhZlJydTl5WlpEUVhU?=
 =?utf-8?B?NC9Pd3VSaWRNZ252S081VEpwSFlodXB2eFdkaTFLOWhlQ1BoREM0eXRmNWpO?=
 =?utf-8?B?SDF2KzBrZGdkczlyamllNGU3MDVaWXdBRjZtYjZ6MjR2ZVpUTkdZUzZoc3o4?=
 =?utf-8?B?NWZRZFBTZmQzak9vYkFhNnB2Wkp3cnNmS3hmS2ZQTkxFdFpBbml1aHpBb2J0?=
 =?utf-8?B?L3EvTGNYdjR2Ty9OaVJEMmZZT3JmTk5zZFhoaSs2RkUzWFA4U2FvMHdWOW1I?=
 =?utf-8?Q?ov8v2Yzx2U+GyVdjeLtBqyd+0Sgdg+B/y2yab6u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWtuamhOWlY4eTZiZDdNUEhQQXI4aHpGaVdDNlRwczdGMFZiaFJFcVBvZGZp?=
 =?utf-8?B?a21TTXNqdWFiN09wRlNaWWNaODdrUGVUYWI5SWxJWlVlK0diN0xQK0hjY0R5?=
 =?utf-8?B?Qzg3cmpzdmtTci8zZXZQTFIvYjdmeTQ3UDlpdGJTbm4raUlyZzF6MUljcTA0?=
 =?utf-8?B?dm5mK2FxVkpaMzZzaGk5dkcrTkQvVlFqWDQzL3VzUFdBM0JUR0xNUm9yelU3?=
 =?utf-8?B?WDlURXNENk9RMUlBMlRHQnFCcUxFbWRXb3B3bjR1Q2NMZHBKcGR5ZzgrZjlR?=
 =?utf-8?B?bGliNjAvK1gwUHVlb09icTYxbFltdGIrSHVSaTRycWxlVlBhbDU1cjVRRjJQ?=
 =?utf-8?B?aFEzcHA4Vnd1SDhudC91TnZGZmtOc1Z6RnkyeHVXTnYzWHovS0VhNEE2ZnVV?=
 =?utf-8?B?eHhUV1ZBbGlUWDVhWGpqb1I3YWVpeDV4RG9zR3FPNWorUVcrK0NSK3lLblkr?=
 =?utf-8?B?cGpJTFVia3czOVJpQlArL2tTUzlUVlp0V2pvb0tsMjVhZldYcTdxTnZLWUVW?=
 =?utf-8?B?bUJhcWdNUExvdVlGbHVSaXgwSUp4a3hPOWg2NEFaN3Y1RURVY0dndXozMmxn?=
 =?utf-8?B?SVJFbVg1Yi9IZllmcitUbU16eDRtL1hTcWFiYXJGR2x5TjJpMFZ2UklnaEQ3?=
 =?utf-8?B?ZjJrblpHT09rWGJ2TGNCWUdYVGpsU1pUNkVQSWpHSVJ3cEg1YmRSeit3NkhB?=
 =?utf-8?B?M29XcWN4dlI3aDBHZkppRXdHNXh1ZlRvcytpK3hpalAzVUpQVXFoTDVaaFRU?=
 =?utf-8?B?WEtsTWtvaXhreUlwVFE1NEQrWTRkMDg3MGxhUFNNaGoyUUtheW1Wa3k3S1dm?=
 =?utf-8?B?b3pFT0tjSXdFZjd6cU5xaGo1SG4vbzZsMGFBUlNmTWFNUndjRUdidXJIM244?=
 =?utf-8?B?S0pUYUcvc2J1NXBCT0NNRk50L2tBeFVNS2FSNXdIYlViMng0dXF6RDNGUlEv?=
 =?utf-8?B?VGIwSG1IU2ZzdW5xNnRFaEVLc2pzNVhaNHJCaXp0dkU3MU1SM3ZZaVRyMkhW?=
 =?utf-8?B?WUlObHlCdGgxN3VWOE1BODk2VlVYSCtUa09aeU82K1JmbnJnc0VDSTk3R3pW?=
 =?utf-8?B?WHlURkVHMUNQQTdmbzJXSS9ORHRTVTJxTFJURFh6YWhnUVhhNzFDOWQ3NU9p?=
 =?utf-8?B?ZHpjTFBCZXEzT05vcVd4S0JmZ2tQMTkvTnVSdjZnQUFEb0FzWUZHdzdROW0r?=
 =?utf-8?B?SDl3YzJFbHlnL2p1VU5DN1lxeW1HN055cTVjMHNudVhjV2JXNk9qeE5naGRl?=
 =?utf-8?B?a2tsVC9iKzF1ajhoU0F6WXhxQlMrMDNGbkp0RFV0YVZsTWF5bFFpeDdqT3N2?=
 =?utf-8?B?dXJoRlRKU0xMMDhranhSbC8yWTRSektTSkZQOFo1aGk0VTE1VDd2QlN5V1cw?=
 =?utf-8?B?TExPem84MEFYcDYyK0hOeUw0a2Nic0RZVFFFRTRkV3ZEV28yTGRPQlM2a05H?=
 =?utf-8?B?VUZpc1pwYmpjRWx2TG1xZE1KRkkyTEZ5L1A2by9rQ1M5UElUTFlzOEdJU1ZM?=
 =?utf-8?B?cmlwYXg0MkZCN0hnUWUyclBsc05JRVNvTzlHZW5vZk5MTWIvVW9QUFhPMHht?=
 =?utf-8?B?VHlXR0wwUGJkcTl3KzZKeFN0NEUyU1YvaGgxSW5iWVBJT25EODJ2MlV4OXJL?=
 =?utf-8?B?ZzJiaWYraDEzeW9jYVdlLy9TUWUyalh5VnEzeWtjbzFmWVBPOGc5NmJPd0ZR?=
 =?utf-8?B?Zmp4anF1QUdxV3hERFF0Y3JPUnpnVndpdTJyQitOSmxhcFZmanZXWkdkN1ZV?=
 =?utf-8?B?NGxidGlicWE2cWRhaC9YWmpYekhRaUthVzB5QXhzd29mQ3p3ZUNIajNKRnRH?=
 =?utf-8?B?U0lmQmNoNXgxTGxrY29EbEh4a2IzMXNQSXYrbzFUR3N4b3ZuSGFCRGd4eTRR?=
 =?utf-8?B?OHNHSlduU3dmb0hub1VwVko3SnlPQzJtRGlHM3lFeFN6NEltK1NKQ3VxTUty?=
 =?utf-8?B?akFHN2dIY1FaVkhHaHFFcERNZXRQVVJXT1JkYUFYYisrcVZsSmdWUmpaYWox?=
 =?utf-8?B?NHRwcWt3ZkpIUmdqbGNrc2drNE9ST2J0aU5oRWF3Y2FaSVJ2a2Q5V3pMVzZi?=
 =?utf-8?B?akU3MnJxeUdjTkd0TXRhY1lpdjlwMkkyVUcva3ZXQmlpUlVDRGxoazNqOHBk?=
 =?utf-8?B?cWtLVnZXN3dNRkNzNU14U3d2K2tzQkxsMWdXa3pZR3hWTDlYOEhXQmdwazlE?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f7700d-00d7-471a-4f4f-08dcf8fb5732
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:55:56.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F3ieKIOXcU7SF69rfLAgRvEb4bLvkC+7bciD7wewATv/2qh1BJHRfYfHRsrKS/vLWMQr332fF5CXVTJLYaBWoawP8/j8OTukSaFKElaV8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8080
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Wed, 30 Oct 2024 11:48:26 +0100

> The test_run code detects whether a page has been modified and
> re-initialises the xdp_frame structure if it has, using
> xdp_update_frame_from_buff(). However, xdp_update_frame_from_buff()
> doesn't touch frame->mem, so that wasn't correctly re-initialised, which
> led to the pages from page_pool not being returned correctly. Syzbot
> noticed this as a memory leak.
> 
> Fix this by also copying the frame->mem structure when re-initialising
> the frame, like we do on initialisation of a new page from page_pool.
> 
> Reported-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
> Tested-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
> Fixes: e5995bc7e2ba ("bpf, test_run: fix crashes due to XDP frame overwriting/corruption")
> Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RUN")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek


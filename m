Return-Path: <bpf+bounces-70194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67ABB3F11
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 14:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32231C2862
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CFA3112C5;
	Thu,  2 Oct 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG6l3X9g"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D930DD20;
	Thu,  2 Oct 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409680; cv=fail; b=jgPYi3+FXl039zH1vKCxTpzMxtT7TW7wgHw4Ycb1PFHXlDhRbpw46/6k7MUf2nTrqS1xPFzWWXGU60sGQw7+cTxo1j716WQAf0tABWj+o/INgq5xyJ6svEH7ZT3ZuFZVp1OT/BpNQ9BhPwbTZPTXrY5Qy2QE+ieN8tYka3PkaOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409680; c=relaxed/simple;
	bh=aQM6xz4fwkjOZveXcIpcDKXn9Iy8FrORJxB5dyoLjO8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H8dEH9TGywSvh9TIxUAW6IXNmaUDFliIUnTSOgEcDf9eOz3IPZyjTQYVk3LsT+/o0N4XFU+CS6cvIRy4Kgxl+iXci6sfp77HM45R43beNX9ZS6gCmUzALEUtKzGtoR0qk8uxj6mfEZynRGlpJpcdeA2SPJwgXQGIY+vLLFHS4CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HG6l3X9g; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759409679; x=1790945679;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=aQM6xz4fwkjOZveXcIpcDKXn9Iy8FrORJxB5dyoLjO8=;
  b=HG6l3X9gpqgvQxPAa9fKEmVHZVa/ail81BFlzoQ27J0DQodKpHsJ0bTo
   A9j7mIQq5cXu5UuWksHluSOlhVkNAo7+40wQ1JhHt84WOksFeRkDJY6Cp
   W1rSXu18gU5U1ysj7EHPuWLUhxV2qHwhCx/Uk/iSM5C3qGgq5oZ+d+0b+
   BBjgHRa9QAJ8x/urD3KBiOzE1nmn/RLpPGc//ASoFdyl98YuzJwe92Q0p
   aszKBSsT52ToRbtiHIpm6jeZ/VON6JV7v0MMOKbU3o1V4QwL8qZt7npbG
   gTwUbqXgO4LWYci+G8ipCvbDnhtYTjTS4HWcXDuCeoPA1DFx5MOhDU1/7
   A==;
X-CSE-ConnectionGUID: ED1sGmAXSjKnJy12OkheHw==
X-CSE-MsgGUID: tW6I9By3QO62a55ptJ9NOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60902215"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="60902215"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:54:38 -0700
X-CSE-ConnectionGUID: q/bggNWUSU+ZyJ+ZIoP44Q==
X-CSE-MsgGUID: Lk6UfSrpTMedtGTUR3gL3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="184328267"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:54:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 05:54:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 05:54:35 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 05:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJqYMKrIK2ClV63oBSOVRhgXgK0jhkcY05DdPqVl86Mcp7pzmxjjc/7nZFOrXilsmRfpQ4aCdAAH37Qqxr1oX4moiDDN2ILa4OTYHoE2+8GXGzW2jJzHC3kG/+Usg9fL6uMzZgkbkjN1AFx/5YCjBY2Kz3lx98KKbxNQECgNBbmnENvAend4jc+8hiYhQ74f5WIzaXyTdFKYPgl/vfxGmEHjG8Ryw8j2rBfoIK119AQEgvr0j9QWGNV0mQK8N8rvf999J463FAqpkHnqadRFbRSXMqBubzFfr2nj4hJy0kgcqbtUaXUp2g7gVTtQ8GQWM9ucunwf1OLdYG05p9Et9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ft5fFwY7f9NM/maAx9TeMlreAz9HgoZDJZd82v2FZU4=;
 b=ilUyateFTyR1lmaht4DqhxYMu1yRtxAJqLnha3raOe4ENrTY8HEqGq85enw7LOkzyjZHktbhDMdT7UC0ULRAoyJV+fxZfByE+AKDZ9I9vIwU4Ay5dnc1t337jQ4GDo+DZlo33QN+7GuGxyl2LOhNq0H01Q06Ewwf7AOyTmfbcjuuPdatz2t4/hjTQufq5ahtoUI4fWOAFb+PUkb8g8HQp7sGRe/rSYYQ7/RfhUjkVdD+xrplDfqmL3TLBiXh70gkFRJnmFmWJFaMvCwDitJ1PUUYlfJAGfzdSeKLF+gR+4glUF2dbOyJSRH5TYRuf+gO716yYroEVZO0ul8lRrb1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA4PR11MB9394.namprd11.prod.outlook.com (2603:10b6:208:563::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 2 Oct
 2025 12:54:32 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 12:54:32 +0000
Date: Thu, 2 Oct 2025 14:54:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Octavian Purdila <tavip@google.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <kuniyu@google.com>,
	<aleksander.lobakin@intel.com>, <toke@redhat.com>, <lorenzo@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
Message-ID: <aN51q5TeJV5R5x04@boxer>
References: <20251001074704.2817028-1-tavip@google.com>
 <aN091c4VZRtZwZDZ@boxer>
 <20251001082737.23f5037f@kernel.org>
 <aN17pc5/ZBQednNi@boxer>
 <CAGWr4cSMme5B-bMc+maKccoYxgVeVKaXk7Eh=SOM7jX3Du5Rkw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWr4cSMme5B-bMc+maKccoYxgVeVKaXk7Eh=SOM7jX3Du5Rkw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0301.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA4PR11MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cd4997-a7ab-47c9-2dc8-08de01b2d4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE1razg3SWxVdkpROEcyK0pubDhRS1J2REl4THFXMXR5RGlTNDEvM3Q2MkJN?=
 =?utf-8?B?bTZDUmsybkh3U0JuTThscVphaGU2N0ozZ21weHdub0ErNVNBc1gxQ2NBOWVE?=
 =?utf-8?B?WTR1S0NoK0VJb0tZUlhCR1dmOXR2MTB0aWVPNGkyV2hZb0ViT2lYMFZnaUNt?=
 =?utf-8?B?TDVvSHlQbWF0YW92UWxqSmVKYVk2RDJKZ1lxOTF4NEJxVTFUS3lNZkVOcHNO?=
 =?utf-8?B?QUwxRkZTQ1NJU0tmMGk1OFB6TzZ1Q1FvL3kva1lNREg2cmY0T01vbW9uZVVH?=
 =?utf-8?B?VkRUQ2NHc0JwM3FOUUpUUU5HQzEwa2E1U0FlS3lUb0hnampQREdIVUNTS2xm?=
 =?utf-8?B?Z0ttWHU2Q2oyNUk2bGgzT3ozZ09WblJVK213UUZJTU9vRjZIdDlIdURwa0FK?=
 =?utf-8?B?YlBsNHNKWFN4SS8wRU4xbEQ5Qzc3QmRFTjhDL2dMZFdMd083UzFWaEtzTk16?=
 =?utf-8?B?WVN0Y1hPRTMzeTBuUlpTZ1BJZ05XRU11MHpRTU8zV2h2MWc4d3FYRE5mZzR2?=
 =?utf-8?B?aEtQOURhSHBqelFqWUdJUWM3OVJFK2NVRGNHY2dwdjJxZWNrNWJuMkhOTlpN?=
 =?utf-8?B?MnZCVVUraWhCMzhpbGxKbmN5SjdQTWFCR0ZiZ2FrZnJVdGtCbDNpamVMaTVX?=
 =?utf-8?B?b1doMitiOGx3ZmlUR1JRN0tXL2tpVm9TaDhuc3JkMkdwNUJDZ2tyb29WeDJq?=
 =?utf-8?B?eVg5RTlSb1d0UHlBUjV4RnVPZGtMb2ZyOEw0OGc4ZERHaTR2cCswZFFoNTRq?=
 =?utf-8?B?ODM0aklJMHYzaXRpSEVhUnkxa0x0ZDZUYnpLYjQ1UFFJeDlNNlpZd041ZU8y?=
 =?utf-8?B?WWxqTU5RbU9NTUJxODdVTkovQjlBL3pDcU1xbFF2djJvcDJ5dlBYRVlKSHhm?=
 =?utf-8?B?blV6Sk9iSkozMDB5ZHZBT3dIL3cxMDdnVTlzZHhVelNadzZ3YXNiOGlCazNs?=
 =?utf-8?B?SldESk95WFd4NFQyaDZkeDY1QllKTzdmRUl2bjNNY0wzNjZnVnU3Q0t5eFpn?=
 =?utf-8?B?ZXB4OTNMTU40d1Nvanl0TmZJbUh3WkdWbGhaVUh4UGJXRVJtQ0w4cUM5R1ZG?=
 =?utf-8?B?SmpoakNNUVpUYnE3S2tkbk5Db0VTZ0xsdGtFS08vZWhnclFOZEZNRUgzZ2Fn?=
 =?utf-8?B?NlpTVnF2bzdienIremZNN2xOTk41Tk8rWUh6R3UvYi9IQk9uQWpJR3V1aGpM?=
 =?utf-8?B?SW5lSUg2WnU4TWZSa0FwdlRLcEEzcm5IRGl6aFpOekNPMWVCVGN1aDFOakU5?=
 =?utf-8?B?RHZCL05VZGxmejNYaTF5NEVnWFdnSE1nblBnNEdXTlNXTU9mL0xkdjNQcTlD?=
 =?utf-8?B?Q2VMeEE0b3BoM2VmKzZueUhWVm80bmlNbmFrTERhbFRZazV5ckVXMWVNSHF0?=
 =?utf-8?B?Z1ZEU09YRUpmN0tqSzZaQWdydk1UT3Y2M05YL05Vak51Ti90dXROYlhzSWVs?=
 =?utf-8?B?Q2llVmxiLzR5c3Y5QW9NSTZ6Q2x5TFdsYktQeituVnZMeThwWER5Vm40cG55?=
 =?utf-8?B?ZmNGSjF4N0IzbkZxckZQTHhRS1BxV3NVYzErWGhmcVpRdnhtYjVNWGhaSjVQ?=
 =?utf-8?B?ZmFtNmlNZEFZVnhnRCtuWGlodmxmWS9NVUdCckdIZi9aRnRra21iQ3YwbmdF?=
 =?utf-8?B?UldlckNIdGtnRnErODBFSXZFV2xrZlZNQ2U5ZEo4RnZaZVRCemRBQjRZMmRr?=
 =?utf-8?B?VFRWbzZuRXNJTXVZZ3JBcGxIaGRXRlZ5NXYrWTdtdkkydHhDWFQrd3JxcmpP?=
 =?utf-8?B?WE4rcnVnWHRacHdVbExVcVNHRWlWbGc5S2xJWnlFcEIzYlRtaWtFSkRlem5E?=
 =?utf-8?B?VStkU1ExL042cTVPZDFUY25VM21yb2JMbEhqMVBxRXh3WUlKODI1NXVjN2FO?=
 =?utf-8?B?MERodlRrWTdaYkdlY3lnUWwwSVpCU2pEcllqNmhkU3pDTktCemZJVTl2Mkwz?=
 =?utf-8?Q?TZ56PiuMX1uC/6XfWAmj9cmy2LuuTJn4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhkZmpBVGlMUU45cjJlSFVBMTY2cmRVRmcyeWtGTUVSeDAxUnFMVXJQMXFl?=
 =?utf-8?B?R05OdGp2dFBvWjFyRk9ITFVCcCtLcW9lWHUyUDVuc0ZSclI4ajIzOHVvUXBP?=
 =?utf-8?B?NE9walpaUVYvdzRlTnkrUFpEczlETEhyZG10ZnRxa1A5dGs0bFZqcXcycld2?=
 =?utf-8?B?ciszSE5TOWMwSUE1NzdNNVdvMks5Y3M1U0g3eCtKS1c3Zk15RmFTNnZobFZH?=
 =?utf-8?B?cm9xQWRXNnNsZkE5VEZQOUYxMGsvY0J1bFVMT0wzZDdFb0lQRVQ0bzdYNmsr?=
 =?utf-8?B?OURpc2tkaFhEeHVtWTdBOGRxdDcvQitnK1NZVnQyalRPNUhveFppV1JYZSt5?=
 =?utf-8?B?eHFUQnArQ3FrWXJBaDI2cldwdHlYSTkvNllQcnA2bGJSQlYyd3luZ1BzdTdX?=
 =?utf-8?B?SC9lcHlSTkJRcjJ6K0R2SHM2b1Q0cS9FazEwcjc4VEZXN0FwK2FIM1NDV0Vr?=
 =?utf-8?B?OUcxSzc3K3ZnUmR4ZDIzZk1YTjdrSHRVOVMyVTdpV2xqRGFOV3pQWXhFL3E3?=
 =?utf-8?B?VFBER3dhL3luZXBlZWZocFc2TFRuM3JLMERQT3dTY0xLbkFGUEVjcmFGdlVX?=
 =?utf-8?B?aUFjdmFuSEdkbWZTcEN0RGlkVkovVnpWSTJPcC9FMHVvWkJIL3EvYlZPeGl3?=
 =?utf-8?B?YlNuWFlvbjZWYWNWbGVvRHFaMkR1SWdGVlJpZlIzTUd6cGhQMmVJZG1zbFc5?=
 =?utf-8?B?KzJTU2t6cUl2YnZXZld6dm5zSjFDeVdGRXVhYVNPdHFQbVEvckUxQjhrK1c1?=
 =?utf-8?B?UmRrMnJUTFJLS2ZIc01JVTR5Nk9sekJMdUJKaFBVeE56NS9ZeW5vSEN2WUhX?=
 =?utf-8?B?UnRUNjdaalN6R1ROREwvWlZMMFlHTDE1cGhYaUk2d0Myd1JFZGM2UFZRY1E1?=
 =?utf-8?B?OXB2MVlxVEg4S0I5Q2lzWGpEK2t2bk81akRKZWJYNllxcFZxRVQrUXkxOUtt?=
 =?utf-8?B?Q2dJSExlVWd4Ym1yeENoRklXZFZWcGVlZzBtSDVSMndqNEEvMkdvZS9mcThL?=
 =?utf-8?B?T21QVCtKZFdsa2VDTnJwTUxoQjhxWjBpU242cTRzWmlQRlFseDR2K2RmT21s?=
 =?utf-8?B?N0hRdVlSSU9iQ3hVbzNmRjdLQ2ZPNlVGK3RuYWt6L1VkRHEyclFsZHZDbG1R?=
 =?utf-8?B?RkZwaklZMit4UmhZbjJhU2FEV3R4eWl4Wmk3b29aTnd0QXhKVkNJdHdINzRR?=
 =?utf-8?B?WGVna2trZEcvNkpCSGVBSE9FUldlbFhTRTJabWo5a2FtSTJqNjJoa2RiS2Fw?=
 =?utf-8?B?Yk42MWh1NXduYzlBbGkwUWYvWFl4cTQ0THk4amQrY0ZMTFpaNHlpb3RxMEt3?=
 =?utf-8?B?TDd6dEtxczRQalFOTVhCK1ltZTFaNGRmU0Mrc1IvQjZZckd2bVNZVzVIUWt3?=
 =?utf-8?B?YVFhdUpOK05oY1hSd09GaytPNC9LdW5HY2dYeGliMDBYMW5WK2l5OStxQ2Zt?=
 =?utf-8?B?VXRpQmhKZFBGWjg3ZVBJVlFEcXRhTHVRTjFXU0hXQ0g4TXRNUmtGOWlnRjVo?=
 =?utf-8?B?SjRNOVdBNEJ2Rk1tQ21GeW1SYkU2K3Z1eHVwSkcveTlpY21JSXhhSGhZZHd5?=
 =?utf-8?B?MVpKTWJnODZFL1pZYWREYzZpQk5RM0UvUWpSYjhYaGdtNTlKSmRBZEYvNHhl?=
 =?utf-8?B?K3N1T1BuazBKNUJaTlZQYTl3bkkwTlB6Um5jT1R5c0dVVlg0dDQ4S3lUYWRL?=
 =?utf-8?B?K2hNU0lnRWVqMkIwd05VY1ZYMFJYc0dja2NqNzRoUWh0eFg5UEYzQ0VVRisr?=
 =?utf-8?B?c3haVDUzbGtUMWxZRzhUdlFVejkwdi92SEF2aHNKUE4yUmdUSDQxTUhjQlo1?=
 =?utf-8?B?NmtLd2VNM2ZBYzd2WlMxazVpdGl0SWd3UW9ISmhDaUVsYWdOUnhZdGxhN3VI?=
 =?utf-8?B?enhVSldwRFRaSVB1OXFiWVhzRDE5UVhDeHlwcHdwWXJEeVR0Ty9yaUxmZ0di?=
 =?utf-8?B?N1JIR3JDOGVMUk5aS1l0dDZoMFp4YXZZQ2F5TE55R2cvTmJpTXJmdGxyZ0k0?=
 =?utf-8?B?RlZtb3U1UE9VMnBIWEwzUmZNZER0ZTFMVnNpa1BiQmxNcXV2T3htN1ZtK1VO?=
 =?utf-8?B?MWYxQXBWMElsZ0duV3dYWWVwYjZZeERSTlFpZVBPWGhOWE4xVnFLVHJ6TU9m?=
 =?utf-8?B?bllqaHAwbXUwY2orTi9RdkY5bWdIZjhsbDVtY1dXVFJkeDM4TXU3OGtwZ01z?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cd4997-a7ab-47c9-2dc8-08de01b2d4e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 12:54:32.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8V+OJ8YRVWB9MDJ4KbCPNQAPY/RhnbheJZIQD0iUOUGNmrP72dOVfK3sW9S1UTULegBn/ugj957eAQOlCOVbGLswvzAHd+Ur0bEgEBnuuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9394
X-OriginatorOrg: intel.com

On Wed, Oct 01, 2025 at 06:15:25PM -0700, Octavian Purdila wrote:
> On Wed, Oct 1, 2025 at 12:06 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Oct 01, 2025 at 08:27:37AM -0700, Jakub Kicinski wrote:
> > > On Wed, 1 Oct 2025 16:42:29 +0200 Maciej Fijalkowski wrote:
> > > > Here we piggy back on sk_buff::pp_recycle setting as it implies underlying
> > > > memory is backed by page pool.
> > >
> > > skb->pp_recycle means that if the pages of the skb came from a pp then
> > > the skb is holding a pp reference not a full page reference on those
> > > pages. It does not mean that all pages of an skb came from pp.
> > > In practice it may be equivalent, especially here. But I'm slightly
> > > worried that checking pp_recycle will lead to confusion..
> >
> > Mmm ok - maybe that's safer and straight-forward?
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 93a25d87b86b..7707a95ca8ed 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5269,6 +5269,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> >         orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
> >         orig_eth_type = eth->h_proto;
> >
> > +       xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?
> > +               MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> > +
> >         act = bpf_prog_run_xdp(xdp_prog, xdp);
> >
> >         /* check if bpf_xdp_adjust_head was used */
> >
> > As you know we do not have that kind of granularity within xdp_buff where
> > we could distinguish the memory provider per linear part and each frag...
> 
> LGTM, based on my limited understanding. I can also confirm the syz
> repro no longer crashes with this patch.

Would you be OK with me submitting this fix and giving you the proper
credit?


Return-Path: <bpf+bounces-54817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4536EA73309
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5A917C1AD
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925621516C;
	Thu, 27 Mar 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUEcPMFP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB2749C;
	Thu, 27 Mar 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080749; cv=fail; b=gcISZJNUioJ/onI8MZYCbD1xWu6XjIqhZhOQIhk6T97kM8jsGGKgQuHMMSNO0lSXnzs/Nv/qkbFi+NFQtHxblMYDh+ukuiOMx9mhD8bWJvrhNlbK6wytGQ8dPQ00HX5bMeWB6GiqDJV1G3zQtEDAbQzAZ1f9pZhZGq9VZHF+y88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080749; c=relaxed/simple;
	bh=ud8yfP1PQG0s2OaO0hrG3ukPKpeEq3JGF8z5IIM8cNM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r/+ydMd8z2VrLs2GWy2tSVw7uGtHB+I9ww7mLeAdbFGXJFHj28EZE7HkrsLVZIeTv7rF3FDE4OKpDGECKpFujP6cTsuZxPzH21CV7aSlgmInvN0tRdtlojEKVnfeK4URLgx9an3yYnMR/xLD6UsfCs28NVSUvyeeEX0VCneLQJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUEcPMFP; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080747; x=1774616747;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ud8yfP1PQG0s2OaO0hrG3ukPKpeEq3JGF8z5IIM8cNM=;
  b=kUEcPMFPJqIaUBwwT2/P2cMsVVnK4WFkvWcD55/ygmyfSVQ0T0jH/Zqc
   X5VFyX782fBptgQ/AF+hVFsiH05AZ3d8KmpeQI2t5KKdOg/l+lPcVUqSN
   pFlRATucKZpuhZ0Yv+DF5wvJEy0G6GRapW0Yzsa6YRLbvRGPbpshhq6za
   MuKbzw0KwS8gpDf4gu/FIAuha+EIIFRTiW7+4VsUlOjrScaNoC732Nw1I
   0voi9ZsmBfE22qwgXVW35hSugE0QmtC+8OkU1YX0ylZlCSII4ylTEH8Fy
   8ntnQmVS+LJV/J9EWO+eDAXGtbfq5jgoz7wnuueepRoqWBJuVDym/DfOo
   A==;
X-CSE-ConnectionGUID: UNddOFbbS9KWdqMIviOImg==
X-CSE-MsgGUID: /Bo7Kx2iRdOp12t5k9Hhxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55066995"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="55066995"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:05:23 -0700
X-CSE-ConnectionGUID: +qvcG+8ITz2geNr6rbcPsQ==
X-CSE-MsgGUID: iqiYC0DVRjKgmeOQgRXwWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125582693"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:05:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Mar 2025 06:05:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 06:05:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 06:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZXZDgfx+eJdaydzFbwhqt4m2XpRkkiQVK2i+0KVshhDxp/n1FxXFwMSAPOlGN/o/LRaEPIqAm/d80WMU9v9isxKwe9m1ceLswJOW+5OSbE8N9KfpADSxOBpPlOn0cxk1b5Fe2/P8eHz76SaAfk2qDlpPJnH467Wqg+rdZouJNzbnt4+11omHnkRgjhrCoL6c1ITc6cyMAIlwSgGNQXhv/q7ds8X92JIs6CtOwQTM3d48PQLy78GjPrHdiTvjx8EF8ss9IJ6q56/1SjgEwTNXugYZFvUj11i05msrQvkFQyMb7nS30+tJv1d8MtOQGOoE4NjgK8CTlwBpujotMriqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6Ac04rSjkpN8RhF7hJx+uGP3dvg2Lws38ZM8Tvr/hk=;
 b=BNTkmswxWOUlmtIx9JL8Kju7SjHtFd53WEToP0NdHJFgVNbjKWCUOxM4j6LlWkFTXsb6Cub2hQqjsLGLMqvoESaO4VLFayL9Tu1jgWHFVggndqeObA3Wb2t3gadv0eysoTTO73vX+A/0OSmlwY1g/xe30lY6iCVilELnHmzn8TkxF2dC57FgvvfZY8BEZ6XTaxS7mWKiw4q0sQD4ciO53WjZwgDa+TX7xhh/aRVCwlryz7AZQrtywT6Mg0Dv+8o/PHjN/N1X2F6wuAf686lMq6IVFSVGwkmyzLPDM4tNY1on9WNgKcunnUF29JRicPGd8PII20jyW9wdmY8rmjf0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) by
 CH0PR11MB5217.namprd11.prod.outlook.com (2603:10b6:610:e0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 13:05:08 +0000
Received: from DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018]) by DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:05:08 +0000
Message-ID: <48e29601-0b32-4a3f-9040-629e701fb735@intel.com>
Date: Thu, 27 Mar 2025 15:04:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 13/14] igc: add support to
 get MAC Merge data via ethtool
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Hariprasad Kelam
	<hkelam@marvell.com>, Xiaolei Wang <xiaolei.wang@windriver.com>, "Suraj
 Jaiswal" <quic_jsuraj@quicinc.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, Jesper Nilsson
	<jesper.nilsson@axis.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Chwee-Lin Choong
	<chwee.lin.choong@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Serge Semin <fancer.lancer@gmail.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
 <20250318030742.2567080-14-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250318030742.2567080-14-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6310:EE_|CH0PR11MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7581a03b-30d7-4402-3d37-08dd6d2fffde
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkFvZC9DRDBZaWVTcWhiTHdyc295TklRcmk0T2J2ZlF1YllvdjBud1dpOW5r?=
 =?utf-8?B?VGlocjVMeUl3WkFQaitHRjEwNUFGSEtiRUlCaldHZDBGa0Y2eU9IcjJxM3pS?=
 =?utf-8?B?bXpXWnRNM0lxUHF1Q0FIWWtkZE1BRnltY2FRWVpMVkFOYWsrVDVTZFp1T0V0?=
 =?utf-8?B?eFFMUTFkWjIzaXBjRWROK3lVWG5hc1lMbGxxUlY2ZWQ1Y3lYRVV1UGtzM3lF?=
 =?utf-8?B?a1hNekVIMXZUNWlJd0hhSm1tUkgzRjBURFpTNSsrTkYyaDlHMTh4eW9aN0Y5?=
 =?utf-8?B?TGR5MFBvc05OYUJ0NkdMNUY0bGVTNTlKYnZNQ09nOVZ0MVRPUDg3dHNQVFVx?=
 =?utf-8?B?SmZsQVlEalA0VUR1YjViYVNRV0RUMjFGUU1LbjJaYUFabHpseDQvZWlkMkhI?=
 =?utf-8?B?TjNla0NNait0SzV5RFdibVlVc2lKSVhGRWZWOW9UVmxJRmllMzFyKzA0elZj?=
 =?utf-8?B?Qm1KWC9VNWhmQ0x5N0hMZ3Z2VnU5UjlmaDVnSzJXbGNjTEMxSFM0SmI0MUZD?=
 =?utf-8?B?M0l3b3g5U3BvY2x3NVVrNnN4VGVwRXpHVEZPY0dSQ2c3QmllbWRLMjZNUE12?=
 =?utf-8?B?YUVJT1RTa1E3UWJPSEhicmNOdUUzRDZGdjFtSXZJU2RRZTBZbFRiMmhzTjA2?=
 =?utf-8?B?NzZVYkl6WEJGSWpzazVwVElmbklSaXVON0Q1T21UUkVJN09zcDVncGRyUnM0?=
 =?utf-8?B?Z3FHTHAvQ0oxdkJ4T1dhYytkd2tGMTJ2M3N5c1VROGd0YVNmMjFJY2JVMm5Y?=
 =?utf-8?B?dmRDY0dSRTIzQ2ovTGxyc2x2VG9VOHhlVTA1eWx5RnhBczZNenF3eEgwSlFj?=
 =?utf-8?B?MW1zalEzRHl2QU5STkp6OFdzaE5ibk13QWdIWDU2ZXgzdDBjMHdkbElBTVZa?=
 =?utf-8?B?aEhLOVZuVWhRdFdiZm9yZnZyNldHQVRYa2xkdFZtREtJZDI2aURJcXhXZGM2?=
 =?utf-8?B?NU9QZWRQdDYwbnQ4Qzg4V2h1Uk5YSm40dVpRakgzYWpORGRLR3FneDNmei9R?=
 =?utf-8?B?OHpLaURGTXMyUFdyQlZHZXBNYVpDK0VEZFBNaFZQZWt4TXo0SXlzUDdCVEhw?=
 =?utf-8?B?TVNmOGh3MXJPdFpDbVJqTFB6cXRJVEdlWFB6MVRBUEdzdlRrbEZ4OGFubitH?=
 =?utf-8?B?ZEVPSFlIbng4Yi9kZGFYSUhmdVpkWlhDSXMvclhHZnZMZlI2TUhMUnU5UU5U?=
 =?utf-8?B?QWZScXltdEx5dUt2cjhkRW1sQWErQVZ4ZytVSmtDOGhocWJPK2hHUi9UQXFX?=
 =?utf-8?B?Y282TGVFKy9zZUpKVDhDdEJaWWU5dWZVanVsU1ZJZjljSkFJVmJWMHR4a2hR?=
 =?utf-8?B?aFFkZ3FoUXMycXVuY3hMMGxibzc1cGE3clJSN1VxektjeGJEeVBwc094Umgx?=
 =?utf-8?B?Q1NDdDVmZkJSbFhnWEhhTVVMbkM0SlJMZzV0OHQ5TzcvYkVzRUNzcVBIWThX?=
 =?utf-8?B?OHkvZDZOdk16c2NTeGM3TzBQNU1Oc3VUM0Q3d2hqVXNadVk2dllqdzhKVUFO?=
 =?utf-8?B?SzhBL01UVUY3Zll3akc4amtzeUxXcVN1d2c1djUzOHhwUFpYeVZEcktSZkRT?=
 =?utf-8?B?WVBoUkk5S3BRY2p0RjB0SDlqcGREQnlxaXo2bzJ0b055TSt2WnpuTERFdG5k?=
 =?utf-8?B?MzJUNGxRNUx1dWduU0VYcEMvTFVTTFNKLzJtOEIzQ1JpTE1taFcyTkJ4UmNT?=
 =?utf-8?B?OXJXTktZN3ZsaTRrekJsMVBNb1VQeGFEaGY0U2RvTzhxbkNvU3hVNmgvWmYx?=
 =?utf-8?B?WGk2QThRRldtbkx1SHg5OXVTUEZBWHBmZFRQSXNQOTVvcURyejJIZmVqcXcz?=
 =?utf-8?B?RHZ6VmxLOGU0V0s2eGtzcTVvSURwdFVrTWxzbGFvTmF3NWU3UzA1dXdaTW01?=
 =?utf-8?B?SUtpeDBvWUs3Z29SdWdqVnJWQVFHelVzamF1T2NFMmk4OFpnaEp2NURZZEY4?=
 =?utf-8?Q?MTZNFzjrIwo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NqMWF5Q1dvcldGb3NUY1lCUjVsejFZeXluZnhlT09IOUF1em1FR1pvOXkz?=
 =?utf-8?B?TlQzWkkrRC9RMDdBazNaTWszSmNNOTJuc3lFb04zcFJCb0N6L3lONEJOZ1Fy?=
 =?utf-8?B?T3Y0VlJzK3daRkIxbll3dmttbFhhT1FCNE13ZjFoM2NVSU9xd3E3azNZTExX?=
 =?utf-8?B?dXVrYkpRRHVteWIwc0xoMlhiUS9ia1Ywbkt4d3lsbmlNc2dPRUxobmFINlpu?=
 =?utf-8?B?YUIxTTBKdnJ4MXQ4SFZJRVZObTNWL0xDcUwycjVvQzRCak5IU1NTY1NydlNv?=
 =?utf-8?B?ZUtjVmxpNXdTV2lWcjhIYzJNcDZGRXoxK2hTZGs0cW1XNVBOTE5nejJrOTVB?=
 =?utf-8?B?WE9QaDYydHB1aGZ1YXZRT24vdi9NdExMZEFyTzcyV3RlV0FyOEdDR1gzenZN?=
 =?utf-8?B?Mi9FMTJwajdsTEdjYXRGME92WU5iYldOMlFrQURTMlhsdFBIZVk4eUxXYzFD?=
 =?utf-8?B?Qm5qYjM4aDE2T3dxQ0w2OW0yU1FMT0czay83RUlDd2xBeUFGZ0RqZVd2KzRN?=
 =?utf-8?B?eFB3Q0UzSDJNa2dPYUZGWGJSZTNodXI0bXNHR1lHYnBxSTlSTGs0cEorU0Js?=
 =?utf-8?B?QXhSYVVTZWM0eXRhNG9yeFBiczlYc1RnTEJpaTdPWUFRbnhrc0xOZVV6UWIr?=
 =?utf-8?B?M2wyWWl6a2laWDN0TkExSys0anQxNEtEdnFpVGhmNjJ1SFBxZmtkK1d6SU5S?=
 =?utf-8?B?VDNIaExmWEZUckcrRmlxY2pOUEVpTzlrczEyeDEvMkFTLytjbzR1aTBkdmR0?=
 =?utf-8?B?cTRuRkVFUXlBdFNCQ2FVb3ZJakg5VW9kQlQwd3IzcWtBSm1HZXZUN3BRWlg2?=
 =?utf-8?B?bE5QWUxLVGNuUWJ2R2pvK0toU0ZEckI2d2RSRGdDMDk1dWhwQTRkUUljUTdT?=
 =?utf-8?B?M3JyYnVDaUQ1OGtvZG9CdmhTMzVxOERYaUloaGJmU2VvMytvODFkUnh2ZmQ4?=
 =?utf-8?B?UDBXYlZzalBnZ0FmNzROVXVTaEo5TjJpQkpNNWpHejMreWx6YXM4Z2ttUFVr?=
 =?utf-8?B?MTRwbmZ5QTZ4eXJJMU5XMHd0VWxHam9jd0xxWnZjWnd3cFJ4OFpiNEdOQStt?=
 =?utf-8?B?cnM2WUVEQ1JVbzFxY0JGajhOdVRDcUtBekFubkc0OW1TNnhYOWE3NWxsbWEw?=
 =?utf-8?B?dzBpbC80RXU4N2oxSUhIdjc1cCsrLzl4Qk9WZnl6UlNDd0o0ZW8xQ1QzNFp4?=
 =?utf-8?B?SmVWOXh5cVU0Sld1NGhBYjJYT2JxQ0pOVFl2SmVTS2tDWWVOUjkzNFc2REFx?=
 =?utf-8?B?OTc0RFkySTEzVWZEN0VBQy9RYS9DTWZlcW9ZRHlUcU9oWFZvRm9FcitQQ1ha?=
 =?utf-8?B?WkUwMlRBZGQwcDlCaXQ1VU1qTnZlNkx0SkMvb1Fqd09kanAzUE12V2dPTlg0?=
 =?utf-8?B?OTBQTmpRLzlsK0E3U2xEYXl1enBrdGc1Vll1dHhXc01wZmMxdkw0MW1HMnJT?=
 =?utf-8?B?Z3ZiWTBPNXlVWVFOdmoyZWZIdU1UbHBYR0h3MHZtZkhKcExWTm9QNms1T3Q2?=
 =?utf-8?B?RkdXWmVuWnRoNVZVaE1SN0xFZ1dYOVR3Z0tMa0pQQVFtYWpBYjBBcXJHdjlO?=
 =?utf-8?B?OW4vcHZURWxHbCs5QmUzVXBUbU5KbWwySno2djY4MFFEcGZjL2ZLK0hoeWR4?=
 =?utf-8?B?OTAvRXRLQTB2Z2VvUi96RlFsTXdrT1pIN1FvMDJKZnN0ZGFCN2h6NUJYYlVV?=
 =?utf-8?B?T0tVeTRTSlFGVlUxYWxOTUN0aFZKZmxlV0tJcU83WXRIMEo4SGhQa1J2b25Q?=
 =?utf-8?B?MU1zeGV6cEhqcVdpcVArTGZOWEx0eUluRmxqZWcwaWZ5TnIrN1dhZUpNcmtV?=
 =?utf-8?B?S0VVTHdCMy9wd0FQSkl1NVB0RjN3OFErZmhkUjdkTk9sT0FwaFlLWVFtQllW?=
 =?utf-8?B?ODY0aFBxejhCQnJCcGRiOEt4NldzQWNzamZQUitUbGtNTHJmbnBBbHE5NTJo?=
 =?utf-8?B?ckxtZG4rN1NMZXZoNzl6S3h2dXovbG5oZ0J2cmdIZTlLeHZmOEtYRFBxS0x1?=
 =?utf-8?B?dURmdmd4VlpxdVp1anA5eXNQRlhXZTl6eFo1b3U5RWcwQXRRQTJRY0wxb3F1?=
 =?utf-8?B?eXYwRlAyUkoxZnEvVDM2dVRTSzg1ZmFxVFNjL2ZlbmhWRHE5ZGcwMy9OdWpZ?=
 =?utf-8?B?eXBZUVdJOCtUY0poN3Jpd1dJQ2EyYmQ0QUM2UHRwTk1UUTNpcXpDS0I3ZjVk?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7581a03b-30d7-4402-3d37-08dd6d2fffde
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:05:08.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLmYVdZzB7r/8XK5i+wF0brx+QIgWgZVWL40MsYiHlQM02zEXLGiyLH6cY9VFMq4gn5rxd1s2Ms2/khz9FLX2sk63rvzrZE/s30GnaG1nP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5217
X-OriginatorOrg: intel.com

On 18/03/2025 5:07, Faizal Rahim wrote:
> Implement "ethtool --show-mm" callback for IGC.
> 
> Tested with command:
> $ ethtool --show-mm enp1s0.
>    MAC Merge layer state for enp1s0:
>    pMAC enabled: on
>    TX enabled: on
>    TX active: on
>    TX minimum fragment size: 64
>    RX minimum fragment size: 60
>    Verify enabled: on
>    Verify time: 128
>    Max verify time: 128
>    Verification status: SUCCEEDED
> 
> Verified that the fields value are retrieved correctly.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 14 ++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_tsn.h     |  1 +
>   2 files changed, 15 insertions(+)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>


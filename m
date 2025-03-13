Return-Path: <bpf+bounces-54001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57BFA6033F
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 22:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD03E3A6BEE
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 21:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EAA1F4E39;
	Thu, 13 Mar 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMKGfFB6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C581D63C0;
	Thu, 13 Mar 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900221; cv=fail; b=lXCK5nCWwHsdsIH+rZzydthT75puMaOPDsAOPWyTG7eT4dk1mmNT0GELsEe+/Ay1noKJV8SckmtakvPnWRrq1knnabG1jxaR8x1yAMRoNmrE75ss2DIyVkTPzQ/mzXyojrYk1FDUtAycr8hUdD+8tLBzWizSuEwApPqRsbf3yrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900221; c=relaxed/simple;
	bh=DgrFpcxtnk79hkhZzOwuhSUsd8sSWyfhwC+GIOPZ77E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7bFkvSXtEO6/FBw7QID7+ycgkjFqM1Kd9bJ57H5X/1RDVaTfpxYROKj+YkH0Ws4H0IMTJhemduqoXmsI8fOY150CPo4FqS62I4h5pC7EKejqG/q+ws9Z1vTa7vFY93z0p1Rmr1TrdREuLBE7Los6+sI0SrH2rsXGur2pGvCvWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMKGfFB6; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741900220; x=1773436220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DgrFpcxtnk79hkhZzOwuhSUsd8sSWyfhwC+GIOPZ77E=;
  b=AMKGfFB66nBKoEPc+86OxqN/pPPx5RVjHes3iJL50MhENCUrFVDTDl+M
   NDI8UHkpQ8Nc8JvvgfwlVHz4x3JvuffU1wQ2ZLpMJL7bTNj10X3yF8ymn
   l8m8nU1fsSdn4/5+l2gcBXk8U8pEOLl43179kecF54dFaPKl1YFs0+gGr
   9o8hR+1QkCmmgmipvxtnQuorFmt9l08VFUx1gxYXceBe96M2hTQZnirP9
   7+HcPAGZLTna9JR/W9Emykw3CKt7MCVrAt83mDQkfWVYJDrg0bdSUieGV
   4IowRU0jYNJmeayRviaYcU1NHjMD9lCiXZo7s1o3hwWL4HGR/KXisfbrT
   A==;
X-CSE-ConnectionGUID: eznO+EYZQTWB6ds6b/BrIQ==
X-CSE-MsgGUID: Lp8p3MJARaeE30dW+ZM59g==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42766442"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42766442"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 14:10:05 -0700
X-CSE-ConnectionGUID: 7Jk+EKlTTCud49Jq2CsC/Q==
X-CSE-MsgGUID: lOS3jH3ORRGuIfyct6B2Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="120860987"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 14:10:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 14:10:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 14:10:02 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 14:10:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/Z1W1z8ZlHGyQDvBnb8vkT/bDs2mr20Jr4z2+zsHsR7OUVF3YHmn5rQsSqQVYml4B+dS1dealJlkTAQ649p32G3ww+hnBzHeQDuJtpF55dh1HiKfsuvt9uu8yE5+UGV+xjWH+jIpVPA7c4uhQkK4ty95RrN3TtYVrDDqiO8Qhbx0k4QhESwDtBV0PxM4x8T2N+8i3+3qfaGmWrQxt7ipbYuph67USqZJpgucUwABg9vffgNwUiGk/utaBf925sfE0Ds/OB3Xeuo6rTT3ip+yNQJP7AP39lyO8ZdsHdqBsEwo9lySlwKyZfQ9VktMyerRhBG/oF+Mf9ArYQ/PD/ZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E45ReUDgJlcJOBMmUBMkjqsOf7Q6u6VUkzeBkCoDTsI=;
 b=YU2aqC8SEyrNocIxqrsRl6uLJKNvf5zuRGIDhW8J91qrNgHOhmV3OXVt2eqcYMv/Yde8RDfjVbHDfIwtdhzsUMMgBuY7NI7icvPvv12LDw5x00kTac6CC9s1mTRkWC98Y1ajqzEk0jAejI/EJYlCngxu6q0DOWmwvgw9xuHPTfrjqOY7s1oufzsFwGVNfUmftGjLUMZCJVfiHtMBqLPDZHDeULq8LtlDerJ52P53+M9sQQM1KZ5Ryq4HApixdJaOa0O9h/u88Qr4wCw0DslrJwXy5BNw48QLaBOpni3WOonLLTOQ7Nlm9a6nbHPCD96cyka4AzI8UJg2q4kPvkPi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 21:09:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 21:09:26 +0000
Message-ID: <b2b632cc-ca69-497f-9cf9-782bd02cac79@intel.com>
Date: Thu, 13 Mar 2025 14:09:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
To: "H. Peter Anvin" <hpa@zytor.com>, Yury Norov <yury.norov@gmail.com>
CC: David Laight <david.laight.linux@gmail.com>, Jiri Slaby
	<jirislaby@kernel.org>, Ingo Molnar <mingo@kernel.org>, Kuan-Wei Chiu
	<visitorckw@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>,
	<andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<dmitry.torokhov@gmail.com>, <mchehab@kernel.org>, <awalls@md.metrocast.net>,
	<hverkuil@xs4all.nl>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <louis.peens@corigine.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<parthiban.veerasooran@microchip.com>, <arend.vanspriel@broadcom.com>,
	<johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <alistair@popple.id.au>,
	<linux@rasmusvillemoes.dk>, <Laurent.pinchart@ideasonboard.com>,
	<jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>,
	<dri-devel@lists.freedesktop.org>, <linux-input@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<oss-drivers@corigine.com>, <netdev@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<brcm80211-dev-list.pdl@broadcom.com>, <linux-serial@vger.kernel.org>,
	<bpf@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>, Yu-Chun Lin
	<eleanor15x@gmail.com>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <20250306162541.2633025-2-visitorckw@gmail.com>
 <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>
 <Z8ra0s9uRoS35brb@gmail.com>
 <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>
 <20250307193643.28065d2d@pumpkin>
 <cbb26a91-807b-4227-be81-8114e9ea72cb@intel.com>
 <0F794C6F-32A9-4F34-9516-CEE24EA4BC49@zytor.com> <Z9MGxknjluvbX19w@thinkpad>
 <795281B1-9B8A-477F-8012-DECD14CB53E5@zytor.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <795281B1-9B8A-477F-8012-DECD14CB53E5@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b10f16-aaa7-4494-8167-08dd6273564e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2xMdC9xZ0lWeDl5dW5sOVZMK1ovSFRPeUpnaUZnd3g2R1c0Wkcza1RjZHQw?=
 =?utf-8?B?WCtSWnhUMldGN21SR1pmc2xDc0lidXpEZnpzRU1JYkNtbFFNYnVwM1V3R1Az?=
 =?utf-8?B?bnVzb0EwdklhaVpwd0k0OVI2MVFCQjlKdGIzbG5zeEhURGFvY2ZmQkk4L3Fu?=
 =?utf-8?B?c2Z4WEdSck4xR04veGdkVFpQNE1NVThaK0Q5WFpwRktFMVJHYmgzYWNQaGRk?=
 =?utf-8?B?akxLTXJJQmFpOEZhRTBRS3BaYnlMRE1PcExwdWwxTjFtZ1VadkZSRVZYZ0FE?=
 =?utf-8?B?NWVnakJJakoybGVJR0doQXZRT0loNnR1TG5kRHdRNGJscklwRXI1dnkrVXBk?=
 =?utf-8?B?bUIrTGFhcCtseEZzQVVtQkYrRTl2bnlqdXF6V2szMVdhQS80M09XeVhTb2Fm?=
 =?utf-8?B?QXhheVZyc1Ywd2ZqVlhKNUhFTjNpNWYwcnBUVHhibFQ2Sk00aTFmV2tRYTg0?=
 =?utf-8?B?YmM4Uk1DVFJlMkhoNm1BOHprcmNXL0FZcEtKbytDT1Bzc1JpU3ZsZGhEb1pP?=
 =?utf-8?B?TENreWpYN0Z4cjNKc2cxRFR5TzBtTHNFVENEK283NnMyMFMzZG9YaHBJL3VH?=
 =?utf-8?B?SWZseUFXZEpkV3NBOE9yV1lncDRLNHpvdE1wWHRPZmZSR25IeCs1di81S1VF?=
 =?utf-8?B?ZGIzMVErVU02TXVEVjNrelNnVnd6NTRlYzVwSU10RmVvaHV2RGlzcFFONjQz?=
 =?utf-8?B?T1EwUzRmTjVYdGdxUTBESnBEaUlzN2tldEViVnM3dW5lcXVkZFNQS3lSdzZa?=
 =?utf-8?B?ZEtUcmY0TzhOaFpmVFk2NERFQmluV1VqSUFPSktmQVc2S0lPbGxwK210Q3pG?=
 =?utf-8?B?cXozQnpacExxZ0pwSUV0SGpablJ3NitCV1Npc0gvazlIV01qSnFHbEVzTHZP?=
 =?utf-8?B?eFRsRUUvM1JJZVBTeHhJRHdiMURJL1hLTTNuVHBFZnd4NE9qWlRES2xNSHZo?=
 =?utf-8?B?UE0xaEpidXRTV0pDc09uNUk3SWxsS1kzNDRGV2h1Um92eUduSGZzbFArOVhT?=
 =?utf-8?B?NTF5emRYVStZL0xFd0JVN0ZiMkhlWEFSWHNOWG9ENmZhNTY1Zm13ZjcrMEJL?=
 =?utf-8?B?enFJNDBVNzAyUkRvTWZ2U1NXNnZWNDFZSENjYWhQZEhuazhNcVJDL2RkaC9V?=
 =?utf-8?B?V2VyNzFBQmQzVy9tUWdiSTBsc2h1M0JISTFlSTArSnFxK0VHcm81R3hNNmxK?=
 =?utf-8?B?VUc1bXlyZ2Foa2YvVlhUYTh1Y05jT01CZHdkR0plQTBHVDNGbjR2LzY1QlVm?=
 =?utf-8?B?dUgzYkYzSGRKNXJFYTRNWmE3cE9VcEFIOFZMNmpnUVhOc2Q1azR5ZlZPOWNJ?=
 =?utf-8?B?dUVuWVJqRUI0dDNOamhqcXN4T2QvMkFDNjRBSXNxbzJsK2NaSjZDVGU3ODZR?=
 =?utf-8?B?eDMxRE8zV2FrU2VqY2h1UXljeU0yUlFBSkQxZjJyNmtiODhXdkFPOGlPTGtq?=
 =?utf-8?B?RE44QTQyeWpZVDFtN3lmSjFsUHdhakxqeDlaL1V0THhmSlVBMjVNb1lIaGtM?=
 =?utf-8?B?QUIwUnFHeDIvYjlIY3V3QUVrdm1DeWloMmdhRXlCcDQxSk5OM2xzanlxWW5C?=
 =?utf-8?B?UFJVYUdrZTlmNjV6REo5ciszZTVHR1ZMc2U0MjM4d2dDWC9WUGdLR3J3Rndm?=
 =?utf-8?B?dE4rRjIzWnFNNWoyM2RCc0dvakVuN2pjQUc3dXVzSm5tOVhzQ0NlTjM1eThu?=
 =?utf-8?B?OTF1dlJ5MjFKMXpveTBvYzFRQnROd1UvZW5zZ3RqZERzU2pHSFRvT0VUT1NX?=
 =?utf-8?B?aXltcE5rWmNkZDNSQ09TT29ncHFtaEt3c1RIZ0R2dTVRc25GcEtlMEFTWWR5?=
 =?utf-8?B?akRCVlgwK1hzaktuK2d4YnJha1h4dzRLdW9JeDlqQ2RiL1hVMGNqdDQxNVZP?=
 =?utf-8?Q?6djIK3dZhi617?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdhTlR2RzdrbXhDcHArRmdPenZqeEhiV2s2YnY0Y01kS3VuRERPdkYyMzhR?=
 =?utf-8?B?dzd1VlFZYjM1TUVwRGFGcHZmTXF6UkEwWDdSQm1mSGNZQk5NZVhlQWdQRzNI?=
 =?utf-8?B?VXhPa2tQTnIyMk5EbGI4NFUyei90UzBjSVdzNW9mc0NhNU5RQ1JuREk0Zjc5?=
 =?utf-8?B?RjBMU2RNeTlVaGxQQkl2OWhNUXBwRFZ0UGYxVGovRWRyQXFaby9EazFNMFVl?=
 =?utf-8?B?TGRHUFhuUjg5MUJCalJnc2xaMXFBOVJBcGdaQWtWNFBvZGRZOWk1WHpzQWVs?=
 =?utf-8?B?eStYVmhQSDVxSnhyVCtwUXRwb05yRFJkSnNVR0JGd1ZHZTlCL0dFYUJGK3Zv?=
 =?utf-8?B?UmowUm81TVNoZFFSWnFIelRORERuWjU1VnkzL2hmeUZuSCtxYXhkNnphSW9H?=
 =?utf-8?B?VUdUMDdnVTFBeW1WajlVZ2xDR0ttK2FOU1ZQVzQraHNrMlUybHl1VnlTVlh0?=
 =?utf-8?B?cDU5ZlhiM0N0VnZwSUtRMWJJdXduVFJpQnRUa1ROU3F4YXNselIycHM0MGF1?=
 =?utf-8?B?RkNtUmx4aE5SUFNuRW9wcjhqdUdyT3g1T2tFUWhYc1JxK0tyRm5nZmJQYXVm?=
 =?utf-8?B?cEpoamRsZ1hhbCt2Z2ErbnhpdU83L0Jrb2hsMGNGL0RobGlyNzl3UktaWTJT?=
 =?utf-8?B?Wlp6SGdhWit5eW1PZnNqczlubWpVN3pORWllSDVzVDlmbVNneDd5MG9jTGVT?=
 =?utf-8?B?bndWS2NveU9FcGUzY05aNlQyV1k3U2RuQ2xETStNUmY3SnJXWEk4S3p4enhB?=
 =?utf-8?B?b1Z6d0ZLczJPN1NUVmJwZGJDV1ZFWS8xM09xSitPUTdoRklneXU0SHloSkpT?=
 =?utf-8?B?N2wrYVNaTWFSV1l5c1Y3YzVZRC9lYkJ2K0VLa0pldTRPTGgrZlBIY2laQzYr?=
 =?utf-8?B?Yno1UW1acXI5eHJLYW4wTlRsTGVBMnp2OTlOWVdBSVdKbjVvUlZ1NHRzZ0dx?=
 =?utf-8?B?aGh2VzRtY1MvNDNhclhTdXI0ZGdzTXlWbFp3THczdWg2MDl3bFZzQ1I5YkY0?=
 =?utf-8?B?L3U2ODNiYXQ5OGE3aWRhMUxBMVEwaGVXcThOS2JNeFZJTExma2NXK2lvbkQw?=
 =?utf-8?B?YzRBazljenZXdURXL2NVU3YrY3FJWWdpc2ZMNzJTSGJCSzJvOEVqbll5bWJY?=
 =?utf-8?B?WUV3NmNPVThZUWU1SUdxN3hNY01jTnhDV2dMTXoxVGwwL0FCRkk3ZlBmUUhr?=
 =?utf-8?B?QmdRT1RhaFpCa1VaZkFxbVlwbFVnRlF2Qy9pbHJiR0ZYaHVaZERhNi93Mlg1?=
 =?utf-8?B?dlJWZGJQcjY1M1AzakJWUGJrRElWamJCRVdKcyt5c0F1R2dVWGVHRlRiekNy?=
 =?utf-8?B?aXRmMlViUUNMWk4vdGtrQ203d3JaRXd5Q3lkaEI1RFI4aFJLazM5Um5XaFly?=
 =?utf-8?B?dE8xaUhmMVpoS0xIcGpQYkxOU1pjTys5TVVUNEtYRWFiNitkNDNHWkIyc0RF?=
 =?utf-8?B?SkZNakhRdU94RE5EaGp3Y3JaZWE0d29VTmUyUktFUEhHOXg1TUNuVmN4TTAv?=
 =?utf-8?B?UzJBSmY4emFrVkxQUWZpMTNmeHVDV2dWSVk5YUVMN0tENVVQL3grNndwelkr?=
 =?utf-8?B?Z1R3b0hibkJ4V0laNXlXczM5NnQyWko2bU92WkZTaGVBM25wZk9wbFNpc25R?=
 =?utf-8?B?MkZrdWpIbjFDRDNjaSt0clRtR21vSXpHdy85NnAzMUhlWWtncVJ3NjV2UGdT?=
 =?utf-8?B?enBvRnhJYW1hbTRrYUk4YVV3M3lTUmdERDZwRFFxaEg0TW5wdm15ZVIvMnIy?=
 =?utf-8?B?cU5rWDZBUnp0ZHlUcThPdFlZMlN3MWRDVmdYRy9ocVhQeVJRZXhkTFRjcjBa?=
 =?utf-8?B?UzF2TDBRUmF4bHh5Zi9ldS9HT3ZKMldBT0JOTVBKb09yYUJ2T0MrcVhxVE5C?=
 =?utf-8?B?TWp6cjNkd2FvWGVVZTNtdTF6L2tyNC9YZThjWTFQT0pMU1ZscnJCQ0tCQVhV?=
 =?utf-8?B?d2dMQW9YMVFLejBjQjZhNld0U2dlUXBId2F1dkFoTFFYMmRsdEc3M0NiZ3pj?=
 =?utf-8?B?MWh4VTRvWGFYYlg5VUZ2UnNzK29CNHBxdTRrdVN3THkyMjYwaUtPOTVVcjBC?=
 =?utf-8?B?WTdzdGhsOGlFNytwby9keE1XbUdUK2NzVlZDeTlHRGFvSnR5N0NrYk03eHl2?=
 =?utf-8?B?aHRORXpGUVN2ZzNZelA4bFNuaHJOQnYzWU5EVzNoRDRhZzNDQVRxeGpZeWls?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b10f16-aaa7-4494-8167-08dd6273564e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 21:09:26.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l05o3X0cy9v7nJGc+IVjRhjuA1RbK8izJdn9E++fY2m/U5w6Dw8hyFeURYozIl3EdMxdxlYgyXDkRfNbnj4ipUCFlhAAyH/1uuo9rOvl8GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
X-OriginatorOrg: intel.com



On 3/13/2025 9:36 AM, H. Peter Anvin wrote:
> On March 13, 2025 9:24:38 AM PDT, Yury Norov <yury.norov@gmail.com> wrote:
>> On Wed, Mar 12, 2025 at 05:09:16PM -0700, H. Peter Anvin wrote:
>>> On March 12, 2025 4:56:31 PM PDT, Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>> [...]
>>
>>>> This is really a question of whether you expect odd or even parity as
>>>> the "true" value. I think that would depend on context, and we may not
>>>> reach a good consensus.
>>>>
>>>> I do agree that my brain would jump to "true is even, false is odd".
>>>> However, I also agree returning the value as 0 for even and 1 for odd
>>>> kind of made sense before, and updating this to be a bool and then
>>>> requiring to switch all the callers is a bit obnoxious...
>>>
>>> Odd = 1 = true is the only same definition. It is a bitwise XOR, or sum mod 1.
>>
>> The x86 implementation will be "popcnt(val) & 1", right? So if we
>> choose to go with odd == false, we'll have to add an extra negation.
>> So because it's a purely conventional thing, let's just pick a simpler
>> one?
>>
>> Compiler's builtin parity() returns 1 for odd.
>>
>> Thanks,
>> Yury
> 
> The x86 implementation, no, but there will be plenty of others having that exact definition.

Makes sense to stick with that existing convention then. Enough to
convince me.

Thanks,
Jake


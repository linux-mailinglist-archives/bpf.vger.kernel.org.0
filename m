Return-Path: <bpf+bounces-28774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3AB8BDEF9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335CCB2523E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB1914E2E4;
	Tue,  7 May 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzFtxCDR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7614D45A;
	Tue,  7 May 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075543; cv=fail; b=eIwJLk0i3Uk8nqTbjrvzCMhGZu5mhfk8dVVWuNeGfrduoQSe/YRQT2NWGDWI2njermUGTbGdZCJmz+3gqUsjtTmoIDbzwCq1ILS805yaykornb6HelcoshBbibQkhm78JCYvNL04KGxqQaZbJIRzBnqyY1KklE78mxQsRi6JpO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075543; c=relaxed/simple;
	bh=rSpEKq856ivOisbA+DGCO6zRpheXI0YnLuGhR6psShg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EOYMAeSrkdK+FajR6QKy5Oyq1A0pYfhWWeSI0O4c295H7KGqrsC/r3KurHzfqrspFiz6FiuEH825tlfSB/kg9yNvQWLWyLbDMCIxuRhb8kO4U7lAQpUrnHN+yWXYGsXwgYJhiZVU3PrJd0/aB2i/ac3c2M8J7HyhDlqF1JJjAg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzFtxCDR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715075542; x=1746611542;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSpEKq856ivOisbA+DGCO6zRpheXI0YnLuGhR6psShg=;
  b=PzFtxCDRwaydxSIZjpv0/TffCSJtkqjlj4x22pFkJ8GoR1UGyIFOblzE
   EARoSochZR4MB2WWRM1L1Meo68v0ob8HJcN7stcgJISKyKdgX2XGsL05T
   /9CFzpSc94os16wMENXie53dCNNnL1q+9txS5sr9dxwFKo9YGAL7ZOdiw
   FyFPAvZl5BNHbLczAWv7tSmGbniuK/+53dYmJGvaCAXdUXSh8+VD2tDJw
   e/4N/MUvYTdmRgX3KlqjlYjuFplWFf2n67Y8tJHJCoeRmKG1SkxoAALqa
   /B2UNd8YXPfuDjG+eZsaqqiBzaPELqCJc8QYhLMNBRZzr8nyNZQRkD+qx
   w==;
X-CSE-ConnectionGUID: g5AiQdsKR3C7xAwy2mUZMQ==
X-CSE-MsgGUID: Ulw3q5MISfGup/uAMaaUkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10982274"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10982274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 02:52:21 -0700
X-CSE-ConnectionGUID: ixIXN56mRpC3yr1mNYGZjg==
X-CSE-MsgGUID: z8CCcSxeRfG+Q2PWoI33Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="59639012"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 02:52:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:52:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 02:52:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 02:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RslQjyL91g4I7mCwg8fZFYyg2/s5pH0/RadGoNWa6tkYeFXCySXyc3FRlKRqaJQ/85CWVvL2W5pms4FUAbA4J0W8F2+Mg6N1cRKfS2URTSvbjYorepaGfx/yFEdpWa9eVLHe68TluNe8d685MTLjQBTG4zosB8B7z6s2YNaynlmpjGiWpZf+UuNNYoGUArV8P/xSLpYUQzutiWAn/EHTTVa3CmgXLcRGa4zTRXdcaX0KWba3WtJYYDmQTzvqUCh+v24iAwTI+znymGF3wYc4Kp9FQZp09djCN0jE3LV5/8ORmqQW379U+yG79cpNmEKpK+ZTCUDDVZDRb5igPX6Hcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOYtlP7RIVVMqt7FySB/7jQDs1b1Tk7mnoZXQNsd2eI=;
 b=noGD5eWAO/cKUhZsiHNIDVm/c94nV1ZHDYYKArwL7V7ZlIlL+UqY41Fda8AzJsWkbEBGsprckyrpPDdqoe39WRFlkipoAoY783AChyJN/LH6WCiKfqe1gLgLEJbpy52ZjubRSfJqaN1x6B9Yu5euSmpxBG1MmzgAvy2gJwdEX+uYadtX807f5PYmo5etD+PVrTvinozdUkS/82gunykrLWtDRehdFY+qGIRM5U6KaYjH6efUttS0aWJ5TmRevVq0VLHF5tkTQ0tOVBBBijnUZnYcm8/B84CcqmMGa3Xf5DUaf01Hv/0VZpRWxO+j5cT1yIogpjCgD8pp+Hjd3hcQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL3PR11MB6481.namprd11.prod.outlook.com (2603:10b6:208:3bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 09:52:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 09:52:16 +0000
Message-ID: <e9a8d649-40b0-4595-a702-9fd8164e5326@intel.com>
Date: Tue, 7 May 2024 11:51:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/7] page_pool: check for DMA sync shortcut
 earlier
To: Christoph Hellwig <hch@lst.de>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240506094855.12944-1-aleksander.lobakin@intel.com>
 <20240506094855.12944-7-aleksander.lobakin@intel.com>
 <20240506115043.GA28172@lst.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240506115043.GA28172@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL3PR11MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: e155b9e2-85af-4482-4632-08dc6e7b6098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDMxSWVaN1ZNNWIvSzFMcXg1Rlg1bkd0Q043dkM4cUJmVE4rWU1UV0RHbFNT?=
 =?utf-8?B?TGlFSzVhR0JQYUttV3NENERDMGJVQkdLdFZoRGpWTWpiSU9wSGRBUzk4VTlr?=
 =?utf-8?B?R0JtOEg1TzNsV2lxWUp6VmpNeUpPbTlzaVpzZE0raElGamN6NkVqS09zcE9L?=
 =?utf-8?B?OWY4V3hBVTRibHpwNlVXRkgwdk1UN3FyNTVjYkg3bFhkc3JhQjlXM1dyNk9U?=
 =?utf-8?B?ZTZLeTloUjRGbkxEc0U2QVdJUVFWdHBzOWRUaUx3MlJ3WWpWWlhBR0h1Yjhy?=
 =?utf-8?B?dzBaL00ycDBYelhwQ3FLQVNCc0ZpVXNmRlZMOEljN3lOT01OZlQxSTAzY21i?=
 =?utf-8?B?TGFGRENCR2dOTnJudWVLb0llUFcveDVDZFAvTjk5K3lIR2VKWkF2bUlRNTRz?=
 =?utf-8?B?QVBZd2NJemV6N1JtdFg0Mk4wdVl1QXJYWUpWa1hxUk45QjQ5QWJQVDZzc0Za?=
 =?utf-8?B?bjZsTmpudkkxcXVuVGhCbmZ5VXRmZGRGRUpyOWFSL0NDRnVVSmM0VHRPV1VD?=
 =?utf-8?B?M0d0S1U5V3hZbE5hdEJPcHlyZDlldGZ1Z1RFRkpnempDeCtJZE1LUFEzZ0Vw?=
 =?utf-8?B?eEJGckVrWE5QeU0zK1JjMUI0OGJmeUsvMmVCZ29LWjhJdEVpcjEwNitRQjJT?=
 =?utf-8?B?UU5oUjkxSVRlT05taE03MlRpbXl1Qms1eU0vRDNURzNwSm56ZnlKVDNiUUtQ?=
 =?utf-8?B?OEdSdlR6Mk82Q2xSeWRyZ3BZMHVrcGw5OFR5czcrZzBjSHZackwrOXhWeVRM?=
 =?utf-8?B?alpMbFc0L1M5cU5jMEQ0RENjaDJaaXRLK2dCR2QyYUc5NW9DQyt0akRVZnQ3?=
 =?utf-8?B?aUxXVFZseDJDeG90WElEWi9NVWJocEdCWTFKblpQcGp2WHBWV0RlKzcxYTFi?=
 =?utf-8?B?dnhHVDdxYitpNzV6UWhVUmtqdW4zU1BTSVRETFpsdG1LZ0hpdmlIZGNleDdt?=
 =?utf-8?B?NVVXOFFzOEp6WUo2SnNGR3ZLUXdqbFJCRG1qLytiOUtWWGgyeHVNMSt0R29i?=
 =?utf-8?B?NjJZTkFiR3VTdnNDeHBOYWtkWkdWRFJsc3R2ZnpXSXhNRlFPemkraXAyWnYz?=
 =?utf-8?B?SXFmM3JqYkIzajBwNnBBcC9GV256TGZKRVpiY3hxMWR2ajduNFNwZTVhSVJC?=
 =?utf-8?B?SHk1QitsUlJ5eFcvWDVhcHo1cTBOei9nRXdlTTZzOHNvQUJ2MDdBazBQeExn?=
 =?utf-8?B?YVA3S3ltcGNqcm5MelVQaTY1M3RXLy9ZSGJScWJRL2JEKzdxSUVublhMUHdB?=
 =?utf-8?B?RFN0YndrUjN6dGk3TXZaWmllNzRIT3V5NHNyWDdQQVozWGxvejRMSnJWZjR5?=
 =?utf-8?B?RTVES1lTcWxPS21uNkptY2szRnhPTE43NklndXBTeXQ0R1lLaE9HWDhhY0VQ?=
 =?utf-8?B?NEZzWi9RQnUzdURXRlhzTG1BQU1ocStZYVQrVjdpeEVQTEQ4KzdqUERKMVps?=
 =?utf-8?B?VzFoWTd2aDY1MlM4YWtNMHVUNnU2clpUcnFoalJseGpjdjl3cE9wb041YS9j?=
 =?utf-8?B?elovcGFUSG5wUDBjNWEzaEhCQS9JdGt3Y2oxcDBGb1VkbGNrY3RMVkxrKy9h?=
 =?utf-8?B?NjJ1blB3U1pFME94U3VodUJFTDRwRjhoRnY2VERYZFpFbnhNM2RPNi9DYldI?=
 =?utf-8?B?QkZkNmg2T3lIMnh1eHBoWFVFNEVabzBxVitEalpYNjJ4UGJtL2dGOGpOK0JR?=
 =?utf-8?B?aG1teUpLWWZvQld2UEpwZzluQXhmKzFEWVRtM1BhSCt4M0FwUnZRMFlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXpWdlNQM3VqQmJkN3pFVmg2SVVqTWo3REhxSkVVZUhMRVUwN0NsdlNUWEtZ?=
 =?utf-8?B?anBoRlVPVHVtYm5VZEs1QXUzSEJ6Ny80R3JpSmxsZWJReWFRL0t3K2FSWnNL?=
 =?utf-8?B?Rit5N0VBVTJZalhkd2F1U0laejI2ZU9YdW9wRkJORXRBMG85Qnp2NHdHOU5h?=
 =?utf-8?B?VEtXcU5sb2Q4VVAzNXREcVpVS3RIY0JSVTJMaVNBdlFiUTl3dWJ5Umx3RFVy?=
 =?utf-8?B?YXFiTUMyaStSZWhxSE13UkMzMnZuVU8zVkJGVnNBMitIVjBhUTJTS2ZaYWRW?=
 =?utf-8?B?LzgxZ1VWL05aczB0NWJ2SW1TYUR5MUJ5dW4zcWpORUljL1R4TWdZaHBvMFdH?=
 =?utf-8?B?NWZqMGpaWTRkeVV1a0dpMmtYUDNJNEZ5aXZxSTg0SVBiM2krb3QrQyszRklI?=
 =?utf-8?B?NGRiR1cwMi9qV2M3c0R3VS95eHVKT1ZXVk1XTnV3ZUp4RFphemZTOUxzbEpt?=
 =?utf-8?B?SSsvem05cFp1M3dQUnFTUzhVbE9QaUZFVGh3ZXlZZlcrMkVQUjExbmJIZ0da?=
 =?utf-8?B?SVErSGtycXdobHFnVFhnUE1WZ0R1U1FyL2FQbXFtUU0vRC90ZWZTUHplMjI2?=
 =?utf-8?B?d0VmM0RIS2tIMnNQbXFZbVR3MWhCTlRKT2pxZ1VCZm9Wa2p6dHdOYTFCMFBw?=
 =?utf-8?B?SlJHYmI2bTZJUy9jVDRQUWdsQjFPeklMWW54UEVicUtOL2R2VCtwVVk1NkRR?=
 =?utf-8?B?eDMveThZc05Id3pVZ2tBaGIvRjl4MmZEQXpKcnlxLzYxcnltT1BtN2pQbDEx?=
 =?utf-8?B?WXZoRlRYQjZtYUM2aUtpb3BHTUcwclNlVnh4WkNzZVNadFlwNnp2RER4aVpH?=
 =?utf-8?B?MWc2TVNtYkhuTjdiUEpSNURlZENWWlJzbE55U1ZuWnBla2NJUzN2UnlBR3NV?=
 =?utf-8?B?clcrWCtCZXpTWTQ3enJnZ3Jkc2lWZi90Z1RwV1RtQjF3TVR4b1V1cDdUY2lt?=
 =?utf-8?B?T3ZSWis4eGdFcWlKRTFKYzQ2Z3d1UmY2UERLZGRrNzVLMkJueFR3eG9uam5y?=
 =?utf-8?B?dFRHcEc5TkhUdzFCbUFWOTlGQngzSWdHVisxbE41VTM2VWI0RU56akVid1JJ?=
 =?utf-8?B?UmlLdnQzVlRWOGhodGljQ2hvNmlyKzlCR1A2S1M2emw5Mm1ob055b2lRSDB0?=
 =?utf-8?B?RS9GM29mYm5RcGFlZUUwREloSUFOM1ZMYjN5bEwwYVlFRVp3WFlTa0htd081?=
 =?utf-8?B?R1dBTzhDVVJ2SHRpam9rMDdvWlU2ak5CeGZnS3JCUnI2cXV2TGU2L29vSFdS?=
 =?utf-8?B?VjloZGdjTDFZWitFQzFGMzlmZ1J6Rllzb2hQSXFLb0tOWnFLeFR3MytFUDVn?=
 =?utf-8?B?N1EvSHkzaVpzK2xkTTB4Y29nWEV3ek5KaEpPU3R0Yy82WUwvVTNtdkhqNGpr?=
 =?utf-8?B?R1BqdUxmNDQ2ODVPQ3pMNlJ4eDBWUGZEOVZBbzV1SXczSEgvakNERWtXVTF0?=
 =?utf-8?B?NDNXaFZRMVRuZU83aHppcWc1M24yVjVLS0RVWDVwTG1QRXdWdjJoUjNWSHpH?=
 =?utf-8?B?Z1NodkFnenpBQjcvbWVwQ2FoWldNQVc2bCthZ0lXTzdWRDVoTDdSSE4zVzFo?=
 =?utf-8?B?R0FmbzFMaTdTNWh4eU16V2NCZnFablJIZVlHSkh0MzZDenIvNmt4ZGYybEVs?=
 =?utf-8?B?NEk0VDMwWkNTVEMrVmdHU3hYUjBvUGE0OG1xZ0xaV3NQcWE1TjBtVEtISU5y?=
 =?utf-8?B?NDBrUXZoVHFYRVdkVmNDVE9mWkkwRFNjV1p5ZllNblVzaXJCaVVibFlYT1Zh?=
 =?utf-8?B?SmJrMTN1R2x0VkNMenFiZmEveU5Mc2h4WVhKMHpmRGdpeHlIWlE5WXRQSFB5?=
 =?utf-8?B?ZGJFUGJtRU85NG9HckQwbXh0ODZIUWh5TFUrZm1sK3lVckJoaVFlZTVHeWZJ?=
 =?utf-8?B?QnV1NDh6WmUxdlNhTkhrZVNWYmRSVWEvdVQ0N084YWpiODIwaFJZbDc5d2VG?=
 =?utf-8?B?cnQwT2lMWGUyOGU0OUIrWnBEUFcvZ3lieVNEUzZmTVh5c29lQzc0ZmxUL1Zq?=
 =?utf-8?B?TzNYQmxTa2JkVkFWNDU2bHFOcVFGQTZpVVhnNXBmcmZqNjRKRktqTDE5VzJH?=
 =?utf-8?B?VlNENWZ6Zm1USGlLR2Z3NnVHczYvQm5LT040eWgvY0dnVjFVYS80eVVESkMw?=
 =?utf-8?B?L25sdTNJc3A3dU11YlUzbDFrb2xQSjFTNVhuU1FzMng2MkhMRGNjQ2RpMzhp?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e155b9e2-85af-4482-4632-08dc6e7b6098
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 09:52:16.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ds4qgn7n39DtptBUnTTjEwtf7tby2MH6z2NCdtkR5M/glIO+63wDtzAFlOmeFR3pF7FUaOlJ+b2wgFahYPqHIskjx2Y8hBdt4v0suy/h828=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6481
X-OriginatorOrg: intel.com

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 6 May 2024 13:50:43 +0200

> The first hunk here fails when trying to apply it to the 6.9-rc6
> based dma-mapping for-next tree.
> 
> Should I go ahead and just apply the first three patches?  Or do
> we need a shared branch with something?

My CI fails now fails to compile this patch when !HAS_DMA. Let me fix
this, rebase on top of your tree and resend? We'll resolve this conflict
in linux-next then.

Thanks,
Olek


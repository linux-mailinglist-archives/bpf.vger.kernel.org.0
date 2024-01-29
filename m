Return-Path: <bpf+bounces-20595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A98407DC
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B8B283E82
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02A65BA7;
	Mon, 29 Jan 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb8Q6mSl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370A657C0;
	Mon, 29 Jan 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537319; cv=fail; b=IbjrEgm2EfmOg0sRPZqRauNne0WwJbfXNJlTdko0Q/iW6elVHt3pPHWyIDaFR6TMKg3N9Ewe/Od7et3VHuYj4jfSFN0VNuubDgrqMz6iJnUhEYj8I8UTkZJ/7CQ/wfz3Zr7mYoQ1TJYXske0FGPMcIam75wUpTWvD6W50iE4vkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537319; c=relaxed/simple;
	bh=ALubBJfYFsE431iDIDaKrjjVhWVl4wMIA2PFot74AVo=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kT6swPGKkXe3ebXZ9oc4zB+j71Vhxy3dcTIB4GbiGlI0c5TKCKnOH7h6PSpP3W/1SzQ6IrbG7xBcj+OhTeKUjPY6iroubwqbbQKIqLnzB5aUxbQJf2xRephCtvUj89oFLacEeE+0g34LJRyl/X6+Lz9yMZnu07QlReMO2mOLTyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sb8Q6mSl; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706537317; x=1738073317;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ALubBJfYFsE431iDIDaKrjjVhWVl4wMIA2PFot74AVo=;
  b=Sb8Q6mSlwvbfM4Gtg3T4kydJI7rKLFcJfWElFYy073HSt31CxuGAEXnP
   di+rg87G8c85j1qQTL9GEwgXmUSIzW3YmkpCr1ou2cGGg34Gv78r0Irj1
   b8+erFYpuPz3u3PFOGlfx77itkl8MGgpQ/dxRwy7NHuS7SD2K+JZmoklT
   AZqB1kPOZ5QCwWCvk2hBQ/TfvVVBza/1j3wLqrURiEi9vUu9vc3c/luFc
   Fob4YqJofTaA71HRyU/5vDcCNywHAns7uSE+U1uuWYrxIngZ/pNwESlSs
   plUYCsNYViYjK0mlQZuQj4EPdVeFfDIu8gn1zzjMA9eZMkd+45Sfqqg8Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="402599674"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="402599674"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:08:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="821860965"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="821860965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 06:08:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:08:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 06:08:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 06:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9rgHRggQ2NATJZEqZF7fnJJJfi91UKkIKE4LE3FEm2dB5BIgfTMH2foD8RPnxGkjAEqmkKA+giY141HBJBsucmnXUJ2YBdmI8AFoVOLYf4wqPUo+UBegFubzn+RxL6tHLmu6h3YiRzQ11s6XFh4v0ps0F+QvT3Viil+LyROMAyORMKfwF+sI1fy3LyfQPF9y0GjgJIX9er/Q5P7ODw6pyBfz+BRUDiaMNvKqMj4QyHWXt3S5OxAQjrYVpjR3Xk4jzg7+dusDsCdws7UAnSWCxqiP7IhD6iKqABn+1IetvWcb8UQAzPOmC+ZPdZ0isqU+8FkEnCt18AeNHEOEjcmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrfQV9N1sfF2mvo65tbzfOjTjYKddOzIG0BJ1l1NHto=;
 b=UfqeFBOPsVMZPjclKezVnyvQh/VJBsGuqzjKqfyccIwa3PNtWs82Nxx3ZA0zp/GAzTfmPRodp2KNPvqqrNkO8n57pod5hrjcFjY8AgBbVLsBTLthzyZAyrlbA4SxiWemFFpFIUu6N+GZSoI2IYhQN5YNKwN5yX6W1CffHS90jSTtR741a00dSbRewmvJXFx7/Rhn7G8S/qBvERDngelNkNCuA5Py8blblj1d6b/BPAasToRQXVLMQKtbxmHYb1x1me+XPBiMXK6ozxlIq16RVKzegxAMl6LpW6OU+SFwy45RVGXg9bgAOBmzNzhTuf2SzO0pz/R/bsd8fsl6DuJG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 14:08:27 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:08:27 +0000
Message-ID: <3d9f7f89-9d62-4916-8f3f-a4aaad85a8e2@intel.com>
Date: Mon, 29 Jan 2024 15:07:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] dma: avoid expensive redundant calls for
 sync operations
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexander Duyck
	<alexanderduyck@fb.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-3-aleksander.lobakin@intel.com>
 <0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com>
 <7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
In-Reply-To: <7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM8PR11MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: a92e4153-adb1-4101-6d06-08dc20d3c35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h95djrgMKqSXCkApu0n/UGv6DDJrne+L3V07IoTmoI6Jf/C4UjorylFPdlgUpJbfgpNoDA18gSijSdKF4uk8A3AD62RDuFQNpav2nxhVVV0JQAZ5jW6jfnDj1xUVDChUmKWfA3to8ZzU+IFqNuXWab3kOImV5hClkIDHFUQAuFnxVpkBl62zqG5ThzDovZA2GlWQOz7CEfw2v64O5HUS1XFLu/2msQ8ZNGFpfygZqu6hN6IiK3tz1h9RqHQ+nnSrVx5e7IkXP5jYBubklp4mDJ8Gbg0fL6QX9bLf2r2mECxlnrFhjt1CICgPciia4SpXNKREZCHe002qZYl3AELp3OD0XkJu/NXJTrp1Zs9sG4abblSUJPNfDjpGQPi03CdUtDd790lXEOIt0h9otS4HKwh2EKW911Dm2O3Hn9fteo90hisKrHWqxQzCLvw+W6skhLJVS7820b9vbjctVaWZc9NnjE92u+JJTOxqFpC7sN3NNL3M5AR7w1+poMUSYcEgb2KGoXK63RUOrClV1+l87zYCpt4Qv7DCRx2Rg9G4wdNLsnK0ZFEB5r47P2Ui/DoOc/8RJAXX6zam4Bf5DaKgkSYZKJ9v9O7bAJnv/mai/4N+ticVHph471o8TJT09lRpMQJsvzFNYYKCUwqBrvaRpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(5660300002)(54906003)(316002)(66946007)(66476007)(6916009)(66556008)(6506007)(86362001)(8676002)(53546011)(8936002)(6486002)(478600001)(31696002)(6666004)(4326008)(26005)(2906002)(6512007)(7416002)(2616005)(41300700001)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVSSHdhdXJaN1J4S3c5OVJlZWhNNDNkQVFnQ043SmZzdW1mcUpxV3BENUNV?=
 =?utf-8?B?NEUrSUlmTDJGeUV3eWFwUHdCUHVHZ3ZzWmRRYVFYeUhONEFCOUNZazB0Qngx?=
 =?utf-8?B?TWdPVXBrMEV3N2JNZkgzTzVNM1NoVFNlL3laRk5DbTdVdThpZjVXTENYalNp?=
 =?utf-8?B?bERZdXB3VjBPR0MzaEgrR201THB2UFRGNWNRQnVnZXlUK0RWdUcyM05UaXNB?=
 =?utf-8?B?WVZSTTZPK2k2dzg5a0pqOGEvWFJUOC9hdlFQaHhxQTdVcUFudVg5eXZoK2pU?=
 =?utf-8?B?b1kyTmxaNnRxY0JjNUxiR01abWpPN2J6cXBmVzFKenplcC9VL0FVbGwrZVl3?=
 =?utf-8?B?ZDlSem0rZnk3MFhjVFlvQU5YMWVaRUFxYStYRE15N2l3Y0RSUjZMbU5Ra1Zi?=
 =?utf-8?B?L0t0RTJFNmtkeURZVzBSMnBGTFZObEovbnRCWnUwclo2dWdDMUlUM2dIVmdN?=
 =?utf-8?B?NVZTWk5vY24wZUc1Uko4L0E5ZVlGYUk4b3hXTkhKbml4SHhrZ0I0VEFVNnUx?=
 =?utf-8?B?QUIyd01xdTlxN3ZFMHNpQ2s5ZnlwU0g3L3l3YkRRak8xcEJDcjVUbWVkZGR3?=
 =?utf-8?B?TWNIL3hxc1RzektBL29TTVE3dnA2TjZ5MWMyNjVoam5pTjk5N0lWTUFPOCtJ?=
 =?utf-8?B?dnk1eE96ZTBaUVZzZWdvVkhxWGdaQXV3TG5OdVAyQ0dDRnNtSGdObmh0clJV?=
 =?utf-8?B?Y25NaWMzbkdsdVBPN09VZTJBcm4xUEc4S3JrUmUzN3pOQjdGNFFmU01qcXVJ?=
 =?utf-8?B?bzBKNUM4YjBNNTZjbDA0MnJNMnRCeU16bC92aWlHdVV0VXRxN2krZ0J1c0dW?=
 =?utf-8?B?b2x2Qjk2Nk8yN0I0ZDMybWxESkFPQnRSV2JISnZ5Sm03dlhCMmpicUJSbmlB?=
 =?utf-8?B?V2xnSGxMY0xETnJVRUZ6Tm94bDdYUjJOYVc3R1l1QnY1QThUU2phRFRleTBS?=
 =?utf-8?B?cHVzalRDUFNzN1dNay9ORFpuZmI4Y1I2V1hjNzVCWklBOFBwSGxuNFNtRDdY?=
 =?utf-8?B?by9EUVd0NFRvWVNsQ3Y2ZU1tYVRmbDZTc2MyRTJ1Wk1KUmFaQ2J6L3AyOWNT?=
 =?utf-8?B?bzJySWdsNndrMSswWEJkcjVUU3VoK2ZHU1hma0Z5Nm5oR1VXRENLZnVueHhX?=
 =?utf-8?B?a21UUFhPazZNVXZEL1JFUVNtK1JOenRkMUhBeVVQTFRoNFB5dW5JeEJySTY5?=
 =?utf-8?B?ZnZtVThnZjlGaHRwSXRlRXhlSHlaczJzRjIwT2RXK1VvVm44Nm1uK3Bid0J4?=
 =?utf-8?B?OUpqSFgwK0QwdHpQb1JaaE1zM0hxRzcxUytNbjNrNFh5YVRpbURweHRSVFdK?=
 =?utf-8?B?N21RK0lXM3VXR25JYkluZnZHcE9XZjdoODl5R085TWRNNFo1L1l3cFgrTWhJ?=
 =?utf-8?B?UXVKZ01GN3hadGNwMGQwUk5GUy9oTFhUK0FkZnMzOGw1ZXdZNElDb2lNdGx1?=
 =?utf-8?B?cVd3NDVGb21QMVplSTZzN1RSYko4a0RkMGcyV3NyaHVFZGJzbGRQTnNvVEtD?=
 =?utf-8?B?NVAwYkttRFhrNnFvaFlaRVFkUXZFSWxVZ3NmeFBaQStnSStpWXFpR0Qvd2hj?=
 =?utf-8?B?WHM4TFUwYXlCWVM3d29NUDBVYXV4a1Z1Uk9OL29uSVlpd3VkTHZTeFJVMUhk?=
 =?utf-8?B?U0xJVzFHVTZZd3RxTmFPOUlpbGpIbmFQa0xDTDdUaG9PV0FjWUpMT09zMjFW?=
 =?utf-8?B?YUwzWnZ2NWtiWk1jejAzSU9MQm9xWGsrUGFVYS92azNBWHJ2OFJ2K1Z4eitG?=
 =?utf-8?B?dUtBNitRMWl4TUoyU252bXF1R0xGR2tVNi83bFpBaFhMSSt0d3B3Rll5Wmw0?=
 =?utf-8?B?Y29TUExJWWpXYllzbUFDbWcwUXZsR0NhRWJPTzg0OFkybzR6cXlYZjdFVTE4?=
 =?utf-8?B?L0dqaGp5TVFUdWR3WTdqLy9sb2VrbjJsc2ZUV2hSZ1BlMEhGdnpLamovVjhQ?=
 =?utf-8?B?a3NSL3A4bUhuSE9LSnpWUUdSdUVOWmd5ZUlLaDM0NE5KbEQzT29Iakp4c1Mw?=
 =?utf-8?B?c1pjdEdqOGpWU2hQZVY4MGdwdm1KZ0RRb0t0Q1VRMDR4VXZucjBrM3g4VDkx?=
 =?utf-8?B?WDhqS3V1UnhtSzdYZU1xSEp6ZWloSmhTVHVDc0tZQ3lPOVZGR1Y1NlFsbE5U?=
 =?utf-8?B?NjYwUkF0YU9rQ1ZQajcyN1lyRm1BL2xSU0oxRTJqV0lxYVEzRkhHeFpxc1J0?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a92e4153-adb1-4101-6d06-08dc20d3c35f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:08:27.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX1gWGl3odRQYQ8Vg00cn7ZRUDD3cWPkJcE6BLpqByyKD1fLHb9qcOqVhgDSGpO24sZtKyc6TzcQ11we+BG8D3Bzd8I9DtKyM+Dy9ENseyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5669
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Fri, 26 Jan 2024 17:45:11 +0100

> From: Robin Murphy <robin.murphy@arm.com>
> Date: Fri, 26 Jan 2024 15:48:54 +0000
> 
>> On 26/01/2024 1:54 pm, Alexander Lobakin wrote:
>>> From: Eric Dumazet <edumazet@google.com>
>>>
>>> Quite often, NIC devices do not need dma_sync operations on x86_64
>>> at least.
>>> Indeed, when dev_is_dma_coherent(dev) is true and
>>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>>> and friends do nothing.
>>>
>>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>>
>>> Add dev->skip_dma_sync boolean which is set during the device
>>> initialization depending on the setup: dev_is_dma_coherent() for direct
>>> DMA, !(sync_single_for_device || sync_single_for_cpu) or positive result
>>> from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA ops.
>>> Then later, if/when swiotlb is used for the first time, the flag
>>> is turned off, from swiotlb_tbl_map_single().
>>
>> I think you could probably just promote the dma_uses_io_tlb flag from
>> SWIOTLB_DYNAMIC to a general SWIOTLB thing to serve this purpose now.
> 
> Nice catch!

BTW, this implies such hotpath check:

	if (dev->dma_skip_sync && !READ_ONCE(dev->dma_uses_io_tlb))
		// ...

This seems less effective than just resetting dma_skip_sync on first
allocation.

> 
>>
>> Similarly I don't think a new op is necessary now that we have
>> dma_map_ops.flags. A simple static flag to indicate that sync may be> skipped under the same conditions as implied for dma-direct - i.e.
>> dev_is_dma_coherent(dev) && !dev->dma_use_io_tlb - seems like it ought
>> to suffice.
> 
> In my initial implementation, I used a new dma_map_ops flag, but then I
> realized different DMA ops may require or not require syncing under
> different conditions, not only dev_is_dma_coherent().
> Or am I wrong and they would always be the same?
> 
>>
>> Thanks,
>> Robin.
> 
> Thanks,
> Olek

Thanks,
Olek


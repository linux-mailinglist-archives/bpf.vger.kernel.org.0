Return-Path: <bpf+bounces-18226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C2C8178C1
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390182853F9
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA667146C;
	Mon, 18 Dec 2023 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aui8BYGK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D925D74B;
	Mon, 18 Dec 2023 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702920578; x=1734456578;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xgK8an1n5C5ZA4oAm3a0f1yPfRfiHPLIMGCEPWCtrBo=;
  b=Aui8BYGKGlpNkbK/YsxgPBIeN28gRr2RYA4q7UXIDYzdun25iow7Iyo3
   48sNKn5VLELF79RA6Dfw95zx7qJP4Rfci9gsLKE908RWNGoHKS8fxT2Eo
   L14GQilEiEN+QyuQpo2+BqQpJ035T9AawSBACAylZXpyNUPr69pJqCPfs
   6tfFwbTbKG1h3PEbwTRPSnhWJL0eaIzXAyv0zhXSUtB/UDjHzBEiKejU0
   CRJ6UGzlSOLfXozBvnY52ZDXVupQuBHSfqeWHJPQ7cGdVfeV2ADkZDa1G
   UCp/f1bij1sq/vKPbJBysi5l6slJ66k9S9mDAEcnXyUgIK2XX+hyb+fxR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2747717"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2747717"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 09:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="768907242"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="768907242"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 09:29:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 09:29:38 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 09:29:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 09:29:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 09:29:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDlOzqQro9XSex5UQX36t7mmi7u/iYc1Rr5ZYe2XtgHGcRrI8k25+cVkk1g+wjN4hAOHw0OaEX7XlpOTCoPyO+ilUvrbR0Re5HaYUZ6TBXQmZrVT/q8LV9nTNo0eCO/N+TkSI9c8P/So2TsiKJ18tYvMdaVhi/BxPJbXQZP4ecN52Xumuh1tnjx66yocf0zabOHTRVkc15w/AmbwXwZ1biLfrRgq8izPmUl73PIHWMT/Lb2U8DeALZUsg0lfXd+Mg/RWFpTBtqtN/YJMq3kvcN1wB+TYBUFcu1zs6xVuzZOv6kUhO3b82ASrkl5iHzRdIhq5Z2US1Byk7J39PYd+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv1wxUpBMFCNu6Mnn7GdQdP8mLYXGBb71HSeRaTZ67k=;
 b=ElN+UAVhUwzktnKJjJ0eAegIudcEKk4+MUjjoGcFV3seMLKwL7C/2bpy7QEZGxq2pas26yIINdaQlUlbVt4RxGosZmmo89tnmb2sD+ExHUYtex8AuNb7pMW/ySeZpBzsCbK5YJl2dnfIfYzJTwMnM8qypTHeNo2rPWzMyIfJGtJ7rJ4FfRQHd6CMtU8RbeppgX4dAoWTNVshVtu40BJPN2zaQurhk9Vs1QdlGbm5IJDPtnlCS63peGpQtoDRY4EKe7c4gJNOntARjbA+3K9uQfjpPy+en0v1wzHMfodaZDCYMne+JJJSLGqysUK+ER9to1yx42TL8zAs4BUtYqUvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.35; Mon, 18 Dec
 2023 17:29:36 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:29:36 +0000
Message-ID: <6a440dec-9952-39ca-9022-1490c6626907@intel.com>
Date: Mon, 18 Dec 2023 09:29:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: Tree for Dec 15
 (drivers/net/ethernet/intel/ice/ice_base.c)
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell
	<sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, <ast@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Network
 Development" <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>
References: <20231215150128.07763fb1@canb.auug.org.au>
 <8b76dad3-8847-475b-aa17-613c9c978f7a@infradead.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <8b76dad3-8847-475b-aa17-613c9c978f7a@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f660498-493d-48c8-33f7-08dbffeee7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6znRkJmAe2TtJB61lwIWV52FT/gWlJks6baJvxmW6oJ4ATt6NtVWEGbsrJxWq9vxwecp8tuWADCrimjYN5u/9gusickybTFX/MXH38qA9kuitfZzp5LB8FfzX7DI/YCYOjNCc1c6I1AgFbEYShcD1j+F/c5CunWJISQNucanxp414ntdMexz7jDNRsTEyy41Hj/Z6THczUCwy3qVj5iggFrLRNpw+vKgc2GTKYjvpQJOzF3geBXaAcZGkLtaOpYYMgfCVOgtHLwXfk3ijTecKhthp6qAXof2gnjzoia32jaDOcKenVxelMbdl7cOhWYpowbu2JidXCvXV0qaLehkXs8tzqPe5gc0pUmKDMyEWN2wYtVokjMtgCQ7J0Zao+IdVw/EvL8pr75n+xLjfvcB2oQ1WBt0ZIbp8XI/2h+zKM6ZQr2GGQX4F0zjxhgIPv+d8UJZA+DRnT2BWLYbQy6LhIFJuQRX7a3sqmN2gl5qzvdd1wM7emnkagueR9ey3z5GFbtfkkHOCNgkkMvZGh3PJ4VkQU1s5omiRVKwcLQ0e3wbAWPW6W5z2JJdt5ARp3ZM0uvXRPYZXsbzcHvnsZ2m7CVX1LQb+QDmYjhvoeKlbsiEFj5X8FYHxZNYP+lBspk/M2Km6LQtH+5YNdiSjhRO/eeV7UlPCsOOogaYMDU6GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82960400001)(2906002)(38100700002)(4744005)(41300700001)(36756003)(921008)(86362001)(31696002)(66946007)(54906003)(66476007)(66556008)(110136005)(6666004)(316002)(6512007)(478600001)(107886003)(2616005)(6486002)(31686004)(6506007)(26005)(5660300002)(53546011)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxwYmc3RUhBc2ZrbkJJaGp0NVlsZE5kWitxdUZJcXJYZ1RCTk9FaWlLYnA1?=
 =?utf-8?B?ZU10ODhBQ2xqbmlTV3R2L1hCdTJoLzdiNk9uMmFpZUFTekhlSi9BN1ZEVUlZ?=
 =?utf-8?B?SGZ0dUhmZ0twVkxEUFU2cmZlNVFyVlZzR0NYd1ZZbmtaNEt4enJDay9FMjZt?=
 =?utf-8?B?bTl1MW5xenN1bGQxMTBQS0owU1RxUXlQeFpZdFVIbjZKMjAweHFXN3BSWG1R?=
 =?utf-8?B?cVV4OXhVdkR5UUxrbnMyRFZuY250VGFUckdFTlVrRXd0SG1TVW5WYmRGbUhu?=
 =?utf-8?B?UVdNTytjL0h1cDFTMjJBTTVmMDRPcUtCSDV3ckZ1dzdOTDgzTSt0ay9VY1Ft?=
 =?utf-8?B?Ty9DRnJoeHN0Rmh6eGFzdEFQNG5YUnFIb001ekE4QzgzTXJHcUc5V0kzaW53?=
 =?utf-8?B?QWwvcys5ZGhwSkpNYWZiTkdJOFFUdGlGc0tsQzEvOURJMlBsZWRnWlM4aWEr?=
 =?utf-8?B?MWFkbjFqd05CMkFNRllUckd2YXp3RnZINnd2MnJpMXFZdjhueEx3UUFHeDdH?=
 =?utf-8?B?T0ZjNTEwZEk2QW1TOHFLVnc4ZncvbkVjdTlzcllUOWdNR2g1OFg0NUp3bHZx?=
 =?utf-8?B?RUNsRThSZ3RMdUVWbFNUVHk5Z3VBLzVwTlVBMFl0WExjajh3MFE1YVdRejEz?=
 =?utf-8?B?bUVRekYrQVZEbWl0SGJ2NDFEVmFlVGRWOGxianc0dU83Y2tHQnNJYWRsaFgz?=
 =?utf-8?B?b1FPR2k1ZFowOVo1NmNkQTJhaG5mdmM5L3E4NE1CU3F6R0NmK2VkQXhNTk54?=
 =?utf-8?B?eUVGdTF3K2x1aWZuUUhHUlh5SStjRlUzeTE5cDNibTFhQ253eTdYei8zMmRD?=
 =?utf-8?B?UFJZSktTTDg1Zk5yQWlRbjJRZEtUQlFUQTR5VGJaeWdqRWJBeVI4VmN4SmNt?=
 =?utf-8?B?Wk8xYmpEaS9PWjllVXE5bXBOSy9GSWtxeW01V08wbU43VVNzWFRxcDVMaGNz?=
 =?utf-8?B?ZTFmMEYyUHFucmdMVTMvekdvd01Yb2IrTHNHOHJVWElaL2xjOEtKYUtQWWxs?=
 =?utf-8?B?cklpdTB2T1JmcjVYcmNnRWxTVURFSjRFZWNMK0tac2VoUEdPeFFLdHM5TTJq?=
 =?utf-8?B?VnRVSndwU3JEdnpaUHBCY1FxWmR3WWMwMW5LbUQ4K0p5U3pMaG8xVlcyckhV?=
 =?utf-8?B?MFUvUWQ5akJ6S0lYYTB4cDhQRThrd0I1Z0dMYlJSSVkxN0Z5ZUVJbUtScGVM?=
 =?utf-8?B?dWtnZmdTSmNwMkp6R2cybkt0WW5jZXBFaVJ0azRsWHVHRWw2amVsQXpZaDZG?=
 =?utf-8?B?RjVHL3dmOG8vQldkVmR4SDNiaVp4NTZINlc1SnNScHJvVXhzaUd6V2VhOXF5?=
 =?utf-8?B?VnNjTjNrTnJCTFRQeExHcTV2ejNWUTJxN3U3THJ5RXRYSVJwOVRrby9XT01E?=
 =?utf-8?B?Rm1TQjdYSzRnTTg1YWRRNzJyNXVuM25EUkxJSkw5bllmVzNwV09OUlUrOTNN?=
 =?utf-8?B?dEd6U3pEWnV0YUdIYjV5eEFsbnpGeTVQaTI5NzRqSlNrVEZOSWdtWVRWQVRU?=
 =?utf-8?B?bjV3V0ZKRnUyMk1jZlJtRzlycXlYbXR5SEFhSXBEby9OWWtlNUVFQlpzdlMz?=
 =?utf-8?B?OXQ2Vm9QSUNnVHMrZEJta2NZR0xjTUV5K0ZrZ1pVNWdXSUN5RGV6VkVFenRC?=
 =?utf-8?B?cW5JWlV2TGJ6dnFVTGhjRkZqTWxkaVoxQ2ozL2p1QmpuUHErY25RNG9nanFr?=
 =?utf-8?B?YVM1aEtjaENjR28yby9abzdESHpIWHBzd1J4MTJNR2QxT3loeDBPRHlHOVlT?=
 =?utf-8?B?Qm5NdFNLUVpzNjYrakV0WndQbVM5RXRhM0ZFVXRTMWRQYXcya0x6SjZ2REFZ?=
 =?utf-8?B?Qk1VTXlzQmgxSzVEcDlGK2VXeC9QMWRYanNXYVdxc3VKRm5Pd3IxZTJTek5Y?=
 =?utf-8?B?RUgxSzJWd2JSQ1VpVzllUGtTeVpxN0cwRWdPRnNqV2RXYzBONG9WKzRMaW5O?=
 =?utf-8?B?UUJUS0tJcWZSVkY5NnR3b2JQVGpzQ3FpcUhLWTQvb1lOTlpKSUtyM2x1V1lK?=
 =?utf-8?B?MVBRYllNa3hjSDhpaWN5Zkk5SlpreFRIa0thTFAvNzhIcy9PUXNqaDBGd052?=
 =?utf-8?B?ZTNzV0VmbDhSMm1YSXdEZi8vY3BFNk9NditBSWNoeU9oR3E3aE5wWDRJczNm?=
 =?utf-8?B?WGU2WUo3bnpLTDBsa2VqSzJjUHpMbWhiVVlISjR3cUQ2bllJaWV5TElsYnRN?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f660498-493d-48c8-33f7-08dbffeee7fe
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:29:36.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F984TJnQuijBuzX16DStIpbazIM14krAU6cvBrv4okOh1XxwqiMtbEZSzEeeWXb7haChW1esUupSmW/T2xVlEwCKf14msQ1vLwJJ8OlCpBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com



On 12/15/2023 9:26 PM, Randy Dunlap wrote:
> 
> 
> On 12/14/23 20:01, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20231214:
>>
> 
> on s390:
> 
> # CONFIG_XDP_SOCKETS is not set
> 
> ../drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_xsk_pool_fill_cb':
> ../drivers/net/ethernet/intel/ice/ice_base.c:533:16: error: variable 'desc' has initializer but incomplete type
>    533 |         struct xsk_cb_desc desc = {};
>        |                ^~~~~~~~~~~
> ../drivers/net/ethernet/intel/ice/ice_base.c:533:28: error: storage size of 'desc' isn't known
>    533 |         struct xsk_cb_desc desc = {};
>        |                            ^~~~
> 
> 
> Full randconfig file is attached.

Adding bpf as it's from d68d707dcbbf ("ice: Support XDP hints in AF_XDP 
ZC mode") which is on bpf-next (and hasn't made it's way to the Intel 
trees yet).

Thanks,
Tony


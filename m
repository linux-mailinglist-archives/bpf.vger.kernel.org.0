Return-Path: <bpf+bounces-4609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526A74D865
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9761F1C20A71
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F85125DE;
	Mon, 10 Jul 2023 14:04:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C25229;
	Mon, 10 Jul 2023 14:04:26 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202EDF;
	Mon, 10 Jul 2023 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997865; x=1720533865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DmFi0mBBkwNRXtp6+5HD9K9UaEfrigwnZbLJ3Dz/f+k=;
  b=F9ki/ykUfYLCRXgq3DlVNBqjfS/Ms1Ivsc2h1Xzug5HctXIsJ3waQTpi
   Hl/dGEvp1Wklp7TIOfwLG76k/fD7dTeJHyn82OdxVzcmaE04Eusn5qRur
   IjLaUefFeOk70Y5DuSqFpHUqToa6aT52EbAGyVspKmZE0Z6ZiKJun9Ecm
   bwe1Iz38GQoA/YNqd5QQlBB4lrF/y8oTLMCPMUX+YqWlf2hox/ZChyWLB
   MIJLIlApn0ERVn6RldR+JKPoQ8kQ5Uiz0WHaGEKkCs9NS/DTHB1mnpAwi
   sOCdjD4ir0LY7CZePmXPmlrjUt7VbxktGowAd2SM0rgzzIPJRzdLIv+xN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="343945164"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="343945164"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="844882426"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844882426"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 07:03:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 07:03:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 07:03:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 07:03:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 07:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlhQXhgAE06qpNDazgT0hUyIynob9aoFhuZW7ma2LuTIMrtoHokvMF0UMWJxNkmtbxgAxHwJ34wWf59kuj+s8oljPuMzRfsybHYzFiBtXy1Em3BhMT8T8374ifpe7eYCaLfv9ABc107j+mZyXQesm1oy4d9mRWmMXeqsn+epvU5CHlwENSMgXMEkvfyS6LTsIqaynw4HxWkVh9Bdv/3Umwd9M+6JDVr/7x7eRL/Tdj0Dm97bf5k1hpM9i+e3v+Z53dD4ySfw0yIrkM0pWJevKqEr5fbdtlkemXvj45bMclyCoBLqO7AWFtKqfCu9P6ksdL09XiQrj7tdRBNb/5mnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjWn3yhOjQDJQO6C3ufsiDxgyfE8y42pE15FMhg4Dbo=;
 b=hxgJbRP5OBRoOrwTOqQA8iQQNxOHW3sacu6mJkZpIABHEl1CBltVLJDLHDjKm7uRiFfM/w6h3G5LtnQre9U+Q4p7U9L21opgC39LbWlSSIT3WbET2Kl42tmgOgYHpTW4LEu3wQg0YBonwErOdtS/0QSyNiHpvt0EmegGU2l6v+8RjQ7odd//t19ZheJTkTaFz9kFE/fG8IKCHlK0RG5Ku3+YLI481BP2fMTO7iZ8LpUJ23QgwOdA8wzsyugG9QukoIP9mQ7PA7QdSgZeWGV7HothT2dD8T31fLGen/yspQmokZXAIscTLmNEZrHVmA4bAEdL62Hmxaq/4ltNQze1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 14:03:05 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:03:05 +0000
Message-ID: <8821258e-08e7-8128-8275-74ce550110cd@intel.com>
Date: Mon, 10 Jul 2023 16:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v2 15/20] net, xdp: allow metadata > 32
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, John Fastabend
	<john.fastabend@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-16-larysa.zaremba@intel.com>
 <64a3386623163_65205208fe@john.notmuch> <ZKbU6qaPUN/gPY9t@lincoln>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZKbU6qaPUN/gPY9t@lincoln>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e02b5af-71a1-477d-2709-08db814e617e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeLO6r7lfP/qCb450cN8mvDN57TOIIv+Lrv2D/MOchPLqqjDpNIYm0ZLHsK92eKdmtncnjYMkZK8rs20JLaSx5f5fJFH+NJ2KYqOmAoSYt5LL1lT1YFoBEohfIZFwTmg8wsKVulAjmgo2R9OD7AkkHZ/NTbQMUSha6EaMm65blTQNLBNI8vWcbstqcQGP1DIq5EyRRE1rP83GMKJuaTQ5qhI1gDq03x0EjrO34GxrT14b2O0jpVxif0TLbR+kvPTseNF/ZUsxYzTzjLxlU5BbItjvofNDcneCiVrw2dgYMP8uRg1xGXk0mW7aNE1oWTilZUwWIs1LayN/6zrrEYkjgAUKQjl0ITN7P4U3mm6JM/3Y+oCsQVQg1gj9whtkD+zTNslrp7zRi9l/YYIuliDc1tU7zvNZKe2Ey7cmQNkarFthOB4m7qC7+KWJfbcxZ4PSJk9vt+OgPh8arloG8cvkPO5kY1WHgKUDRwVXpNNfte1G5Sb2fHLuZ/81Y3B3eEjz0XbgPTyb2+knAqJkWC3OtN2fAU0PXaTHngDigL7RdIQap95e6aRHFuWt7J/IfIbFZqMze+bG3veS93Oz5syiJtchV0rd1MSgK5Ua4tf74texqTZ+FRQiiEwna0i13CVWyLAZomlwjUQs1WSx1rPQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(478600001)(6666004)(6486002)(110136005)(54906003)(6506007)(26005)(83380400001)(6512007)(186003)(41300700001)(316002)(66476007)(8936002)(2906002)(66946007)(86362001)(7416002)(5660300002)(8676002)(4326008)(38100700002)(66556008)(82960400001)(2616005)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhnbTJQdWJTU0RnVnE4aGZzR2RZWmNvUlhMTHJucTl3bytObEpUOGtYSFZR?=
 =?utf-8?B?cjBtQ2o0UDFPRy93MStMenUwWlpJVEJCTjZrWlFkUXFNYjFwTEtZTDcwdGRK?=
 =?utf-8?B?UmVlYi80bU44S1NsN3pxRTE5cnJramZDVFBHaThabDlMNm9RZ3BNMTQ0aUZM?=
 =?utf-8?B?N3pQRGVqQWk4ck1IcDZCT29RQlU3ZC9YWlpocmZJT0JXTkxrYytrNjQ0cnBJ?=
 =?utf-8?B?eXZBMFRDSzlaVFZ3Z2V0UVQrZjRMRFB3Qy92RXlmVHFncnZSMTBCWTdBYm5j?=
 =?utf-8?B?RFB5ZVlNeHY2bEhKNDJWVTJqWGYrUWIxVFVmNm5ISjMzdUhubTN2aHpBdEpu?=
 =?utf-8?B?TG5NbWV0ckxMdUlXd2hxTlFaTWl6a3ZYYldRQitoQ05ia0dDSmpES0UvK1pR?=
 =?utf-8?B?S2JzUHJDcFVKTW4yeVZCQnZJVkI5cEtndDFnV2tSV1pYVkZlN3c1RTI4RzM2?=
 =?utf-8?B?OHMvK2dJQnNKOW9SZkxKMUJtSk9wQnpqOTYyYmhPN1Y3YnlYSDJwb0ZrRGlu?=
 =?utf-8?B?YzNIR2M5QmhiVVhEQWpmeGZoN2Y4aWNZMThpcFlXQnN1dlJDV3FhN2ptVTFX?=
 =?utf-8?B?TnR2QUhTWForZEdJNVdNTGxaSmpMdEFzTkdUNjRCczZVekZERVdkd2NZbVZR?=
 =?utf-8?B?UEFHekV0U1lrWnRyaktPOTc2cjZUY0lmb0NRMlRoaldWWG1IVzdWNVFRaDRR?=
 =?utf-8?B?VUt1L3ZRMTArWWxhbGZGcnZRUUd0RWRWZ0syQU9WTU11aXZhMXBwTnVPRUtt?=
 =?utf-8?B?NUpESXdNSXZXY2hOdEFXbzZ5WStYNHBmRWNQdFBJbFRrbzV5Umx3OVVEV0lW?=
 =?utf-8?B?ZElidTM3Vm9SaGVJYVdhRE4xbDQ5cnNHakJVUmlGLzlpV0JIQlBwL1FzZExQ?=
 =?utf-8?B?RGc4YmlKak1kZUl1LzdGY2Q1MUFpalo1SkVIWThEZ0JxQzNDRTFpVE14d01L?=
 =?utf-8?B?Z2dXVW1ENWg5dEpHWTZVeFdEZkxmeFczcjBWVzU5b2xrUmZzT3ZMSHFWZFdo?=
 =?utf-8?B?MUZQRnNTekhVcGcxdlk3bGZid1ByeFQ4bldleXYyTDUxUVdFdzN3T0gyOWNH?=
 =?utf-8?B?a1pxMmhDMDNXK3F1ZFdGRVIwVExjUVhHU2pEenNPL1I2WVMvTUtMczZrMHR0?=
 =?utf-8?B?M3gyR0VFNGc5cm5KcS9YRW02M0JNZ3NleDhFUWYwbWhuc0xSVFV6NzVCOHRs?=
 =?utf-8?B?YXVXUTlLVithQ2ZWYTNMWDFQSDRFSU9IYkNLU3lsOGFyVkg4YmI5bXNXb0Nz?=
 =?utf-8?B?TWtWYk1sT0Q5Sm4wWS90ZGhKS2kxdUF5YmtTc2gyaU50MjJxNjJrUkc0RTFM?=
 =?utf-8?B?aUYrU0syam14aW9YaS9NK3dJMUwwMHhYSFZZcE9iVHUra0FHaXNTZjF3T1h6?=
 =?utf-8?B?V25EOW5qR0cwSWIxOGh1clBMQ05mTGJTYUZLZmZyNktvb2pxM2NNampLL0hz?=
 =?utf-8?B?SFdEMlB0RUx1RVV5ckJ6bkRXdlI4ektJV2FJcUxIQWM1ZVQ5NVRVVGVTZjAz?=
 =?utf-8?B?L04yMmkrQXhlb2tXNTlVVmc4dTRDNTRIUm9FUWVva3IvKzd5N3EvaUY5cHRV?=
 =?utf-8?B?M3hBeEFUQWxEb0x6WEcwT1h3YXI4MjJzZHI2Ti9VNFFKcDAwdVpJQk1LZVNX?=
 =?utf-8?B?alFvVVg3TU5rVWc4eENjL0VzZzZQWExFTmpYWG0reGlHeW9jU2o4OUtlVzNt?=
 =?utf-8?B?UDdqYzBGVFh0UFkxY3BrQ3ZxK05JOXN0TmdFZEVidG1zeEtQNFpKSlZQOUcy?=
 =?utf-8?B?RzZCcHpiaHFjY3AzcnBlVnJMNjJhTmJUcG1MbGgvd3lsNE5Mb09YR2pkYmtX?=
 =?utf-8?B?cUxoS3I3aFlqTlNkMUljL3lFcHh0OHlGR21JRWoycGpPcDlGRXFFZGE5dWVF?=
 =?utf-8?B?cmtWMFNERmtwVEpRSUFvamhKWTRDbExFNGt1ZCttekZsa0ZFVlF2U29Na2Y3?=
 =?utf-8?B?R3FrckIwRWFPbUo4TXdIZlM3SVB3dFlBanNZenFKaG9CSWtyUlIvWUlvbHdo?=
 =?utf-8?B?dmVNK2FMU0szYWxxNHR4QVZHUmF4RFIzREdZL2IzWm1XRG1oQlEvK1p3R3ZQ?=
 =?utf-8?B?V3NteXg1MVoxWDlCbk0wTUROdldBWWZGQ0FEb1Nkbk1hOTlyMGNGTkZYZHFX?=
 =?utf-8?B?VVhtWmRQNnY5TVFublpOSTQrMkljZFJ3ZXlVTXpqdEx5dTErOXdaRmI3SUpY?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e02b5af-71a1-477d-2709-08db814e617e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:03:04.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLbxQw89F1Fh2KOpRiM3XjxpGazVtLmpV2nZsIul8Xrjyw3/UIcue4HGwFeRX2SN2kCRogP/nWiYuTBRWXULkePRxerzIHr6HXvJuSQzvZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 6 Jul 2023 16:51:22 +0200

> On Mon, Jul 03, 2023 at 02:06:46PM -0700, John Fastabend wrote:
>> Larysa Zaremba wrote:
>>> From: Aleksander Lobakin <aleksander.lobakin@intel.com>
>>>
>>> When using XDP hints, metadata sometimes has to be much bigger
>>> than 32 bytes. Relax the restriction, allow metadata larger than 32 bytes
>>> and make __skb_metadata_differs() work with bigger lengths.
>>>
>>> Now size of metadata is only limited by the fact it is stored as u8
>>> in skb_shared_info, so maximum possible value is 255. Other important
>>> conditions, such as having enough space for xdp_frame building, are already
>>> checked in bpf_xdp_adjust_meta().
>>>
>>> The requirement of having its length aligned to 4 bytes is still
>>> valid.
>>>
>>> Signed-off-by: Aleksander Lobakin <aleksander.lobakin@intel.com>
>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>> ---
>>>  include/linux/skbuff.h | 13 ++++++++-----
>>>  include/net/xdp.h      |  7 ++++++-
>>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index 91ed66952580..cd49cdd71019 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -4209,10 +4209,13 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
>>>  {
>>>  	const void *a = skb_metadata_end(skb_a);
>>>  	const void *b = skb_metadata_end(skb_b);
>>> -	/* Using more efficient varaiant than plain call to memcmp(). */
>>> -#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
>>
>> Why are we removing the ifdef here? Its adding a runtime 'if' when its not
>> necessary. I would keep the ifdef and simply add the default case
>> in the switch.
> 
> Seems like Alex has missed your message, but we discussed this with him before, 
> so I know the answer: Compiler will 100% convert it into a compile-time 'if' and 
> this looks nicer than preprocessor condition.

Sorry, I'm not always able to follow all the threads =\

As Larysa said, it's not a runtime `if`. Both conditions are always
known at compilation time.
And this looks a bit less ugly than with ifdefs to me :D

Thanks,
Olek


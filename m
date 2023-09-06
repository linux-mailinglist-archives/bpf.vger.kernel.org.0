Return-Path: <bpf+bounces-9328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AADA793C36
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 14:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455FC28132A
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C1101FA;
	Wed,  6 Sep 2023 12:05:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6A3D9E;
	Wed,  6 Sep 2023 12:05:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF4E6A;
	Wed,  6 Sep 2023 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694001924; x=1725537924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uQ95qCafV8iHUD6aIavNtluoFeDHAZvpKGp2cNjN4Vg=;
  b=CptUVWYpZp5fHmPWH9ey6k5DHxkSqw4y5iyX08aS7TqXsDIQg3mWFC08
   6p1hlYAeCqTrLOzBSM/svGPRKpdzH3pzS6hM/3n0MNe/YRdBQm5vi6BGX
   1e5ThEZ7MQ9f1i6XGnwyIC1fJxlgfmKpF6EAT5D9b06CAytJFlkGoYF5B
   XAWICCKmB6Op/h4CBUSlLBBSLYlErEM552gfvZ3qYSRxr64E76x/pfgsG
   /wXUH9ejJo/9kSjtlT+GcRploeKbkXVYSEWG1hLm4fD8tdBUqS1QyrCoL
   nw/QugMxpEzmzUX8UuPPUj24VF+UA9xdl1z2Ghpa4G+eqlCT+KfrSfFv5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="443441285"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="443441285"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 05:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="915245295"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="915245295"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 05:05:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 05:05:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 05:05:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 05:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvWaPbM5ERu/Tsh1fAqT8HzjAM8XbWuCd3mh5OGvnJ260yRIfJQk6c+8CO0OkEk5VphIFZScw1wwY+TWFpeNYzBHMNdbNlo0aKOf7SIHiY2OxXRgZBjwQ+FAno9NJJZs3fhK6s2OY1OHEb9XbVkHcUKlJqQvYsDltNO+a4zkslRMnQ4ej8xrQg9YVP3FU0B1z+ISlIcOJ7DOaV/k3yO9dlY5GyQtRZZcvv11bFMVvOkFuzg1ONShGYAm11Sh7BJ/SGtc9nIhNkHvh9L+oAlmMAAdifezAr00aom5C3eXSPlpyx7HVlbCf4QgSpXBUOwh0LzeaGfu4e0vWtVZvnyefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzzCTcEPPZaHAdDEH8XEIwK8jSASIUTN/P7LVgwUOT4=;
 b=jZ0DyLg1LDBoBjLnoHMqLzm416wSBEuwhb1r/avrGe7OkejpqQdJG2r/pxYvKnxiGh9eeIxIed+So0DAttj3VS+AVftfR/PVeF3hnx22fI96AreX5t6DMoC6T8kVDJuy2YZp5tZc4m7/Cz1U8whF05XR7fkYqfzaZs0FBlVJl7YjrocBG2tLExodeDRjOPie2VuUXl/HB9ZIhpAE7BNSWrbwniKQ+zYwzenVs4xUd0XlmZ0j0X8QzZiwRl5W1ART610AggeT2lpGznOwWcuuCMOzV7tsFUQ2Gzy32LdpMxqj80kEiRkbjeqKQiQBaVCCDYgtVXPpkJax3i2CShJS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:05:20 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6745.028; Wed, 6 Sep 2023
 12:05:19 +0000
Message-ID: <e9a0ba2d-3815-fdf4-ba07-cdd87fa00fe0@intel.com>
Date: Wed, 6 Sep 2023 14:03:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [xdp-hints] [RFC bpf-next 07/23] ice: Support RX hash XDP hint
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-8-larysa.zaremba@intel.com> <ZPdMTG6INvxUV0Jh@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZPdMTG6INvxUV0Jh@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fd5d50-b712-4a97-17b1-08dbaed18a45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+j6PnECIza0qW8+nvBqp3LXyPN7KrxBr9sLrdaeY33zQ9Csu/UE99TdsPOOZ0IBkk7p4flgsz75Iy0cMSxLIhocxRoDpX5uUfmgL7bl1SRcKllojVW3Q8mXADkpibPjHnsgG+vcU/1o8uh8ZL1d5VYloW6qj8HtDCZrS38e7z2eIhSCsMbJf5GhdiHuUIfOwagORIIz75885k8jvmlphk6bAquqikZZxlEBIm4ZNk8F/bGKn1BZCDpOfw1BV4KVfw9TFG3Rlb8q00D/DyestHqCLB/Yfn3aq9XC+jsm2RPU9nQcuP4U41i9Q6Q92mUQr6V5N5kXWXIdEs9gEWK/H8Mdr5eM7soiJaMEw+J8Sz1G79cN7y+/D3j6MtrrpzhJdaYZjt30/tUTvoKV1XqNV4XdpDZ3V3E4e9dzRGGOX8l9T9dIl9Yyeogwi8phXEtwsOyXkA8pNflm+NH6eU1fhy0DFwlGo2mYbRxCY5VAutd+1TaxR8A0CyeN7xEk0aWSpxgu4UTppOz79Q2lc1TIu7a3cSUS7XWQtgTOVO+I0Ym+DXtpSCIsYy3a0UEejLb9wHrXJjFcDOVS/JYppJoZocJd2Ef26ElduXeTT1nJoJaHJ8L5rBK6xEt3TXLfcxfnS16I9+hIlL6eW2cmiRmT8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199024)(186009)(1800799009)(6666004)(6506007)(6486002)(6512007)(83380400001)(478600001)(2906002)(2616005)(26005)(7416002)(37006003)(41300700001)(6636002)(54906003)(66556008)(66476007)(316002)(8936002)(66946007)(8676002)(4326008)(6862004)(36756003)(5660300002)(82960400001)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFREM3RQOTVOcE55d1BQYmpqbVpQaktMMC8zTjJjRkFYajJUU3JXc2hJQ25a?=
 =?utf-8?B?eitpeDAvY3puTVVFTGFyNm13Tk9Ick5pZ0w5cFp0UDRaVVRCYnU5TG9wYVZn?=
 =?utf-8?B?Ym1NUlNRUlpYUWxhblBRb2tQTGxLd2xkR3k3enBxOXcyL2gxS2VPWTN3MkxI?=
 =?utf-8?B?VjcyeTl1cEJRVG1DVVZjWmE2K2xIMlZJRzljR2ZZMmdOeDhMUnhNeTNZMXgr?=
 =?utf-8?B?ZHpBS09Ed0IxSHBDb09rUzFkU1NlVDM3NCtwMmhRTWlKdmdyMWVhNmZHeHJW?=
 =?utf-8?B?VkZHSkdtRklncFo1bjhKTUVNOGFCdHlIL3dJUmdSdGNFMWZpaTN6UUVHeUJw?=
 =?utf-8?B?aXVyZWN5WEF0blJEZ3hQV0R3VHVxbk5paTIzLytrUlRPbzkra3NWNDE3N2Rr?=
 =?utf-8?B?ZmZCV3UvUzMxTFY3VDl3UjFNTHFoNUVvb3VHaXo4V1UyUVpHSUZNclJqVWFQ?=
 =?utf-8?B?NzNPRFp0L0I5anNYMXNqRVp6cnVIbzZHSE54eFV5c1hDOWk5aWZPV3F4ZGlV?=
 =?utf-8?B?REl3ZUdBOEtsajM4cFowZk0zYjJ6VFc1RmdCNWJUVStzZUEzdFZVTzRpSFZX?=
 =?utf-8?B?OW9PVjFhdExwQUtJcGxXZUoxRVVJczY0VUNCRG0zTXl2RnR5R3RhRi9NQVNw?=
 =?utf-8?B?aFNvcDFZZGJhT2UrbSs2UzRaQml3Z0puY0ltQXlwNkRicmpKbWtjOGV2dXA2?=
 =?utf-8?B?UTFTc1VUUHFXdENNUm5FNEtMSmdPOU9BMEVnOEl0bXFWNkVuREludVJTTXpk?=
 =?utf-8?B?TUdsSE13aG9vQTZvSWh5U1l5YmNEbkRodEFVVi9iQS8yckwyUmordEhaZ3p6?=
 =?utf-8?B?MSsrczJXU2g0eFBoOVhmdURqeGJMckk3Y1h6elI2eU9vS0FabWVBcEtUUDNh?=
 =?utf-8?B?SjlySXR1MlowUXpDTmUrSTdBNFVUbnFBWkczQ1pENXpLWGtJaVk3RFMvamxF?=
 =?utf-8?B?dXdVUkJyOHVXZlVBWUZHMWhOZWpCb0RCZ0tQZDV2WlA1NlgrNTU2YnFBclNR?=
 =?utf-8?B?VndiM0FWeGd2TVl3a1dzb1A5T2FERVJ0bUV3TS84WTNBcE8yZm1wZTZFUmRZ?=
 =?utf-8?B?OE5pbHB1Zjk3OTNHck1xTkM2Y3VCS3JuT3dLZVpsOGY1b1llZ2dxK3FRVjJG?=
 =?utf-8?B?a0lDNXlYYTIveTllNmVucGZJcGFTVG5oeGU5VXVMQzhRelRmNEgrTmttSnBs?=
 =?utf-8?B?KzlXSEN1aHQvVjZSQnNXMER3aEg1aUltQ093bm1UZENUTlZIdTBzQWcrclVu?=
 =?utf-8?B?YlJwMmNHbTkwcjBOQ0lsVWpqMHMxL2JkRUx2akhZVjNSUlI4eXRPN2t5L1hQ?=
 =?utf-8?B?UnN0WUJiNGR3M3pXNUdiSXpFMXBkbmthUWo4M2x0cGs0alV1MnpYUURSODJr?=
 =?utf-8?B?cDNTMGRPNlBJWXordTJMRGlSZ3FTUkIzS09OSnI0TkxZcnNWaHgrbFdWdU5p?=
 =?utf-8?B?VkJtelJIRW9PdzZtdlZUM0pTbHd0ZkM0eVJpZGdnWmJSSjAvamViTkRxYVcy?=
 =?utf-8?B?M2ZONS9ENXh0YWJnQ281bzgyOUp4NjFlTVJ2TEdjWEJTNWtmRXVaMWlwNXZL?=
 =?utf-8?B?TURsL3g5OE5pNnY3MzVETHpQSDh0N3g3VURod2Y5ZmJrRzd4WGUveGU5c1Jn?=
 =?utf-8?B?Q09kVVI1clBUVmtlTjlFdTZwV0paZnJxczZMMUhBOVhZcDhGY3FCUjE2ejVm?=
 =?utf-8?B?M0pmRG9yOFB6YnFUSkkvdnp1OTBmNTFBYlcyMzBKTmZDTUgza1R3Wm85WDVZ?=
 =?utf-8?B?U0s0WGMzYnpqN0FOaGUxd1FCNnh3aXd3ZFZoYXEyL2VaS2xCcFRoV2pSM21R?=
 =?utf-8?B?NHdTdEplVTRGWmd5QUhSclQvL0lKMVZaZjdGNEw5YXNuK0pnbFEzZlc1ejJ4?=
 =?utf-8?B?UkdVaU5KVnlLNFdKeE11YXdNUG9KNTJWWmp5c0xRb1lzK1hkT3VmTVBPcUpJ?=
 =?utf-8?B?RWZ0TWtMWDh2TEROYXNGLzNvUjN2V3dWMmJaQURCRFRYQ0h4Tmh5dEJBV1dS?=
 =?utf-8?B?dk5BeDlpQVNEUHFmY0F6OXJTMDlxQUNiQ2NrMHlYM0NkU1pBK0VmVHhaZmpi?=
 =?utf-8?B?YlBCSDQ3d1lLTjBzT2ZMSmM5cDFrbHlYc01ieXk3T1JYbHhscGlwdklSREw1?=
 =?utf-8?B?dkZqYzNwaU1oKzgvWjFTQVdNMC9WRXZENFhLV05hbzF3NjZCM1Q1Y0t3cERK?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fd5d50-b712-4a97-17b1-08dbaed18a45
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:05:19.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq7pysuwip7RllrOwixK+Sh4QUFsrMdpHqNThaZnHk6E7yUWHN2VTM15e+d9YQkPdpvbgmen3URlPh3n35Q4e85sIA4rQRnHFvoDy18MbNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 5 Sep 2023 17:42:04 +0200

> On Thu, Aug 24, 2023 at 09:26:46PM +0200, Larysa Zaremba wrote:

[...]

>>   */
>> +#define ICE_PTYPES								\
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #34: FILE: drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h:676:
> +#define ICE_PTYPES                                                             \

[...]

> ERROR: space prohibited before open square bracket '['
> #476: FILE: drivers/net/ethernet/intel/ice/ice_txrx_lib.c:580:
> +#define ICE_PTT_UNUSED_ENTRY(PTYPE) [PTYPE] = 0
> 
> total: 2 errors, 0 warnings, 0 checks, 525 lines checked

Those all are FPs. The same "errors" are present in libie. checkpatch
doesn't parse the code like e.g. sparse does and it's not able to
understand every #define black magic we're able to write :D

> 
>> +
>> +/* A few supplementary definitions for when XDP hash types do not coincide
>> + * with what can be generated from ptype definitions
>> + * by means of preprocessor concatenation.
>> + */
>> +#define XDP_RSS_L3_NONE		XDP_RSS_TYPE_NONE
>> +#define XDP_RSS_L4_NONE		XDP_RSS_TYPE_NONE
>> +#define XDP_RSS_TYPE_PAY2	XDP_RSS_TYPE_L2
>> +#define XDP_RSS_TYPE_PAY3	XDP_RSS_TYPE_NONE
>> +#define XDP_RSS_TYPE_PAY4	XDP_RSS_L4
>> +
>> +static const enum xdp_rss_hash_type
>> +ice_ptype_to_xdp_hash[ICE_NUM_DEFINED_PTYPES] = {
>> +	ICE_PTYPES
>> +};

[...]

Thanks,
Olek


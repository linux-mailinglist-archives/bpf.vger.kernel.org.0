Return-Path: <bpf+bounces-5339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A12759B55
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35401C210CB
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4BC138;
	Wed, 19 Jul 2023 16:48:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FEB800;
	Wed, 19 Jul 2023 16:48:12 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9CB91;
	Wed, 19 Jul 2023 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689785291; x=1721321291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/H+0UaO1mEQJGDj4ZmlsnzDIwI2IQGIu+jYRD5LDkSU=;
  b=GHAFlvdtjmB8wGM8PSkgBRqiHh+H9qzQVCd0CSWXOIiqJzIfGH+93suI
   LtUuepzWDvlpNpk0BiQzSdGX69JwsdrDTuowFa+FrtS8WFK1nM0V7sJ17
   vHWAboGBjSiuloHSeSaDJA2KFXwUAd52T+hjAD7olIU1AaLOXaj+hB7Px
   IC1DIzDQf/zeJAyoMiicIhWBJozH+7J5X1ZEXkQJoladwZN4PFsYtx7De
   oUVlRMFoyFDEOrNGBHaiF17HhPyhTlEKQQw1p9/gUhanBn893eri8n1FK
   3c1k+nRWCjwEgfpcf53cPUMMQTPs5Yu5KWgkWFEd1SE5pbhAh744a9eYC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356478878"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356478878"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="1054808256"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="1054808256"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2023 09:48:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 09:48:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 09:48:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 09:48:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 09:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DALnCS38E9BJdQQInHjMTW0OPxHKy2pK7k/YmnyTMXJz4fQ0SCXYqu9MMF8CL8ZIBLpGzyrDrRB0zLxaUIiaAbUrxV2gtbvuKZvPrBQXgUsHnm/VX+RGGycx8pJ7lMWijkoF0SnJPny19v9xTeEHHNPrOpRa89cCDX46PkygP8AtqrZB4t84sfa8rAEiyZy7yQmVUyW/6RnFVkgWUhkuUAU90nG4FKpjpp7ullhAuRJKuv8dfhxnKeg2R/82saYxNGxDMVz1YLZ7fCMN0Z6WLDV/iiTTtnb20oAR6qNl3yf6gamq0EbAh0AWnNEdNZkaXQLFJ+oyK+Owee3i7WGrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwn+a+Kp/UvYFtUp4WhJqWUxgG5MsAi9LrOAdh0Snks=;
 b=DzHV/20NWTK4Ib1VhPzIQEP1+fkxxhYdAFn5XCrQWmBoSOtYEq1iCTA6ISmnwhTzX8GcmLJR5uI74OrxF5PplJdTsCuG98Zs5ajhig2LWmG2CxO/eC7zZajTfJxaFh1YD7SuMIpVa1eZcgXzGBpfpun6wwj/t+0ZK5qscRDNXS9d9D6zYRlzknKkA7LdTARW81kdYAbXuom11L0frElgph711zj8K+DzZKbeEBLzUItO+OojuWPF1J2AA8JtYvhMTLS2+mwqKVrHJMRGaRUqfQSV3D5P2vd5nj7MBKV/Mba2IsdEfPEbguTmjNNbcNGs6D+vQan57gmBklPjqM7XnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 16:48:08 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 16:48:08 +0000
Message-ID: <e0d85f3a-377b-dd29-3125-c5c304d9d234@intel.com>
Date: Wed, 19 Jul 2023 18:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
 <fa3dc82a-fe5e-a90c-6490-1661f1bb43d8@intel.com>
 <AM5PR04MB3139675725C77A4C06103DA48839A@AM5PR04MB3139.eurprd04.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <AM5PR04MB3139675725C77A4C06103DA48839A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ2PR11MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebba99b-0620-437e-7c7e-08db8877edca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n59IcBGGe/pETqNDn/fgpBNF8j4QvMyb3rntYd7UbQ7PyXzARamXcsGKfryw+Gy/u23nDTsi4JOadLaWcoAEFeifrfSj+dtdvZpMyOkGiaITgGazTXWTuCcds1AqsHnnRumIMTQ+3ssYZdRxmlPawLeq8dHkcKEiaKVUPGoVmb0nhLEU0/h70rEkQp9r1leQNJcy/kddZVm23O5GoHRONpcgjvOMpf1xUbl8hxT8yMH/yVOB/rNCGMtAiO0Hkxqa0wsbHNspGd5bb4eG2ku7/66QS66DBLYVYsW+6uYz5jLU7OZbLrYSyojv8j20aH8S+ofyX+tSsDhxA5RAEiiqhY7Ql1xYQLfnSuKFhoCiPBgZS8/vwO+kcigda1886pw5BKzJXtXTe8Y3bgHdTUvWbQWB5Jl39iI9jujVinhue+XIBbx473sb2keKldUpHaHyyMhV88bn17D5T2J/5qmHj2d6sx/LC02lruP8Jt5SIajC1n7mCavT8PT97rNncd5/thnahzf0MVk45+a8pke4RL8rNoHFX0pJk4yFAPM9EI7r3w5/JpW/Yio1xeKZLU+BsD5frLXwMgATEXaQtmFDNSs4zjSaPU7VPTmkV59zcxr3/U8fAg9aylHsqMT5KlQIIspDyA3Pp2QSz5tavwhmZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(31686004)(6666004)(6486002)(478600001)(54906003)(83380400001)(2616005)(36756003)(31696002)(86362001)(2906002)(26005)(186003)(53546011)(6506007)(6512007)(66476007)(38100700002)(66556008)(6916009)(66946007)(5660300002)(4326008)(316002)(41300700001)(8936002)(8676002)(82960400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVSUUFqR0g0emdMSDBMWXVSa3VGTTVEbGJuaXFHblVocnNtM0VVVkhadmRa?=
 =?utf-8?B?Q05YKytJeXd3c3hsenN4aXh2OXdHNlNzeUxrUmNCZzJTcFQwZ0hLenJ1a1lk?=
 =?utf-8?B?SUdSRTlWeDUrM2UyeWQ5UG9hUEcvNjF4Q1dJT0FjeHErMzk5aFV4eDZ2L1hE?=
 =?utf-8?B?UHBPSmc3SndEZ3lSSm94WmFiRFppdVA1RlpPbWdobnk2d2RtZEpZWVAvYmVy?=
 =?utf-8?B?UHhVUXJpTmtpei84QkIrRnlYUS9uS2NRcUo1cjBEa2htejBHdFIyUkZSOTBo?=
 =?utf-8?B?cTR2d3V0bTNldkdSdktKWVdZU0xtUUdzQWlOZDFCbmZLREN2YU5EMmdxeDRD?=
 =?utf-8?B?Z0ppK2dVcVNOTVhqNnJzQkdFYXlPbVltbWVVbjRqaXVCS0hPNWFKTnlpWTdK?=
 =?utf-8?B?SnVwN2ZnM3dlbENKVWRPRFRhVWtDcC8zUzVvMm5SVE1BQzBUQUl0a0VaUE5V?=
 =?utf-8?B?VFZLTGxYZXVhM2plNFFtY3BieFRBaktCenN2SlFodWdsaFhkemFDMTVFOVJL?=
 =?utf-8?B?aEp5MFVCWFNxUGVnRXhKcWhoS1AxMU5xNW1RdW4yL3R2N2J0WVFOK3p1clRU?=
 =?utf-8?B?cExOTm1oclltenhBMjJjaVRSQmhqZS9JaWkrTm4zN0Jjd1RhSDRHTjhiL3hV?=
 =?utf-8?B?a3ZGR0ZUMVMyeWJ0Y0xtNERxVzh3alVpaVh4WjR0dHBkTmNWeWFwUExjTEJv?=
 =?utf-8?B?RGpra1hoS1lrZVoraWVsN1pDNFBOcTVzU0ZYSXF5VW1IRkY1eVR6QUZET3hP?=
 =?utf-8?B?dWZuQUVoOWVuWVA3SlZibnhXOGsyUkJxR0JuZUZMdGFxZ3BsNEVzMzhpTG4x?=
 =?utf-8?B?OHEyR1lCdEM5Y1o3U3hQZExrWkpDUFpBaFY5K2ltY2tWRTBTeURjTGw5OU1y?=
 =?utf-8?B?YVk4SUU0amZZaGNxbDZ3VmUwTXVMUUVKVGhwNjhkbHB5Q2tubWZ0TG5WNFZF?=
 =?utf-8?B?eVJJclZDdUJNTnJnYUhDS1FkTWRsNkFPRTVkTlJseitjQlA2UVhQT1JwOSs1?=
 =?utf-8?B?OXVvVS9kMHVuVDlCT0tQTXBtQy8rRjFONEdQUHk4cUFxSDhoOUsvekR3MitM?=
 =?utf-8?B?cSs1VE1vL1NTTkphaFZJKzhMYVRPVmlkYmx3UktQbWJ3MEdDT0VhczViRkkz?=
 =?utf-8?B?djJ5ZXhwbkJvMmQxT3p1MDdIQ2RVaE5rbjRBVU5Gdlh2a1R4YzlxSElqdFkz?=
 =?utf-8?B?bklCdkNiYXJ3MHNwWm5xTWJLT050Y25RTDZQNkpoWmhXbVBBeThpT2pOdi9C?=
 =?utf-8?B?SzRTOW9JVllPOEk2TTE3SDkvd0FjME5Xc1R6aFErd2l5QUYyVlZBcDc4WTNG?=
 =?utf-8?B?ejlBVkZnVnlNODZaUi8rWDlxNUxSN1NrdXZJYWp2QW00SlBucmNzUUtLSU56?=
 =?utf-8?B?N21TWlBlZUVMSkJHK2dwWGY3aG9OOUxybm5hODVPamZmUkVPQUFrVkRkc1hZ?=
 =?utf-8?B?WUFlMU8va2hWT1VkTmJzb0N0NnZyNnlFeXUybkVwSFYwbWR2bk5xcFRuZW1Y?=
 =?utf-8?B?RjhVbDlqRmRqMnhmV0tkK3ZFT0Nua1ZLRkM0aU03RWhnVkJ5b2JwWFVaczlp?=
 =?utf-8?B?aFZ5aFdrMnpBeXUyd2cwNEg4cGYrVFI2bVU3Tkl5d0VPTmg5cVJnZWh3YThG?=
 =?utf-8?B?L2lZZUlyNTJsWjhVMzJDdk5pZTF0V3BrQ0wra21aQ2FHcHpGUWl3UkdiUGxq?=
 =?utf-8?B?MFc3K1loK1ZQRFhmWkRkcjMvLzB2QUlyYW52RXNGd3A1dFBzTGZsaEpYZWZr?=
 =?utf-8?B?QkRob2tSM1hGcnNxYzNBbHh4TTh2WTRWd3hyb0ptQlNEQzA2bmZuR1dVWmJI?=
 =?utf-8?B?M0ExMU93aDA1WU5yRU5aNTlDK3ZZNmpFdjlkSXg4NUlTZllTME5Mc3UrTE1Z?=
 =?utf-8?B?NGMrTVZuSGpEdUQxTGVxc2dDYXVmdGhBUkxtQk8zUkF2a2Z2VGhnVERkT2ds?=
 =?utf-8?B?U3FVZkJnbjFNK1lnSG9rVUZMVk9YYnNXZjlxNnNhS1NlaERCMGVVdWdFL1p4?=
 =?utf-8?B?YVNzejJiWVcxd09QWFJML1lEWldhZTI5Y2hmTmNhWURNa0UyNEdQdjZ0R1lq?=
 =?utf-8?B?SW83V3NJbHJnNVJHNVIvL2tRbnVYaS9PdWNGWnU3M2FqZWNmbHRvYk5pakZ5?=
 =?utf-8?B?QjdUTlZDb29jbENmNDlXOXNQZVQ1YmYzbGtJeWRYSWQxZWhQWisvM044Znla?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebba99b-0620-437e-7c7e-08db8877edca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 16:48:07.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1kXtSAaaYPOcGfcmGIoMCeTAAukOd2XG9Z0w40wihApys+I1ADwd13RFNnKpgpkIQg3v5rC7Y3HTWMKZyj5F/aqmxnBFhlAPhw080hCyO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8498
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>
Date: Wed, 19 Jul 2023 03:28:26 +0000

>> -----Original Message-----
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: 2023年7月18日 23:15
>> To: Wei Fang <wei.fang@nxp.com>
>> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net;
>> hawk@kernel.org; john.fastabend@gmail.com; Clark Wang
>> <xiaoning.wang@nxp.com>; Shenwei Wang <shenwei.wang@nxp.com>;
>> netdev@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
>> linux-kernel@vger.kernel.org; bpf@vger.kernel.org
>> Subject: Re: [PATCH net-next] net: fec: add XDP_TX feature support
>>
>> From: Wei Fang <wei.fang@nxp.com>
>> Date: Mon, 17 Jul 2023 18:37:09 +0800
>>
>>> The XDP_TX feature is not supported before, and all the frames which
>>> are deemed to do XDP_TX action actually do the XDP_DROP action. So
>>> this patch adds the XDP_TX support to FEC driver.
>>
>> [...]
>>
>>> @@ -3897,6 +3923,29 @@ static int fec_enet_txq_xmit_frame(struct
>> fec_enet_private *fep,
>>>  	return 0;
>>>  }
>>>
>>> +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
>>> +				struct xdp_buff *xdp)
>>> +{
>>> +	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
>>
>> Have you tried avoid converting buff to frame in case of XDP_TX? It would save
>> you a bunch of CPU cycles.
>>
> Sorry, I haven't. I referred to several ethernet drivers about the implementation of
> XDP_TX. Most drivers adopt the method of converting xdp_buff to xdp_frame, and
> in this method, I can reuse the existing interface fec_enet_txq_xmit_frame() to
> transmit the frames and the implementation is relatively simple. Otherwise, there
> will be more changes and more effort is needed to implement this feature.
> Thanks!

No problem, it is just FYI, as we observe worse performance when
convert_buff_to_frame() is used for XDP_TX versus when you transmit the
xdp_buff directly. The main reason is that converting to XDP frame
touches ->data_hard_start cacheline (usually untouched), while xdp_buff
is always on the stack and hot.
It is up to you what to pick for your driver obviously :)

> 
>>> +	struct fec_enet_private *fep = netdev_priv(ndev);
>>> +	struct fec_enet_priv_tx_q *txq;
>>> +	int cpu = smp_processor_id();
>>> +	struct netdev_queue *nq;
>>> +	int queue, ret;
>>> +
>>> +	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
>>> +	txq = fep->tx_queue[queue];
>>> +	nq = netdev_get_tx_queue(fep->netdev, queue);
>>> +
>>> +	__netif_tx_lock(nq, cpu);
>>> +
>>> +	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
>>> +
>>> +	__netif_tx_unlock(nq);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int fec_enet_xdp_xmit(struct net_device *dev,
>>>  			     int num_frames,
>>>  			     struct xdp_frame **frames,
>>> @@ -3917,7 +3966,7 @@ static int fec_enet_xdp_xmit(struct net_device
>> *dev,
>>>  	__netif_tx_lock(nq, cpu);
>>>
>>>  	for (i = 0; i < num_frames; i++) {
>>> -		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
>>> +		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
>>>  			break;
>>>  		sent_frames++;
>>>  	}
>>
> 

Thanks,
Olek


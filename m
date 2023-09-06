Return-Path: <bpf+bounces-9329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6C793C92
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 14:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF18D1C20A05
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 12:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D210787;
	Wed,  6 Sep 2023 12:24:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2CED6;
	Wed,  6 Sep 2023 12:24:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ACA170D;
	Wed,  6 Sep 2023 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694003076; x=1725539076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z3XiQgp0ruah8HY0AFFvHws9pGoh9pjKlUoMQhjtgSc=;
  b=aN7U7VJmKDuGBqGpbSfLeFXMalTXSGZOpzIwR8cHp0jFCe9+57OEU8Tr
   UeXIc0hgqEoVzU+sc4UB2KOtvaL8DHdeYU6Mw1HUBCkK0ntHX3lPnvm6h
   8Wwds/uzTl4Y8sCjdRNawmuUoMIrFpWoMzi8Io2CLen+XboyFGh7XwZgz
   3VGmt+nptRQUPQdc0W3CuITzDGI3As2+z+SEXCIiDsSNNhGa0mD7eRxCW
   gOBNMmcGg2/Ahv1zP6oyV53GMy6bZVtubw2p80laGy5Kx9/eQ+ZbSq3hx
   WO0jHcL7nUNTRn4uIh90QtSXbmch3mcg0HIUs5sHcrwENQ9WDGsKSnlnP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463430915"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="463430915"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 05:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="1072366471"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="1072366471"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 05:24:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 05:24:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 05:24:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 05:24:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 05:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYYAKyxQuDWppU/D8w0FsGM5jacRW5cPl3GKt/pAAgOvG9NDE/IBERjhJ8uhPooKWIzQq0r6sTykBTBBbZTC/bOv1mWpACPi5asGVHUzzJINIKRf1pD8mQpZOJEIvmvjwGIcy5dabn/nBVBOi5PkhU5FR3wMTpJsZiLsSAw3JANXSZXXGb2dcBcJx/SLshYzyYlVL91x5CsFbSKymeoeff80BqTzGpozo1zoGItkOSa1EX59WB3An4c0el+AbPMjc5AiyZFpO+XhgVPA3ONfJ/pQtbPEpnWxxvPQPp3SVeJI7aeVfYZeU3FM89E47kZffyWpmmyzg9P199Cqd1zCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOqwOYtDOt2rqaqaNc+tPv8dYIBlgm0yL/it/Vc3jEU=;
 b=AFDHl9HKF875W1ozAe3ul9uiwdQq2KX1Dhzyucwye9der4uBMxlDps1RSc+O/BWXEuz6zTIdMhl5d2J3wbKO/ezM6/QG1vqozYUpNd1sFsbcNl6h/CgGutTleezEMfZq1CFRAEpztsTvBLUomVGj2l9GQX2ELySEJbXP5ZmAFKCgVpI1IhHvKMCcwlS7fJR5fiCFcNHkqVFBhKXQZ1I385Y1UVRzQR9n/OrZlJ9I0CROAk6EAcTClkKxuEGtgPC03it8eygxjushznaWhF7PfIJP5RAs4MJzqoPtOnrv5OEf7nttrZnBLhHKtiSSsMPc9QASVQX8ow+m3hjPU0jkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB4800.namprd11.prod.outlook.com (2603:10b6:a03:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 12:24:27 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6745.028; Wed, 6 Sep 2023
 12:24:27 +0000
Message-ID: <e2b1bf53-b216-c90d-869e-24008943e41b@intel.com>
Date: Wed, 6 Sep 2023 14:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [xdp-hints] [RFC bpf-next 01/23] ice: make RX hash reading code
 more reusable
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
 <20230824192703.712881-2-larysa.zaremba@intel.com> <ZPXruYZtN6rA6MuS@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZPXruYZtN6rA6MuS@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: 87660334-dbdb-4210-49cf-08dbaed4368e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmLSZCUtkUECuWmTJ/UgrDddrwidevkksgv2nc9DUYpv92Rk2QGuPlcropB2Zu5BFv25LTZNQnp3osqLMKomNVdTttAvrR8RldK6x7H2jExY5GSw0CbmDpu5V2E4c0DgwfFHa++ueimVuQE/90NKOiSGy/hhrLs9XaWGcKZsFyMXdD9W733Xlt3IQ23FQ6t/BVJwfiLxN2UaQTTkDnBvxDP1rRiXbLc3C97awISu6Qvq8g8lUfdOlaY0ZWR6+ijWDNN7EABB9Qp6r/2DU7HSNhQwxz149ufCJBYAXGRhKrb4r9thpAGNPkEJh/X2Gd0TTiQ4PwqLAtKCTGg/40uN9QP5ysWxeU0SBJl66Z0ov6uiHlo99jJi8tXqH35UGfrknQddCsrQHtjmpmDKvyejkTtKCPZ4xvwn6o8MPMdHUkgCDFLIA1+01+4D7PQuYPO3njm7hD+WQ7sPr605qeYfpmOgZxInQevkPBEgYeRiLAcY9v4kgj85k+9zOmY0eb8RMaJPl4SPMO/QF6ArUovGa66vHoNVRDnQF81aSlEEP34nTWxQZ6cKE0RPSmkmznKzgkm873dquzXIqmE2m6XVF7XRkliepJ/kW+MOc5bGnNxxOwK0HJjlWgw3fSDhkqwCbEE2vNGSsRcYIg/Axlw0mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(186009)(451199024)(1800799009)(31686004)(36756003)(6506007)(8676002)(6862004)(31696002)(6666004)(5660300002)(4326008)(8936002)(2616005)(26005)(86362001)(41300700001)(6486002)(6512007)(7416002)(478600001)(38100700002)(316002)(2906002)(82960400001)(37006003)(66476007)(6636002)(66946007)(54906003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJOZXVVRGdWdEtBY2hwbWs4QkIrdTY4Snl0WDk2K3Y3Q2hvRE1HdVZGc1Ay?=
 =?utf-8?B?Vi8ybmc0WGNGdHl0ZWlsRWhmMEoyQzhPV2g3UVVhNXRRMWk1WGZzNDZLeTl0?=
 =?utf-8?B?RnpvTHlLNjJMTzRpM1NGNzJQUHJVUEkwL25oMTljblFCb3BZcm1kZHF2ZzNJ?=
 =?utf-8?B?TFQ0NkVwaDBVRFRIZERUN2ZpSWY3UGlyZW5BTVQyallnUWpOR0ZXbjFCUWEv?=
 =?utf-8?B?NzU5OTAzbDJkZDdSQVRWdGRkNE5CVXVDN2k4Z1U1N21QbXhhcWdLMHJDTVQz?=
 =?utf-8?B?TG53a29FY2VCNnN1VU41SGhkOEdKVEtCQWFLQUFwODNXcHBNR2g0a2hMYjRp?=
 =?utf-8?B?Qm5uUmxIWUhNL0J3eWI2N1A3M0R4UW1qUjZxOEdTcHhrczJkMzk2RVkzRDZS?=
 =?utf-8?B?VkR4SXgwQTh6MjQvVWxGdGdjYy9QWWg3eE8vb2ZiSzdKcEF6aStrQ1d5TER6?=
 =?utf-8?B?RjJDbHVmMC9kT04vV01DeWNWL3ZQb2pDelcvZEpTQlVrR0czUW5FZzFRNW9u?=
 =?utf-8?B?cUVwdERRbFJFc2lxZ1JUbmc1bXRaUjdqdGlUVmtsNFl4bjZhdFJXQ2xvTTdo?=
 =?utf-8?B?NnJGRHlZWHRhUzJ0YmJZRk5xajR4RkVKWGIvd0xSMzdYeGRJeis2dnA3cDIx?=
 =?utf-8?B?cEZLQXBPNVJvQVdnMjBkQnI0anJ0WEQ2WkxScWEwZXFoQ1ZPdW1QMUIveWMz?=
 =?utf-8?B?Um85ck9ucjRhQ2Nxbm5mS0VmMDhhYzFDZ29ocTVXY3NIV280b1l1bnVja2FQ?=
 =?utf-8?B?L1p0WU44WVJ6QVVFby9va1VPRnN0Vkh2bnN5cmVYVjBOOXhjTHpCMUxWSGlW?=
 =?utf-8?B?Z2NpSkpoSEJBRzlnbWV3RFo2OWVDSE5qODdCdEFNSXpPR3laVDA4bHh5R2Zn?=
 =?utf-8?B?d2R3elhJU3FnNDNaNzY5d0hKSWJWa0YyOU5ic3FhNTF0VmlzMkpTazhoNkJJ?=
 =?utf-8?B?WGNCTXJ0K0ozYk9PeWJCQ3d3RWtmR3JMTFc3OTVicGNyWEdnMXVSSFdVaHRP?=
 =?utf-8?B?c0tvcVM5aTFobFNmUnNEY0hxWHlKUzdhMTZENy9oS1E0ODBLMDZqMGROaFdk?=
 =?utf-8?B?RzBSWTBTTlprS2c4UDhzeXprTEVIams2elVvTW5Nb3BYOGxSalJEeFdBSjJC?=
 =?utf-8?B?bGpubFBlRm1uaW01Yk9lbEpIV3RwaHFTb0x2MVpURFhCd2N1c2NwRjIvbUd2?=
 =?utf-8?B?eEhiTDJUbjlTZC9HaGloblNGclpvSVcxL054SHNZekQwcWZnWld4NytoQUhp?=
 =?utf-8?B?c1RjcFVkSzVOekl2bE5BVFdJbVpIKytLaG9FU1RGNTRVQklodVVPS1FVL05X?=
 =?utf-8?B?U2MzSEpsRnBUOCtyMVFDTGliMG1BZlJ4RE1vUUZubUFQWGsvbkY2SW5hRGZD?=
 =?utf-8?B?dkZobW1FK2VjeFV2UnF5ZXNlZktTVUptbTgrcmY5TzNNWFdKQ1hadHNvOUh6?=
 =?utf-8?B?VnFVL2ZDaXlkQUQ4TGNEVkN1OThXZmU3Y04xUW8wUk8rTHN3bWdrRVVESkU3?=
 =?utf-8?B?U3VpZU5NYkdMZ09WRGtUOUdieHcveDhSQnZoVG5TVzcreitVcnNWdHl3S0VM?=
 =?utf-8?B?dlh2RnU2ejJlTXVyMDhUOXlLeVdGSGFjUzMwSTRDaDBTUGJSZ0JwZ095OGZE?=
 =?utf-8?B?RlFZUUEzV1ZSVjFoOENRMmxIREFnTTFSTVQvQ2hhSlMxai8yaTV3KzJCVlM0?=
 =?utf-8?B?dE05UnVCc0FucjJ3Z2YxZDlGS0dGTkl1UWhzdkdyV3dvVjJlZkJlODkxbndk?=
 =?utf-8?B?TGhPOWxpcHc4ZDArbldVTEFtTHFZS2VkcmJUaWFKYjAzRFByc2Q3cGF1RDRC?=
 =?utf-8?B?d3V4MDE3cy9uNXlwU1BrbmVYL3BhUTdtMEU0ckdLdnFxWDh6cE9HTEszNytN?=
 =?utf-8?B?T05xZk9IMnBzdkVMUW9LTFlFa1pCdnY1MWNvdVpHblQ4SDdzam5RU2kwSE1s?=
 =?utf-8?B?b3hOZHdQTytNcVA5OGhxR29xcjQ4clV5TVA3Szl0THQ1UUV4QUFpMm9wOXpQ?=
 =?utf-8?B?dWFwdDF4blU5QXFPMzJyMVM2Q3hFcHloMS9sZ1pjYzNrY3BRQkN1MHNUbWxU?=
 =?utf-8?B?c1RSVTYvdC9ldmtDTlhmbU9NWWx6K29sY2JBb1hxQzZCWHBpZ1ZCdGdicVFk?=
 =?utf-8?B?UXFTZ3Nja2JSc1lXelBhTTd6K0x1czJISWFNRmNKVGlOZm1MNkE2OFFXWEkv?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87660334-dbdb-4210-49cf-08dbaed4368e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:24:27.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltNPhXRYvjGI+5BIkX3HYELsNJlP9FyasFStz7zfisq1wXUiJw+pL36DWRwZRdCjLGDSlNb2vOKwtp2ZdyCpk+xnPVQiWTB6Mk23Sssl3Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4800
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 4 Sep 2023 16:37:45 +0200

> On Thu, Aug 24, 2023 at 09:26:40PM +0200, Larysa Zaremba wrote:
>> Previously, we only needed RX hash in skb path,
>> hence all related code was written with skb in mind.
>> But with the addition of XDP hints via kfuncs to the ice driver,
>> the same logic will be needed in .xmo_() callbacks.

[...]

>> -	nic_mdid = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
>> -	hash = le32_to_cpu(nic_mdid->rss_hash);
>> -	skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
>> +	hash = ice_get_rx_hash(rx_desc);
>> +	if (likely(hash))
>> +		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
> 
> Looks like a behavior change as you wouldn't be setting l4_hash and
> sw_hash from skb in case !hash ? When can we get hash == 0 ?

I do the same in libie. hash == 0 makes no sense at all no matter if you
set sw or l4, esp. for GRO and other stack pieces.
BTW, sw_hash is never set by drivers, it's meant to be set only from the
core networking hashing functions (when it's hashed by CPU with SIPhash
with the help of Flow Dissector). So we only do care about l4_hash.
Valid hash == 0 for valid L4 frame has 0.0(0)1% probability even for
XOR, not speaking of Toeplitz / CRC (have you even seen MD5 == 0? :D).
if the frame is not L4, the kernel doesn't treat your hash as something
meaningful and falls back to SIP. But the prob of having hash == 0 for
L3- is not higher :D

> 
>>  }
>>  
>>  /**
>> @@ -186,7 +201,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>>  		       union ice_32b_rx_flex_desc *rx_desc,
>>  		       struct sk_buff *skb, u16 ptype)
>>  {
>> -	ice_rx_hash(rx_ring, rx_desc, skb, ptype);
>> +	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
>>  
>>  	/* modifies the skb - consumes the enet header */
>>  	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
>> -- 
>> 2.41.0
>>

Thanks,
Olek


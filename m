Return-Path: <bpf+bounces-9431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB879787F
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C5F1C20B91
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002E8134CD;
	Thu,  7 Sep 2023 16:47:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815C134C1;
	Thu,  7 Sep 2023 16:47:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518592702;
	Thu,  7 Sep 2023 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694105196; x=1725641196;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TpyOm31/x67trGDwqjheOYnbkoKm1D0PRcPwGWesd/c=;
  b=FnAs93RrHVs3XFplHp/P9s+Z7eX7rYzBmJRLNUIMMI4YHGvzKBu+Bt/u
   5Ixe8qNBqKrundKsS4GLIdolPQ2EEFpK+dMJe8kCOqEWR4Y9CpCHL9y1D
   Y2yh8ifULTbj7Ys1NEN3828aW9oIRZSs+XqMh3kmMp/7W6pn3900Qh5FO
   zmnboD0xaAq5pWQh/LIoEYQZas8zm/MvTUAXprnGVh8tSevgZgNyBA52U
   mtvE9cM46qaFvUvHdi20nhJFa+hJInW+eRPhpQbtzE3SYqJuYjUjFGcB4
   QCJTMlRO04mVw8rCwztqBpMZbiQ6UwpIWhygulXj9hXWKL9cmXKGrwpZo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357721773"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="357721773"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 09:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="832271335"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="832271335"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 09:44:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 09:44:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 09:44:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 09:44:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6nf5yZ3LJ9kmedFUN1X+9DaJkFmag7gDo3GjGRWHFP80k/IVoi4GJveOQngHcEZr1YWdayQHsSea1uNO/vtlfrbYXUdvbN8m2wZCT7IX2l0NJbuociktRagg/RxSwYTGElMZRafQ+WZvl37Aqq+PUIw73SNIG1L9vbHJlUPmDYRnoRfGFOXvEBvDvmmg3pwa9KgrY3Jt0Rl6mr5Azz6NurB22BGcn+x7G8gMeE834VJzuY3osT8HJIbKvkWSm7WMUqlbOqyGCMBG8mPuKSKc1jGBP4UNC1n0am6X9GfVujPwE2idvOTTaEGskFPeBGKjKO0cy5vTBP9cb5mF/zmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPdAGA4EniEHgJtsSQpBOM6eEGk2yY5/HUnflzF1LP0=;
 b=BFkpExloHf1Gd5K+vZBY/xEhCL+tfm8lojHomv/i9LcivrJ+20rxB5sSxiLC/ae0/lu+2M8LTmd/D2KEwmEk9SKSTBwXTpYLqySlrHjuTHrRGf01r1gA81/2hFFXiJnT9crRMhQgXT8xJ0pJC7LQfX8aopU0BKna2mRGEn0uXUvxsIeznxX4lIzrrM9icMR7H4tVt6c/GsIgw+ybz4pVHV1orkJJ4cIQvaKPkkGGpVG3w5Rj5B9dgateTbNIUdug0+1/kJrIj7S6jBDJ/kpeFLUQWaN9LnTjVZWLDE6BYeYrxg5Cj29uHs6wlQJ0F7VVaIsfqLIndxaG1Y3eWTJ+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Thu, 7 Sep 2023 16:44:07 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 16:44:07 +0000
Date: Thu, 7 Sep 2023 18:43:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [xdp-hints] [RFC bpf-next 05/23] ice: Introduce ice_xdp_buff
Message-ID: <ZPn9zgnItkkVfpu/@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com>
 <ZPX4ftTJiJ+Ibbdd@boxer>
 <ZPYdve6E467wewgP@lincoln>
 <ZPdq/7oDhwKu8KFF@boxer>
 <ZPncfkACKhPFU0PU@lincoln>
 <CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com>
 <ZPn9eRofEv3guPLj@boxer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPn9eRofEv3guPLj@boxer>
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9e3ddf-beea-47c4-8bac-08dbafc1a778
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRk/lNDGVbHgz9Urpbsb5cQb6ebeL8ALPTso+G9XjF/vbWKrQ2143+S81dtIWP1Wy1hqDtmtcxmrKsNRuv0rV6c2wFRimx3NVDE0DyewlNHMkNFwxIQ0cnmgPKyRbifW+yINSUUQOSJ2Fo//bnukSWb8ceCErJmg7TBXxnd2d1GWbIyBaHV5DquY3swcyBN6NcZ7XVLkIOGlT+kidfLSM6R9iW5UbCjcz6fabhg5m4qO23oNtTjTELbLYc3PxS+Z0aSEM66hf+PTXJtLVxaloV+uRmtbMC/Lby02iqCJbj/CZefjTKoc/W9mc2w8hO20DtXcf/i29aI4rgiwQhw7Bo3e79uYs5t1aNf+fwE70qM2GbqZ8NXR+9tigIqphcZA2zoxnh8pthggkfxNO911kBDYwAej9aHtqR4ZbDx2N7/9qDuUFOKj3ndiQbqeakrNYD5e4Fr5uwYagwTrMJWS7M880/zjtBbV58CbxA88Z5FoTZzSgqHCKaLnRkB7TM4RG4ar50gPxkPcI6sxmEVAEt432f/d+PJjD1l/Mqm2uqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(1800799009)(186009)(451199024)(26005)(5660300002)(4326008)(8676002)(8936002)(2906002)(7416002)(83380400001)(86362001)(82960400001)(38100700002)(33716001)(6916009)(6486002)(6506007)(6666004)(66556008)(54906003)(66946007)(66476007)(53546011)(966005)(44832011)(6512007)(478600001)(41300700001)(9686003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW4vRU9IVzJaQStpQ0h3VWxSclRkUXFsUnlFVThOQm5lVm05WjRJN1dQUGtJ?=
 =?utf-8?B?QThZU1RpUEVqOGVJdGQrR0Z5d2NrWk1BNWhSN29JQkNCUDc5SGc2N3NOQTMy?=
 =?utf-8?B?cjc5VFhKVkIzUWJYcnN5amNzOUFVK0N1UThsd3o1aDFUeFRyZ2NXdHZCaUV0?=
 =?utf-8?B?aXdaYkpIcDNmTFFZVE9STGg3Sjd3MGZEUXpteG5WRmk0U214TEhrZWZSZlkr?=
 =?utf-8?B?azNHc3hJRmFlVEw0UndBczVsWE5sQnlUSVlWa2w5UnZ3NXZ6U3dyQlp0UEZt?=
 =?utf-8?B?WTdKclRFUkNLK24zZ0dZQkJHRjdacHNqVUJvMFRqZ3VBOFZ0OWRYWFRzOVds?=
 =?utf-8?B?OE9ZVnpRVndBeS9sazhqZzdVaTlVeGV0MWNxcXp0elJZd0JzS3BVNVZJZFpQ?=
 =?utf-8?B?K1Flbm5nYUZuanFhTERnMmRYaFdDNnhadkRGWjFNTDVZVjdxTWdqMW9ZYmxZ?=
 =?utf-8?B?K2YyS29zRG1oY3F3V3grbno2eWRVMzgyMy9qVjcwOGJDVWFHdU5RQlNwb0hU?=
 =?utf-8?B?NmREL0JVLzBIS3RIaDcvZnhpNVZqWWl4THFjZUY0ckFHK1k2eVZRdU9yS3Z2?=
 =?utf-8?B?QTBwV0xrUVdQdlBicUVVUE16UzVIT1p2a2RhWE5pYUFhOURuUmQ4N0N6eXJU?=
 =?utf-8?B?L2JEYkhINENuKzN3enh2V3ZteVFzT3BuSkNMRGNPZzdYM1QzUUdTRXJTTzlj?=
 =?utf-8?B?K2pjMk40MXQxRW5mOG0rYTBnMzhjNisyUXZEWkRMVVIrM2VZOHFaNDAzelJt?=
 =?utf-8?B?VUFNaU0wbnR2NnVUcFJHTFBVRVRLdVAxajg1bGlYYml1OGoyajJidXNtai90?=
 =?utf-8?B?WHlJYVVVR0Y2MTBHcmNRNVQyL1Q3eDlsWFdqQ3Y1emZxc3lFYXNFZVVGUlhz?=
 =?utf-8?B?V1dlSW9JdVJhSGc2M1pjUmNXUjBHb3R6Rko5Z2pFVWl0MC84THo4em5sQnQy?=
 =?utf-8?B?SG9BMFd6aTRPUEJXL1V5eWNOc2N6WXRWMGdaWm5nUWU2WDlvYkVGZmZXYTdk?=
 =?utf-8?B?Njc3L3dIdmliQ2Q0U2RXdkNLSEl5SGdxTi9EbTdodjVDR2hnQ1FlQUExZkhP?=
 =?utf-8?B?YmpwbmpEbHUyYXBFQ0w1N3ZJM28yOFc2Sm1iOWptWGJEQkx3azBhZXhvTit3?=
 =?utf-8?B?MmtaWmlXVUp0Z3hDQVMxQlU2ZCtSSVV6cmNxNHpiM1NueGI0NHVSTTNPUjl0?=
 =?utf-8?B?bVl3eDhXamxRb3h6dXJnb0cxcDNtS1Q5M3NEdWNrbjQzR2ZMYzFKaG9sWm83?=
 =?utf-8?B?eWFTNmJWMys3SFNyOFhKSWNVQkFlL09HeVVPamJvelBRd0dBVmpFMUZ6VkU2?=
 =?utf-8?B?TDBZbEwzMmVlUkVqR253aEc5TXhPQlNsVGJ4QW91SDNIVHRzNHAvYzlOYXN2?=
 =?utf-8?B?bzUzVnRFT0lKS2Uxdk56Q3dtYW1TeFRTMm02aTg1R1UxQ1VoYnVyTklMb3NU?=
 =?utf-8?B?K0dNZTh0RmFGbmh1V0ZBNTNvV1JLVUpXK2pTTjhrb1g5VmV4cTRsU2ZrRVlG?=
 =?utf-8?B?MGh3RFdaRFA4dXRLUUFoQ0ZTb0g5RjgrcmZHVW1KdnRSUE1uYkZqdm5UVjd1?=
 =?utf-8?B?SW9Db0c1VkZXQWVDcnRMaHpBa3RIOTYzcmc0NjVqWjhOdXhCeUwvQVFqRjhB?=
 =?utf-8?B?bmR6Z1FBaE4xcG5hTWVlc2RhazV3dGtNR2NGbkYveG85REdZTGt4UGg1YmFH?=
 =?utf-8?B?VlJ6Nis0S2pMeEVwelo0aVhHZEZhM2lvaDlnWFk2QnVsR1B5R3h4dEtxQ1B3?=
 =?utf-8?B?SVVmODdBV01raFM1SzJkNDFTYlA1RDdOVm1yQW1XNHJWWk5GWFVqcmVsMDg0?=
 =?utf-8?B?M1NYWWhXNFpEQmlKY3NvYTBGR2IvcWZFMEZ3Sm1WNWlFMkh6YVJLLzBWS1M0?=
 =?utf-8?B?OHZvRjVyZlJYVmwxZXEyTnAvZG12QTFWaWExYTFodG9yR1BENE5OWS9lendn?=
 =?utf-8?B?M1BidGg0VE53MDZGK2JYZ08vNUFRcnB0U244UWFiTlZsTFJzQ1ZrNUxxbnNS?=
 =?utf-8?B?MERsNEQ3R1oxc3Rna0V1RnUwVjlHajFhSklKRGV5REh4aFNyM3J6REdjaDVU?=
 =?utf-8?B?UnFSL2gxNWZPdUVqcE1LM3NKdmZEVFZHTHZrUVhUMlMxOWFrL2VhTEpiSEpK?=
 =?utf-8?B?WUk3c3hQUW5sMXZsZXU1bjVBUkFldm54K3V3akx4TUp3dFhjMWIxa0JDc0Rn?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9e3ddf-beea-47c4-8bac-08dbafc1a778
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 16:44:07.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +syrhIQH+TrqAGIoi6hsrRPeWh09KFW4ciKfd44TGPTzlUiZI49nQuNsblq9E+jo6hVGGJIN2B7dP6Jj+9gwnKeTg01jZPh1TrZfCBMeGIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 06:42:33PM +0200, Maciej Fijalkowski wrote:
> On Thu, Sep 07, 2023 at 09:33:14AM -0700, Stanislav Fomichev wrote:
> > On Thu, Sep 7, 2023 at 7:27 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> > >
> > > On Tue, Sep 05, 2023 at 07:53:03PM +0200, Maciej Fijalkowski wrote:
> > > > On Mon, Sep 04, 2023 at 08:11:09PM +0200, Larysa Zaremba wrote:
> > > > > On Mon, Sep 04, 2023 at 05:32:14PM +0200, Maciej Fijalkowski wrote:
> > > > > > On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> > > > > > > In order to use XDP hints via kfuncs we need to put
> > > > > > > RX descriptor and ring pointers just next to xdp_buff.
> > > > > > > Same as in hints implementations in other drivers, we achieve
> > > > > > > this through putting xdp_buff into a child structure.
> > > > > >
> > > > > > Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp_buff
> > > > > > if i'm reading this right.
> > > > > >
> > > > >
> > > > > ice_xdp_buff is a child in terms of inheritance (pointer to ice_xdp_buff could
> > > > > replace pointer to xdp_buff, but not in reverse).
> > > > >
> > > > > > >
> > > > > > > Currently, xdp_buff is stored in the ring structure,
> > > > > > > so replace it with union that includes child structure.
> > > > > > > This way enough memory is available while existing XDP code
> > > > > > > remains isolated from hints.
> > > > > > >
> > > > > > > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > > > > > > 64 bytes (single cache line). To place it at the start of a cache line,
> > > > > > > move 'next' field from CL1 to CL3, as it isn't used often. This still
> > > > > > > leaves 128 bits available in CL3 for packet context extensions.
> > > > > >
> > > > > > I believe ice_xdp_buff will be beefed up in later patches, so what is the
> > > > > > point of moving 'next' ? We won't be able to keep ice_xdp_buff in a single
> > > > > > CL anyway.
> > > > > >
> > > > >
> > > > > It is to at least keep xdp_buff and descriptor pointer (used for every hint) in
> > > > > a single CL, other fields are situational.
> > > >
> > > > Right, something must be moved...still, would be good to see perf
> > > > before/after :)
> > > >
> > > > >
> > > > > > >
> > > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > > ---
> > > > > > >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
> > > > > > >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 ++++++++++++++++---
> > > > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
> > > > > > >  3 files changed, 38 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > > index 40f2f6dabb81..4e6546d9cf85 100644
> > > > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
> > > > > > >   * @xdp_prog: XDP program to run
> > > > > > >   * @xdp_ring: ring to be used for XDP_TX action
> > > > > > >   * @rx_buf: Rx buffer to store the XDP action
> > > > > > > + * @eop_desc: Last descriptor in packet to read metadata from
> > > > > > >   *
> > > > > > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > > > > > >   */
> > > > > > >  static void
> > > > > > >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > > > >             struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > > > > > -           struct ice_rx_buf *rx_buf)
> > > > > > > +           struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> > > > > > >  {
> > > > > > >         unsigned int ret = ICE_XDP_PASS;
> > > > > > >         u32 act;
> > > > > > > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > > > >         if (!xdp_prog)
> > > > > > >                 goto exit;
> > > > > > >
> > > > > > > +       ice_xdp_meta_set_desc(xdp, eop_desc);
> > > > > >
> > > > > > I am currently not sure if for multi-buffer case HW repeats all the
> > > > > > necessary info within each descriptor for every frag? IOW shouldn't you be
> > > > > > using the ice_rx_ring::first_desc?
> > > > > >
> > > > > > Would be good to test hints for mbuf case for sure.
> > > > > >
> > > > >
> > > > > In the skb path, we take metadata from the last descriptor only, so this should
> > > > > be fine. Really worth testing with mbuf though.
> > >
> > > I retract my promise to test this with mbuf, as for now hints and mbuf are not
> > > supposed to go together [0].
> > 
> > Hm, I don't think it's intentional. I don't see why mbuf and hints
> > can't coexist.
> 
> They should coexist, xdp mbuf support is an integral part of driver as we
> know:)
> 
> > Anything pops into your mind? Otherwise, can change that mask to be
> > ~(BPF_F_XDP_DEV_BOUND_ONLY|BPF_F_XDP_HAS_FRAGS) as part of the series
> > (or separately, up to you).
> 
> +1

IMHO that should be a standalone patch.

> 
> > 
> > > Making sure they can co-exist peacefully can be a topic for another series.
> > > For now I just can just say with high confidence that in case of multi-buffer
> > > frames, we do have all the supported metadata in the EoP descriptor.
> > >
> > > [0] https://elixir.bootlin.com/linux/v6.5.2/source/kernel/bpf/offload.c#L234
> > >
> > > >
> > > > Ok, thanks!
> > > >
> > 


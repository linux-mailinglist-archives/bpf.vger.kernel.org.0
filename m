Return-Path: <bpf+bounces-6748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825E76D83A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3791C2111D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB5111A2;
	Wed,  2 Aug 2023 19:54:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFBF100AD;
	Wed,  2 Aug 2023 19:54:52 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E682C19AD;
	Wed,  2 Aug 2023 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691006091; x=1722542091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UnjHuCfGxiS/vPkmDO5U29yqf/Pak1KEvCsEumnZoKQ=;
  b=miLaGInM9VIPzSOUzhMWa/mUI3biRYaELfPiGEpz83Yhx/JEoK4XrGil
   1tyCbHGqNLIAc8RFsVf5wUIt3ooALm3AMi2pVQDLGB8qDDzMqij+3nd70
   KrMfYJjH8Ao1g5+5bpuMgpYmyzOtZkspDtcWzFS7SVRXH65jLJFO1dv0k
   IpN42j+q7nG8B8W6SFAQ6jiP/QNMffWh1vItkMgknfFMKYGN6/GFakKpi
   Cx9deSZ2FaTocNFL4vJLdQ+JClddbFM0AjgHFW2wCl1M8HzSpbXMd6uUm
   VR+qYxiLRv5jrvecunxBgzf+tOV9hMgX7GyKr5S9/dbb0bB+COJvEseL8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354598182"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="354598182"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 12:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="903070647"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="903070647"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2023 12:43:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 12:43:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 12:43:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 12:43:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 12:43:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUNygOl/iFgZzDK/FAPZ756ywlcclFmG7Egk5jzMUdFM+l3wK0DqnfFBRFratznZw6mfM3AvNb19TC0kn0vWaU9c9RYwpDYA2ZygxhetyDeWw5/frSW7jq0UPbXYIUZVfIneLcqxcfdGQscFXUCc4RTtMz+19hRSllAgzO9NyGl1PLh3NgxTglSDTTR/4dsJrZMLM2vNSQWgdeM45HUq+nqNtsVl5uN2wautD+5HGawd2MAXDclGF7J3gLmkfzyjP7bCc0X0C5x/DyM0yS9dqNn82c7xajNmdV+K4uQ72f7anyQ0VAzF4zyl4FHvVLy08moYbTHvJDuXVPhqSXwnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT5XdVE/szmz5qhCS7WLX4a1yvkRvDZIjW7rObylWaE=;
 b=ogamZPgdY15g6EUDuCWmkeMfr/NWVgbz/19DGl/bXA22bLrZDB0phZHhy9i2YN8N+F4L1GFlXgPRFA2MkFA6TrEokLYpzGpebbokYtK7jYHK1C0ACb2PMHLRJrngrI3kgdHF5hJ4HMNaPz82wn3JEx0d208UZz7JUm/SZSwG5SO4vYuog/HpgEvmHXKACIaXR7HLRs4qjVV76l+oajYJlxeSsM4Dq8nsIemc15me/1O/KKLiGZIxKT1tMWY5HyuQ33si2G7ebbaAU62TnJQ3rCSXDwPQpbHus+14927INWMh6Qp7vbLaizGH9pRrESrtzz1JEDV61tFFFWwL1GYzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Wed, 2 Aug
 2023 19:42:58 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 19:42:58 +0000
Message-ID: <ec094a06-e61b-0138-d258-d1952934f6b2@intel.com>
Date: Wed, 2 Aug 2023 12:42:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next 2/3] net: move struct netdev_rx_queue out of
 netdevice.h
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <ast@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <hawk@kernel.org>,
	<aleksander.lobakin@intel.com>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <gregkh@linuxfoundation.org>,
	<wangyufen@huawei.com>, <virtualization@lists.linux-foundation.org>
References: <20230802003246.2153774-1-kuba@kernel.org>
 <20230802003246.2153774-3-kuba@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230802003246.2153774-3-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:303:6b::9) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CH3PR11MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 2813ae22-e549-4327-e6a8-08db9390ac79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePWyCTvzjkL5IUJurR/QElKDUXiZvRaK0C9HvHdySjwq0qXvwzbO5H6wWS9F/xrobSLhiawmh+XqK3rGoj9OqyQo7BQ0ABs1sNc+WSD8S5aGh97D404tjdjvNjyzK0BIfRPrsEPXPKqkrUVMSaauW2wurUZCIfeU5oKXkusnaGnLr0bQcp789ZR8TZj6TF0aOmEGj1TQ/RcQ6i/zJZx7F8XfIVsC17vY56K1s5+0V5vyVITqs3KuiwrCdmcEKn2ZqSCxi64eDZa98xyS+rspWw6qwC5csh81PLjrikVG2A/Wxs3umn/24XFAkDM0KZ0QHM1Td0vJBzt9w/VqGfU+URro2qvRlb84Dj5zVeOQ/KFzHsem4YmUYl+kZEAaZk6CLKaA7imuEfCSR8WSF+G/Fn2S5uLmdNhvmuTJPLJmNRGGoym+7MINPUKEsvrILV9kGObi4gjZ7zalgLD11hJJl44cjZOuCBM0b+HiJxw904hskPYWgGM/preVK3ydxk0WtrmrHRVrgXOmi7C1SiXZLg3r8vqdDMrB35GhYjGU0C8n3JxHI0tjRqn5ExgOUSl7pwH09LbTFvB8HmVYLWLanokRz+//SmXEgYM0RsprT3g7DWVE+rCXrfexXHRjRVsrr11uvjGhWpmVtnKIIJQ4TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(26005)(6506007)(83380400001)(186003)(66946007)(66556008)(7416002)(41300700001)(82960400001)(86362001)(38100700002)(31696002)(66476007)(4326008)(5660300002)(8676002)(8936002)(316002)(31686004)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My9HclFKYTN0TW5HYTVLUThVcE9pQTBJbjJQTXhyOVpIRVJxK0srdVZNVkdj?=
 =?utf-8?B?Tjhuam11UlBwUWc3TGw4TmpmM2pISlFnTi91SkdWMWlwK1NPZFpabE9xaVFR?=
 =?utf-8?B?V2EyZllIUGpFSXFSeTFMTjBnZFczR3g5aktsZWFKWnRlcWVkSTNKUVRxY3Nn?=
 =?utf-8?B?VCttMzlmOERXQWF6YllIM1JoUE9EdkU1Smh0dk1WLzNOR3cwWkh2STFRdFRP?=
 =?utf-8?B?bHVmNlUxSWhXTjVrekFYcmhZTG9TaVUzK282NE56MlNiRTVQbHdEZWY0QzBJ?=
 =?utf-8?B?amZDWCtja1BzQVBBWWhzK1lxaUdJMWZUTURQZnlKOVdHVDRuVk5adXQ3V0Zk?=
 =?utf-8?B?ZE9CcnJhZ3g3Sk5LS01jT2JYdjVPNVdxMnpISUh1eUd6OFN4bkdlRmlLVk1S?=
 =?utf-8?B?QzBiMng0L2VQR1MyRUhmOCsxWmYybWp5NWxQVFh4dk1iQ1UxUmpFanppdnpw?=
 =?utf-8?B?bk95UkhDZG1mNzVqSHhkM2VPdFhHOVJJUWc3RG5ocFcyem9KamNKaFNHZ1Mz?=
 =?utf-8?B?V0xXUTlOOWF6Y1VESXNaRmdDZmZzcnN2ajduYjYyOXJjd2JQYWQ4ajZqQjZE?=
 =?utf-8?B?NGVoaFJneFM1cVdNbmk3Q21iSEI3LzBxRW9iOTdTcUtkYTBwdVRwWlM1ZHJs?=
 =?utf-8?B?WG9xNDU2WnVGMUNXU094cStHUWppWjhscFk1L3B4VGszNDg5cUx1dVV0ZlFw?=
 =?utf-8?B?em0vWEljbDJDd2ZVOEVBVzUwSENCZkVIekpQQ2o0aVhZMWJkSUxTTG0xTjdp?=
 =?utf-8?B?Kzkyd2JwMG9VZ0FodWNMZnZ2NWpQT1BuSXYrSXhoWlFZMHZLUkExdkwxNnRY?=
 =?utf-8?B?dmhBYUhqcWM5cG1KN2dFZEtneEhjYmlqZXFveXV1L1RybVJDcUlBSitGK3RN?=
 =?utf-8?B?R2Q4VXZiaGNlZzZqWmdLREZtam9xaXY3UUlJbFF0QVJuUHZrTml3MXRXekJ3?=
 =?utf-8?B?TzFVbVpkN24wMEFmWGJqb1RuMkwva1BoVENLbkU4TVJRMTBkSWZsV3JUeklT?=
 =?utf-8?B?SFY2Rm52ZFZWMlU4a3ljLzNxazI3K1lob2JPRVl0QTZFNkU2T081NHBrZzNG?=
 =?utf-8?B?VnRxODBVQ1RYVFFReDFVNWNjL3lBMEgzV2tMSlN4RWlHSnJWWnlmYmxNSTJM?=
 =?utf-8?B?emxDYUlwVFhSKy85Qktkb3hlVXZxS0NTUWFrWWFpRUdnc3V5QmJPTVdzcEJF?=
 =?utf-8?B?N1NYWmdBbVd6bTluc3VlS3lRRFM1cDErVVVyc1I2cUpPQjVMdGVkS3JwY1Rm?=
 =?utf-8?B?bk5zak5qbWVmT0FEazFoVmU2TDhJRVJLZGcwTUg5QWNBZUdjZkdQeTB1dUND?=
 =?utf-8?B?T3E4RlNLOVR2VkoyODRFLy9IUG1IaDdnR0E2MnhzZmhZUHdYK1RCaUdvZzIv?=
 =?utf-8?B?ZGUvcmtKWWpadG1mUGNEd3pxRHdrQVorSTNyWVVUM3lHU3ZGZ2x6TERqaCs4?=
 =?utf-8?B?aEI1eWFpdGlxcGk2alZlWmNIcjA1OVg0ck9yZTk2RERuUnBmK0xBK0xJbWtn?=
 =?utf-8?B?ZkYyOWRwLzRRN3BodTNvN2trVTFxalF2SUUycTVWUkdxSGxjU0J5bFBuUlVQ?=
 =?utf-8?B?U1ZuZDVUQmpTL2hvaWxCL251dVVrY0oyRW1JU0piaHBOaVkxV3pRUjZBS2FR?=
 =?utf-8?B?K2FiQVExN3V3eVp2WkY5U0lTTXpXWko5cnN3SnRXVWp4TTNBWDhMYmxmWW0y?=
 =?utf-8?B?L01KZ2hNZENQdFgxU0JhakRpZ05BUnhuVzBGb1VOUGR5WEt6RURMRDJTQjRs?=
 =?utf-8?B?Z3ovaUdQei83OVVDOC9pWHE2cXVGczN3V2JtUVA3THFlL1lTVW0yWFpncGRi?=
 =?utf-8?B?M0VYbGRqVmNzeTQ3YmdELytzOFRUTDZXME55aVBmL0dIRjNEZWswQmE3UXh5?=
 =?utf-8?B?M09lT1kvb2cxS0lnWlN6eEhJK2oweTEwN3BhVUNnVDRFUWlhZ3lpRWN3U010?=
 =?utf-8?B?bXEveUNBbTJTb2YwclZJOW1GYUoyZzIxRnNyQ1BsbGx0Q1crVVZHSUJkdXlw?=
 =?utf-8?B?dW1IREdxRGthUUhIcms5WjNDNUFVb25RRURmYVc5Sk5VN0I5UzRxOFBtWjFj?=
 =?utf-8?B?c1AwckQxbGQ3WnZuWHl6ZytoaExqTFhweXBscGsrTmFlQTFQUmx0am04V3Iv?=
 =?utf-8?B?Q0pLQ2lMVXFsMmdmbkY5aEZXZGRlQzhSbWphbHBwS1lPVkttdmZ0NE4raFIy?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2813ae22-e549-4327-e6a8-08db9390ac79
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 19:42:58.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZhZwWO3bkNixGXoP6W6ZEJEtm6W/wtF0hKdDCV+I/V9xbRC3kVQIM2Vddeu8Hsh7HVXihCDnbqzYNgxxe61W7Asc+C7VEUtxwSPkfW1fGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8660
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/2023 5:32 PM, Jakub Kicinski wrote:
> struct netdev_rx_queue is touched in only a few places
> and having it defined in netdevice.h brings in the dependency
> on xdp.h, because struct xdp_rxq_info gets embedded in
> struct netdev_rx_queue.
> 
> In prep for removal of xdp.h from netdevice.h move all
> the netdev_rx_queue stuff to a new header.
> 
> We could technically break the new header up to avoid
> the sysfs.h include but it's so rarely included it
> doesn't seem to be worth it at this point.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: andrii@kernel.org
> CC: martin.lau@linux.dev
> CC: song@kernel.org
> CC: yonghong.song@linux.dev
> CC: john.fastabend@gmail.com
> CC: kpsingh@kernel.org
> CC: sdf@google.com
> CC: haoluo@google.com
> CC: jolsa@kernel.org
> CC: bjorn@kernel.org
> CC: magnus.karlsson@intel.com
> CC: maciej.fijalkowski@intel.com
> CC: jonathan.lemon@gmail.com
> CC: hawk@kernel.org
> CC: gregkh@linuxfoundation.org
> CC: wangyufen@huawei.com
> CC: virtualization@lists.linux-foundation.org
> CC: bpf@vger.kernel.org
> ---
>   drivers/net/virtio_net.c      |  1 +
>   include/linux/netdevice.h     | 44 -----------------------------
>   include/net/netdev_rx_queue.h | 53 +++++++++++++++++++++++++++++++++++
>   net/bpf/test_run.c            |  1 +
>   net/core/dev.c                |  1 +
>   net/core/net-sysfs.c          |  1 +
>   net/xdp/xsk.c                 |  1 +
>   7 files changed, 58 insertions(+), 44 deletions(-)
>   create mode 100644 include/net/netdev_rx_queue.h
> 

Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0db14f6b87d3..5bcfd69333ea 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -22,6 +22,7 @@
>   #include <net/route.h>
>   #include <net/xdp.h>
>   #include <net/net_failover.h>
> +#include <net/netdev_rx_queue.h>
>   
>   static int napi_weight = NAPI_POLL_WEIGHT;
>   module_param(napi_weight, int, 0444);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3800d0479698..5563c8a210b5 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -782,32 +782,6 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index, u32 flow_id,
>   #endif
>   #endif /* CONFIG_RPS */
>   
> -/* This structure contains an instance of an RX queue. */
> -struct netdev_rx_queue {
> -	struct xdp_rxq_info		xdp_rxq;
> -#ifdef CONFIG_RPS
> -	struct rps_map __rcu		*rps_map;
> -	struct rps_dev_flow_table __rcu	*rps_flow_table;
> -#endif
> -	struct kobject			kobj;
> -	struct net_device		*dev;
> -	netdevice_tracker		dev_tracker;
> -
> -#ifdef CONFIG_XDP_SOCKETS
> -	struct xsk_buff_pool            *pool;
> -#endif
> -} ____cacheline_aligned_in_smp;
> -
> -/*
> - * RX queue sysfs structures and functions.
> - */
> -struct rx_queue_attribute {
> -	struct attribute attr;
> -	ssize_t (*show)(struct netdev_rx_queue *queue, char *buf);
> -	ssize_t (*store)(struct netdev_rx_queue *queue,
> -			 const char *buf, size_t len);
> -};
> -
>   /* XPS map type and offset of the xps map within net_device->xps_maps[]. */
>   enum xps_map_type {
>   	XPS_CPUS = 0,
> @@ -3828,24 +3802,6 @@ static inline int netif_set_real_num_rx_queues(struct net_device *dev,
>   int netif_set_real_num_queues(struct net_device *dev,
>   			      unsigned int txq, unsigned int rxq);
>   
> -static inline struct netdev_rx_queue *
> -__netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
> -{
> -	return dev->_rx + rxq;
> -}
> -
> -#ifdef CONFIG_SYSFS
> -static inline unsigned int get_netdev_rx_queue_index(
> -		struct netdev_rx_queue *queue)
> -{
> -	struct net_device *dev = queue->dev;
> -	int index = queue - dev->_rx;
> -
> -	BUG_ON(index >= dev->num_rx_queues);
> -	return index;
> -}
> -#endif
> -
>   int netif_get_num_default_rss_queues(void);
>   
>   void dev_kfree_skb_irq_reason(struct sk_buff *skb, enum skb_drop_reason reason);
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> new file mode 100644
> index 000000000000..cdcafb30d437
> --- /dev/null
> +++ b/include/net/netdev_rx_queue.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_NETDEV_RX_QUEUE_H
> +#define _LINUX_NETDEV_RX_QUEUE_H
> +
> +#include <linux/kobject.h>
> +#include <linux/netdevice.h>
> +#include <linux/sysfs.h>
> +#include <net/xdp.h>
> +
> +/* This structure contains an instance of an RX queue. */
> +struct netdev_rx_queue {
> +	struct xdp_rxq_info		xdp_rxq;
> +#ifdef CONFIG_RPS
> +	struct rps_map __rcu		*rps_map;
> +	struct rps_dev_flow_table __rcu	*rps_flow_table;
> +#endif
> +	struct kobject			kobj;
> +	struct net_device		*dev;
> +	netdevice_tracker		dev_tracker;
> +
> +#ifdef CONFIG_XDP_SOCKETS
> +	struct xsk_buff_pool            *pool;
> +#endif
> +} ____cacheline_aligned_in_smp;
> +
> +/*
> + * RX queue sysfs structures and functions.
> + */
> +struct rx_queue_attribute {
> +	struct attribute attr;
> +	ssize_t (*show)(struct netdev_rx_queue *queue, char *buf);
> +	ssize_t (*store)(struct netdev_rx_queue *queue,
> +			 const char *buf, size_t len);
> +};
> +
> +static inline struct netdev_rx_queue *
> +__netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
> +{
> +	return dev->_rx + rxq;
> +}
> +
> +#ifdef CONFIG_SYSFS
> +static inline unsigned int
> +get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
> +{
> +	struct net_device *dev = queue->dev;
> +	int index = queue - dev->_rx;
> +
> +	BUG_ON(index >= dev->num_rx_queues);
> +	return index;
> +}
> +#endif
> +#endif
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 7d47f53f20c1..4ed68141d9a3 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -21,6 +21,7 @@
>   #include <linux/sock_diag.h>
>   #include <linux/netfilter.h>
>   #include <net/xdp.h>
> +#include <net/netdev_rx_queue.h>
>   #include <net/netfilter/nf_bpf_link.h>
>   
>   #define CREATE_TRACE_POINTS
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8e7d0cb540cd..1fee2372b633 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -151,6 +151,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/prandom.h>
>   #include <linux/once_lite.h>
> +#include <net/netdev_rx_queue.h>
>   
>   #include "dev.h"
>   #include "net-sysfs.h"
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 15e3f4606b5f..fccaa5bac0ed 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -23,6 +23,7 @@
>   #include <linux/of.h>
>   #include <linux/of_net.h>
>   #include <linux/cpu.h>
> +#include <net/netdev_rx_queue.h>
>   
>   #include "dev.h"
>   #include "net-sysfs.h"
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 4f1e0599146e..82aaec1b079f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -25,6 +25,7 @@
>   #include <linux/vmalloc.h>
>   #include <net/xdp_sock_drv.h>
>   #include <net/busy_poll.h>
> +#include <net/netdev_rx_queue.h>
>   #include <net/xdp.h>
>   
>   #include "xsk_queue.h"


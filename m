Return-Path: <bpf+bounces-13701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD527DC9C6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 10:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626F9B20DE7
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7116416;
	Tue, 31 Oct 2023 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7ZKiUgy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F413AF0;
	Tue, 31 Oct 2023 09:40:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305FD8;
	Tue, 31 Oct 2023 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698745199; x=1730281199;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RQ59IvOFE5BPJE3ugduzBnh5GP5h/fXdWRJ5zm7z95k=;
  b=k7ZKiUgyqK5OhAwHJZLx1VgVhckmDMMCtitnBd1Vbrg6XaGTiRtHemA1
   wjYY+qDqb+ljcNk9bjmVYqsZyVFf9q4zIeF1y0II+ESnj51hBR9gzTl0K
   lojGhXO1z2rNn4L0tzntXH+t8U4kd6XZLQnaiGuZAvR/ZH5PTC9lva9na
   KU1uXWuIlyKc3zbsX2oScNQ5HcdKiOJOAoMICpGml4JcyDuTnyTPaVhDT
   xHvAZebSMd68U5Szl+Uz3LcIGMxls+KuixffQGPQLd9CVENq4aNhBOuQu
   ID3nOa+gcyviz6SZd6DWhM6Dzutu8EuHcnmXIhX1a5rh1soLpI/TysbCJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1132081"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1132081"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760568862"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="760568862"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 02:39:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 02:39:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 02:39:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 02:39:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 02:39:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIlOcBgyLFvwi6o17VfKd2QYZaZvjLta77K5HyZeIiJsybFW2eY8ACby7pexJWKx77Yz9wP+8BhBzp4/m57XsQ3UbMx8A53Ln0WoHhPL13lOtYPO1LiCXmEYxC7QHNKXcOYdhoLHiE8co3CbH+jZOON/YqLQ8boaUVZeB5eFGzvOIbrDZW2Uyg0fKOlUL6Lcl8S/wp9aLGujMYpVwXYPJK//5UIcP185ZsYwD0R9F3LLO2tnv6lUkWPeMb9YXCSjK1os17RHDt8/FB5c+dPuNf86LTXoEUOfxzePUJP2NLfMpkL29GxxE5bWRsmSWB1Ul9MhwJmWwhET0uZUvOh0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqzMWFIkNXQMxz/AtWbZImCq15avladCxE8DbZRVOrs=;
 b=PUYBiJEIl0cl8KsFezKl6tndiboSJhosYso51Ui5wDsbyx+WrVpS0b8df5B8TYYq+1k2TtHou9qZaAnqfLSTXwZmUTvDSmtuNHm8TtPVowGxCc4USty63a1gVqsxz7sWoy5268HRccx/HVIWG9B4e0QZ/ByYxudUY3JsCuPwwPRuX68vu1WZbiuSqwjfK/jBE2LQ3IvUkT1pScyfzDLlVJVLcT4a1udVTov2L1YKoZZK4DO9nbsBrxCXa7oxY7MYhmPLfS/wXcxd9FqAXeJd6mpqlDIoasFkrQdrNGOH6E1085U9+MWvr4LldgNJEI436Y+u19CPiSAItbz9nyG9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Tue, 31 Oct
 2023 09:39:49 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%6]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 09:39:49 +0000
Date: Tue, 31 Oct 2023 10:39:43 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Simon Horman <simon.horman@corigine.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, John Fastabend
	<john.fastabend@gmail.com>, Aleksander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf-next] net, xdp: allow metadata > 32
Message-ID: <ZUDLX6yqcKLsSknL@lzaremba-mobl.ger.corp.intel.com>
References: <20231026165701.65878-1-larysa.zaremba@intel.com>
 <20231027130930.7d6014df@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231027130930.7d6014df@kernel.org>
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 794daf5c-201e-45f5-fbc3-08dbd9f55370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OY+XdYMmySADxaaK+OKNQkh9VusfgGx08eihXpkidjIhYW58dJ6OKBWSw3plJnXyIfc1PRTU+POoR85ge8uhwjhBtakm/4Wcm78QY0DDFUrrM3E9JZAFhjNyvlsnHA9Oj4NgI+FKY8nqCxfTa59WBmgkrdumrttc5izZokH6tN/0WDMBY06eScBS6dDDeLzI/WK92fZOYcwxEt8Vm4jNqXWd011NEa1s7gsIRDFlPK3zwkyvgyP7KBOIMtipCUeOx4Ejw4vau2XX4xAgtQIMopldgn5rE4dVe4KIhDVsJOWVN0nxYC07TybNKz60osBnrmZYmPUkJDVKwRC7Uq80BidStf3JqNekzJALrLyEzNDp4Qu4rrI0HTr2VvHcgtujDw9YOzH1VPfmxtbGAX8j1md6LUSKMXGB8NX9eKj8pumQizNMUhAXNDvSdLyuwcbL4G4ct8+n8oJzri56GkW1VQxezyFT4QRsfE4W7UvDWYtkEVCL492WjrKkHts2QuMyyWL9BWqn/PtTPWr8iuFllyQwOTtAa3T0qgIOqqOQVzQ5PVQuD1D42GBCUXIUeuED
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82960400001)(4744005)(86362001)(26005)(478600001)(6506007)(66946007)(316002)(6486002)(6916009)(66556008)(66476007)(5660300002)(54906003)(107886003)(6666004)(8676002)(7416002)(6512007)(4326008)(8936002)(2906002)(41300700001)(44832011)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7sp5UO4IYF2BeYj5N4/u1jD7XhsPaaaOAZPjX6qU4lA7btSPMGbkmTW/BHL?=
 =?us-ascii?Q?TiuCLGdkbBQs3Om24TtAmLzTpqroKR9VWh8cghAp82SqcDZEWZ2P16DWdcnt?=
 =?us-ascii?Q?NraZCI1gGFnn8QD0IPFBCv5kWxQ8YzhawHaGXWNaUk30mptfB1PGY+cTvB4X?=
 =?us-ascii?Q?GPGQh9z+a9fSaTE2lMRhgWStQSfPy37KXPvbblLSBlLqz3v2OBp+zi/Zx3vE?=
 =?us-ascii?Q?nUwXCn8EB08KSs9sUZttUqthSSh831QJc2jhp4fopayyPJxUAKde1yIuxDIl?=
 =?us-ascii?Q?F3RdfOw/k371nSof6v7o5jke+KekVODJRoD5B4RVZgKVbu8bRqUVbZYy2hb0?=
 =?us-ascii?Q?FAHdoLkCEekT/Q65bmI+k0hWfk6jCVjOQM7NAkFqZ97sUkRwYnjgoi7vtvKv?=
 =?us-ascii?Q?eBtXZFSnypW1jyGT6AV8W7gsQqL91h3qJwtbIqUvz92umcrDP/ZEz2oTSCK+?=
 =?us-ascii?Q?NQfHg1PZc+q2Kp78lblNJjvFgK2IiGI+fehG+v9picCLKPokGM7wRBqXmHhn?=
 =?us-ascii?Q?B11hjMP7qMOnPHjaADUJw8e5dYGwLlxPNeAjuYWX0B+wtU1na6WuQK0b8uq0?=
 =?us-ascii?Q?03dmxeY+J1t8yMjmPDBgnTZxS19lVSKvP9gqKokx9FNRFzn+rybYs5I3UOSc?=
 =?us-ascii?Q?ByMI9rpHM/tft60GSoy3bVPFHBsedPcEXsbf+bQM0WdJcK3Dxqmg36kmM3Eb?=
 =?us-ascii?Q?GB/fATHX34XID8HwT9Lvkci6PC+2LnZ5ATx3GQM8cGDGKIkVXJUJUDMY7q+6?=
 =?us-ascii?Q?3oO3+QDgGe00S7qfqVmxc6Brt+PZRjR7uf02cgtncHDQlVG+WwQh4kGP4+Ve?=
 =?us-ascii?Q?eY89ElARXXmE0bW8DPkL1IM1tNA9cR/kJL+aH6R02Eu9VngbY4ws21s7iKX4?=
 =?us-ascii?Q?fkaSUniy/OZ4t/waGfSvd4JZb1tV+K4PVrNufDZOtnnAPWAZEwd3KGKF9hDg?=
 =?us-ascii?Q?wotnfrd34vpJEk9CB1MG/kwH2lwRPCxmUBlo2rsi3DWs9tbQ1c+s6PDzzn8b?=
 =?us-ascii?Q?tXL8qPkZp5sQyRzTs6Yv9dFKD2IJdngh1wb4sf+ympve7xwubrCdviZxTk9T?=
 =?us-ascii?Q?mmUUsHOCOOw3M7N37U5atE0dIflzlG6VtBiyTs5BdDzOGh0hsvaeu3565iMM?=
 =?us-ascii?Q?ed48OwcNU1p72dn7nTqNTvxVyqgO+GaTVCC8DOeOaOj2SLnzS7pdUTAyKff7?=
 =?us-ascii?Q?TiSsBRFFYW67SBvOrVMwW3//sPiH9CUa1uBqkJgj4noQmW2jitA/lPdRAHtU?=
 =?us-ascii?Q?0lXN2N9QxNSemHnqGXaj125FgP2f8wq2WAaPZq6gVuDNMdklvl4yT3txWgnR?=
 =?us-ascii?Q?9wKVeB/ofBIeXwKgZE1UayzAfri0xaKmNunIsGiQqXVbs3lheuN0RrKE5qeg?=
 =?us-ascii?Q?jeR56SalsmP8mKdoVB/cDQ6rTAeCp+5FIxaqL1esOEDWQ+bmlytgH2xCaPmm?=
 =?us-ascii?Q?K7G5z0ghUBH8nysX+bMJ+o0L/x2VS3zJhvndt8jz4y3PqNdD4uikPCY26hNF?=
 =?us-ascii?Q?jStm+qPRSm1dhfhMgAL0G4WoZMb0DxoLcY8Dqei/5TlBYbi1tJ0yMzsB4B+w?=
 =?us-ascii?Q?ze03UtZi14fUF6bpvIWjrPBOzrGkJibKQs4a13NGxnrik0Iv0r4+sK+4Exnu?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 794daf5c-201e-45f5-fbc3-08dbd9f55370
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 09:39:49.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q31CRZVsURo5eLeyMQPSS8Uc0exvt1rsRkUl+kIi8eJw/kFzP+v2DdIzrxszbyelhdxagEn6yipfOeYWmhq1rE9QaMrvp2xkpEiHCxbfqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

On Fri, Oct 27, 2023 at 01:09:30PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Oct 2023 18:56:59 +0200 Larysa Zaremba wrote:
> >  static inline bool xdp_metalen_invalid(unsigned long metalen)
> >  {
> > -	return (metalen & (sizeof(__u32) - 1)) || (metalen > 32);
> > +	typeof(metalen) meta_max;
> 
> The use of typeof() looks a bit unnecessary..
>

You are probably right, will send v2 without it. 


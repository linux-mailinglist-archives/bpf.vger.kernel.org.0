Return-Path: <bpf+bounces-14984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCAE7E9ADD
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 12:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9DC1F20FEA
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0FF1CAA7;
	Mon, 13 Nov 2023 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBT+cXIK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A41CA8C;
	Mon, 13 Nov 2023 11:21:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB61D51;
	Mon, 13 Nov 2023 03:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699874464; x=1731410464;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=npRW6akP9If3Td4/3M+nfDWSer9x6SpS8WBv0mxNKag=;
  b=ZBT+cXIK09NeddiqTiOTEhnAEz64umWK3bCUKldKEVmnTLYK7jPkbpHC
   FvHJyC3DSXUj48vYAbaBENh30uRdeAfW6g3i4eZwM5EjhHPs8pQY2Eu+7
   WurwpwL2hqv2wIwOu69EZIgF/37nCl6Grs267IMM/A91kDYcAMQBd59p1
   7d03NgwMMfLyqi/mUyojaoB8TK5uV+S5Kkg47lLyOtzIZ4LoebfsaA2LB
   mDSfoqYA95bBMzcqjQ2UJh9bJMsAml1Vq+bNCPt0NnESZknlrgV7Nervu
   6NQrPNJpUYK3JHOzVPl5HBoAuqSdM4pPOJVpuP0cEYBgZzGTdn19e8Vt3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="394316675"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="394316675"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:21:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="854937932"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="854937932"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 03:21:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 03:21:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 03:21:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 03:21:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 03:21:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZuZ+poN2kLzubFzfj+YyD/06LQ1JB0CJ7IRsiqV+3aQHe/e5K6Qt21W7MX849EfdEHlAzwW9ef4RJmQFRV3WaTqRzLOl9NFbWgaupsvbFj5sGeH32OUiOQqZfUnXh1+1N+8sQ8QBbmbsVNxKYyg/OD2XXZTKwKDPWFndqadXUD4mj3q4nSw9II8QYerf2MTCpgBqwl79RlCMmGglZMg46zlfhIIo/WS3IFOwrkw0+P1MzqNW/DhgD4eN9/4Iyi4cy4sPKozXG1QrzHvb9drn5eFcrhUZ7JEKGX2lkU+EjgMZWh2n5ri8WTSa6iK1Iod0UnnCQwn11cejx9xQWJD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5Bok0/KAUz97kSIzXO+4eiY999qyCXG9fLP1mW2e3I=;
 b=OOUsgOe3R6eHO2kVwrLc+5XE5ciUOG348aMum+VT8GYZCalqPG7VNeEkhiobGovAvQh3YicSUKw8cZgA0IUb9j7jHte4IdF8y2IzDiIfndf7mmNLgDVbGdDW7MXZNsBHu1SQzvPIetv6aus69g2g0OxkQfE8crQNYFHa9A/4nAMGt1M20HyWAk4g5sa3u4UBKgnUeWv8LFkQxWTAOLNZQ1G7xcjVc8mFe78qvg4cMikfauFVe+MjbXxoQLxb6SzGp/eELVt/yOUGkHEaVk0Z8JCmmZjK2FJpIBHEQOq3fCSA4ClIctqbBjAmoivaP9nziGZ4mTkNwxizunM75a5B6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB5797.namprd11.prod.outlook.com (2603:10b6:303:184::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Mon, 13 Nov
 2023 11:20:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 11:20:59 +0000
Date: Mon, 13 Nov 2023 12:20:46 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED
 test.
Message-ID: <ZVIGjshhLOeuMXQN@boxer>
References: <20231103142936.393654-1-tushar.vyavahare@intel.com>
 <ZUubk1lZ6WDDV2k+@boxer>
 <IA1PR11MB65141693FD1808D40560A4FC8FB3A@IA1PR11MB6514.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA1PR11MB65141693FD1808D40560A4FC8FB3A@IA1PR11MB6514.namprd11.prod.outlook.com>
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e3504b-7221-4f48-d2e2-08dbe43a9c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6HyoK4FSImPZkpJINJ8+Tg8jKDnPuMMVUD4iZN6Nx4pj+PrULfbyoZbfEGan4+VKSlGPCMFc92U0oaQ5AFfvEU1cA8x9LRQ8prZDwNlufwxtt0Be3wx7PPhB7dFi1bGwxX6P8kTD5UVW8JN572Y0m8oyPBlDyYVShAf8GlDiuoc8jZziwzJVJx9acujinc2He0frCOea9u1D0qPYmF1WkFVxR9wRjhA6oCc3qyjZrYHcef0RxNw8w3SkJZnbc8Xn9yn+lVxqcUj73grxsYGzAKeOThV34YSdezIgF8ahaYDKC44UE3QlKH8wPuhTXXyeL+VhnL/fr14m0JqgsRzx8uihLJWkdeBmGBuL/uX0BkPKmR/8EUpaMgsbKdrx1NXLqBhTdr839OTnDWVTM5Scn4MvIB9mIIUHFvqRelPtbDnTxD/4rxu4kZNA/j3TnWT5q6jRjgmEJo8dvNq6rf246Mf9UJ8EJ6gOZBljqovrTaUyVUrwOpkreBH6MqIUeEfBNKZhApI/NWGwiaXrNGfCE1Kd+HpsJb79emJMjwv/qfZJZ9mzBB6QnwN1ShkJYah
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6636002)(107886003)(26005)(6506007)(33716001)(53546011)(6666004)(9686003)(6512007)(83380400001)(44832011)(5660300002)(4326008)(6862004)(8936002)(8676002)(30864003)(2906002)(41300700001)(6486002)(478600001)(316002)(54906003)(66476007)(66556008)(66946007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTs9S9aSmglO5tXKC5x2EpIHVJ6GAQXZXzFswpKdIaXWwi4qqvatP9l4Hp5g?=
 =?us-ascii?Q?hN/Y6stDE8NCs2aDK2CKzadI9HQA7bixuasPitpWGANMkW/2/KFT6KgqTtNQ?=
 =?us-ascii?Q?luGyk/7NXfsJTQbc/cVA0lmHeqYAg9nGqnZOkJvnWnRcWvnPDXll+XKA9uAH?=
 =?us-ascii?Q?4pnGHaXbpIOPn6wmn03bPWjhujx/3swFIm056nr9rPlrTn+1ViztmfiW0yMk?=
 =?us-ascii?Q?z8rLJwKBhqPV+KfUlOjlVrcJdyXJuLauSS1b+paDHp6CljvsCvZlF8HrB+Lz?=
 =?us-ascii?Q?5fr+2THfvXj3CarpSnqt/jR4/y+W7kjPJ6nxnUkWhIEYlDvbvtNcq980RlbY?=
 =?us-ascii?Q?QvzYQKNdBnydEzcR7hSx+FC65kRcD3HrGj5FgKNGVhknfm3ucerGhDXIeJM5?=
 =?us-ascii?Q?38Axb8fIJ8Sz217Ikk35kpY7JewVKkMd91UzKeuhuj6WMjTbPD/bDg/LPmVs?=
 =?us-ascii?Q?6PqGt+ijVjCfK9YJbLOoXrE9pWhWas5vfG8AXX8fsrICr703NVnpQ9aCROV7?=
 =?us-ascii?Q?EC81wG/35L3B+F4xCQWvIqwT30+LxFz25zN3MiK8TjwrJoNpVzN/q4OaHIvE?=
 =?us-ascii?Q?wqHZMk+u7ZVbMOc9p3UKZZYN2cfeko3Qh24bshQmqNsXyKAJg3XIbr8c0pmA?=
 =?us-ascii?Q?w0y/br/jncpgeCubP4wEtBgDb9JmhSRkfKGKPFMevKT1W1iGIxm8rFzvlbIG?=
 =?us-ascii?Q?EE3podSzXfmyIiWIbsBpzQX7JVkqtbCjr47snfrohXNRXC3HKwcuFEYzI2yK?=
 =?us-ascii?Q?ihRfDxRPL3XtmVOFpvAtz/6+432xZif0rlmjTdAKry3r7HUSZ/FH9A1IARJr?=
 =?us-ascii?Q?jTQB6xhk9TnSss4RP/5S+7Cr4aFUgi0WBgoEiQKD9PGp7VGhHG+uvz/VxJYp?=
 =?us-ascii?Q?sNLsyyS7o9Er01VCQS7smzH8fZpYK8vAXMevbIZPT31L1/shBTRw30qyT3Sp?=
 =?us-ascii?Q?zmqL9pc/rlMF3vC05AXPPFq6xSY0JOJMRG8oP+Vhq8jEOuWsQHGEZA076zZJ?=
 =?us-ascii?Q?dOfec1mWhNoKitzSDY5YUMUCQrSbMYJgQcxWCuV/LS48cyMuoq36eUjHKm97?=
 =?us-ascii?Q?ukDy4hCLwaV+vthfLIZv317jsRlLRWyD1c0xfkjNfFxHQ4UgaYu0HENfnkjh?=
 =?us-ascii?Q?c/mnnxEFm6KZ9MQ9xxI+WrF2FJDKxZgTHSObOfE4ybT/YYBLjeY8wzhKT3GR?=
 =?us-ascii?Q?IEVgIehO9yAD450jmLntGkx5Nvni+RnOdLBM0OaB8LUvjNGOtrUevk2Evxk7?=
 =?us-ascii?Q?E3rERafxJOfUlag5grHzp1At25S0VZgahEXlqS0YOS2TImldD6RSvybh2vyp?=
 =?us-ascii?Q?V5eWMRvnl/KbAGq8XTi4Gm33H8Xlon7B95kekHREhyEe8sA360xX5yVneRzO?=
 =?us-ascii?Q?FmNCfb70/31LFADNLg335uX539YLmufzBni8+9AMjb1rjOe+Nm1e93ehb5M7?=
 =?us-ascii?Q?Q7UkAfSZojetZEK7c9mE9wdVp1eyrOSvwqpHi1C2gf5aZcJlFeaFjcbsS+E+?=
 =?us-ascii?Q?NnrxrzDtoOaEEYgZT7E409UQSDGQG/a/wWSCuMcP1Nh/uqyeoRti8Md0mLZi?=
 =?us-ascii?Q?2LwkMFdajuMW2kNbt1+hTTwDo8YikDW0eQJaOdkdK4LWlmyqwhPOnsPaguWB?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e3504b-7221-4f48-d2e2-08dbe43a9c82
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 11:20:59.0784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3oGVxbbU3SgvZYsRNOTG6hb6R2qGlJNYAch02wKqPIoMenhyLtENU+Nq7uMt+gnr8Ivi6Xpuic6NNM86QBOZ0pElgzV+88XytBdrkNOOfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5797
X-OriginatorOrg: intel.com

On Mon, Nov 13, 2023 at 07:42:09AM +0100, Vyavahare, Tushar wrote:
> 
> 
> > -----Original Message-----
> > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > Sent: Wednesday, November 8, 2023 8:01 PM
> > To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlsson,
> > Magnus <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com;
> > davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> > ast@kernel.org; daniel@iogearbox.net; Sarkar, Tirthendu
> > <tirthendu.sarkar@intel.com>
> > Subject: Re: [PATCH bpf-next] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED
> > test.
> > 
> > On Fri, Nov 03, 2023 at 02:29:36PM +0000, Tushar Vyavahare wrote:
> > > Fix test broken by shared umem test and framework enhancement commit.
> > >
> > > Correct the current implementation of pkt_stream_replace_half() by
> > > ensuring that nb_valid_entries are not set to half, as this is not
> > > true for all the tests.
> > 
> > Please be more specific - so what is the expected value for nb_valid_entries for
> > unaligned mode test then, if not the half?
> > 
> 
> The expected value for nb_valid_entries for the SEND_RECEIVE_UNALIGNED
> test would be equal to the total number of packets sent.
> 
> > >
> > > Create a new function called pkt_modify() that allows for packet
> > > modification to meet specific requirements while ensuring the accurate
> > > maintenance of the valid packet count to prevent inconsistencies in
> > > packet tracking.
> > >
> > > Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem
> > > feature")
> > > Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > > ---
> > >  tools/testing/selftests/bpf/xskxceiver.c | 71
> > > ++++++++++++++++--------
> > >  1 file changed, 47 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c
> > > b/tools/testing/selftests/bpf/xskxceiver.c
> > > index 591ca9637b23..f7d3a4a9013f 100644
> > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > @@ -634,16 +634,35 @@ static u32 pkt_nb_frags(u32 frame_size, struct
> > pkt_stream *pkt_stream, struct pk
> > >  	return nb_frags;
> > >  }
> > >
> > > -static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt,
> > > int offset, u32 len)
> > > +static bool pkt_valid(bool unaligned_mode, int offset, u32 len)
> > 
> > kinda confusing to have is_pkt_valid() and pkt_valid() functions...
> > maybe name this as set_pkt_valid() ? doesn't help much but anyways.
> > 
> 
> will do it.
> 
> > > +{
> > > +	if (len > MAX_ETH_JUMBO_SIZE || (!unaligned_mode && offset < 0))
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void pkt_set(struct pkt_stream *pkt_stream, struct xsk_umem_info
> > *umem, struct pkt *pkt,
> > > +		    int offset, u32 len)
> > 
> > How about adding a bool unaligned to pkt_stream instead of passing whole
> > xsk_umem_info to pkt_set - wouldn't this make the diff smaller?
> > 
> 
> We can also do it this way, but in this case, the difference will be
> larger. Wherever we are using "struct pkt_stream *pkt_stream," we must set
> this bool flag again. For example, in places like 
> __pkt_stream_replace_half(), __pkt_stream_generate_custom() , and a few
> more. I believe we should stick with the current approach.

We have a default pkt streams that are restored in run_pkt_test(), so I
believe that setting this unaligned flag could be scoped to each test_func
that is related to unaligned mode tests?

> 
> > >  {
> > >  	pkt->offset = offset;
> > >  	pkt->len = len;
> > > -	if (len > MAX_ETH_JUMBO_SIZE) {
> > > -		pkt->valid = false;
> > > -	} else {
> > > -		pkt->valid = true;
> > > +
> > > +	pkt->valid = pkt_valid(umem->unaligned_mode, offset, len);
> > > +	if (pkt->valid)
> > >  		pkt_stream->nb_valid_entries++;
> > > -	}
> > > +}
> > > +
> > > +static void pkt_modify(struct pkt_stream *pkt_stream, struct
> > xsk_umem_info *umem, struct pkt *pkt,
> > > +		       int offset, u32 len)
> > > +{
> > > +	bool mod_valid;
> > > +
> > > +	pkt->offset = offset;
> > > +	pkt->len = len;
> > > +	mod_valid  = pkt_valid(umem->unaligned_mode, offset, len);
> > 
> > double space
> > 
> 
> will do it.
> 
> > > +	pkt_stream->nb_valid_entries += mod_valid - pkt->valid;
> > > +	pkt->valid = mod_valid;
> > >  }
> > >
> > >  static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len) @@
> > > -651,7 +670,8 @@ static u32 pkt_get_buffer_len(struct xsk_umem_info
> > *umem, u32 len)
> > >  	return ceil_u32(len, umem->frame_size) * umem->frame_size;  }
> > >
> > > -static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32
> > > pkt_len, u32 nb_start, u32 nb_off)
> > > +static struct pkt_stream *__pkt_stream_generate(struct xsk_umem_info
> > *umem, u32 nb_pkts,
> > > +						u32 pkt_len, u32 nb_start,
> > u32 nb_off)
> > >  {
> > >  	struct pkt_stream *pkt_stream;
> > >  	u32 i;
> > > @@ -665,30 +685,31 @@ static struct pkt_stream
> > *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
> > >  	for (i = 0; i < nb_pkts; i++) {
> > >  		struct pkt *pkt = &pkt_stream->pkts[i];
> > >
> > > -		pkt_set(pkt_stream, pkt, 0, pkt_len);
> > > +		pkt_set(pkt_stream, umem, pkt, 0, pkt_len);
> > >  		pkt->pkt_nb = nb_start + i * nb_off;
> > >  	}
> > >
> > >  	return pkt_stream;
> > >  }
> > >
> > > -static struct pkt_stream *pkt_stream_generate(u32 nb_pkts, u32
> > > pkt_len)
> > > +static struct pkt_stream *pkt_stream_generate(struct xsk_umem_info
> > > +*umem, u32 nb_pkts, u32 pkt_len)
> > >  {
> > > -	return __pkt_stream_generate(nb_pkts, pkt_len, 0, 1);
> > > +	return __pkt_stream_generate(umem, nb_pkts, pkt_len, 0, 1);
> > >  }
> > >
> > > -static struct pkt_stream *pkt_stream_clone(struct pkt_stream
> > > *pkt_stream)
> > > +static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream,
> > > +					   struct xsk_umem_info *umem)
> > >  {
> > > -	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream-
> > >pkts[0].len);
> > > +	return pkt_stream_generate(umem, pkt_stream->nb_pkts,
> > > +pkt_stream->pkts[0].len);
> > >  }
> > >
> > >  static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts,
> > > u32 pkt_len)  {
> > >  	struct pkt_stream *pkt_stream;
> > >
> > > -	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> > > +	pkt_stream = pkt_stream_generate(test->ifobj_rx->umem, nb_pkts,
> > > +pkt_len);
> > >  	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
> > > -	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> > > +	pkt_stream = pkt_stream_generate(test->ifobj_tx->umem, nb_pkts,
> > > +pkt_len);
> > >  	test->ifobj_rx->xsk->pkt_stream = pkt_stream;  }
> > >
> > > @@ -698,12 +719,11 @@ static void __pkt_stream_replace_half(struct
> > ifobject *ifobj, u32 pkt_len,
> > >  	struct pkt_stream *pkt_stream;
> > >  	u32 i;
> > >
> > > -	pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream);
> > > +	pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream, ifobj-
> > >umem);
> > >  	for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
> > > -		pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
> > > +		pkt_modify(pkt_stream, ifobj->umem, &pkt_stream->pkts[i],
> > offset,
> > > +pkt_len);
> > >
> > >  	ifobj->xsk->pkt_stream = pkt_stream;
> > > -	pkt_stream->nb_valid_entries /= 2;
> > >  }
> > >
> > >  static void pkt_stream_replace_half(struct test_spec *test, u32
> > > pkt_len, int offset) @@ -715,9 +735,10 @@ static void
> > > pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int off
> > > static void pkt_stream_receive_half(struct test_spec *test)  {
> > >  	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
> > > +	struct xsk_umem_info *umem = test->ifobj_rx->umem;
> > >  	u32 i;
> > >
> > > -	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream-
> > >nb_pkts,
> > > +	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(umem,
> > > +pkt_stream->nb_pkts,
> > >  							      pkt_stream-
> > >pkts[0].len);
> > >  	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
> > >  	for (i = 1; i < pkt_stream->nb_pkts; i += 2) @@ -733,12 +754,12 @@
> > > static void pkt_stream_even_odd_sequence(struct test_spec *test)
> > >
> > >  	for (i = 0; i < test->nb_sockets; i++) {
> > >  		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
> > > -		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts /
> > 2,
> > > +		pkt_stream = __pkt_stream_generate(test->ifobj_tx->umem,
> > > +pkt_stream->nb_pkts / 2,
> > >  						   pkt_stream->pkts[0].len, i,
> > 2);
> > >  		test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;
> > >
> > >  		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
> > > -		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts /
> > 2,
> > > +		pkt_stream = __pkt_stream_generate(test->ifobj_rx->umem,
> > > +pkt_stream->nb_pkts / 2,
> > >  						   pkt_stream->pkts[0].len, i,
> > 2);
> > >  		test->ifobj_rx->xsk_arr[i].pkt_stream = pkt_stream;
> > >  	}
> > > @@ -1961,7 +1982,8 @@ static int testapp_stats_tx_invalid_descs(struct
> > > test_spec *test)  static int testapp_stats_rx_full(struct test_spec
> > > *test)  {
> > >  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS +
> > DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> > > -	test->ifobj_rx->xsk->pkt_stream =
> > pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> > > +	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test-
> > >ifobj_rx->umem,
> > > +
> > DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> > >
> > >  	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
> > >  	test->ifobj_rx->release_rx = false;
> > > @@ -1972,7 +1994,8 @@ static int testapp_stats_rx_full(struct
> > > test_spec *test)  static int testapp_stats_fill_empty(struct test_spec
> > > *test)  {
> > >  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS +
> > DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> > > -	test->ifobj_rx->xsk->pkt_stream =
> > pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> > > +	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test-
> > >ifobj_rx->umem,
> > > +
> > DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> > >
> > >  	test->ifobj_rx->use_fill_ring = false;
> > >  	test->ifobj_rx->validation_func = validate_fill_empty; @@ -2526,8
> > > +2549,8 @@ int main(int argc, char **argv)
> > >  	init_iface(ifobj_tx, worker_testapp_validate_tx);
> > >
> > >  	test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
> > > -	tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT,
> > MIN_PKT_SIZE);
> > > -	rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT,
> > MIN_PKT_SIZE);
> > > +	tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem,
> > DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> > > +	rx_pkt_stream_default = pkt_stream_generate(ifobj_rx->umem,
> > > +DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> > >  	if (!tx_pkt_stream_default || !rx_pkt_stream_default)
> > >  		exit_with_error(ENOMEM);
> > >  	test.tx_pkt_stream_default = tx_pkt_stream_default;
> > > --
> > > 2.34.1
> > >


Return-Path: <bpf+bounces-15065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762D7EB549
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 18:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B451C20B29
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE041237;
	Tue, 14 Nov 2023 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoAizpae"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7441741;
	Tue, 14 Nov 2023 17:03:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B9FB8;
	Tue, 14 Nov 2023 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699981437; x=1731517437;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0OrbkmIQ22EiN1pknDxjQ/dT9e5FPvFosOpZ7pBQ3yI=;
  b=EoAizpaeLnGPmIz1W+mDfPcTsA+t2Etl/LBw0FX333A2bvtFXJfuIF4J
   0fOsFyou/CTMt0QJp7+JrcPbBB8VBdiT5AI41pXYcYRoKytztHbrW5DWS
   P3STUx4TCxhjle2RGPPAEQI+hX+dj24gBLv4abFI+6jdu2twyn1yh+3V0
   RPVwqQRrvx/ebjzWgkAdd9SWjOW9KCBXFVZEeYZJ1mwYVzGdp0/WVUbjz
   rC1V3u9x+FtzDIIzEAsLk5V2l8oqjZAh74SEYhUbZBK+ZSGWNQZzt7lUe
   CWVABOJTj8A3iVzkdjVcMBRdYD/tQHcZD/4mz7XejJ2tVtLy0KlcOCr0D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="9334564"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="9334564"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 09:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="758227274"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="758227274"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 09:03:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 09:03:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 09:03:38 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 09:03:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LflI2+wvhoPPqyBtSN4k1mppkchJ8rpqE3zAXhafPAFAqvluaMyYKcyCjZhfOPbEZ4GFA9IPfksSPTTa86BAQhG3S/gVcACNHv/J9UDHFoCD/edj3laRmFSoL/O1PhZ71XjxJ2+9FJJht4sNb1HxMcaCUQKcKPo33HXxJ8mquwsT6yaDSfkZpA7RklueqXm2Pr/K0KnOmrE4AqfPYVrN9VR/NHD3a9YVhlPR4OuxoQVQvsyCK1XrHry64/d6VZzuVESMBJSuPfZOnFg8EQArI5sBiN6DmFsHgY7GqFuSwk6fb1+kh/2xzg90/aA7zAosZGgANwgjY0pA/XgBZ9kNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krPtTpx6trRGKYy3XpgS+QsYEqHCBtVfoMyVt8SVL7k=;
 b=iRvi4q9y26GTn8CnlsjNHNgbX2zd+V3CpUiJoPHzn0daddTJ+19j87187NIbJFPkqTYl15fQPZkzzZoCCiPrlqWbQXyk8aR13McsqiZQRRn+QAeCiTo91yC+ldVHYtt6HWmfahIUaa5sUPEe3ejGJe2SjVVpXJS8Og2gb6oZptR65LMOkHYSKJrm3rndqMzJ3MVM6b/rlbfYRO4c42uKgzP9WYHorkopjWWvWeOMYVf0MjgmaKOo7LvQ7XDf4W/H4VTO6ktTPCWwHP7NS+4gHhpzB2/Kkf1vOmfO21LKwcTUmhCebtm8pTDD8jVeVryRTVS9MpQKE1MnrZNGlHqlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6075.namprd11.prod.outlook.com (2603:10b6:208:3d5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Tue, 14 Nov 2023 17:03:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 17:03:34 +0000
Date: Tue, 14 Nov 2023 18:03:23 +0100
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
Message-ID: <ZVOoWyTMLMPxyExo@boxer>
References: <20231103142936.393654-1-tushar.vyavahare@intel.com>
 <ZUubk1lZ6WDDV2k+@boxer>
 <IA1PR11MB65141693FD1808D40560A4FC8FB3A@IA1PR11MB6514.namprd11.prod.outlook.com>
 <ZVIGjshhLOeuMXQN@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVIGjshhLOeuMXQN@boxer>
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6885ab-77a6-4086-fb33-08dbe533a315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LP0+PGXiJgNih2To0TgzGV3Yc9YZhfiAK4kIpEKjDNYjLCz4To0+LkNsrg0ss/zCSUQoxfzFWzO1U6V1W+MAl/6baZomIgDQnPtDt6jDlAyUmUVsKr2XmoedjR+ydlg5Ui/NZCxwAKuyYtaa9QT+I1GFYttDIXEbAQlrVPrUWb2aDFcadFUf0884r7TiuU+2zrAonn1z0YOvGF1Lg98UCpN4Ym+nf6PXpVr8d4xkb6PAEMACgaQBpIlYTnCVsuZdLPB5y1b+KTB6VMIZDPX9ZBHe3c2r+tKo8P/OnDo6eT39MKJGnARUf1jFEGuNcL1dJ3hJCsBKo8JeCM0fZiqEkUlG9F/HUOpJHaSJ9CD5MNz6IoQs9JH+0DAxizypiJJavF1eGjohbY8X39kpuqvVUpC49bwaAmBKZaQvr/5rlqr+B2/AMjPlXwS0b3JBG3VI792vwdTAqTiuBEWFNK2VNe69WEl7zWf5PQB4rQfThvvFO+0C/vITpvydXAC95C8R9WoD73tkrHXFX0mkmXgDkE3yTo9lT8lffLTiR1+x6q6QNCvozlAUW2kVF79os6di
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(54906003)(66556008)(9686003)(66476007)(6636002)(6512007)(66946007)(316002)(83380400001)(38100700002)(82960400001)(6862004)(8676002)(8936002)(4326008)(6486002)(478600001)(6666004)(6506007)(53546011)(44832011)(86362001)(5660300002)(107886003)(2906002)(33716001)(26005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ar9peinywuxHq8CfhzkmK34e6E49CCSDkoNn020OIEMqRqxP4vpmlgBdmXLv?=
 =?us-ascii?Q?8PUZGx+Xi5TqE0sP/khk2mNfe5JlRELLIV2T2yO2FOReX5BLn9NT80FsAcNO?=
 =?us-ascii?Q?SKaA2KgReX5bO3VLtxKEcH53YQaxldvQlIQmYCrkCoG26YNMe3oOUr69wrNa?=
 =?us-ascii?Q?phjH7KSBTorXZZIswHZZwFz5FaNeX8b42hAh4XbtDKDeDGgsCD+NRgRFc2Hv?=
 =?us-ascii?Q?FJLkyaNbV7xtUtRdHgbN1Cdh48BQDcQ8fweoLjWlbcN3us8RCObY61/vc89e?=
 =?us-ascii?Q?Z3ADNtHp0ULmibTvZtl3pEjun9AIyfFfDIx5P+09MuN0DwmhMimp/WbuKktn?=
 =?us-ascii?Q?s1Ye/FQK4ZRZC29jjNWqYIpfPd/6oyTThXnzdaa47r08H4+47eem6nK4bY4f?=
 =?us-ascii?Q?06usg3jbn04mevuTY3h6n7ghfXXDsvmFZN9RmVdqmrfPJ05dkT/vG8+QUJEU?=
 =?us-ascii?Q?O0a6tDoHZdTCcwVzD7NcPKhGvcKe74tF5vwdVyabtzY179tnGNdPgyqCXOOJ?=
 =?us-ascii?Q?EWlQrBhzNxJMohf8PdT65Z35JzAyUGzk3eTTWRIbfko0yeKYQ7PTucF+mioa?=
 =?us-ascii?Q?CZHL0DPHVVwZ5Y9HmhwsAdYgTIgkwYK2qC/GA+JtywnYEd+V3nmqj/tnxzXD?=
 =?us-ascii?Q?s4MsgS40r96DW208v/ll+gZVtu15Bf+8jzq93RsTMfE5eCTYWnXVNOYowjUf?=
 =?us-ascii?Q?b+TBBzQWKyOoSMg0pTbpC65pPqQPg0E91nbEZ2FEIP03bUtkffPHMUfR6kFU?=
 =?us-ascii?Q?6IHZTGcFcnT91FsUr1t8vuz0PXXtDM2zoD2GBY59ovt1BrsrQdBnx2wegxdP?=
 =?us-ascii?Q?zu1WDiZcC66eQbHRCHcVn8KJurdOBx6UDwxl9+fBEgqOEpk6xYyFFdZSYQrz?=
 =?us-ascii?Q?ggRrYPOlY7OTHo+5sCa5XAYI54iVYBn/QMouOgFfD+reDE2ql88Duw28Nz0E?=
 =?us-ascii?Q?1IksaLCuKWyA3BdbD32n9iuO1hniK/pZWjrR5/94uTZOH3Ec5ABCiBxWDAUN?=
 =?us-ascii?Q?yWmybcNsx2xAgG9t1g03esqi4FfMm2FO8NDw9XhBoUhLNzD5JWkG3FMX8vp9?=
 =?us-ascii?Q?/qULqdTK9uld4BefZW+qBBjkg55dRBRzMXLUPXG0a/sbRL3zs6erYN7WV9A5?=
 =?us-ascii?Q?uyL3tpp64DdY6BOy7N9oGnZWrHUO4AjVWYuagCrQ198nYbjFqVbO7E/RGl0L?=
 =?us-ascii?Q?nUsocUMSjWtZZJ9GZX8kS1W7skYE/IGekwKDvNegtvsqNbsFsmTuuPlAtJMX?=
 =?us-ascii?Q?pmsNgNuq8IXM88clGwZsT8ElYPd3TZLtLAWresjVLPVlWnxaFgBn2FlxBM2Z?=
 =?us-ascii?Q?O8ISh3E8U3fr9gfABf26jy+qq+FfE5A2NXQTzrQRzXpDUTN9aYNlVgGFulE9?=
 =?us-ascii?Q?xvo2P+Jmcvhc+QZyegJdKVmb3dm0Aq3NdRAHS0qA3qI8J4JpokGvWo3yFT8J?=
 =?us-ascii?Q?DSgif41hm1VlYAYn7zxjjNEd6W7/pQIAcC6aMw2i6FHi7zIAC5ARBMqqIbrL?=
 =?us-ascii?Q?Yb+b09xyNBrGmdLTSMwtwJJM0JpbLXTLe0qKl8O5ysVOh2dlRHqeYCB5s5SQ?=
 =?us-ascii?Q?s+rkpl/ZHlnTo9QIZL6C7rRrciekgpopZqUOx9KX4w2wVr3rbNYMvOGDERtQ?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6885ab-77a6-4086-fb33-08dbe533a315
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 17:03:34.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XylLFPA4Br5OdWsG8N09hzY2qdDGOT2B+1hfW0RAiafPO4dsTyoXMzr1/AuHUGn3r+/V6SzK+f4wVfyOdztEag/X9XDLDhHkv9KLzGv5+0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6075
X-OriginatorOrg: intel.com

On Mon, Nov 13, 2023 at 12:20:46PM +0100, Maciej Fijalkowski wrote:
> On Mon, Nov 13, 2023 at 07:42:09AM +0100, Vyavahare, Tushar wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > > Sent: Wednesday, November 8, 2023 8:01 PM
> > > To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> > > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlsson,
> > > Magnus <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com;
> > > davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> > > ast@kernel.org; daniel@iogearbox.net; Sarkar, Tirthendu
> > > <tirthendu.sarkar@intel.com>
> > > Subject: Re: [PATCH bpf-next] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED
> > > test.
> > > 
> > > On Fri, Nov 03, 2023 at 02:29:36PM +0000, Tushar Vyavahare wrote:
> > > > Fix test broken by shared umem test and framework enhancement commit.
> > > >
> > > > Correct the current implementation of pkt_stream_replace_half() by
> > > > ensuring that nb_valid_entries are not set to half, as this is not
> > > > true for all the tests.
> > > 
> > > Please be more specific - so what is the expected value for nb_valid_entries for
> > > unaligned mode test then, if not the half?
> > > 
> > 
> > The expected value for nb_valid_entries for the SEND_RECEIVE_UNALIGNED
> > test would be equal to the total number of packets sent.
> > 
> > > >
> > > > Create a new function called pkt_modify() that allows for packet
> > > > modification to meet specific requirements while ensuring the accurate
> > > > maintenance of the valid packet count to prevent inconsistencies in
> > > > packet tracking.
> > > >
> > > > Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem
> > > > feature")
> > > > Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/xskxceiver.c | 71
> > > > ++++++++++++++++--------
> > > >  1 file changed, 47 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c
> > > > b/tools/testing/selftests/bpf/xskxceiver.c
> > > > index 591ca9637b23..f7d3a4a9013f 100644
> > > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > > @@ -634,16 +634,35 @@ static u32 pkt_nb_frags(u32 frame_size, struct
> > > pkt_stream *pkt_stream, struct pk
> > > >  	return nb_frags;
> > > >  }
> > > >
> > > > -static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt,
> > > > int offset, u32 len)
> > > > +static bool pkt_valid(bool unaligned_mode, int offset, u32 len)
> > > 
> > > kinda confusing to have is_pkt_valid() and pkt_valid() functions...
> > > maybe name this as set_pkt_valid() ? doesn't help much but anyways.
> > > 
> > 
> > will do it.
> > 
> > > > +{
> > > > +	if (len > MAX_ETH_JUMBO_SIZE || (!unaligned_mode && offset < 0))
> > > > +		return false;
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > > +static void pkt_set(struct pkt_stream *pkt_stream, struct xsk_umem_info
> > > *umem, struct pkt *pkt,
> > > > +		    int offset, u32 len)
> > > 
> > > How about adding a bool unaligned to pkt_stream instead of passing whole
> > > xsk_umem_info to pkt_set - wouldn't this make the diff smaller?
> > > 
> > 
> > We can also do it this way, but in this case, the difference will be
> > larger. Wherever we are using "struct pkt_stream *pkt_stream," we must set
> > this bool flag again. For example, in places like 
> > __pkt_stream_replace_half(), __pkt_stream_generate_custom() , and a few
> > more. I believe we should stick with the current approach.
> 
> We have a default pkt streams that are restored in run_pkt_test(), so I
> believe that setting this unaligned flag could be scoped to each test_func
> that is related to unaligned mode tests?

Ok now I see that we are sort of losing context when generating pkt
streams, that's a bit unfortunate in this case. Maybe we can think of some
refactor later on.


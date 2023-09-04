Return-Path: <bpf+bounces-9217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398CD791C5D
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41F8280ECD
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE57C8EE;
	Mon,  4 Sep 2023 18:09:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70EA94A;
	Mon,  4 Sep 2023 18:09:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E8F1B6;
	Mon,  4 Sep 2023 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693850969; x=1725386969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bZ4CHvUZwq3mimJJ5VAXKyJ+hCaOV8tUHcUwMPw59Ho=;
  b=Wl/Ftk02B4fbJDgrIqnEwWyiKwQhWO1kXNhiv/hXeEGFSuDh+p7+MWJS
   hyXUIinDi/GJEDFA3haxF08gsMQ4w8+m5PA32yI+a9f8wAjxiTHWN8czR
   wWquo1z7NVyP0UfU+MOLfI27OGVkDO4oMN09zcTH4Wc2+QXQohVShrN/R
   Zc10g8mHQRN0BmS6zjAt5Hhp6T18znRhAfsCH0ONucBu5254uY3/EHem8
   5Pov9XO0911+cy2ZVwNqo58KenAdHw+RBIklRDksqLmkhEpGwFS0Ln0bw
   HBhz5xs/YLEKQ2BAawgg04zz7retsa4+9h8gYVrwxcGEwhU9dStVSTxdy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="375533896"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="375533896"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 11:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="690659607"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="690659607"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 11:09:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 11:09:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 11:09:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 11:09:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 11:09:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cewsH7KGBGF+stlqHr2mEmIfkPdvS6Njbg/1OjzQJc5i42ilcWuwRwkrK6T0tca8AtMs3HjLQ9yKEHUcfImm/Eabd5UxTTV9K2lPl6H9IRCtvwJc/jrQNYtBplibmI95D5Zd570VoviIAjjT8xR3IgnlzC7nW07jmk+QEvwb00syW82fY6+kcEnz4/U3H3HP/KEMxqzWiGN4t+Ti2vwq47oGQjMdLJXnhPauUqvrDlZVXHohXP2RCkPiMsntqN9co3+KFejSOxeFuYQdWacKA7lFiG6L7aTGpee8Q72h66AIEKa1kV+saW+KhC8K6GYRjhM8uJUNzztzIB+0/iQeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzDDdRcll+AIgnwlDuZHu8o/QotBNX8DCqwe1pBOiog=;
 b=RrSfER8grKInIsLopKsSJyAJQfl5thYfkrOsbbGMznQDA7W/PTyJK4XDjPhdup+vLovWU99b8550ZwdZFzxYw+l10OfiYLFUindPhhY7mtaStGUGEEQZ1PDjSR9SQrTUTOMQ5QpNqpHt24kYkVLT83pPz1MuZLmSHMejHbadUlFqG07tn3ioh+fsAf6GROtmTTXal6PxDU3Hq6r8qcGZRR/H3LIEibXmnvK1FrDRWog6obb5N9b4X/WZ6JCvFN7NlX5jtqrsu5i8oKX36hASq17/EH99CYqA7iaXZI/GwV0J16LsZRJVftSmsBo5CUI88mZrNF1TyrqLEnMkRURZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH8PR11MB6926.namprd11.prod.outlook.com (2603:10b6:510:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 18:09:24 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 18:09:24 +0000
Date: Mon, 4 Sep 2023 20:01:06 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
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
Subject: Re: [xdp-hints] [RFC bpf-next 03/23] ice: make RX checksum checking
 code more reusable
Message-ID: <ZPYbYqnStaChh8BY@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-4-larysa.zaremba@intel.com>
 <ZPXxkOCK5e4M/P5H@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPXxkOCK5e4M/P5H@boxer>
X-ClientProxiedBy: DB8PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::41) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH8PR11MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: f913dc82-0904-42cb-48ce-08dbad721177
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWLblIeNt1EFnqdy/hI2jLpZTK6qPhyR7Mliyq5y/Pa3ksueXzPQgfDwpTPIFupzZaKyi4ms3reAm6SKMvcl0c00B+Yg+Lww/Hw8gpbcuM5YcEH1EbNBBQYNv/EQ20/KXsRUKiJd7SMJe8PoE2x1Hk0uNqw3DP55Edlog+syTXaUo3MHvDmeuDdrdLmqn2hF65W7+NrN7pCcjLYsJv4UNtS1PyXhzAnc2PptC2P7Bqrr7VLg34HzushONXXNwIBwdAPQBlVIeVHz+6zQhOGFbBcmN2Aa29aOKa3V0tpQ62uAPElK8ifO1A+Ql0lGOf8akCRwALg+v/pPfz28yzQj3l3gw/brrAAQbjlaAGH23exxJ1W10SwMhEeXkmQW3u1cwC1z3Trbtraf4PvC2+JQbMVrMg3H2ZH/eLNlunqJ/PtPGVo/p6dtXhsn2K3NOnxO9YOj2HgS+xNNKReIBfkeFyxSKHUxgZEovKvuZfiYOttQCuhKtcet0zVKEAN20FDJR/AGspptOgyFSLF9okqScWwG1FlEt5OMtdPJ5xubHOst9l+rjM+0RytexXWVlJSI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(7416002)(6666004)(6486002)(33716001)(6506007)(478600001)(82960400001)(38100700002)(83380400001)(26005)(9686003)(6512007)(54906003)(316002)(2906002)(66556008)(66476007)(6636002)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008)(6862004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/oyxtUOUZQsBIZYTJP61EKU0zK3bI951otDwdk2KCJcavTLRqTQZvZzSYYXq?=
 =?us-ascii?Q?wsNWrC+DB6X/iMulMMCJ4NCKuO2C1nsANnHVinQ1/SbBCqJsWGkMcYdzXXm8?=
 =?us-ascii?Q?pSjYDBDOTSiENjZGiYFKlOWIEJW2keZM5zdPFgunJymt9qobUz8P8p0707VV?=
 =?us-ascii?Q?Rfxzwj8dw33YXnapu5pYOvclhFhLNKAVuCimuQ81D30Ha3VUVpUvt327QnKn?=
 =?us-ascii?Q?C3Hi6Lbf+GH8z/qMYj69imev95tKkGtvLK+Ff4QrMJVq8sQ0f0IIveOyBqmm?=
 =?us-ascii?Q?PbDSZkkcevz7EBTgUsjcY9aA+VF3lP1ITaqSFxZwqNOBmeYvbXDH2VssqeiN?=
 =?us-ascii?Q?yy30ClLw5zFevfHw6BxXV3uCxEvZWOhfYT+kqdfo0FVpqDjwHh2zWCMbStRH?=
 =?us-ascii?Q?Th9OcOc/IipomEH6H7296O81/RoMXk1u88aHNHp2vL5QGWTGZX+8Cx7oIq7Z?=
 =?us-ascii?Q?pFgs70RpZIcUFliI1LmptPc/9q3P1WxbNGztEpVtXfaWAeu5VbyCQSp28mAq?=
 =?us-ascii?Q?PU5NxbaNwqxVJFCNV+WB2bkBuCjcMFZhPf7h2Rj05W2MGHy3wRXwKkHtvHyL?=
 =?us-ascii?Q?Hb5yGw0xVNo20w+ug1TZlep6kn/JC3jh6OHip0jNIbV9eLU4qcAUOkg1Ohva?=
 =?us-ascii?Q?dhQb9Sx8YwUn/NT/mV0vgg3fBtkn2tPVxBkDpwhvxZd9vcb1QMbbqsVR3UXm?=
 =?us-ascii?Q?q/X9URfbIugBFJi3Qt+kfiKrFQHzEFXEAx84lgGonhI4bkyz2WztRHsagmWn?=
 =?us-ascii?Q?kOY9lyLdJTdgBhUJu2DCxRrPfd7JbyQw0+CjnTUU8oOuNOAN/ka1ob6NsHKS?=
 =?us-ascii?Q?84CoahE7w8LpMm8ZqLeBwvf+61iGvmfNyU4ctdjOvhDUIzaFukhxVPPo0EQw?=
 =?us-ascii?Q?emA0fE/fFFZ64BCrsBCMh+m6Oqp5VQ+iBT78UxCJRfcxJoLmMvCBxNW6CoSN?=
 =?us-ascii?Q?1Rmsl5sCfP4YrYADhcDnTHtSUynyAM29LjrC4gu7gJM/fbNcHp3+v/uD0Mnu?=
 =?us-ascii?Q?qZsH+IwIGD2MOJto61VbTSvl/68e65oKCsA3DZzENeLWX3/ViodkVkMkaKJ6?=
 =?us-ascii?Q?Vf2aSKhwkseJOzZUM7vUR8vUk3vH06O3tHjnjtGfrY0gQqcJRHwaaj272pw3?=
 =?us-ascii?Q?fTSWZy9aHprVT2C6vKER5o5yypkhVyZVBam8pG3c3XEzd2rKeSZ/P1REdrk7?=
 =?us-ascii?Q?8MK4snudBSPtPT0HB6elD2bByzusDIzaaWFEBt4zOnEIWQLZ9bzKTVuCSeFW?=
 =?us-ascii?Q?2lc75uWfr4XrzVlIgcZRPlYkFeUSrxGsGBKfXGATsVE7F/uclkClZHo5qDRU?=
 =?us-ascii?Q?ibk0MKwfPQw/mZHpzLRNwJl6FtAw3wgSBjshkl1BJBRDntgtynQ6PqIVmwZw?=
 =?us-ascii?Q?6qNKdMWsdRrqDzvC1oHWqQan7PkYb9OUudgkrhJfMXnTl/x9GRT0iTCO8yWs?=
 =?us-ascii?Q?wDEKpBeiOgjIm2ge4RgHFIJPzb/wM6mEZjzUis1MDuoOZA1+r3Yw2hDkpRkr?=
 =?us-ascii?Q?PAILTwg7JC4g8UEL6xECNm7Vw0BGHI/Y4kxT9cXMHrmfffYqWpB24FHVg8sN?=
 =?us-ascii?Q?087s2V7Gye/ER74Baj/hTmtO6umTl4OKXbqKioBd6dkluZyrrRNHMfjzE3V+?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f913dc82-0904-42cb-48ce-08dbad721177
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 18:09:24.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1oP/1svs5OmbY/ob0us5ki8+Ic0uj+jteUfvwgUywUimuBLrbO8MynXi6cMm0ckH2LOk6ZjKDk4W99cRjBIT0lIxSypoXF8TvxKq2J+opw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6926
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 05:02:40PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 24, 2023 at 09:26:42PM +0200, Larysa Zaremba wrote:
> > Previously, we only needed RX checksum flags in skb path,
> > hence all related code was written with skb in mind.
> > But with the addition of XDP hints via kfuncs to the ice driver,
> > the same logic will be needed in .xmo_() callbacks.
> > 
> > Put generic process of determining checksum status into
> > a separate function.
> > 
> > Now we cannot operate directly on skb, when deducing
> > checksum status, therefore introduce an intermediate enum for checksum
> > status. Fortunately, in ice, we have only 4 possibilities: checksum
> > validated at level 0, validated at level 1, no checksum, checksum error.
> > Use 3 bits for more convenient conversion.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 105 ++++++++++++------
> >  1 file changed, 69 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index b2f241b73934..8b155a502b3b 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -102,18 +102,41 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
> >  		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
> >  }
> >  
> > +enum ice_rx_csum_status {
> > +	ICE_RX_CSUM_LVL_0	= 0,
> > +	ICE_RX_CSUM_LVL_1	= BIT(0),
> > +	ICE_RX_CSUM_NONE	= BIT(1),
> > +	ICE_RX_CSUM_ERROR	= BIT(2),
> > +	ICE_RX_CSUM_FAIL	= ICE_RX_CSUM_NONE | ICE_RX_CSUM_ERROR,
> > +};
> > +
> >  /**
> > - * ice_rx_csum - Indicate in skb if checksum is good
> > - * @ring: the ring we care about
> > - * @skb: skb currently being received and modified
> > + * ice_rx_csum_lvl - Get checksum level from status
> > + * @status: driver-specific checksum status
> > + */
> > +static u8 ice_rx_csum_lvl(enum ice_rx_csum_status status)
> > +{
> > +	return status & ICE_RX_CSUM_LVL_1;
> > +}
> > +
> > +/**
> > + * ice_rx_csum_ip_summed - Checksum status from driver-specific to generic
> > + * @status: driver-specific checksum status
> > + */
> > +static u8 ice_rx_csum_ip_summed(enum ice_rx_csum_status status)
> > +{
> > +	return status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> 
> 	return !(status & ICE_RX_CSUM_NONE);
> 
> ?

status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;

is immediately understandable and results in 3 asm operations (I have checked):

result = status >> 1;
result ^= 1;
result &= 1;

I do not think "!(status & ICE_RX_CSUM_NONE);" could produce less.

> 
> > +}
> > +
> > +/**
> > + * ice_get_rx_csum_status - Deduce checksum status from descriptor
> >   * @rx_desc: the receive descriptor
> >   * @ptype: the packet type decoded by hardware
> >   *
> > - * skb->protocol must be set before this function is called
> > + * Returns driver-specific checksum status
> >   */
> > -static void
> > -ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
> > -	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
> > +static enum ice_rx_csum_status
> > +ice_get_rx_csum_status(const union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
> >  {
> >  	struct ice_rx_ptype_decoded decoded;
> >  	u16 rx_status0, rx_status1;
> > @@ -124,20 +147,12 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
> >  
> >  	decoded = ice_decode_rx_desc_ptype(ptype);
> >  
> > -	/* Start with CHECKSUM_NONE and by default csum_level = 0 */
> > -	skb->ip_summed = CHECKSUM_NONE;
> > -	skb_checksum_none_assert(skb);
> > -
> > -	/* check if Rx checksum is enabled */
> > -	if (!(ring->netdev->features & NETIF_F_RXCSUM))
> > -		return;
> > -
> >  	/* check if HW has decoded the packet and checksum */
> >  	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
> > -		return;
> > +		return ICE_RX_CSUM_NONE;
> >  
> >  	if (!(decoded.known && decoded.outer_ip))
> > -		return;
> > +		return ICE_RX_CSUM_NONE;
> >  
> >  	ipv4 = (decoded.outer_ip == ICE_RX_PTYPE_OUTER_IP) &&
> >  	       (decoded.outer_ip_ver == ICE_RX_PTYPE_OUTER_IPV4);
> > @@ -146,43 +161,61 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
> >  
> >  	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S) |
> >  				   BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S))))
> > -		goto checksum_fail;
> > +		return ICE_RX_CSUM_FAIL;
> >  
> >  	if (ipv6 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_IPV6EXADD_S))))
> > -		goto checksum_fail;
> > +		return ICE_RX_CSUM_FAIL;
> >  
> >  	/* check for L4 errors and handle packets that were not able to be
> >  	 * checksummed due to arrival speed
> >  	 */
> >  	if (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_L4E_S))
> > -		goto checksum_fail;
> > +		return ICE_RX_CSUM_FAIL;
> >  
> >  	/* check for outer UDP checksum error in tunneled packets */
> >  	if ((rx_status1 & BIT(ICE_RX_FLEX_DESC_STATUS1_NAT_S)) &&
> >  	    (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EUDPE_S)))
> > -		goto checksum_fail;
> > -
> > -	/* If there is an outer header present that might contain a checksum
> > -	 * we need to bump the checksum level by 1 to reflect the fact that
> > -	 * we are indicating we validated the inner checksum.
> > -	 */
> > -	if (decoded.tunnel_type >= ICE_RX_PTYPE_TUNNEL_IP_GRENAT)
> > -		skb->csum_level = 1;
> > +		return ICE_RX_CSUM_FAIL;
> >  
> >  	/* Only report checksum unnecessary for TCP, UDP, or SCTP */
> >  	switch (decoded.inner_prot) {
> >  	case ICE_RX_PTYPE_INNER_PROT_TCP:
> >  	case ICE_RX_PTYPE_INNER_PROT_UDP:
> >  	case ICE_RX_PTYPE_INNER_PROT_SCTP:
> > -		skb->ip_summed = CHECKSUM_UNNECESSARY;
> > -		break;
> > -	default:
> > -		break;
> > +		/* If there is an outer header present that might contain
> > +		 * a checksum we need to bump the checksum level by 1 to reflect
> > +		 * the fact that we have validated the inner checksum.
> > +		 */
> > +		return decoded.tunnel_type >= ICE_RX_PTYPE_TUNNEL_IP_GRENAT ?
> > +		       ICE_RX_CSUM_LVL_1 : ICE_RX_CSUM_LVL_0;
> >  	}
> > -	return;
> >  
> > -checksum_fail:
> > -	ring->vsi->back->hw_csum_rx_error++;
> > +	return ICE_RX_CSUM_NONE;
> > +}
> > +
> > +/**
> > + * ice_rx_csum_into_skb - Indicate in skb if checksum is good
> > + * @ring: the ring we care about
> > + * @skb: skb currently being received and modified
> > + * @rx_desc: the receive descriptor
> > + * @ptype: the packet type decoded by hardware
> > + */
> > +static void
> > +ice_rx_csum_into_skb(struct ice_rx_ring *ring, struct sk_buff *skb,
> > +		     const union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
> > +{
> > +	enum ice_rx_csum_status csum_status;
> > +
> > +	/* check if Rx checksum is enabled */
> > +	if (!(ring->netdev->features & NETIF_F_RXCSUM))
> > +		return;
> > +
> > +	csum_status = ice_get_rx_csum_status(rx_desc, ptype);
> > +	if (csum_status & ICE_RX_CSUM_ERROR)
> > +		ring->vsi->back->hw_csum_rx_error++;
> > +
> > +	skb->ip_summed = ice_rx_csum_ip_summed(csum_status);
> > +	skb->csum_level = ice_rx_csum_lvl(csum_status);
> >  }
> >  
> >  /**
> > @@ -229,7 +262,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> >  	/* modifies the skb - consumes the enet header */
> >  	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
> >  
> > -	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
> > +	ice_rx_csum_into_skb(rx_ring, skb, rx_desc, ptype);
> >  
> >  	if (rx_ring->ptp_rx)
> >  		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
> > -- 
> > 2.41.0
> > 


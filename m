Return-Path: <bpf+bounces-9267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C65792B65
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478111C2093F
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B592DDAD;
	Tue,  5 Sep 2023 17:05:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800F378;
	Tue,  5 Sep 2023 17:05:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33F373019;
	Tue,  5 Sep 2023 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693933520; x=1725469520;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i+D5tDpRGqsNmGY2e6S+XlTOSbFE61zmfw+38ORD8YY=;
  b=MmXAqpbz39TPF1i+S3GllFVazXaDdUHro/UMBX8hHC10mEM7QLYUcrBl
   7/ZMW/CwCRRnwh7d4OddA/WH3DANvvfxJINsNR666UMQTVziK9vtsRfWZ
   TFhIDzeaWtrAXQOYfjs/E1iDrzXqJ4HOpJRBYXtWTYIZK/i8cxrs0rU1V
   KTUOmlSOeM3ac3LNnwoSUI5p2EJl3CW6pPt4agz4wLxDDLRB7j8avRAkO
   vBdWOo9Y2s+bhBLqgwtu96/hmQRiKmyD4ebBRPcQaCZ3VoDbyn9VeXqgW
   cPpHpqQawQP73ZaHMNPR+8iGoOE3JQYtaiq4GF4rQFX29bmby6usRFCVB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407841929"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="407841929"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="744330360"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="744330360"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 10:03:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 10:03:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 10:03:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 10:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVnRffXbyk5vfZuObxllIa8rtJdYZFQYzGmpWQ2zPCDGGBJn/npfs2aDHHrZD762H7bABoAZQFh3EjWCiP7/KyVJEXZdVtXBMFwfLuZk1n1h0I61WYen9LGrpMOEDFtltjMHIdtIi3WbYlnWB/fXg3wA6rmL4RoRBzaT39MMizA3bVyeSMEVRCMOepSwBYgIm9NK/10MGnYSQUFMoUx7wInfjs+nb68MUsFH0VnaHNgQzQmzgeEoyXbFizqFwnhCAxPhbKUWQONPnb5OaoYee+rcdVO0Tu94RoT7z9vvyBTRD+2ci23L9HfgW2pcG1zaxOvzFAnF2boG1tCQfLIaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbk4ea+l7RiQ1n/sV75si40nYbfoiOFgokNWzQKJEQE=;
 b=ISbt8wFO08bgCo6E+xakyDTUR1UqY71PV+ktMlvG4Nt01nSWi+OvPIUHO/vHlALkgufLyZfmkb3Wp1DN8sckcEJL5g/eXXNFLWoy6mRX6GXwU1v5zDhF9Meq76MqfLnspG5yzHDxpgfYrJRTBGIQX62JCVagdL8+1HDzBnUKAt15IzCoOLZnBo3Q/yQqLhLQll7ZnyF9UVq2UKhjvgc9GKy2xmiFr9gxn6j5H0wktuj2865UQkOZCXrhG1lw8h2kDqg3wOxMoyJj48egyWVgJKhpJkU37doZ3ARZuFehz3XhoQ6830YddJous74FS4rehUKQ3SeShig2cP5WrVZpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB8083.namprd11.prod.outlook.com (2603:10b6:8:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 17:02:04 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 17:02:04 +0000
Date: Tue, 5 Sep 2023 18:53:37 +0200
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
Message-ID: <ZPddEcHOeRrtRcmj@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-4-larysa.zaremba@intel.com>
 <ZPXxkOCK5e4M/P5H@boxer>
 <ZPYbYqnStaChh8BY@lincoln>
 <ZPdLN56BWQVQGKkA@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPdLN56BWQVQGKkA@boxer>
X-ClientProxiedBy: DUZP191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 701d7f1c-bc1b-4785-6305-08dbae31d3e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEYa4PYOo832QdCxRI9D8QBCt+SDU62fELXW0o+2ul30R1ycDvx5S9eAxD7mJHkvmfb2IT1sKiDtgTeXElyKW+ykxPNFVHRK+V5/0zGHwe4Itn2A0oia5ZLYyIwW7RmD7+v3DH2RCNnFlIrqkTn80rP+yek6EQxmlEZQEReLaUCfCC4nDXjvk3DC2EbE8KbcE8V5Qa3jbgwAIbH0n2ThqSAeJTJRF1qccHLRKPvbmP4HBanXjZgcEva6QglOMfFHLknqawAHxAg5uFY/KkWrCMZXXyYN/jORmqRve8zsuIIJhz/GYSZLZKXiAhYq2GcTRObEvbNfSF8J7Fi7hPxpsR4C+vmi7b1aMp1sFmT75PSU+K9zo8nXciO7Qk8w+xPEYk7XTxfT5eijO19YxIuaOvbatgSFo3/AnCjNI5PYBnLBrFz3vg3HGqU/CVXf6xsQGi+qffxCsz8prjQbFxqhb68X5UE8VBS3tFAlF4l0OCmrrVgTcZIGHQhWJLQU9NOQFwrU+2/Z1fd1dFyEF2e0PZYY15OJOyr3MlRSXpNQfiNvcFJPHczlns8+P2Aaajxf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199024)(1800799009)(186009)(82960400001)(54906003)(66556008)(66476007)(66946007)(6636002)(478600001)(38100700002)(316002)(2906002)(7416002)(6862004)(8936002)(8676002)(6506007)(44832011)(5660300002)(4326008)(83380400001)(41300700001)(9686003)(6512007)(6486002)(6666004)(26005)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ciHXGsfEVQ+5A1mS3NGYauzRVqMlIUpziZHecXyd1gccFecRIPefSkAB9vLI?=
 =?us-ascii?Q?GrkZ0vLnLjlZ1KClj03RdDTbSB83aO+DMdz+5zizOEpBZxxSpqB7UqNL6Dpi?=
 =?us-ascii?Q?gzrKTV/pAVkEQh3oxl+WT9uzjlonKjbo0itssFQUo8P5LmXnkDWK//jqFjJa?=
 =?us-ascii?Q?jO9ew/wGjoQ82k9aEKfUg0ptVuXJ8gM3EaLU1po4HoVPf5s3KLAPkniRaN8G?=
 =?us-ascii?Q?wBBpG6DByVWteEeUcE6tm782yamJ9tftHugKLJ1nPJtEmJtadGY6cdEqrHN5?=
 =?us-ascii?Q?iOk3J/ZHkidVX5jxwscbwh5+CH6GwcYiSeYztjxqZxiY/oejvZDZI6cSEUHa?=
 =?us-ascii?Q?Xy97Ll2OsFvG1lO8ESkhlFoYsSfS1xnFhpJ30W6oFXPj3kBDrtRST7RRHQsx?=
 =?us-ascii?Q?0cIwc5St+iias/qJCFV7oZ0oBeg9g/Cbo/B2pVKCQjsyFtLobPCU2pWRcuZ/?=
 =?us-ascii?Q?bNZN05Q574VNyoSYLWL3ARHiV1uWEXYnPDMqToxA3hDkPNvmqQ0hZlhRM+QS?=
 =?us-ascii?Q?117I6I4ToWxY46S+9ofeCVPuoEsao/3y2Db7erG8n24uXj8zMS+e9slipwjC?=
 =?us-ascii?Q?nRkdBsuoGqAXomYwJX6N7sInlXSAsEUvxr7f4QYjZOAasldBcwKjsZTag9ad?=
 =?us-ascii?Q?PiVOqH113orp4oCiiBGWxCJHdXLNUsQtZF+gB/QsR8h6sEsr2avzDvfZFF+U?=
 =?us-ascii?Q?OVI834KXbEvNycVi+lSTJLzYw978qGAqkceQQ3N6TiWp8QV87elcd72RoF1D?=
 =?us-ascii?Q?vldRSz/ewYwKKRQAjaqmzZp/VV71kCGuUxZgpeAGnzEI7IPH1GdEosFSkQmv?=
 =?us-ascii?Q?Yixz/HR+GDEWQUQBXod1oyhqE/VjbbrgFbVaq3/pOGVR3dg1QJlN+y41ODuy?=
 =?us-ascii?Q?ywJVrgx5YxGmn1PrS0CGcp3QU2TcOEe/fQGVKbNPZpY8W/c1qs1q5dMzTw4s?=
 =?us-ascii?Q?yTs58lpmzIBrRxzRZatFP5fl2rGQT8UrNuD1uZjPiiwwacbpTQDaVYq8orfg?=
 =?us-ascii?Q?gS4eNfhImPAKhzUvfmwBNjHFPqSwxpw3vIbr6MQACh1+3o1PFke08YdrMUyU?=
 =?us-ascii?Q?J9TyEYnk3h2RctfNZv9DzujySneYo08/glbnCj92Z+bK1EQRmTpIGXT7jznF?=
 =?us-ascii?Q?vx8YeBBX/8NDvrdyZmcVKwBld08ggReQ3S5h0YRpBAYIcpyT03cOru3zuNHt?=
 =?us-ascii?Q?nvQSejGjq45LtB0gCNDUGU/UnNbPVRGkUk+5M2JkAnivZZlKpKMi6oyate0B?=
 =?us-ascii?Q?XIRJE7bKqgKlAxDbnH7rPNXwihNFw/Kc7e7AJaxvScVhZKJfUchFNieg7N2/?=
 =?us-ascii?Q?XyCSuyD+6Ow1bJV1Ug1p3zqdkHtL8Vl+lh0oNkBsxH5dguEjcCkQEWBlllZD?=
 =?us-ascii?Q?FpqAVkgNBUFDvePHYi7717vOR1H7dLoGqn5cv0WQ/6NZmUxHxliEHKUBb++p?=
 =?us-ascii?Q?sJwynXCuUhcwRMqj9CsygCvqCuvGc8TSY2QY7emIy3U8L6iL6ex3/RBom60a?=
 =?us-ascii?Q?UGTOF0w9BSzWDyZcCQLKBkUkuqGkEvX9KYJatAIaV9uTB55j/qp2tiVWVG1K?=
 =?us-ascii?Q?8n2jDdi9AMwmD4NtLmqHljTlQ3N0/+8248isEOQXieaT1vmRhnurIym3qyFW?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 701d7f1c-bc1b-4785-6305-08dbae31d3e3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 17:02:04.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iGTo5lZiFjcFX8n3lnqtceTkROv0kGRQuNxSTZEv0KsOivF/rMsbXDdt24o23vGM8oYDk9T1KKoq2Z4ct8ml5UmAH9SSkLQKE923ZdFyCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 05:37:27PM +0200, Maciej Fijalkowski wrote:
> On Mon, Sep 04, 2023 at 08:01:06PM +0200, Larysa Zaremba wrote:
> > On Mon, Sep 04, 2023 at 05:02:40PM +0200, Maciej Fijalkowski wrote:
> > > On Thu, Aug 24, 2023 at 09:26:42PM +0200, Larysa Zaremba wrote:
> > > > Previously, we only needed RX checksum flags in skb path,
> > > > hence all related code was written with skb in mind.
> > > > But with the addition of XDP hints via kfuncs to the ice driver,
> > > > the same logic will be needed in .xmo_() callbacks.
> > > > 
> > > > Put generic process of determining checksum status into
> > > > a separate function.
> > > > 
> > > > Now we cannot operate directly on skb, when deducing
> > > > checksum status, therefore introduce an intermediate enum for checksum
> > > > status. Fortunately, in ice, we have only 4 possibilities: checksum
> > > > validated at level 0, validated at level 1, no checksum, checksum error.
> > > > Use 3 bits for more convenient conversion.
> > > > 
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 105 ++++++++++++------
> > > >  1 file changed, 69 insertions(+), 36 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > index b2f241b73934..8b155a502b3b 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > @@ -102,18 +102,41 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
> > > >  		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
> > > >  }
> > > >  
> > > > +enum ice_rx_csum_status {
> > > > +	ICE_RX_CSUM_LVL_0	= 0,
> > > > +	ICE_RX_CSUM_LVL_1	= BIT(0),
> > > > +	ICE_RX_CSUM_NONE	= BIT(1),
> > > > +	ICE_RX_CSUM_ERROR	= BIT(2),
> > > > +	ICE_RX_CSUM_FAIL	= ICE_RX_CSUM_NONE | ICE_RX_CSUM_ERROR,
> > > > +};
> > > > +
> > > >  /**
> > > > - * ice_rx_csum - Indicate in skb if checksum is good
> > > > - * @ring: the ring we care about
> > > > - * @skb: skb currently being received and modified
> > > > + * ice_rx_csum_lvl - Get checksum level from status
> > > > + * @status: driver-specific checksum status
> 
> nit: describe retval?
>

I think that kernel-doc is already too much for a one-liner.
Also, checksum level is fully explained in sk_buff documentation.

> > > > + */
> > > > +static u8 ice_rx_csum_lvl(enum ice_rx_csum_status status)
> > > > +{
> > > > +	return status & ICE_RX_CSUM_LVL_1;
> > > > +}
> > > > +
> > > > +/**
> > > > + * ice_rx_csum_ip_summed - Checksum status from driver-specific to generic
> > > > + * @status: driver-specific checksum status
> 
> ditto

Same as above. Moreover, there are only 2 possible return values that anyone can 
easily look up. Describing them here would only balloon the file length.

> 
> > > > + */
> > > > +static u8 ice_rx_csum_ip_summed(enum ice_rx_csum_status status)
> > > > +{
> > > > +	return status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> > > 
> > > 	return !(status & ICE_RX_CSUM_NONE);
> > > 
> > > ?
> > 
> > status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> > 
> > is immediately understandable and results in 3 asm operations (I have checked):
> > 
> > result = status >> 1;
> > result ^= 1;
> > result &= 1;
> > 
> > I do not think "!(status & ICE_RX_CSUM_NONE);" could produce less.
> 
> oh, nice. Just the fact that branch being added caught my eye.
> 
> (...)


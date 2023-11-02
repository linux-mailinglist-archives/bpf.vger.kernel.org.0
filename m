Return-Path: <bpf+bounces-13949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1549A7DF448
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 14:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9891C20EF5
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872B19BBD;
	Thu,  2 Nov 2023 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5X9ptW6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143518E2D;
	Thu,  2 Nov 2023 13:49:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE5D7;
	Thu,  2 Nov 2023 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698932984; x=1730468984;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rv8oYErasb+iWCZxYNT3XOIWlTZWc/uSqGY0bOETr6o=;
  b=E5X9ptW68FOV9xJu2yEjGbQ7SKK4HoLwofpdWAqCIBPpqqbm7f/fWoKm
   cCcLCo3pK4KI3Iip7s3D0erYU8UbX3HyNP5njFZhcXRilCdTIKkgYjwEN
   0sxLx9sT5FQxK2rFzlmprDHhnPZ6v0MQtWBx46rp835SB7Krrk9CdW9Vw
   pfRKlsH3JtqEBnxl1tzWH6KroGvxrv/fP9/6t/XnOf0zDV2MR7vx/wBB3
   wJ3o3U+9nUJ1+aPHvyTWflXhpjDjTtjkLg+r4pVkxdzeYHGINyWk8sgtP
   czAJF+smMp+PdBWukiwljVdIJTRp+SDOTdWI+u6Oumc/ERFFkSkPNofft
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1639901"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1639901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="827143099"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="827143099"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 06:49:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 06:49:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 06:49:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 06:49:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 06:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRWNG2rmY8ex14IMEhOUG83ngQXf7GIqrb8BHDHqr9JvEOSwA/0JRmifRuSya9+5y3cmOzxCRzxwXd9ypiz1l66w9HoqjPtVqs0EbDQNk7p6SfRnbFN8fC3ooS3Q8M8UlUo9Z3PO+bhHpvcI4h+AUGBMQisNZScVCFUfRHnvAgHDimkpn9+Aqafy3Fy7AD8rBPuJw38aFgOJ/J1Eth7BkoEavzBUAnjG5dLUPIVtkQW8GtjNcicIBadSIocj1cf88GAzlCplTpn5ZOdc1pvB8tE6TurTo/dQVxMM2ZNxJdH7Bf6qEtRMUQerX+ErR6h+vMqgYPaCTzMmBraUS9hXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT1O3Qk4KF1s20Vb2gJmVjwQ6BnVSOLm6sauQO99ZUs=;
 b=TIe8c27a92PU74PMtM+BNUPIkqOGWgIA4dg4ADbwAUamtBNP80R6hbKTbsttnrirrFcgUVpgRFcggjAXo91Y4pvqHu2oUe2mVEKW9swvcMsNaTihn7lnRJ0y46LIBtz+xISYvn66Md3Nc18IlqiuaBseR/pgzJfWNuv/30zQZ7IerI28UbiUaj8YC+yd6zdvHg2nBtJH0yWnz2g66ARZYYqq4wTtEmycqPOggEOx22FjvoLZ+UJ2X+WCK+ugQMjDeqJFBiezIFJCq+RPc/qVV6ZaoFWrmrQO2LIBf8wWxmHZSDkjgy5bbg1AedbV2G/tyA9CemjXS99lsVNilDmvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 13:49:15 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%6]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 13:49:15 +0000
Date: Thu, 2 Nov 2023 14:48:47 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, "Saeed
 Mahameed" <saeedm@mellanox.com>, <toke@kernel.org>
Subject: Re: [PATCH bpf-next v6 11/18] ice: put XDP meta sources assignment
 under a static key condition
Message-ID: <ZUOov1RTpZL5+NOl@lzaremba-mobl.ger.corp.intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-12-larysa.zaremba@intel.com>
 <ZTKrjU0a0Q1vF1UU@boxer>
 <ZTY+chHJEgggHu5J@lzaremba-mobl.ger.corp.intel.com>
 <ZT1nSGYng8sUKQD7@boxer>
 <ZUENpw5GVqcL0GJc@lzaremba-mobl.ger.corp.intel.com>
 <ZUOitlGHC0Kgrh5i@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZUOitlGHC0Kgrh5i@boxer>
X-ClientProxiedBy: VI1PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:802:2::30) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5c24f7-89c8-4991-ced3-08dbdbaa7543
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlAGvvKta+7gwBaShb2ENvY07w9DqpagQqCylXBvOYTMw/Jj2lmzVbAmiMsSKu+ZNT5vJ+WDTFMNkZ17DI9L6+mmxuHmTS7ZOKJfPj6LldGQTl4jRiV7pXgwyLf6hu124ngGT9BukKNbiF2BhUsT32fcaLqja6vaXfQApS39eZrXinZJHtlkxDvFKbv3S43YLo2xUm8gMy/wKXGOlbP4O2wcAhLtrZb7cNUPTEkCC6azRispAhD4y5FHfNWZYtZx03EDxC4ZGs7FaEd2XR08rVHF0qn7FCJ4HWr7JB4hSSDe8itDjpmCdCUQCE1dPNguVNNQOTJEDd+3RoIJvuASxxzkXNMXKwmWkm8J3pOpSu44eOPukgye25R5qSruH0QawYNjbhgCG29xD91bzOipBmDV8nXQA6C2PLybwWpZ3e6cJF/g+/C6XSDtw45jCXC4Hu2Z2gXbDH3M4xS+pfdPJ0mzjARtdIoUM+b/auzszZtQXUfHtOw1CzOdgu3dguYJs9N2WpP/59sgIb7RsTYE2ej+qaYo2rsyO5w4AN0qTgenYYVnic/NgJfyldFwqNeZticrTcoI1Az3u5io/jMybGKPpbZ1fbCtLlGE0xKByy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66899024)(26005)(38100700002)(316002)(6636002)(54906003)(66476007)(66556008)(7416002)(66946007)(5660300002)(8936002)(4326008)(6862004)(8676002)(44832011)(6666004)(6512007)(2906002)(6486002)(478600001)(41300700001)(6506007)(86362001)(82960400001)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wEwD/NiKIp9PTGn3hPYlyyDw0oCx3LqFj5qhrqne7H9wdZEEsNk3DFFm16jW?=
 =?us-ascii?Q?vxWnNBr2vPUJIwnoCDl5okCkUbMlJgrxr6qbJ1b72n+Q8KAkGNzLgTbz5R4d?=
 =?us-ascii?Q?3uy6nxqD9sn02m30mo4LAqa4VnLseWBcH2hv1EsPx52PYU45hkjZYFsR1TwR?=
 =?us-ascii?Q?LKKWuCCOQjmJ/KevYzRAgnROMW69K/UHFaahQWr47aZ8yw/hyJlkkWqP+sYl?=
 =?us-ascii?Q?k5edYlI3jnBeBAx+e0T+KZ4Fp1o6K0ElYBABZqbhw9A9bHKDhzwfXFbg+TsP?=
 =?us-ascii?Q?MKvSTOgnKrTIeMVmQfSFmlE05rucrQFpxVax//2wCIk+lvycnIPIDMTspFW7?=
 =?us-ascii?Q?XKLa+A3I7eVR66oIc91jd1K21K3vb5T02y7mMHt0+v+Rxo2Cxtf0chK7KEDj?=
 =?us-ascii?Q?CTpN8BHJD1AEhG/6J9WswIihak7SnZBN2uk9kGtOEmWC0qT5y4PVAIgnJQhR?=
 =?us-ascii?Q?2nF0idMm2Ea6ABsuTyvhqEU2bn4NOwm/Ex3AWZ6tcJDAJ27wiCIcyfhZWzt8?=
 =?us-ascii?Q?Gi7qkcDlqmvJD0zcl9JM+YH78qT1JdqF/GZO+mBj3mORCH0ctzlNSTEHz1PK?=
 =?us-ascii?Q?4Hfe9t02jkjtvfpU6hPoYTSfbSwJNYYZx2NW4bjq/zJYXJaCgFb2CKHgwHUZ?=
 =?us-ascii?Q?oqST3b7yLpqAmp9xO+Vqj2yw25e9jGtnNg/ILh7c/+ExjZ4iHlTGdIz6Fqpc?=
 =?us-ascii?Q?/7Zdj72cn+ms3dcbDH+43oROgEf39MaYSnYsUvY5YKE7a3uOK1sfJD+NSjeA?=
 =?us-ascii?Q?0hPNhanI7zmbRQDUVzvejZzFBOI5o+vmBbkzaprQKwRXIABHRzEH2QboNrsQ?=
 =?us-ascii?Q?KhfFLa90uygqldXzHq/nxors91af6ZZvOVlDgUUs7heqlByOL0MoSXXZU7Ls?=
 =?us-ascii?Q?IQHLEaWRoPyJ8+gk7V2khFG33Jr7NG0aSmy/e1B3qORGtXEeAOp9udl3DI3n?=
 =?us-ascii?Q?iJNpY2BLMRWAMGU+ysqCuxKpuYPse6LlbQQU2AwrAo9C8TdKcnrJ8kdpvUpu?=
 =?us-ascii?Q?N7bdHaDUbPUoKR8yQlxzwRf0pA3tvhnh0rxl9l2LrQjvkiXGX6TVquPD+ByW?=
 =?us-ascii?Q?yXKSRyCt2B6Seeeyp9+LdoqKHqwJ967xDZ6xq9fjDN3cPizyNa57GMlLILIk?=
 =?us-ascii?Q?jNwbpvywVI3R+/WxF4W7NVYD+YM2e3I8wekmwQm0cQ0UN9wEueHUwLlHWYNa?=
 =?us-ascii?Q?/I+LZpNebpKkmH/f8ZMz71v5bT5m6c6oqttaQY49CH4494hLSyz8Pv5CQzTx?=
 =?us-ascii?Q?TAfiofZo10P6h+BxfjV+Rf2xbJz83NAyWhD8gNPa+XjDcIJA8TtEK2uWwTEx?=
 =?us-ascii?Q?vG3NaU6DeQS/UJWe/Px61Wejv3tkkI83D0df4OXwHXaf9v/4IB/KO7qKTMp3?=
 =?us-ascii?Q?rcosSw36R0fAnIOe+Zcq4u1FiTU8i/A2BPSE2WCEUvXZU9W+DLMj2hkIOAa1?=
 =?us-ascii?Q?OuZe1m5ZR0DDeLgMr2/N3L3hrEwnXLibo+SakWIJPijIKXdoxP/V14Se1j2z?=
 =?us-ascii?Q?96ifCG015DKhcCvu7uGCFoqnIAC777lX808E550Dcgb4wFQvih+Hk+4c3T2N?=
 =?us-ascii?Q?r4qN6Sjc8FMh2BxagJdYP5R3WQgWA7ESFVLhwkL0NnUJdipGYTzr5vTxhyfZ?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5c24f7-89c8-4991-ced3-08dbdbaa7543
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 13:48:56.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7jNQv0kj4BfbJQkbzfE3CaWgG5Xt4hnPqfRI722O4Ba3xKDjB5NSYYiOF1pqht+HBRThSVrLI+PFvQMKJik+wpN4+v1xaXkLnioTcFBwjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5469
X-OriginatorOrg: intel.com

On Thu, Nov 02, 2023 at 02:23:02PM +0100, Maciej Fijalkowski wrote:
> On Tue, Oct 31, 2023 at 03:22:31PM +0100, Larysa Zaremba wrote:
> > On Sat, Oct 28, 2023 at 09:55:52PM +0200, Maciej Fijalkowski wrote:
> > > On Mon, Oct 23, 2023 at 11:35:46AM +0200, Larysa Zaremba wrote:
> > > > On Fri, Oct 20, 2023 at 06:32:13PM +0200, Maciej Fijalkowski wrote:
> > > > > On Thu, Oct 12, 2023 at 07:05:17PM +0200, Larysa Zaremba wrote:
> > > > > > Usage of XDP hints requires putting additional information after the
> > > > > > xdp_buff. In basic case, only the descriptor has to be copied on a
> > > > > > per-packet basis, because xdp_buff permanently resides before per-ring
> > > > > > metadata (cached time and VLAN protocol ID).
> > > > > > 
> > > > > > However, in ZC mode, xdp_buffs come from a pool, so memory after such
> > > > > > buffer does not contain any reliable information, so everything has to be
> > > > > > copied, damaging the performance.
> > > > > > 
> > > > > > Introduce a static key to enable meta sources assignment only when attached
> > > > > > XDP program is device-bound.
> > > > > > 
> > > > > > This patch eliminates a 6% performance drop in ZC mode, which was a result
> > > > > > of addition of XDP hints to the driver.
> > > > > > 
> > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/intel/ice/ice.h      |  1 +
> > > > > >  drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
> > > > > >  drivers/net/ethernet/intel/ice/ice_txrx.c |  3 ++-
> > > > > >  drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 +++
> > > > > >  4 files changed, 20 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > > > > > index 3d0f15f8b2b8..76d22be878a4 100644
> > > > > > --- a/drivers/net/ethernet/intel/ice/ice.h
> > > > > > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > > > > > @@ -210,6 +210,7 @@ enum ice_feature {
> > > > > >  };
> > > > > >  
> > > > > >  DECLARE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> > > > > > +DECLARE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> > > > > >  
> > > > > >  struct ice_channel {
> > > > > >  	struct list_head list;
> > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > > index 47e8920e1727..ee0df86d34b7 100644
> > > > > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > > @@ -48,6 +48,9 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
> > > > > >  DEFINE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> > > > > >  EXPORT_SYMBOL(ice_xdp_locking_key);
> > > > > >  
> > > > > > +DEFINE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> > > > > > +EXPORT_SYMBOL(ice_xdp_meta_key);
> > > > > > +
> > > > > >  /**
> > > > > >   * ice_hw_to_dev - Get device pointer from the hardware structure
> > > > > >   * @hw: pointer to the device HW structure
> > > > > > @@ -2634,6 +2637,11 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
> > > > > >  	return -ENOMEM;
> > > > > >  }
> > > > > >  
> > > > > > +static bool ice_xdp_prog_has_meta(struct bpf_prog *prog)
> > > > > > +{
> > > > > > +	return prog && prog->aux->dev_bound;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * ice_vsi_assign_bpf_prog - set or clear bpf prog pointer on VSI
> > > > > >   * @vsi: VSI to set the bpf prog on
> > > > > > @@ -2644,10 +2652,16 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
> > > > > >  	struct bpf_prog *old_prog;
> > > > > >  	int i;
> > > > > >  
> > > > > > +	if (ice_xdp_prog_has_meta(prog))
> > > > > > +		static_branch_inc(&ice_xdp_meta_key);
> > > > > 
> > > > > i thought boolean key would be enough but inc/dec should serve properly
> > > > > for example prog hotswap cases.
> > > > >
> > > > 
> > > > My thought process on using counting instead of boolean was: there can be 
> > > > several PFs that use the same driver, so therefore we need to keep track of how 
> > > > many od them use hints. 
> > > 
> > > Very good point. This implies that if PF0 has hints-enabled prog loaded,
> > > PF1 with non-hints prog will "suffer" from it.
> > > 
> > > Sorry for such a long delays in responses but I was having a hard time
> > > making up my mind about it. In the end I have come up to some conclusions.
> > > I know the timing for sending this response is not ideal, but I need to
> > > get this off my chest and bring discussion back to life:)
> > > 
> > > IMHO having static keys to eliminate ZC overhead does not scale. I assume
> > > every other driver would have to follow that.
> > > 
> > > XSK pool allows us to avoid initializing various things per each packet.
> > > Instead, taking xdp_rxq_info as an example, each xdp_buff from pool has
> > > xdp_rxq_info assigned at init time. With this in mind, we should have some
> > > mechanism to set hints-specific things in xdp_buff_xsk::cb, at init time
> > > as well. Such mechanism should not require us to expose driver's private
> > > xdp_buff hints containers (such as ice_pkt_ctx) to XSK pool.
> > > 
> > > Right now you moved phctime down to ice_pkt_ctx and to me that's the main
> > > reason we have to copy ice_pkt_ctx to each xdp_buff on ZC. What if we keep
> > > the cached_phctime at original offset in ring but ice_pkt_ctx would get a
> > > pointer to that?
> > > 
> > > This would allow us to init the pointer in each xdp_buff from XSK pool at
> > > init time. I have come up with a way to program that via so called XSK
> > > meta descriptors. Each desc would have data to write onto cb, offset
> > > within cb and amount of bytes to write/copy.
> > > 
> > > I'll share the diff below but note that I didn't measure how much lower
> > > the performance is degraded. My icelake machine where I used to measure
> > > performance-sensitive code got broke. For now we can't escape initing
> > > eop_desc per each xdp_buff, but I moved it to alloc side, as we mangle
> > > descs there anyway.
> > > 
> > > I think mlx5 could benefit from that approach as well with initing the rq
> > > ptr at init time.
> > > 
> > > Diff does mostly these things:
> > > - move cached_phctime to old place in ice_rx_ring and add ptr to that in
> > >   ice_pkt_ctx
> > > - introduce xsk_pool_set_meta()
> > > - use it from ice side.
> > > 
> > 
> > Thank you for the code! I will probably send v7 with such changes. Are you OK, 
> > if patch with core changes would go with you as an author?
> 
> Yes or I can produce a patch and share, up to you.
>

I have already started, your diff does not compile, so I took some creative 
liberty. Will send you patches for verification this week.
 
> > 
> > But also, I see a minor problem with that switching VLAN protocol does not 
> > trigger buffer allocation, so we have to point to that too, this probably means 
> > moving cached time back and finding 16 extra bits in CL3. Single pointer to 
> > {cached time, vlan_proto} would be copied to be after xdp_buff.
> 
> It's not that it has to trigger buffer allocation, we could stop the
> interface if pool is present and update vlan proto on pool's xdp_buffs
> (from quick glance i don't see that we're stopping iface for setting vlan
> features) but that sounds like more of a hassle to do...
> 
> So yeah maybe let's just have a ptr in ice_pkt_ctx as well.
> 
> [...]


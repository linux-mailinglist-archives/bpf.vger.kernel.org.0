Return-Path: <bpf+bounces-9222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A57791CC2
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 20:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFF328109B
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7DC8FE;
	Mon,  4 Sep 2023 18:26:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E1C8EB;
	Mon,  4 Sep 2023 18:26:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F21AD;
	Mon,  4 Sep 2023 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693851996; x=1725387996;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q28Zob2YHwoYHcXzRni/0q+mlkhIeF0kmePiUW2UXW0=;
  b=Ne18DvPRi+eL9+JmW89ryo9dFOXAflx9V/QkyKIrjTFDsV8s5CGryase
   6LsVhZR3KcaPsUfWdgnS0AsCsCWK7WTQgdnZP7ZJafJWFEcbFay8sWtVo
   oqquWMedcFSCHf1ZIpef+vOrI6ZWi0gRB30oisP3gxpT7r3thPzUGSBhP
   v7IxDuF/LSP1zq+Fre2xJyIbCaEc/RFqcin9rVVAiwCn+25+VZkmwuGQy
   QbTBq6mllvdts+Xx/X5bUmkqmYEGJRdOjm8hfC/6FdiuWowVr7w3LPMXy
   3CAcxWDblrmPsZxrP2em6oxqUtcjH5ZG9WNQhmW7sk9u68HyXMR9OnwL0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440615772"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="440615772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 11:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="770074398"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="770074398"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 11:26:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 11:26:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 11:26:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 11:26:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 11:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gt4FUeU2Y3ZYp+Pxbg37CHubSPsvSIsQloAXEFJlwJ42HkW9+T/9pf5+nsKY3QKXI2sInpARy2PVsx0adnTCO986+02QbwGw63qavYiH/VuvjgSBt/SjSRDwBsISr71fgOr8qyCv5egwrEm2qxNl5PkH2TbGPiouCI0uolw7Xhpe3wx0eF/s1TQmh62sLXw9VrUc5uL7avd1niVgOYdifXYeiq7E0zrhvu/lG8dGZKW/tdJYDPIqJc27wq80cSstRAiC9jhjsmBoX8NgINiT3sAQvtHVLjHqpAbO0KqLdB0mLSd2dQhZE/7xlVsJozvMqo21tZn5OZhj0vmZJWu4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTkdy6BD79NG1khpFn0wYeri9Vy8S75wWaBHQmbT4DI=;
 b=QZadtaXAB9YdyiIUXMUOBJhpdAKGRfP0yroSYcj+RHo82C++OGvj0bOvp4agUwI1DKm2gaHrFoopRXanvctRWyfbrEM6E1s8dQwhnIK+X40desreCrTWH0YTWTvzFqQCo02ey1gGak5OnyaNZBcODRBMOw4Ltha70aYjNIpN+OMOYwHiSadiz5ZzPAqMrpCpv92mYVmZlRrjQv42/kTjg6XwdchBHXsa2aQIKtO8G048m2QAmiCfDHMtqRME1FXaJ04nLNcc3pwafXJjO5hLS9XZxv56P9ZH0lHx5zyKvgWNgjblsVUn/18enapXktqNsixIFSMlh3JtYnllD6NarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 18:26:16 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 18:26:16 +0000
Date: Mon, 4 Sep 2023 20:18:01 +0200
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
Subject: Re: [RFC bpf-next 10/23] ice: Implement VLAN tag hint
Message-ID: <ZPYfWe5umMSlxAZ5@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-11-larysa.zaremba@intel.com>
 <ZPX/IqfeLXcyQjZT@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPX/IqfeLXcyQjZT@boxer>
X-ClientProxiedBy: DU2PR04CA0330.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::35) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dff3d34-d12e-4b3c-beac-08dbad746cd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDVX/osAj9H3Il+W6M2EEaqbVz3KFC6H3CPwotcoAC9ZPoQKYsTvXOt/sUwMS1ptpJKlmBrrKIW14uR+iUP3v3yKEn/l6OBXsfSGIz0Ir4GBtzrM4S88BEy6abihsB8y+uuxWqZcTMX1j8BInZGkfn+qHkm2bt7vuLm58iBwaZ6zsOeOGGuOzbCs76k+8auMWMyl/MskupW6BcEQBqtYiJu/hQwXSnccdh+X1RnQyz986J7HjjPYxZFEj12fsm4nf9xn4Q59olIW8CCUwzNd4oj23RuBjx+T6ya5E8Qc8wmTMZ0kp/qR398DXAqcWuDSdHvf1hD7l2dsy4P322c44Nn0bQqjOH3KhTXII1y6H0406rIgAryKIfgKkli5QDsTO3wpZXHDNwAhk65uEgwueJ/tzYUj249wp4CvMut85o1lwhj2RdARK3BQxP130i1cF+twKQZhVoZuKND24S181Cr2bljQW+Oa9NO5vm1PwQUV4p54Kf9cZ2OudmGdANgGNI27MSCRK8/BGpULt+csr/3XZ5bzSJeCaK6qd2d1ILdlNcVXZ/48BoUCnPCQ8wVq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6506007)(26005)(6486002)(9686003)(6512007)(86362001)(38100700002)(82960400001)(33716001)(83380400001)(44832011)(7416002)(41300700001)(8936002)(66476007)(316002)(6636002)(66556008)(54906003)(4326008)(6862004)(5660300002)(66946007)(8676002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z5dwkEmO9XQftMArdcUdilLgytdCfyuM7CcqiCkacrqRwi02c0agoHI+QTL1?=
 =?us-ascii?Q?YEwM0+8quLpORlVnupzve4u1RAMo54kwB1dsHtCAsfK2jzTQwnC+9KA7GFjT?=
 =?us-ascii?Q?KbWirgWHgTyBM5BRUfflpWPrQnuyndl/bBAImsreAVC9ufANzeC5baupdWuD?=
 =?us-ascii?Q?zwl0fhUibDj34Ktod9GzcqfSR0ZSgITiX/O9JQvQZMCINUTWZuWr/QSN9/+O?=
 =?us-ascii?Q?1XsQ/Tf/SyeE5waUL9HbgVtOgMLMgmcmk7X0dVVNISbdpGR5/ub7uIptsYCC?=
 =?us-ascii?Q?sB6oEQWGW7tKLmbub/RD6jBh9gcACXldoPfK7Fd17JpPOHf4JBAPigpVTsYD?=
 =?us-ascii?Q?kZ/77JgTEG3j6y2V4fYUOBY3PzCa/Vy0sG9/VgB5VxJ2MPmbVPZvNLvq7zRX?=
 =?us-ascii?Q?mWpTsK747CPFd6Kvt3rZoCtzy6fn7vBqMYofmNORfMWrOJkY6vJrOMNAHlqq?=
 =?us-ascii?Q?i/9ZUx4FP4MdBfge/a6WhgFm3eTgLIr7WmjVdXSUGecbCCXzZ/EGMXow7zfg?=
 =?us-ascii?Q?zg909/CiAi9LiS1TgfAg27/RbUmupTTUNuXwWDEOz8T5D3YWj5sT9qfnJdib?=
 =?us-ascii?Q?Fzo3UKwnnMcSbiEtF8SvG3O7wvtk80Tw8QKb/J0ua04hyEn0vRSJzoyxX1JL?=
 =?us-ascii?Q?kQmdkPKCKXzYXT71e5Z930C9Tp+AJJXTyLySPqUpVh5XtMpaydSmkuc9FK3C?=
 =?us-ascii?Q?0J//S6YoN7MRt2QLjWZsJxIl9LYhk/Ru9Ww+SFpUOCd4Wf02VI5M/C6d+Uv8?=
 =?us-ascii?Q?VtdV1aKWKru8P5bXx6ylQZV6Ze+VXVOzgDU4ee/MjvgEv4Il3NSoHCch+2HM?=
 =?us-ascii?Q?yGI2xLNygK/0EfCwuHCneLPSi/rCmVgmr1ee/43IhqoggA03leLd1Yq1tP/4?=
 =?us-ascii?Q?Bppz8tHT9MEZVzaUyRq14eQ2ZMyem5bfmq+FTRVVGI0jcTItx+D0RrMWvewn?=
 =?us-ascii?Q?MARq+rS+mxGm266gFXDAI/EWgJHDgknRx8m2xTtF7Jz17vumc5OtVEKh1m6p?=
 =?us-ascii?Q?lgF4bW8rKRidjIwJ7tHGUid4w5M788SM9edLL94tanmjzqgDhUUKE6wMzyu1?=
 =?us-ascii?Q?Jpcr7SyDfG6bRRu//9JpWACpo4ZlW8tTmJyrfJiYlCkHArdRF0hqOcdnA0Op?=
 =?us-ascii?Q?WWnCePy3muKIc/tSW75JPHcqy3Td25LhXBgIPfFF/Z0ToA1LEuy7KqvR9PK+?=
 =?us-ascii?Q?lImVJgtEn/TBR4f6Un+84elD/JZq06SnYP2TyHxCtJsnE26zBEjnlBE3ljR8?=
 =?us-ascii?Q?gpMI5n4kLMoj4OPx2d2dlciYGCheuNO+OZaMp49VupblC6sMWua5Bcb2a7+w?=
 =?us-ascii?Q?8rPr8wN3L9xC95c96FOkwWAASZUJIuS/myLWkjE3E9HC4bIzEijkWH8vWxV2?=
 =?us-ascii?Q?eJFdFIXkKUJEpj9fQyppY1zZwmxU9DO2Y+dOFv3rM/+ZcnnLYBzKqiWwmbFH?=
 =?us-ascii?Q?EMQesmtPJab35DTJkEmNRPyYNRWwOYp/J9ZzMU2z0g3+yeAWp+gEzx5W8Y3B?=
 =?us-ascii?Q?d9F0EeRPFZ3Kyc/GcwViNqFLZJr+x3iV9Wgy2eQVCgInOM2ThAVdPW47uyOP?=
 =?us-ascii?Q?21p57esNU7b56nUhoTQnm3m29qmjkklnDCb8Oh0pbhvLJ1N4umkRTyhK7Bij?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dff3d34-d12e-4b3c-beac-08dbad746cd1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 18:26:15.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HFgzYledNnoT8c9Fa4kcXZWZGaQEeN5gkGyBWb//LPdeBwuGdkM58IHHCrS+KzKOWDCvuaseNg56mIQjwUeoEV7MdHUl65ThZEexp2hcv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 06:00:34PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 24, 2023 at 09:26:49PM +0200, Larysa Zaremba wrote:
> > Implement .xmo_rx_vlan_tag callback to allow XDP code to read
> > packet's VLAN tag.
> > 
> > At the same time, use vlan_tci instead of vlan_tag in touched code,
> > because vlan_tag is misleading.
> 
> misleading...because? ;)
>

VLAN tag ofter refers to VLAN proto and VLAN TCI combined, while in the 
corrected code we clearly store only VLAN TCI.

Will add the above to the commit message.

> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 ++---
> >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  4 +--
> >  drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 ++---
> >  6 files changed, 57 insertions(+), 8 deletions(-)
> > 


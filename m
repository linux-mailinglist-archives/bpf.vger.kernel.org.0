Return-Path: <bpf+bounces-10062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6A17A0B4C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF08A1C211A7
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A826291;
	Thu, 14 Sep 2023 17:09:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90812134C;
	Thu, 14 Sep 2023 17:09:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FA1FE1;
	Thu, 14 Sep 2023 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694711357; x=1726247357;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jCJN0REaZl66sDijyA9z8Wg8CwhiRyn9woFhGTNwGt4=;
  b=FEhnX7E0bMMrm1bZPGGghXKfU4gfw3O5Z9k7sDOJSm2dZBM1jktJUdgR
   wrxWlt7VSwJQ84ZtWbKr2qOVBJfeoVuu2Fa3QmhiwrtKvS+OrhoZ7ay83
   JVEfz4vEZfWXG/Z519Yvq68iqvpYx0NS2NHV1FmZfGLcc7i5h+H17ujvr
   J7YHgbtVZZhvpaoCYU69cnJqA4v9bJjV/KlbPJLNabOTyz+Q9x0/+OWli
   9F5FYzvoBRXeGaWZAtitXZC6TjPpuwdctOM2b/5dp86Zm3/A66DbKDQQQ
   0EF/e4gWq6iRedqm3EAgT0YOpVidHlCZUsCXC5rjMlZkJmNYp/bByDEVr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378937509"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="378937509"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="868321051"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="868321051"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 10:08:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:08:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:08:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 10:08:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 10:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfwMG6VnBKvfIcxhEjIvgCBTsHZ+WuDiJq+5SHFhZMW43A/ykfcX5XBLMeKffesZmutSvRU+p45KsujxM4CR6UxStszp4Hx26Wa5n/DItqYIDbcCPuITHlEKxi9CVElYn8QAdQgpe0fdVWgAVz0XCSf3bFeHpd/0ZVt8/ODAIeoryOAaYtSfZtzLZ2qUIPHDNbp081c0KOuNyg6RKgbqaWp+Je+56yWughYZRhZ+U7h/+ufbwChG/xJssk73nlL4biFHIgGlJ0zv+48MI8Xp3kp+Y7T4XcFEbjJOn9InskI5sjH2io+B91QQ+2GfgM45VyAXvExF5XMJsUManM8cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpFkZpM+7e817s2zfgMCTa/yhkR/Gjh9CwgpTXQa4jk=;
 b=dxcUyq+rbDY8ViaC+FB3LMZyu7GSjxa+eHRmec61kB99XkQKg0k9zBWnPx2hdkMl4xspeLO2SQ7LYKQ9XV2D1IZRx/7N+wOpvgFti2PSEZlBARIjWwj3xU1lV0W9C7xFGwkVLuRmyi3xvm1fp7dzBKK8Upn+uzxWNZGU939SLJzvqPG51cb2j9sBuhvM1NcM/FKUc9+Du3LOBRYohSn0ivVy8cmaYvWftrlgBtWBF+HAXEGqQyQTnpjhK9SMmnX0ln8hKlPo6wbeRpzVQrrvxhPsrEhNpOd8GPEJ9qZSfYGqsXymnKt/oD7WpSomf5o4+2Pjbf+m2P5qFts5kECC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 17:08:40 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:08:40 +0000
Date: Thu, 14 Sep 2023 19:02:56 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
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
Subject: Re: [xdp-hints] [RFC bpf-next 10/23] ice: Implement VLAN tag hint
Message-ID: <ZQM8wAlV50KxPjd3@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-11-larysa.zaremba@intel.com>
 <0abb29d7-fcad-c014-ea06-c7ec9460245e@intel.com>
 <ZQM0lzXSsseZTmOy@lincoln>
 <3f8f0fd8-b75c-5666-797b-315ebb632ca2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f8f0fd8-b75c-5666-797b-315ebb632ca2@intel.com>
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 396e2884-47a6-4611-916c-08dbb5453cad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCirvlR3yfH4JRzyFt0xsVfzz1t37EdtW6V7hfCjTcbTHWaFonUszU8ZIS0PQCDEtah8XXVQ/x59KtNo9R/5PROaD/ozPyDgBdv08T3P6cofvc8bxRDUnCvt2EJuiOeC4wLYDTYmot1VrUmsTi9PG15jH/9pGhFFQ4PQ0++sOzJqHCyr/omLAGX+Zr5YKLQ7SdMz7QR8Nji3Z8xPD4o3xXshqX6HQ0Uga3jMorLeCrIU7AIhJbcc4ImhNEv2bMttBSynsLu1z+0pmfvAEEBoik5ljph4cf89IviMbODykm0qlOnHTf50ySzQ4g+cS8rpXBB6Sar+VhvPzWgL71SkxcoualSldSzv9GIvCdqkXyCVuAYIBaigm+J7jbRufj4TNvcr+ZuPYBK7i1fJOF9UyYaC/fLodj92eFUEACNQCqFA5vj3UCSwMomBWJB+do3N5HAWUb5QrLzyanQx9aeoyACMtXcKKGlHNEfNbXYzHyJhelSU7wxJT8pMXI6d65tUKIr1eyOhOak7aPxlTyA3m3fhhl6zHIZrsN/OYAImfh59lxGt2JWGRR85shmdx0Ps
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(7416002)(6666004)(6486002)(6506007)(6512007)(9686003)(66556008)(2906002)(41300700001)(44832011)(54906003)(6636002)(33716001)(66946007)(5660300002)(4326008)(26005)(66476007)(6862004)(316002)(8936002)(8676002)(82960400001)(86362001)(38100700002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3vI2uxb1R9lq9lHBioNjcBRPoXlP2VkdvjpaZMmZTAZoKaA5O77kJHluneC?=
 =?us-ascii?Q?h0PaZgjmpYmBV7NyA+PyAyb/odnlkY613XKcVIytrExYIrcQHdTZ+mSiLgid?=
 =?us-ascii?Q?9o4eDvb2/gj7KJ07A5tla/9SDt8i/nxrkE3fMr4sb6sKKi8VXNYwk4KKE7kv?=
 =?us-ascii?Q?pwjZM6DOQWmlMRWMFH05pd4GH1TN0VqwiGLFw28/7aexZbPWiDsiii/gWAQS?=
 =?us-ascii?Q?ZYJYOVadOc7Ug0TVQQpVoYek3xn2eZDtDxLiAUb92Fv2TpqlnQ/tSc3XSP7f?=
 =?us-ascii?Q?djTaR2QWiYuoPY3UD6s4rewDiyPr6VBnnaS7JpOFe9rz/mEqQr62PiZ9+NNS?=
 =?us-ascii?Q?1p4VPcNeICBHCcfPK3DiCu5l6TF/iR0PXcN009jS/OuNPO1du3L0Qqr9KC0g?=
 =?us-ascii?Q?H1hNOok6JKGnE9IMrIOpmRSn2S086Eg0hpozTvhnBnOsEUbDmwXW5V3LbA2x?=
 =?us-ascii?Q?HE8JpjMvQPBxl53I1ySi+G+ihGUt2sRpzsOHadvQw4jP1FO+wxq6oWb6dOHC?=
 =?us-ascii?Q?bSJDsVo998xokYcspHc7XZqOX529luX4vy0lo/23W+O3Rx/xDweKebs0WNZV?=
 =?us-ascii?Q?JHwtY8r1tH1D8ctqD6E61xn/exPTm1cD3zdCSP79tW+lwPfcBoep+BKmv7K8?=
 =?us-ascii?Q?JvXCwbmOwFJ3Zvzv+Ynb1m4TUMNMWt0m3RYvt5SuKxf5T0l8fsO5XzSIrbhX?=
 =?us-ascii?Q?bm7yi+4jrA3QNtylL/B0o+Wux4K+T9Wiy/x4Mh2zvgOH2IMTI3zY8NjKtGgJ?=
 =?us-ascii?Q?FT3v3CpbeUE5bXv0eyHsGyj7aVm++egQKPsCbxxUNz80uOmuJuP7HbR2z8FG?=
 =?us-ascii?Q?eQf5pPgh5F66zR2gGcLOqN2uQp7qszz2ilxm1jqNSyayU+sh3myKitv2fqB6?=
 =?us-ascii?Q?eso+QbRtaYPSv73UBQHXnPKAsKbw2S2XmPeYcpX/lr5RHNuOGZGCFwqi5w2x?=
 =?us-ascii?Q?tbd9YMzoCDfwsOP1IdNqaG8yXY3CvLFZeWWOAC5zdmyA/XHUouMnhwqAlmCs?=
 =?us-ascii?Q?xO5iZrx5uDR/+c7j4OGr5DhXMZto0MboEotVKGSVw6w+Mq3Y/W/nCZC+8KLr?=
 =?us-ascii?Q?7Ayfu5wAcu3nXHpMB6hQ856sNuF3kOa53BSFg0uHvV5DuneOPALE94AUf8jW?=
 =?us-ascii?Q?7oWcOxOZFbmjOHftw5JpfBzAEPmSH5+onahu5jMFyRApLCRAB7g/1REE4p7o?=
 =?us-ascii?Q?e/UAersY+IC+8AanaD7xhPBPbIw5mK22EHaTfrhzbin0LUDnPtAUPohxRtJx?=
 =?us-ascii?Q?p5OevuKXBX3pu9NXGz7jObFBpFPgg0Cic8bcn2L49tyz5NguHlKKolsgPoG5?=
 =?us-ascii?Q?fkJRXXa7EAMcoT3k6lNajJ+3jlWM5sJoL8czatUVrdCYNkH2RWZxSqprfNec?=
 =?us-ascii?Q?VYPbgui+zRmQRRHjbwoRJ8RFTwhw0FGiNkbhc2uF53weZTwnMNdyxkPvw+Ra?=
 =?us-ascii?Q?HQ1plKB4c5wRPIIPY6GP/proeDZhOlmpGhXBt0uIuKdu2r3yIbCwwgr3dD46?=
 =?us-ascii?Q?nH2qzdDisA8DveJqactZdJSJwWW8KjW6YD86UnUynD+1XRrs3av9SogMQUGa?=
 =?us-ascii?Q?sR1bh9Cy0sxF6xiQbsInYil+QkSvZqG04XmvDJ6KqimmYFyHXyJzXkda4ZGE?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 396e2884-47a6-4611-916c-08dbb5453cad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:08:40.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Qvr0mqtBl6RNurACy18el8DvRDWe4vokimsZ3mMbPixobiIjAoUO5UOm5s/pk+4wybebLK+GCJs4j2mqBOf4Ns4f4KZH9zoYg+Pyjm4bC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 06:38:04PM +0200, Alexander Lobakin wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Date: Thu, 14 Sep 2023 18:28:07 +0200
> 
> > On Thu, Sep 14, 2023 at 06:25:04PM +0200, Alexander Lobakin wrote:
> >> From: Larysa Zaremba <larysa.zaremba@intel.com>
> >> Date: Thu, 24 Aug 2023 21:26:49 +0200
> 
> [...]
> 
> >>> +static void
> >>> +ice_set_rx_rings_vlan_proto(struct ice_vsi *vsi, __be16 vlan_ethertype)
> >>
> >> @vsi can be const (I hope).
> > 
> > I will try to make it const.
> > 
> >> Line can be broken on arguments, not type (I hope).
> >>
> > 
> > This is how we break the lines everywhere in this file though :/
> 
> I know and would really like us stop at least adding new such
> occurrences when not needed :s

I think with such minor stuff, it is more important to keep style consistent in 
files.

> 
> > 
> >>> +{
> >>> +	u16 i;
> >>> +
> >>> +	ice_for_each_alloc_rxq(vsi, i)
> >>> +		vsi->rx_rings[i]->pkt_ctx.vlan_proto = vlan_ethertype;
> >>> +}
> >>> +
> >>>  /**
> >>>   * ice_set_vlan_offload_features - set VLAN offload features for the PF VSI
> >>>   * @vsi: PF's VSI
> >>> @@ -6049,6 +6066,11 @@ ice_set_vlan_offload_features(struct ice_vsi *vsi, netdev_features_t features)
> >>>  	if (strip_err || insert_err)
> >>>  		return -EIO;
> >>>  
> >>> +	if (enable_stripping)
> >>> +		ice_set_rx_rings_vlan_proto(vsi, htons(vlan_ethertype));
> >>> +	else
> >>> +		ice_set_rx_rings_vlan_proto(vsi, 0);
> >>
> >> Ternary?
> > 
> > Would look ugly in this particular case, I think, too long expressions and no 
> > return values.
> 
> 	ice_set_rx_rings_vlan_proto(vsi, strip ? htons(vlan_ethertype) : 0);
> 
> ?
> 
> [...]
> 
> >>> -		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
> >>> +		vlan_tci = ice_get_vlan_tci(rx_desc);
> >>
> >> Unrelated: I never was a fan of scattering rx_desc parsing across
> >> several files, I remember I moved it to process_skb_fields() in both ice
> >> (Hints series) and iavf (libie), maybe do that here as well? Or way too
> >> out of context?
> > 
> > A little bit too unrelated to the purpose of the series, but a thing we must do 
> > in the future.
> 
> Sure, +
> 
> > 
> >>
> >>>  
> >>>  		/* pad the skb if needed, to make a valid ethernet frame */
> >>>  		if (eth_skb_pad(skb))
> >>
> >> [...]
> >>
> >> Thanks,
> >> Olek
> 
> Thanks,
> Olek


Return-Path: <bpf+bounces-20224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC083A936
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 13:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB3B2848B3
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC760DD8;
	Wed, 24 Jan 2024 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fb6S7QD6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA118622;
	Wed, 24 Jan 2024 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097762; cv=fail; b=lD8UidNbzohJsHwKjUvY2t3ZLTt1mqk4vJ56Z2jj/97kzQ8dx235Kr/Lgu9o+XenepDRsybA/t1r6JhLeyPfW6oWx4+HEvGwdpqZ9twRDFuP5oBbUHSWvO9YqX7UT2u3btLjgoGdtsLxEskQWt+lga+uxozmtwKmKqT/i7et8ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097762; c=relaxed/simple;
	bh=xpqAaiY8Jz90BdxWLamZY5xQCfcxYesr8G7Qwv+Dnwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CV3gRIBDWVTfvUccD6K4jIs02e1RXRg/Geww5HFDP/uaaqrlsiqdI+TRHYlnVOrPorbCxGXswrvYonYZ4ofcWWF9mrOnt9LATe2CIPewCJ/71tuihiHfmFLJycg+MGTy9he3kyp2bOPJ1Cmc+7qEwnYngkjGz5++CUPLGm2VjO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fb6S7QD6; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706097761; x=1737633761;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xpqAaiY8Jz90BdxWLamZY5xQCfcxYesr8G7Qwv+Dnwk=;
  b=Fb6S7QD6zlVRJSf6dJZ5eSDGt2VjOHFw1v5NWrUGz13km2mcQOtqQmnf
   7doEiJR01SpYZ3tNt0BUhNJ3qOjdbp0QVAM0VWuW4s7xXMODtdkIOsaYy
   qt6YjdhN69qBgSRDd4Kq4yoZK+dE6jNh6aAoYU373lT7eLrKRlGB6wfSe
   khBSdMD5haAamTNFaYkp9TY9hfLWTMafrlSmfGPdjCLrEIN4870dzB6Z6
   Gqqmh5y157fl1qic9+E4hg/EHDmPKuyEdqV/gBUW7TaiPNOb2SHBVWhJA
   A42Q/GlW6j+naH3T5+Y7Te5ethHeXxVuCnQka5X7HJG5aX8E2BUptpS9y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15173831"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15173831"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 04:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1860298"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 04:02:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 04:02:38 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 04:02:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 04:02:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 04:02:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DapEL1WMEd4in9EgYqsHp5vgXZIsTczmx1fEI0DA3dTMm3ZcLsXjMlcRecb6Mr1glx9dAlfce+M9YF3eBQba1sxB5oqkM07lkNhCN6duG25hhu7ax48jWs2gqcAqTWlqGa64XIZb5f5TntnMDwp6crCmNowPLqoKPLalEIUTKWDIwe/WsoDnTVMFJiGijZ/aAQ5xqJAyhH0RUegqLkW/TXzZHQvk49p6N77Ki3GT8lZDqqocA3tylcZamCK/zLAOeT4rA1l/wxHOF2tw82sfkaB+bnXYQMQhaSdzZ/fVPr2VATHWdSfmOyT5ELYlDQNZJAWoZcz2/9MRHvWR+8wUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxiRfh7wGV0+OB2ss7eh9q/66a854CsVx0td/5iapR0=;
 b=P2zguRO48ytwlM8foOKMzYfGQFYA1ZzFO74ybj/Wz2Cb3gENKlfl79I8x00bWj6yJEZtl1lWOAp+bLSMPU6nX/8GEzw3rHdlFoJIKlGJjCboIuIKS5jdnYXMYJkPO0UrltP0yxBjwXj+LgW/AZmQFTu4rVVGPuVxvHIMOwImAbjyURrtSi+3dQL1W/kSzBG+ji8xjEdT/QTFQOwf9TFabElpBnYh5JJrLlUklQ+vqv+zo0YZrrgobuXHTMoDn7tO3ib1ucyUA+v8BnigKyCc/Nz3SzUzYfTrt9+MrOzMlpxc+HtW08eoIKcptgp9WksnuyIJNgz+PWWTYWzROTUrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7730.namprd11.prod.outlook.com (2603:10b6:930:74::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.34; Wed, 24 Jan 2024 12:02:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 12:02:34 +0000
Date: Wed, 24 Jan 2024 13:02:21 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
	<martin.lau@linux.dev>, <tirthendu.sarkar@intel.com>,
	<john.fastabend@gmail.com>, <horms@kernel.org>
Subject: Re: [PATCH v5 bpf 03/11] xsk: fix usage of multi-buffer BPF helpers
 for ZC XDP
Message-ID: <ZbD8TWLihi4SZTwR@boxer>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
 <20240122221610.556746-4-maciej.fijalkowski@intel.com>
 <20240123175317.730c2e21@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240123175317.730c2e21@kernel.org>
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: dc07f836-6434-4726-e724-08dc1cd459ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PF6nlKHSStuSp1Tr4HDuDkd1jU+PocvkeK0KcQS6/l9KokShrmIqB9JviTbllzbxuEcFsh3Cy4heRwgivfNXVcqdJBAiJuJHeQB0PU3nJZGhF/ceGPRoHOdD/7dF35RkfECW0mR/6J5O5o4IsyRNGv46LlJBF7XMg8VEocY2NNgZTyUF6EMiHvnP3XNWrWKluCO0vmgmB1EB+mSz3uk8Woi0q0MFV/7sF0G2pK1zkOCEGA0ZcicaTA/nMEypnbyGsesDVb6eApKMrfuY54PxBzFZRfS24dX0KOeoOIHCvwlonr9Rquw6m9lcnC/8+GwbAuIBWivH8U5Rioy6p9ZrN+FgIT2Ei6JI5om+O4a44acN2rDPdLU82p99IUmGPWmjYX/w3OYXK4FR5Gn2lopVId3sag1s7jqs5SGDbCOKPxSXQMyRYLDL3LFohlTkTzmjWnY9a2wsFf4hThFD2q2kLJfU2PVOLLfYNfVZc52vxa5YjyMWCVHPtYg2tIIPCx0jEemJXp+SjuTygERAuKvWaF3jZLSDC5OZLEt3+0j9LoFChtXFgXh8dRi/DrYXWKFu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(5660300002)(66946007)(44832011)(4326008)(8676002)(86362001)(66476007)(316002)(6486002)(66556008)(6916009)(8936002)(2906002)(26005)(6666004)(478600001)(6512007)(7416002)(9686003)(6506007)(33716001)(41300700001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N/jQPDIhjJbhsc1bgNvXmvW30ujruDc6ilLoFmnDNpTso+LDWUXKyruvIQi5?=
 =?us-ascii?Q?Nwoe8SgsOYH+Je3//XzmQYf5DmsQHchdLlVCQKfH84g46flroV2BlCbzTaSJ?=
 =?us-ascii?Q?7zCvbWhHDgtelszmQOZ6beIYXaCTyihqfInjeNYZn4+3fuowfU047inbbnAh?=
 =?us-ascii?Q?P9tbgXSp/Gq2cIEFzYIQx6kWJ6rq6EOOWFaG98dtuPHQviHPsPLcX9FEzCDo?=
 =?us-ascii?Q?udcKaVWSCQdpvWRRTd2+03lkjr8pMVOxsFB0Dr0+oY0IkVj5ueJDV2JZljiz?=
 =?us-ascii?Q?tMK1un2Yh2gFwNZ05JygF+fs8gU4qc5hyyYYAE+RD8NaWQtaFwRllAD+6xM9?=
 =?us-ascii?Q?yz8w4WuPUIMCc4pWqeEOVN2/ImpVlWHPcuOq1zDuZX5Pus48nnnUBaMr2+y9?=
 =?us-ascii?Q?YbtUa496NQdTgAGsc8B3rbjENECZKA1TTw1wsRLww/PxLPwcTEDp7xYul+YD?=
 =?us-ascii?Q?tLrsS8L5Y9SiSs3cWmHU6dAZmmuy/oo6tDehqwU9EQemuLgNp630+LvrBEPW?=
 =?us-ascii?Q?/aZudyhLgu4KsuycA64i0+4tvFGkcT9WorTIQkZWqOHNQLX/lIepFNQqPbF2?=
 =?us-ascii?Q?HAMgw0+uthySEJaIj5iB+pMX0N9oBxaNPNx4kY+jIkiICkLgvGRCofQmlCLO?=
 =?us-ascii?Q?SgkEAn7H9iuCLH/J+Zy3kRqaUe35qSSESN4EaqFRpeNtAJK2FkRlQ7u/Idzo?=
 =?us-ascii?Q?JG6IXw92Lb8YJECpyJpuOzau3UnEVHdMEpWPcN/3zXWYLJayTRMa2vfFRpjd?=
 =?us-ascii?Q?A7ZHZyTtqtrzfn8HnOOonwzfbLTS36mLFRb8eIPRo+YmVBv8b0juaeVIYFZQ?=
 =?us-ascii?Q?TyD89E48pONwVdKaoT6Ye+NAM2K2UoWb1ZRNJWC6sB8heR77QiAt/K2WhfpH?=
 =?us-ascii?Q?kj7qxF3PIqZI1a4YwSPSitQDv+PHievO+BjV7FUn/iZjBrV7/RBsOh8KZWRR?=
 =?us-ascii?Q?LXfauXmPxXmPZZvsf2nis6TvOHSAySio4MeQzQEf2U8VIaZqVJJai10O12E/?=
 =?us-ascii?Q?Z5JF3wXcUeMB9iewus3V4Wb9yLPumEs+pCkuWR5rrfIbHrW7C3PC6ZheuG6+?=
 =?us-ascii?Q?wFMoGa7ZcpV1kQiAkGpvoEkx07Owqm4SnCqukhj1dJS3NK+b+P5rQ5Oa42uz?=
 =?us-ascii?Q?3iAhj2bBVwOtpQrr6DcnOnxEpu7j2+Ehf0IYNPYoXQwCBecYnPY4g5kog45V?=
 =?us-ascii?Q?C5zCwRq6yehb0j04iTI5JGb6hHqS92r9gP4In8WciTuik6foMQI2z1pLANG1?=
 =?us-ascii?Q?h/LKgAas2PTj5gsunTZ8tGtEg5e2yJv9wxY/wl4FVLNVUMlkB6idz1zl8ifi?=
 =?us-ascii?Q?rutv+4qtvBOchGG5SvazrQsRhxbIXGH9aHjBM1Ojvrhd6VhTtZFM9qc6uQ2F?=
 =?us-ascii?Q?2/HBbptAlCP68Y4WD1zyzTs0iBiBKRFg4IYPtJ0FFQ/4/YxqiBkIMD8xiaIC?=
 =?us-ascii?Q?8q6cFkQ4qNwwpPAyGUnPbizGR1MJnMr+TvanSsK0RfHZlQJFWAZnrpt/Ui4m?=
 =?us-ascii?Q?cYDlKu+5FCCDGwulfZdFUU+4+O7G3V4Vw3KJsmoVQlAj4pjrqmilyU6Uw7yM?=
 =?us-ascii?Q?kn6CwY6WT0NOw49WeY5sEdqE0aGMwiAeClY8yCBK8AtiI2eVUTdL3nBJG+Fi?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc07f836-6434-4726-e724-08dc1cd459ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 12:02:34.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvvfbxdfJr+JUb0xPrjkcdIq209adkm8rkhsQl+V94B9czY+hhxN7U2O+NM3mvpAeCt7YvCOnAwgwxBf4Vn1tS4FcGNMOgZTV4tnyE5LgVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7730
X-OriginatorOrg: intel.com

On Tue, Jan 23, 2024 at 05:53:17PM -0800, Jakub Kicinski wrote:
> On Mon, 22 Jan 2024 23:16:02 +0100 Maciej Fijalkowski wrote:
> >  
> > +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> > +			  skb_frag_t *frag, int shrink)
> > +{
> > +	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL)
> > +		xsk_buff_get_tail(xdp)->data_end -= shrink;
> > +	skb_frag_size_sub(frag, shrink);
> 
> nit: this has just one caller, why not inline these 3 lines?

we usually rely on compiler to do that, we have the rule "no inlines in
source files", no?

> 
> > +}
> > +
> > +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
> 
> nit: prefix the function name, please

will rename to bpf_xdp_shrink_data(). Thanks for taking a look!

> 
> > +{
> > +	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> > +
> > +	if (skb_frag_size(frag) == shrink) {
> > +		struct page *page = skb_frag_page(frag);
> > +		struct xdp_buff *zc_frag = NULL;
> > +
> > +		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > +			zc_frag = xsk_buff_get_tail(xdp);
> > +
> > +			xsk_buff_del_tail(zc_frag);
> > +		}
> > +
> > +		__xdp_return(page_address(page), mem_info, false, zc_frag);
> > +		return true;
> > +	}
> > +	__shrink_data(xdp, mem_info, frag, shrink);
> > +	return false;


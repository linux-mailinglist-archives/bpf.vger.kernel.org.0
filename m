Return-Path: <bpf+bounces-18370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD441819B52
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 10:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC051C257C3
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121DB1DA54;
	Wed, 20 Dec 2023 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikS4uwdV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E661DA2F;
	Wed, 20 Dec 2023 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703064245; x=1734600245;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r6oJx9hL/cenqSSvIsV+9vT5MfEnJT9fjkrBSe5HHi8=;
  b=ikS4uwdV7eunIHTe53YwiFWDYHC6K1j8+btvWXjSiC44hk3tdrnWCnAS
   avli/UoRSWUkCQuPCXVGRhWpx3pN+xDwKjSJA+YHEbfllNOW0WCbza5/i
   uh1lS3H/raOk6rY2mtLxso86RRvxI60L35jwVC9lmuxA4wNwn2LUqdws7
   PeZcLGuUR4nHD/sqeEGgqwUduZhTMDZn7qI56tNsfafq3hwcgl3+htYZz
   p+SPpJGH4mKS1vkm3j1Sj6nuYEP/VsdzrY8nhwgL4XRvr88KqoBe9+ei1
   RkAeqiivKnkh4zulTpiY4xwV4etI8jictXLCWcTQNPNN4VGU/gAxvklwd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="398569640"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="398569640"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 01:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="949472710"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="949472710"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 01:24:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 01:24:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 01:24:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 01:24:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnsS4IHQH4SEDGWKDzP7jZhyg9V9cl6mFuiMvuZEizuxk6sUwv6TJh5AkjLB8LZtsnkYNcxU9kU+b4lwtT52bj9oeXKfcexAr5ogILZdYIu1ft7bNKLebDfQJTZ1PcuMtX8WjhK5eypLp9FOdFPLWlH6/JoRRJatH4yY/Ud7Qvc4V4dQozUlSb6ShKTc7FLsWl2m8/e/6t5Ci/popqIVte+VTwz+5Dp9vqmYDt7/Ghq4Elor8QoA20kApdTMYohFQkpbHjmqRDhJiLOlgbrgspustr9nAG5UQ4gHTggejqvHYg3Cfkrzxj6awObk1qcQ8C6Yc9dlk/BuoDgg3sQg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWzsXutQEw4yyLONF9LYPW339reAloZU1AeV3pB/Zas=;
 b=Ex+yiBeLCf+t51d3J1WDY9ev2c9qCnC75kOtIHureuZw5bHa1Fq9LDcEZZxO3sdEhqcI0lBwbaVsKIfZVZjmZbWpXGdLnPMG1ggC6Fx+A+DQfmjdddcF2+DPTe6uoZ3NIdPZBNc7leppWaR1UJ7FasQHg4px9uBu/hQhU9+M3BAfEATT9n8cAOBOYoB8n0g7X7x1pyecio0Upm3YoamvVCcUMhCTr17pW2Lq+bugQTaV0LYM0wC4n48mMfEcdrHrpstmuSdHL0tNm71C/kOi6X/pbL53RsynYEHFLFNTqglwTbrj4nwlUhC1fq5GTyXYiI8Ss7ucls3WbZscTLQZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 09:24:02 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 09:24:02 +0000
Date: Wed, 20 Dec 2023 10:23:51 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <maciej.fijalkowski@intel.com>,
	<magnus.karlsson@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Simon Horman
	<horms@kernel.org>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 3/3] ice: Fix PF with enabled XDP going no-carrier
 after reset
Message-ID: <ZYKypxfcfwTjZQ8w@lzaremba-mobl.ger.corp.intel.com>
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
 <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
 <18b686c6-aec1-41ce-8d9c-572667c9a738@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18b686c6-aec1-41ce-8d9c-572667c9a738@amd.com>
X-ClientProxiedBy: VI1PR06CA0207.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::28) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 36784a4f-1ed1-4b19-8bc5-08dc013d6725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DA+s7D9lhRbk0Cnpc8ps7RoP6HGFtnM1wbrRyRelw4G66jYOz5ExzPGrwEjYYeUIi7I2o/ixIJuMM4/RYixuSdXS7Qsv76aJyb1yRtfmVO4gITJofcmwVyBkCcD7QOfAOl/5GsJcavGm24RlWAH4QJKCMb/lBGa7goMV1daBQt/1XfR54BcOp4zHdSWF48MWurYlNVEYRaG9e69/0tfen0RGecTF7kRGkrAMLeMUYbEXnLV/YRqoPEyApkhHfFyDFozYoEqeFNusemp2OPvofqy6Wn6v+R5F6vFS1kDlzBmYWOT8+4V4PDqZjGqhFTjs6kD6V0IKTr903ZSTbf+gZmizVEmCu9++nIw2xTb1ywv1iLvk9O32uwWTKHa4tBG5ky7DyjwgkAw8Yk+pWB5ulT0CmNOn1Q9HjoQ9o+e2HzvOdCigNz5pTz71CpKgfx+XaAn0eN+cFy2yPDhiEZ8AFSl6NnIBlEGMMlbJgYl7Uvcm63ZJ3UmUyO5rCG3mfIVlj0jLEEM0jnBykysGY4k3kdU6y94G+WAtDFsHp4ham0D+ACJuRq0Q3PzV9Jx7ANSAKQh79w2NqccUJHK9mZtGsC+dwBZQNqRU1jseIXWP1vZIQNd0K4/JmydzmBMtLDx9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(86362001)(38100700002)(82960400001)(6666004)(316002)(478600001)(54906003)(6506007)(6512007)(8936002)(8676002)(66476007)(6916009)(6486002)(66946007)(66556008)(7416002)(5660300002)(26005)(4326008)(83380400001)(53546011)(107886003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sWJRKTmozUgg/qA2How//btLa3/Jby3MUUq7Kwa/sVPIZXTunIXch/oVBKen?=
 =?us-ascii?Q?3GPbt1zjFBN5G8ePkfTrxkJm3ttqaIKimHQ5Lu+vN0BE+bmgKc5pb9qr8Umv?=
 =?us-ascii?Q?m6/fxF59kUTPEIPMdqE0r6RxZlrRtYSnFuDzXYZXY/0hRXqol36k9IUj/9Ye?=
 =?us-ascii?Q?R6b8iT2U1nVAVCQ61gvcIp1hStiG0lMaipirSDhkjsFKzRPXu41fOZwWTE+9?=
 =?us-ascii?Q?ZBh1oCrupWL5foJ9fnpMSAL8pt0mSkoG2lTWvt97eeWqDfAPfV8aXdt6T/ky?=
 =?us-ascii?Q?xvfBXjd+3nouP8mV9hRxI/MCSrToKoDwVl1ohYoqzjOkXEg6cZgj8B+87wFF?=
 =?us-ascii?Q?aBnBUX1ofXUZaZh2Do+G9XossvRttP/JcgumXOjK2uidXC/orTEpXy39NsMu?=
 =?us-ascii?Q?R1V2Ss1rR0/DGnZtzPAlB6wBtioOXFBh8lc1P1hDgEGCr0exI/LHhknrNHFP?=
 =?us-ascii?Q?NRfoq4fCyHysieBajb47wM3DJYOd6QUBmWaFlcDmrwpnrRHVlmFmJhgOJ4qL?=
 =?us-ascii?Q?7t6mPwYwMmZNBzKYJM/lXd1Xp/dZv197UkMIlGDN65CKXUV6vDi4AJysRxBB?=
 =?us-ascii?Q?EJKPGwxnF/rqbLiXrHQ78hn4atkJJzFNmN1Dt4lQz1FU+DOrZn8l0NZ9c2ml?=
 =?us-ascii?Q?c+82xYiBqxJgq19ZwbD3KL1rNqVpIagjA+ctvB+rTi8JsVf5S3O9PiuqAXC8?=
 =?us-ascii?Q?HsLuabNYzWUN/qe+JjtrA5NmLcENhcWoL2xZclsoK4uqvmm/dt3evlYIsipR?=
 =?us-ascii?Q?rrt528WPPUc3VWOvgHHbIqx24M83euS78gNjHmpLcqz+MynL0eO0sDAqAx7W?=
 =?us-ascii?Q?KS32BhEqX+M/+CVU8uJXRq4VZ1Szs6l1Q7iyabHaRSKHv02pohQe5VWB30Lk?=
 =?us-ascii?Q?edU5MM3lp360ftvfZEKnWAQFNjCIemdyswM+cCPqZk4BXJQk1KuqIjD64gvL?=
 =?us-ascii?Q?I4VwiNMMYV+R1INPPsQA5NUIyV9FafBggSJyr4IxJmBnCtWuCENWz/4iLh51?=
 =?us-ascii?Q?n0BbOOkDVHB3anr3IKKXGXbt3yBE0omJRtmUBD/uHcWCEResB/BGX3dxlvUW?=
 =?us-ascii?Q?8ZgrSjyXrmIT/qDfcefF+beqO3I69Yu5GxGTu4VmtKmse4r62B0Zt+KaXXbD?=
 =?us-ascii?Q?L3X/XX/qEL0OzJql3DacN7vVptJnHZxn4S/Sg60Ixb7/tkCJewoQzmA6mrOE?=
 =?us-ascii?Q?6SQLg3v20CeErlFfcx6zBCzex5eHStg3vtpcOdau4rxBmaUQmEKuGagrIMiZ?=
 =?us-ascii?Q?nK9ba9Av5ZuwOz1xz+yrILo636m9e16s+6yVMuP5412CiYwxbwhiI0h2CAyc?=
 =?us-ascii?Q?Xg4JVqRGvz6Dong5u8Ey4XAS1qutEMzW/Tz9dmgFjvxzVsYLqAcWZ7RPMLxJ?=
 =?us-ascii?Q?sKRzlSa8g5koTR+pGZPSm1v3Bvm5kK7mVCE6hlEn+IxvDUiSbf4JLQ4K51oh?=
 =?us-ascii?Q?qYM+Uy67DtXHP2JK1+8WHiVYc26uhCotbWv8/jHNoDS1lHspdKwrdQkDPknK?=
 =?us-ascii?Q?ni+u5ySSAvGGXlqxOqIemZ+3vbY6eWUswObcVd8p2XobTpn/a5Jvh7OQ9qfn?=
 =?us-ascii?Q?VoX3VW7Ql5etswFSzTvwKDUpzx4t+COxT8UyX7MLdf3hzLCLUXl32M9/WCG9?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36784a4f-1ed1-4b19-8bc5-08dc013d6725
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 09:24:01.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+WWPUcAltQC8bOxd6V6rQyYWtCzGmPeBc2ECw0eswDETdVhe+SU5ShqRrA8EFk9QG2NG4KiY43fKwH37a3di6cio9HDlLguWrdbDtQN+W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
X-OriginatorOrg: intel.com

On Tue, Dec 19, 2023 at 04:09:09PM -0800, Nelson, Shannon wrote:
> On 12/18/2023 11:27 AM, Tony Nguyen wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > From: Larysa Zaremba <larysa.zaremba@intel.com>
> > 
> > Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
> > functions") has refactored a bunch of code involved in PFR. In this
> > process, TC queue number adjustment for XDP was lost. Bring it back.
> > 
> > Lack of such adjustment causes interface to go into no-carrier after a
> > reset, if XDP program is attached, with the following message:
> > 
> > ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
> > ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
> > ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
> > ice 0000:b1:00.0: PF VSI rebuild failed: -22
> > ice 0000:b1:00.0: Rebuild failed, unload and reload driver
> > 
> > Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index de7ba87af45d..1bad6e17f9be 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -2371,6 +2371,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
> >                  } else {
> >                          max_txqs[i] = vsi->alloc_txq;
> >                  }
> > +
> > +               if (vsi->type == ICE_VSI_PF)
> > +                       max_txqs[i] += vsi->num_xdp_txq;
> 
> Since this new code is coming right after an existing
> 		if (vsi->type == ICE_VSI_CHNL)
> it looks like it would make sense to make it an 'else if' in that last
> block, e.g.:
> 
> 		if (vsi->type == ICE_VSI_CHNL) {
> 			if (!vsi->alloc_txq && vsi->num_txq)
> 				max_txqs[i] = vsi->num_txq;
> 			else
> 				max_txqs[i] = pf->num_lan_tx;
> 		} else if (vsi->type == ICE_VSI_PF) {
> 			max_txqs[i] += vsi->num_xdp_txq;

Would need to be
	max_txqs[i] = vsi->alloc_txq + vsi->num_xdp_txq;

> 		} else {
> 			max_txqs[i] = vsi->alloc_txq;
> 		}
> 
> Of course this begins to verge on the switch/case/default format.
> 
> sln
> 

I was going for logic: assign default values first, adjust based on enabled 
features (well, a single feature) second. The thing that in my opinion would 
make it more clear would be replacing 'vsi->type == ICE_VSI_PF' with 
ice_is_xdp_ena_vsi(). Do you think this is worth doing?

> 
> >          }
> > 
> >          dev_dbg(dev, "vsi->tc_cfg.ena_tc = %d\n", vsi->tc_cfg.ena_tc);
> > --
> > 2.41.0
> > 
> > 
> 


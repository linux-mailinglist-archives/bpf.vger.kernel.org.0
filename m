Return-Path: <bpf+bounces-18511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4281B204
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 10:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930D0B27773
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6971224DE;
	Thu, 21 Dec 2023 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0PqXczz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD34E611;
	Thu, 21 Dec 2023 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703149561; x=1734685561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qILVNS/SbsCTDBKA7E6k0XuR2yqtGhSxZS1R2cTsIuc=;
  b=D0PqXczzBhXZOH108leafsk+XSeCVC3crLZogJM3QGuQm5KRIS7xEF/j
   LjvNzQGCMaZ3hY2zY2En5vB/Cm4+k4ZPMZl3t4+AQW75Y5/iyQg70fbB+
   vGeAmP3ktRS9Yi98JwZzGox+5TsLWxNmnFvSgnezVfTBTkyVr98PCE6v1
   P5bM5pHqEMObe1z46v7rlJdpX+tJFmpuEt2DKUsaxmrYVI8w8YsqjHvL+
   pjNdx4mWyMhMUSHODL/CxpuN78YIP6BkXDjcVSRz84elRH9taY6mZmOpC
   ktCAPoTQGnp4sncyBC6XnALY0hqOzsHqQMiPysF1DubvLQMWGMbDY5NqN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="394837151"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="394837151"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="769889383"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="769889383"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 01:05:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 01:05:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 01:05:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 01:05:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 01:05:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCQWt1m+XAJ0w5h6NNyB/FxltQxSjfm4/GGiiF7eqBc1VGQA7VVeLzsojruyxHz/9ETUdDuEZ1jek9TyyYVjDc/V8Z0OB0GOyNpsFwNuLXYMviMkJh9bTf7qFsMTrLwKkHGydHd5/2HkKuwi2Ufs4SIoe2KdLjjA3fChI3YEYUuChsstqlcaIy875nzT/QCqdzfLexUDQ39FB3ZCG46kaLxxihAvp9uOQJTcYufrvJNXBsejlhIqCXpXpewK17q1UnmReqjehqYMynl/h4wlS4RwY6BzRNn6S+ahfp+GrOQpvL0vW65Vbe0tmuqK4+G9ajn+UVynwzgA5WV+BIzS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK3h+nehfsu+uTJBaccfPTMcKUBKMf44FKZQ09gZF00=;
 b=LiU3KTM86hSt/RAcmFEzmPmjPl1YB1VDabLvkI9O7+0aWfeByrZnlzg6cSmmlLAGNJ44mi6ljGRyA1/iDrbfxLLcDlkrYS/fndlD7OZIMWdHpK81o3BHwyT4I1zja1sMqgILCfr+WLip/ELqcu+ySUq9WOZBPuj0Bk5yonGMEx7O/pxqTn0v76GClTH5iiqJNrCXC5FKYnsQLqsyoJiIXDnJjtRzeNWMsuXsw1Tg1r9quYQRSuxpw+rMI5SOgTG4hz9cWuE9tp3cNq9Xc/FhyEpk7+Tff3ibK5p4E88kycUxly5yXv5k+fHnVIyy24w8FNYMClpf/FXk+3bOomkCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 09:05:51 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 09:05:51 +0000
Date: Thu, 21 Dec 2023 10:05:43 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "Nelson, Shannon" <shannon.nelson@amd.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <netdev@vger.kernel.org>,
	<maciej.fijalkowski@intel.com>, <magnus.karlsson@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>, "Chandan
 Kumar Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH net 3/3] ice: Fix PF with enabled XDP going no-carrier
 after reset
Message-ID: <ZYP/59gQ+g824Ed9@lzaremba-mobl.ger.corp.intel.com>
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
 <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
 <18b686c6-aec1-41ce-8d9c-572667c9a738@amd.com>
 <ZYKypxfcfwTjZQ8w@lzaremba-mobl.ger.corp.intel.com>
 <e24ad563-f814-490f-8659-af6ff15cdbc0@amd.com>
 <3830bef7b52414e3a0b874d3fd23d7e8bc4c1c2f.camel@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3830bef7b52414e3a0b874d3fd23d7e8bc4c1c2f.camel@redhat.com>
X-ClientProxiedBy: VI1PR06CA0112.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::41) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 2648c09d-9150-4951-4573-08dc0204078d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owhSO0EZKVFqR+AACz+pEUDFBahCgUW2H2XfajD31WdhXGZ4jocLrzW5aWspCwQi1DMLbB5cjBzUMaIINXBQDWB4GTORL/6wfs6B+7FtCm5sotrCs3tc7DdM09HFv3mwmwkhkswhbaT1xqLvkG0qwaewHA28ll7SAEuoRnqUN1TYBcafLFegBaBgp59wgifQ10Q8A5/XKKKw6bmBxowVKKAwOUSWE4aPXnPOSvouGByorcGII7ESDkl5Adt7m05dNoqle9VcSCOfZL3ZbitFzS5SfcRR4BeiQrdteHVRtW4QAVOfQdnuuxmxLOShJk8k1Q4IzmULL8NYXW0JKVA/KLV16czXvNguEijfRjKHEH93DxHTx7B5HZL5nGPUzY16wTRGgiBDLGWOk3NCbLTKoHvdyluw277jrQ+Le03wyIyKLB7AJ96jGXLrONII8hyNTkA7V+J/t04cqWS4r5ZUNV3PC0Xs6SSV9bJTUnRnitAI0wlFgkGpQIFjJ64dPqfp4VOdw89JBaqPJceuCY1TMpMwOsCsO/I8OD3vJNLfT0SY6mX1jgBrjsFTT6cQXztdLd7KMvKOJD4FR6nriHuuM7qrJFy6LbAdBXC5qEbKFdSFEy/Pvn2wIsYXBIfSoUY8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(107886003)(4001150100001)(478600001)(2906002)(6512007)(7416002)(26005)(6506007)(4326008)(53546011)(66556008)(6916009)(8676002)(8936002)(6666004)(54906003)(66476007)(316002)(66946007)(44832011)(5660300002)(6486002)(38100700002)(83380400001)(82960400001)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6I58fiNrj9lc7XAx8VITEoYam4+2YzVn8PXk/p5ge/nm4Bm5/tjE3aVJgGnk?=
 =?us-ascii?Q?aTPAwLxOP8Gjc0pXj6zRVb0qlSajKhC5/xQHXmn7/bdWpbgcmHWmaKGXmYMY?=
 =?us-ascii?Q?O9g+MDMLmtf44Fbr+P8uAQjdIN/bhV8VroQu1N0HHI3txxjBnWXN2LRMgkro?=
 =?us-ascii?Q?MTmhXWaFCKMzL3osCfhZ76kjs3xAscGlfSg960m4uR6N+CAasdOOv+IeiSKB?=
 =?us-ascii?Q?KivnvL3ai3oKczof34gsvL86fTv4Ia/GUdGg+LgeFKAfRPxX04ZvolDkuugF?=
 =?us-ascii?Q?cXFfvJFr2UXqR+Q5XwwoCUD5vfeCJEh45dpNI+dDEmrC5GoUyEhz2TGhDlCP?=
 =?us-ascii?Q?gV+Rpw0yThgF6PqQXeXDy/PxRy4xR14C9lvI36xPQFLKR6LxCvEHHLFpr1OZ?=
 =?us-ascii?Q?07ZDPtuNU/r1c+9hLFmnGiHEI+n9SDMuLxEBuQj4DU8KfVqYHZESiuSPCQ/S?=
 =?us-ascii?Q?qi8kZ+Z9jAlwWM63LtdcOPYYzuLd82/0QwAQO/1Wgt2iBuNaWl6kNY/YnSY9?=
 =?us-ascii?Q?FkzR2x9XGPUn8Bd7GeFwcBHwHmiYyWZN4n8g7GrVM8vCA7MgfLAhNntH1viw?=
 =?us-ascii?Q?ZbFwhdTz8IJlbylyrKvTuUUuBIDftc4fEu51rdjss87t+GDzMflcWyKV4J20?=
 =?us-ascii?Q?d0V8F4gmo+AJs7UDt9fGKlfQViwo2GEOljSzoUp6wsJ4gr/IPn1nZZjXXHhM?=
 =?us-ascii?Q?lFI5oAsrUJB2C0Xztq+qwlNqLhyuTJiLwWqryIl4Y3/RoC3LVMAiow9dw9RX?=
 =?us-ascii?Q?pOuw/svi7Qgz9Db7rujyUg1nepoiOAsqlda3FSYdDCcfijA4ftkpxWW8+tM3?=
 =?us-ascii?Q?F3pwbFcFIHrgNkp4xVb4C2GqCOfzlIfebZ6ade8cb7ZRVXPpCbkrOBJa07i9?=
 =?us-ascii?Q?ub3HnAiF/wbnrX3Xq9ZnSzaMzb6aqsVn0EK9HYXOAyR9dUmqsRjwcEK2q7el?=
 =?us-ascii?Q?MRu5MZ8ejibN715dey4kn8D+x2GP+hF6itOXV02gs+3JcNrwzp5bc1IQebtL?=
 =?us-ascii?Q?UakHhJszqg4SnrgvZVbpy4CV82z5eIeVz6tg2REt5mTSUQe0Bj4adoWNdjy3?=
 =?us-ascii?Q?JF2bZQhoEOFHkdMnZhDV4YXijtgC1B+I0rW/mEB/NNCLOVmbsMMZbD0GiTPZ?=
 =?us-ascii?Q?0nB0fWpUG2qbtDQ51BfJ7XTrjdAfxAQ6ejqXtEKtDLcplkcHb9aGOfkSmup1?=
 =?us-ascii?Q?MM5EYcX+YI3TAIK+eF+W3qy58EJIw1Ta9y4qPB1c4UR08gsarBaKhvvQqRKB?=
 =?us-ascii?Q?v8Kvoa8FGt3acv62HoWDKAZ3GuhwLqQqlqpO2uzasXYcs16fVFVz8sDyxpGD?=
 =?us-ascii?Q?zoA2S28Fm+vjYlkRqAI5Nryzi5WVnPo+ccbhgRWCPyLWsMUBQyQvSWs9NOwY?=
 =?us-ascii?Q?vWDRagDghAaqgDUbQqBolVVgkkr3jv9nFa5QlsJZfWGiYaLQNguQDXHKMWQi?=
 =?us-ascii?Q?NDoswB2hOuFdbs3Lk9W46Ing/Uerzf2OQL1v8xOFjk4tpWetOrQZiSXJbS13?=
 =?us-ascii?Q?GYtRknVriDOR9wRP0fjEkJTfcA2xMR9c86IvzMM23cStjOWOau0u6UZWEeV+?=
 =?us-ascii?Q?OXD8fdRWevr6hn33NGqryw9mwjPGsVxhTL31KqvXOC5PIngV10KR/DGI7V6B?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2648c09d-9150-4951-4573-08dc0204078d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 09:05:51.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRvUfnGH2FVBwsybf6cutBvkPm46GE54p2nBfq3X5Gs+Kvutk5k9W0raTNhSo8VFdTSzffJdDuRg89B7eykLahJIp3QTOgPJ5+S/2CVU/oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com

On Thu, Dec 21, 2023 at 08:23:39AM +0100, Paolo Abeni wrote:
> On Wed, 2023-12-20 at 09:04 -0800, Nelson, Shannon wrote:
> > On 12/20/2023 1:23 AM, Larysa Zaremba wrote:
> > > 
> > > On Tue, Dec 19, 2023 at 04:09:09PM -0800, Nelson, Shannon wrote:
> > > > On 12/18/2023 11:27 AM, Tony Nguyen wrote:
> > > > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > > > > 
> > > > > 
> > > > > From: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > 
> > > > > Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
> > > > > functions") has refactored a bunch of code involved in PFR. In this
> > > > > process, TC queue number adjustment for XDP was lost. Bring it back.
> > > > > 
> > > > > Lack of such adjustment causes interface to go into no-carrier after a
> > > > > reset, if XDP program is attached, with the following message:
> > > > > 
> > > > > ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
> > > > > ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
> > > > > ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
> > > > > ice 0000:b1:00.0: PF VSI rebuild failed: -22
> > > > > ice 0000:b1:00.0: Rebuild failed, unload and reload driver
> > > > > 
> > > > > Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> > > > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > > > Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> > > > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > > > ---
> > > > >    drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > > index de7ba87af45d..1bad6e17f9be 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > > @@ -2371,6 +2371,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
> > > > >                   } else {
> > > > >                           max_txqs[i] = vsi->alloc_txq;
> > > > >                   }
> > > > > +
> > > > > +               if (vsi->type == ICE_VSI_PF)
> > > > > +                       max_txqs[i] += vsi->num_xdp_txq;
> > > > 
> > > > Since this new code is coming right after an existing
> > > >                if (vsi->type == ICE_VSI_CHNL)
> > > > it looks like it would make sense to make it an 'else if' in that last
> > > > block, e.g.:
> > > > 
> > > >                if (vsi->type == ICE_VSI_CHNL) {
> > > >                        if (!vsi->alloc_txq && vsi->num_txq)
> > > >                                max_txqs[i] = vsi->num_txq;
> > > >                        else
> > > >                                max_txqs[i] = pf->num_lan_tx;
> > > >                } else if (vsi->type == ICE_VSI_PF) {
> > > >                        max_txqs[i] += vsi->num_xdp_txq;
> > > 
> > > Would need to be
> > >          max_txqs[i] = vsi->alloc_txq + vsi->num_xdp_txq;
> > > 
> > > >                } else {
> > > >                        max_txqs[i] = vsi->alloc_txq;
> > > >                }
> > > > 
> > > > Of course this begins to verge on the switch/case/default format.
> > > > 
> > > > sln
> > > > 
> > > 
> > > I was going for logic: assign default values first, adjust based on enabled
> > > features (well, a single feature) second. The thing that in my opinion would
> > > make it more clear would be replacing 'vsi->type == ICE_VSI_PF' with
> > > ice_is_xdp_ena_vsi(). Do you think this is worth doing?
> > 
> > Hmm... I made a dumb error in a quick read of the code.  This suggests 
> > that making the intent of the code more clear would be a good idea.  I 
> > think that the ice_is_xdp_ena_vsi() would definitely make it more clear 
> > as opposed to the bare ICE_VCSI_PF.
> 
> I think that the current patch fits well for stable, and the issue
> looks relevant enough that we should prefer have it fixed in this
> cycle. Any refactoring/change would not allow such result due to the
> timing.
> 
> I'll apply the series as-is, please follow-up on net-next as needed (no
> rush).

Ok, thanks a lot.

> 
> Cheers,
> 
> Paolo
> 


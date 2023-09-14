Return-Path: <bpf+bounces-10057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60D7A0B22
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883B01C21170
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBC426288;
	Thu, 14 Sep 2023 16:58:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCC208A1
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:58:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A21FE2;
	Thu, 14 Sep 2023 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694710736; x=1726246736;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ttWsEG9I/e6vdlCdz2VaS6HXv2EdKKp38qH+zUGKDOU=;
  b=QXZueWMPyZUOkBf+64vBZwbWPtVLPnqYHhktg3D7M7gsh/A1lFopUL4h
   Eo81jmv+0dzLi50xnhRZ+VPsLE2YeX5+QPZUsbvKhqre+EChkEEAiPXcr
   iZc7iNkIKEjworgkg7eeFsn1/Y20vklz7tGzhSiPaWYNaf/w1XXJqdMUj
   ELc8zg1ZWdPXy6sAxxGheHox2BjC54fNbMX38SMtBYQvog4FK+LjjCa8Y
   LdLgR8tkwW4bM1FV8qtcMgRoao020s8aUpmmEcS8ozAd5k2lLEIrV3O/x
   Mgap7yLKDQopf60SA9S/Mr+gdGAjNa2387qaCqv3Gwz7WG32Qtb3acsR2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="364059845"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="364059845"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="834816568"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="834816568"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:58:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:58:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:58:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/MAXBGSKK637xK0YjamxLI6ZcERW0x1GGv081jBLiE/Zd+V5dAau7Zcrqxo25oCGu0rSO4rVPgcvS91oBTuLBWM6Td7N5Sj98H34D64FvhYff6toq/KShIrsqiWqh4DsA8pjKVChHE91oXFBnExiEmmL7aUkYkBsP+foM5TAI/zT9JqN5LcHbZqWzwC+AZdfqGFVuTpdU5VkwLPfEuP1dAMbHyWn3fMhJHfapfv6YT4xK6Uxh3Uf1kWu+ssOnIK7LSCHwOA/oEL/zc7CFp6UvyLfen7ZWjuvzTrmLP+o1GQIC7eDdvQzipkzKSbZYIvFtnN875s7oDtrjR3g9OpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2899Y8v4adOJ188fXuf6id4+6sIWSIfBTmd73ANN9A=;
 b=crNrDDbjPofiBWku2ZmZz3YJYqtJW0QPPk23frvU1hVlwvLesemy/lDgtGkiaL7Crx6Pkryg+S2lCWoDmYTZKANH6v16n5tsrfBVB9NrQgwKtiTLT5ylM62OxyiMa9o2gXTDLK3Zdi+VZV6Gm+hSL3i0wwzjKc5fTKysqeYhikl99vo7sp2Ah5LUJZ5HkXqAOdKK8dxvtVaRmsMc9E1b53SuwBIzJhfh/pW1Yunk0dV4kv46aMI5r7U1Kfp5IlNCW2ed9QmZ/onql63zTVzvGS/Z4cjrIUk7Aj4oSKd72VOR5x5SZXPhrCuD+mQE7V1zvNfnZbh/lk3xX0Oe0gFy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 14 Sep
 2023 16:58:52 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:58:51 +0000
Date: Thu, 14 Sep 2023 18:53:11 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow to use kfunc XDP hints and frags
 together
Message-ID: <ZQM6dy80CMl2AVzJ@lincoln>
References: <20230914083716.57443-1-larysa.zaremba@intel.com>
 <ZQM293Gdx//GQPzA@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQM293Gdx//GQPzA@boxer>
X-ClientProxiedBy: BE1P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::24) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 77133fc6-6e9d-4e84-bbbe-08dbb543df36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0a6ieQNpq8ZrsbZ+gkp30dw0kmVtRoFpQK4FqXF0BQmOjzXyuEnyxlcQ1Pg1qy6lGmwtdDutz9aP+qCpjBII2PI642V8ZkmOJkhqDuB7AeJ7f9HhMnsoTsA1A8bPkh6D+7lkvC3i3c1g0A746IghZeHKa6LXcoyBdn7d8ElB0ZeWkXni3Mq/SHJbPLdu0xT8sqeqDsUx/zEnqKrMdoOGuh+mxGBqN7sN79lx4AhTMqDamnANfVLL8ZmOkCdUJU/7rmJWrs+vMEXGopQxEqedNakyPdw/GXviWf/jfeT2YxBKuhGIPjhA8l3c6jTmw7/N6ZEALOGKa9Ll+Y0FvzXLfX6pOfw+naFWPYvCXJWoDaR3BYLBR1vdMjDv110ABc02T1GTh6+k/ZM39G4xc43IPD7TYBgIpdWheoRsQKBY/HejzvukOp6leN3Xue5enEcDyfQ45DIAqCiRzqS2VuQP1yKoTdOOTyB4keDMvSRaAOil9JNgDc5wJslABvgO2tSJXpdtuEsrWcbxSJKrJMqtUsKd8GkIBFJLENeKcBQbq44=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199024)(186009)(1800799009)(2906002)(7416002)(41300700001)(6636002)(316002)(54906003)(66946007)(66556008)(66476007)(44832011)(5660300002)(4326008)(6862004)(8676002)(8936002)(33716001)(86362001)(6486002)(478600001)(6506007)(966005)(6666004)(83380400001)(9686003)(6512007)(38100700002)(26005)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EA19Eqcav/ynB7en1I7DaCr8Dnet0VuJqCHQD0fd2iqXWbEk9gJJCy+Z9lt6?=
 =?us-ascii?Q?7+DnLCwn77lpiSr9GkXkRljMF383rWSWK1mO84lg4tBWXdLP3hEbP5Wf1r5W?=
 =?us-ascii?Q?qnKUXKLCIJ0HuhaFv3VVxIsslsYVJvulbrOBVSC87NHMh8IqRnLIfRx+Cbg4?=
 =?us-ascii?Q?yICW7WXCCBmOG6AuttPNAREutGkMBj7BgiJxR1orlEvsHc+vCEHnAeENLTBZ?=
 =?us-ascii?Q?RKf5OjeJLRvm2/dtiMop2t9n5fl/tGyy74KZ78h09isqsmdEGHai1qOZWqRy?=
 =?us-ascii?Q?RU+j9+JCyRDXckkgRzdfZCID6+haBNvNCFaQMbhjMQ7z++1nNfwqIahBAMMK?=
 =?us-ascii?Q?BNx/W6Em9UctisCakD9S5dG1FgKhA4K8MbiKwGMzlDOhIvhHq0BAaLMWUSfa?=
 =?us-ascii?Q?Chf+8+GKDhK+q+xToOlwayRKlEl6viddF1VWetgNtpgMiIvSAkdBpTMYfd5C?=
 =?us-ascii?Q?Vd9zsP/ckRhe5TTnlvEJmISJsrsrbB1hRE82vp//L3EudS3/iK4IsgcVBunj?=
 =?us-ascii?Q?3NRD+ueTOHGG0fRYbxQCgeaiFMqqSR8Yebft4CCzPCjMbzRkqyspVjvTJJ/2?=
 =?us-ascii?Q?ngiNDug/qJKH0V/G+LLee+Ursm/mStoYVDp8bBorbiQXoYxL7ePxcwC4/3rc?=
 =?us-ascii?Q?Hgqt+6M5/Ye5JbFdcY+uziAGGqIoYiT4AL3RgecMsdwR3lHXOBnlcNEjm8OZ?=
 =?us-ascii?Q?/snGj6EW0Mw4AOEOtxaWNFFH/Lq/3f/sqHadBKDdKmnKpPXsPHXe/IiASOcA?=
 =?us-ascii?Q?CYfXnsKK5GzZFvBW4R95JlL4lM5OytLfZWaxRRZbhPwHNDWG7mBLbQOT5zeS?=
 =?us-ascii?Q?ULwIo8VkZ6ABe7fvif+Df/6xccASQTrHcQul+7Lec4/1sz4uYteSsG9eEP+q?=
 =?us-ascii?Q?eY2iXpZOJxpfmPcgRpVLkTetca8RYnK+bom1gvVR96/4iL+goqYXGulDSnDr?=
 =?us-ascii?Q?tW0uiwkgHmCFxYus3046KctK4L1A8/nRR6JJ6PVMt80iMj4FLxJHe023SrPA?=
 =?us-ascii?Q?a072HYhSQlvJWu1DT/4eYvc2+bTUWbRh/MuyhtcUxkNbZ68doBSAgqYbtbn4?=
 =?us-ascii?Q?C2ed2K3K1JDD7dx+L3d7NHNKHf3r1L2IN94SkK2YW6JmaYAdBMnQx/89H8s3?=
 =?us-ascii?Q?xxIEPEdXTLFK6Sh2zR6NbDjriSWeaF7dziat3nHIpvwUS3E5Vg5xYqiH9M5Z?=
 =?us-ascii?Q?2UNSFtiDzJ5MIc7ammwxEIVHARONdK8LpHYFxoq6ZEInKeNu3ngUaZjrVDIk?=
 =?us-ascii?Q?6CRaRiI1+4zUNm6NF8eTbQEBQnT5vy73snfwG44DooGks+J6Cwdlgs0MiB2k?=
 =?us-ascii?Q?2bOEmLQwoTkK6aBc1OGmrR7sIEcssuBV7CcWWCOTxb92r4Q1aYhGK4QoBR6K?=
 =?us-ascii?Q?n7k76sLmKuusYdIkjIvmb5OWPb/+mQf7cV41+hsKR2Ev+LMChB5e8HmiMQ1W?=
 =?us-ascii?Q?0k6QrNEu5/bgDAdV8kkmoM0Bs0Zy/X35XJlMwN40e5WhCMwgDtlDZlzkycJT?=
 =?us-ascii?Q?8sKCKo+cP3yJUkN62X6xVe3/jgUzbTHAK4mhggy1R4jPOl32XTShg539XL0Y?=
 =?us-ascii?Q?6pTwCRLs6R8jZav1/c5glM2UrXzJYKNnv5oHF4oOPsVPmUAqAxzBfBzDuphs?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77133fc6-6e9d-4e84-bbbe-08dbb543df36
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:58:51.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFM0jwDwTomYVRkzRreA5xJEY15HeXQgFUnL3RcT4JctEuugEzxe2Jo3D91JCY6rne782yDt/VcZF1nPZcjbyekqCffx1jbo7p4/nK/lGL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 06:38:15PM +0200, Maciej Fijalkowski wrote:
> On Thu, Sep 14, 2023 at 10:37:11AM +0200, Larysa Zaremba wrote:
> > There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> > cannot coexist in a single program.
> > 
> > Allow those features to be used together by modifying the flags conditions.
> > 
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com/
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Though it would be worth spelling out something in the commit msg about
> additional check you're adding (frags flag can't go without dev bound)
>

Ok, I'll add to the commit message the below:

Frags are allowed only if program is dev-bound-only, but not if it is requesting 
bpf offload.

> > ---
> >  kernel/bpf/offload.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index ee35f33a96d1..43aded96c79b 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -232,7 +232,11 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> >  	    attr->prog_type != BPF_PROG_TYPE_XDP)
> >  		return -EINVAL;
> >  
> > -	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> > +	if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
> > +		return -EINVAL;
> > +
> > +	if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
> > +	    !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
> >  		return -EINVAL;
> >  
> >  	if (attr->prog_type == BPF_PROG_TYPE_SCHED_CLS &&
> > -- 
> > 2.41.0
> > 
> > 


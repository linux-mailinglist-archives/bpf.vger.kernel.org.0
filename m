Return-Path: <bpf+bounces-10055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775457A0B0F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151E628215F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268EB23746;
	Thu, 14 Sep 2023 16:55:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1A14F6B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:55:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462812129;
	Thu, 14 Sep 2023 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694710508; x=1726246508;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tK70SRqKM92MqS7mgOlSYDTtQlgcppAt96yOf4AQOJc=;
  b=VimRh0OoA+lUXmElKb9s3EL/GHeurWr7QR/GApvoCoQ6kLYPJfSs+L7v
   i36UAz38HfBIHPhA3M6DSHeOY6k9icKBR1Bxz4Mql8uv29fcBBwS2HTCA
   p6Fo3l9qaD1L7RVLCkrrZEizNwqEMyUdqSvEXXpch04O99TG6wXZzzeNc
   gHrLvtygCz2fgpuZpj2Wo59gWbP3BcnF9EEVx1o4GWCvV+ak8Rb6ZWnmR
   KUQ7AdbWznW1hBjOHb0YnaX4HmBh6ukywCtIDaukjSUs/FzqcoEGwlzAm
   twm6fd+TKWujWVJi4zpChU04LNnsT3evMGmziTRNropFmfXSRcxXIRvM4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359273932"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="359273932"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:55:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="737973405"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="737973405"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:55:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:55:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:55:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZECp3Pxqh2coLDV4Wabb1BsDdt4JPDbecZBaUXjCX6ZvL0bJpHhdX3vX+4T3XKEP9iDW686w3HBrvjVJU78UAHKTmcDFx6xU8ab/PbRH0FWucnxcJl1b5M5W4D4aTY5WQH6Bq+bZxym1ud8Jr29NHprdEHTADqSLDx9EEWaVHQFNlB4eSH0TdSpssvfSZ90OLvUq0l+SFZ5gxaw4b3dxNOTt9W0dctkMAJ6ThU4S1UaQ3e9UJb22G48XIsYNMCfoVwfGAbdox5WaarcuOS3tKUkHe+sZVwUyIUOCqegckQ0MAXT9pzCQww+tt66NU8GIn58ab04vTsTvuNrLJHxYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWYcQ9zeridtZt60V2sB3EnTvPiBCDtxrEoScsA3n9Q=;
 b=e2JJcTPZLCfP+WrwyiQAPCoh9xC78jCFqniH/sdzlPCYtgE+1sqcxz/ioAuiKn4juSUTgHu04wErjxFjaFgJ9AI1y8UGI/B2EBguYzbr0joqKt7C+/qxUzU6OoR93t0Pafy2AXSnhrdeKURAv+DhoGOKfmmQTzh4BbvajX5ADBv7+jVWYZh4BtwUenAk2JE3/A1GJa7m9XDCRxuZ+UC0UijTAcNe4U2inuUu6e8eYEvxRmO6znNhUUShL2vtRWXD2Ms8a6NNV+5RB22xQL6Y3R7cLYKeq27JmbN22R5oShbIcKPoGEIGq7LxrheS42V2IB4Z5sPQlButsn01vjM54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM8PR11MB5589.namprd11.prod.outlook.com (2603:10b6:8:26::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 14 Sep 2023 16:55:05 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:55:05 +0000
Date: Thu, 14 Sep 2023 18:49:22 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow to use kfunc XDP hints and frags
 together
Message-ID: <ZQM5kt8qHKUH0Iob@lincoln>
References: <20230914083716.57443-1-larysa.zaremba@intel.com>
 <ZQM1BUzcZQtXusA3@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQM1BUzcZQtXusA3@google.com>
X-ClientProxiedBy: FR3P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM8PR11MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 7677332c-6aa6-4eb1-a29d-08dbb543583b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K67Pno4IjH8JdOhtfWRnQ0oWvI6KjTSbyTqN3TW/npSd/b3Rg4m9V/60B9wcfH4gDItYfo9RZHs3CyFkAXtJCLG/pTxwMhmHYy7OxaYJyN+Z0ZS1ov/gCV00tPfKTf3jPyU3TQPyC1Uvz/Jqpp4Z1hTvd8djVg9ONW1rk6ecQHL5xdEcWOp4zMYbUkExGAZkp07ED9auhaV+oc4S8hyX5KKk8BgA9p4Irx9f2t2BPT2ZszqNSTyWzsvrtnkZNMbkSJDRMN3/geQx6TVtM+psq10h2n7TBiBf5GNxItsJsC3zdQgFYiQCq4l9G4DVrtbfGfmgQVqPSP0Gn8DwWFFMZJDM4mWFWCVGC10TPFp+pbNsp4Zg9Z2BpLef69nfZuJK6DgcDYR/XwgPOdstbNTnXF++90P0qQJ7eqL0Gn6iQ6Wx8mM0QFwOOKk4IfFdh+6MuK6Mu8nSb6gZqDAbnb3yUtZxuJgzI1e5xwfOwZrRS4xJ1VcmnurdMUQCeAHzH5ayHc5SpDM8KTUCAJt3n38kXw3QGPwn22FFI4XLFJvHXbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(966005)(33716001)(316002)(66946007)(66476007)(66556008)(6916009)(6486002)(26005)(9686003)(6666004)(83380400001)(6506007)(6512007)(38100700002)(82960400001)(86362001)(478600001)(54906003)(2906002)(7416002)(5660300002)(41300700001)(4326008)(44832011)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9hyCL9gOzuxZsm3sc7BXodhsvDSFoJI1NZcFxIJBL/I3/lZ6pniz4e2Eq0r?=
 =?us-ascii?Q?jt0qZNxB/ADhAwqG3OZc2qfCQm23lsu8TyMC/ittmThzc2dDIefblU03lMgK?=
 =?us-ascii?Q?m2Rr+H883Jrt2Asarb2gllLKWZmG2IEGtorezOD9FwQtvlW2+rqAVg/Vamqt?=
 =?us-ascii?Q?0Qisrg0wI9jAZGxjxmSdvPy4xBnhDQpHtVjV766tz630XfJByLG3xwcaTJV0?=
 =?us-ascii?Q?9/V/tkCru/E96w7GYw71RdM/lY49CS7C4zE9gHYNjHqxR6pDFoMS3PIR3MSm?=
 =?us-ascii?Q?/+yGGA1mW+D3LX6ZTSnnspCg+ddlZqo8zCzaTXyu6gOfGLAw3j3o1//oNqJX?=
 =?us-ascii?Q?sFcru+tU5SDwA6e838BpCH/OLZMhssNdqTaPA9a71QgKy1Gza15O5qTEfwPl?=
 =?us-ascii?Q?yNUrwYwWM08i6oDXfna7yctJq+PjdX4vVeNoLouzFu6RQKOGXfIfMXHmMWfx?=
 =?us-ascii?Q?FQGAjvzhzADf5UjJavfugVkf2IlFdO77o9m7cx/0gL8/NOJ2PJnmN5l4a1qp?=
 =?us-ascii?Q?03G3uu9ZjwQxJtaeJEBfFAdgTvw1HrZGrLeALGDlXqTaoK7puw495FYlbL8U?=
 =?us-ascii?Q?/reAfv9GLXifFUbQ6oTgOQP3u1wmzcd42GxYaFtwuHGzAC97NMfHLt/ui4F8?=
 =?us-ascii?Q?SIo3cSC1DLt7lEMzzQy4fpNC2KRvkTYT5HJAlEpy4te0vN6zkpO09KLAIdJX?=
 =?us-ascii?Q?cDnCRiyvWq4RrMX+EGxn+NDgitky1K8JSuTx0H9dMJyGG9pmlznD5IMgCtxq?=
 =?us-ascii?Q?6JcrgyTzJW0IkM1ClPr8gSGfAjfBfbX7i/i+JXEDEIIxJ5VgkUZhwluIGVdI?=
 =?us-ascii?Q?wUI4HkxGsSjUVuTOpFe1s+amW8aNTbbvbraRbcvoGvpkRF1Bv45I09PvBLXf?=
 =?us-ascii?Q?KsSUk2tx9/8tsNSngqqikp+NmOWnL+U5ZulyiZNXiG1NMzpttcVyA7Ag7hNh?=
 =?us-ascii?Q?f7Fm/6NLWz4bsB64224tTF1QcGSsNDqdK/SuLIa3yS/Tej1mQttJarM/DZSg?=
 =?us-ascii?Q?RjSm/HypH3K+mAUQXSGFNCCRtoYwnHvtOIJgWZa7Xb37GnxowgdH2bTsEPoj?=
 =?us-ascii?Q?nNJvsLN9k1aQE2GcMX2cb+J69GHU5NQIhqM11HOcNDe4GUreuPalWQdm1sR7?=
 =?us-ascii?Q?YB1Ftp6kzsd/of1IaOU+/YYgAC52pWIDOmNjcmkLpU34CwXJrnxsyYbPxIgV?=
 =?us-ascii?Q?ekS4E6m6MfjzHuAEss/VRzMCdQguKIUmtxKrA4jU5MAEgD6okbpwxHG6nRfX?=
 =?us-ascii?Q?5ldTma5TEGkYkdb47GjQ8rQB9+tS+za7w1Xpf7eXke4hITmV2ofoIZx/dGEN?=
 =?us-ascii?Q?tVzo2Jbl1MwY8T7jN0I2TCh3OfQtPl5waArmalaisJNHyOHWFJ+3rG857qAR?=
 =?us-ascii?Q?rp9f+L0s359BZhllvT3mLqnTfbKEpAqMVy9NpLJ2DRwnpeD0zPsKQMyoIyh2?=
 =?us-ascii?Q?6DQfLmoPG5OvGXt0tlw4dGt2K04KtwtQtdzsUUuw3zJWR+hIjvX/BVsGPeDE?=
 =?us-ascii?Q?pQYsiq7RVbpxVANBKHPynY0fGzjSo0ahCK75Drwevs2AW9KEe+1vLi3WC2cW?=
 =?us-ascii?Q?Ocv4C1l4t/36d3y4E1UtxiEQuGu/VGGp3212PkZDWEQ7IQA27MhsfIwhRRAT?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7677332c-6aa6-4eb1-a29d-08dbb543583b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:55:05.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guWO39UdH5rTfDqe9OL0EbznCDIRsDRRwk4yuWde9V9bAY4bZhwuClGwPe6+xvGj01Ee6OEKss+cMDGD+1BxUknxgWzwCZ1nQhYD0OD7rOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5589
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 09:29:57AM -0700, Stanislav Fomichev wrote:
> On 09/14, Larysa Zaremba wrote:
> > There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> > cannot coexist in a single program.
> > 
> > Allow those features to be used together by modifying the flags conditions.
> > 
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com/
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
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
> 
> [..]
> 
> > +	if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
> > +	    !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
> >  		return -EINVAL;
> 
> Any reason we have 'attr->prog_flags & BPF_F_XDP_HAS_FRAGS' part here?
> Seems like doing '!(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY)' should
> be enough, right? We only want to bail out here when BPF_F_XDP_DEV_BOUND_ONLY
> is not set and we don't really care whether BPF_F_XDP_HAS_FRAGS is set
> or not at this point.

If !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY) at this point, program could 
be requesting offload.

Now I have thought about those conditions once more and they could be reduced to 
this:

if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY) &&
    attr->prog_flags != (BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
	return -EINVAL;

What do you think?


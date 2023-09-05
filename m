Return-Path: <bpf+bounces-9269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED940792CD3
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C78281227
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA92DDBA;
	Tue,  5 Sep 2023 17:55:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB621D535;
	Tue,  5 Sep 2023 17:55:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A811326;
	Tue,  5 Sep 2023 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693936517; x=1725472517;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GWe4AQ4nzWsXAGTDLSvnioWnwec10jwOepPf96sX5QM=;
  b=TK+k9WIwsWVmcmVX3ZpTLo1GqMgFOJyS9WK5v6x7TufzWHZ9607OSME7
   nOac8vEWpXncWnCS7ZsqjVaySmp1C4jP1UG+OGdEHePcMJBtB+avnWqOd
   qmkR1HcBCjxXIx1JSFLNBxOW+IWQOaH+pgerZyIa+VJl9WpVT3grvlzsQ
   ukrNShgiYh5+D2AHfDZbJQqg86Vv3W62cIxr041yrxAmScHeo9aYw5UBf
   3OtFxGL/MVcj2K4J61fKtGA8FnUqUzOApJpq7P0y66m4hxsj9kZwwI370
   lxfedMEHDwUUHvVnQVoyMzSZmnNXq2+3i5hbq5EJD7Ij2xwmfKgbzx0V1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375760562"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="375760562"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="864830211"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="864830211"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 10:44:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 10:44:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 10:44:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 10:44:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 10:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuUXbTLr1pW6WbPNIdrtd3uShFY9zv7kxm97FHQgdNszga3yxbasM5DI/74cP50iJFCdFHhswtZ2Y48c8RikYnbVZpznBFtW+pwDzsgIU+Lx5pTIy8h7GvCOKxgTLPXD2akpxjpHXlGtsH8hfb0jbi3XPsJMUan7dr2G9TfyMpU9DsE5QtbeboTfmZYMEVyvVZi4FB89mURtc1XvA7oyv8iA87inkCPdT0IkAPB0cuzYlHjTDzxImgwnpHSiOIGTryzYpxPGswikvG+XRqTjfA28c43ue6vyFft3WAxV+8pmLaIbOGdHm9DqREoKaAyHjZam0jw0lYES2TxGdh2mvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFmzOhSPM9uUffWZ7qW8yex9MZxuTAEFynavSGTZqDc=;
 b=B4pmbOp9edjBTSAoqLefV/nI3SgYLWd0lnDuHFaehcsduZFVh2uL/pD9dmPoE6figkNN0x+QdizRP4ZzzhSSz50Rd9pt5IgSvKb7P/OStF0gPotHVk7kumoC7PE/V4Kt2Tw1+MfwtFPGlBxCbxHEPkS/57LeY8tWgANR9IZMMAUFclRkNOzh5xJ8skWc1KlVvnujFhGnZ4Z+VUy5fgFq8oeBiITouEfO/dTKs8K+tS2QnQG6dbax68KWfj7Gqr9yBtE9K/WgJDy0rNqwHXBwLh/HdqvheYb7f6P98okEuUkR4UiSD3WLoAxSDyHV7amtmGMLnQkYn8gKlp/qzx9Q2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7939.namprd11.prod.outlook.com (2603:10b6:610:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 17:44:42 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 17:44:42 +0000
Date: Tue, 5 Sep 2023 19:44:32 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
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
Message-ID: <ZPdpALUo6CveX4Oc@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-4-larysa.zaremba@intel.com>
 <ZPXxkOCK5e4M/P5H@boxer>
 <ZPYbYqnStaChh8BY@lincoln>
 <ZPdLN56BWQVQGKkA@boxer>
 <ZPddEcHOeRrtRcmj@lincoln>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPddEcHOeRrtRcmj@lincoln>
X-ClientProxiedBy: BE1P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 661d1e79-38c9-4c39-45cf-08dbae37c8bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5XGABHpAiR9PAKnb6PyOAPTcESITmpx0pod9P0h5a7oFGYY8gk5HuleS1pWt8cV3ngv8W09rZUjbRG7U4Ti57/LoT3FPgQ80CZQXkpEqUnx9YDCuzM7uNa3kLmwD99SLeKxwesxEoCo111ZFQGseud9LMlXH80tPy5iXad+1ZLZorQmaox3AADyM4KE4tnACJ5nnj4HWumQNeCAxdp1Al/capawlv0bUzbK4gHxodnoyK7xvIP4G40xHWbxIq+e/F3wxKkPRuzcM9wuck4axJGXIr8mPNsm/nLLIkrLU7kLfVWDyfxRdBGFD9gLOHQSHEC1IOBUDA7F73pBGxpK5BfK2wR/v4k6DnvoETkNQ0G58XhWtBszGPY+HopHmedAtWLFqkCPozPKMY0VL83eYwejaoYhY2ZV2Si0k8P4+DVzcbkshx0dWr/l1kFhK3cRFP0eupXoc+7p5V+HKazniuUxj3v7dd9gkHNLy7PJnZc/rQ5195pkWdcnaLiRpEoPnM6JHsqSb5pCbuNCnCAkB5Z3+xRpz5JyW/AcUAanBWVwHDhrBbwRTeJFZxORo2No
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199024)(1800799009)(186009)(478600001)(86362001)(6636002)(66476007)(66556008)(54906003)(2906002)(66946007)(316002)(8936002)(5660300002)(44832011)(6862004)(4326008)(8676002)(9686003)(41300700001)(6512007)(38100700002)(83380400001)(26005)(7416002)(6486002)(33716001)(82960400001)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ouYz9eDWZNkiyIkgR8B8wBMrIRNQaScQOfruYBIQSym1kX8fz7Uy8MVXd2DX?=
 =?us-ascii?Q?HSiazWRXy7E0J9D7hgqLuZ7SGuLx3zBWa6Lhp2VgL7bjJPx+ZDH7Lx+0I/B7?=
 =?us-ascii?Q?RmwCFp7xPeTLxAAHPlZISymdaeVcexrlaKsU6Jd7XZOU0nPRODVKalc/CRPW?=
 =?us-ascii?Q?TvwdDlTXlvhWDC7hOkkE4gvDbHPp9d4cW9Ek5Fgro8fNlh7eQyevNJTRFiJ9?=
 =?us-ascii?Q?Yidk3c8I7UVz8Z/nSleaSnaRWs84PMY3YMlRe32/zg3PzmnUP4F5TTQUYEho?=
 =?us-ascii?Q?lUVkF5q5tKrPeKy2Mtfipr+Lj37urrj7xLMaRjtVI1FGJeV5B7FIsqQHTUsF?=
 =?us-ascii?Q?4n25jRpoXGN0IX+6U7CczBn8zgzPYv+2Iir6+4fuMv4C3qcMvXpkznoeEmPD?=
 =?us-ascii?Q?cOHzxVdkt8SXl/D68f3zkWJGpAs+rNH4S/843Zhp9dQiQpWr4abhFwE7k7bA?=
 =?us-ascii?Q?v50NfCM/3jo8OB7y8m9/FkElKvmKxcDGLXNrnpxqPWFznSwzvujGzVo4lBCl?=
 =?us-ascii?Q?NoHC8CSvheGSOVWKAcXSNK8WpFg70UuwovfvHQ1clE6q9y9zOuB3QPvZfvDC?=
 =?us-ascii?Q?4At3RTRE2Ao+ELZbuqMRQY27Xb9aVtjGsAMivJc8NioInXTmCRMrVeaq1wRD?=
 =?us-ascii?Q?WwJz9tncqLjKARr25QgmhsgqG1k39FWadEoc0i+/2H1/8ID9vixPfXM+/AoJ?=
 =?us-ascii?Q?1xmZfk9iozGb5oXq7FBVSnKX5J0qBZwFfcrx0T2EXxLEj4Jfl7G28JYdyZXr?=
 =?us-ascii?Q?8N3iLVlh4EV6TAE0Lt8dVjZQDsJa1K4qbd8jEVzNVr7hnXr0lcCXfSrMeXxE?=
 =?us-ascii?Q?VUf5wLlToLAa0FF1S1Tw4ZmDMyEfsVTy+NafjCHWfl5KmuYDBlTI6sa+xHUL?=
 =?us-ascii?Q?gxaWGHi0+/s98cZEsE3WB9Enly/JOT5XcE7geEbKZwo6sTDI8IvGozkhlE1w?=
 =?us-ascii?Q?XQf6QjL8QWuz8WkvrIL28kzNqEcHHAXusM9dX2pK8ahlHx4bI7uMgU3mWsR7?=
 =?us-ascii?Q?ajwvR5Gq9yU4AfPsQbU+RcSNT5ZgNrsTtPWGct4Db5SvUM/FbAtcpzvdKd2R?=
 =?us-ascii?Q?emsXkwwPRQDS9r2aGHD5p6pUxUycKrQ2bGAVtAJMf7o93oumFP8OWrQh7ZQs?=
 =?us-ascii?Q?JcdskvDpSFAt3r8gvvphNAVZAg+NiON6hkkYOGApGbnjPL64SOwfgBhDDuUV?=
 =?us-ascii?Q?8yaOGIjHdGli/cJxKuO/mKWgstLEa3jiK+S0+P9UhARb6kPLex+CiGg0X7Nd?=
 =?us-ascii?Q?KDkzqr9UxT0OYG8LsDdVhUN3+nqCr3jZO5hzrETotcWP0htJ9OHK2UBWohtY?=
 =?us-ascii?Q?H1zrDFMR3AqaeXCSHLfXwxCrQ+CmtSu3SjwusAjYY/iqVBm1nlcfepxTjisj?=
 =?us-ascii?Q?WpHcveZ48vanQRumsVJp14tnoEwP/a8ct0xwp5Md+24oA7QzxG5gV7eDFPZg?=
 =?us-ascii?Q?zXXy2BRabN9gT7evYpZ/FWksZG3kLg4sOxMCP4hnDs9y6+mrMJgHMtP8dSsZ?=
 =?us-ascii?Q?8p2rFxrIgbGCd1qBuxntov7SSNSRI/LIZiaBCrk+UV3PwyyTj2TUQdDrTwjO?=
 =?us-ascii?Q?DhK1Qd2hAP4m8XIOI+nZUeY2s/pJLJQ8vgwrJPa7g9vh6/lVNkYjD1eCLg+A?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 661d1e79-38c9-4c39-45cf-08dbae37c8bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 17:44:41.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHebwsKZjqEsy96YtI1xacvSi0xTi4M6kShrz2bDt0b4aLw1lwGt4NDCOY2XOTbPqPiG655/qDjHHPf8U945LuTq7PUuEIg87UFKkTMy51k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7939
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 06:53:37PM +0200, Larysa Zaremba wrote:
> On Tue, Sep 05, 2023 at 05:37:27PM +0200, Maciej Fijalkowski wrote:
> > On Mon, Sep 04, 2023 at 08:01:06PM +0200, Larysa Zaremba wrote:
> > > On Mon, Sep 04, 2023 at 05:02:40PM +0200, Maciej Fijalkowski wrote:
> > > > On Thu, Aug 24, 2023 at 09:26:42PM +0200, Larysa Zaremba wrote:
> > > > > Previously, we only needed RX checksum flags in skb path,
> > > > > hence all related code was written with skb in mind.
> > > > > But with the addition of XDP hints via kfuncs to the ice driver,
> > > > > the same logic will be needed in .xmo_() callbacks.
> > > > > 
> > > > > Put generic process of determining checksum status into
> > > > > a separate function.
> > > > > 
> > > > > Now we cannot operate directly on skb, when deducing
> > > > > checksum status, therefore introduce an intermediate enum for checksum
> > > > > status. Fortunately, in ice, we have only 4 possibilities: checksum
> > > > > validated at level 0, validated at level 1, no checksum, checksum error.
> > > > > Use 3 bits for more convenient conversion.
> > > > > 
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 105 ++++++++++++------
> > > > >  1 file changed, 69 insertions(+), 36 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > index b2f241b73934..8b155a502b3b 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > @@ -102,18 +102,41 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
> > > > >  		skb_set_hash(skb, hash, ice_ptype_to_htype(rx_ptype));
> > > > >  }
> > > > >  
> > > > > +enum ice_rx_csum_status {
> > > > > +	ICE_RX_CSUM_LVL_0	= 0,
> > > > > +	ICE_RX_CSUM_LVL_1	= BIT(0),
> > > > > +	ICE_RX_CSUM_NONE	= BIT(1),
> > > > > +	ICE_RX_CSUM_ERROR	= BIT(2),
> > > > > +	ICE_RX_CSUM_FAIL	= ICE_RX_CSUM_NONE | ICE_RX_CSUM_ERROR,
> > > > > +};
> > > > > +
> > > > >  /**
> > > > > - * ice_rx_csum - Indicate in skb if checksum is good
> > > > > - * @ring: the ring we care about
> > > > > - * @skb: skb currently being received and modified
> > > > > + * ice_rx_csum_lvl - Get checksum level from status
> > > > > + * @status: driver-specific checksum status
> > 
> > nit: describe retval?
> >
> 
> I think that kernel-doc is already too much for a one-liner.
> Also, checksum level is fully explained in sk_buff documentation.
> 
> > > > > + */
> > > > > +static u8 ice_rx_csum_lvl(enum ice_rx_csum_status status)
> > > > > +{
> > > > > +	return status & ICE_RX_CSUM_LVL_1;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * ice_rx_csum_ip_summed - Checksum status from driver-specific to generic
> > > > > + * @status: driver-specific checksum status
> > 
> > ditto
> 
> Same as above. Moreover, there are only 2 possible return values that anyone can 
> easily look up. Describing them here would only balloon the file length.

You really think 5 additional lines would balloon the file length? :D

I am not sure what to say here. We have many pretty pointless kdoc retval
descriptions like 'returns 0 on success, error otherwise' but to me this
is following the guidelines from Documentation/doc-guide/kernel-doc.rst.
If i generate kdoc I don't want to open up the source code to easily look
up retvals.

Just my 0.02$, not a thing that I'd like to keep on arguing on :)

> 
> > 
> > > > > + */
> > > > > +static u8 ice_rx_csum_ip_summed(enum ice_rx_csum_status status)
> > > > > +{
> > > > > +	return status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> > > > 
> > > > 	return !(status & ICE_RX_CSUM_NONE);
> > > > 
> > > > ?
> > > 
> > > status & ICE_RX_CSUM_NONE ? CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
> > > 
> > > is immediately understandable and results in 3 asm operations (I have checked):
> > > 
> > > result = status >> 1;
> > > result ^= 1;
> > > result &= 1;
> > > 
> > > I do not think "!(status & ICE_RX_CSUM_NONE);" could produce less.
> > 
> > oh, nice. Just the fact that branch being added caught my eye.
> > 
> > (...)


Return-Path: <bpf+bounces-14073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974FA7E04C6
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD4C1C210C0
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092714ABA;
	Fri,  3 Nov 2023 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDVuUWgu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CC1A59D;
	Fri,  3 Nov 2023 14:35:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FDED4B;
	Fri,  3 Nov 2023 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699022096; x=1730558096;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5v7IU1nNP+y6RnhmJv6uPNiAVR8uYSISnhRz+KHn3Go=;
  b=hDVuUWgufbldF5AZ04fAGxX5tYT9wgkWG+GTvImrZcWPM/4wPQsPT0LM
   aEh1Ndg2T09EKgjZr3ylm1hs4LoQEP51gIRX+Zw5wGeF4ltcufmu4+dcH
   8ETqKhGL9nflDC2axu8S/vO5q38MY3esMRShC8SL6LkfSLytwYJHl5AKO
   x3f+fOQQ9TwAE1lowKymdlHnGfqGkagHmVO/wPpLCvqD2WDK8aFwDMXbo
   zIaPufjXXz8ajUmvWF6IW1cm+zDzFPuaM17poEdw14EhJ254EgQ5AU5wA
   ihv+Z2SAS34W/Ihs1ayjEGCg6R91AU8NEbB0BhOckflenV+az7BnyI7id
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="386123978"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="386123978"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="796633203"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="796633203"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 07:34:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 07:34:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 07:34:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 07:34:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 07:34:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbvzf3wm0MRiQWVLAZSxtreu+rjlf9oTsB1rOWMvj/TN1L27JFHYY8+qIwI3JEHchS+WX3oRcLkMMDX0CRNfPjYK1wpJ/3uRKnaVtvN93zxFFI+OkimGCVMNXQ+kaYIsRUFBsrdSjOYIZX07RzypBVMTOVyHeYZS/kK1trDm/dMN4bz6ZeSww5O+j+h9bO58KUUqD3890Uc/TkN7/KttBtVBtDnJ4OGmoKc/QFchwoKTlfB8R2pZCOlKpp6oddcaZsyyu1pvtWv0fAdFXcHBdbn+A/WYrs6JZoa1h7dWzDWJ7QeyL/2wygQIzHE9NpeTlF+LXDlpTMM2aCYaagqmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYxeeA+o/57xF5ttYtnPRRwAbUpfPdLx7oYfaYQvs9c=;
 b=mbwZQLVf5mwwSmMau2nABFBHn4bxPx7sHWdpl4+514F4cgfzi8JM/ns4rGSvnMyR/QGIgWAvaZzgZVcVt7cwYvfdVeWn6bbEROj0gMAydEKqmCUSMrGf+6s80U6SiHwkIILw2Cmx5kI0xv3g9MsAzYcAx7GMLqKzkZJUUr8zFgGFcJIS3gsmxgn/hdq+aEkWOEtBe5kpo8IFqqKDKPut7Sk4cmYagSCcsvcRpUkWBwpAsZqEZ3uGycQMC6lazcYeByQEmZpQjyJM23OpRLsQybpXL8AdWs29zWLwJJX29DbdDHT+h9OgBdgej9NEwSvloGtWuDUi70QPxJVeyz4tQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH0PR11MB8233.namprd11.prod.outlook.com (2603:10b6:610:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:34:32 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%6]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 14:34:32 +0000
Date: Fri, 3 Nov 2023 15:34:26 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>, "Magnus
 Karlsson" <magnus.karlsson@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, John Fastabend
	<john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next v2] net, xdp: allow metadata > 32
Message-ID: <ZUUE8lH+EbuRNI16@lzaremba-mobl.ger.corp.intel.com>
References: <20231031175742.21455-1-larysa.zaremba@intel.com>
 <b6da9739-a6e6-4528-a4cd-f87e8e025740@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6da9739-a6e6-4528-a4cd-f87e8e025740@intel.com>
X-ClientProxiedBy: WA2P291CA0033.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::13) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH0PR11MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f82d5b-a8e9-4d5e-deb3-08dbdc79feb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKfuB7YB6jyXFhXdevYc+XesE2g92NodRepc1HxeeNnyWEZf8HGbmc5enDEhzECxqo5R/8STDVYDJouabo4eqQwl94eDX2UNRCCfmSX/jEmW9shW+kSvqFy841rw33LrqQ4OJ2dUuW/nqFmkEwymxhohIJKaTvC72HM9eSkyRNo9cY7L05fa2f+PQ67w6tFDuNtSm6YutOXjW3XOmzzOcHWMZS5LVBQfE3pB5gC7DUt79QRdhs0bEIIAAlAdEaX2B1pgg4F7T9Rq0pJVEYiTqxnxvxYKe6BPlFoDg/qnUzQ/mwjg2+ba4PPrCOOMVKTXqtc7mX2LxHQSrrRZahF2e0w53U1QAO3zHPsGrk+vkf7fuHSz7YK8MUW0fkWCO7l5qMAxlMI80czU/uUwWaNFDFhG4s8Cmt4OYzCfUrwXVMT8GsS8d5u9k69b/M2hcdI6wzRD6lkM44WqJGuKLt0kKNGjkXJo6ixCym7xksHcqNZ19+Wff+Cd+ABbE4haO6aORoOj4Zr3eOjhZFHQAq+X+6SFTDbh1qVYCtcpzr8K1EZuCCgWNSDDPM2va3O8i0LH14ZIwnCmWc+o3jeoUIKbCpkCnRsmchiap7BaSudtSbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(4744005)(44832011)(83380400001)(26005)(7416002)(41300700001)(2906002)(6862004)(6486002)(4326008)(8676002)(8936002)(38100700002)(82960400001)(6506007)(478600001)(66476007)(54906003)(66556008)(316002)(6636002)(86362001)(6666004)(66946007)(6512007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AyNupV06yvELRH6Dfd5fBJaJF7Qus3ciiPA9XzpwNfcT+kjkTXhhCUVROoCE?=
 =?us-ascii?Q?H+0Niz2EaPAtZU5uXGN1hJ7wpgxIasTO7qREBbqEPjbnLK/N9yDk03iuwpWz?=
 =?us-ascii?Q?+7dCxquLSHFUkizpsoCRLvaIOWZZmAWVoLoRir9JCbZFbEYp/7c8ED4Wf1w3?=
 =?us-ascii?Q?tSAfqbFM8ZrmqPXLVxpAgaZcsk9jp/s6Uq2NHt49TmDBBGCAPC27hO+fh456?=
 =?us-ascii?Q?Gy4ndWJaXVPyPr6v7EE4w9EJCNQxy5Opj4rXHx77VSaT4H9yQLPxCsnUVXhd?=
 =?us-ascii?Q?L5gUHRNc5iuDITL3lj7HNWwyfwOX9k4Ay8JfRv6Q7U296MoSjO+7myBTzeut?=
 =?us-ascii?Q?sLIqZG1b1NDzAxqN/NrXtLVmxSo1K9No7R0ckanL1TnIy/iYX8zK4bOWYqfA?=
 =?us-ascii?Q?bSA8nKHS13rcsEPWw0aOA76Y1xD8a8UybG71huvrfJXx1yuKWOKqs2zI2oQp?=
 =?us-ascii?Q?F3tCsr+qVFeDw7i7oCuwso8SIeUFFqGQNN8l3XgVTnSuz8HOwm24qI0TIz2T?=
 =?us-ascii?Q?WGjc5pNp3nMr2wI65E1v7EP1RsR0rQbLmP1fSdghPli454tXGvI1gukIUt3l?=
 =?us-ascii?Q?F0pFIM19iDGw1uboSlVWV+LEGaMRc7Nd8HGHT+0lV51E+eQb7iAvsdEZWmoc?=
 =?us-ascii?Q?muUNKvYT8WhITPcOVRsIGE0upDMT2uLOCd0AMkwu3x8aywdKhIGxYkL05iPX?=
 =?us-ascii?Q?9vRTOnZPnixN/WPiuHFVNspp5oql+R4lZEp1DbSm60bLdZK6EZqen7U58MRv?=
 =?us-ascii?Q?rQvKB6EA1UDGtQ5RurNgZhJG+ejxrlAbXqv0cR2zdR0qZgggFzVY7M8LBC4S?=
 =?us-ascii?Q?ntkkW1u0Qe7B+05Us2EUf7/lYl2+QqJpEs8d+C/U1ZP0NUxUMUjZdJUBq3fQ?=
 =?us-ascii?Q?GE6CmuDrwjgxNlg/HmQwliRJqFgNyTlHUUeWiSwAeDtUOEZLNQa0Wqp8aRL9?=
 =?us-ascii?Q?7gwAFRlpaR12mJCaPZKGZUX27cer9ux57/N0izf5phJ08UW9daF9edCOwVJg?=
 =?us-ascii?Q?51XSNjA2J3FRhRRHWCgEltxJcCH6pxI2JBtp10NF0OrC6oEiNSy8pN+0gMcR?=
 =?us-ascii?Q?+YY9tVSq4gR48tsklPXbdIaj/33MfETvwNCSiW9UbQSaB8J32Fc6/1OZvytQ?=
 =?us-ascii?Q?UlC5CRJ20mVvj9oPo3HCVDOrw+CoFOZwRPEq/B3j3Ql4X1CeP2Hmt7MCmAPN?=
 =?us-ascii?Q?ov98McLH+qbwOFuGrRtlxKZaetG4SrceSgf5Tq8yiW5iHMpa80q5zV+Ub2Wq?=
 =?us-ascii?Q?ifeof4UvFAussy3/JJ1dHmtyTfUdyMZYk3PSTQZqOB6uvvFXHi8X+llMe619?=
 =?us-ascii?Q?mdPRXfl0eguNAOQ525rTaiueBwRvx+pytD+8b04g+s0G+5MxjFrifYJ3Ee/+?=
 =?us-ascii?Q?3R+9vtClBa5fOC87m9/Sh4bg+eWxK9XtYbSv7hIHItX+jxXMNl+EL2EzU1cU?=
 =?us-ascii?Q?UoerdNiFbwumqVCLLWxzjCzi6lKjDJMjPo3fDukV0EaRl3xysUQjBRDKXvw3?=
 =?us-ascii?Q?j1gfcztgx5t5R8SrweyZ/wwRaEE6zKCNfuM174qB+WAWk+VFxj+nTH+HOW5y?=
 =?us-ascii?Q?/saFci1tr68/BSkxrZDlVIRTCOeZBkHw5nypD39sSoGm4fv94CzM/25xHGb9?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f82d5b-a8e9-4d5e-deb3-08dbdc79feb7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:34:32.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lgK0PRc5mCqzAvNa/BKOGZ2hRXJ835ntohGfpSUBhgT2Lemv7eMkySdO+O1vQVekV4iYhXOmtGDmyfo06R2qux84H/QG7YGpGF3OWxs0Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8233
X-OriginatorOrg: intel.com

On Fri, Nov 03, 2023 at 03:03:14PM +0100, Alexander Lobakin wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Date: Tue, 31 Oct 2023 18:57:37 +0100
> 
> It doesn't have "From: Alexa..." here, so that you'll be the author once
> this is applied. Is this intended? ^.^
>

No, I should probably resend.
 
> > 32 bytes may be not enough for some custom metadata. Relax the restriction,
> > allow metadata larger than 32 bytes and make __skb_metadata_differs() work
> > with bigger lengths.
> > 
> > Now size of metadata is only limited by the fact it is stored as u8
> > in skb_shared_info, so the upper limit is now is 255. Other important
> > conditions, such as having enough space for xdp_frame building, are already
> > checked in bpf_xdp_adjust_meta().
> 
> [...]
> 
> Thanks,
> Olek


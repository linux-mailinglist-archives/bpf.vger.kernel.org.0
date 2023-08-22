Return-Path: <bpf+bounces-8284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533D7848A7
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82A51C20B5E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3921CA16;
	Tue, 22 Aug 2023 17:48:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD82B544;
	Tue, 22 Aug 2023 17:48:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04678E75;
	Tue, 22 Aug 2023 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692726503; x=1724262503;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cn0zGu/kypt+u4l3JhY9M5xdJjnjQGeHshLbnFkyc8k=;
  b=aAKFFrmnwLY6p6lFsLW29uf41Foncxy/nkgLfVVG1mjjKZjCagv/hI0Y
   vcy5Fmd/L5542pB5U7tN/PDEwbAEc3Y/2w93JLrphVjpA4oLV3AMIjPIw
   ugISUxCcYJkCyAZX0680TCa2JU+9ZSNXfq1MBKynO3DrroBP0ir0uJtdH
   DUCa6+tEAHVcvz/1JFFYDAcCU8pqOub0gAagBXxITji9x3mwrS+eYmqSb
   sN1CmIIfCim5puyMNT07GIiMsfP0Fd/L1BA5l17OJS9AmlCsHlzOrnloO
   QDPY2m7LE/a0SZ/akXlIuyV39MOeXFqBxFZAtRyS95Pn1pGFjAKUdWqsa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404954963"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="404954963"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 10:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765843959"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="765843959"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2023 10:48:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 10:48:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 10:48:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 10:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtFWDillryI2gyjmiFYGdY0N28ggSCXf2sx0+maewmDLRE78uJucbTigg/V/0YICnDECGq/tfib2IAU6raANBdJ5Jq//J2ApVK/KLJ0QoTkYOHZHm97E4q7yRZ3f+laqQ/7MN9+d8hs9cuXxIzseDGJlTTZyIViABm/tQQcdwSRwRPTYUKwdy1FCtY79i4Zoor/R1B5+0PzOBto6PssanW3XjwTkFbo4KshXI9sR5WJHi45N/+m27EP0n7zjogKzVWIjfvveTsQNxhbXN48itlaDU5xhXkWG9cFehipoB0qIokIsWSxpTxryDpbZ4z5IPQZPkS5MiTcqHuuphJ+D+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6lRtEtA6AI5Wf28nL7kaZCnt+uXYGE0Meb5CzihYDY=;
 b=EwChPB7C5aN7ulnreNmFYG+665SA5RJEzikp6CnpDUFPmLjilDtfvWejFHVyOJXKYcwA4ToycsoWeNQ8zbgo7g3/uA8jgKFZcU6m0GR3aGub/559isAB4iGjaGK4qJBEUc9cjY9ivr/TZrrw5xmSQUT8G7cd4/RWJjGXauxKzQciQL6sgDxmt1Dy58ReIaxZYqDWTgI5Sffl+KXsw93olhZwMR2TgotrK7Qm57ztijnpr1CHN1EKLfe5FOfFR5R8OLoxO6vHuPX2fWIlSAUmPl61ZwcxeaOguGipgP9d2VSM/EQYwW+WfIVnHUv5ko9y6elewVF0CUqUqnzMW81hMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7591.namprd11.prod.outlook.com (2603:10b6:806:32b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 17:48:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 17:48:17 +0000
Date: Tue, 22 Aug 2023 19:48:05 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
CC: Stanislav Fomichev <sdf@google.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: Re: [PATCH bpf-next v2] xsk: fix xsk_build_skb() error: 'skb'
 dereferencing possible ERR_PTR()
Message-ID: <ZOT01et9Sq1WYne1@boxer>
References: <20230815150325.2010460-1-tirthendu.sarkar@intel.com>
 <ZNvB9AUzNIzwMW6+@google.com>
 <SN7PR11MB665573AB14515B617C3D2EA69015A@SN7PR11MB6655.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SN7PR11MB665573AB14515B617C3D2EA69015A@SN7PR11MB6655.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 028d1555-d7f1-46c4-e051-08dba337f798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UETj5iuNMU7nq2J6RSGsf42dQ+s+I7lDVYU42z33m3sL5stmP1HcR2gtwo9FR6k2EtjyX3s+wBbu86WeTAXdyMcJNgQL210tAV5UXH508QgkcT2t07cBUzSG73X5qBZ3LG+1NRVKNn/0W+4T86XFhSDRh82xtGn/GVGlQ+1CEPFRvY96MhsYLOH6C5FiHh1N2B6GucF9+CO++OcIC4AGa7GxAqDQ6tsUpz4bFkkz536p4w1ZrlqCiMqyWgavorhL4lTNM6KDcb97obyywqG4Ucz9O4R48dUaxJZxCKeodlrGYFXV1PjRYZ3h2TjDZxI0iWt0JoQPmSKTdbgbdXFf5DYxfK9c655hlOmMCSUBVn5zHCF1hbGliANZ7db1RegSIiK6jefxiOwkHoFDs/SIF0vVKEMo9dnzHL19qGfsTXvahNPgjV8vK/3D7q1vc/A8IH1GFPih+CnB6jeXWO6902T+IOEB/8wpg3bveskJREqS2Yyk6WEKCr0Fes2wokOuyFVgaIgYxHr5xcEeluop/nrvsoVytT7oAWKfQU18kzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(2906002)(7416002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(6636002)(8936002)(4326008)(6862004)(966005)(316002)(66946007)(6512007)(9686003)(54906003)(66556008)(66476007)(66899024)(82960400001)(478600001)(6666004)(41300700001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KK79b4fyaglRUXLZhM4U3U7wQjviCNhaE4DtTOLasSYfM4kE0rPpNYDlXV0y?=
 =?us-ascii?Q?4FGom1RBIqHrvA7pj5gPwXJDVcP8WI8bhT5Bkwcql3w0rvtj4p2L4zQZ4iqw?=
 =?us-ascii?Q?DttB282/U3w4xnXNPeLIg1zKUSl8DY/3yRdiQkUjZB4vs5vC7bUWy3awzzcU?=
 =?us-ascii?Q?yGJyAjIuooY0xnnYJGWmP+ZEpm3poel2Yqf0h9Yps45XteYglQDsCOSW70+G?=
 =?us-ascii?Q?zRcHC9GtvtX1Zq3j1ctexAXkv7jNGohRL1Crue9edl8hQqGZF6xiR+DDnfe4?=
 =?us-ascii?Q?NhWBPTpI54DJEXmv8ATQnBWr0zlDsedva/sQeTBqNZSL5nESVb/JJG5MiR/W?=
 =?us-ascii?Q?nnfbae6kax3+VDXqfCTkaBM/OIvKTh6d/wY7TJb/fYabioU9PRbIb+s1mabC?=
 =?us-ascii?Q?+ikbQlIzfYc4qNgEq+wBLs/zWiOeoBUKz3fnvHZY2qU2h5euP7+z+qdSPGPs?=
 =?us-ascii?Q?P7UhmjJk877VLr20M77cbV2zZVyiF+lox0Et+64RAjOEK5cj+9zo3CaJ78uM?=
 =?us-ascii?Q?A6big3gv4HVcwYub9eN5KWK9sgVNZFHQlBwSLsUxyCjrHw2Iie4hZ1GwAGZo?=
 =?us-ascii?Q?XImytZbe3Yi6u9abSQT4/uIg4r5qH0N18iapLg5+fTOvcCla8TWIZ4PfY7/o?=
 =?us-ascii?Q?OAI1VYsH/WxIZvUfhkYRQHmmc8LHzswb7vabWat6rhPLFu40jyxFv2FSVMdF?=
 =?us-ascii?Q?/Xpk3nSNnB+8oYb0Xa5U0TCuvF90aTyeR3pCTdouAWO3GlKiTKOlSv0uNmzn?=
 =?us-ascii?Q?gbNRd6mei51ns2ShzTl5hgQ4uIAIPeqSylw+rS+zoddN8T/jLscXhzdgjkSF?=
 =?us-ascii?Q?tNumwa3j7IbJ9+PCwEPTVBeeFLgVSkOI2yNhXfoawNNMkrx67DMOl2OmRpJC?=
 =?us-ascii?Q?+w5eklrjZWM08xGlzt7NKohxmIYVfDWCAh1J5ScF1xn8/JB2iUpWE/qDNV/j?=
 =?us-ascii?Q?es+nxj/uUuxuAmnQbPfRWsCp8I4jWUyI/CYtd4zKfx6Idzb7R2vqbxN4LP+j?=
 =?us-ascii?Q?PaXrb1HE0+YopRCogVt9jAqIYjP5/RaSA+prEx105tQxiP0o72WBPvUf2yWr?=
 =?us-ascii?Q?uM1+/9+tsZ+cRzP6WsbFNdxYQkwFz2aTijpjINeypAJzSnrG3q0xNNLECUps?=
 =?us-ascii?Q?hG3yKCdKFuwRIIrsrEa2tQ15y0b6YEn5LqziRhAMqAjqi70a3CH8RDa/OEQO?=
 =?us-ascii?Q?AlW5UP3/OcneDc2pzsJtG6y+9eqbECACi92APXQ824Vy1JbQtwDROwB07Sqe?=
 =?us-ascii?Q?MeVoR5PSPylRtS6aWNnuWR+3q6ILrdggqGXB2c/eAfa49khwENTBTWgxkCb2?=
 =?us-ascii?Q?HseTMZyQaGZhj2T3CQSUolyIaW4Mp5m3AsNLesh+j1+nixyPaiO7OgGe/DOl?=
 =?us-ascii?Q?WM0Peeea+YB9IUgNq3mO6cUsyOY5NyEM/EQppEJB5YGhOJC8xjSJMk+G+hLq?=
 =?us-ascii?Q?0jYtATCxR06LJBE8fn4d/G2udrXi5nyPknvbHYfgfKkwg4Wofqbbk1HparZn?=
 =?us-ascii?Q?L21TobUab/hnyboBjgRy/EuhfpB5TdGMXx6QYRp7ZpEuByMATtYyFY4wbdIO?=
 =?us-ascii?Q?yI4cAdYVjnLC0a/kC7wxQ+ZY+tQgF3mzo1p0+382MOVy53RYAL7jTyCnwpDK?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 028d1555-d7f1-46c4-e051-08dba337f798
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 17:48:17.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lz8neKySdpv2iYANZTI5LpNk/airDxMQhVoAic9jetIUTIQFUbT+XMLZ4DCKyntmCrY3ZV+YSuNqV7V702wtJRja6rc1V0lXV6KFOCHBFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7591
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 08:04:52AM +0200, Sarkar, Tirthendu wrote:
> > -----Original Message-----
> > From: Stanislav Fomichev <sdf@google.com>
> > Sent: Tuesday, August 15, 2023 11:51 PM
> > On 08/15, Tirthendu Sarkar wrote:
> > > xsk_build_skb_zerocopy() may return an error other than -EAGAIN and
> > this
> > > is received as skb and used later in xsk_set_destructor_arg() and
> > > xsk_drop_skb() which must operate on a valid skb.
> > >
> > > Set -EOVERFLOW as error when MAX_SKB_FRAGS are exceeded and
> > packet needs
> > > to be dropped and use this to distinguish against all other error cases
> > > where allocation needs to be retried.

Please be explicit - say that you're changing this error code
in xsk_build_skb_zerocopy() otherwise it's not clear.

You're not saying anything about kfree_skb() that is added when
skb_store_bits() failed. This code is non-trivial so all of the changes
need to be described.

Also did we test this patch? I believe it would require us to run xdpsock
against virtio net device?

> > >
> > > Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/r/202307210434.OjgqFcbB-lkp@intel.com/
> > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx
> > path")
> > >
> > > Changelog:
> > > 	v1 -> v2:
> > > 	- Removed err as a parameter to xsk_build_skb_zerocopy()
> > > 	[Stanislav Fomichev]
> > > 	- use explicit error to distinguish packet drop vs retry
> > > ---
> > >  net/xdp/xsk.c | 22 +++++++++++++---------
> > >  1 file changed, 13 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index fcfc8472f73d..55f8b9b0e06d 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -602,7 +602,7 @@ static struct sk_buff
> > *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > >
> > >  	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
> > >  		if (unlikely(i >= MAX_SKB_FRAGS))
> > > -			return ERR_PTR(-EFAULT);
> > > +			return ERR_PTR(-EOVERFLOW);
> > >
> > >  		page = pool->umem->pgs[addr >> PAGE_SHIFT];
> > >  		get_page(page);
> > > @@ -655,15 +655,17 @@ static struct sk_buff *xsk_build_skb(struct
> > xdp_sock *xs,
> > >  			skb_put(skb, len);
> > >
> > >  			err = skb_store_bits(skb, 0, buffer, len);
> > > -			if (unlikely(err))
> > > +			if (unlikely(err)) {
> > > +				kfree_skb(skb);
> > >  				goto free_err;
> > > +			}
> > >  		} else {
> > >  			int nr_frags = skb_shinfo(skb)->nr_frags;
> > >  			struct page *page;
> > >  			u8 *vaddr;
> > >
> > >  			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) &&
> > xp_mb_desc(desc))) {
> > > -				err = -EFAULT;
> > > +				err = -EOVERFLOW;
> > >  				goto free_err;
> > >  			}
> > >
> > > @@ -690,12 +692,14 @@ static struct sk_buff *xsk_build_skb(struct
> > xdp_sock *xs,
> > >  	return skb;
> > >
> > >  free_err:
> > > -	if (err == -EAGAIN) {
> > > -		xsk_cq_cancel_locked(xs, 1);
> > > -	} else {
> > > -		xsk_set_destructor_arg(skb);
> > > -		xsk_drop_skb(skb);
> > > +	if (err == -EOVERFLOW) {
> > 
> > Don't think this will work? We have some other error paths in xsk_build_skb
> > that are not -EOVERFLOW that still need kfree_skb, right?
> > 
> 
> There are 4 possible error paths in xsk_build_skb():
> 1. sock_alloc_send_skb:  skb is NULL; retry
> 2. skb_store_bits : free skb and retry
> 3. MAX_SKB_FRAGS exceeded: Free skb, cleanup and drop packet
> 4. alloc_page fails for frag: retry page allocation for frag w/o freeing skb
> 
> Of these 1] and 3] can also happen in xsk_build_skb_zerocopy() and the 
> error returned is either -EOVERFLOW or something else and the same
> error handling needs to be done.

That would be helpful to have it included in commit message.

> 
> > I feel like we are trying to share some state between xsk_build_skb and
> > xsk_build_skb_zerocopy which we really shouldn't share. So how about
> > we try to have a separate cleanup path in xsk_build_skb_zerocopy?
> > 
> 
> The only things that are common between *copy and *zerocopy  paths are 
> setting  the skb headers (destructor/args, mark, priority) and error handling.
> 
> While we can potentially split out the paths into independent functions, the
> same skb header settings and error handling will still need to be duplicated in
> both functions.
> 
> > Will something like the following (untested / uncompiled) work instead?
> > 
> > IOW, ideally, xsk_build_skb should look like:
> > 
> > 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > 		return xsk_build_skb_zerocopy(xs, desc);
> > 	} else {
> > 		return xsk_build_skb_copy(xs, desc);
> > 		/* ^^ current path that should really be a separate func */
> > 	}

IMHO this is way out of the scope for a fix. We can think later on about
cleaning up these paths.

> > 


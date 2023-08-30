Return-Path: <bpf+bounces-9006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE9F78E203
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 00:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DDF1C20818
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 22:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5AE8BF3;
	Wed, 30 Aug 2023 22:01:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD0749B;
	Wed, 30 Aug 2023 22:01:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EB810C8;
	Wed, 30 Aug 2023 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693432872; x=1724968872;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=05fV2nbo/+cH7rUuq5i63nAOWiuva1fan8zkIH6gRko=;
  b=MpX3vN966x6rGbC/AFlHj81RRRdeP1spydwgDWDVhQNrYGwW3qgHOZNg
   C7Pc+m26csf8FmDn7+w1mehSx/5DjlxbnsrxG3xkZ6LBwzp6p6FI4qiaw
   jber37Pw+aXKTmOFldfo1sPdRQe6vbZ018Lop716ION6t0Ew9dFtsC6w9
   F3oLogs9edRKFi+TzfqwJeLLUjtpvkU5qmY065Rt6hAIoea+lj6kbtnui
   eOvk/2oVdC9cW8P4iW4nWunyku3W9c0pJ8YFoaPmRIXrc+msHNzNvVfMp
   yR2zwYxaZ2aQuV0n3UcOOjz8Hp0Hi0AGf3vY9Z5zUsoAhC7sNoAj0KaFR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462135425"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="462135425"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 14:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="853882373"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="853882373"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2023 14:57:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 14:57:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 14:57:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 14:57:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaDGjdTP9RCJmB9n14Vu2uqF8E94MUVsc0fkkbj0aOKojYZqFuZe6NRk+vGvs1it75D3/JCTJV9xexW1by3XyuDdR1mcjCbvAYha3tt3oN7Ok8MkuQtvyDAWVl7XTJkGLOJh2KokbTxsh2B9o+OrofSOK9eyTmENGYF9VA4xCQukeQRMTfkQ5isCe3TUErkk/xf5RTz6BLgj4/UgRkH6gS0ngxfKaJDbAUSC3Rb5gkp4vy2hdyYtLpxpKrTBbkIYgnEby0+bSEWOrYW1xyJOuwH8wbCZ0N3BoSdcPkhvD32dk2/ZjGBrIuB7EW+pRAZxCV7D9owynO2/7mNqeIUVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iaBkReoTb0bKznEbXBNRjdg29jwGr4vjyibsybcLiM=;
 b=kxOldErg6ikmuTiz+CvH+0GcmWQn+hwzV/HJ0boglc7pyO4HFYl3pvBtKNfAIyVbn5VnOVJ9ABlouixSPkl9nJvcO2Oi61GFhpqsEpItqXe6Koqv/zJ8U3O5OO2jhzxi2Zf9XIHDApfr6k/U77tZDxP6OYvWeYg5bk6AUeuoCj9xW2UtHH4Yhw+PyUNu6L3FFLP2igIv6iC5ExPl6d1KtjBY4a/SigIhf4f9NpkiKfNiF4tZP0+YewooFkIfKzoTNNFSKlDy+mCGfUAP+t2BYaAKc5da9LcjFmzsS2HiRdBqauh2atnVm0bWHCPZfU06tVKusZ7VPtb2NQ3HTQ58mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 21:57:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 21:57:34 +0000
Date: Wed, 30 Aug 2023 23:57:22 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <jonathan.lemon@gmail.com>,
	<bpf@vger.kernel.org>,
	<syzbot+822d1359297e2694f873@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf] xsk: fix xsk_diag use-after-free error during socket
 cleanup
Message-ID: <ZO+7QvZRfCuCIO3Q@boxer>
References: <20230830151704.14855-1-magnus.karlsson@gmail.com>
 <ZO92QCe1s7yUiHRR@boxer>
 <CAJ8uoz2SMuwrO_OvrvJyWynfKMYuNNcxwNzt_O=T_=TnY4sA2g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz2SMuwrO_OvrvJyWynfKMYuNNcxwNzt_O=T_=TnY4sA2g@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c06865-5926-41a4-2bb0-08dba9a41dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZg9Z564xwxUzfDayNHSDK08xHZ4ZlydFWdYaF9N1y0+gF9CD5zuOK/kJUdfDa7wgs4iOfRYq3htn4OVoUx/LfpC1mfA4G5Pz6V149UfK28vs4DvJ2OLAt72KYXpMFfM61wr66JpSusgMeGEX8DVoBqGV3P1Cwpx9iYzEabzIOAhiCnTtx4KdqMPWuIZUXUeEyeTKz8+23xAg0pXp2qMQ8uLfrZs77r8zE/7oyvkrkvGI5rkIXBYSPUJryX/NTQs+UfVuui8/DW7pHBuBsmq8soW2LzNhzroosUIkHUFz12YdHH8BFbPrbUFl89ryxKo+yyIxoeU5oemgzReLn1fpvkWsIVJAsoQZ6r/BFmdRcYhhK1pACH4fO8qdspndueW/MTKF7V99wK22nrSPXenNAdl00416r0699k5oY3oKzvSgHrT03Kxb/yrLsOMhicUUVNknibhBpH4/tS3GjCZtMDbaTAifb6z8mEoYyoW/AnXDV5NKM+PHOARyaYNgRWsc63mmWmoCNDRw/fTrf/XqNfvDl2DspoOp5xh1Q6aRWc6yh5/wpH50+lp3TCeBWsRH4vpn3ny9Hzt+P0SnSu0HnQgsYZX3Ahjqu7Wgw2h8OQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(396003)(346002)(1800799009)(186009)(451199024)(478600001)(66476007)(66946007)(66556008)(6916009)(316002)(82960400001)(38100700002)(2906002)(41300700001)(8676002)(8936002)(86362001)(5660300002)(44832011)(4326008)(83380400001)(6512007)(9686003)(6486002)(26005)(6666004)(6506007)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bf8cp6A1Os9FCnSIwDbBeTZtb1RaCyRam171cAfa4+BnHOAaGSFd10f7btbh?=
 =?us-ascii?Q?0k3LTTCjxRSj99KA+LnM3APlFcTspl+vjdiickEc9w3NJ+lnRT5YZj/P6XNj?=
 =?us-ascii?Q?t0Q5qFsfnI0rKpy6BQ37dafDh2owdLjK5TwtaPCCBWE4i9D7DLwJQSol40eL?=
 =?us-ascii?Q?D36qwgcc/nAM8AO5qmg6z2BdxSi8B+HysX1/9ftvGPsrv8n75WdI37U+QleN?=
 =?us-ascii?Q?ehp9sA325AdD5RLqWiBdLA3cpM+GgadntGi5u8ElwMJcVIPItP0pR130srip?=
 =?us-ascii?Q?o5E7lCTOHoMjl0LjaPA1o0eusb+TSdw5eOr2cClA1MI2jI5xrxPBmAvkDpQX?=
 =?us-ascii?Q?zTOVxEbXP0hdg/QYcAhNmLDItsX+i7YjCBzf7uXMFDrTYFI/tnI76nyqkoh3?=
 =?us-ascii?Q?O7bAkdm5fsCun+YiXZhRs1KIYlLvBtb0rzqiyd3CnCA7Z82+FoIyvcZTKJSn?=
 =?us-ascii?Q?xAZrp2lKF0ufmYgg+z/GduSISKUdbY9N5T8n106YcDaXZdWXf7Mbq0z874cL?=
 =?us-ascii?Q?m9pT660GjHCmmY18rBr66hZ2fd2lLKjbk5QlggoSvOh7Gj8CSuI81ml7XENH?=
 =?us-ascii?Q?Ot8dc3SjtaYTlB5SCjrHRpAZ7ujEyyQ68ODLgY6yVTKScs/oI7qC0cgh2IUW?=
 =?us-ascii?Q?Y5mTXyf6SARJ0MJw8sVDsYhagKPiD+toCMlcQ/RBZlYvYx77Cwgm3cw4QAyk?=
 =?us-ascii?Q?Fp5sY47ILXptxzApi1ADOnSGw1prY4P8v5rstxNAIP7ItjN5jlSkCkIr+mEp?=
 =?us-ascii?Q?W6HAFWJR6BA1MNLj40TNC02oI1+4GJmrDY9q2porf0snx3BaukLccE77dY7P?=
 =?us-ascii?Q?UXMh2YPfuyNakxrjShki0NVQwwMoGWrwyAetNEl9RM5dtoxZIfiIONUMAeMS?=
 =?us-ascii?Q?Z9dGzIFLAug9EASgFwxRYF3TPgT48rtn6Iy9pYYPAyRJm7plC7IjgoMccIv2?=
 =?us-ascii?Q?Rf7MrBfRjs1gwtoBx4m3Wp0s/A+KF/sadmrtihQElWMbe/BeV0AOttI2ST6F?=
 =?us-ascii?Q?3wNXfuKae+qDJrWecsGKiSJmZAg0VDEsVYYF/hFTsLq6dPiul4mQAQoimdzT?=
 =?us-ascii?Q?mWpk8Gro/E3DlXVcXuolQjjkbZ0cM5MND7WyrbkoUJfo6NLN4UEIpiwq9uxc?=
 =?us-ascii?Q?qjO70ZkND+yC+BHV8VyZ9hb+8Fr4mjx2BD8fUvkRQN9ZRbH3iB928W9+aaJJ?=
 =?us-ascii?Q?GP+9+KpD7KV+m3zy8Z36VZzNRhguKK/l4OjTzCU2+8OB3GWZx7aU673XO0yR?=
 =?us-ascii?Q?UyFSXPObEKVL8j2X87rYeC6iS4DfRDQ5KoqR9aM3iM5jZ2BjZi8fKtWJf9IG?=
 =?us-ascii?Q?kOgwz21i2mNF40UBTbrURvN0m8pCqVZ0mLzb9nsXQX8g/ShycQnqXob6k1es?=
 =?us-ascii?Q?41AsN6bstOzKQOu0rhk+2/z0gew1Pkx3dHe3TDqUNbf4iIvl8RSyHYU0PW9X?=
 =?us-ascii?Q?ctK/rDDGu/cHtQXybUqD01WN22OKAK8xQ82GXneRodALcdW2Q2jWJCgONCZS?=
 =?us-ascii?Q?qo18So+mpYTlRwEV2tSLGoIWcMAFA11rENG1m2krjhzqvKf3Tj/ROaVgWZu9?=
 =?us-ascii?Q?yy1Tp1AaK8oB9Pk4JXdbJ6jAlLzt3bkc22bmunTmEboyq5APUEm6OFZ6tDol?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c06865-5926-41a4-2bb0-08dba9a41dd0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 21:57:34.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgLzEXeSItTtG9plbJpywJXq5CKRGZCyawypjkGGPdi4fT2k8pOPWRvzAou0dHlHlcpTQN5LhyCJPKpRyQE7DG2gpOg+TtzyR/WGQwfKYXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 08:58:09PM +0200, Magnus Karlsson wrote:
> On Wed, 30 Aug 2023 at 19:03, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 05:17:03PM +0200, Magnus Karlsson wrote:
> > > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > >
> > > Fix a use-after-free error that is possible if the xsk_diag interface
> > > is used at the same time as the socket is being closed. In the early
> >
> > I thought our understanding is: socket is alive, we use diag interface
> > against it but netdev that we bound socket to is being torn down.
> 
> If the socket was not going down at the same time, we would still have
> a reference to the netdevice and it would not disappear. So the socket
> needs to be going down for this to happen.

No, I am able to trigger this now on my local system with KASAN turned on
via:

window 0:
sudo ./xdpsock -i enp24s0f0np0 -r -z -q 17

window 1:
watch -n 0.1 "ss --xdp -e"

window 2:
sudo rmmod ice

we hold the device via dev_get_by_index() in xsk_bind() but dev_put() is
called from xsk_unbind_dev() which can happen either from xsk_release() or
xsk_notifier(), our case refers to the latter.

I don't see currently how ss gets the ifname but after rmmoding ice I am
getting something bogus over there:

Recv-Q Send-Q Local Address:Port Peer Address:PortProcess
0      0               if18:q17              *     ino:18691 sk:2001
        rx(entries:2048)
        umem(id:0,size:16777216,num_pages:4096,chunk_size:4096,headroom:0,ifindex:0,qid:17,zc:1,refs:1)
        fr(entries:4096)
        cr(entries:2048)
        stats(rx dropped:0,rx invalid:0,rx queue full:0,rx fill ring empty:0,tx invalid:0,tx ring empty:0)

'if18' instead 'enp24s0f0np0'. With your patch we bail out early so we
wouldn't have that problem AFAICT.

> >
> > > days of AF_XDP, the way we tested that a socket was not bound or being
> > > closed was to simply check if the netdevice pointer in the xsk socket
> > > structure was NULL. Later, a better system was introduced by having an
> > > explicit state variable in the xsk socket struct. For example, the
> > > state of a socket that is going down is XSK_UNBOUND.
> > >
> > > The commit in the Fixes tag below deleted the old way of signalling
> > > that a socket is going down, setting dev to NULL. This in the belief
> > > that all code using the old way had been exterminated. That was
> > > unfortunately not true as the xsk diagnostics code was still using the
> > > old way and thus does not work as intended when a socket is going
> > > down. Fix this by introducing a test against the state variable. If
> >
> > Again, I believe it was not the socket going down but rather the netdev?
> >
> > > the socket is going down, simply abort the diagnostic's netlink
> > > operation.
> > >
> > > Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
> > > Reported-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
> >
> > Nit: I see syzbot wanted you to include:
> > Reported-and-tested-by: syzbot+822d13...@syzkaller.appspotmail.com
> >
> > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > ---
> > >  net/xdp/xsk_diag.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> > > index c014217f5fa7..da3100bfa1c5 100644
> > > --- a/net/xdp/xsk_diag.c
> > > +++ b/net/xdp/xsk_diag.c
> > > @@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
> > >       sock_diag_save_cookie(sk, msg->xdiag_cookie);
> > >
> > >       mutex_lock(&xs->mutex);
> > > +     if (xs->state == XSK_UNBOUND)
> > > +             goto out_nlmsg_trim;
> >
> > With the above I feel like we can get rid of xs->dev test in
> > xsk_diag_put_info(), no?
> 
> It has to stay since the socket does not get a reference to the device
> until it is bound. It is fine to use the xsk_diag interface on an
> unbound socket to query its state.

Yes good point here.

> 
> > > +
> > >       if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
> > >               goto out_nlmsg_trim;
> > >
> > >
> > > base-commit: 35d2b7ffffc1d9b3dc6c761010aa3338da49165b
> > > --
> > > 2.42.0
> > >


Return-Path: <bpf+bounces-11796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996487BF41C
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 09:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75851C20BC7
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A14D299;
	Tue, 10 Oct 2023 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEVORFf8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947F23D8
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 07:26:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F362711;
	Tue, 10 Oct 2023 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696922709; x=1728458709;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p9HLHs5galXTO+IOSuu2QjJ59DGbX8sF0R3q+wSo4NY=;
  b=VEVORFf8GfcqPdtDaErkkPu9q9qhGZVAIAWEJazd3Fb3k2XKwhzYzgbd
   yjHuIsDgYCIAYCFaqmiqoxzWFyX9eUqdA/kwM4l+uwLtny5Jfmt/M16KA
   TYkUiSJf27DBjv4eZCBLSZ54WeKd9iJA1VH2L/mEl89Lfsg16mzbZJzVD
   mpLKVLY0MZIvKB/XhqGRjTOUyfQewZhjrkKBn/sUCdSx0eGA0cqAfBYmt
   eS9G7/acWprrRLyuLY/XFH3JSx12dC/bK0CPbLPcTPGhZLAY1mgeMpoNQ
   Dn62WOAExD2iaRnpwqdg2Ry8wAMFTGnViZL/JQ1B94DjAEaITtxzuzAYz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374672134"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="374672134"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 00:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="819125180"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="819125180"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 00:25:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 00:24:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 00:24:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 00:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leL5vq6TH34XBDaaHYPkmNaJ3R5GC+NRdTIEDpjaFEUvfFrKg1dEyB9Pu76aOMYlQGeMRnKdA3ZBgZ4klh5lGl2/fjPJWbDt/F9q7aER5jWABrSnHraFXH98OiJ1VK1frkFU6c7FVt4QnLeXmrjHRfv7jvSVlG0xPiFs3Esa8XWQUV2ScuTM+fnghhGXY4XC2M879lfJFx/fM9SHJ8IaumP4WO/b/oFG+QDE8AowjGua/D5+5jUbLirm1Zic8fi1rcjKJHIXBM3AjbxwV5rkoNvXW6Ym347sDo/5XOw0yXhOPdTOq5j2EDMnVPckaJyDFTgXQ3lY+UCXo1pUoE+pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/pFVoJYQJw7a1KoUmuOopXLXmDqOgAmDwPD7MAKcI4=;
 b=f4So5J0RIEnftS0xOH1jptDVvemL6iyaGrgeA2ceIwkPWEz2sDa2c+jK5/c8xS2jMpsAbvKTMJhNjRC/Hkx/R6+MZexX2PkpTPekhv2K8C8D/UZcnEaqIWr9mlFy6pan/2ksfdpfj+D+us3C0rQJfGu6OiEj5rIeZMVuW0uhIi+XYZ/Uc9/3+pXk/cpPXovTDAInlnzTNQWwy1v/3cw8E2gmy8+QeMtjNmeBkbJSJuMAqnJKh2jRPojKzNme90FdZVs3DUeCh5VSIbZgaal/avsdJ/cm70gaN3i32J/HZrk3/k5CrD+3N6eRyEQ+jfZ92djgpavRT0xyfJLD3PDDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 07:24:51 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 07:24:51 +0000
Date: Tue, 10 Oct 2023 09:24:41 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, <linux-kernel@vger.kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add options and frags to
 xdp_hw_metadata
Message-ID: <ZST8OTwh+6y1S170@lzaremba-mobl.ger.corp.intel.com>
References: <20231009160520.20831-1-larysa.zaremba@intel.com>
 <ZSQvMr3-lY9uTzn_@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZSQvMr3-lY9uTzn_@google.com>
X-ClientProxiedBy: WA2P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::26) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a03055-ae9e-40cc-9878-08dbc961fdd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPoHsL6eFmFj7udaHCfXjsChCAsRR5W25LoKVuNF96V46q7pTCGBrw0dtRnWsOI1OzldRpyC2vOLQnWhTeKT2alI6BAb1s1CVGXR7shFYcj3mOfzYNBKBBjazOG57C6GEfgN694eYtV1ucqOuh3WCG3O7nkBA4di1gd1hgtgWfDqoBS4Eib6K1qjJiQu7WrV+Z6kNW5GaJ9KZqBZysVb71dne2LXzE7dE8BmcLMGq9CnbXWPTus/amruaA1Fmkd90v/ESzLqrk3rSvlEXWv3LdqxgOcHBJAQYiSadEOktBy0q6vUKyKmPA1KBkmYvESdgT4yY96puCeVYAzTQpHS9B/afZP0IERmYc+KPwZyUiqoPfa9uFn7oHpdSkPG25Fl66bDFubXrkaWEuWu8HT5bO/v7fmcO/TIZklY1GvwdeyShbKDnpDWRQqCu/DMuaqOYlq/Rpy905zgDo7As6hSIg3dsLCs4l9bWklF+2yd2o6BpHFq3wDghxjf5qUgirRGfqYEhzO7oQ3Y2H7nI7ZGDQInk45Qw6BNeacWgoxZK7npd0nwp1L1PjnFskFpRxQG9TTsF1vhRMmAcTTh1vuybHlRw8VKjYri+XS6Dr+K7BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6506007)(107886003)(6512007)(82960400001)(86362001)(38100700002)(83380400001)(2906002)(6486002)(7416002)(966005)(6666004)(41300700001)(8936002)(478600001)(44832011)(4326008)(8676002)(316002)(26005)(5660300002)(66476007)(6916009)(66556008)(54906003)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bw8lokzZLUA/lOLLSgAx4t585f7CO3PxGT7PNbOSB5MIYXCjHuEhNcE/el3C?=
 =?us-ascii?Q?7/5Fp8b91ZrDp8D70hOPtnD/yLnWh6+K4aBRy/XMeSEUYuuMBWrN1j8e8HQW?=
 =?us-ascii?Q?a5blTZuS1o9aI+OpCCuMRbm+g+VbBvjNMWWylAPTRU+DVqkkd0GxbBuFXe/d?=
 =?us-ascii?Q?GUfrmp0TdXRA5UuoB4L0EKg98QK0SN3LE+YeWJuIbhGbZr+0XGCv9MwQ7kA2?=
 =?us-ascii?Q?/eYXWfI4zHYtRl1By8SNQp7oeDk9jyX05Ne+Azc5cC5q/GphOIsjpBavwPTl?=
 =?us-ascii?Q?hNbf3vu9mJhrgE9Cxy15UJp3nZPNj0RTepgH5xwPohfdop012SoWhasO3Ik3?=
 =?us-ascii?Q?YJDQGhljxhEwgaXKNXdYHmHiIdzj/62wvWbJdFQHqyjHFAyW4wsLuAksVCf7?=
 =?us-ascii?Q?R8h7VgvqW3854f7N6sbCaQYjjH2aH5++80Rwv1l5/lVR2RlZ272ZH4wo+RIA?=
 =?us-ascii?Q?a+O9L5BxDo8qSw4JSvIVPZtnYI6a90xPPz+2JGrHTHP23a3fz7sCm/xrK/ta?=
 =?us-ascii?Q?TJYVb1VYXkRx4M7+KhmaEqCkL3DRFT1pX3jf8OE2R2NzpLkU2lEvl0axsyz+?=
 =?us-ascii?Q?tE8C4QdXH4q+L4CSGOq+DmTsjsQdFw524+hhIaeHAcaG1jDO0Vtd6l0Mxa28?=
 =?us-ascii?Q?FpzAnWupe/ALnOJntX8sZb0f0bZT6xH5ou6kJLM0bb9DcAlL8PJNgVLfjgs8?=
 =?us-ascii?Q?q6SD4PiVRg8BvzbYSqsq5dsE1/cqqd6+IrH3Ap4jxQ6YOjLgnY3jAjLRT5r8?=
 =?us-ascii?Q?Y/+CqD6JyZbV5sm8BDFQ7IZL4iGhhIPX/MEwfcySDa1/P6jDcxQWVRPatWFZ?=
 =?us-ascii?Q?bDZrRU3MdQxgaOMOVsAJCpexvVH2yDS/yMYreXNx0yzvb6o/BsNDQRSFrUB4?=
 =?us-ascii?Q?3Qm9zI36lzDMfS6pZJFQiJNr00ync5Z0kU8ucNog37O+4L9GhvteUk4i+cf+?=
 =?us-ascii?Q?SsyKML2weNnoXx5W5DAyqqUctKbXrnU02TQ+w1lUOpZb6MEuy1xKW3WclsmT?=
 =?us-ascii?Q?dOqHKaGGtkREGj+2c1A2coiueaaYHYOsQpMOtLGnq+cFOFvDbyKXEZTkwfsp?=
 =?us-ascii?Q?pQ+PumwoFvAJb5RCkU64qTlmcUPf09qDeL2uLea0BSllZX0NJdb3hRFqasZJ?=
 =?us-ascii?Q?Y36EqH9MZt8+RNMJcuWO77HepT8KB6QzpgpqOdelIB/Gp8DCvc8BLRk7/suu?=
 =?us-ascii?Q?G9ycdcJvEg6D9DQp+CAHYYzTb/zrJt2bQOvt52usO/zKTeg2z1X3QU9lQPEe?=
 =?us-ascii?Q?gRcdO2WdLF8lTLBMxki5Hzeu40RY2WxbK93eTqQ0LtyED56y0m4HJ1ifA7Ip?=
 =?us-ascii?Q?aG8z9wCos4swi73reVNIcMeAWRhsIENd8SMFOUKaOgc5q+W4n4WHGDSEqs+g?=
 =?us-ascii?Q?QTnWu+5cIBK4rTvwLJFkPUlWlilvYlyVEfY9d+t4HqGahRCb1KCl8qPk8jov?=
 =?us-ascii?Q?MksaAFfW4mLvjjjA9/AYkm9eBZ5BzBzBPMAzG9JWhrOBk/URbcQsZPJRtT+E?=
 =?us-ascii?Q?+WUOWt6/qEc3Svha+9izFhqbOzqpuOKbXCtgHyBZ8cN+HJQEsJ8uUAuCGL4F?=
 =?us-ascii?Q?JqzFIao7Wu/qNzcJGpZaMzR1NwFYbU+MSl8KSrkVGrRSRK7E9bExTr4t8Gxn?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a03055-ae9e-40cc-9878-08dbc961fdd9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 07:24:51.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjXwsq5jyuHdJm/sM0Rtj/8T89+Qalkx//zqM/tnY7AtnsmpntlL/dxp1jZaRln+Rg2YE2Y6E4ifGPzlkmUt2YsAcBlveuYXy5q6SKtXlOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 09:49:54AM -0700, Stanislav Fomichev wrote:
> On 10/09, Larysa Zaremba wrote:
> > This is a follow-up to the commit 9b2b86332a9b ("bpf: Allow to use kfunc
> > XDP hints and frags together").
> > 
> > The are some possible implementations problems that may arise when
> > providing metadata specifically for multi-buffer packets, therefore there
> > must be a possibility to test such option separately.
> > 
> > Add an option to use multi-buffer AF_XDP xdp_hw_metadata and mark used XDP
> > program as capable to use frags.
> > 
> > As for now, xdp_hw_metadata accepts no options, so add simple option
> > parsing logic and a help message.
> > 
> > For quick reference, also add an ingress packet generation command to the
> > help message. The command comes from [0].
> > 
> > Example of output for multi-buffer packet:
> > 
> > xsk_ring_cons__peek: 1
> > 0xead018: rx_desc[15]->addr=10000000000f000 addr=f100 comp_addr=f000
> > rx_hash: 0x5789FCBB with RSS type:0x29
> > rx_timestamp:  1696856851535324697 (sec:1696856851.5353)
> > XDP RX-time:   1696856843158256391 (sec:1696856843.1583)
> > 	delta sec:-8.3771 (-8377068.306 usec)
> > AF_XDP time:   1696856843158413078 (sec:1696856843.1584)
> > 	delta sec:0.0002 (156.687 usec)
> > 0xead018: complete idx=23 addr=f000
> > xsk_ring_cons__peek: 1
> > 0xead018: rx_desc[16]->addr=100000000008000 addr=8100 comp_addr=8000
> > 0xead018: complete idx=24 addr=8000
> > xsk_ring_cons__peek: 1
> > 0xead018: rx_desc[17]->addr=100000000009000 addr=9100 comp_addr=9000 EoP
> > 0xead018: complete idx=25 addr=9000
> > 
> > Metadata is printed for the first packet only.
> > 
> > [0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  .../selftests/bpf/progs/xdp_hw_metadata.c     |  2 +-
> >  tools/testing/selftests/bpf/xdp_hw_metadata.c | 92 ++++++++++++++++---
> >  2 files changed, 79 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > index 63d7de6c6bbb..8767d919c881 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > @@ -21,7 +21,7 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> >  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
> >  				    enum xdp_rss_hash_type *rss_type) __ksym;
> >  
> > -SEC("xdp")
> > +SEC("xdp.frags")
> >  int rx(struct xdp_md *ctx)
> >  {
> >  	void *data, *data_meta, *data_end;
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > index 17c980138796..25225720346b 100644
> > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/sockios.h>
> >  #include <sys/mman.h>
> >  #include <net/if.h>
> > +#include <ctype.h>
> >  #include <poll.h>
> >  #include <time.h>
> >  
> > @@ -49,19 +50,29 @@ struct xsk {
> >  struct xdp_hw_metadata *bpf_obj;
> >  struct xsk *rx_xsk;
> >  const char *ifname;
> > +bool use_frags;
> >  int ifindex;
> >  int rxq;
> >  
> >  void test__fail(void) { /* for network_helpers.c */ }
> >  
> > -static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> > +static struct xsk_socket_config gen_socket_config(void)
> >  {
> > -	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> > -	const struct xsk_socket_config socket_config = {
> > +	struct xsk_socket_config socket_config = {
> >  		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> >  		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> >  		.bind_flags = XDP_COPY,
> >  	};
> > +
> > +	if (use_frags)
> > +		socket_config.bind_flags |= XDP_USE_SG;
> > +	return socket_config;
> > +}
> 
> nit: why not drop const from socket_config and add this 'if (use_frags)'
> directly to open_xsk? Not sure separate function really buys us anything?
>

Considering there will also be ZC/copy option, I thought it would be good to 
separate socket config creation. After giving this a sencond thought though, 
for now options would control bind_flags only. What do you this about removing 
gen_socket_config(), but introducing get_bind_flags()?
 
> > +static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> > +{
> > +	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> > +	struct xsk_socket_config socket_config = gen_socket_config();
> >  	const struct xsk_umem_config umem_config = {
> >  		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> >  		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
> > @@ -263,11 +274,14 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
> >  			verify_skb_metadata(server_fd);
> >  
> >  		for (i = 0; i < rxq; i++) {
> > +			bool first_seg = true;
> > +			bool is_eop = true;
> > +
> >  			if (fds[i].revents == 0)
> >  				continue;
> >  
> >  			struct xsk *xsk = &rx_xsk[i];
> > -
> > +peek:
> >  			ret = xsk_ring_cons__peek(&xsk->rx, 1, &idx);
> >  			printf("xsk_ring_cons__peek: %d\n", ret);
> >  			if (ret != 1)
> > @@ -276,12 +290,19 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
> >  			rx_desc = xsk_ring_cons__rx_desc(&xsk->rx, idx);
> >  			comp_addr = xsk_umem__extract_addr(rx_desc->addr);
> >  			addr = xsk_umem__add_offset_to_addr(rx_desc->addr);
> > -			printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx\n",
> > -			       xsk, idx, rx_desc->addr, addr, comp_addr);
> > -			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
> > -					    clock_id);
> > +			is_eop = !(rx_desc->options & XDP_PKT_CONTD);
> > +			printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx%s\n",
> > +			       xsk, idx, rx_desc->addr, addr, comp_addr, is_eop ? " EoP" : "");
> > +			if (first_seg) {
> > +				verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
> > +						    clock_id);
> > +				first_seg = false;
> > +			}
> > +
> >  			xsk_ring_cons__release(&xsk->rx, 1);
> >  			refill_rx(xsk, comp_addr);
> > +			if (!is_eop)
> > +				goto peek;
> >  		}
> >  	}
> >  
> > @@ -404,6 +425,54 @@ static void timestamping_enable(int fd, int val)
> >  		error(1, errno, "setsockopt(SO_TIMESTAMPING)");
> >  }
> >  
> > +static void print_usage(void)
> > +{
> > +	const char *usage =
> > +		"  Usage: xdp_hw_metadata [OPTIONS] [IFNAME]\n"
> > +		"  Options:\n"
> > +		"  -m            Enable multi-buffer XDP for larger MTU\n"
> > +		"  -h            Display this help and exit\n\n"
> > +		"  Generate test packets on the other machine with:\n"
> > +		"    echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
> 
> nit: any reason we have two spaces in the help description? I don't
> think it's a standard practice, so maybe drop them?

I have just copied usage from xskxceiver. As I see, this is not a standard 
practice indeed, will fix.


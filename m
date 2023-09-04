Return-Path: <bpf+bounces-9219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88206791CB5
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 20:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4010328105E
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE58C8F6;
	Mon,  4 Sep 2023 18:19:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6D1C02;
	Mon,  4 Sep 2023 18:19:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740CB13E;
	Mon,  4 Sep 2023 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693851571; x=1725387571;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W0t7XrvBGpw28b25dzo2AKaLZvo9zuYd9S3LtTNI+Gw=;
  b=Xoqr6sLDP5qgLNZbMjwGc/M3xG0kYt/tzVp+qCUri57zgil7DvjzyOZ/
   SFrIbbpbFjXqCva6Hky04Z9RjKocbZTNTx1XgrRThRpZklCYZiSTl07BK
   Oin3UFuA9VHTAt9M4A+VdN0x/n1oMNcXs/dY/oJCvsOnKzoj/9xU6fUpW
   nP7FR1g4xhsmtc+VpQi8tnCDuWkPQ2sS3OcOdfjoPtCijeaGUqbCqR72J
   /2Fl5U2lCHOSNMbnhFKeZSfSAdNpg9n2/hhUQvfgwDceF1Kk8auEMSErc
   sf47Ma21s6yXsHnTFaQrJtGSy2pP9s6FWhTcPDtjt8OlSR/uLBZI5Dt6H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="375534746"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="375534746"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 11:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806336769"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="806336769"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 11:19:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 11:19:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 11:19:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 11:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/4BOCyyQAhC6HkSl80hPSU2yrezoIB1LC9yJ5psWQGZSF+xqG+jfjHdQxI5Rw74pvH1cqMfB+4zSJSITGipQr3i9dJrJYAkAa82TPgC68nWpC9thbDaKS0mO569HkJNbaecEfLs98tfQ3UBtaW2dpEHdcl3osThQ9YPP+bBGQecHdvjItvz9GDdABtfCUZRo4psoNpD8LAAUiUBQX4MkD4rSAgr02rixuGKXzZvnWPzkxd/oI/+YNlhEjSFalACyj60PkGt/Ah1pjesbeWxlp4IldI77SnQR+iajZ+57K973MdlvAqG+YsNkuDafWH5fAvfyrrWP7Kw7HzQxa0DNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap7flgsPWYgW38ydiTvNhXGP1REWZ9EBFFYqF83ZAEs=;
 b=ZEzya3qN4T5pF2WqVdXnsfnbDEWzcuRKSvH9JQC6ceMsNy6mDLhFai8jnIGYeToW2dfEe5zmmaLkHYaL7oXva9qcK19hwbgMziB0AJsR1gjfM1cFeZmL6zDuDl6RtnbZaiSy0e9o+XCPINaG/108E1rKF9ijyyFtW/RyosayxQNNT8A1AkqxlEBaXii8y09owmXoF6z3anDCch/uzH+OR2ElaoWW0jlyen6Q7CHzMhPwV0gMNTzZVIWU5VH3bR+Utvjn+vj+6HgiYaDUxk3ocaq7c9jWNJRdylU+oF0cB1Z8OO4FqHXwt+Y1jy3J9pjUwhDYRraGU5EW/aNaX5oC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 18:19:24 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 18:19:24 +0000
Date: Mon, 4 Sep 2023 20:11:09 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
Subject: Re: [xdp-hints] [RFC bpf-next 05/23] ice: Introduce ice_xdp_buff
Message-ID: <ZPYdve6E467wewgP@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com>
 <ZPX4ftTJiJ+Ibbdd@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPX4ftTJiJ+Ibbdd@boxer>
X-ClientProxiedBy: DB3PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:8:1::27)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec974ee-c5cc-4ce7-c368-08dbad737700
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Irr5sH1Hx2CNBlIbl0mmiI38d0i5HoJ/dv89KfvdZJBr3bmeUoukrKFT/N6DUK//RRxb6aVbq9NEG/RVmEhcpW4PLYCV2q4Gvc8+wsP2RJ5oQc679o5DF6g7mMGWGuoeSgoeDdvWxgRM0PN95G+ZH8p2MpibdJ2arTFUy1bVFhLx1DFh1ywrXPKokDX9Jemvpao4PADPoZUQhqmF5bDQhbqejmaltM5N+oP8YGCksA5+EknxIvE7Yr+TscHK+sM8PXJfDuPmxtcI9n5Yu7NfmJLB6+ohMIzy9Irkdaebyt2DEc++zOQuzuaBIcMLt2xjEt6BhM28VdLxnUH8n7VHo3/Tg3RF+CWSDI2W7HPaUs6i5Bi/mPK+HK4QYZ1Wr2n7GAlrNhjMpx5YS1pbcsNP0W6qEevutWKBGDGwmPBy32wFitquRlhi1I0zqxo2SQrpe3x2SJYkP2c0cKOweBlqvVvakuPoLIzxF/84Up+Jz0NCGsWbHbEw8TW8EKueVoz7SQ+hDp+vcfqc+/1+DDsvwTYFLjYfmw8r7aOZnMqWyXUhdITVoroIr5d0eTSKqSz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(478600001)(6666004)(66556008)(26005)(66476007)(66946007)(6506007)(54906003)(6486002)(9686003)(2906002)(6512007)(33716001)(8936002)(4326008)(6862004)(8676002)(6636002)(316002)(41300700001)(7416002)(86362001)(5660300002)(44832011)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vCjRJ+wO2UznhTizukAIf6iyOxGYiqPoXeg3C4lTWKaRMjPJHD+moSIGDM2J?=
 =?us-ascii?Q?SxFKk0VT/xh2udRMx7QZilUApbVaR/m1q/Q8I9A+ADbOXzu8gqZ5Wa9cgU96?=
 =?us-ascii?Q?v0S3WYkM7vGOKuxTFHstsVdRWSaomndfzeIbo3VK+y4+hhuUbhYRuHlInFWL?=
 =?us-ascii?Q?0ud4ZZ8A+LdE6Le6+9GzujHW/d/UVuLIMcQUy1+uJv7PKJeesdqLUlw+kcwk?=
 =?us-ascii?Q?hsVxr9nUkVCv2ATlnYRqJ6+6267Hbnd0vPoVi9w2Ek5ad2ZY37hB/Ah05reH?=
 =?us-ascii?Q?gWAen++qoXNR93UT+ruiHJDFCKevKH1XwppKuafeGbr9BZ1ykKN4akPDdKIR?=
 =?us-ascii?Q?4AdwvOddtYsP9pXsZ+yC7I0wGyKGKZdn1KsVd/MzgHyquLJH3f2TNQbY89tK?=
 =?us-ascii?Q?ZjNq61nyY+W/GyE0PTkVdHi858c9RT92V2/88H+Kxjw43Eeu0jS6FC7ZQfXI?=
 =?us-ascii?Q?2tqTX61pBBuZQRMfiRL+dfBY8M7Q1/cADVc8BUBATI2WPzl+QaTVrHh6H4TB?=
 =?us-ascii?Q?nmlRUz+Uy6ugMQgFlxPyUKA8c9zavvTz7pnmbyAdn2m/RtWNi/QFLBOCqQJ/?=
 =?us-ascii?Q?/3DGEQv9gQyXTgPDxRpMkLpV/g/imeWiGK67whD8Ygdlm5uoP+antLFKDnPg?=
 =?us-ascii?Q?WYG+G2DPK8fWelVrWDvtmLmehqEWuWPdpQX67VmEGUa7e+bd04ZQRbs2+DTH?=
 =?us-ascii?Q?0Ke4mSRE+Pb7HUI1YSz7vLfqjbLs0PPcwkzJeumkrc/LTjmR07qrNeERwcIu?=
 =?us-ascii?Q?IAXerqWkoGPC9CAKpzHaCu0yNhtWBaFmVP9+oxbJcSfuBHSCi/OPzBFnqyGJ?=
 =?us-ascii?Q?B6PTa+wqGazk5xAFnmnj3jm9lvmdi3+56nVIW79cJGR80pSv/xzHVfcdMomO?=
 =?us-ascii?Q?+puiT3BA6SbVDyVxAU/C3s0K4XGhMdiSfWSDDOOifTiFHsa9iriQhC6Xf2L3?=
 =?us-ascii?Q?ShfqncNQRIxSg++e59HouMUEgtEaMoJiEGS+FSI5GFlNE4ZsiS+nbeTIbwAH?=
 =?us-ascii?Q?sXD9M/SSFQvHfLEjh5/8ju7VTRSo8h6XAfmyBqPauxMswZc4mj6DcaC9V2o9?=
 =?us-ascii?Q?PPKc+UwJ9qKszxzmMTi6dQ505gpF6ThKbLGIoJY5BUpMrw+liiPq0bI/K18V?=
 =?us-ascii?Q?XBQfgQBKU4YKMXeCvSkczOG11sNz4pF4eYBpfkI/jSVWyeb8kQOIoz1iwY2Y?=
 =?us-ascii?Q?HHrL4bxFkkCDC9qN2mrg0Dv9HdKWl6a+o9JeH3NILQCZb7nm5d7AC8gN3qum?=
 =?us-ascii?Q?uBCqbm6YW6fg1dNz7ZrEY2tqkpcUqZ5MPr1g4E+mSOlj3zMu4SJ2C2LTkmWi?=
 =?us-ascii?Q?2UwFBvBnpC8y1PPHgjdNGJrDF9bqEro3OHhkzT4k4+YoAfMEy95NZKi8YPBc?=
 =?us-ascii?Q?uuUu/f15S4jJy2X5hael/gP/lIxKT9nrzv1kEeV4WF6jhc/GRpModzYN0g/U?=
 =?us-ascii?Q?Quv9AeZefO9vjRJmPxNbHuzBuTHvN6fDvIis3DsGCy6Cttnp4B1FkVh82rzO?=
 =?us-ascii?Q?uSZs4zwD4FPEhdtyEkcsdAc244Sg/acd9rJzDbNLZ/wHTCjwYdHNqRmJK8Ts?=
 =?us-ascii?Q?RIubN/BRFMMDZ5rYT31mzfLE6lY8pT9ouCAE24LVw7rJWxaFFSAgEs/7K/YD?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec974ee-c5cc-4ce7-c368-08dbad737700
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 18:19:24.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGipJJ8ycbTaSgYXz5pwZAFEoNJZ+FIx4uUpAYxGl54cnXfpWr4EZafIU0AVBJtLf6lJ86TcULJzT0MTqXGve2qNXxeWF29G9pQ77OcMd/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 05:32:14PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> > In order to use XDP hints via kfuncs we need to put
> > RX descriptor and ring pointers just next to xdp_buff.
> > Same as in hints implementations in other drivers, we achieve
> > this through putting xdp_buff into a child structure.
> 
> Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp_buff
> if i'm reading this right.
>

ice_xdp_buff is a child in terms of inheritance (pointer to ice_xdp_buff could 
replace pointer to xdp_buff, but not in reverse).

> > 
> > Currently, xdp_buff is stored in the ring structure,
> > so replace it with union that includes child structure.
> > This way enough memory is available while existing XDP code
> > remains isolated from hints.
> > 
> > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > 64 bytes (single cache line). To place it at the start of a cache line,
> > move 'next' field from CL1 to CL3, as it isn't used often. This still
> > leaves 128 bits available in CL3 for packet context extensions.
> 
> I believe ice_xdp_buff will be beefed up in later patches, so what is the
> point of moving 'next' ? We won't be able to keep ice_xdp_buff in a single
> CL anyway.
>

It is to at least keep xdp_buff and descriptor pointer (used for every hint) in 
a single CL, other fields are situational.

> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
> >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 ++++++++++++++++---
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
> >  3 files changed, 38 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 40f2f6dabb81..4e6546d9cf85 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
> >   * @xdp_prog: XDP program to run
> >   * @xdp_ring: ring to be used for XDP_TX action
> >   * @rx_buf: Rx buffer to store the XDP action
> > + * @eop_desc: Last descriptor in packet to read metadata from
> >   *
> >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> >   */
> >  static void
> >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > -	    struct ice_rx_buf *rx_buf)
> > +	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> >  {
> >  	unsigned int ret = ICE_XDP_PASS;
> >  	u32 act;
> > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >  	if (!xdp_prog)
> >  		goto exit;
> >  
> > +	ice_xdp_meta_set_desc(xdp, eop_desc);
> 
> I am currently not sure if for multi-buffer case HW repeats all the
> necessary info within each descriptor for every frag? IOW shouldn't you be
> using the ice_rx_ring::first_desc?
> 
> Would be good to test hints for mbuf case for sure.
>

In the skb path, we take metadata from the last descriptor only, so this should 
be fine. Really worth testing with mbuf though.

> > +
> >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> >  	switch (act) {
> >  	case XDP_PASS:
> > @@ -1240,7 +1243,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> >  		if (ice_is_non_eop(rx_ring, rx_desc))
> >  			continue;
> >  
> > -		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
> > +		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
> >  		if (rx_buf->act == ICE_XDP_PASS)
> >  			goto construct_skb;
> >  		total_rx_bytes += xdp_get_buff_len(xdp);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > index 166413fc33f4..d0ab2c4c0c91 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > @@ -257,6 +257,18 @@ enum ice_rx_dtype {
> >  	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
> >  };
> >  
> > +struct ice_pkt_ctx {
> > +	const union ice_32b_rx_flex_desc *eop_desc;
> > +};
> > +
> > +struct ice_xdp_buff {
> > +	struct xdp_buff xdp_buff;
> > +	struct ice_pkt_ctx pkt_ctx;
> > +};
> > +
> > +/* Required for compatibility with xdp_buffs from xsk_pool */
> > +static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);
> > +
> >  /* indices into GLINT_ITR registers */
> >  #define ICE_RX_ITR	ICE_IDX_ITR0
> >  #define ICE_TX_ITR	ICE_IDX_ITR1
> > @@ -298,7 +310,6 @@ enum ice_dynamic_itr {
> >  /* descriptor ring, associated with a VSI */
> >  struct ice_rx_ring {
> >  	/* CL1 - 1st cacheline starts here */
> > -	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
> >  	void *desc;			/* Descriptor ring memory */
> >  	struct device *dev;		/* Used for DMA mapping */
> >  	struct net_device *netdev;	/* netdev ring maps to */
> > @@ -310,12 +321,19 @@ struct ice_rx_ring {
> >  	u16 count;			/* Number of descriptors */
> >  	u16 reg_idx;			/* HW register index of the ring */
> >  	u16 next_to_alloc;
> > -	/* CL2 - 2nd cacheline starts here */
> > +
> >  	union {
> >  		struct ice_rx_buf *rx_buf;
> >  		struct xdp_buff **xdp_buf;
> >  	};
> > -	struct xdp_buff xdp;
> > +	/* CL2 - 2nd cacheline starts here */
> > +	union {
> > +		struct ice_xdp_buff xdp_ext;
> > +		struct {
> > +			struct xdp_buff xdp;
> > +			struct ice_pkt_ctx pkt_ctx;
> > +		};
> > +	};
> >  	/* CL3 - 3rd cacheline starts here */
> >  	struct bpf_prog *xdp_prog;
> >  	u16 rx_offset;
> > @@ -325,6 +343,8 @@ struct ice_rx_ring {
> >  	u16 next_to_clean;
> >  	u16 first_desc;
> >  
> > +	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
> > +
> >  	/* stats structs */
> >  	struct ice_ring_stats *ring_stats;
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > index e1d49e1235b3..145883eec129 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > @@ -151,4 +151,14 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> >  		       struct sk_buff *skb);
> >  void
> >  ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> > +
> > +static inline void
> > +ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> > +		      union ice_32b_rx_flex_desc *eop_desc)
> > +{
> > +	struct ice_xdp_buff *xdp_ext = container_of(xdp, struct ice_xdp_buff,
> > +						    xdp_buff);
> > +
> > +	xdp_ext->pkt_ctx.eop_desc = eop_desc;
> > +}
> >  #endif /* !_ICE_TXRX_LIB_H_ */
> > -- 
> > 2.41.0
> > 


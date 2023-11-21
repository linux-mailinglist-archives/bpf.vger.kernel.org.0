Return-Path: <bpf+bounces-15512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8B7F284B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 10:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA51281EA2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B930332;
	Tue, 21 Nov 2023 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIlBn3y6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7479BCA;
	Tue, 21 Nov 2023 01:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700557341; x=1732093341;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jn6zcQFYhyvzREP6ASm5COyIL7EdZJjjEWwROlicX+8=;
  b=LIlBn3y6Q8Y8BJjJAejpbFFD0fBCKjmUgzzrFlL1a/xBkOeCvofPkjU8
   nGKdTx4hOdiRcJ+kmvcDxEbnvhJustqb9+AjQnZrdJM+vUBDvZyItHXPF
   zB6WEawYJNpNTMEHK9iJkc6kueKRT4QrkiaCz5fbEHHdWoSYDCzE7l3eh
   vpvEXtKdq4URS8wgWUEhtxx8SmXSrKAWMHSOqnQ7oIs60Es+g5fXnFB1G
   NEj6Ku7TfYmXqITQSBNFvSBXuypolSAwo7P0qKCySJPQC8UIlG4Aov8Hf
   jFK5K7IMuh4DQmAkOrVj7+X8gjNi45Y03Ty0WcQLPTn/QpkWP/CxD6OMT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382191869"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="382191869"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:02:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14842979"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 01:02:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 01:02:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 01:02:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 01:02:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 01:02:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPjC7WevqniR8KJ4W3e0c0DGigWc7QciNjGTiWkE5k6HUrhI8/Zb9c6gHPE55RxRWTMzYosvNCUHh63tneWl7mcFjb9O2NVhmfHYqifQF5eWBQvG61SgFjrl71K0OYLvyf47jZxY4HzEOVBmJFSaD8mPOgd2lodU3L/jxernh090q3Cv4qvYGfko6NSNBEqODEALRjzsPcNY5+JDOGS0J3El/TC9eY1vTzQl4KqSq5EIixY3RqabkbeTpU1NvNzmOJ2sUTJLPPzbRF19vO1VVuZbF4O5gRHuGHmRoL6gpfagNOMQs3N/N6R3bRCFn5S5ow/TLPgzOQ0swSXBBI0v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiF/SRrw5j5u0MpbiNMIfOHpKha6BT6lif+Pev7oOe4=;
 b=LxdNr2ZmSVvf5+yrCrzwnDUhIMOUT83z5/UkJ5qgl+r+wl3z9//OfXNZwiorEl4191XjxpuQOc0Hwr5sQZXz7hhKks/twqFa3GbXLUPlV0D1QOEryFKbt+F05mjte7olxXTRtdtRw5dGeH9Dx14ceOrG8vTPCKotxzIT4Is6n9XTYk8WQRachVMrbvxa7AE09yoIPDXwMeysmCj8xF/uUjbd5ikOdLdyXIk62OU6i8kKwDvHgMp4KWjbRJB5jO892L/TzvXwo45EvYazLN+8SXjSh+Jn5NEvit0z5MXZZT43KXGzg3yiNmf+7n2R38rXh+jjZRVQXNOlWaCy+hqeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 09:02:15 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 09:02:15 +0000
Date: Tue, 21 Nov 2023 10:02:06 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, "Saeed
 Mahameed" <saeedm@mellanox.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v7 17/18] selftests/bpf: Use
 AF_INET for TX in xdp_metadata
Message-ID: <ZVxyDhqz4mBZwIpl@lzaremba-mobl.ger.corp.intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-18-larysa.zaremba@intel.com>
 <170051500599.3770946.2674696540245347885@gauss.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170051500599.3770946.2674696540245347885@gauss.local>
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: ddeb1237-e75c-4fdf-0d7f-08dbea708e5f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDE1wI1xeOC9LPSLzKA7ZQXFRIlbjwdAQrfYskCA4BC0DEdPgnrOjpKDVBDfHX26SabfZacq2iKUTqE97zoVekHxGv1OdP2+CrDPa4fuPUJN7SnSCV6TiMdblabw3OjJlJvR/WFwAE4BpNpnBhC2/K5XKwRa1qNoJoqs07LL45dy+e3IZV0vgpt3491L8/L47cl2s5M5j85nV5PfMI6volWqCu/W/rzUPCsVE/WL2AZcP0HFRQPA8iREvu/g/mGaTMhzaJZhiEZD0POauVRjpSEEWmPWE9dv9mo5MBm9LK85M/ejTPY2Drc1zw+kkEKD3d0uTlfTIY0LVK0itFfQjF95pZ42Vl79KRFFW2X/XNKZYSp6VvuMDFJs6LbeuccIR2QDHyyHsVippyXPTpw+5FgbpDHvOOyXT3pR7a6Lkv7fDw8dJaJACnUU8On6KBuUBPi2bWSZb2lwo22QeWy8M0cOcpHjf/iSmDm004CjyVHqGmt1CFBqL1LRvyT5C9zVrh9VY73NeDizG8klgFsVhRJ1cJWOlk4Iy/pXIDVxlsZjZgzpNU+cRFiutvlZiGiR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(5660300002)(7416002)(44832011)(41300700001)(4326008)(8936002)(8676002)(66946007)(6916009)(66556008)(54906003)(66476007)(316002)(86362001)(26005)(6486002)(107886003)(6512007)(6666004)(6506007)(478600001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKOMeyxZ0dkefDvAN9T7eQv2mZqXH8BOY5me3/UXoXv5Eb8Wugk/60kKwYtR?=
 =?us-ascii?Q?U50D7NJm8VRqeRPksW1CnuT3pq+kWdBCiAEFCnDM3n1L350tI1beTn4zlhjv?=
 =?us-ascii?Q?F0dyAVXCrDHtxvNiKp0bQvJXffimig2XQ2l6s5aiYP48S0pV0jEGND891inh?=
 =?us-ascii?Q?sjTaPlpv8IDaZ0/1n4kh8nGlx7byRp87NDHkln3elMMrW7y/ZNcla04nsgWb?=
 =?us-ascii?Q?QdWnjHKbg2Xys22EKaktS2Fy1P5RBSQfwQqtj7pct6Y9R3/J+ojvMTNvnWTF?=
 =?us-ascii?Q?wIHpYoNLlSDk4AEbfmaZYIq71SkevgCFTDtgS2xEnSTt3AtrFKwhgiAyR1Z+?=
 =?us-ascii?Q?j/F6o8IitGIugH+Pu1JuqNkdta77HP9FhXhJwdqXtKbfmUWQZ4iY3aIwtUx5?=
 =?us-ascii?Q?ngof6O9QNY6wTEM/l3+m5S0p4QQXjsGNqJshXKksS7gYbxxqZbx/yWQ3THsE?=
 =?us-ascii?Q?oIzkVYRx8sWHupa/RuWs7LoOsF4b4svHXQddPUZBgc6oXllUlghu+czyddTD?=
 =?us-ascii?Q?jZa72iobCML7qwu+07Z1d6oWEGTLhcj5IILUFDL21hcN+O280Y0C8/CLsRLm?=
 =?us-ascii?Q?ZIg+wTuDnPcIndum2pI67P9TWE4EgrmU89ONEvaJdd1AsJg26okpR5+VJJrD?=
 =?us-ascii?Q?y8HcZrc8T4EaDKjYceE3crVDLiFfp3J617QPAtfz3aQ797j4MwgJnm5NtpQ+?=
 =?us-ascii?Q?LMf1IGBxlh43f3Inf6Wngbo4/81SP/vsHetchzeWWb5vYcnVei5e0730eCYZ?=
 =?us-ascii?Q?eetxSFz1CrfynoPcZDKUR3uqHIqpJSrt+3Hk9AxlJj/wtvg2QIWMtLO38u2V?=
 =?us-ascii?Q?evzT5mowoHw+iFa74EooPcExvrBwZL6COSrX4TRGsvWY8HoLIJ+8j13r4pEj?=
 =?us-ascii?Q?+EDQI7WGFTpaIQUkbshN+HMkYkbaj/Cgxp4PibHHAsYZRAjc3ifjMiAyArjT?=
 =?us-ascii?Q?KitlftEpc7mhjYlB3Jo1J87hoq+2GA7OUO7TIAWxELvJ8n+UH+mIa3HqbtT5?=
 =?us-ascii?Q?9wjFsZpbA0midXF8uvM59YLDnR5mKDI34qL8l3N1bJtYhprxgI6LxHrMScog?=
 =?us-ascii?Q?Qp3Hai5GswTuflaWiEw0014QpJ0csUO59prCpr4D7JDZOO3MpNTAIdcWLDsQ?=
 =?us-ascii?Q?p7R0mRVQTTp562VtSjJQH7Xgqr+R2Xfg18GhDH/GjVXMa/XB7k+ph9WTFiMK?=
 =?us-ascii?Q?AaIJK2CkrOm6Kl/ilnXeusxuVO+0g7bBp0oFB++8N0m1qrDmQenPV2/X9dPC?=
 =?us-ascii?Q?8NTFAy560agpqd3vNJ3YOSu4RZQv+OzvzfYQNn1Nn18JICyX3rR79NzDeBnB?=
 =?us-ascii?Q?YvojEtiEciTs6QllISM1QMdupQIn/NDNLGs1IC1xEB8Kp9gF8/kdkPPVvTTM?=
 =?us-ascii?Q?2rvdKfg1hdrV37S6aFhOz/a1LMuExwt5Jqna1iqaE2itrC3PXxSQnWfuc74H?=
 =?us-ascii?Q?/404impcH713XTR1rztO/Cwh4V25mVSKZAw2ZpbhZT3nEdovQeuVybOIIzTG?=
 =?us-ascii?Q?0nLhrgW2w5j/edTz71AOModmp8jBxNue1ZZL0kuszt4oAMcLnyQs07xWqGHL?=
 =?us-ascii?Q?NklXAmVd7c0ARloGsRutUTz1U7ZB7V8HXFCCISiGux5lNwMKi+R9ezsn3Pl2?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeb1237-e75c-4fdf-0d7f-08dbea708e5f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:02:14.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDv19jhK+6lFvq02t9qxAsUyia7BPD4qVPMxz7lYAsfNTrfRAQUHo6qJyQu7kiC+wPkw7JXjmfQjefc8VwnyxxJLk084FceIvn8gphZnat8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com

On Mon, Nov 20, 2023 at 01:15:41PM -0800, Stanislav Fomichev via xdp-hints wrote:
> Date: Mon, 20 Nov 2023 13:15:41 -0800
> From: Stanislav Fomichev <sdf@google.com>
> To: Larysa Zaremba <larysa.zaremba@intel.com>
> CC: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
>  andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
>  john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
>  jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski
>  <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Jesper Dangaard
>  Brouer <hawk@kernel.org>, Anatoly Burakov <anatoly.burakov@intel.com>,
>  Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
>  <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
>  xdp-hints@xdp-project.net, netdev@vger.kernel.org, Willem de Bruijn
>  <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
>  <alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, Saeed
>  Mahameed <saeedm@mellanox.com>, Maciej Fijalkowski
>  <maciej.fijalkowski@intel.com>
> Subject: [xdp-hints] Re: [PATCH bpf-next v7 17/18] selftests/bpf: Use
>  AF_INET for TX in xdp_metadata
> 
> On 11/15, Larysa Zaremba wrote:
> > The easiest way to simulate stripped VLAN tag in veth is to send a packet
> > from VLAN interface, attached to veth. Unfortunately, this approach is
> > incompatible with AF_XDP on TX side, because VLAN interfaces do not have
> > such feature.
> > 
> > Replace AF_XDP packet generation with sending the same datagram via
> > AF_INET socket.
> > 
> > This does not change the packet contents or hints values with one notable
> > exception: rx_hash_type, which previously was expected to be 0, now is
> > expected be at least XDP_RSS_TYPE_L4.
> 
> Btw, I've been thinking a bit about how we can make this test work for both
> your VLANs and my upcoming af_xdp tx side. And seems like the best
> way, probably, is to have two tx paths exercised: veth and af_xdp.
> For veth, we'll verify everything+vlans, for af_xdp we'll verify
> everything except the vlans.
> 
> Originally I was assuming that I'll switch this part back to af_xdp, but
> I don't think having tx vlan offload makes sense (because af_xdp
> userspace can just prepare the correct header from the start).
> 
> So if you're doing a respin, maybe see if we can keep af_xdp tx part
> but make it skip the vlans verification?
> 
> generate_packet_af_xdp();
> verify_xsk_metadata(/*verify_vlans=*/false);
> geenrate_packet_veth();
> verify_xsk_metadata(/*verify_vlans=*/true);
> 
> ?

Sounds good to me, will do so.


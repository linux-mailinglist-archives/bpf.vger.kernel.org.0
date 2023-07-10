Return-Path: <bpf+bounces-4611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631974DA95
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB16281342
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D784134BA;
	Mon, 10 Jul 2023 15:54:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B512B78;
	Mon, 10 Jul 2023 15:54:01 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36B31716;
	Mon, 10 Jul 2023 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004423; x=1720540423;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SkRUe3brSnvKyEYzpPkHs0M/aNnM9gg/4c/JFIShIz8=;
  b=TBevtmo6MiB8vaUsPXxYxKGHUWXU3rmrgD+LXnAHlGHDxjKrtZPuX6VK
   lKDsUajMge9J7+fnhC+QXxThrWae6ItDoiQPdfyYUwEdcopaubk6Ce3mr
   zDVch2JmLvdknzf0tN0CRn7BaaYX5nkT91WvKoqf9t7ZM6rmpw3LAU4Ic
   NlOAFj8yyrktL1hmRfMNcCoamuRd02D1MYcKHNqxJdOorVatWVi3WqSwu
   S5dPF+6AF/leUI/xKVuoYAzJ8DDyhpynHOxhIhvjxwpVrIeKvKOLOiUCv
   gzfouh3teSGm4qkG7nF5QFg417/4m27wqxk7lG1MelsSqHDEkXD8zFDGr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361843616"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361843616"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720745077"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720745077"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 08:53:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 08:53:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 08:53:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 08:53:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 08:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1aBvBuV8Lax0W2F8pksgHA5r7LXQBUpXGvjkLvGKQC5VJ8zHAdS1EXOsE4j5zcW619ssFOTcWWAbPQv05VafZDllaPjzCJiNrXshXyIfnpvacBKz/5M/nt94nFf+UKFUSu/Ba3WH3Y9Y/r3IWQm+2auQQkRiP6gUBw4bhNQ904RflBqLhG3wENpL4Vzmz7QGN53LM2pLIXQBztmz+1kXzOwKd2TpA0v31iBQ7ndPwGok8dFjm7Xl2VLE0nnNk83Jr0Ohk93os23+NNlbrF5vX6dJ2l00eFeaJApFDlwtepusdisY9Q0BcyExo7h8E2XsveWrzm745LlZ5R9BmGfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycG9IJkCtGirN8ugknPPWrfwgzmQB/kfrAbRC0N1Yy0=;
 b=Vqt12ojt6lxGQWkEAdXk84u/E3ly/gEUZpd6Exw8qbekIxzRrggB+B85+O7JXVqskmJ0ISLyrizOWOHBPdcycrAeMvs+kfKQKgS+bhpKm4vTOzTP3NirAo6fUchSxpaBKGmwCCYmPykLhImPBcJpdSsAbp33RrVIz39crbLT3ZIGCJQ1DeQXgyRrvXnza7v3eAzzzcYY1uE86jcHehRaBJdS+JC+ujaBp7yBC2zrIqil5Pq9ipdg/8Rx3dZcVNwh/r5e6HZ8Dc3RyWpt7ruI9zH1tZfkwWxSlE6qlwjhVVqr2wMTKQsPMFq5gNUTSm/6PjgpruAgyvnn1CFEXPJ6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 15:53:18 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 15:53:17 +0000
Date: Mon, 10 Jul 2023 17:49:27 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 06/20] ice: Support HW timestamp hint
Message-ID: <ZKwohzanCVIFwrxN@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-7-larysa.zaremba@intel.com>
 <ZKWo0BbpLfkZHbyE@google.com>
 <ZKbOQzj1jtDeaaMp@lincoln>
 <CAKH8qBvrSJF0HppJ9OVF5wRDP-qV6uVfkWBvPR9=-SpRoyvDJQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBvrSJF0HppJ9OVF5wRDP-qV6uVfkWBvPR9=-SpRoyvDJQ@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CO1PR11MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7cca03-fe24-4c86-b4d6-08db815dc54b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTqYmqOgrJfWvnDCHNosUCSLY1Tq+gVfYJLp+0xgKPgd16Rx6lvd5+uB3CvUFBDbw63lwMZUQ2v/d3vj2JSTTIE7cuBJYKcDaF6unDRUtCr6yfVQDABfccfdkyICZAxAfI8wFO+7aEj/tvG++g8kVqUtxcY2llcoXzbB39fZyIYkp/8W5RNTiIS7wo32LGbunbAtIZJR4yQ/Rq8cMRUmz0pNYC/vBiSn1m4szQWzwgPECKvsBNBtq7jIZqLqfH5tAhiNcQjfJ66DnHXGExbX5Hf0LAGY6a5McYInrow7NEb37+PXJ3Xd3NNsWMfFjh1b4qfCTZVbxmr4kHa8RVtAoyAQR/src8N/z3JofFL0VyBRA7McT2cTADCpDbIok3oOq82JPu6QPW99mEY+/UuCnmnmHrYt0tLpGZn4cxtpxFG3ideRTbRWNcINsFU7y1GpGDCWcjLP2cfMwNfO3oh6vH2RTYazkSwZbXFNR3nOLR1MRAa922bcnp8WTh8ZRpNLP9C8zFY5L4BSqSVrlKVu5MiH3a6b9T6CKH17yzt5SzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(6486002)(478600001)(6666004)(54906003)(53546011)(6506007)(26005)(186003)(9686003)(6512007)(966005)(2906002)(33716001)(66946007)(41300700001)(66556008)(316002)(6916009)(4326008)(66476007)(5660300002)(7416002)(44832011)(8676002)(8936002)(38100700002)(82960400001)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJTYUViSmdpcGlaNEI0Y2xRRitObDJ4NVlmOFJnSkZlVmYvSVJSTXIzOStM?=
 =?utf-8?B?VlJBcXhRVmEvTTZqc3p2OU9NYk9FOEorcDNyZkhvdmRJdjJGaGZERCtNWWFv?=
 =?utf-8?B?UURZNzhCcmozTm1uUHU2TW8ya2UyZlpqeThreGFuYjU2SUU0UE5lQ2NkaUtW?=
 =?utf-8?B?RHV2eWVoWFA4TDBIdEMxaU1jNlVoZXpoS3RvMkhPZm5FV0U5bHhyNVFvdDR6?=
 =?utf-8?B?aks0WFlxMFBXNzNWdUJVTE5NK0d3cnQ1eVlaaTFRazFSWUl5VzVLM2NNUEJq?=
 =?utf-8?B?dGNtZDEzWUlwcDNwMjlENUN2aEJveUFqa2t2MjZsdWpweEU4amdVRkY3TllN?=
 =?utf-8?B?YTBmdEs3TnBZazRvZzJIYmdMRWxGVGV1K2JOdlNCZ2k3Vit4a0taaHJEUUdz?=
 =?utf-8?B?Rmo1RkhZQXRoNUtLQkwyTmgvTEhOSlUvTFZIbVV0WnJxK2dKd21lMUYvQmF2?=
 =?utf-8?B?NC9Kb3grbFArZlRNQm9EcS9XbTRvUnA5UVkxeWJia1ZWK3F5bU96dS91WElE?=
 =?utf-8?B?SGVyM3piV3JFQno4WDdyZ3RVTEpLRnlNRWZOc2UrZlV5dGlPcEVqRHZlRDNO?=
 =?utf-8?B?TGZlVlhwR3lubElCZlFIc1ltcDZ1b0xxL0tLZ1dLSFI2aGlmTEg1QTBJdFVx?=
 =?utf-8?B?M0NoblkwN0JOMVBaTzIvYmphbCtNRWw0M2MybXdBWkRLamtvV2k2OHY4MDB4?=
 =?utf-8?B?RVNWYTE1SlZ2ODd0clh0eG15U1l3cjdHQVF2VFQ0NjhmSzk1clU2RlMzWGYv?=
 =?utf-8?B?aHU1UXdEajlwYytwL0h3SFBZNVJtTzlNWXVMSzlHZVV6L2kvWU00V0RhaURN?=
 =?utf-8?B?Vlgyd3BmWlVldXlJYnJ6VC8zZjVlV0N3bVlDL2hMblJNaUhubkJ0L3AzUEV1?=
 =?utf-8?B?K01rdXV3eWlLV2Jobzljck4vMHRsQm5kSHBoTnJYNVJiQVhXSllYUFhyc3Nm?=
 =?utf-8?B?bi83T3gvY29NRFYwZUJUZ2dJeDk3NUhqMTRkZXNKc2llaGlHT1FNNW9HYy9m?=
 =?utf-8?B?ZVAwM3Y3SzZQaWIxWTNncGR3d2h4SERjaVF1a0I3dFNyV0xCd0RUMWxoRHBn?=
 =?utf-8?B?WUFidkg0OHBHOWpwSGEyeTNVTURkVmUrRm1PTU52QjB3S1liaEdjUEpDZE5C?=
 =?utf-8?B?dzFBSllEUTFralhMalRHUCtDbWRpb1dLVHJZR095eVphb1ZXZE1Yc21CaDg2?=
 =?utf-8?B?Z1B5djNKMzQ0SXc0MmdyVUU0aW10NndMdXdZaWI1ekp3V0V3aEhTTkZRVWNG?=
 =?utf-8?B?cDROc2JpVHdXZGZmRVp3d2l2WDY2RkJGTzFWRW92enB0dzhLODVDaCt4cXJq?=
 =?utf-8?B?N2QrZW9oOGJERXlIbFhtNCtzeXE3MTFXTGRFOG1meFJhYVYxZHBWdWlPKzMy?=
 =?utf-8?B?NHErb2pLYktuY3VsSmhWWUJEVytsVUN5ekF3M212MXo5d3BKYUhVSUY0Q0g2?=
 =?utf-8?B?SFF6NTRRQlNFMXpqVnhuY3NoZlZGN2c1V0h1aWZqUVA4ekhORm1kSlZtZ3Fx?=
 =?utf-8?B?VHVzbUVYVHZZbHRCVXAzWHhxUGpmOE9nUVc5VUljRkpEYUJkSjdHalk4elg4?=
 =?utf-8?B?UnU5N3dLRGJzTmx3cU1GaXlxQVdzTERtWDIySVl3NkF2ODByUkR2bUQvOW5G?=
 =?utf-8?B?VmVmTTV5T0U4dnlTVDY1MU5pb2VrWXhabWdvQXhCVHAxSFFjbHNrNGpUcHR0?=
 =?utf-8?B?Q0YxUW5wTHFaWGE2WHdUbW5UMmhoSjRIUzRYM2ZvcllaaGxkWnFGWHlRaGJn?=
 =?utf-8?B?emRqZGxuU3ZOTDJ6MFlNblNEQ3pTMmpOV3dqTENiRUNCMHJ2eTRtc0c0akNE?=
 =?utf-8?B?SmRiZEdWcmM4VHpVMklxQXdpeGdsb3JLRFZVUmsxSFFRZjBnV0hiUWE1d1F4?=
 =?utf-8?B?VVlpZk5ZZ0x3bk9QT3Y4d0FKc3R1VytwOHNNRHhHRUgwU2VYR3NPSk1sQzlk?=
 =?utf-8?B?UFZyYzRlcmx2Y2RzVnlsdlNnYnBSZUEySnRUU3pLeDRWVjkxZy9jR0hVRjhJ?=
 =?utf-8?B?ejl3QmFzRmVNSkxsTnE3dTNTMituMDdaaS9Na2Z6TmRac243dFJOT1JlZnds?=
 =?utf-8?B?NElnVUJka1hTQVRLM2d4NFF4c2JBMEpGQWp5TUYwMFpDOHdzbmJod2hWL01y?=
 =?utf-8?B?YnRBL25HWHpkcGNWTUVwaVdyTE5qZkdVeTZGeXNQdGFBVzNod2hOSm41b2Nq?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7cca03-fe24-4c86-b4d6-08db815dc54b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:53:17.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neXMsEnT/rYTeMQ/nBfjnmLPWltNshRfWqXjyoqL7JNIrrjZjCcdyBxZqLclJk2adtNapAuZlQudjb8Jv35VZNWO6FwnW1fcKIu78kL0KbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4787
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:39:29AM -0700, Stanislav Fomichev wrote:
> On Thu, Jul 6, 2023 at 7:27 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > On Wed, Jul 05, 2023 at 10:30:56AM -0700, Stanislav Fomichev wrote:
> > > On 07/03, Larysa Zaremba wrote:
> > > > Use previously refactored code and create a function
> > > > that allows XDP code to read HW timestamp.
> > > >
> > > > Also, move cached_phctime into packet context, this way this data still
> > > > stays in the ring structure, just at the different address.
> > > >
> > > > HW timestamp is the first supported hint in the driver,
> > > > so also add xdp_metadata_ops.
> > > >
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
> > > >  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
> > > >  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
> > > >  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
> > > >  drivers/net/ethernet/intel/ice/ice_ptp.c      |  2 +-
> > > >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
> > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 24 +++++++++++++++++++
> > > >  7 files changed, 31 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > > > index 4ba3d99439a0..7a973a2229f1 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice.h
> > > > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > > > @@ -943,4 +943,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
> > > >     set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
> > > >     clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> > > >  }
> > > > +
> > > > +extern const struct xdp_metadata_ops ice_xdp_md_ops;
> > > >  #endif /* _ICE_H_ */
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > > index 8d5cbbd0b3d5..3c3b9cbfbcd3 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > > @@ -2837,7 +2837,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
> > > >             /* clone ring and setup updated count */
> > > >             rx_rings[i] = *vsi->rx_rings[i];
> > > >             rx_rings[i].count = new_rx_cnt;
> > > > -           rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
> > > > +           rx_rings[i].pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
> > > >             rx_rings[i].desc = NULL;
> > > >             rx_rings[i].rx_buf = NULL;
> > > >             /* this is to allow wr32 to have something to write to
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > index 00e3afd507a4..eb69b0ac7956 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > @@ -1445,7 +1445,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
> > > >             ring->netdev = vsi->netdev;
> > > >             ring->dev = dev;
> > > >             ring->count = vsi->num_rx_desc;
> > > > -           ring->cached_phctime = pf->ptp.cached_phc_time;
> > > > +           ring->pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
> > > >             WRITE_ONCE(vsi->rx_rings[i], ring);
> > > >     }
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > index 93979ab18bc1..f21996b812ea 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > @@ -3384,6 +3384,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
> > > >
> > > >     netdev->netdev_ops = &ice_netdev_ops;
> > > >     netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
> > > > +   netdev->xdp_metadata_ops = &ice_xdp_md_ops;
> > > >     ice_set_ethtool_ops(netdev);
> > > >
> > > >     if (vsi->type != ICE_VSI_PF)
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > > index a31333972c68..70697e4829dd 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > > @@ -1038,7 +1038,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
> > > >             ice_for_each_rxq(vsi, j) {
> > > >                     if (!vsi->rx_rings[j])
> > > >                             continue;
> > > > -                   WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
> > > > +                   WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_phctime, systime);
> > > >             }
> > > >     }
> > > >     clear_bit(ICE_CFG_BUSY, pf->state);
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > > index d0ab2c4c0c91..4237702a58a9 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > > @@ -259,6 +259,7 @@ enum ice_rx_dtype {
> > > >
> > > >  struct ice_pkt_ctx {
> > > >     const union ice_32b_rx_flex_desc *eop_desc;
> > > > +   u64 cached_phctime;
> > > >  };
> > > >
> > > >  struct ice_xdp_buff {
> > > > @@ -354,7 +355,6 @@ struct ice_rx_ring {
> > > >     struct ice_tx_ring *xdp_ring;
> > > >     struct xsk_buff_pool *xsk_pool;
> > > >     dma_addr_t dma;                 /* physical address of ring */
> > > > -   u64 cached_phctime;
> > > >     u16 rx_buf_len;
> > > >     u8 dcb_tc;                      /* Traffic class of ring */
> > > >     u8 ptp_rx;
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > index beb1c5bb392a..463d9e5cbe05 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > @@ -546,3 +546,27 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
> > > >                     spin_unlock(&xdp_ring->tx_lock);
> > > >     }
> > > >  }
> > > > +
> > > > +/**
> > > > + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> > > > + * @ctx: XDP buff pointer
> > > > + * @ts_ns: destination address
> > > > + *
> > > > + * Copy HW timestamp (if available) to the destination address.
> > > > + */
> > > > +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> > > > +{
> > > > +   const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> > > > +   u64 cached_time;
> > > > +
> > > > +   cached_time = READ_ONCE(xdp_ext->pkt_ctx.cached_phctime);
> > >
> > > I believe we have to have something like the following here:
> > >
> > > if (!ts_ns)
> > >       return -EINVAL;
> > >
> > > IOW, I don't think verifier guarantees that those pointer args are
> > > non-NULL.
> >
> > Oh, that's a shame.
> >
> > > Same for the other ice kfunc you're adding and veth changes.
> > >
> > > Can you also fix it for the existing veth kfuncs? (or lmk if you prefer me
> > > to fix it).
> >
> > I think I can send fixes for RX hash and timestamp in veth separately, before
> > v3 of this patchset, code probably doesn't intersect.
> >
> > But argument checks in kfuncs are a little bit a gray area for me, whether they
> > should be sent to stable tree or not?
> 
> Add a Fixes tag and they will get into the stable trees automatically I believe?

What about declaring XDP hints kfuncs with

BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)

instead of BTF_ID_FLAGS(func, name, 0)
?

I have tested this just now and xdp_metadata passes just fine (so both stack 
and data_meta destination pointers work), but if I replace &timestamp with NULL,
verifier rejects the program with a descriptive message "Possibly NULL pointer 
passed to trusted arg1", so it serves our purpose. I do not see many ways this 
could limit the users, but it definitely benefits driver developers.

The only concern I see is that if we ever decide to allow NULL arguments for 
kfuncs, we'd need to add support for a "_or_null" suffix [0]. But it doesn't 
sound too hard?

I have dug into this, because adding

if (unlikely(!hash || &rss_type))
	return -EINVAL;

or something similar to every .xmo_ handler in existence starts to look ugly.

[0] 
https://lore.kernel.org/lkml/20230120054441.arj5h6yrnh5jsrgr@MacBook-Pro-6.local.dhcp.thefacebook.com/


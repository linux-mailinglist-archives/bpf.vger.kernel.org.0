Return-Path: <bpf+bounces-9430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AB79783B
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA741C20D3C
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DE9134C6;
	Thu,  7 Sep 2023 16:43:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FD15B0;
	Thu,  7 Sep 2023 16:43:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE135B1;
	Thu,  7 Sep 2023 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694105017; x=1725641017;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZMcny39V5izg8VAdGgwrzxxWrHug4jZel/+WuGFpPi0=;
  b=BbRQphYnFLwkX/0wS5J0gRVxOcVD1PXNyhvaC1LTRbM5gjhj1pQHFr+K
   17lYmbhIhlFXW346/KHUB2+p0kpSZIlmn7ZZ7ZylULzYRNQ+9cKAbMeFn
   27yE82HuTBHo6NPmuxfkZAT+bM7swbkD0oQOQuLgoY7unupHTwsJ5nr2P
   DGeXUDfY+Lz+T+zz+j4ynlvhtsFMtZgjPGG3Wzk4EAdEtW3eR/9lOhC/q
   dsz4Hse4f2StsyGbqUst+alSuUMOeX3pUqa5zAQL5j3No+3+v/AXcAI16
   sYV9KuGjwv2ljv0ycN4GlXB4g4PoUbHrf7MdNljFbhwR2nExtSWlqW37l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408404828"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="408404828"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 09:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="742084829"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="742084829"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 09:42:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 09:42:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 09:42:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 09:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSCMu1kBFIN0aj8Nn/G56I4ee5c7Sk7xrTrTyxcgkUb4lOePe57LRjv8+fGM4ulWwcCmqOXw8mvzrJWCpL6pbJN1Y4F3cCZH9SS2f8UwSUU+Y2luDzy3NJpE/0I99rvpW3CpGLd/HmA2RpnefL+XMUz3fjMknDfw5T0qT1WANLAdBc+IiH5O/uDaUxUHA0wGG3hoz9LUsfprXMXvH4VzewQvl0r3+tDZMNWXAawo2a/WrcHOrDEJIBpvK61cH8cQjMnAznG2Hu0x2XoW9P+fgT63HkFMktF1GpqO2lg6xfph7d5aGuWtbBo+aUV/VAS9g5jnb2Dw/FBfffMBEK0cwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSgm/ylTG4qztQOnQVr4u7k9mxhXjpQB9mqHvHhGIHs=;
 b=gcbY0mjwl5wtg4aTpkframqmJtCQCv1jSjLpDdjCIQjJJmUo3xKCJ/u6WqJKLRRiX2WCfD55Z+QsCdgQX8MMT5J2Ia01SO6wZ394MQIqxj8bfSaBkTEINySfw0+ei30PFh8T5sRjHEyzAf1vATI/jHiOzGzWoZnt7vj2EHCf3kCkMWuL4CnjKlDIhWxZbtwHuejzLP0IWKK0wR3/wP+7z56UQ4dqucH1PlpI3ZH7zZI65IRbF0CN5qnrWROGI+rFDOrqLXE97khkuCJwYsHiUV2E96cgYoMAA7cNcDomSolRFIcpJkUob0A+P0MgekJYSBElTLG59y1r2O9y6CrYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Thu, 7 Sep 2023 16:42:42 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 16:42:42 +0000
Date: Thu, 7 Sep 2023 18:42:33 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [xdp-hints] [RFC bpf-next 05/23] ice: Introduce ice_xdp_buff
Message-ID: <ZPn9eRofEv3guPLj@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com>
 <ZPX4ftTJiJ+Ibbdd@boxer>
 <ZPYdve6E467wewgP@lincoln>
 <ZPdq/7oDhwKu8KFF@boxer>
 <ZPncfkACKhPFU0PU@lincoln>
 <CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5e7cca-40df-4a1d-be5c-08dbafc174b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VK/fyoCAIiClLMi/KnHWYW91I6zJzqtGLSBo+FG57tankYc2x+gZ/NB3XzLjIKpSecn+esLxl55WRpyVctWxekHODHjhOWrfZ2AXo87CMgILhYqhvRDZSWtxDuZhqD0N6XAMao+0dXhpB8JGM7Vdn6ErDZoNztv6rtQqm2Ul44iTP51UuW6nWLcTbeVbe5dO79y748p6KLIdxkc889blmCA1VNE2F1gWFRbClaHmHvH1AaylPbmK/hofP7QlnOSoC29GKgC6kXAm95lhjd/nAKZwuWHDGq7f/cXGY1tXVRHZxUIst7z/z6/Bjtg95yQCrvOC1qgWLO6OmnGB+WVOJ6rTzxCq6XeGc7R8ZMVHFpv9dyktMlTpFJ62OOfuXTSSpdMVd8K78Y3UeWHDaufMtpoDPDdGdWPAgFkLofHvJA0M4KbIsVCWPnQ9+xXM6oOd7vHLwomTjrjERLtkJCJxX+/6RADxVNzgfkb8lio77w8xFCLjIIs6ghxr456VB2YRC7970av9LEEg2HifenSBXPVJmDNGLlZ2soS3LHdHeTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(1800799009)(186009)(451199024)(26005)(5660300002)(4326008)(8676002)(8936002)(2906002)(7416002)(83380400001)(86362001)(82960400001)(38100700002)(33716001)(6916009)(6486002)(6506007)(6666004)(66556008)(54906003)(66946007)(66476007)(53546011)(966005)(44832011)(6512007)(478600001)(41300700001)(9686003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhHTGRPSlR2ZnlXOEFjUTh6RW9XUWphem5ydCt1ODZJRndEczR4VVlSU2Rz?=
 =?utf-8?B?K0FXdG8zSytYZVVydzl6bEQ3V2VxS285emR1ZEZZa1czb3RRa0NMRFhBM1E1?=
 =?utf-8?B?T1l2UEY1WXdZTWdQTUtHQkJaUWZBNVRjeDZ6ZlV4cGhyL2Y1d25BbTI4UDZn?=
 =?utf-8?B?RVYzWVhBN1VVenFuRG5UU2M5NWJ0Y3Q4VGx2TW9ldnFaWGhZNnVqb2FZS0ov?=
 =?utf-8?B?MExaVkJKalJ0R2NWQnQ1UTU4SERCa0l3ZUd3WTY2Qy81d1M3VlQrWjR6eUhL?=
 =?utf-8?B?NmN2N2hJckNLQ3krNDZVbkE0NGozaW1JR2VYMW0wVTMwajlLQnA2eVB2WmVO?=
 =?utf-8?B?Nm9aUC9JeXc3cGxLQlRySzExdjgvTC8vWmtRZlVEQlVGYmJ5OVd2T2NVTXRx?=
 =?utf-8?B?NEl3L0QvT1hQbDlMOVdyckh5U0x5dTVVSzgranVtTHE5cmJ6OTJhcE5TZHdN?=
 =?utf-8?B?cHY5RFExdFFRVnBSTU5kNTVzWDM2elF0VkwzNS83QW1OZjAwRmwyc2JDUENP?=
 =?utf-8?B?NW43ZFlCY3RxSVdVaWVybWRRTFpEbDB0cUo5Qmp3SUM1S0orTnorZVBCRlBR?=
 =?utf-8?B?dXEvNnlzSUVxQ1diNndUNGJUZUZ5WnduZzJRdVh0c0RLRERVWFJUS1J5OFRR?=
 =?utf-8?B?YjJPdnpVT1M4UXJySURaYjByYzJPeWtONGVKRkRHS09tdS8wZmNvQUhEdmVi?=
 =?utf-8?B?WlF4Z2NYaWpKajAzaU8rQkVvMHR4TS85bGR2YW96bUR1MDJQUEVWWXAzVVN3?=
 =?utf-8?B?MHpKb29aSnkrdHFIbit0Y0ovSVNIQ0RhRk1yQU9taG53TU5KekdYMUluZlJ2?=
 =?utf-8?B?NENuV29tTm81Y3ljY3dzcDVVM1dlUXdKcU9BcDhTS1A5Z2FVeUNya2M4Y0Yz?=
 =?utf-8?B?ZE9JL2NiUks0dDFiNVNDSFJrU3dkM09JclVodGUrZ1pjN0E3YnJJY05sUnFW?=
 =?utf-8?B?VTBVTUo4eVlaS0VXOW1MUjJQVXE2VDBlNTF6Qnk1TXN6QXp2Sy9pbGdRNzhj?=
 =?utf-8?B?S1hHTlZFNkFXT3JhQmNlYURrbGNGTGVGanNCVzhxL0hDSUtqUElBS0lWdjI5?=
 =?utf-8?B?bnZCRktsNWVSMno1Sm9FRk9DZ0c3SVZGVGFYeGc4dmJ2OHYwcTBPTUVzMzRU?=
 =?utf-8?B?L0NIREdoQVBvckZPTml2WFRDaEpqWXdFeVlqZi94Yjg1a2lCSHUvVnNlZ2E3?=
 =?utf-8?B?V2tRb21DYTVlK2NUY0Nwa2JXK2pFTnBEdkZVaVpraEpVKzFTSm1OOGZPMjla?=
 =?utf-8?B?M2MzeW5GNkxiWWVsUUlxOEQ0WXFkQXhWUzV4dFdEWVVYY2xYWEhrVU9jZzdi?=
 =?utf-8?B?NFJaUXg1Qm5NYzhYUjcrL2x3NGM1Q3dlV0M3WDR0RGViSEtPRWVFTDBkbUU0?=
 =?utf-8?B?WGtZa1ZrWXBjZjljd2ZIUkJkUEtWZVl0bjJybmV3OFZZZkdveGF1Tk8wWWNo?=
 =?utf-8?B?alRHc0lCN2oxcWNPWFhyVzZGZEh6UVJMdEVDSGtqb1VMY0VPdXluM1Y1dFZw?=
 =?utf-8?B?bkQwSG1PemVjQlBsN2Q2eTNpUEkxWWphb1ZDRS9meGRJVHNaK2I3TE0zYmVG?=
 =?utf-8?B?ZTZwalZmSW1KUlN0SjRySVA0bEtEbC8rR0xuUlRvTlVyKytEc3I2WFJGRmQ4?=
 =?utf-8?B?dFFPQXppY2VpQUJVcnpoRndYYnJuSGJGUE5EazFnTmRWZUsvY01JbHc4RzNF?=
 =?utf-8?B?WmoxWEMwYkpNSFliV2dId2VRV29DdXZxSzZtbElLRGVJQXRXUVNrakEvMXdD?=
 =?utf-8?B?VHJJVkhZc1JnNnRZNUhSZkEzTjhWWHhJeHBpNVNrd3VPZ1FoWG40QzNDd0pp?=
 =?utf-8?B?bmdkTmlHZjV1aXU3ODdXRG9TcmRTTy9Vc2w3aGhpSlUvL2prbDI1ZC9iM3ha?=
 =?utf-8?B?NEZnN1JYU3VQNEZLbG9XTUx6UkFmWk9iVkM1SnRYNW1NZGs0UkY5UWh4Nmp4?=
 =?utf-8?B?Wnl6Sk5kdTZJckJvL3M0WEVzSlcxT2NteTY3djZudkRPaHV1UlQ0alNKZUVn?=
 =?utf-8?B?ZHcrN0FTUGVtaFpsN0s0T1ErTEZ5NXNDaXNoaU5NeHRhTjkzRmMrU2p2OGFI?=
 =?utf-8?B?NkZBSjBPZ2RIQzB2dmdLeVBCRUV3YkY0cXh4UVEyMWllSmx3bE9CQjRxcE42?=
 =?utf-8?B?M2xkajFRcU9yUUZtOERJUFlJa3ZkMHBvdlozL3ZQbTZxanBYOEJSa0h0VUhl?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5e7cca-40df-4a1d-be5c-08dbafc174b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 16:42:42.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diCB6Mvd2h5wndUvLE8usGfGAZnohNC3MGfkviy4EZ5yRuJhlMUColCuWv6xuz3N23U2NqviibSb6lSOBS9tIrA8DtDt9dZBNi/r3LS00hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 09:33:14AM -0700, Stanislav Fomichev wrote:
> On Thu, Sep 7, 2023 at 7:27 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > On Tue, Sep 05, 2023 at 07:53:03PM +0200, Maciej Fijalkowski wrote:
> > > On Mon, Sep 04, 2023 at 08:11:09PM +0200, Larysa Zaremba wrote:
> > > > On Mon, Sep 04, 2023 at 05:32:14PM +0200, Maciej Fijalkowski wrote:
> > > > > On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> > > > > > In order to use XDP hints via kfuncs we need to put
> > > > > > RX descriptor and ring pointers just next to xdp_buff.
> > > > > > Same as in hints implementations in other drivers, we achieve
> > > > > > this through putting xdp_buff into a child structure.
> > > > >
> > > > > Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp_buff
> > > > > if i'm reading this right.
> > > > >
> > > >
> > > > ice_xdp_buff is a child in terms of inheritance (pointer to ice_xdp_buff could
> > > > replace pointer to xdp_buff, but not in reverse).
> > > >
> > > > > >
> > > > > > Currently, xdp_buff is stored in the ring structure,
> > > > > > so replace it with union that includes child structure.
> > > > > > This way enough memory is available while existing XDP code
> > > > > > remains isolated from hints.
> > > > > >
> > > > > > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > > > > > 64 bytes (single cache line). To place it at the start of a cache line,
> > > > > > move 'next' field from CL1 to CL3, as it isn't used often. This still
> > > > > > leaves 128 bits available in CL3 for packet context extensions.
> > > > >
> > > > > I believe ice_xdp_buff will be beefed up in later patches, so what is the
> > > > > point of moving 'next' ? We won't be able to keep ice_xdp_buff in a single
> > > > > CL anyway.
> > > > >
> > > >
> > > > It is to at least keep xdp_buff and descriptor pointer (used for every hint) in
> > > > a single CL, other fields are situational.
> > >
> > > Right, something must be moved...still, would be good to see perf
> > > before/after :)
> > >
> > > >
> > > > > >
> > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
> > > > > >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 ++++++++++++++++---
> > > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
> > > > > >  3 files changed, 38 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > index 40f2f6dabb81..4e6546d9cf85 100644
> > > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
> > > > > >   * @xdp_prog: XDP program to run
> > > > > >   * @xdp_ring: ring to be used for XDP_TX action
> > > > > >   * @rx_buf: Rx buffer to store the XDP action
> > > > > > + * @eop_desc: Last descriptor in packet to read metadata from
> > > > > >   *
> > > > > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > > > > >   */
> > > > > >  static void
> > > > > >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > > >             struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > > > > -           struct ice_rx_buf *rx_buf)
> > > > > > +           struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> > > > > >  {
> > > > > >         unsigned int ret = ICE_XDP_PASS;
> > > > > >         u32 act;
> > > > > > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > > >         if (!xdp_prog)
> > > > > >                 goto exit;
> > > > > >
> > > > > > +       ice_xdp_meta_set_desc(xdp, eop_desc);
> > > > >
> > > > > I am currently not sure if for multi-buffer case HW repeats all the
> > > > > necessary info within each descriptor for every frag? IOW shouldn't you be
> > > > > using the ice_rx_ring::first_desc?
> > > > >
> > > > > Would be good to test hints for mbuf case for sure.
> > > > >
> > > >
> > > > In the skb path, we take metadata from the last descriptor only, so this should
> > > > be fine. Really worth testing with mbuf though.
> >
> > I retract my promise to test this with mbuf, as for now hints and mbuf are not
> > supposed to go together [0].
> 
> Hm, I don't think it's intentional. I don't see why mbuf and hints
> can't coexist.

They should coexist, xdp mbuf support is an integral part of driver as we
know:)

> Anything pops into your mind? Otherwise, can change that mask to be
> ~(BPF_F_XDP_DEV_BOUND_ONLY|BPF_F_XDP_HAS_FRAGS) as part of the series
> (or separately, up to you).

+1

> 
> > Making sure they can co-exist peacefully can be a topic for another series.
> > For now I just can just say with high confidence that in case of multi-buffer
> > frames, we do have all the supported metadata in the EoP descriptor.
> >
> > [0] https://elixir.bootlin.com/linux/v6.5.2/source/kernel/bpf/offload.c#L234
> >
> > >
> > > Ok, thanks!
> > >
> 

